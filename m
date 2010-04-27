From: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
Subject: [patch 13/16] no-hstrerror.patch
Date: Tue, 27 Apr 2010 13:57:21 +0000
Message-ID: <20100427135909.635880000@mlists.thewrittenword.com>
References: <20100427135708.258636000@mlists.thewrittenword.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 27 16:00:11 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6lKY-0003LI-O5
	for gcvg-git-2@lo.gmane.org; Tue, 27 Apr 2010 16:00:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756046Ab0D0N7M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Apr 2010 09:59:12 -0400
Received: from mail1.thewrittenword.com ([69.67.212.77]:63676 "EHLO
	mail1.thewrittenword.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755801Ab0D0N7K (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Apr 2010 09:59:10 -0400
Received: from mail1.il.thewrittenword.com (emma-internal-gw.il.thewrittenword.com [192.168.13.25])
	by mail1.thewrittenword.com (Postfix) with ESMTP id 84F645CD7
	for <git@vger.kernel.org>; Tue, 27 Apr 2010 14:20:17 +0000 (UTC)
X-DKIM: Sendmail DKIM Filter v2.4.4 mail1.thewrittenword.com 84F645CD7
Received: from akari.il.thewrittenword.com (akari.il.thewrittenword.com [10.191.57.57])
	by mail1.il.thewrittenword.com (Postfix) with ESMTP id C97C7ADA;
	Tue, 27 Apr 2010 13:59:09 +0000 (UTC)
Received: by akari.il.thewrittenword.com (Postfix, from userid 1048)
	id BF37611D4D1; Tue, 27 Apr 2010 13:59:09 +0000 (UTC)
User-Agent: quilt/0.46-1
Content-Disposition: inline; filename=no-hstrerror.patch
X-Virus-Scanned: clamav-milter 0.96 at maetel.il.thewrittenword.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145916>

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
@@ -546,11 +546,22 @@ test -n "$NEEDS_SOCKET" && LIBS="$LIBS -
 
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
@@ -813,6 +813,7 @@ ifeq ($(uname_S),SunOS)
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
