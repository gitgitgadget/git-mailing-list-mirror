From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 2/2] git-svn: fix 'info' tests for unknown items
Date: Fri, 29 Aug 2008 15:42:49 +0200
Message-ID: <1220017369-32637-3-git-send-email-trast@student.ethz.ch>
References: <20080829081654.GA6680@yp-box.dyndns.org>
 <1220017369-32637-1-git-send-email-trast@student.ethz.ch>
 <1220017369-32637-2-git-send-email-trast@student.ethz.ch>
Cc: Eric Wong <normalperson@yhbt.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 29 15:44:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZ4Gv-000249-8J
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 15:44:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754377AbYH2NnB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2008 09:43:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756169AbYH2Nm7
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 09:42:59 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:37232 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753157AbYH2Nm4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 09:42:56 -0400
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 29 Aug 2008 15:42:52 +0200
Received: from localhost.localdomain ([77.56.223.244]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 29 Aug 2008 15:42:52 +0200
X-Mailer: git-send-email 1.6.0.1.98.g76a24
In-Reply-To: <1220017369-32637-2-git-send-email-trast@student.ethz.ch>
X-OriginalArrivalTime: 29 Aug 2008 13:42:52.0413 (UTC) FILETIME=[2244DAD0:01C909DD]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The previous tests all expected the results from SVN and Git to be
identical, and expected both to return success.  This cannot be
guaranteed: SVN changed the message style between 1.4 and 1.5, and
in 1.5, sets a failure exit code.

Change the tests to verify that 'git svn info <item>' sets a failure
exit code, and that its output contains the file name.  This should
hopefully catch all other errors.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 t/t9119-git-svn-info.sh |   73 ++++++++++++++++-------------------------------
 1 files changed, 25 insertions(+), 48 deletions(-)

diff --git a/t/t9119-git-svn-info.sh b/t/t9119-git-svn-info.sh
index 1811010..3e48459 100755
--- a/t/t9119-git-svn-info.sh
+++ b/t/t9119-git-svn-info.sh
@@ -319,82 +319,59 @@ test_expect_success 'info --url symlink-directory (deleted)' '
 
 test_expect_success 'info unknown-file' "
 	echo two > gitwc/unknown-file &&
-	cp gitwc/unknown-file svnwc/unknown-file &&
-	ptouch gitwc/unknown-file svnwc/unknown-file &&
-	(cd svnwc; svn info unknown-file) 2> expected.info-unknown-file &&
-	(cd gitwc; git-svn info unknown-file) 2> actual.info-unknown-file &&
-	test_cmp expected.info-unknown-file actual.info-unknown-file
+	(cd gitwc; test_must_fail git-svn info unknown-file) \
+		 2> actual.info-unknown-file &&
+	grep unknown-file actual.info-unknown-file
 	"
 
 test_expect_success 'info --url unknown-file' '
-	test -z "$(cd gitwc; git-svn info --url unknown-file \
-			2> ../actual.info--url-unknown-file)" &&
-	test_cmp expected.info-unknown-file actual.info--url-unknown-file
+	echo two > gitwc/unknown-file &&
+	(cd gitwc; test_must_fail git-svn info --url unknown-file) \
+		 2> actual.info-url-unknown-file &&
+	grep unknown-file actual.info-url-unknown-file
 	'
 
 test_expect_success 'info unknown-directory' "
 	mkdir gitwc/unknown-directory svnwc/unknown-directory &&
-	ptouch gitwc/unknown-directory svnwc/unknown-directory &&
-	touch gitwc/unknown-directory/.placeholder &&
-	(cd svnwc; svn info unknown-directory) \
-		2> expected.info-unknown-directory &&
-	(cd gitwc; git-svn info unknown-directory) \
-		2> actual.info-unknown-directory &&
-	test_cmp expected.info-unknown-directory actual.info-unknown-directory
+	(cd gitwc; test_must_fail git-svn info unknown-directory) \
+		 2> actual.info-unknown-directory &&
+	grep unknown-directory actual.info-unknown-directory
 	"
 
 test_expect_success 'info --url unknown-directory' '
-	test -z "$(cd gitwc; git-svn info --url unknown-directory \
-			2> ../actual.info--url-unknown-directory)" &&
-	test_cmp expected.info-unknown-directory \
-		 actual.info--url-unknown-directory
+	(cd gitwc; test_must_fail git-svn info --url unknown-directory) \
+		 2> actual.info-url-unknown-directory &&
+	grep unknown-directory actual.info-url-unknown-directory
 	'
 
 test_expect_success 'info unknown-symlink-file' "
 	cd gitwc &&
 		ln -s unknown-file unknown-symlink-file &&
 	cd .. &&
-	cd svnwc &&
-		ln -s unknown-file unknown-symlink-file &&
-	cd .. &&
-	ptouch gitwc/unknown-symlink-file svnwc/unknown-symlink-file &&
-	(cd svnwc; svn info unknown-symlink-file) \
-		2> expected.info-unknown-symlink-file &&
-	(cd gitwc; git-svn info unknown-symlink-file) \
-		2> actual.info-unknown-symlink-file &&
-	test_cmp expected.info-unknown-symlink-file \
-		 actual.info-unknown-symlink-file
+	(cd gitwc; test_must_fail git-svn info unknown-symlink-file) \
+		 2> actual.info-unknown-symlink-file &&
+	grep unknown-symlink-file actual.info-unknown-symlink-file
 	"
 
 test_expect_success 'info --url unknown-symlink-file' '
-	test -z "$(cd gitwc; git-svn info --url unknown-symlink-file \
-			2> ../actual.info--url-unknown-symlink-file)" &&
-	test_cmp expected.info-unknown-symlink-file \
-		 actual.info--url-unknown-symlink-file
+	(cd gitwc; test_must_fail git-svn info --url unknown-symlink-file) \
+		 2> actual.info-url-unknown-symlink-file &&
+	grep unknown-symlink-file actual.info-url-unknown-symlink-file
 	'
 
 test_expect_success 'info unknown-symlink-directory' "
 	cd gitwc &&
 		ln -s unknown-directory unknown-symlink-directory &&
 	cd .. &&
-	cd svnwc &&
-		ln -s unknown-directory unknown-symlink-directory &&
-	cd .. &&
-	ptouch gitwc/unknown-symlink-directory \
-	       svnwc/unknown-symlink-directory &&
-	(cd svnwc; svn info unknown-symlink-directory) \
-		2> expected.info-unknown-symlink-directory &&
-	(cd gitwc; git-svn info unknown-symlink-directory) \
-		2> actual.info-unknown-symlink-directory &&
-	test_cmp expected.info-unknown-symlink-directory \
-		 actual.info-unknown-symlink-directory
+	(cd gitwc; test_must_fail git-svn info unknown-symlink-directory) \
+		 2> actual.info-unknown-symlink-directory &&
+	grep unknown-symlink-directory actual.info-unknown-symlink-directory
 	"
 
 test_expect_success 'info --url unknown-symlink-directory' '
-	test -z "$(cd gitwc; git-svn info --url unknown-symlink-directory \
-			2> ../actual.info--url-unknown-symlink-directory)" &&
-	test_cmp expected.info-unknown-symlink-directory \
-		 actual.info--url-unknown-symlink-directory
+	(cd gitwc; test_must_fail git-svn info --url unknown-symlink-directory) \
+		 2> actual.info-url-unknown-symlink-directory &&
+	grep unknown-symlink-directory actual.info-url-unknown-symlink-directory
 	'
 
 test_done
-- 
1.6.0.1.98.g76a24
