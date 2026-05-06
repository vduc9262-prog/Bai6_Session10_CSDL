create database btth;

use btth;

-- thac tac 1 
-- Bảng Patients
CREATE TABLE Patients (
    Patient_ID CHAR(5) PRIMARY KEY,
    Full_Name VARCHAR(100) NOT NULL,
    Admission_Time DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Bảng Vitals_Logs
CREATE TABLE Vitals_Logs (
    Log_ID INT AUTO_INCREMENT PRIMARY KEY,
    Patient_ID CHAR(5),
    Heart_Rate INT CHECK (Heart_Rate > 0),
    Blood_Pressure VARCHAR(20),
    Record_Time DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (Patient_ID) REFERENCES Patients(Patient_ID)
);


-- Thêm dữ liệu vào bảng Patients
INSERT INTO Patients (Patient_ID, Full_Name) VALUES
('BN001', 'Nguyen Van An'),
('BN002', 'Tran Thi Binh'),
('BN003', 'Le Van Cuong'),
('BN004', 'Pham Thi Dung'),
('BN005', 'Hoang Van Em');

-- Thêm dữ liệu vào bảng Vitals_Logs
INSERT INTO Vitals_Logs (Patient_ID, Heart_Rate, Blood_Pressure) VALUES
('BN001', 72, '120/80'),
('BN001', 75, '118/79'),
('BN002', 80, '130/85'),
('BN002', 78, '128/84'),
('BN003', 90, '140/90'),
('BN003', 88, '138/88'),
('BN004', 70, '110/70'),
('BN004', 73, '115/75'),
('BN005', 85, '125/82'),
('BN005', 82, '122/80');


-- thac tac 2 
create index idx_patient_id_record_time
on Vitals_logs (Patient_ID,Record_time);


-- thac tac 3 
create view ER_Dashboard_View as 
select 
    v.Log_ID,
    v.Patient_ID,
    v.Heart_Rate, 
    v.Blood_Pressure,
    v.Record_Time,
    p.Full_Name,
    p.Admission_Time,
    case
        when v.Heart_Rate is null then 'PENDING'
        else cast(v.Heart_Rate as char)
    end as Heart_Status,
    case
        when v.Heart_Rate > 120 or v.Heart_Rate < 50 then 'CRITICAL'
        else 'STABLE'
    end as le_vel
from Vitals_Logs v 
join Patients p on v.Patient_ID = p.Patient_ID;

-- Kiểm tra kết quả
select * from ER_Dashboard_View;


-- thao tac 4 

-- cập nhật bệnh nhân có id là P001 heart_rate thành 160

update  ER_Dashboard_View
set Heart_Rate = 160
where Patient_ID ='P001';










