From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH v3 2/2] MSVC: Fix an "incompatible pointer types" compiler
 warning
Date: Thu, 10 Dec 2009 19:03:13 +0000
Message-ID: <4B2145F1.8050205@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Marius Storm-Olsen <mstormo@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 10 20:06:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIoLD-0006Hk-72
	for gcvg-git-2@lo.gmane.org; Thu, 10 Dec 2009 20:06:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761565AbZLJTF5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Dec 2009 14:05:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761563AbZLJTF5
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Dec 2009 14:05:57 -0500
Received: from anchor-post-2.mail.demon.net ([195.173.77.133]:37024 "EHLO
	anchor-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1761554AbZLJTF4 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Dec 2009 14:05:56 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-2.mail.demon.net with esmtp (Exim 4.69)
	id 1NIoKv-0002mH-lo; Thu, 10 Dec 2009 19:06:02 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135040>


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
---

Changes from v2:
    - removed the #if conditionals and related code depending on
      the _USE_32BIT_TIME_T macro being defined.
    - re-worded the commit message to reflect the above.

We assume that git will never be compiled with -D_USE_32BIT_TIME_T,
otherwise this patch will introduce a breakage that the current code
does not suffer.

[Hmm, should the above paragraph (or one like it) be added to the
commit message?]

Note that, if we wish to support 64-bit Windows, we would not be able
to use this macro anyway (it elicits an #error message on WIN64).
(ie. a time_t can only be 64-bits on WIN64)

ATB,
Ramsay Jones

 compat/mingw.h |    4 +++-
 compat/msvc.h  |   40 ++++++++++++++++------------------------
 2 files changed, 19 insertions(+), 25 deletions(-)

diff --git a/compat/mingw.h b/compat/mingw.h
index b3d299f..55fd7fa 100644
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
1.6.5
