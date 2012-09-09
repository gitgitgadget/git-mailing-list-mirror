From: Pete Wyckoff <pw@padd.com>
Subject: [PATCHv2 06/12] git p4: test clean-up after failed submit, fix added files
Date: Sun,  9 Sep 2012 16:16:07 -0400
Message-ID: <1347221773-12773-7-git-send-email-pw@padd.com>
References: <1347221773-12773-1-git-send-email-pw@padd.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Luke Diamand <luke@diamand.org>,
	Johannes Sixt <j.sixt@viscovery.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 09 22:18:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TAnxZ-0004o1-5m
	for gcvg-git-2@plane.gmane.org; Sun, 09 Sep 2012 22:18:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754809Ab2IIUSS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Sep 2012 16:18:18 -0400
Received: from honk.padd.com ([74.3.171.149]:53003 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752589Ab2IIUSR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Sep 2012 16:18:17 -0400
Received: from arf.padd.com (unknown [50.55.149.165])
	by honk.padd.com (Postfix) with ESMTPSA id B3B785AF2;
	Sun,  9 Sep 2012 13:18:16 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 3D67332112; Sun,  9 Sep 2012 16:18:14 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.176.gc22bed1
In-Reply-To: <1347221773-12773-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205096>

Test a variety of cases where a patch failed to apply to
p4 and had to be cleaned up.

If the patch failed to apply cleanly, do not try to remove
to-be-added files, as they have not really been added yet.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 git-p4.py                     |   2 -
 t/t9815-git-p4-submit-fail.sh | 132 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 132 insertions(+), 2 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 39fa2e1..0481f43 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1200,8 +1200,6 @@ class P4Submit(Command, P4UserMap):
         if not patch_succeeded:
             for f in editedFiles:
                 p4_revert(f)
-            for f in filesToAdd:
-                os.remove(f)
             return False
 
         system(applyPatchCmd)
diff --git a/t/t9815-git-p4-submit-fail.sh b/t/t9815-git-p4-submit-fail.sh
index 397b3e8..e73d6ab 100755
--- a/t/t9815-git-p4-submit-fail.sh
+++ b/t/t9815-git-p4-submit-fail.sh
@@ -108,6 +108,138 @@ test_expect_success 'conflict on first of two commits, quit' '
 	)
 '
 
+#
+# Cleanup after submit fail, all cases.  Some modifications happen
+# before trying to apply the patch.  Make sure these are unwound
+# properly.  Put each one in a diff along with something that will
+# obviously conflict.  Make sure it is back to normal after.
+#
+
+test_expect_success 'cleanup edit p4 populate' '
+	(
+		cd "$cli" &&
+		echo text file >text &&
+		p4 add text &&
+		echo text+x file >text+x &&
+		chmod 755 text+x &&
+		p4 add text+x &&
+		p4 submit -d "populate p4"
+	)
+'
+
+setup_conflict() {
+	# clone before modifying file1 to force it to conflict
+	test_when_finished cleanup_git &&
+	git p4 clone --dest="$git" //depot &&
+	# ticks outside subshells
+	test_tick &&
+	(
+		cd "$cli" &&
+		p4 open file1 &&
+		echo $test_tick >>file1 &&
+		p4 submit -d "$test_tick in file1"
+	) &&
+	test_tick &&
+	(
+		cd "$git" &&
+		git config git-p4.skipSubmitEdit true &&
+		# easy conflict
+		echo $test_tick >>file1 &&
+		git add file1
+		# caller will add more and submit
+	)
+}
+
+test_expect_success 'cleanup edit after submit fail' '
+	setup_conflict &&
+	(
+		cd "$git" &&
+		echo another line >>text &&
+		git add text &&
+		git commit -m "conflict" &&
+		test_expect_code 1 git p4 submit
+	) &&
+	(
+		cd "$cli" &&
+		# make sure it is not open
+		! p4 fstat -T action text
+	)
+'
+
+test_expect_success 'cleanup add after submit fail' '
+	setup_conflict &&
+	(
+		cd "$git" &&
+		echo new file >textnew &&
+		git add textnew &&
+		git commit -m "conflict" &&
+		test_expect_code 1 git p4 submit
+	) &&
+	(
+		cd "$cli" &&
+		# make sure it is not there
+		# and that p4 thinks it is not added
+		#   P4 returns 0 both for "not there but added" and
+		#   "not there", so grep.
+		test_path_is_missing textnew &&
+		p4 fstat -T action textnew 2>&1 | grep "no such file"
+	)
+'
+
+test_expect_success 'cleanup delete after submit fail' '
+	setup_conflict &&
+	(
+		cd "$git" &&
+		git rm text+x &&
+		git commit -m "conflict" &&
+		test_expect_code 1 git p4 submit
+	) &&
+	(
+		cd "$cli" &&
+		# make sure it is there
+		test_path_is_file text+x &&
+		! p4 fstat -T action text+x
+	)
+'
+
+test_expect_success 'cleanup copy after submit fail' '
+	setup_conflict &&
+	(
+		cd "$git" &&
+		cp text text2 &&
+		git add text2 &&
+		git commit -m "conflict" &&
+		git config git-p4.detectCopies true &&
+		git config git-p4.detectCopiesHarder true &&
+		# make sure setup is okay
+		git diff-tree -r -C --find-copies-harder HEAD | grep text2 | grep C100 &&
+		test_expect_code 1 git p4 submit
+	) &&
+	(
+		cd "$cli" &&
+		test_path_is_missing text2 &&
+		p4 fstat -T action text2 2>&1 | grep "no such file"
+	)
+'
+
+test_expect_success 'cleanup rename after submit fail' '
+	setup_conflict &&
+	(
+		cd "$git" &&
+		git mv text text2 &&
+		git commit -m "conflict" &&
+		git config git-p4.detectRenames true &&
+		# make sure setup is okay
+		git diff-tree -r -M HEAD | grep text2 | grep R100 &&
+		test_expect_code 1 git p4 submit
+	) &&
+	(
+		cd "$cli" &&
+		test_path_is_missing text2 &&
+		p4 fstat -T action text2 2>&1 | grep "no such file"
+	)
+'
+
 test_expect_success 'kill p4d' '
 	kill_p4d
 '
-- 
1.7.12.rc2.111.g96f7c73
