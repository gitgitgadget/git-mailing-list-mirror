From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [RFC PATCH v2 2/2] MSVC: Fix an "incompatible pointer types" compiler
 warning
Date: Fri, 04 Dec 2009 23:13:36 +0000
Message-ID: <4B1997A0.9000004@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Marius Storm-Olsen <mstormo@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 05 00:16:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGhNk-0004S8-Ub
	for gcvg-git-2@lo.gmane.org; Sat, 05 Dec 2009 00:16:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932563AbZLDXPy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2009 18:15:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932543AbZLDXPy
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Dec 2009 18:15:54 -0500
Received: from lon1-post-2.mail.demon.net ([195.173.77.149]:53238 "EHLO
	lon1-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932561AbZLDXPx (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Dec 2009 18:15:53 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-2.mail.demon.net with esmtp (Exim 4.69)
	id 1NGhNW-0000oS-bL; Fri, 04 Dec 2009 23:15:59 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134587>


In particular, the following warning is issued while compiling
compat/msvc.c:

    ...mingw.c(223) : warning C4133: 'function' : incompatible \
types - from '_stati64 *' to '_stat64 *'

which relates to a call of _fstati64() in the mingw_fstat()
function definition.

This is caused by various layers of macro magic and attempts to
avoid macro redefinition compiler warnings. For example, the call
to _fstati64() mentioned above is actually a call to _fstat64(),
since macro _USE_32BIT_TIME_T is not defined, and expects a pointer
to a struct _stat64 rather than the struct _stati64 which is passed
to mingw_fstat().

The definition of struct _stati64 given in compat/msvc.h had the
same "shape" as the definition of struct _stat64, so the call to
_fstat64() does not actually cause any runtime errors, but the
structure types are indeed incompatible. Also, the "shape" of
struct _stati64 changes, depending on the _USE_32BIT_TIME_T
macro, since the time_t type is defined as either __time64_t or
__time32_t.

When _USE_32BIT_TIME_T is defined, the call to _fstati64() is
actually a call to _fstat32i64() and expects a struct _stat32i64
pointer parameter. (struct _stati64 would again have the same
"shape" as struct _stat32i64).

The _USE_32BIT_TIME_T macro, along with all of the additional
structure type definitions, function definitions, and overloading
macro magic was introduced in msvc 2005.

In order to avoid the compiler warning, we add declarations for the
mingw_lstat() and mingw_fstat() functions and supporting macros to
msvc.h, suppressing the corresponding declarations in mingw.h, so
that we can use the appropriate structure type (and function) names
from the msvc headers.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Changes from v1:
    - moved the new declarations to msvc.h rather than clutter mingw.h
      with msvc related code.
    - don't even attempt to support older msvc compilers

The patch is still marked RFC because:
    - I'm still not sure if the flexibility to support both 32- and 64-bit
      time_t is required.
    - should -D_USE_32BIT_TIME_T be added to the Makefile?

ATB,
Ramsay Jones

 compat/mingw.h |    4 +++-
 compat/msvc.h  |   54 +++++++++++++++++++++++++++++-------------------------
 2 files changed, 32 insertions(+), 26 deletions(-)

diff --git a/compat/mingw.h b/compat/mingw.h
index 5b5258b..b5cec7f 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -175,13 +175,15 @@ int mingw_getpagesize(void);
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
index 9c753a5..f431007 100644
--- a/compat/msvc.h
+++ b/compat/msvc.h
@@ -21,30 +21,34 @@ static __inline int strcasecmp (const char *s1, const char *s2)
 }
 
 #undef ERROR
-#undef stat
-#undef _stati64
+
+/* Use mingw_lstat() instead of lstat()/stat() and mingw_fstat() instead
+ * of fstat(). We add the declaration of these functions here, suppressing
+ * the corresponding declarations in mingw.h, so that we can use the
+ * appropriate structure type (and function) names from the msvc headers.
+ */
+#if defined(_USE_32BIT_TIME_T)
+# define stat _stat32i64
+#else
+# define stat _stat64
+#endif
+
+int mingw_lstat(const char *file_name, struct stat *buf);
+int mingw_fstat(int fd, struct stat *buf);
+
+#define fstat mingw_fstat
+#define lstat mingw_lstat
+
+#if defined(_USE_32BIT_TIME_T)
+# define _stat32i64(x,y) mingw_lstat(x,y)
+#else
+# define _stat64(x,y) mingw_lstat(x,y)
+#endif
+
+#define ALREADY_DECLARED_STAT_FUNCS
+
 #include "compat/mingw.h"
-#undef stat
-#define stat _stati64
-#define _stat64(x,y) mingw_lstat(x,y)
-
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
+
+#undef ALREADY_DECLARED_STAT_FUNCS
+
 #endif
-- 
1.6.5
