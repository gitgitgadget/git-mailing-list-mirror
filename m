From: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
Subject: [patch 14/16] no-inet_ntop.patch
Date: Tue, 27 Apr 2010 13:57:22 +0000
Message-ID: <20100427135914.801944000@mlists.thewrittenword.com>
References: <20100427135708.258636000@mlists.thewrittenword.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 27 16:00:16 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6lKZ-0003LI-9o
	for gcvg-git-2@lo.gmane.org; Tue, 27 Apr 2010 16:00:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756051Ab0D0N7S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Apr 2010 09:59:18 -0400
Received: from mail1.thewrittenword.com ([69.67.212.77]:61326 "EHLO
	mail1.thewrittenword.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755801Ab0D0N7P (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Apr 2010 09:59:15 -0400
Received: from mail1.il.thewrittenword.com (emma-internal-gw.il.thewrittenword.com [192.168.13.25])
	by mail1.thewrittenword.com (Postfix) with ESMTP id A71275CDB
	for <git@vger.kernel.org>; Tue, 27 Apr 2010 14:20:22 +0000 (UTC)
X-DKIM: Sendmail DKIM Filter v2.4.4 mail1.thewrittenword.com A71275CDB
Received: from akari.il.thewrittenword.com (akari.il.thewrittenword.com [10.191.57.57])
	by mail1.il.thewrittenword.com (Postfix) with ESMTP id EBEC1ADC;
	Tue, 27 Apr 2010 13:59:14 +0000 (UTC)
Received: by akari.il.thewrittenword.com (Postfix, from userid 1048)
	id E15C711D4D1; Tue, 27 Apr 2010 13:59:14 +0000 (UTC)
User-Agent: quilt/0.46-1
Content-Disposition: inline; filename=no-inet_ntop.patch
X-Virus-Scanned: clamav-milter 0.96 at maetel.il.thewrittenword.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145918>

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
@@ -981,6 +981,12 @@ ifeq ($(uname_S),HP-UX)
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
@@ -545,11 +545,33 @@ AC_SUBST(NEEDS_SOCKET)
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
@@ -561,8 +583,9 @@ AC_CHECK_FUNC([hstrerror],
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
@@ -792,7 +815,6 @@ GIT_CHECK_FUNC(mkstemps,
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
