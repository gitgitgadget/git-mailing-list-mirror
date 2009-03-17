From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 1/2] MinGW: a helper function that translates Win32 API error
 codes
Date: Tue, 17 Mar 2009 08:39:46 +0100
Message-ID: <49BF53C2.6020707@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Petr Kodl <petrkodl@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 08:41:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjTvZ-0004cX-VO
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 08:41:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753904AbZCQHkF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 03:40:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752985AbZCQHkD
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 03:40:03 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:28632 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752764AbZCQHkA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 03:40:00 -0400
Received: from [192.168.1.98] (cm56-163-160.liwest.at [86.56.163.160])
	by bsmtp.bon.at (Postfix) with ESMTP id 5D79C2C402A;
	Tue, 17 Mar 2009 08:39:52 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113430>

From: Petr Kodl <petrkodl@gmail.com>
Date: Sat, 24 Jan 2009 15:04:39 +0100

This function translates many possible Win32 error codes to suitable
errno numbers.  We will use it in our wrapper functions that need to call
into Win32.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
  Dscho,

  I've split this off from the Petr's hard-link patch and moved the function
  to the top or mingw.c because we should reuse it in our other wrappers
  to convert error codes.

  -- Hannes

  compat/mingw.c |  113 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  1 files changed, 113 insertions(+), 0 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 27bcf3f..f66ad56 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -4,6 +4,119 @@

  unsigned int _CRT_fmode = _O_BINARY;

+static int err_win_to_posix(DWORD winerr)
+{
+	int error = ENOSYS;
+	switch(winerr) {
+	case ERROR_ACCESS_DENIED: error = EACCES; break;
+	case ERROR_ACCOUNT_DISABLED: error = EACCES; break;
+	case ERROR_ACCOUNT_RESTRICTION: error = EACCES; break;
+	case ERROR_ALREADY_ASSIGNED: error = EBUSY; break;
+	case ERROR_ALREADY_EXISTS: error = EEXIST; break;
+	case ERROR_ARITHMETIC_OVERFLOW: error = ERANGE; break;
+	case ERROR_BAD_COMMAND: error = EIO; break;
+	case ERROR_BAD_DEVICE: error = ENODEV; break;
+	case ERROR_BAD_DRIVER_LEVEL: error = ENXIO; break;
+	case ERROR_BAD_EXE_FORMAT: error = ENOEXEC; break;
+	case ERROR_BAD_FORMAT: error = ENOEXEC; break;
+	case ERROR_BAD_LENGTH: error = EINVAL; break;
+	case ERROR_BAD_PATHNAME: error = ENOENT; break;
+	case ERROR_BAD_PIPE: error = EPIPE; break;
+	case ERROR_BAD_UNIT: error = ENODEV; break;
+	case ERROR_BAD_USERNAME: error = EINVAL; break;
+	case ERROR_BROKEN_PIPE: error = EPIPE; break;
+	case ERROR_BUFFER_OVERFLOW: error = ENAMETOOLONG; break;
+	case ERROR_BUSY: error = EBUSY; break;
+	case ERROR_BUSY_DRIVE: error = EBUSY; break;
+	case ERROR_CALL_NOT_IMPLEMENTED: error = ENOSYS; break;
+	case ERROR_CANNOT_MAKE: error = EACCES; break;
+	case ERROR_CANTOPEN: error = EIO; break;
+	case ERROR_CANTREAD: error = EIO; break;
+	case ERROR_CANTWRITE: error = EIO; break;
+	case ERROR_CRC: error = EIO; break;
+	case ERROR_CURRENT_DIRECTORY: error = EACCES; break;
+	case ERROR_DEVICE_IN_USE: error = EBUSY; break;
+	case ERROR_DEV_NOT_EXIST: error = ENODEV; break;
+	case ERROR_DIRECTORY: error = EINVAL; break;
+	case ERROR_DIR_NOT_EMPTY: error = ENOTEMPTY; break;
+	case ERROR_DISK_CHANGE: error = EIO; break;
+	case ERROR_DISK_FULL: error = ENOSPC; break;
+	case ERROR_DRIVE_LOCKED: error = EBUSY; break;
+	case ERROR_ENVVAR_NOT_FOUND: error = EINVAL; break;
+	case ERROR_EXE_MARKED_INVALID: error = ENOEXEC; break;
+	case ERROR_FILENAME_EXCED_RANGE: error = ENAMETOOLONG; break;
+	case ERROR_FILE_EXISTS: error = EEXIST; break;
+	case ERROR_FILE_INVALID: error = ENODEV; break;
+	case ERROR_FILE_NOT_FOUND: error = ENOENT; break;
+	case ERROR_GEN_FAILURE: error = EIO; break;
+	case ERROR_HANDLE_DISK_FULL: error = ENOSPC; break;
+	case ERROR_INSUFFICIENT_BUFFER: error = ENOMEM; break;
+	case ERROR_INVALID_ACCESS: error = EACCES; break;
+	case ERROR_INVALID_ADDRESS: error = EFAULT; break;
+	case ERROR_INVALID_BLOCK: error = EFAULT; break;
+	case ERROR_INVALID_DATA: error = EINVAL; break;
+	case ERROR_INVALID_DRIVE: error = ENODEV; break;
+	case ERROR_INVALID_EXE_SIGNATURE: error = ENOEXEC; break;
+	case ERROR_INVALID_FLAGS: error = EINVAL; break;
+	case ERROR_INVALID_FUNCTION: error = ENOSYS; break;
+	case ERROR_INVALID_HANDLE: error = EBADF; break;
+	case ERROR_INVALID_LOGON_HOURS: error = EACCES; break;
+	case ERROR_INVALID_NAME: error = EINVAL; break;
+	case ERROR_INVALID_OWNER: error = EINVAL; break;
+	case ERROR_INVALID_PARAMETER: error = EINVAL; break;
+	case ERROR_INVALID_PASSWORD: error = EPERM; break;
+	case ERROR_INVALID_PRIMARY_GROUP: error = EINVAL; break;
+	case ERROR_INVALID_SIGNAL_NUMBER: error = EINVAL; break;
+	case ERROR_INVALID_TARGET_HANDLE: error = EIO; break;
+	case ERROR_INVALID_WORKSTATION: error = EACCES; break;
+	case ERROR_IO_DEVICE: error = EIO; break;
+	case ERROR_IO_INCOMPLETE: error = EINTR; break;
+	case ERROR_LOCKED: error = EBUSY; break;
+	case ERROR_LOCK_VIOLATION: error = EACCES; break;
+	case ERROR_LOGON_FAILURE: error = EACCES; break;
+	case ERROR_MAPPED_ALIGNMENT: error = EINVAL; break;
+	case ERROR_META_EXPANSION_TOO_LONG: error = E2BIG; break;
+	case ERROR_MORE_DATA: error = EPIPE; break;
+	case ERROR_NEGATIVE_SEEK: error = ESPIPE; break;
+	case ERROR_NOACCESS: error = EFAULT; break;
+	case ERROR_NONE_MAPPED: error = EINVAL; break;
+	case ERROR_NOT_ENOUGH_MEMORY: error = ENOMEM; break;
+	case ERROR_NOT_READY: error = EAGAIN; break;
+	case ERROR_NOT_SAME_DEVICE: error = EXDEV; break;
+	case ERROR_NO_DATA: error = EPIPE; break;
+	case ERROR_NO_MORE_SEARCH_HANDLES: error = EIO; break;
+	case ERROR_NO_PROC_SLOTS: error = EAGAIN; break;
+	case ERROR_NO_SUCH_PRIVILEGE: error = EACCES; break;
+	case ERROR_OPEN_FAILED: error = EIO; break;
+	case ERROR_OPEN_FILES: error = EBUSY; break;
+	case ERROR_OPERATION_ABORTED: error = EINTR; break;
+	case ERROR_OUTOFMEMORY: error = ENOMEM; break;
+	case ERROR_PASSWORD_EXPIRED: error = EACCES; break;
+	case ERROR_PATH_BUSY: error = EBUSY; break;
+	case ERROR_PATH_NOT_FOUND: error = ENOENT; break;
+	case ERROR_PIPE_BUSY: error = EBUSY; break;
+	case ERROR_PIPE_CONNECTED: error = EPIPE; break;
+	case ERROR_PIPE_LISTENING: error = EPIPE; break;
+	case ERROR_PIPE_NOT_CONNECTED: error = EPIPE; break;
+	case ERROR_PRIVILEGE_NOT_HELD: error = EACCES; break;
+	case ERROR_READ_FAULT: error = EIO; break;
+	case ERROR_SEEK: error = EIO; break;
+	case ERROR_SEEK_ON_DEVICE: error = ESPIPE; break;
+	case ERROR_SHARING_BUFFER_EXCEEDED: error = ENFILE; break;
+	case ERROR_SHARING_VIOLATION: error = EACCES; break;
+	case ERROR_STACK_OVERFLOW: error = ENOMEM; break;
+	case ERROR_SWAPERROR: error = ENOENT; break;
+	case ERROR_TOO_MANY_MODULES: error = EMFILE; break;
+	case ERROR_TOO_MANY_OPEN_FILES: error = EMFILE; break;
+	case ERROR_UNRECOGNIZED_MEDIA: error = ENXIO; break;
+	case ERROR_UNRECOGNIZED_VOLUME: error = ENODEV; break;
+	case ERROR_WAIT_NO_CHILDREN: error = ECHILD; break;
+	case ERROR_WRITE_FAULT: error = EIO; break;
+	case ERROR_WRITE_PROTECT: error = EROFS; break;
+	}
+	return error;
+}
+
  #undef open
  int mingw_open (const char *filename, int oflags, ...)
  {
-- 
1.6.2.rc2.971.g14d5
