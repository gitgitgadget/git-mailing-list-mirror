Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72B7D1F991
	for <e@80x24.org>; Wed,  2 Aug 2017 10:44:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752852AbdHBKow (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Aug 2017 06:44:52 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:10764 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752577AbdHBKou (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2017 06:44:50 -0400
Received: from lindisfarne.localdomain ([92.22.28.33])
        by smtp.talktalk.net with SMTP
        id cr8nd8nSUiSHacr8zdwinx; Wed, 02 Aug 2017 11:44:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1501670689; bh=i+Nlp9PF1AfHZQt+teuErXgbycfJzIqYojYXmVOHy3s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=i8uEg2uzyPQMzWxAX0k7kSP6AKYdHMSs9RhF0Xff4CTFOhoQMKiCHUN6A7G0lhITH
         a78I1LLY1pFmWKOuda+U1wp3vh3KLQ9UEJx2V/6hy/GQzR8u9pPB14sfqjVmklwcap
         qmXpr0TbhFv9s3Jgog+woRyjFaAtHSEL9wOp52OM=
X-Originating-IP: [92.22.28.33]
X-Spam: 0
X-OAuthority: v=2.2 cv=UoATD64B c=1 sm=1 tr=0 a=BeSdjzhxhZnKGFP9cxuqMA==:117
 a=BeSdjzhxhZnKGFP9cxuqMA==:17 a=evINK-nbAAAA:8 a=ybZZDoGAAAAA:8
 a=1GoPJPuayXcPpOOgDuQA:9 a=aELoKnN1OsnrT1SA:21 a=a3k4yHTwTw0fwyIl:21
 a=RfR_gqz1fSpA9VikTjo0:22 a=0RhZnL1DYvcuLYC8JZ5M:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 2/6] rebase: honor --rerere-autoupdate
Date:   Wed,  2 Aug 2017 11:44:16 +0100
Message-Id: <20170802104420.12809-3-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.13.3
In-Reply-To: <20170802104420.12809-1-phillip.wood@talktalk.net>
References: <20170802104420.12809-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfF6fWZIVaOiFSYBjC/Gxl8S6yJ08Rz3yIex//sDF/XiAdK07nMR4nmGMzAQKSfVLK5GHn4zInnyYx/VmLTVyvLVtZmytS3jgJbZ1ICgAGl2lfTIubPoD
 DtJDbypgZIfYFZehKKyPLBNbcMHLiwfR8zuyCOxExIOqIVoAXcGddVjwQWiFyS3YUGG89eyQalOpREROfTIV4q1vPk8TZG0AgAC0IaQYWfBN69aGzpZliIP/
 urQEJXngqoYPL/cRdR2gLA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Rebase accepts '--rerere-autoupdate' as an option but only honors it
if '-m' is also given. Fix it for a non-interactive rebase by passing
on the option to 'git am' and 'git cherry-pick'. Rework the tests so
that they can be used for each rebase flavor and extend them.

Reported-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 git-rebase--am.sh          |  3 +-
 t/t3418-rebase-continue.sh | 82 +++++++++++++++++++++++++++++++---------------
 2 files changed, 57 insertions(+), 28 deletions(-)

diff --git a/git-rebase--am.sh b/git-rebase--am.sh
index 375239341fbfe885e51a25e9e0dc2d4fee791345..319933e70a34f9da4ec93d063eb102eff33b6787 100644
--- a/git-rebase--am.sh
+++ b/git-rebase--am.sh
@@ -45,7 +45,7 @@ then
 	# itself well to recording empty patches.  fortunately, cherry-pick
 	# makes this easy
 	git cherry-pick ${gpg_sign_opt:+"$gpg_sign_opt"} --allow-empty \
-		--right-only "$revisions" \
+		$allow_rerere_autoupdate --right-only "$revisions" \
 		${restrict_revision+^$restrict_revision}
 	ret=$?
 else
@@ -82,6 +82,7 @@ else
 	fi
 
 	git am $git_am_opt --rebasing --resolvemsg="$resolvemsg" \
+		$allow_rerere_autoupdate \
 		${gpg_sign_opt:+"$gpg_sign_opt"} <"$GIT_DIR/rebased-patches"
 	ret=$?
 
diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
index 4428b9086e8bcb383df801834d0de323f316f4fa..2b746f1559ad21a5ebf3bebd726c9a1b3d071c5a 100755
--- a/t/t3418-rebase-continue.sh
+++ b/t/t3418-rebase-continue.sh
@@ -40,25 +40,6 @@ test_expect_success 'non-interactive rebase --continue works with touched file'
 	git rebase --continue
 '
 
-test_expect_success 'non-interactive rebase --continue with rerere enabled' '
-	test_config rerere.enabled true &&
-	test_when_finished "test_might_fail git rebase --abort" &&
-	git reset --hard commit-new-file-F2-on-topic-branch &&
-	git checkout master &&
-	rm -fr .git/rebase-* &&
-
-	test_must_fail git rebase --onto master master topic &&
-	echo "Resolved" >F2 &&
-	git add F2 &&
-	cp F2 F2.expected &&
-	git rebase --continue &&
-
-	git reset --hard commit-new-file-F2-on-topic-branch &&
-	git checkout master &&
-	test_must_fail git rebase --onto master master topic &&
-	test_cmp F2.expected F2
-'
-
 test_expect_success 'rebase --continue can not be used with other options' '
 	test_must_fail git rebase -v --continue &&
 	test_must_fail git rebase --continue -v
@@ -93,25 +74,72 @@ test_expect_success 'rebase --continue remembers merge strategy and options' '
 	test -f funny.was.run
 '
 
-test_expect_success 'rebase --continue remembers --rerere-autoupdate' '
+test_expect_success 'setup rerere database' '
 	rm -fr .git/rebase-* &&
 	git reset --hard commit-new-file-F3-on-topic-branch &&
 	git checkout master &&
 	test_commit "commit-new-file-F3" F3 3 &&
-	git config rerere.enabled true &&
+	test_config rerere.enabled true &&
 	test_must_fail git rebase -m master topic &&
 	echo "Resolved" >F2 &&
+	cp F2 expected-F2 &&
 	git add F2 &&
 	test_must_fail git rebase --continue &&
 	echo "Resolved" >F3 &&
+	cp F3 expected-F3 &&
 	git add F3 &&
 	git rebase --continue &&
-	git reset --hard topic@{1} &&
-	test_must_fail git rebase -m --rerere-autoupdate master &&
-	test "$(cat F2)" = "Resolved" &&
-	test_must_fail git rebase --continue &&
-	test "$(cat F3)" = "Resolved" &&
-	git rebase --continue
+	git reset --hard topic@{1}
 '
 
+prepare () {
+	rm -fr .git/rebase-* &&
+	git reset --hard commit-new-file-F3-on-topic-branch &&
+	git checkout master &&
+	test_config rerere.enabled true
+}
+
+test_rerere_autoupdate () {
+	action=$1 &&
+	test_expect_success "rebase $action --continue remembers --rerere-autoupdate" '
+		prepare &&
+		test_must_fail git rebase $action --rerere-autoupdate master topic &&
+		test_cmp expected-F2 F2 &&
+		git diff-files --quiet &&
+		test_must_fail git rebase --continue &&
+		test_cmp expected-F3 F3 &&
+		git diff-files --quiet &&
+		git rebase --continue
+	'
+
+	test_expect_success "rebase $action --continue honors rerere.autoUpdate" '
+		prepare &&
+		test_config rerere.autoupdate true &&
+		test_must_fail git rebase $action master topic &&
+		test_cmp expected-F2 F2 &&
+		git diff-files --quiet &&
+		test_must_fail git rebase --continue &&
+		test_cmp expected-F3 F3 &&
+		git diff-files --quiet &&
+		git rebase --continue
+	'
+
+	test_expect_success "rebase $action --continue remembers --no-rerere-autoupdate" '
+		prepare &&
+		test_config rerere.autoupdate true &&
+		test_must_fail git rebase $action --no-rerere-autoupdate master topic &&
+		test_cmp expected-F2 F2 &&
+		test_must_fail git diff-files --quiet &&
+		git add F2 &&
+		test_must_fail git rebase --continue &&
+		test_cmp expected-F3 F3 &&
+		test_must_fail git diff-files --quiet &&
+		git add F3 &&
+		git rebase --continue
+	'
+}
+
+test_rerere_autoupdate
+test_rerere_autoupdate -m
+
 test_done
-- 
2.13.3

