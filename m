From: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
Subject: [patch 03/15] pthread.patch
Date: Tue, 16 Mar 2010 05:42:23 +0000
Message-ID: <20100316054311.332443000@mlists.thewrittenword.com>
References: <20100316054220.075676000@mlists.thewrittenword.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 16 06:53:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrPiX-0002vN-Ba
	for gcvg-git-2@lo.gmane.org; Tue, 16 Mar 2010 06:53:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964969Ab0CPFxL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Mar 2010 01:53:11 -0400
Received: from mail1.thewrittenword.com ([69.67.212.77]:57185 "EHLO
	mail1.thewrittenword.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757481Ab0CPFw5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Mar 2010 01:52:57 -0400
Received: from mail1.il.thewrittenword.com (emma-internal-gw.il.thewrittenword.com [192.168.13.25])
	by mail1.thewrittenword.com (Postfix) with ESMTP id 774075CC9
	for <git@vger.kernel.org>; Tue, 16 Mar 2010 06:02:33 +0000 (UTC)
X-DKIM: Sendmail DKIM Filter v2.4.4 mail1.thewrittenword.com 774075CC9
Received: from akari.il.thewrittenword.com (akari.il.thewrittenword.com [10.191.57.57])
	by mail1.il.thewrittenword.com (Postfix) with ESMTP id 80255DE9;
	Tue, 16 Mar 2010 05:43:11 +0000 (UTC)
Received: by akari.il.thewrittenword.com (Postfix, from userid 1048)
	id 749D111D4D5; Tue, 16 Mar 2010 05:43:11 +0000 (UTC)
User-Agent: quilt/0.46-1
Content-Disposition: inline; filename=pthread.patch
X-Virus-Scanned: clamav-milter 0.95.3 at maetel.il.thewrittenword.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142306>

Without this patch, systems that provide stubs for pthread functions
in libc, but which still require libpthread for full the pthread
implementation are not detected correctly.

Also, some systems require -pthread in CFLAGS for each compilation
unit for a successful link of an mt binary, which is also addressed by
this patch.
---
 Makefile      |    4 ++++
 config.mak.in |    1 +
 configure.ac  |   17 +++++++++++++++--
 3 files changed, 20 insertions(+), 2 deletions(-)

Index: b/Makefile
===================================================================
--- a/Makefile
+++ b/Makefile
@@ -287,6 +287,7 @@ RPMBUILD = rpmbuild
 TCL_PATH = tclsh
 TCLTK_PATH = wish
 PTHREAD_LIBS = -lpthread
+PTHREAD_CFLAGS =
 
 export TCL_PATH TCLTK_PATH
 
@@ -856,6 +857,8 @@ ifeq ($(uname_S),AIX)
 	BASIC_CFLAGS += -D_LARGE_FILES
 	ifeq ($(shell expr "$(uname_V)" : '[1234]'),1)
 		NO_PTHREADS = YesPlease
+	else
+		PTHREAD_LIBS = -lpthread
 	endif
 endif
 ifeq ($(uname_S),GNU)
@@ -1297,6 +1300,7 @@ endif
 ifdef NO_PTHREADS
 	BASIC_CFLAGS += -DNO_PTHREADS
 else
+	BASIC_CFLAGS += $(PTHREAD_CFLAGS)
 	EXTLIBS += $(PTHREAD_LIBS)
 	LIB_OBJS += thread-utils.o
 endif
Index: b/configure.ac
===================================================================
--- a/configure.ac
+++ b/configure.ac
@@ -782,7 +782,11 @@ AC_DEFUN([PTHREADTEST_SRC], [
 int main(void)
 {
 	pthread_mutex_t test_mutex;
-	return (0);
+	int retcode = 0;
+	retcode |= pthread_mutex_init(&test_mutex,(void*)0);
+	retcode |= pthread_mutex_lock(&test_mutex);
+	retcode |= pthread_mutex_unlock(&test_mutex);
+	return retcode;
 }
 ])
 
@@ -799,7 +803,8 @@ if test -n "$USER_NOPTHREAD"; then
 # handle these separately since PTHREAD_CFLAGS could be '-lpthreads
 # -D_REENTRANT' or some such.
 elif test -z "$PTHREAD_CFLAGS"; then
-  for opt in -pthread -lpthread; do
+  threads_found=no
+  for opt in -mt -pthread -lpthread; do
      old_CFLAGS="$CFLAGS"
      CFLAGS="$opt $CFLAGS"
      AC_MSG_CHECKING([Checking for POSIX Threads with '$opt'])
@@ -807,11 +812,18 @@ elif test -z "$PTHREAD_CFLAGS"; then
 	[AC_MSG_RESULT([yes])
 		NO_PTHREADS=
 		PTHREAD_LIBS="$opt"
+		PTHREAD_CFLAGS="$opt"
+		threads_found=yes
 		break
 	],
 	[AC_MSG_RESULT([no])])
       CFLAGS="$old_CFLAGS"
   done
+  if test $threads_found != yes; then
+    AC_CHECK_LIB([pthread], [pthread_create],
+	[PTHREAD_LIBS="-lpthread"],
+	[NO_PTHREADS=UnfortunatelyYes])
+  fi
 else
   old_CFLAGS="$CFLAGS"
   CFLAGS="$PTHREAD_CFLAGS $CFLAGS"
@@ -828,6 +840,7 @@ fi
 
 CFLAGS="$old_CFLAGS"
 
+AC_SUBST(PTHREAD_CFLAGS)
 AC_SUBST(PTHREAD_LIBS)
 AC_SUBST(NO_PTHREADS)
 
Index: b/config.mak.in
===================================================================
--- a/config.mak.in
+++ b/config.mak.in
@@ -57,4 +57,5 @@ NO_DEFLATE_BOUND=@NO_DEFLATE_BOUND@
 FREAD_READS_DIRECTORIES=@FREAD_READS_DIRECTORIES@
 SNPRINTF_RETURNS_BOGUS=@SNPRINTF_RETURNS_BOGUS@
 NO_PTHREADS=@NO_PTHREADS@
+PTHREAD_CFLAGS=@PTHREAD_CFLAGS@
 PTHREAD_LIBS=@PTHREAD_LIBS@

-- 
Gary V. Vaughan (gary@thewrittenword.com)
