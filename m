From: Kevin Daudt <me@ikke.info>
Subject: [PATCH v2 1/2] t5520-pull: Simplify --rebase with dirty tree test
Date: Sat,  6 Jun 2015 23:12:24 +0200
Message-ID: <1433625145-29668-1-git-send-email-me@ikke.info>
References: <1433282157-8171-1-git-send-email-me@ikke.info>
Cc: Paul Tan <pyokagan@gmail.com>, git@vger.kernel.org,
	Kevin daudt <me@ikke.info>
To: "Junio C. Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 06 23:12:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1LOY-0001tM-1o
	for gcvg-git-2@plane.gmane.org; Sat, 06 Jun 2015 23:12:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422635AbbFFVMm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2015 17:12:42 -0400
Received: from ikke.info ([178.21.113.177]:51652 "EHLO vps892.directvps.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932432AbbFFVMl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2015 17:12:41 -0400
Received: by vps892.directvps.nl (Postfix, from userid 182)
	id 2AC791DCF6D; Sat,  6 Jun 2015 23:12:40 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on vps892.directvps.nl
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.1
Received: from ikke-laptop.ikke (unknown [10.8.0.6])
	by vps892.directvps.nl (Postfix) with ESMTP id 4C0071DCF6D;
	Sat,  6 Jun 2015 23:12:39 +0200 (CEST)
X-Mailer: git-send-email 2.4.2
In-Reply-To: <1433282157-8171-1-git-send-email-me@ikke.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270953>

Simplify the test case for testing git aborts the pull --rebase when the
work tree is dirty.

Signed-off-by: Kevin Daudt <me@ikke.info>
Helped-by: Paul Tan <pyokagan@gmail.com>
---
This is a preparation for the next pathch.

Changes since v1:
- Moved the tests just belof the first --rebase test
- Simplified both tests to only test if the rebase either succeded for
  failed


 t/t5520-pull.sh | 32 +++++++++++++-------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 7efd45b..925ad49 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -122,6 +122,19 @@ test_expect_success '--rebase' '
 	test $(git rev-parse HEAD^) = $(git rev-parse copy) &&
 	test new = $(git show HEAD:file2)
 '
+
+test_expect_success 'pull --rebase dies early with dirty working directory' '
+	git reset --hard before-rebase &&
+	before=$(git rev-parse --verify before-rebase) &&
+	test_config branch.to-rebase.rebase true &&
+	echo dirty >>file &&
+	cp file expect &&
+	git add file &&
+	test_must_fail git pull . copy &&
+	test $(git rev-parse --verify to-rebase) = $before &&
+	test_cmp file expect
+'
+
 test_expect_success 'pull.rebase' '
 	git reset --hard before-rebase &&
 	test_config pull.rebase true &&
@@ -278,25 +291,6 @@ test_expect_success 'rebased upstream + fetch + pull --rebase' '
 
 '
 
-test_expect_success 'pull --rebase dies early with dirty working directory' '
-
-	git checkout to-rebase &&
-	git update-ref refs/remotes/me/copy copy^ &&
-	COPY=$(git rev-parse --verify me/copy) &&
-	git rebase --onto $COPY copy &&
-	test_config branch.to-rebase.remote me &&
-	test_config branch.to-rebase.merge refs/heads/copy &&
-	test_config branch.to-rebase.rebase true &&
-	echo dirty >> file &&
-	git add file &&
-	test_must_fail git pull &&
-	test $COPY = $(git rev-parse --verify me/copy) &&
-	git checkout HEAD -- file &&
-	git pull &&
-	test $COPY != $(git rev-parse --verify me/copy)
-
-'
-
 test_expect_success 'pull --rebase works on branch yet to be born' '
 	git rev-parse master >expect &&
 	mkdir empty_repo &&
-- 
2.4.2
