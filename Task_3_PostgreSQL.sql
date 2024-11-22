CREATE DATABASE EventsManagement;

CREATE TABLE Events (
    Event_Id SERIAL PRIMARY KEY,
    Event_Name VARCHAR(100) NOT NULL,
    Event_Date DATE NOT NULL,
    Event_Location VARCHAR(100),
    Event_Description TEXT
);
select * from Events;

CREATE TABLE Attendees (
    Attendee_Id SERIAL PRIMARY KEY,
    Attendee_Name VARCHAR(100) NOT NULL,
    Attendee_Phone VARCHAR(15),
    Attendee_Email VARCHAR(100) UNIQUE,
    Attendee_City VARCHAR(100)
);
select * from Attendees;

CREATE TABLE Registrations (
    Registration_Id SERIAL PRIMARY KEY,
    Event_Id INT NOT NULL,
    Attendee_Id INT NOT NULL,
    Registration_Date DATE NOT NULL,
    Registration_Amount DECIMAL(10, 2),
    FOREIGN KEY (Event_Id) REFERENCES Events(Event_Id),
    FOREIGN KEY (Attendee_Id) REFERENCES Attendees(Attendee_Id)
);
select * from Registrations;

INSERT INTO Events (Event_Name, Event_Date, Event_Location, Event_Description)
VALUES
('Music Concert', '2024-12-10', 'City Arena', 'An exciting evening of live music and performances'),
('Tech Conference', '2024-11-15', 'Tech Hub', 'A conference on the latest trends in technology'),
('Food Festival', '2024-11-20', 'Central Park', 'A festival celebrating local and international cuisines');

INSERT INTO Attendees (Attendee_Name, Attendee_Phone, Attendee_Email, Attendee_City)
VALUES
('Sucharita', '1234567890', 'sucharita@example.com', 'Bengaluru'),
('Madhuri', '9876543210', 'madhuri@example.com', 'Pune'),
('Samrath', '5556667777', 'samrath@example.com', 'Hyderabad');

INSERT INTO Registrations (Event_Id, Attendee_Id, Registration_Date, Registration_Amount)
VALUES
(1, 1, '2024-12-01', 150.00),  
(2, 2, '2024-11-10', 200.00), 
(3, 3, '2024-11-18', 300.00);  


INSERT INTO Events (Event_Name, Event_Date, Event_Location, Event_Description)
VALUES
('Fashon Show', '2024-12-05', 'Ramp Gallary', 'A display of modern Fashon Jewellery and Dresses');

UPDATE Events
SET Event_Date = '2024-11-18'
WHERE Event_Name = 'Tech Conference';

DELETE FROM Registrations WHERE Event_Id = 3;
DELETE FROM Events WHERE Event_Id = 3;

INSERT INTO Attendees (Attendee_Name, Attendee_Phone, Attendee_Email, Attendee_City)
VALUES
('Shankar', '7978699431', 'Shankar@example.com', 'Mumbai');

INSERT INTO Registrations (Event_Id, Attendee_Id, Registration_Date, Registration_Amount)
VALUES
(1, 4, '2024-12-01', 150.00);  -- Register Shankar for Music Concert

SELECT * FROM Events;

-- To generate attendee list for a specific Event for ex:- Tech Conference

SELECT Attendees.Attendee_Name, Attendees.Attendee_Email, Registrations.Registration_Date
FROM Attendees
JOIN Registrations ON Attendees.Attendee_Id = Registrations.Attendee_Id
JOIN Events ON Registrations.Event_Id = Events.Event_Id
WHERE Events.Event_Name = 'Tech Conference';

-- To generate attendee lists

SELECT a.Attendee_Name, a.Attendee_Email, e.Event_Name
FROM Attendees a
JOIN Registrations r ON a.Attendee_Id = r.Attendee_Id
JOIN Events e ON r.Event_Id = e.Event_Id;

-- To calculate event attendance statistics

SELECT e.Event_Name, COUNT(r.Registration_Id) AS Total_Attendees, SUM(r.Registration_Amount) AS Total_Revenue
FROM Events e
LEFT JOIN Registrations r ON e.Event_Id = r.Event_Id
GROUP BY e.Event_Name;