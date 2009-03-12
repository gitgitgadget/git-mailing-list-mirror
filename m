From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: [PATCH] configure: make iconv tests aware of user arguments
Date: Thu, 12 Mar 2009 15:20:11 -0400
Message-ID: <1236885612-22575-7-git-send-email-bwalton@artsci.utoronto.ca>
References: <1236885612-22575-1-git-send-email-bwalton@artsci.utoronto.ca>
 <1236885612-22575-2-git-send-email-bwalton@artsci.utoronto.ca>
 <1236885612-22575-3-git-send-email-bwalton@artsci.utoronto.ca>
 <1236885612-22575-4-git-send-email-bwalton@artsci.utoronto.ca>
 <1236885612-22575-5-git-send-email-bwalton@artsci.utoronto.ca>
 <1236885612-22575-6-git-send-email-bwalton@artsci.utoronto.ca>
Cc: Ben Walton <bwalton@artsci.utoronto.ca>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 12 20:22:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhqTg-0007sz-6N
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 20:22:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756824AbZCLTUg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2009 15:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755077AbZCLTUe
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 15:20:34 -0400
Received: from www.cquest.utoronto.ca ([192.82.128.5]:36891 "EHLO
	www.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755317AbZCLTUR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2009 15:20:17 -0400
Received: from ntdws12.chass.utoronto.ca ([128.100.160.253] ident=93)
	by www.cquest.utoronto.ca with esmtp (Exim 4.43)
	id 1LhqRy-0004TB-7I; Thu, 12 Mar 2009 15:20:14 -0400
Received: from localhost
	([127.0.0.1] helo=ntdws12.chass.utoronto.ca ident=505)
	by ntdws12.chass.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1LhqRy-0005uP-4O; Thu, 12 Mar 2009 15:20:14 -0400
Received: (from bwalton@localhost)
	by ntdws12.chass.utoronto.ca (8.13.8/8.13.8/Submit) id n2CJKEfA022713;
	Thu, 12 Mar 2009 15:20:14 -0400
X-Mailer: git-send-email 1.5.5.6
In-Reply-To: <1236885612-22575-6-git-send-email-bwalton@artsci.utoronto.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113110>

--with-iconv is now taken into account when doing the tests for iconv.
If the user requests alternate handling for libiconv, the -liconv test
is run before the -lc test.

Signed-off-by: Ben Walton <bwalton@artsci.utoronto.ca>
---
 configure.ac |   48 ++++++++++++++++++++++++++++++++++--------------
 1 files changed, 34 insertions(+), 14 deletions(-)

diff --git a/configure.ac b/configure.ac
index f4b8e49..6fe4bfe 100644
--- a/configure.ac
+++ b/configure.ac
@@ -375,20 +375,35 @@ int main(void)
 	return 0;
 }
 ])
-AC_MSG_CHECKING([for iconv in -lc])
-AC_LINK_IFELSE(ICONVTEST_SRC,
+
+if test -n "$ICONVDIR"; then
+   lib_order="-liconv -lc"
+else
+   lib_order="-lc -liconv"
+fi
+
+NO_ICONV=YesPlease
+
+for l in $lib_order; do
+    if test "$l" = "-liconv"; then
+       NEEDS_LIBICONV=YesPlease
+    else
+       NEEDS_LIBICONV=
+    fi
+
+    old_LIBS="$LIBS"
+    LIBS="$LIBS $l"
+    AC_MSG_CHECKING([for iconv in $l])
+    AC_LINK_IFELSE(ICONVTEST_SRC,
 	[AC_MSG_RESULT([yes])
-	NEEDS_LIBICONV=],
-	[AC_MSG_RESULT([no])
-	old_LIBS="$LIBS"
-	LIBS="$LIBS -liconv"
-	AC_MSG_CHECKING([for iconv in -liconv])
-	AC_LINK_IFELSE(ICONVTEST_SRC,
-		[AC_MSG_RESULT([yes])
-		NEEDS_LIBICONV=YesPlease],
-		[AC_MSG_RESULT([no])
-		NO_ICONV=YesPlease])
-	LIBS="$old_LIBS"])
+	NO_ICONV=
+	break],
+	[AC_MSG_RESULT([no])])
+    LIBS="$old_LIBS"
+done
+
+#in case of break
+LIBS="$old_LIBS"
 
 GIT_UNSTASH_FLAGS($ICONVDIR)
 
@@ -455,13 +470,18 @@ int main(void)
 	return 0;
 }
 ]])
+
+GIT_STASH_FLAGS($ICONVDIR)
+
 AC_MSG_CHECKING([for old iconv()])
 AC_COMPILE_IFELSE(OLDICONVTEST_SRC,
 	[AC_MSG_RESULT([no])],
 	[AC_MSG_RESULT([yes])
 	OLD_ICONV=UnfortunatelyYes])
-AC_SUBST(OLD_ICONV)
 
+GIT_UNSTASH_FLAGS($ICONVDIR)
+
+AC_SUBST(OLD_ICONV)
 
 ## Checks for typedefs, structures, and compiler characteristics.
 AC_MSG_NOTICE([CHECKS for typedefs, structures, and compiler characteristics])
-- 
1.6.0.5
