From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: [PATCH] configure: rework pthread handling to allow for user defined flags
Date: Thu, 12 Mar 2009 15:20:12 -0400
Message-ID: <1236885612-22575-8-git-send-email-bwalton@artsci.utoronto.ca>
References: <1236885612-22575-1-git-send-email-bwalton@artsci.utoronto.ca>
 <1236885612-22575-2-git-send-email-bwalton@artsci.utoronto.ca>
 <1236885612-22575-3-git-send-email-bwalton@artsci.utoronto.ca>
 <1236885612-22575-4-git-send-email-bwalton@artsci.utoronto.ca>
 <1236885612-22575-5-git-send-email-bwalton@artsci.utoronto.ca>
 <1236885612-22575-6-git-send-email-bwalton@artsci.utoronto.ca>
 <1236885612-22575-7-git-send-email-bwalton@artsci.utoronto.ca>
Cc: Ben Walton <bwalton@artsci.utoronto.ca>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 12 20:23:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhqVC-0000Gf-Bg
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 20:23:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756361AbZCLTUi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2009 15:20:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756826AbZCLTUg
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 15:20:36 -0400
Received: from www.cquest.utoronto.ca ([192.82.128.5]:36893 "EHLO
	www.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756467AbZCLTUR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2009 15:20:17 -0400
Received: from ntdws12.chass.utoronto.ca ([128.100.160.253] ident=93)
	by www.cquest.utoronto.ca with esmtp (Exim 4.43)
	id 1LhqRy-0004TL-BE; Thu, 12 Mar 2009 15:20:14 -0400
Received: from localhost
	([127.0.0.1] helo=ntdws12.chass.utoronto.ca ident=505)
	by ntdws12.chass.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1LhqRy-0005uY-8Z; Thu, 12 Mar 2009 15:20:14 -0400
Received: (from bwalton@localhost)
	by ntdws12.chass.utoronto.ca (8.13.8/8.13.8/Submit) id n2CJKEUL022721;
	Thu, 12 Mar 2009 15:20:14 -0400
X-Mailer: git-send-email 1.5.5.6
In-Reply-To: <1236885612-22575-7-git-send-email-bwalton@artsci.utoronto.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113113>

The tests for POSIX threads can now be controlled by the user with the
--enable-pthreads=FLAGS option.  If this is set (to some value other
than yes or no), the value is passed to the compiler.  Thread support
is based solely on the outcome of this test.  The user may specify not
to use threading at all or to use the default tests (first -pthread
then -lpthread) by not specifying FLAGS when passing --enable-pthreads.

Signed-off-by: Ben Walton <bwalton@artsci.utoronto.ca>
---
 configure.ac |   89 ++++++++++++++++++++++++++++++++++++++++++++++++----------
 1 files changed, 74 insertions(+), 15 deletions(-)

diff --git a/configure.ac b/configure.ac
index 6fe4bfe..4e728bc 100644
--- a/configure.ac
+++ b/configure.ac
@@ -127,6 +127,27 @@ if test -z "$lib"; then
    lib=lib
 fi
 
+AC_ARG_ENABLE([pthreads],
+ [AS_HELP_STRING([--enable-pthreads=FLAGS],
+  [FLAGS is the value to pass to the compiler to enable POSIX Threads.]
+  [The default if FLAGS is not specified is to try first -pthread]
+  [and then -lpthread.]
+  [--without-pthreads will disable threading.])],
+[
+if test "x$enableval" = "xyes"; then
+   AC_MSG_NOTICE([Will try -pthread then -lpthread to enable POSIX Threads])
+elif test "x$enableval" != "xno"; then
+   PTHREAD_CFLAGS=$enableval
+   AC_MSG_NOTICE([Setting '$PTHREAD_CFLAGS' as the FLAGS to enable POSIX Threads])
+else
+   AC_MSG_NOTICE([POSIX Threads will be disabled.])
+   NO_PTHREADS=YesPlease
+   USER_NOPTHREAD=1
+fi],
+[
+   AC_MSG_NOTICE([Will try -pthread then -lpthread to enable POSIX Threads.])
+])
+
 ## Site configuration (override autodetection)
 ## --with-PACKAGE[=ARG] and --without-PACKAGE
 AC_MSG_NOTICE([CHECKS for site configuration])
@@ -672,23 +693,61 @@ AC_SUBST(NO_MKDTEMP)
 #
 # Define PTHREAD_LIBS to the linker flag used for Pthread support and define
 # THREADED_DELTA_SEARCH if Pthreads are available.
-AC_LANG_CONFTEST([AC_LANG_PROGRAM(
-  [[#include <pthread.h>]],
-  [[pthread_mutex_t test_mutex;]]
-)])
-${CC} -pthread conftest.c -o conftest.o > /dev/null 2>&1
-if test $? -eq 0;then
- PTHREAD_LIBS="-pthread"
- THREADED_DELTA_SEARCH=YesPlease
+AC_DEFUN([PTHREADTEST_SRC], [
+#include <pthread.h>
+
+int main(void)
+{
+	pthread_mutex_t test_mutex;
+	return (0);
+}
+])
+
+dnl AC_LANG_CONFTEST([AC_LANG_PROGRAM(
+dnl   [[#include <pthread.h>]],
+dnl   [[pthread_mutex_t test_mutex;]]
+dnl )])
+
+NO_PTHREADS=UnfortunatelyYes
+THREADED_DELTA_SEARCH=
+PTHREAD_LIBS=
+
+if test -n "$USER_NOPTHREAD"; then
+   AC_MSG_NOTICE([Skipping POSIX Threads at user request.])
+# handle these separately since PTHREAD_CFLAGS could be '-lpthreads
+# -D_REENTRANT' or some such.
+elif test -z "$PTHREAD_CFLAGS"; then
+  for opt in -pthread -lpthread; do
+     old_CFLAGS="$CFLAGS"
+     CFLAGS="$opt $CFLAGS"
+     AC_MSG_CHECKING([Checking for POSIX Threads with '$opt'])
+     AC_LINK_IFELSE(PTHREADTEST_SRC,
+	[AC_MSG_RESULT([yes])
+		NO_PTHREADS=
+		PTHREAD_LIBS="$opt"
+		THREADED_DELTA_SEARCH=YesPlease
+		break
+	],
+	[AC_MSG_RESULT([no])])
+      CFLAGS="$old_CFLAGS"
+  done
 else
- ${CC} -lpthread conftest.c -o conftest.o > /dev/null 2>&1
- if test $? -eq 0;then
-  PTHREAD_LIBS="-lpthread"
-  THREADED_DELTA_SEARCH=YesPlease
- else
-  NO_PTHREADS=UnfortunatelyYes
- fi
+  old_CFLAGS="$CFLAGS"
+  CFLAGS="$PTHREAD_CFLAGS $CFLAGS"
+  AC_MSG_CHECKING([Checking for POSIX Threads with '$PTHREAD_CFLAGS'])
+  AC_LINK_IFELSE(PTHREADTEST_SRC,
+	[AC_MSG_RESULT([yes])
+		NO_PTHREADS=
+		PTHREAD_LIBS="$PTHREAD_CFLAGS"
+		THREADED_DELTA_SEARCH=YesPlease
+	],
+	[AC_MSG_RESULT([no])])
+
+  CFLAGS="$old_CFLAGS"
 fi
+
+CFLAGS="$old_CFLAGS"
+
 AC_SUBST(PTHREAD_LIBS)
 AC_SUBST(NO_PTHREADS)
 AC_SUBST(THREADED_DELTA_SEARCH)
-- 
1.6.0.5
