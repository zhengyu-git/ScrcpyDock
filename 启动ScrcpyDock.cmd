@echo off
setlocal
set "PYTHONDONTWRITEBYTECODE=1"
set "PYTHONUTF8=1"
set "SCRCPYDOCK_SCRIPT=%~dp0app\scrcpydock.py"
if not exist "%SCRCPYDOCK_SCRIPT%" (
    echo Missing app\scrcpydock.py. Keep the full ScrcpyDock folder together.
    pause
    exit /b 1
)
pushd "%~dp0"
python -c "from PySide6 import QtWidgets, QtMultimedia, QtSvg; import av; assert hasattr(av.container.OutputContainer, 'add_mux_stream')" >nul 2>&1
if errorlevel 1 (
    echo ScrcpyDock requires Python, PySide6 and PyAV.
    echo Install the dependencies with: python -m pip install -r requirements.txt
    pause
    popd
    exit /b 1
)
where pythonw.exe >nul 2>&1
if errorlevel 1 (
    python "%SCRCPYDOCK_SCRIPT%"
    if errorlevel 1 pause
) else (
    start "" pythonw.exe "%SCRCPYDOCK_SCRIPT%"
)
popd
