From: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
Subject: [patch 15/16] no-socklen_t.patch
Date: Tue, 27 Apr 2010 13:57:23 +0000
Message-ID: <20100427135919.955263000@mlists.thewrittenword.com>
References: <20100427135708.258636000@mlists.thewrittenword.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 27 16:00:10 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6lKZ-0003LI-RO
	for gcvg-git-2@lo.gmane.org; Tue, 27 Apr 2010 16:00:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756056Ab0D0N7W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Apr 2010 09:59:22 -0400
Received: from mail1.thewrittenword.com ([69.67.212.77]:52874 "EHLO
	mail1.thewrittenword.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755801Ab0D0N7U (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Apr 2010 09:59:20 -0400
Received: from mail1.il.thewrittenword.com (emma-internal-gw.il.thewrittenword.com [192.168.13.25])
	by mail1.thewrittenword.com (Postfix) with ESMTP id EB8445CD7
	for <git@vger.kernel.org>; Tue, 27 Apr 2010 14:20:27 +0000 (UTC)
X-DKIM: Sendmail DKIM Filter v2.4.4 mail1.thewrittenword.com EB8445CD7
Received: from akari.il.thewrittenword.com (akari.il.thewrittenword.com [10.191.57.57])
	by mail1.il.thewrittenword.com (Postfix) with ESMTP id 2397DACB;
	Tue, 27 Apr 2010 13:59:20 +0000 (UTC)
Received: by akari.il.thewrittenword.com (Postfix, from userid 1048)
	id 19FC211D4D1; Tue, 27 Apr 2010 13:59:20 +0000 (UTC)
User-Agent: quilt/0.46-1
Content-Disposition: inline; filename=no-socklen_t.patch
X-Virus-Scanned: clamav-milter 0.96 at maetel.il.thewrittenword.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145915>

SunOS 2.6 and earlier do not have a socklen_t type declaration.
---
 Makefile      |   10 ++++++++++
 aclocal.m4    |   41 +++++++++++++++++++++++++++++++++++++++++
 config.mak.in |    1 +
 configure.ac  |    6 ++++++
 4 files changed, 58 insertions(+)

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
@@ -737,6 +740,7 @@ EXTLIBS =
 ifeq ($(uname_S),OSF1)
 	# Need this for u_short definitions et al
 	BASIC_CFLAGS += -D_OSF_SOURCE
+	SOCKLEN_T = int
 	NO_STRTOULL = YesPlease
 	NO_NSEC = YesPlease
 endif
@@ -813,6 +817,7 @@ ifeq ($(uname_S),SunOS)
 	NO_MKSTEMPS = YesPlease
 	NO_REGEX = YesPlease
 	ifeq ($(uname_R),5.6)
+		SOCKLEN_T = int
 		NO_HSTRERROR = YesPlease
 		NO_IPV6 = YesPlease
 		NO_SOCKADDR_STORAGE = YesPlease
@@ -980,6 +985,7 @@ ifeq ($(uname_S),HP-UX)
 	NO_NSEC = YesPlease
 	SNPRINTF_RETURNS_BOGUS = YesPlease
 	ifeq ($(uname_R),B.10.20)
+		SOCKLEN_T = size_t
 		NO_PREAD = YesPlease
 		NO_INET_NTOP = YesPlease
 		NO_INET_PTON = YesPlease
@@ -1114,6 +1120,10 @@ else
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
