From: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
Subject: [PATCH v5 03/18] Makefile: -lpthread may still be necessary when libc has only pthread stubs
Date: Fri, 14 May 2010 09:31:34 +0000
Message-ID: <20100514093736.227762000@mlists.thewrittenword.com>
References: <20100514093131.249094000@mlists.thewrittenword.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 14 11:37:51 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCrL5-0001bS-1x
	for gcvg-git-2@lo.gmane.org; Fri, 14 May 2010 11:37:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758715Ab0ENJhj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 May 2010 05:37:39 -0400
Received: from mail1.thewrittenword.com ([69.67.212.77]:64990 "EHLO
	mail1.thewrittenword.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754537Ab0ENJhh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 May 2010 05:37:37 -0400
Received: from mail1.il.thewrittenword.com (emma-internal-gw.il.thewrittenword.com [192.168.13.25])
	by mail1.thewrittenword.com (Postfix) with ESMTP id 89F885CC0
	for <git@vger.kernel.org>; Fri, 14 May 2010 09:54:28 +0000 (UTC)
X-DKIM: Sendmail DKIM Filter v2.4.4 mail1.thewrittenword.com 89F885CC0
Received: from akari.il.thewrittenword.com (akari.il.thewrittenword.com [10.191.57.57])
	by mail1.il.thewrittenword.com (Postfix) with ESMTP id 611FBCD4;
	Fri, 14 May 2010 09:37:36 +0000 (UTC)
Received: by akari.il.thewrittenword.com (Postfix, from userid 1048)
	id 56BDF11D4D1; Fri, 14 May 2010 09:37:36 +0000 (UTC)
User-Agent: quilt/0.46-1
Content-Disposition: inline; filename=pthread.patch
X-Virus-Scanned: clamav-milter 0.96 at maetel.il.thewrittenword.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147061>

Without this patch, systems that provide stubs for pthread functions
in libc, but which still require libpthread for full the pthread
implementation are not detected correctly.

Also, some systems require -pthread in CFLAGS for each compilation
unit for a successful link of an mt binary, which is also addressed by
this patch.

Signed-off-by: Gary V. Vaughan <gary@thewrittenword.com>
---
 Makefile      |    4 ++++
 config.mak.in |    1 +
 configure.ac  |   17 +++++++++++++++--
 3 files changed, 20 insertions(+), 2 deletions(-)

Index: b/Makefile
===================================================================
--- a/Makefile
+++ b/Makefile
@@ -294,6 +294,7 @@ RPMBUILD = rpmbuild
 TCL_PATH = tclsh
 TCLTK_PATH = wish
 PTHREAD_LIBS = -lpthread
+PTHREAD_CFLAGS =
 
 export TCL_PATH TCLTK_PATH
 
@@ -898,6 +899,8 @@ ifeq ($(uname_S),AIX)
 	BASIC_CFLAGS += -D_LARGE_FILES
 	ifeq ($(shell expr "$(uname_V)" : '[1234]'),1)
 		NO_PTHREADS = YesPlease
+	else
+		PTHREAD_LIBS = -lpthread
 	endif
 endif
 ifeq ($(uname_S),GNU)
@@ -1349,6 +1352,7 @@ endif
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
@@ -802,7 +802,11 @@ AC_DEFUN([PTHREADTEST_SRC], [
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
 
@@ -819,7 +823,8 @@ if test -n "$USER_NOPTHREAD"; then
 # handle these separately since PTHREAD_CFLAGS could be '-lpthreads
 # -D_REENTRANT' or some such.
 elif test -z "$PTHREAD_CFLAGS"; then
-  for opt in -pthread -lpthread; do
+  threads_found=no
+  for opt in -mt -pthread -lpthread; do
      old_CFLAGS="$CFLAGS"
      CFLAGS="$opt $CFLAGS"
      AC_MSG_CHECKING([Checking for POSIX Threads with '$opt'])
@@ -827,11 +832,18 @@ elif test -z "$PTHREAD_CFLAGS"; then
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
@@ -848,6 +860,7 @@ fi
 
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
