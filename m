From: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
Subject: [PATCH v5 09/18] Makefile: some platforms do not have hstrerror anywhere
Date: Fri, 14 May 2010 09:31:40 +0000
Message-ID: <20100514093807.382121000@mlists.thewrittenword.com>
References: <20100514093131.249094000@mlists.thewrittenword.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 14 11:38:22 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCrLW-0001sM-GW
	for gcvg-git-2@lo.gmane.org; Fri, 14 May 2010 11:38:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758787Ab0ENJiL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 May 2010 05:38:11 -0400
Received: from mail1.thewrittenword.com ([69.67.212.77]:65485 "EHLO
	mail1.thewrittenword.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758769Ab0ENJiI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 May 2010 05:38:08 -0400
Received: from mail1.il.thewrittenword.com (emma-internal-gw.il.thewrittenword.com [192.168.13.25])
	by mail1.thewrittenword.com (Postfix) with ESMTP id B18ED5C0C
	for <git@vger.kernel.org>; Fri, 14 May 2010 09:54:59 +0000 (UTC)
X-DKIM: Sendmail DKIM Filter v2.4.4 mail1.thewrittenword.com B18ED5C0C
Received: from akari.il.thewrittenword.com (akari.il.thewrittenword.com [10.191.57.57])
	by mail1.il.thewrittenword.com (Postfix) with ESMTP id 88E4CCE6;
	Fri, 14 May 2010 09:38:07 +0000 (UTC)
Received: by akari.il.thewrittenword.com (Postfix, from userid 1048)
	id 7F13011D4D1; Fri, 14 May 2010 09:38:07 +0000 (UTC)
User-Agent: quilt/0.46-1
Content-Disposition: inline; filename=no-hstrerror.patch
X-Virus-Scanned: clamav-milter 0.96 at maetel.il.thewrittenword.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147067>

This patch improves the logic of the test for hstrerror, not to
blindly assume that if there is no hstrerror in libc that it must
exist in libresolv.

Signed-off-by: Gary V. Vaughan <gary@thewrittenword.com>
---
 config.mak.in |    1 +
 configure.ac  |   17 ++++++++++++++---
 2 files changed, 15 insertions(+), 3 deletions(-)

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
