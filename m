From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 2/4] git p4: test submit
Date: Sun, 29 Apr 2012 20:57:15 -0400
Message-ID: <1335747437-24034-3-git-send-email-pw@padd.com>
References: <1335747437-24034-1-git-send-email-pw@padd.com>
Cc: Gary Gibbons <ggibbons@perforce.com>,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 30 02:58:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOewH-0003aR-Ka
	for gcvg-git-2@plane.gmane.org; Mon, 30 Apr 2012 02:58:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754768Ab2D3A6A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Apr 2012 20:58:00 -0400
Received: from honk.padd.com ([74.3.171.149]:36587 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754314Ab2D3A6A (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Apr 2012 20:58:00 -0400
Received: from arf.padd.com (unknown [50.55.155.59])
	by honk.padd.com (Postfix) with ESMTPSA id E73D160C0;
	Sun, 29 Apr 2012 17:57:59 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id A5BA9313F8; Sun, 29 Apr 2012 20:57:57 -0400 (EDT)
X-Mailer: git-send-email 1.7.10.572.ged86f
In-Reply-To: <1335747437-24034-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196529>

Try each of the five diff patterns that might happen during submit.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 t/t9807-git-p4-submit.sh |   92 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/t/t9807-git-p4-submit.sh b/t/t9807-git-p4-submit.sh
index 2d7dc27..a2499ee 100755
--- a/t/t9807-git-p4-submit.sh
+++ b/t/t9807-git-p4-submit.sh
@@ -88,6 +88,98 @@ test_expect_success 'submit with master branch name from argv' '
 	)
 '
 
+#
+# Basic submit tests, the five handled cases
+#
+
+test_expect_success 'submit modify' '
+	test_when_finished cleanup_git &&
+	git p4 clone --dest="$git" //depot &&
+	(
+		cd "$git" &&
+		git config git-p4.skipSubmitEdit true &&
+		echo line >>file1 &&
+		git add file1 &&
+		git commit -m file1 &&
+		git p4 submit
+	) &&
+	(
+		cd "$cli" &&
+		test_path_is_file file1 &&
+		test_line_count = 2 file1
+	)
+'
+
+test_expect_success 'submit add' '
+	test_when_finished cleanup_git &&
+	git p4 clone --dest="$git" //depot &&
+	(
+		cd "$git" &&
+		git config git-p4.skipSubmitEdit true &&
+		echo file13 >file13 &&
+		git add file13 &&
+		git commit -m file13 &&
+		git p4 submit
+	) &&
+	(
+		cd "$cli" &&
+		test_path_is_file file13
+	)
+'
+
+test_expect_success 'submit delete' '
+	test_when_finished cleanup_git &&
+	git p4 clone --dest="$git" //depot &&
+	(
+		cd "$git" &&
+		git config git-p4.skipSubmitEdit true &&
+		git rm file4.t &&
+		git commit -m "delete file4.t" &&
+		git p4 submit
+	) &&
+	(
+		cd "$cli" &&
+		test_path_is_missing file4.t
+	)
+'
+
+test_expect_success 'submit copy' '
+	test_when_finished cleanup_git &&
+	git p4 clone --dest="$git" //depot &&
+	(
+		cd "$git" &&
+		git config git-p4.skipSubmitEdit true &&
+		git config git-p4.detectCopies true &&
+		git config git-p4.detectCopiesHarder true &&
+		cp file5.t file5.ta &&
+		git add file5.ta &&
+		git commit -m "copy to file5.ta" &&
+		git p4 submit
+	) &&
+	(
+		cd "$cli" &&
+		test_path_is_file file5.ta
+	)
+'
+
+test_expect_success 'submit rename' '
+	test_when_finished cleanup_git &&
+	git p4 clone --dest="$git" //depot &&
+	(
+		cd "$git" &&
+		git config git-p4.skipSubmitEdit true &&
+		git config git-p4.detectRenames true &&
+		git mv file6.t file6.ta &&
+		git commit -m "rename file6.t to file6.ta" &&
+		git p4 submit
+	) &&
+	(
+		cd "$cli" &&
+		test_path_is_missing file6.t &&
+		test_path_is_file file6.ta
+	)
+'
+
 test_expect_success 'kill p4d' '
 	kill_p4d
 '
-- 
1.7.10.366.g90ade
