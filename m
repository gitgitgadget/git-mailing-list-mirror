From: Pete Wyckoff <pw@padd.com>
Subject: [PATCHv2 08/12] git p4: revert deleted files after submit cancel
Date: Sun,  9 Sep 2012 16:16:09 -0400
Message-ID: <1347221773-12773-9-git-send-email-pw@padd.com>
References: <1347221773-12773-1-git-send-email-pw@padd.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Luke Diamand <luke@diamand.org>,
	Johannes Sixt <j.sixt@viscovery.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 09 22:19:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TAnyD-0005C4-2t
	for gcvg-git-2@plane.gmane.org; Sun, 09 Sep 2012 22:19:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754848Ab2IIUS5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Sep 2012 16:18:57 -0400
Received: from honk.padd.com ([74.3.171.149]:53013 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752589Ab2IIUS5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Sep 2012 16:18:57 -0400
Received: from arf.padd.com (unknown [50.55.149.165])
	by honk.padd.com (Postfix) with ESMTPSA id BBCBC5AF2;
	Sun,  9 Sep 2012 13:18:56 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 63ED532112; Sun,  9 Sep 2012 16:18:54 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.176.gc22bed1
In-Reply-To: <1347221773-12773-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205098>

The user can decide not to continue with a submission,
by not saving the p4 submit template, then answering "no" to
the "Submit anyway?" prompt.  In this case, be sure to
return the p4 client to its initial state.

Deleted files were not reverted; fix this and test all cases.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 git-p4.py                     |   2 +
 t/t9815-git-p4-submit-fail.sh | 119 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 121 insertions(+)

diff --git a/git-p4.py b/git-p4.py
index ea14c1f..60012bc 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1304,6 +1304,8 @@ class P4Submit(Command, P4UserMap):
             for f in filesToAdd:
                 p4_revert(f)
                 os.remove(f)
+            for f in filesToDelete:
+                p4_revert(f)
 
         os.remove(fileName)
         return ret
diff --git a/t/t9815-git-p4-submit-fail.sh b/t/t9815-git-p4-submit-fail.sh
index e73d6ab..1823cff 100755
--- a/t/t9815-git-p4-submit-fail.sh
+++ b/t/t9815-git-p4-submit-fail.sh
@@ -240,6 +240,125 @@ test_expect_success 'cleanup rename after submit fail' '
 	)
 '
 
+#
+# Cleanup after deciding not to submit during editTemplate.  This
+# involves unwinding more work, because files have been added, deleted
+# and chmod-ed now.  Same approach as above.
+#
+
+test_expect_success 'cleanup edit after submit cancel' '
+	test_when_finished cleanup_git &&
+	git p4 clone --dest="$git" //depot &&
+	(
+		cd "$git" &&
+		echo line >>text &&
+		git add text &&
+		git commit -m text &&
+		echo n | test_expect_code 1 git p4 submit &&
+		git reset --hard HEAD^
+	) &&
+	(
+		cd "$cli" &&
+		! p4 fstat -T action text &&
+		test_cmp "$git"/text text
+	)
+'
+
+test_expect_success 'cleanup add after submit cancel' '
+	test_when_finished cleanup_git &&
+	git p4 clone --dest="$git" //depot &&
+	(
+		cd "$git" &&
+		echo line >textnew &&
+		git add textnew &&
+		git commit -m textnew &&
+		echo n | test_expect_code 1 git p4 submit
+	) &&
+	(
+		cd "$cli" &&
+		test_path_is_missing textnew &&
+		p4 fstat -T action textnew 2>&1 | grep "no such file"
+	)
+'
+
+test_expect_success 'cleanup delete after submit cancel' '
+	test_when_finished cleanup_git &&
+	git p4 clone --dest="$git" //depot &&
+	(
+		cd "$git" &&
+		git rm text &&
+		git commit -m "rm text" &&
+		echo n | test_expect_code 1 git p4 submit
+	) &&
+	(
+		cd "$cli" &&
+		test_path_is_file text &&
+		! p4 fstat -T action text
+	)
+'
+
+test_expect_success 'cleanup copy after submit cancel' '
+	test_when_finished cleanup_git &&
+	git p4 clone --dest="$git" //depot &&
+	(
+		cd "$git" &&
+		cp text text2 &&
+		git add text2 &&
+		git commit -m text2 &&
+		git config git-p4.detectCopies true &&
+		git config git-p4.detectCopiesHarder true &&
+		git diff-tree -r -C --find-copies-harder HEAD | grep text2 | grep C100 &&
+		echo n | test_expect_code 1 git p4 submit
+	) &&
+	(
+		cd "$cli" &&
+		test_path_is_missing text2 &&
+		p4 fstat -T action text2 2>&1 | grep "no such file"
+	)
+'
+
+test_expect_success 'cleanup rename after submit cancel' '
+	test_when_finished cleanup_git &&
+	git p4 clone --dest="$git" //depot &&
+	(
+		cd "$git" &&
+		git mv text text2 &&
+		git commit -m text2 &&
+		git config git-p4.detectRenames true &&
+		git diff-tree -r -M HEAD | grep text2 | grep R100 &&
+		echo n | test_expect_code 1 git p4 submit
+	) &&
+	(
+		cd "$cli" &&
+		test_path_is_missing text2 &&
+		p4 fstat -T action text2 2>&1 | grep "no such file"
+		test_path_is_file text &&
+		! p4 fstat -T action text
+	)
+'
+
+test_expect_success 'cleanup chmod after submit cancel' '
+	test_when_finished cleanup_git &&
+	git p4 clone --dest="$git" //depot &&
+	(
+		cd "$git" &&
+		chmod u+x text &&
+		chmod u-x text+x &&
+		git add text text+x &&
+		git commit -m "chmod texts" &&
+		echo n | test_expect_code 1 git p4 submit
+	) &&
+	(
+		cd "$cli" &&
+		test_path_is_file text &&
+		! p4 fstat -T action text &&
+		stat --format=%A text | egrep ^-r-- &&
+		test_path_is_file text+x &&
+		! p4 fstat -T action text+x &&
+		stat --format=%A text+x | egrep ^-r-x
+	)
+'
+
 test_expect_success 'kill p4d' '
 	kill_p4d
 '
-- 
1.7.12.rc2.111.g96f7c73
