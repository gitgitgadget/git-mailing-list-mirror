From: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
Subject: [PATCH v5 11/18] Some platforms lack socklen_t type
Date: Fri, 14 May 2010 09:31:42 +0000
Message-ID: <20100514093817.727518000@mlists.thewrittenword.com>
References: <20100514093131.249094000@mlists.thewrittenword.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 14 11:38:33 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCrLh-0001z6-0n
	for gcvg-git-2@lo.gmane.org; Fri, 14 May 2010 11:38:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758801Ab0ENJiV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 May 2010 05:38:21 -0400
Received: from mail1.thewrittenword.com ([69.67.212.77]:64052 "EHLO
	mail1.thewrittenword.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758789Ab0ENJiT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 May 2010 05:38:19 -0400
Received: from mail1.il.thewrittenword.com (emma-internal-gw.il.thewrittenword.com [192.168.13.25])
	by mail1.thewrittenword.com (Postfix) with ESMTP id 32D805C71
	for <git@vger.kernel.org>; Fri, 14 May 2010 09:55:10 +0000 (UTC)
X-DKIM: Sendmail DKIM Filter v2.4.4 mail1.thewrittenword.com 32D805C71
Received: from akari.il.thewrittenword.com (akari.il.thewrittenword.com [10.191.57.57])
	by mail1.il.thewrittenword.com (Postfix) with ESMTP id E5336CD2;
	Fri, 14 May 2010 09:38:17 +0000 (UTC)
Received: by akari.il.thewrittenword.com (Postfix, from userid 1048)
	id D4F2B11D4D1; Fri, 14 May 2010 09:38:17 +0000 (UTC)
User-Agent: quilt/0.46-1
Content-Disposition: inline; filename=no-socklen_t.patch
X-Virus-Scanned: clamav-milter 0.96 at maetel.il.thewrittenword.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147069>

Some platforms do not have a socklen_t type declaration.

Signed-off-by: Gary V. Vaughan <gary@thewrittenword.com>
---
 Makefile      |    7 +++++++
 aclocal.m4    |   41 +++++++++++++++++++++++++++++++++++++++++
 config.mak.in |    1 +
 configure.ac  |    6 ++++++
 4 files changed, 55 insertions(+)

Index: b/Makefile
===================================================================
--- a/Makefile
+++ b/Makefile
@@ -8,6 +8,9 @@ all::
 # Define SANE_TOOL_PATH to a colon-separated list of paths to prepend
 # to PATH if your tools in /usr/bin are broken.
 #
+# Define SOCKLEN_T to a suitable type (such as 'size_t') if your
+# system headers do not define a socklen_t type.
+#
 # Define SNPRINTF_RETURNS_BOGUS if your are on a system which snprintf()
 # or vsnprintf() return -1 instead of number of characters which would
 # have been written to the final string if enough space had been available.
@@ -1087,6 +1090,10 @@ else
 BROKEN_PATH_FIX = '/^\# @@BROKEN_PATH_FIX@@$$/d'
 endif
 
+ifneq (,$(SOCKLEN_T))
+	BASIC_CFLAGS += -Dsocklen_t=$(SOCKLEN_T)
+endif
+
 ifeq ($(uname_S),Darwin)
 	ifndef NO_FINK
 		ifeq ($(shell test -d /sw/lib && echo y),y)
Index: b/configure.ac
===================================================================
--- a/configure.ac
+++ b/configure.ac
@@ -633,6 +633,12 @@ AC_SUBST(OLD_ICONV)
 ## Checks for typedefs, structures, and compiler characteristics.
 AC_MSG_NOTICE([CHECKS for typedefs, structures, and compiler characteristics])
 #
+TYPE_SOCKLEN_T
+case $ac_cv_type_socklen_t in
+  yes)	;;
+  *)  	AC_SUBST([SOCKLEN_T], [$git_cv_socklen_t_equiv]) ;;
+esac
+
 # Define NO_D_INO_IN_DIRENT if you don't have d_ino in your struct dirent.
 AC_CHECK_MEMBER(struct dirent.d_ino,
 [NO_D_INO_IN_DIRENT=],
Index: b/config.mak.in
===================================================================
--- a/config.mak.in
+++ b/config.mak.in
@@ -58,6 +58,7 @@ NO_INET_PTON=@NO_INET_PTON@
 NO_ICONV=@NO_ICONV@
 OLD_ICONV=@OLD_ICONV@
 NO_DEFLATE_BOUND=@NO_DEFLATE_BOUND@
+SOCKLEN_T=@SOCKLEN_T@
 FREAD_READS_DIRECTORIES=@FREAD_READS_DIRECTORIES@
 SNPRINTF_RETURNS_BOGUS=@SNPRINTF_RETURNS_BOGUS@
 NO_PTHREADS=@NO_PTHREADS@
Index: b/aclocal.m4
===================================================================
--- /dev/null
+++ b/aclocal.m4
@@ -0,0 +1,41 @@
+dnl Check for socklen_t: historically on BSD it is an int, and in
+dnl POSIX 1g it is a type of its own, but some platforms use different
+dnl types for the argument to getsockopt, getpeername, etc.  So we
+dnl have to test to find something that will work.
+AC_DEFUN([TYPE_SOCKLEN_T],
+[
+   AC_CHECK_TYPE([socklen_t], ,[
+      AC_MSG_CHECKING([for socklen_t equivalent])
+      AC_CACHE_VAL([git_cv_socklen_t_equiv],
+      [
+         # Systems have either "struct sockaddr *" or
+         # "void *" as the second argument to getpeername
+         git_cv_socklen_t_equiv=
+         for arg2 in "struct sockaddr" void; do
+            for t in int size_t unsigned long "unsigned long"; do
+               AC_TRY_COMPILE([
+                  #include <sys/types.h>
+                  #include <sys/socket.h>
+
+                  int getpeername (int, $arg2 *, $t *);
+               ],[
+                  $t len;
+                  getpeername(0,0,&len);
+               ],[
+                  git_cv_socklen_t_equiv="$t"
+                  break 2
+               ])
+            done
+         done
+
+         if test "x$git_cv_socklen_t_equiv" = x; then
+            AC_MSG_ERROR([Cannot find a type to use in place of socklen_t])
+         fi
+      ])
+      AC_MSG_RESULT($git_cv_socklen_t_equiv)
+      AC_DEFINE_UNQUOTED(socklen_t, $git_cv_socklen_t_equiv,
+			[type to use in place of socklen_t if not defined])],
+      [#include <sys/types.h>
+#include <sys/socket.h>])
+])
+

-- 
Gary V. Vaughan (gary@thewrittenword.com)
