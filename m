From: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
Subject: [patch 11/15] no-hstrerror.patch
Date: Tue, 16 Mar 2010 05:42:31 +0000
Message-ID: <20100316054352.704479000@mlists.thewrittenword.com>
References: <20100316054220.075676000@mlists.thewrittenword.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 16 06:54:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrPjM-00038F-I4
	for gcvg-git-2@lo.gmane.org; Tue, 16 Mar 2010 06:54:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965022Ab0CPFxb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Mar 2010 01:53:31 -0400
Received: from mail1.thewrittenword.com ([69.67.212.77]:53535 "EHLO
	mail1.thewrittenword.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757621Ab0CPFw6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Mar 2010 01:52:58 -0400
Received: from mail1.il.thewrittenword.com (emma-internal-gw.il.thewrittenword.com [192.168.13.25])
	by mail1.thewrittenword.com (Postfix) with ESMTP id C8AC15CDD
	for <git@vger.kernel.org>; Tue, 16 Mar 2010 06:03:14 +0000 (UTC)
X-DKIM: Sendmail DKIM Filter v2.4.4 mail1.thewrittenword.com C8AC15CDD
Received: from akari.il.thewrittenword.com (akari.il.thewrittenword.com [10.191.57.57])
	by mail1.il.thewrittenword.com (Postfix) with ESMTP id D423DDE8;
	Tue, 16 Mar 2010 05:43:52 +0000 (UTC)
Received: by akari.il.thewrittenword.com (Postfix, from userid 1048)
	id CC83611D4D5; Tue, 16 Mar 2010 05:43:52 +0000 (UTC)
User-Agent: quilt/0.46-1
Content-Disposition: inline; filename=no-hstrerror.patch
X-Virus-Scanned: clamav-milter 0.95.3 at maetel.il.thewrittenword.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142313>

SunOS 5.6 and 5.5.1 do not have hstrerror, even in libresolv.

This patch improves the logic of the test for hstrerror, not to
blindly assume that if there is no hstrerror in libc that it must
exist in libresolv.
---
 Makefile      |    1 +
 config.mak.in |    1 +
 configure.ac  |   17 ++++++++++++++---
 3 files changed, 16 insertions(+), 3 deletions(-)

Index: b/configure.ac
===================================================================
--- a/configure.ac
+++ b/configure.ac
@@ -526,11 +526,22 @@ test -n "$NEEDS_SOCKET" && LIBS="$LIBS -
 
 #
 # Define NEEDS_RESOLV if linking with -lnsl and/or -lsocket is not enough.
-# Notably on Solaris hstrerror resides in libresolv and on Solaris 7
-# inet_ntop and inet_pton additionally reside there.
-AC_CHECK_LIB([c], [hstrerror],
+# Notably on Solaris 7 inet_ntop and inet_pton additionally reside there.
+AC_CHECK_LIB([c], [inet_ntop],
 [NEEDS_RESOLV=],
 [NEEDS_RESOLV=YesPlease])
+#
+# Define NO_HSTRERROR if linking with -lresolv is not enough.
+# Solaris 2.6 in particular has no hstrerror, even in -lresolv.
+NO_HSTRERROR=
+AC_CHECK_FUNC([hstrerror],
+	[],
+    [AC_CHECK_LIB([resolv], [hstrerror],
+	    [NEEDS_RESOLV=YesPlease],
+	[NO_HSTRERROR=YesPlease])
+])
+AC_SUBST(NO_HSTRERROR)
+
 AC_SUBST(NEEDS_RESOLV)
 test -n "$NEEDS_RESOLV" && LIBS="$LIBS -lresolv"
 
Index: b/Makefile
===================================================================
--- a/Makefile
+++ b/Makefile
@@ -774,6 +774,7 @@ ifeq ($(uname_S),SunOS)
 	NO_MKSTEMPS = YesPlease
 	NO_REGEX = YesPlease
 	ifeq ($(uname_R),5.6)
+		NO_HSTRERROR = YesPlease
 		NO_IPV6 = YesPlease
 		NO_SOCKADDR_STORAGE = YesPlease
 		NO_UNSETENV = YesPlease
Index: b/config.mak.in
===================================================================
--- a/config.mak.in
+++ b/config.mak.in
@@ -43,6 +43,7 @@ NO_D_TYPE_IN_DIRENT=@NO_D_TYPE_IN_DIRENT
 NO_SOCKADDR_STORAGE=@NO_SOCKADDR_STORAGE@
 NO_IPV6=@NO_IPV6@
 NO_C99_FORMAT=@NO_C99_FORMAT@
+NO_HSTRERROR=@NO_HSTRERROR@
 NO_STRCASESTR=@NO_STRCASESTR@
 NO_MEMMEM=@NO_MEMMEM@
 NO_STRLCPY=@NO_STRLCPY@

-- 
Gary V. Vaughan (gary@thewrittenword.com)
