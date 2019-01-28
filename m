Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46A321F453
	for <e@80x24.org>; Mon, 28 Jan 2019 10:27:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfA1K1y (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Jan 2019 05:27:54 -0500
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:12175 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbfA1K1y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jan 2019 05:27:54 -0500
Received: from lindisfarne.localdomain ([92.22.28.19])
        by smtp.talktalk.net with SMTP
        id o48ogLKdyoI6Lo48tgOUlL; Mon, 28 Jan 2019 10:27:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1548671272;
        bh=BfMrl4/Q9th6+b2R3Jz/+ZQjxcwemjZV4zNavEcBnkc=;
        h=From:To:Cc:Subject:Date:Reply-To;
        b=ksHCxCHzJEn41M1doz9p2sExFwLEg9KiujjYAinHbYySnAL7Rvm3TfhgpHoy40jA4
         jyLvVfeb/JLdfX8KiW4Dp5va60nu/K9pkZICft6xdFpQTR1Fbe3bJTt+UbWaAvluDY
         4bw4JYzECft+INNghbkbJo4RTQ0Xb4jCxE2ZfoYI=
X-Originating-IP: [92.22.28.19]
X-Spam: 0
X-OAuthority: v=2.3 cv=FOE1Odgs c=1 sm=1 tr=0 a=9gbt3CTG59kvQAKbLaJjPA==:117
 a=9gbt3CTG59kvQAKbLaJjPA==:17 a=evINK-nbAAAA:8 a=6ii0WbWA_mWsRorEkHwA:9
 a=IRE8gornbkEVbH4e:21 a=yrD7ZrPnyWDIKmET:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH] implicit interactive rebase: don't run sequence editor
Date:   Mon, 28 Jan 2019 10:27:56 +0000
Message-Id: <20190128102756.19152-1-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.20.1
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfHcQcOKO9GC1rSKzbJ8kpCH89mK5cF6Ms7SqwrJVpGswHj86S5Mi+lCvzH3AX3llqusWQ1oUj9EehVqxtR1z6rM90ZW5pCzeBM9t8zP73QzGuK8Bj1LV
 x5abIPYR4NqHmjagGMJNIk2oDOaXqpG0dCSQd1xsEo/Nnlq0vjFP6QzYaUevrcTv1PyTy6xQW+/DsiSH+ykN0okBVRPexMnd0IaB27TmU4F8N+ZbE7rHzHZl
 dEon18yekU1rkerAFRto0UpnDLQKG32U7STSicS23AP6BqT7HSUs6CVryfuS33r9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

If GIT_SEQUENCE_EDITOR is set then rebase runs it when executing
implicit interactive rebases which are supposed to appear
non-interactive to the user. Fix this by setting GIT_SEQUENCE_EDITOR=:
rather than GIT_EDITOR=:. A couple of tests relied on the old behavior
so they are updated to work with the new regime.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/rebase.c                   |  5 +++--
 git-legacy-rebase.sh               |  4 ++--
 t/t3404-rebase-interactive.sh      |  5 +++++
 t/t3430-rebase-merges.sh           |  2 +-
 t/t7505-prepare-commit-msg-hook.sh | 10 +++++-----
 5 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 00de70365e..7c11b4ac7f 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -354,7 +354,8 @@ static int run_specific_rebase(struct rebase_options *opts)
 		argv_array_pushf(&child.env_array, "GIT_CHERRY_PICK_HELP=%s",
 				 resolvemsg);
 		if (!(opts->flags & REBASE_INTERACTIVE_EXPLICIT)) {
-			argv_array_push(&child.env_array, "GIT_EDITOR=:");
+			argv_array_push(&child.env_array,
+					"GIT_SEQUENCE_EDITOR=:");
 			opts->autosquash = 0;
 		}
 
@@ -475,7 +476,7 @@ static int run_specific_rebase(struct rebase_options *opts)
 	if (is_interactive(opts) &&
 	    !(opts->flags & REBASE_INTERACTIVE_EXPLICIT)) {
 		strbuf_addstr(&script_snippet,
-			      "GIT_EDITOR=:; export GIT_EDITOR; ");
+			      "GIT_SEQUENCE_EDITOR=:; export GIT_SEQUENCE_EDITOR; ");
 		opts->autosquash = 0;
 	}
 
diff --git a/git-legacy-rebase.sh b/git-legacy-rebase.sh
index b4c7dbfa57..41f7799bb5 100755
--- a/git-legacy-rebase.sh
+++ b/git-legacy-rebase.sh
@@ -168,8 +168,8 @@ run_interactive () {
 
 run_specific_rebase () {
 	if [ "$interactive_rebase" = implied ]; then
-		GIT_EDITOR=:
-		export GIT_EDITOR
+		GIT_SEQUENCE_EDITOR=:
+		export GIT_SEQUENCE_EDITOR
 		autosquash=
 	fi
 
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 7a440e08d8..2b961745cc 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -156,6 +156,11 @@ test_expect_success 'rebase -i with exec of inexistent command' '
 	! grep "Maybe git-rebase is broken" actual
 '
 
+test_expect_success 'implicit interactive rebase does not invoke sequence editor' '
+	test_when_finished "git rebase --abort ||:" &&
+	GIT_SEQUENCE_EDITOR="echo bad >" git rebase -x"echo one" @^
+'
+
 test_expect_success 'no changes are a nop' '
 	git checkout branch2 &&
 	set_fake_editor &&
diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
index cc5646836f..4c69255ee6 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -125,7 +125,7 @@ test_expect_success '`reset` refuses to overwrite untracked files' '
 	: >dont-overwrite-untracked.t &&
 	echo "reset refs/tags/dont-overwrite-untracked" >script-from-scratch &&
 	test_config sequence.editor \""$PWD"/replace-editor.sh\" &&
-	test_must_fail git rebase -r HEAD &&
+	test_must_fail git rebase -ir HEAD &&
 	git rebase --abort
 '
 
diff --git a/t/t7505-prepare-commit-msg-hook.sh b/t/t7505-prepare-commit-msg-hook.sh
index ebfcad9c4c..ba8bd1b514 100755
--- a/t/t7505-prepare-commit-msg-hook.sh
+++ b/t/t7505-prepare-commit-msg-hook.sh
@@ -215,7 +215,7 @@ test_expect_success 'with hook and editor (merge)' '
 test_rebase () {
 	expect=$1 &&
 	mode=$2 &&
-	test_expect_$expect C_LOCALE_OUTPUT "with hook (rebase $mode)" '
+	test_expect_$expect C_LOCALE_OUTPUT "with hook (rebase ${mode:--i})" '
 		test_when_finished "\
 			git rebase --abort
 			git checkout -f master
@@ -225,7 +225,7 @@ test_rebase () {
 		GIT_EDITOR="\"$FAKE_EDITOR\"" &&
 		(
 			export GIT_SEQUENCE_EDITOR GIT_EDITOR &&
-			test_must_fail git rebase $mode b &&
+			test_must_fail git rebase -i $mode b &&
 			echo x >a &&
 			git add a &&
 			test_must_fail git rebase --continue &&
@@ -241,18 +241,18 @@ test_rebase () {
 			git add b &&
 			git rebase --continue
 		) &&
-		if test $mode = -p # reword amended after pick
+		if test "$mode" = -p # reword amended after pick
 		then
 			n=18
 		else
 			n=17
 		fi &&
 		git log --pretty=%s -g -n$n HEAD@{1} >actual &&
-		test_cmp "$TEST_DIRECTORY/t7505/expected-rebase$mode" actual
+		test_cmp "$TEST_DIRECTORY/t7505/expected-rebase${mode:--i}" actual
 	'
 }
 
-test_rebase success -i
+test_rebase success
 test_have_prereq !REBASE_P || test_rebase success -p
 
 test_expect_success 'with hook (cherry-pick)' '
-- 
2.20.1

