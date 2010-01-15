From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v2 5/7] MSVC: Fix an "incompatible pointer types" compiler warning
Date: Fri, 15 Jan 2010 21:12:19 +0100
Message-ID: <0f678f3417c6b64993b19f707bd221aa17629c7a.1263584975.git.j6t@kdbg.org>
References: <cover.1262895936.git.j6t@kdbg.org>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Johannes Sixt <j6t@kdbg.org>
To: msysgit <msysgit@googlegroups.com>
X-From: git-owner@vger.kernel.org Fri Jan 15 21:13:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVsYP-0004sM-1p
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 21:13:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932228Ab0AOUNy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 15:13:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758176Ab0AOUNx
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 15:13:53 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:31661 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758152Ab0AOUNw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 15:13:52 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 694FD2C4007;
	Fri, 15 Jan 2010 21:13:50 +0100 (CET)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 9F76D19F60D;
	Fri, 15 Jan 2010 21:12:53 +0100 (CET)
X-Mailer: git-send-email 1.6.6.218.g3e6eb
In-Reply-To: <cover.1262895936.git.j6t@kdbg.org>
In-Reply-To: <cover.1263584975.git.j6t@kdbg.org>
References: <cover.1263584975.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137112>

From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>

In particular, the following warning is issued while compiling
compat/msvc.c:

    ...mingw.c(223) : warning C4133: 'function' : incompatible \
types - from '_stati64 *' to '_stat64 *'

which relates to a call of _fstati64() in the mingw_fstat()
function definition.

This is caused by various layers of macro magic and attempts to
avoid macro redefinition compiler warnings. For example, the call
to _fstati64() mentioned above is actually a call to _fstat64(),
and expects a pointer to a struct _stat64 rather than the struct
_stati64 which is passed to mingw_fstat().

The definition of struct _stati64 given in compat/msvc.h had the
same "shape" as the definition of struct _stat64, so the call to
_fstat64() does not actually cause any runtime errors, but the
structure types are indeed incompatible.

In order to avoid the compiler warning, we add declarations for the
mingw_lstat() and mingw_fstat() functions and supporting macros to
msvc.h, suppressing the corresponding declarations in mingw.h, so
that we can use the appropriate structure type (and function) names
from the msvc headers.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 This patch is new in this round.

 compat/mingw.h |    4 +++-
 compat/msvc.h  |   40 ++++++++++++++++------------------------
 2 files changed, 19 insertions(+), 25 deletions(-)

diff --git a/compat/mingw.h b/compat/mingw.h
index a105dc9..afe12ea 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -209,13 +209,15 @@ int mingw_getpagesize(void);
  * mingw_fstat() instead of fstat() on Windows.
  */
 #define off_t off64_t
-#define stat _stati64
 #define lseek _lseeki64
+#ifndef ALREADY_DECLARED_STAT_FUNCS
+#define stat _stati64
 int mingw_lstat(const char *file_name, struct stat *buf);
 int mingw_fstat(int fd, struct stat *buf);
 #define fstat mingw_fstat
 #define lstat mingw_lstat
 #define _stati64(x,y) mingw_lstat(x,y)
+#endif
 
 int mingw_utime(const char *file_name, const struct utimbuf *times);
 #define utime mingw_utime
diff --git a/compat/msvc.h b/compat/msvc.h
index 9c753a5..023aba0 100644
--- a/compat/msvc.h
+++ b/compat/msvc.h
@@ -21,30 +21,22 @@ static __inline int strcasecmp (const char *s1, const char *s2)
 }
 
 #undef ERROR
-#undef stat
-#undef _stati64
-#include "compat/mingw.h"
-#undef stat
-#define stat _stati64
+
+/* Use mingw_lstat() instead of lstat()/stat() and mingw_fstat() instead
+ * of fstat(). We add the declaration of these functions here, suppressing
+ * the corresponding declarations in mingw.h, so that we can use the
+ * appropriate structure type (and function) names from the msvc headers.
+ */
+#define stat _stat64
+int mingw_lstat(const char *file_name, struct stat *buf);
+int mingw_fstat(int fd, struct stat *buf);
+#define fstat mingw_fstat
+#define lstat mingw_lstat
 #define _stat64(x,y) mingw_lstat(x,y)
+#define ALREADY_DECLARED_STAT_FUNCS
+
+#include "compat/mingw.h"
+
+#undef ALREADY_DECLARED_STAT_FUNCS
 
-/*
-   Even though _stati64 is normally just defined at _stat64
-   on Windows, we specify it here as a proper struct to avoid
-   compiler warnings about macro redefinition due to magic in
-   mingw.h. Struct taken from ReactOS (GNU GPL license).
-*/
-struct _stati64 {
-	_dev_t  st_dev;
-	_ino_t  st_ino;
-	unsigned short st_mode;
-	short   st_nlink;
-	short   st_uid;
-	short   st_gid;
-	_dev_t  st_rdev;
-	__int64 st_size;
-	time_t  st_atime;
-	time_t  st_mtime;
-	time_t  st_ctime;
-};
 #endif
-- 
1.6.6.218.g3e6eb
