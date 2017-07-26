Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83B9C20899
	for <e@80x24.org>; Wed, 26 Jul 2017 10:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751788AbdGZK1o (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jul 2017 06:27:44 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:55916 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751622AbdGZK1l (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2017 06:27:41 -0400
Received: from lindisfarne.localdomain ([92.22.28.33])
        by smtp.talktalk.net with SMTP
        id aJXGd63uhZtcPaJXXd3j2N; Wed, 26 Jul 2017 11:27:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1501064860; bh=7xeEKvRax+wSEh00XWp1jVM9qkPF25SnCFf0trw0t78=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=cMykxFS2dV9LYfzVPAty3zI1osDSE26WqudDtPXeg+V4xxc8G5CdyP+9Aj76//frU
         SEK+CH7JKvo2XhQUAf9A7oo9PvuykRa3yQGHN+NOkuA6+rlxT9rHk53DVuOHG+1n3n
         jPDTO/3t6XsGSbRgUArrB2q2tiDdBLUIrwhy4cbA=
X-Originating-IP: [92.22.28.33]
X-Spam: 0
X-OAuthority: v=2.2 cv=QqEc5h6d c=1 sm=1 tr=0 a=BeSdjzhxhZnKGFP9cxuqMA==:117
 a=BeSdjzhxhZnKGFP9cxuqMA==:17 a=evINK-nbAAAA:8 a=q0yqAvXvQUgnCnxUwMYA:9
 a=ROd-9-0NBTkDb1jS:21 a=Uoe-jRJ2baT2agM3:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [RFC PATCH 4/5] Add tests for rebase --continue --autostage
Date:   Wed, 26 Jul 2017 11:27:19 +0100
Message-Id: <20170726102720.15274-5-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.13.3
In-Reply-To: <20170726102720.15274-1-phillip.wood@talktalk.net>
References: <20170726102720.15274-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfIx3AlWW10xiA9vzg2g+F2Nlp7rv2wVYhLEW/D8+rX97AktAX2kyEuwRhRBt7AHZChE7ubh5zHISgALqKNLWkPwW34esN37J/b5rp510qHlOdcV6Mw2D
 5NQNPymo29RuOahS6yWLVNViAY70+V9AAcVN7YTuDoGA/scuA9k8Fyloe/26smlqCq1Mhw0nN0RbDB2YekWF9HBa+UyBk2dOYwzZrNPJraXnG1L0B+6VOvh/
 9PwtZo3chIjXlw5QqyGacN1lrphm1huIgCF14mYzYSet1yOw9/WTqCG1ZXivVnzE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Make sure that --autostage stages any changes and fails if there are
merge markers in the file to be staged.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t3418-rebase-continue.sh | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
index 4428b9086e8bcb383df801834d0de323f316f4fa..4e71e5d5c2f26866cd5d32bfea445f899398d6c9 100755
--- a/t/t3418-rebase-continue.sh
+++ b/t/t3418-rebase-continue.sh
@@ -14,7 +14,6 @@ test_expect_success 'setup' '
 
 	git checkout -b topic HEAD^ &&
 	test_commit "commit-new-file-F2-on-topic-branch" F2 22 &&
-
 	git checkout master
 '
 
@@ -40,6 +39,40 @@ test_expect_success 'non-interactive rebase --continue works with touched file'
 	git rebase --continue
 '
 
+reset () {
+	rm -fr .git/rebase-* &&
+	git reset --hard commit-new-file-F2-on-topic-branch &&
+	git checkout master
+}
+
+test_autostage () {
+	action=$1
+
+	test_expect_success "rebase $action --continue --autostage stages changes" '
+		reset &&
+		test_must_fail git rebase $action --onto master master topic &&
+		echo "Resolved" >F2 &&
+		git rebase --continue --autostage
+'
+
+	test_expect_success "rebase $action --continue --autostage fails when there are merge markers (1)" '
+		reset &&
+		test_must_fail git rebase $action --onto master master topic &&
+		test_must_fail git rebase --continue --autostage
+'
+
+	test_expect_success "rebase $action --continue --autostage  fails when there are merge markers (2)" '
+		reset &&
+		test_must_fail git rebase $action --onto master master topic &&
+		git reset -- F2 &&
+		test_must_fail git rebase --continue --autostage
+	'
+}
+
+test_autostage
+test_autostage -i
+test_autostage -m
+
 test_expect_success 'non-interactive rebase --continue with rerere enabled' '
 	test_config rerere.enabled true &&
 	test_when_finished "test_might_fail git rebase --abort" &&
-- 
2.13.3

