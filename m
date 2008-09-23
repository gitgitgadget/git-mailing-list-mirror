From: Dmitry Potapov <dpotapov@gmail.com>
Subject: [PATCH] add GIT_FAST_STAT mode for Cygwin
Date: Tue, 23 Sep 2008 18:06:17 +0400
Message-ID: <20080923140144.GN21650@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <johannes.sixt@telecom.at>,
	Junio C Hamano <gitster@pobox.com>,
	Steffen Prohaska <prohaska@zib.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 23 16:08:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ki8YB-0005md-Ea
	for gcvg-git-2@gmane.org; Tue, 23 Sep 2008 16:07:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751462AbYIWOGZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2008 10:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751409AbYIWOGZ
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Sep 2008 10:06:25 -0400
Received: from ik-out-1112.google.com ([66.249.90.183]:39797 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750958AbYIWOGX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2008 10:06:23 -0400
Received: by ik-out-1112.google.com with SMTP id c30so1190463ika.5
        for <git@vger.kernel.org>; Tue, 23 Sep 2008 07:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=o55OMCO6xi2CVsDYtgtJTIX4ZvMqF39/ireMhEDImFo=;
        b=TRpHsbBxRpZOIvHGdbiV2yFbh8T/hpLMB0uGX8oYOh1XENSbOcBLwhZ4eRVTVIkAIT
         O8tOhBkS6yYcEhNDITDDM4R5UWfT8p9BY9ZBSe7qPrVVSULDJQHHYOGwPLVIp0wc3PXG
         bQby0UxjjsHNE1/xLcPiPzjJkiNAt5TxtGZeM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=lEUMT9smMzamqOmGspf8vgGmTSxM74loFYavOlR6V/m6u34W9L3h7GNAFcjby7Sdj/
         b11Egf+Q1s17RSkT7rjrEXhFwfoIUNgTuCbpWrG6MOZaS3eCNR7DmpALDQmJIzo7IgF8
         /KlSoyK+uMiODSCWhpE3LB+Mh+3FL+hT0F5o4=
Received: by 10.210.113.16 with SMTP id l16mr6718058ebc.11.1222178782010;
        Tue, 23 Sep 2008 07:06:22 -0700 (PDT)
Received: from localhost (ppp85-140-168-121.pppoe.mtu-net.ru [85.140.168.121])
        by mx.google.com with ESMTPS id 23sm2394949eya.7.2008.09.23.07.06.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 23 Sep 2008 07:06:20 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96566>

This patch introduces the GIT_FAST_STAT environment variable. If this
variable is not set then Git will work as before. However, if it is set
then the Cygwin version of Git will try to use a Win32 API function if
it is possible to speed up stat/lstat.

This fast mode works only for relative paths. It is assumed that the
whole repository is located inside one directory without using Cygwin
mount to bind external paths inside of the current tree.

Symbol links are supported by falling back on the cygwin version of
these functions.

A very superficial testing shows 'git status' in the fast mode works more
than twice faster than in the normal mode, i.e. with about the same speed
as the native MinGW version.

Signed-off-by: Dmitry Potapov <dpotapov@gmail.com>
---

After getting used to how strikingly fast Git is on Linux, using Git on
Windows (even only for a few hours) was not so pleasant. So, here is
this patch.

For those who wonder why I don't know use MinGW version of Git, the
answer is simple -- I have Cygwin install and I happy with it, while
the MinGW version comes with MSYS, so it cannot be used in Cygwin.

 Makefile          |    4 ++
 compat/cygwin.c   |  133 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 compat/cygwin.h   |    9 ++++
 git-compat-util.h |    1 +
 4 files changed, 147 insertions(+), 0 deletions(-)
 create mode 100644 compat/cygwin.c
 create mode 100644 compat/cygwin.h

diff --git a/Makefile b/Makefile
index 3c0664a..0708390 100644
--- a/Makefile
+++ b/Makefile
@@ -347,6 +347,7 @@ LIB_H += cache.h
 LIB_H += cache-tree.h
 LIB_H += commit.h
 LIB_H += compat/mingw.h
+LIB_H += compat/cygwin.h
 LIB_H += csum-file.h
 LIB_H += decorate.h
 LIB_H += delta.h
@@ -747,6 +748,9 @@ ifeq ($(uname_S),HP-UX)
 	NO_SYS_SELECT_H = YesPlease
 	SNPRINTF_RETURNS_BOGUS = YesPlease
 endif
+ifneq (,$(findstring CYGWIN,$(uname_S)))
+	COMPAT_OBJS += compat/cygwin.o
+endif
 ifneq (,$(findstring MINGW,$(uname_S)))
 	NO_MMAP = YesPlease
 	NO_PREAD = YesPlease
diff --git a/compat/cygwin.c b/compat/cygwin.c
new file mode 100644
index 0000000..0b63d2f
--- /dev/null
+++ b/compat/cygwin.c
@@ -0,0 +1,133 @@
+#define WIN32_LEAN_AND_MEAN
+#include "../git-compat-util.h"
+#include <windows.h>
+
+static inline void filetime_to_timespec(const FILETIME *ft, struct timespec *ts)
+{
+	long long winTime = ((long long)ft->dwHighDateTime << 32) + ft->dwLowDateTime;
+	winTime -= 116444736000000000LL; /* Windows to Unix Epoch conversion */
+	ts->tv_sec = (time_t)(winTime/10000000); /* 100-nanosecond interval to seconds */
+	ts->tv_nsec = (long)(winTime - ts->tv_sec) * 100; /* nanoseconds */
+}
+
+#define size_to_blocks(s) (((s)+511)/512)
+
+/* do_stat is a common implementation for cygwin_lstat and cygwin_stat.
+ *
+ * To simplify its logic, in the case of cygwin symlinks, this implementation
+ * falls back to the cygwin version of stat/lstat, which is provided as the
+ * last argument.
+ */
+static int do_stat(const char *file_name, struct stat *buf, stat_fn_t cygstat)
+{
+	WIN32_FILE_ATTRIBUTE_DATA fdata;
+
+	if (file_name[0] == '/')
+		return cygstat (file_name, buf);
+
+	if (GetFileAttributesExA(file_name, GetFileExInfoStandard, &fdata)) {
+		int fMode = S_IREAD;
+		/*
+		 * If the system attribute is set and it is not a directory then
+		 * it could be a symbol link created in the nowinsymlinks mode.
+		 * Normally, Cygwin works in the winsymlinks mode, so this situation
+		 * is very unlikely. For the sake of simplicity of our code, let's
+		 * Cygwin to handle it.
+		 */
+		if ((fdata.dwFileAttributes & FILE_ATTRIBUTE_SYSTEM) &&
+		    !(fdata.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY))
+			return cygstat (file_name, buf);
+
+		if (fdata.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY)
+			fMode |= S_IFDIR;
+		else
+			fMode |= S_IFREG;
+		if (!(fdata.dwFileAttributes & FILE_ATTRIBUTE_READONLY))
+			fMode |= S_IWRITE;
+
+		/* st_dev, st_rdev are not used by Git */
+		buf->st_dev = buf->st_rdev = 0;
+		/* it is difficult to obtain the inode number on Windows,
+		 * so let's set it to zero as MinGW Git does. */
+		buf->st_ino = 0;
+		buf->st_mode = fMode;
+		buf->st_nlink = 1;
+		buf->st_uid = buf->st_gid = 0;
+#ifdef __CYGWIN_USE_BIG_TYPES__
+		buf->st_size = ((_off64_t)fdata.nFileSizeHigh << 32) +
+			fdata.nFileSizeLow;
+#else
+		buf->st_size = (off_t)fdata.nFileSizeLow;
+#endif
+		buf->st_blocks = size_to_blocks(buf->st_size);
+		filetime_to_timespec(&fdata.ftLastAccessTime, &buf->st_atim);
+		filetime_to_timespec(&fdata.ftLastWriteTime, &buf->st_mtim);
+		filetime_to_timespec(&fdata.ftCreationTime, &buf->st_ctim);
+		errno = 0;
+		return 0;
+	}
+
+	switch (GetLastError()) {
+	case ERROR_ACCESS_DENIED:
+	case ERROR_SHARING_VIOLATION:
+	case ERROR_LOCK_VIOLATION:
+	case ERROR_SHARING_BUFFER_EXCEEDED:
+		errno = EACCES;
+		break;
+	case ERROR_BUFFER_OVERFLOW:
+		errno = ENAMETOOLONG;
+		break;
+	case ERROR_NOT_ENOUGH_MEMORY:
+		errno = ENOMEM;
+		break;
+	default:
+		/* In the winsymlinks mode (which is the default), Cygwin
+		 * emulates symbol links using Windows shortcut files. These
+		 * files are formed by adding .lnk extension. So, if we have
+		 * not found the specified file name, it could be that it is
+		 * a symbol link. Let's Cygwin to deal with that.
+		 */
+		return cygstat (file_name, buf);
+	}
+	return -1;
+}
+
+/* We provide our own lstat/stat functions, since the provided Cygwin versions
+ * of these functions are too slow. These stat functions are tailored for Git's
+ * usage, and therefore they are not meant to be complete and correct emulation
+ * of lstat/stat functionality.
+ */
+static int cygwin_lstat(const char *path, struct stat *buf)
+{
+	return do_stat(path, buf, lstat);
+}
+
+static int cygwin_stat(const char *path, struct stat *buf)
+{
+	return do_stat(path, buf, stat);
+}
+
+/*
+ * This are startup stubs, which choose what implementation of lstat/stat
+ * should be used. If GIT_FAST_STAT is not set then the standard functions
+ * included in the cygwin library are used. If it is set then our fast and
+ * dirty implementation is invoked, which should be 2-3 times faster than
+ * cygwin functions.
+ */
+static int cygwin_stat_choice(const char *file_name, struct stat *buf)
+{
+	cygwin_stat_fn = getenv("GIT_FAST_STAT") ?
+		cygwin_stat : stat;
+	return (*cygwin_stat_fn)(file_name, buf);
+}
+
+static int cygwin_lstat_choice(const char *file_name, struct stat *buf)
+{
+	cygwin_lstat_fn = getenv("GIT_FAST_STAT") ?
+		cygwin_lstat : lstat;
+	return (*cygwin_lstat_fn)(file_name, buf);
+}
+
+stat_fn_t cygwin_stat_fn = cygwin_stat_choice;
+stat_fn_t cygwin_lstat_fn = cygwin_lstat_choice;
+
diff --git a/compat/cygwin.h b/compat/cygwin.h
new file mode 100644
index 0000000..a3229f5
--- /dev/null
+++ b/compat/cygwin.h
@@ -0,0 +1,9 @@
+#include <sys/types.h>
+#include <sys/stat.h>
+
+typedef int (*stat_fn_t)(const char*, struct stat*);
+extern stat_fn_t cygwin_stat_fn;
+extern stat_fn_t cygwin_lstat_fn;
+
+#define stat(path, buf) (*cygwin_stat_fn)(path, buf)
+#define lstat(path, buf) (*cygwin_lstat_fn)(path, buf)
diff --git a/git-compat-util.h b/git-compat-util.h
index db2836f..cd9752c 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -85,6 +85,7 @@
 #undef _XOPEN_SOURCE
 #include <grp.h>
 #define _XOPEN_SOURCE 600
+#include "compat/cygwin.h"
 #else
 #undef _ALL_SOURCE /* AIX 5.3L defines a struct list with _ALL_SOURCE. */
 #include <grp.h>
-- 
1.6.0
