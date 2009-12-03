From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [RFC PATCH 2/2] MSVC: Fix an "incompatible pointer types" compiler
 warning
Date: Thu, 03 Dec 2009 18:44:11 +0000
Message-ID: <4B1806FB.2050401@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Marius Storm-Olsen <mstormo@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 03 19:59:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGGtk-00004s-WB
	for gcvg-git-2@lo.gmane.org; Thu, 03 Dec 2009 19:59:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756539AbZLCS7K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Dec 2009 13:59:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756528AbZLCS7J
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Dec 2009 13:59:09 -0500
Received: from anchor-post-3.mail.demon.net ([195.173.77.134]:65357 "EHLO
	anchor-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756502AbZLCS7I (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Dec 2009 13:59:08 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1NGGtV-00026E-ng; Thu, 03 Dec 2009 18:59:14 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134465>


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

In order to avoid the compiler warning, we use the appropriate
structure type names (and function names) from the msvc headers.
This allows us to compile with -D_USE_32BIT_TIME_T if necessary.
Note that the original mingw code should work with an msvc/sdk
prior to 2005. We attempt to detect this by checking for _stati64
being defined as a macro and, if not defined, conditionally
compiling the original code.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

The first version of this patch was much simpler; the diffstat showed
a net decrease of 15 lines of code! The extra fat comes from additions
to the compat/mingw.h file. The original change looked like this (along
with the identical change to compat/msvc.h):

    @@ -175,13 +175,21 @@ int mingw_getpagesize(void);
      * mingw_fstat() instead of fstat() on Windows.
      */
     #define off_t off64_t
    -#define stat _stati64
     #define lseek _lseeki64
    +#if defined(_MSC_VER)
    +#define stat _stat64
    +#else
    +#define stat _stati64
    +#endif
     int mingw_lstat(const char *file_name, struct stat *buf);
     int mingw_fstat(int fd, struct stat *buf);
     #define fstat mingw_fstat
     #define lstat mingw_lstat
    +#if defined(_MSC_VER)
    +#define _stat64(x,y) mingw_lstat(x,y)
    +#else
     #define _stati64(x,y) mingw_lstat(x,y)
    +#endif
 
     int mingw_utime(const char *file_name, const struct utimbuf *times);
     #define utime mingw_utime

This works with my version of msvc/sdk, provided we have no need to compile
with -D_USE_32BIT_TIME_T. (I was a little concerned when I noticed that the
time_t type was 64-bits; I checked a few of the obvious places to see if this
causes any breakage, but didn't find any).

Also, I added the "&& defined(_stati64)" in the hope that it would work with
older msvc/sdk versions.

The reason for the RFC is:

    - maybe we don't need the flexibility of compiling with/without the 32-bit
      time_t definition (which *works* BTW) and can revert to the original patch?
    - I *think* this will work with older msvc, but I can't test it!
    - I've tried to be careful not to break the MinGW build, but again I can't
      test it. (I will be shocked if I have ;-)

ATB,
Ramsay Jones

 compat/mingw.h |   27 ++++++++++++++++++++++++++-
 compat/msvc.h  |   25 +------------------------
 2 files changed, 27 insertions(+), 25 deletions(-)

diff --git a/compat/mingw.h b/compat/mingw.h
index 5b5258b..98d233b 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -175,14 +175,39 @@ int mingw_getpagesize(void);
  * mingw_fstat() instead of fstat() on Windows.
  */
 #define off_t off64_t
-#define stat _stati64
 #define lseek _lseeki64
+
+#if defined(_MSC_VER) && defined(_stati64)
+
+# if defined(_USE_32BIT_TIME_T)
+#  define stat _stat32i64
+# else
+#  define stat _stat64
+# endif
+
+  int mingw_lstat(const char *file_name, struct stat *buf);
+  int mingw_fstat(int fd, struct stat *buf);
+
+# define fstat mingw_fstat
+# define lstat mingw_lstat
+
+# if defined(_USE_32BIT_TIME_T)
+#  define _stat32i64(x,y) mingw_lstat(x,y)
+# else
+#  define _stat64(x,y) mingw_lstat(x,y)
+# endif
+
+#else  /* !defined(_MSC_VER) || !defined(_stati64) */
+
+#define stat _stati64
 int mingw_lstat(const char *file_name, struct stat *buf);
 int mingw_fstat(int fd, struct stat *buf);
 #define fstat mingw_fstat
 #define lstat mingw_lstat
 #define _stati64(x,y) mingw_lstat(x,y)
 
+#endif
+
 int mingw_utime(const char *file_name, const struct utimbuf *times);
 #define utime mingw_utime
 
diff --git a/compat/msvc.h b/compat/msvc.h
index 9c753a5..c099fe0 100644
--- a/compat/msvc.h
+++ b/compat/msvc.h
@@ -21,30 +21,7 @@ static __inline int strcasecmp (const char *s1, const char *s2)
 }
 
 #undef ERROR
-#undef stat
-#undef _stati64
+
 #include "compat/mingw.h"
-#undef stat
-#define stat _stati64
-#define _stat64(x,y) mingw_lstat(x,y)
 
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
