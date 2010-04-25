From: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
Subject: Re: [patch 13/15] no-socklen_t.patch
Date: Sun, 25 Apr 2010 03:39:55 -0500 (CDT)
Message-ID: <20100316092122.GF26540@thor.il.thewrittenword.com>
References: <20100316054220.075676000@mlists.thewrittenword.com>
 <20100316054403.034575000@mlists.thewrittenword.com>
 <7vzl28lodo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 25 10:40:34 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5xOD-0007Yx-PE
	for gcvg-git-2@lo.gmane.org; Sun, 25 Apr 2010 10:40:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752688Ab0DYIj5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Apr 2010 04:39:57 -0400
Received: from mail1.thewrittenword.com ([69.67.212.77]:63453 "EHLO
	mail1.thewrittenword.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752653Ab0DYIj4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Apr 2010 04:39:56 -0400
Received: from mail1.il.thewrittenword.com (emma-internal-gw.il.thewrittenword.com [192.168.13.25])
	by mail1.thewrittenword.com (Postfix) with ESMTP id E3E645CED
	for <git@vger.kernel.org>; Sun, 25 Apr 2010 09:00:57 +0000 (UTC)
X-DKIM: Sendmail DKIM Filter v2.4.4 mail1.thewrittenword.com E3E645CED
Received: from localhost.localdomain (unknown [192.168.1.254])
	by mail1.il.thewrittenword.com (Postfix) with ESMTP id 89A3FA47
	for <git@vger.kernel.org>; Sun, 25 Apr 2010 08:39:55 +0000 (UTC)
Received: by localhost.localdomain (Postfix, from userid 1000)
	id 4AF2E57C; Sun, 25 Apr 2010 03:39:55 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <7vzl28lodo.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Scanned: clamav-milter 0.96 at maetel.il.thewrittenword.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145731>

On Tue, Mar 16, 2010 at 12:25:07AM -0700, Junio C Hamano wrote:
> "Gary V. Vaughan" <git@mlists.thewrittenword.com> writes:
> 
> > +ifneq (socklen_t,$(SOCKLEN_T))
> > +	BASIC_CFLAGS += -Dsocklen_t=$(SOCKLEN_T)
> > +endif
> 
> This looks like making use of configure mandatory to me?  Could you do
> this patch without doing so?
Sure.

SunOS 2.6 and earlier, HP-UX 10.20 and OSF1 do not have a socklen_t type
declaration.
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
@@ -698,6 +701,7 @@ EXTLIBS =
 ifeq ($(uname_S),OSF1)
 	# Need this for u_short definitions et al
 	BASIC_CFLAGS += -D_OSF_SOURCE
+	SOCKLEN_T = int
 	NO_STRTOULL = YesPlease
 	NO_NSEC = YesPlease
 endif
@@ -774,6 +778,7 @@ ifeq ($(uname_S),SunOS)
 	NO_MKSTEMPS = YesPlease
 	NO_REGEX = YesPlease
 	ifeq ($(uname_R),5.6)
+		SOCKLEN_T = int
 		NO_HSTRERROR = YesPlease
 		NO_IPV6 = YesPlease
 		NO_SOCKADDR_STORAGE = YesPlease
@@ -938,6 +943,7 @@ ifeq ($(uname_S),HP-UX)
 	NO_NSEC = YesPlease
 	SNPRINTF_RETURNS_BOGUS = YesPlease
 	ifeq ($(uname_R),B.10.20)
+		SOCKLEN_T = size_t
 		NO_PREAD = YesPlease
 		NO_INET_NTOP = YesPlease
 		NO_INET_PTON = YesPlease
@@ -1064,6 +1070,10 @@ else
 BROKEN_PATH_FIX = '/^\# @@BROKEN_PATH_FIX@@$$/d'
 endif
 
+ifeq (,$(SOCKLEN_T)
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
@@ -613,6 +613,12 @@ AC_SUBST(OLD_ICONV)
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
Cheeers,
-- 
Gary V. Vaughan (gary@thewrittenword.com)
