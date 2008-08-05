From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 3/3] t9119: conditionally re-enable test depending on svn(1) version
Date: Tue,  5 Aug 2008 00:35:18 -0700
Message-ID: <1217921718-25011-3-git-send-email-normalperson@yhbt.net>
References: <1217921718-25011-1-git-send-email-normalperson@yhbt.net>
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 05 09:36:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQH5m-0001pq-4d
	for gcvg-git-2@gmane.org; Tue, 05 Aug 2008 09:36:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753847AbYHEHfZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Aug 2008 03:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753871AbYHEHfZ
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Aug 2008 03:35:25 -0400
Received: from hand.yhbt.net ([66.150.188.102]:52150 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753439AbYHEHfW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Aug 2008 03:35:22 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 3BEDE2DC08B;
	Tue,  5 Aug 2008 00:35:20 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.rc1.69.g797ea
In-Reply-To: <1217921718-25011-1-git-send-email-normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91431>

I've tested this with svn 1.4.4

This also adds quoting to make it work odd characters
in the trash path.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 t/t9119-git-svn-info.sh |   69 +++++++++++++++++++++++++++-------------------
 1 files changed, 40 insertions(+), 29 deletions(-)

diff --git a/t/t9119-git-svn-info.sh b/t/t9119-git-svn-info.sh
index 964011e..5fd36a1 100755
--- a/t/t9119-git-svn-info.sh
+++ b/t/t9119-git-svn-info.sh
@@ -5,8 +5,19 @@
 test_description='git-svn info'
 
 . ./lib-git-svn.sh
-say 'skipping svn-info test (has a race undiagnosed yet)'
-test_done
+
+set -e
+
+# Tested with: svn, version 1.4.4 (r25188)
+v=`svn --version | sed -n -e 's/^svn, version \(1\.4\.[0-9]\).*$/\1/p'`
+case $v in
+1.4.*)
+	;;
+*)
+	say "skipping svn-info test (SVN version: $v not supported)"
+	test_done
+	;;
+esac
 
 ptouch() {
 	perl -w -e '
@@ -25,7 +36,7 @@ ptouch() {
 	' "`svn info $2 | grep '^Text Last Updated:'`" "$1"
 }
 
-test_expect_success 'setup repository and import' "
+test_expect_success 'setup repository and import' '
 	mkdir info &&
 	cd info &&
 		echo FIRST > A &&
@@ -34,19 +45,19 @@ test_expect_success 'setup repository and import' "
 		mkdir directory &&
 		touch directory/.placeholder &&
 		ln -s directory symlink-directory &&
-		svn import -m 'initial' . $svnrepo &&
+		svn import -m "initial" . "$svnrepo" &&
 	cd .. &&
 	mkdir gitwc &&
 	cd gitwc &&
-		git-svn init $svnrepo &&
+		git-svn init "$svnrepo" &&
 		git-svn fetch &&
 	cd .. &&
-	svn co $svnrepo svnwc &&
+	svn co "$svnrepo" svnwc &&
 	ptouch svnwc/file gitwc/file &&
 	ptouch svnwc/directory gitwc/directory &&
 	ptouch svnwc/symlink-file gitwc/symlink-file &&
 	ptouch svnwc/symlink-directory gitwc/symlink-directory
-	"
+	'
 
 test_expect_success 'info' "
 	(cd svnwc; svn info) > expected.info &&
@@ -55,7 +66,7 @@ test_expect_success 'info' "
 	"
 
 test_expect_success 'info --url' '
-	test $(cd gitwc; git-svn info --url) = $svnrepo
+	test "$(cd gitwc; git-svn info --url)" = "$svnrepo"
 	'
 
 test_expect_success 'info .' "
@@ -65,7 +76,7 @@ test_expect_success 'info .' "
 	"
 
 test_expect_success 'info --url .' '
-	test $(cd gitwc; git-svn info --url .) = $svnrepo
+	test "$(cd gitwc; git-svn info --url .)" = "$svnrepo"
 	'
 
 test_expect_success 'info file' "
@@ -75,7 +86,7 @@ test_expect_success 'info file' "
 	"
 
 test_expect_success 'info --url file' '
-	test $(cd gitwc; git-svn info --url file) = "$svnrepo/file"
+	test "$(cd gitwc; git-svn info --url file)" = "$svnrepo/file"
 	'
 
 test_expect_success 'info directory' "
@@ -85,7 +96,7 @@ test_expect_success 'info directory' "
 	"
 
 test_expect_success 'info --url directory' '
-	test $(cd gitwc; git-svn info --url directory) = "$svnrepo/directory"
+	test "$(cd gitwc; git-svn info --url directory)" = "$svnrepo/directory"
 	'
 
 test_expect_success 'info symlink-file' "
@@ -95,7 +106,7 @@ test_expect_success 'info symlink-file' "
 	"
 
 test_expect_success 'info --url symlink-file' '
-	test $(cd gitwc; git-svn info --url symlink-file) \
+	test "$(cd gitwc; git-svn info --url symlink-file)" \
 	     = "$svnrepo/symlink-file"
 	'
 
@@ -108,7 +119,7 @@ test_expect_success 'info symlink-directory' "
 	"
 
 test_expect_success 'info --url symlink-directory' '
-	test $(cd gitwc; git-svn info --url symlink-directory) \
+	test "$(cd gitwc; git-svn info --url symlink-directory)" \
 	     = "$svnrepo/symlink-directory"
 	'
 
@@ -128,7 +139,7 @@ test_expect_success 'info added-file' "
 	"
 
 test_expect_success 'info --url added-file' '
-	test $(cd gitwc; git-svn info --url added-file) \
+	test "$(cd gitwc; git-svn info --url added-file)" \
 	     = "$svnrepo/added-file"
 	'
 
@@ -150,7 +161,7 @@ test_expect_success 'info added-directory' "
 	"
 
 test_expect_success 'info --url added-directory' '
-	test $(cd gitwc; git-svn info --url added-directory) \
+	test "$(cd gitwc; git-svn info --url added-directory)" \
 	     = "$svnrepo/added-directory"
 	'
 
@@ -173,7 +184,7 @@ test_expect_success 'info added-symlink-file' "
 	"
 
 test_expect_success 'info --url added-symlink-file' '
-	test $(cd gitwc; git-svn info --url added-symlink-file) \
+	test "$(cd gitwc; git-svn info --url added-symlink-file)" \
 	     = "$svnrepo/added-symlink-file"
 	'
 
@@ -196,7 +207,7 @@ test_expect_success 'info added-symlink-directory' "
 	"
 
 test_expect_success 'info --url added-symlink-directory' '
-	test $(cd gitwc; git-svn info --url added-symlink-directory) \
+	test "$(cd gitwc; git-svn info --url added-symlink-directory)" \
 	     = "$svnrepo/added-symlink-directory"
 	'
 
@@ -222,7 +233,7 @@ test_expect_success 'info deleted-file' "
 	"
 
 test_expect_success 'info --url file (deleted)' '
-	test $(cd gitwc; git-svn info --url file) \
+	test "$(cd gitwc; git-svn info --url file)" \
 	     = "$svnrepo/file"
 	'
 
@@ -243,7 +254,7 @@ test_expect_success 'info deleted-directory' "
 	"
 
 test_expect_success 'info --url directory (deleted)' '
-	test $(cd gitwc; git-svn info --url directory) \
+	test "$(cd gitwc; git-svn info --url directory)" \
 	     = "$svnrepo/directory"
 	'
 
@@ -265,7 +276,7 @@ test_expect_success 'info deleted-symlink-file' "
 	"
 
 test_expect_success 'info --url symlink-file (deleted)' '
-	test $(cd gitwc; git-svn info --url symlink-file) \
+	test "$(cd gitwc; git-svn info --url symlink-file)" \
 	     = "$svnrepo/symlink-file"
 	'
 
@@ -287,7 +298,7 @@ test_expect_success 'info deleted-symlink-directory' "
 	"
 
 test_expect_success 'info --url symlink-directory (deleted)' '
-	test $(cd gitwc; git-svn info --url symlink-directory) \
+	test "$(cd gitwc; git-svn info --url symlink-directory)" \
 	     = "$svnrepo/symlink-directory"
 	'
 
@@ -304,8 +315,8 @@ test_expect_success 'info unknown-file' "
 	"
 
 test_expect_success 'info --url unknown-file' '
-	test -z $(cd gitwc; git-svn info --url unknown-file \
-			2> ../actual.info--url-unknown-file) &&
+	test -z "$(cd gitwc; git-svn info --url unknown-file \
+			2> ../actual.info--url-unknown-file)" &&
 	git-diff expected.info-unknown-file actual.info--url-unknown-file
 	'
 
@@ -321,8 +332,8 @@ test_expect_success 'info unknown-directory' "
 	"
 
 test_expect_success 'info --url unknown-directory' '
-	test -z $(cd gitwc; git-svn info --url unknown-directory \
-			2> ../actual.info--url-unknown-directory) &&
+	test -z "$(cd gitwc; git-svn info --url unknown-directory \
+			2> ../actual.info--url-unknown-directory)" &&
 	git-diff expected.info-unknown-directory \
 		 actual.info--url-unknown-directory
 	'
@@ -344,8 +355,8 @@ test_expect_success 'info unknown-symlink-file' "
 	"
 
 test_expect_success 'info --url unknown-symlink-file' '
-	test -z $(cd gitwc; git-svn info --url unknown-symlink-file \
-			2> ../actual.info--url-unknown-symlink-file) &&
+	test -z "$(cd gitwc; git-svn info --url unknown-symlink-file \
+			2> ../actual.info--url-unknown-symlink-file)" &&
 	git-diff expected.info-unknown-symlink-file \
 		 actual.info--url-unknown-symlink-file
 	'
@@ -368,8 +379,8 @@ test_expect_success 'info unknown-symlink-directory' "
 	"
 
 test_expect_success 'info --url unknown-symlink-directory' '
-	test -z $(cd gitwc; git-svn info --url unknown-symlink-directory \
-			2> ../actual.info--url-unknown-symlink-directory) &&
+	test -z "$(cd gitwc; git-svn info --url unknown-symlink-directory \
+			2> ../actual.info--url-unknown-symlink-directory)" &&
 	git-diff expected.info-unknown-symlink-directory \
 		 actual.info--url-unknown-symlink-directory
 	'
-- 
1.6.0.rc1.69.g797ea
