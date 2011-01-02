From: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
Subject: [PATCH] Consistent use of AC_LANG_PROGRAM in configure.ac and
 aclocal.m4.
Date: Sun, 2 Jan 2011 11:24:55 +0100
Organization: Institute for Numerical Simulation, University of Bonn
Message-ID: <20110102102455.GD10365@gmx.de>
References: <20110102060044.GJ19818@gmx.de>
 <20110102075953.GB8937@burratino>
 <20110102094730.GA10365@gmx.de>
 <20110102100012.GA12284@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 02 11:25:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PZL7X-0002Qa-PY
	for gcvg-git-2@lo.gmane.org; Sun, 02 Jan 2011 11:25:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755003Ab1ABKY6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Jan 2011 05:24:58 -0500
Received: from mailout-de.gmx.net ([213.165.64.22]:42071 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1752957Ab1ABKY5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jan 2011 05:24:57 -0500
Received: (qmail invoked by alias); 02 Jan 2011 10:24:55 -0000
Received: from xdsl-78-34-215-55.netcologne.de (EHLO localhost.localdomain) [78.34.215.55]
  by mail.gmx.net (mp028) with SMTP; 02 Jan 2011 11:24:55 +0100
X-Authenticated: #13673931
X-Provags-ID: V01U2FsdGVkX1+IH9RuAtqIr3xFiUq632MNgFr91dJIIRdUOA0BKs
	SrUfcfL/7W5jID
Received: from ralf by localhost.localdomain with local (Exim 4.69)
	(envelope-from <Ralf.Wildenhues@gmx.de>)
	id 1PZL7P-0001eC-CU; Sun, 02 Jan 2011 11:24:55 +0100
Mail-Followup-To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20110102100012.GA12284@burratino>
User-Agent: Mutt/1.5.20 (2010-08-04)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164416>

This avoids warnings from Autoconf 2.68 about missing use of
AC_LANG_PROGRAM and friends.

Quoting autoconf-2.68/NEWS:

  ** The macros AC_PREPROC_IFELSE, AC_COMPILE_IFELSE, AC_LINK_IFELSE, and
     AC_RUN_IFELSE now warn if the first argument failed to use
     AC_LANG_SOURCE or AC_LANG_PROGRAM to generate the conftest file
     contents.  A new macro AC_LANG_DEFINES_PROVIDED exists if you have
     a compelling reason why you cannot use AC_LANG_SOURCE but must
     avoid the warning.

The underlying reason for this change is that AC_LANG_{SOURCE,PROGRAM}
take care to actually supply the previously computed set of #defines
(and include the standard headers if so desired), for preprocessed
languages like C and C++.

In some cases, AC_LANG_PROGRAM is already used but not sufficiently
m4-quoted, so we just need to add another set of [quotes] to prevent
the autoconf warning from being triggered bogusly.  Quoting all
arguments (except when calling special macros that _need_ to be
expanded before recursion) is better style, anyway.  These and more
rules are described in detail in 'info Autoconf "Programming in M4"'.

The patch should not cause any semantic changes in the generated
configure script.

Signed-off-by: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
---

* Jonathan Nieder wrote on Sun, Jan 02, 2011 at 11:00:12AM CET:
> Ralf Wildenhues wrote:
> 
> > I would be happy to update the patch in a way that makes it more
> > helpful, but most of the above is fairly general Autoconf rules,
> > so I'm not sure what you need (being blinded by looking at this
> > stuff too often).
> 
> A little essay in the commit message should be sufficient.  Something
> vaguely like this, maybe.  (cut and pasted from the above)

Thank you for your help!  Resending like this.

Cheers,
Ralf

 aclocal.m4   |    4 ++--
 configure.ac |   56 +++++++++++++++++++-------------------------------------
 2 files changed, 21 insertions(+), 39 deletions(-)

diff --git a/aclocal.m4 b/aclocal.m4
index d399de2..f11bc7e 100644
--- a/aclocal.m4
+++ b/aclocal.m4
@@ -13,7 +13,7 @@ AC_DEFUN([TYPE_SOCKLEN_T],
          git_cv_socklen_t_equiv=
          for arg2 in "struct sockaddr" void; do
             for t in int size_t unsigned long "unsigned long"; do
-               AC_TRY_COMPILE([
+               AC_COMPILE_IFELSE([AC_LANG_PROGRAM([
                   #include <sys/types.h>
                   #include <sys/socket.h>
 
@@ -21,7 +21,7 @@ AC_DEFUN([TYPE_SOCKLEN_T],
                ],[
                   $t len;
                   getpeername(0,0,&len);
-               ],[
+               ])],[
                   git_cv_socklen_t_equiv="$t"
                   break 2
                ])
diff --git a/configure.ac b/configure.ac
index 5792425..20039c5 100644
--- a/configure.ac
+++ b/configure.ac
@@ -345,7 +345,7 @@ esac
 AC_CACHE_CHECK([if linker supports -R], git_cv_ld_dashr, [
    SAVE_LDFLAGS="${LDFLAGS}"
    LDFLAGS="${SAVE_LDFLAGS} -R /"
-   AC_LINK_IFELSE(AC_LANG_PROGRAM([], []), [git_cv_ld_dashr=yes], [git_cv_ld_dashr=no])
+   AC_LINK_IFELSE([AC_LANG_PROGRAM([], [])], [git_cv_ld_dashr=yes], [git_cv_ld_dashr=no])
    LDFLAGS="${SAVE_LDFLAGS}"
 ])
 if test "$git_cv_ld_dashr" = "yes"; then
@@ -354,7 +354,7 @@ else
    AC_CACHE_CHECK([if linker supports -Wl,-rpath,], git_cv_ld_wl_rpath, [
       SAVE_LDFLAGS="${LDFLAGS}"
       LDFLAGS="${SAVE_LDFLAGS} -Wl,-rpath,/"
-      AC_LINK_IFELSE(AC_LANG_PROGRAM([], []), [git_cv_ld_wl_rpath=yes], [git_cv_ld_wl_rpath=no])
+      AC_LINK_IFELSE([AC_LANG_PROGRAM([], [])], [git_cv_ld_wl_rpath=yes], [git_cv_ld_wl_rpath=no])
       LDFLAGS="${SAVE_LDFLAGS}"
    ])
    if test "$git_cv_ld_wl_rpath" = "yes"; then
@@ -363,7 +363,7 @@ else
       AC_CACHE_CHECK([if linker supports -rpath], git_cv_ld_rpath, [
          SAVE_LDFLAGS="${LDFLAGS}"
          LDFLAGS="${SAVE_LDFLAGS} -rpath /"
-         AC_LINK_IFELSE(AC_LANG_PROGRAM([], []), [git_cv_ld_rpath=yes], [git_cv_ld_rpath=no])
+         AC_LINK_IFELSE([AC_LANG_PROGRAM([], [])], [git_cv_ld_rpath=yes], [git_cv_ld_rpath=no])
          LDFLAGS="${SAVE_LDFLAGS}"
       ])
       if test "$git_cv_ld_rpath" = "yes"; then
@@ -472,15 +472,9 @@ if test -z "$NO_ICONV"; then
 
 GIT_STASH_FLAGS($ICONVDIR)
 
-AC_DEFUN([ICONVTEST_SRC], [
-#include <iconv.h>
-
-int main(void)
-{
-	iconv_open("", "");
-	return 0;
-}
-])
+AC_DEFUN([ICONVTEST_SRC],
+[AC_LANG_PROGRAM([#include <iconv.h>],
+ [iconv_open("", "");])])
 
 if test -n "$ICONVDIR"; then
    lib_order="-liconv -lc"
@@ -500,7 +494,7 @@ for l in $lib_order; do
     old_LIBS="$LIBS"
     LIBS="$LIBS $l"
     AC_MSG_CHECKING([for iconv in $l])
-    AC_LINK_IFELSE(ICONVTEST_SRC,
+    AC_LINK_IFELSE([ICONVTEST_SRC],
 	[AC_MSG_RESULT([yes])
 	NO_ICONV=
 	break],
@@ -528,18 +522,12 @@ fi
 GIT_STASH_FLAGS($ZLIB_PATH)
 
 AC_DEFUN([ZLIBTEST_SRC], [
-#include <zlib.h>
-
-int main(void)
-{
-	deflateBound(0, 0);
-	return 0;
-}
-])
+AC_LANG_PROGRAM([#include <zlib.h>],
+ [deflateBound(0, 0);])])
 AC_MSG_CHECKING([for deflateBound in -lz])
 old_LIBS="$LIBS"
 LIBS="$LIBS -lz"
-AC_LINK_IFELSE(ZLIBTEST_SRC,
+AC_LINK_IFELSE([ZLIBTEST_SRC],
 	[AC_MSG_RESULT([yes])],
 	[AC_MSG_RESULT([no])
 	NO_DEFLATE_BOUND=yes])
@@ -631,23 +619,19 @@ AC_SUBST(NO_INTTYPES_H)
 #
 # Define OLD_ICONV if your library has an old iconv(), where the second
 # (input buffer pointer) parameter is declared with type (const char **).
-AC_DEFUN([OLDICONVTEST_SRC], [[
+AC_DEFUN([OLDICONVTEST_SRC], [
+AC_LANG_PROGRAM([[
 #include <iconv.h>
 
 extern size_t iconv(iconv_t cd,
 		    char **inbuf, size_t *inbytesleft,
 		    char **outbuf, size_t *outbytesleft);
-
-int main(void)
-{
-	return 0;
-}
-]])
+]], [])])
 
 GIT_STASH_FLAGS($ICONVDIR)
 
 AC_MSG_CHECKING([for old iconv()])
-AC_COMPILE_IFELSE(OLDICONVTEST_SRC,
+AC_COMPILE_IFELSE([OLDICONVTEST_SRC],
 	[AC_MSG_RESULT([no])],
 	[AC_MSG_RESULT([yes])
 	OLD_ICONV=UnfortunatelyYes])
@@ -931,18 +915,16 @@ AC_SUBST(NO_INITGROUPS)
 #
 # Define PTHREAD_LIBS to the linker flag used for Pthread support.
 AC_DEFUN([PTHREADTEST_SRC], [
+AC_LANG_PROGRAM([[
 #include <pthread.h>
-
-int main(void)
-{
+]], [[
 	pthread_mutex_t test_mutex;
 	int retcode = 0;
 	retcode |= pthread_mutex_init(&test_mutex,(void *)0);
 	retcode |= pthread_mutex_lock(&test_mutex);
 	retcode |= pthread_mutex_unlock(&test_mutex);
 	return retcode;
-}
-])
+]])])
 
 dnl AC_LANG_CONFTEST([AC_LANG_PROGRAM(
 dnl   [[#include <pthread.h>]],
@@ -962,7 +944,7 @@ elif test -z "$PTHREAD_CFLAGS"; then
      old_CFLAGS="$CFLAGS"
      CFLAGS="$opt $CFLAGS"
      AC_MSG_CHECKING([Checking for POSIX Threads with '$opt'])
-     AC_LINK_IFELSE(PTHREADTEST_SRC,
+     AC_LINK_IFELSE([PTHREADTEST_SRC],
 	[AC_MSG_RESULT([yes])
 		NO_PTHREADS=
 		PTHREAD_LIBS="$opt"
@@ -982,7 +964,7 @@ else
   old_CFLAGS="$CFLAGS"
   CFLAGS="$PTHREAD_CFLAGS $CFLAGS"
   AC_MSG_CHECKING([Checking for POSIX Threads with '$PTHREAD_CFLAGS'])
-  AC_LINK_IFELSE(PTHREADTEST_SRC,
+  AC_LINK_IFELSE([PTHREADTEST_SRC],
 	[AC_MSG_RESULT([yes])
 		NO_PTHREADS=
 		PTHREAD_LIBS="$PTHREAD_CFLAGS"
-- 
1.7.4.rc0
