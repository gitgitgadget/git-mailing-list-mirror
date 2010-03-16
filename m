From: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
Subject: [patch 12/15] no-inet_ntop.patch
Date: Tue, 16 Mar 2010 05:42:32 +0000
Message-ID: <20100316054357.859059000@mlists.thewrittenword.com>
References: <20100316054220.075676000@mlists.thewrittenword.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 16 06:53:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrPiU-0002vN-H2
	for gcvg-git-2@lo.gmane.org; Tue, 16 Mar 2010 06:53:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933907Ab0CPFw7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Mar 2010 01:52:59 -0400
Received: from mail1.thewrittenword.com ([69.67.212.77]:54133 "EHLO
	mail1.thewrittenword.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757295Ab0CPFwz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Mar 2010 01:52:55 -0400
X-Greylist: delayed 599 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Mar 2010 01:52:55 EDT
Received: from mail1.il.thewrittenword.com (emma-internal-gw.il.thewrittenword.com [192.168.13.25])
	by mail1.thewrittenword.com (Postfix) with ESMTP id 152A15CDF
	for <git@vger.kernel.org>; Tue, 16 Mar 2010 06:03:20 +0000 (UTC)
X-DKIM: Sendmail DKIM Filter v2.4.4 mail1.thewrittenword.com 152A15CDF
Received: from akari.il.thewrittenword.com (akari.il.thewrittenword.com [10.191.57.57])
	by mail1.il.thewrittenword.com (Postfix) with ESMTP id 17429DE9;
	Tue, 16 Mar 2010 05:43:58 +0000 (UTC)
Received: by akari.il.thewrittenword.com (Postfix, from userid 1048)
	id F20F111D4D5; Tue, 16 Mar 2010 05:43:57 +0000 (UTC)
User-Agent: quilt/0.46-1
Content-Disposition: inline; filename=no-inet_ntop.patch
X-Virus-Scanned: clamav-milter 0.95.3 at maetel.il.thewrittenword.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142304>

Being careful not to overwrite the results of testing for hstrerror in
libresolv, also test whether inet_ntop/inet_pton are available from
that library.
---
 Makefile      |    6 ++++++
 config.mak.in |    2 ++
 configure.ac  |   38 ++++++++++++++++++++++++++++++--------
 3 files changed, 38 insertions(+), 8 deletions(-)

Index: b/Makefile
===================================================================
--- a/Makefile
+++ b/Makefile
@@ -939,6 +939,12 @@ ifeq ($(uname_S),HP-UX)
 	SNPRINTF_RETURNS_BOGUS = YesPlease
 	ifeq ($(uname_R),B.10.20)
 		NO_PREAD = YesPlease
+		NO_INET_NTOP = YesPlease
+		NO_INET_PTON = YesPlease
+	endif
+	ifeq ($(uname_R),B.11.00)
+		NO_INET_NTOP = YesPlease
+		NO_INET_PTON = YesPlease
 	endif
 	GIT_TEST_CMP = cmp
 endif
Index: b/configure.ac
===================================================================
--- a/configure.ac
+++ b/configure.ac
@@ -525,11 +525,33 @@ AC_SUBST(NEEDS_SOCKET)
 test -n "$NEEDS_SOCKET" && LIBS="$LIBS -lsocket"
 
 #
-# Define NEEDS_RESOLV if linking with -lnsl and/or -lsocket is not enough.
-# Notably on Solaris 7 inet_ntop and inet_pton additionally reside there.
-AC_CHECK_LIB([c], [inet_ntop],
-[NEEDS_RESOLV=],
-[NEEDS_RESOLV=YesPlease])
+# The next few tests will define NEEDS_RESOLV if linking with
+# libresolv provides some of the functions we would normally get
+# from libc.
+NEEDS_RESOLV=
+AC_SUBST(NEEDS_RESOLV)
+#
+# Define NO_INET_NTOP if linking with -lresolv is not enough.
+# Solaris 2.7 in particular hos inet_ntop in -lresolv.
+NO_INET_NTOP=
+AC_SUBST(NO_INET_NTOP)
+AC_CHECK_FUNC([inet_ntop],
+	[],
+    [AC_CHECK_LIB([resolv], [inet_ntop],
+	    [NEEDS_RESOLV=YesPlease],
+	[NO_INET_NTOP=YesPlease])
+])
+#
+# Define NO_INET_PTON if linking with -lresolv is not enough.
+# Solaris 2.7 in particular hos inet_pton in -lresolv.
+NO_INET_PTON=
+AC_SUBST(NO_INET_PTON)
+AC_CHECK_FUNC([inet_pton],
+	[],
+    [AC_CHECK_LIB([resolv], [inet_pton],
+	    [NEEDS_RESOLV=YesPlease],
+	[NO_INET_PTON=YesPlease])
+])
 #
 # Define NO_HSTRERROR if linking with -lresolv is not enough.
 # Solaris 2.6 in particular has no hstrerror, even in -lresolv.
@@ -541,8 +563,9 @@ AC_CHECK_FUNC([hstrerror],
 	[NO_HSTRERROR=YesPlease])
 ])
 AC_SUBST(NO_HSTRERROR)
-
-AC_SUBST(NEEDS_RESOLV)
+#
+# If any of the above tests determined that -lresolv is needed at
+# build-time, also set it here for remaining configure-time checks.
 test -n "$NEEDS_RESOLV" && LIBS="$LIBS -lresolv"
 
 AC_CHECK_LIB([c], [basename],
@@ -772,7 +795,6 @@ GIT_CHECK_FUNC(mkstemps,
 [NO_MKSTEMPS=YesPlease])
 AC_SUBST(NO_MKSTEMPS)
 #
-#
 # Define NO_MMAP if you want to avoid mmap.
 #
 # Define NO_ICONV if your libc does not properly support iconv.
Index: b/config.mak.in
===================================================================
--- a/config.mak.in
+++ b/config.mak.in
@@ -53,6 +53,8 @@ NO_SETENV=@NO_SETENV@
 NO_UNSETENV=@NO_UNSETENV@
 NO_MKDTEMP=@NO_MKDTEMP@
 NO_MKSTEMPS=@NO_MKSTEMPS@
+NO_INET_NTOP=@NO_INET_NTOP@
+NO_INET_PTON=@NO_INET_PTON@
 NO_ICONV=@NO_ICONV@
 OLD_ICONV=@OLD_ICONV@
 NO_DEFLATE_BOUND=@NO_DEFLATE_BOUND@

-- 
Gary V. Vaughan (gary@thewrittenword.com)
