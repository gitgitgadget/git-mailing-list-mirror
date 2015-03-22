From: Koosha Khajehmoogahi <koosha@posteo.de>
Subject: [PATCH 4/5] Add tests for git-log --merges=show|hide|only
Date: Sun, 22 Mar 2015 19:28:40 +0100
Message-ID: <1427048921-28677-4-git-send-email-koosha@posteo.de>
References: <1427048921-28677-1-git-send-email-koosha@posteo.de>
Cc: Koosha Khajehmoogahi <koosha@posteo.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 22 19:30:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZkdq-0003PJ-2M
	for gcvg-git-2@plane.gmane.org; Sun, 22 Mar 2015 19:30:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751852AbbCVSa0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2015 14:30:26 -0400
Received: from mx02.posteo.de ([89.146.194.165]:41309 "EHLO mx02.posteo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751813AbbCVSaL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2015 14:30:11 -0400
Received: from dovecot03.posteo.de (unknown [185.67.36.28])
	by mx02.posteo.de (Postfix) with ESMTPS id A3CAF1F5E885;
	Sun, 22 Mar 2015 19:30:09 +0100 (CET)
Received: from mail.posteo.de (localhost [127.0.0.1])
	by dovecot03.posteo.de (Postfix) with ESMTPSA id 3l96p93bQgz5vNC;
	Sun, 22 Mar 2015 19:30:09 +0100 (CET)
X-Mailer: git-send-email 2.3.3.263.g095251d.dirty
In-Reply-To: <1427048921-28677-1-git-send-email-koosha@posteo.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266079>

Signed-off-by: Koosha Khajehmoogahi <koosha@posteo.de>
---
 t/t4202-log.sh | 141 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 141 insertions(+)

diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 5f2b290..ab6f371 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -428,6 +428,147 @@ cat > expect <<\EOF
 * initial
 EOF
 
+cat > only_merges <<EOF
+Merge tag 'reach'
+Merge tags 'octopus-a' and 'octopus-b'
+Merge branch 'tangle'
+Merge branch 'side' (early part) into tangle
+Merge branch 'master' (early part) into tangle
+Merge branch 'side'
+EOF
+
+cat > only_commits <<EOF
+seventh
+octopus-b
+octopus-a
+reach
+tangle-a
+side-2
+side-1
+Second
+sixth
+fifth
+fourth
+third
+second
+initial
+EOF
+
+cat > both_commits_merges <<EOF
+Merge tag 'reach'
+Merge tags 'octopus-a' and 'octopus-b'
+seventh
+octopus-b
+octopus-a
+reach
+Merge branch 'tangle'
+Merge branch 'side' (early part) into tangle
+Merge branch 'master' (early part) into tangle
+tangle-a
+Merge branch 'side'
+side-2
+side-1
+Second
+sixth
+fifth
+fourth
+third
+second
+initial
+EOF
+
+test_expect_success 'log with config log.merges=show' '
+	git config log.merges show &&
+    git log --pretty=tformat:%s >actual &&
+	test_cmp both_commits_merges actual &&
+    git config --unset log.merges
+'
+
+test_expect_success 'log with config log.merges=only' '
+	git config log.merges only &&
+    git log --pretty=tformat:%s >actual &&
+	test_cmp only_merges actual &&
+    git config --unset log.merges
+'
+
+test_expect_success 'log with config log.merges=hide' '
+	git config log.merges hide &&
+    git log --pretty=tformat:%s >actual &&
+	test_cmp only_commits actual &&
+    git config --unset log.merges
+'
+
+test_expect_success 'log with config log.merges=show with git log --no-merges' '
+	git config log.merges show &&
+    git log --no-merges --pretty=tformat:%s >actual &&
+	test_cmp only_commits actual &&
+    git config --unset log.merges
+'
+
+test_expect_success 'log with config log.merges=hide with git log ---merges' '
+	git config log.merges hide &&
+    git log --merges --pretty=tformat:%s >actual &&
+	test_cmp only_merges actual &&
+    git config --unset log.merges
+'
+
+test_expect_success 'log --merges=show' '
+    git log --merges=show --pretty=tformat:%s >actual &&
+	test_cmp both_commits_merges actual
+'
+
+test_expect_success 'log --merges=only' '
+    git log --merges=only --pretty=tformat:%s >actual &&
+	test_cmp only_merges actual
+'
+
+test_expect_success 'log --merges=hide' '
+    git log --merges=hide --pretty=tformat:%s >actual &&
+	test_cmp only_commits actual
+'
+
+test_expect_success 'log --merges=show with config log.merges=hide' '
+	git config log.merges hide &&
+    git log --merges=show --pretty=tformat:%s >actual &&
+	test_cmp both_commits_merges actual &&
+    git config --unset log.merges
+'
+
+test_expect_success 'log --merges=show with config log.merges=only' '
+	git config log.merges only &&
+    git log --merges=show --pretty=tformat:%s >actual &&
+	test_cmp both_commits_merges actual &&
+    git config --unset log.merges
+'
+
+test_expect_success 'log --merges=only with config log.merges=show' '
+	git config log.merges show &&
+    git log --merges=only --pretty=tformat:%s >actual &&
+	test_cmp only_merges actual &&
+    git config --unset log.merges
+'
+
+test_expect_success 'log --merges=only with config log.merges=hide' '
+	git config log.merges hide &&
+    git log --merges=only --pretty=tformat:%s >actual &&
+	test_cmp only_merges actual &&
+    git config --unset log.merges
+'
+
+test_expect_success 'log --merges=hide with config log.merges=show' '
+	git config log.merges show &&
+    git log --merges=hide --pretty=tformat:%s >actual &&
+	test_cmp only_commits actual &&
+    git config --unset log.merges
+'
+
+test_expect_success 'log --merges=hide with config log.merges=only' '
+	git config log.merges only &&
+    git log --merges=hide --pretty=tformat:%s >actual &&
+	test_cmp only_commits actual &&
+    git config --unset log.merges
+'
+
 test_expect_success 'log --graph with merge' '
 	git log --graph --date-order --pretty=tformat:%s |
 		sed "s/ *\$//" >actual &&
-- 
2.3.3.263.g095251d.dirty
