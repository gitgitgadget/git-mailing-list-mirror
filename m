From: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
Subject: [patch 14/15] no-ss_family.patch
Date: Tue, 16 Mar 2010 05:42:34 +0000
Message-ID: <20100316054408.187068000@mlists.thewrittenword.com>
References: <20100316054220.075676000@mlists.thewrittenword.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 16 06:53:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrPiV-0002vN-3B
	for gcvg-git-2@lo.gmane.org; Tue, 16 Mar 2010 06:53:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935279Ab0CPFxE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Mar 2010 01:53:04 -0400
Received: from mail1.thewrittenword.com ([69.67.212.77]:50833 "EHLO
	mail1.thewrittenword.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757361Ab0CPFwz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Mar 2010 01:52:55 -0400
Received: from mail1.il.thewrittenword.com (emma-internal-gw.il.thewrittenword.com [192.168.13.25])
	by mail1.thewrittenword.com (Postfix) with ESMTP id 586E25CE3
	for <git@vger.kernel.org>; Tue, 16 Mar 2010 06:03:30 +0000 (UTC)
X-DKIM: Sendmail DKIM Filter v2.4.4 mail1.thewrittenword.com 586E25CE3
Received: from akari.il.thewrittenword.com (akari.il.thewrittenword.com [10.191.57.57])
	by mail1.il.thewrittenword.com (Postfix) with ESMTP id 6284EDE8;
	Tue, 16 Mar 2010 05:44:08 +0000 (UTC)
Received: by akari.il.thewrittenword.com (Postfix, from userid 1048)
	id 59D8611D4D5; Tue, 16 Mar 2010 05:44:08 +0000 (UTC)
User-Agent: quilt/0.46-1
Content-Disposition: inline; filename=no-ss_family.patch
X-Virus-Scanned: clamav-milter 0.95.3 at maetel.il.thewrittenword.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142305>

Systems that do not provide ss_family in sockaddr_storage do not compile.

This patch adds a configure test, and a new Makefile define along with
default settings for HPUX-11.00, Solaris-2.6 and others.

I've also added a configure test to set NO_SOCKADDR_STORAGE
appropriately, rather than relying on the default settings in
Makefile.
---
 Makefile      |   15 +++++++++++++++
 config.mak.in |    1 +
 configure.ac  |   17 +++++++++++++++++
 daemon.c      |   31 ++++++++++++++++++++-----------
 4 files changed, 53 insertions(+), 11 deletions(-)

Index: b/daemon.c
===================================================================
--- a/daemon.c
+++ b/daemon.c
@@ -591,19 +591,28 @@ static int execute(struct sockaddr *addr
 static int addrcmp(const struct sockaddr_storage *s1,
     const struct sockaddr_storage *s2)
 {
-	if (s1->ss_family != s2->ss_family)
-		return s1->ss_family - s2->ss_family;
-	if (s1->ss_family == AF_INET)
-		return memcmp(&((struct sockaddr_in *)s1)->sin_addr,
-		    &((struct sockaddr_in *)s2)->sin_addr,
-		    sizeof(struct in_addr));
+#ifndef NO_SS_FAMILY_IN_SOCKADDR_X
+	sa_family_t family = s1->ss_family;
+	sa_family_t family2 = s2->ss_family;
+#else
+	sa_family_t family = ((struct sockaddr *)s1)->sa_family;
+	sa_family_t family2 = ((struct sockaddr *)s2)->sa_family;
+#endif
+
+        if (family != family2)
+                return family - family2;
+        if (family == AF_INET)
+                return memcmp(&((struct sockaddr_in *)s1)->sin_addr,
+                    &((struct sockaddr_in *)s2)->sin_addr,
+                    sizeof(struct in_addr));
 #ifndef NO_IPV6
-	if (s1->ss_family == AF_INET6)
-		return memcmp(&((struct sockaddr_in6 *)s1)->sin6_addr,
-		    &((struct sockaddr_in6 *)s2)->sin6_addr,
-		    sizeof(struct in6_addr));
+        if (family == AF_INET6)
+                return memcmp(&((struct sockaddr_in6 *)s1)->sin6_addr,
+                    &((struct sockaddr_in6 *)s2)->sin6_addr,
+                    sizeof(struct in6_addr));
 #endif
-	return 0;
+
+        return 0;
 }
 
 static int max_connections = 32;
Index: b/Makefile
===================================================================
--- a/Makefile
+++ b/Makefile
@@ -122,6 +122,9 @@ all::
 # Define NO_SOCKADDR_STORAGE if your platform does not have struct
 # sockaddr_storage.
 #
+# Define NO_SS_FAMILY_IN_SOCKADDR_X if your platform lacks ss_family
+# in sockaddr_storage, sockaddr_in and sockaddr_in6.
+#
 # Define NO_ICONV if your libc does not properly support iconv.
 #
 # Define OLD_ICONV if your library has an old iconv(), where the second
@@ -700,6 +703,7 @@ ifeq ($(uname_S),OSF1)
 	BASIC_CFLAGS += -D_OSF_SOURCE
 	NO_STRTOULL = YesPlease
 	NO_NSEC = YesPlease
+	NO_SS_FAMILY_IN_SOCKADDR_X = YesPlease
 endif
 ifeq ($(uname_S),Linux)
 	NO_STRLCPY = YesPlease
@@ -777,6 +781,7 @@ ifeq ($(uname_S),SunOS)
 		NO_HSTRERROR = YesPlease
 		NO_IPV6 = YesPlease
 		NO_SOCKADDR_STORAGE = YesPlease
+		NO_SS_FAMILY_IN_SOCKADDR_X = YesPlease
 		NO_UNSETENV = YesPlease
 		NO_SETENV = YesPlease
 		NO_STRLCPY = YesPlease
@@ -788,6 +793,7 @@ ifeq ($(uname_S),SunOS)
 		NEEDS_RESOLV = YesPlease
 		NO_IPV6 = YesPlease
 		NO_SOCKADDR_STORAGE = YesPlease
+		NO_SS_FAMILY_IN_SOCKADDR_X = YesPlease
 		NO_UNSETENV = YesPlease
 		NO_SETENV = YesPlease
 		NO_STRLCPY = YesPlease
@@ -847,6 +853,9 @@ ifeq ($(uname_S),FreeBSD)
 		NO_UINTMAX_T = YesPlease
 		NO_STRTOUMAX = YesPlease
 	endif
+	ifeq ($(shell expr "$(uname_V).$(uname_R)" : '5\.[012]'),3)
+		NO_SS_FAMILY_IN_SOCKADDR_X = YesPlease
+	endif
 endif
 ifeq ($(uname_S),OpenBSD)
 	NO_STRCASESTR = YesPlease
@@ -895,6 +904,7 @@ ifeq ($(uname_S),IRIX)
 	NO_MEMMEM = YesPlease
 	NO_MKSTEMPS = YesPlease
 	NO_MKDTEMP = YesPlease
+	NO_SS_FAMILY_IN_SOCKADDR_X = YesPlease
 	# When compiled with the MIPSpro 7.4.4m compiler, and without pthreads
 	# (i.e. NO_PTHREADS is set), and _with_ MMAP (i.e. NO_MMAP is not set),
 	# git dies with a segmentation fault when trying to access the first
@@ -941,10 +951,12 @@ ifeq ($(uname_S),HP-UX)
 		NO_PREAD = YesPlease
 		NO_INET_NTOP = YesPlease
 		NO_INET_PTON = YesPlease
+		NO_SS_FAMILY_IN_SOCKADDR_X = YesPlease
 	endif
 	ifeq ($(uname_R),B.11.00)
 		NO_INET_NTOP = YesPlease
 		NO_INET_PTON = YesPlease
+		NO_SS_FAMILY_IN_SOCKADDR_X = YesPlease
 	endif
 	GIT_TEST_CMP = cmp
 endif
@@ -1284,6 +1296,9 @@ else
 	BASIC_CFLAGS += -Dsockaddr_storage=sockaddr_in6
 endif
 endif
+ifdef NO_SS_FAMILY_IN_SOCKADDR_X
+	BASIC_CFLAGS += -DNO_SS_FAMILY_IN_SOCKADDR_X
+endif
 ifdef NO_INET_NTOP
 	LIB_OBJS += compat/inet_ntop.o
 endif
Index: b/config.mak.in
===================================================================
--- a/config.mak.in
+++ b/config.mak.in
@@ -42,6 +42,7 @@ NO_D_INO_IN_DIRENT=@NO_D_INO_IN_DIRENT@
 NO_D_TYPE_IN_DIRENT=@NO_D_TYPE_IN_DIRENT@
 NO_SOCKADDR_STORAGE=@NO_SOCKADDR_STORAGE@
 NO_IPV6=@NO_IPV6@
+NO_SS_FAMILY_IN_SOCKADDR_X=@NO_SS_FAMILY_IN_SOCKADDR_X@
 NO_C99_FORMAT=@NO_C99_FORMAT@
 NO_HSTRERROR=@NO_HSTRERROR@
 NO_STRCASESTR=@NO_STRCASESTR@
Index: b/configure.ac
===================================================================
--- a/configure.ac
+++ b/configure.ac
@@ -656,6 +656,23 @@ AC_CHECK_TYPE([struct addrinfo],[
 ])
 AC_SUBST(NO_IPV6)
 #
+# Define NO_SS_FAMILY_IN_SOCKADDR_X if your platform lacks ss_family
+# in struct sockaddr_storage, sockaddr_in6 and sockaddr_in.
+save_CPPFLAGS="$CPPFLAGS"
+case $NO_SOCKADDR_STORAGE:$NO_IPV6 in
+YesPlease:YesPlease)
+  CPPFLAGS="-Dsockaddr_storage=sockaddr_in${CPPFLAGS+ $CPPFLAGS}" ;;
+YesPlease:)
+  CPPFLAGS="-Dsockaddr_storage=sockaddr_in6${CPPFLAGS+ $CPPFLAGS}" ;;
+esac
+AC_CHECK_MEMBER(struct sockaddr_storage.ss_family,
+[NO_SS_FAMILY_IN_SOCKADDR_X=],
+[NO_SS_FAMILY_IN_SOCKADDR_X=YesPlease],[
+#include <sys/types.h>
+#include <sys/socket.h>
+])
+AC_SUBST(NO_SS_FAMILY_IN_SOCKADDR_X)
+#
 # Define NO_C99_FORMAT if your formatted IO functions (printf/scanf et.al.)
 # do not support the 'size specifiers' introduced by C99, namely ll, hh,
 # j, z, t. (representing long long int, char, intmax_t, size_t, ptrdiff_t).

-- 
Gary V. Vaughan (gary@thewrittenword.com)
