From: Dmitry Potapov <dpotapov@gmail.com>
Subject: [PATCH 3/4] mingw: move common functionality to win32.h
Date: Sat, 27 Sep 2008 12:43:01 +0400
Message-ID: <20080927084301.GB21650@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Alex Riesen <raa.lkml@gmail.com>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Marcus Griep <marcus@griep.us>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 27 10:44:22 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjVPY-0004Jz-0A
	for gcvg-git-2@gmane.org; Sat, 27 Sep 2008 10:44:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752116AbYI0InK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Sep 2008 04:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752115AbYI0InJ
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Sep 2008 04:43:09 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:28336 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752006AbYI0InH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Sep 2008 04:43:07 -0400
Received: by fg-out-1718.google.com with SMTP id 19so874565fgg.17
        for <git@vger.kernel.org>; Sat, 27 Sep 2008 01:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=gi18bxEW5XpjWLuskQCs+O59ZbqYMT1BwCt3ep+2T0I=;
        b=RyRx2eByQwoEWEfuZbTaFEShY71H2RWrkoV8lJIjtY4EhDuWEjjXnNjE0GkayeqylX
         8OSE3Ttmk8cCwJdo9XBIbv++Sx5i+HWOZ4bCw2EaHZN8cfwJ/UTrvaz2QgEk0NoVRuff
         Crb3B37QiCXIyP1inTYipFXEDffPBIgkE4IhE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=rkG/INEAujIq8uz7NNy499d/mcF+NH9XCcMo5MKs21HXYVkfsyXcodj4CSSNoPo1e8
         8t/lHey2DBhl7F7kwia6DnnHkxZeK4uo8NL7yHnpaZI/T+TUPhvXGimvX0EivDpx81cl
         NWg75n45NwdoT71nvydff1HmIoT4+Vip6/9Vk=
Received: by 10.86.79.19 with SMTP id c19mr2142072fgb.5.1222504985382;
        Sat, 27 Sep 2008 01:43:05 -0700 (PDT)
Received: from localhost ( [85.141.151.122])
        by mx.google.com with ESMTPS id 3sm4829633fge.3.2008.09.27.01.43.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 27 Sep 2008 01:43:04 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96907>

Some small Win32 specific functions will be shared by MinGW and
Cygwin compatibility layer. Place them into a separate header.

Signed-off-by: Dmitry Potapov <dpotapov@gmail.com>
---
 compat/mingw.c |   42 ++++--------------------------------------
 compat/win32.h |   34 ++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 38 deletions(-)
 create mode 100644 compat/win32.h

diff --git a/compat/mingw.c b/compat/mingw.c
index a2b8cd7..ac77283 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1,4 +1,5 @@
 #include "../git-compat-util.h"
+#include "win32.h"
 #include "../strbuf.h"
 
 unsigned int _CRT_fmode = _O_BINARY;
@@ -39,46 +40,19 @@ static int do_lstat(const char *file_name, struct stat *buf)
 {
 	WIN32_FILE_ATTRIBUTE_DATA fdata;
 
-	if (GetFileAttributesExA(file_name, GetFileExInfoStandard, &fdata)) {
-		int fMode = S_IREAD;
-		if (fdata.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY)
-			fMode |= S_IFDIR;
-		else
-			fMode |= S_IFREG;
-		if (!(fdata.dwFileAttributes & FILE_ATTRIBUTE_READONLY))
-			fMode |= S_IWRITE;
-
+	if (!(errno = get_file_attr(file_name, &fdata))) {
 		buf->st_ino = 0;
 		buf->st_gid = 0;
 		buf->st_uid = 0;
 		buf->st_nlink = 1;
-		buf->st_mode = fMode;
+		buf->st_mode = file_attr_to_st_mode(fdata.dwFileAttributes);
 		buf->st_size = fdata.nFileSizeLow; /* Can't use nFileSizeHigh, since it's not a stat64 */
 		buf->st_dev = buf->st_rdev = 0; /* not used by Git */
 		buf->st_atime = filetime_to_time_t(&(fdata.ftLastAccessTime));
 		buf->st_mtime = filetime_to_time_t(&(fdata.ftLastWriteTime));
 		buf->st_ctime = filetime_to_time_t(&(fdata.ftCreationTime));
-		errno = 0;
 		return 0;
 	}
-
-	switch (GetLastError()) {
-	case ERROR_ACCESS_DENIED:
-	case ERROR_SHARING_VIOLATION:
-	case ERROR_LOCK_VIOLATION:
-	case ERROR_SHARING_BUFFER_EXCEEDED:
-		errno = EACCES;
-		break;
-	case ERROR_BUFFER_OVERFLOW:
-		errno = ENAMETOOLONG;
-		break;
-	case ERROR_NOT_ENOUGH_MEMORY:
-		errno = ENOMEM;
-		break;
-	default:
-		errno = ENOENT;
-		break;
-	}
 	return -1;
 }
 
@@ -130,19 +104,11 @@ int mingw_fstat(int fd, struct stat *buf)
 		return fstat(fd, buf);
 
 	if (GetFileInformationByHandle(fh, &fdata)) {
-		int fMode = S_IREAD;
-		if (fdata.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY)
-			fMode |= S_IFDIR;
-		else
-			fMode |= S_IFREG;
-		if (!(fdata.dwFileAttributes & FILE_ATTRIBUTE_READONLY))
-			fMode |= S_IWRITE;
-
 		buf->st_ino = 0;
 		buf->st_gid = 0;
 		buf->st_uid = 0;
 		buf->st_nlink = 1;
-		buf->st_mode = fMode;
+		buf->st_mode = file_attr_to_st_mode(fdata.dwFileAttributes);
 		buf->st_size = fdata.nFileSizeLow; /* Can't use nFileSizeHigh, since it's not a stat64 */
 		buf->st_dev = buf->st_rdev = 0; /* not used by Git */
 		buf->st_atime = filetime_to_time_t(&(fdata.ftLastAccessTime));
diff --git a/compat/win32.h b/compat/win32.h
new file mode 100644
index 0000000..c26384e
--- /dev/null
+++ b/compat/win32.h
@@ -0,0 +1,34 @@
+/* common Win32 functions for MinGW and Cygwin */
+#include <windows.h>
+
+static inline int file_attr_to_st_mode (DWORD attr)
+{
+	int fMode = S_IREAD;
+	if (attr & FILE_ATTRIBUTE_DIRECTORY)
+		fMode |= S_IFDIR;
+	else
+		fMode |= S_IFREG;
+	if (!(attr & FILE_ATTRIBUTE_READONLY))
+		fMode |= S_IWRITE;
+	return fMode;
+}
+
+static inline int get_file_attr(const char *fname, WIN32_FILE_ATTRIBUTE_DATA *fdata)
+{
+	if (GetFileAttributesExA(fname, GetFileExInfoStandard, fdata))
+		return 0;
+
+	switch (GetLastError()) {
+	case ERROR_ACCESS_DENIED:
+	case ERROR_SHARING_VIOLATION:
+	case ERROR_LOCK_VIOLATION:
+	case ERROR_SHARING_BUFFER_EXCEEDED:
+		return EACCES;
+	case ERROR_BUFFER_OVERFLOW:
+		return ENAMETOOLONG;
+	case ERROR_NOT_ENOUGH_MEMORY:
+		return ENOMEM;
+	default:
+		return ENOENT;
+	}
+}
-- 
1.6.0.2.237.g0297e5
