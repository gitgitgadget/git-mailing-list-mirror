Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8CD320899
	for <e@80x24.org>; Wed, 26 Jul 2017 10:27:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751791AbdGZK1x (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jul 2017 06:27:53 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:8741 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751529AbdGZK1j (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2017 06:27:39 -0400
Received: from lindisfarne.localdomain ([92.22.28.33])
        by smtp.talktalk.net with SMTP
        id aJXGd63uhZtcPaJXVd3j2E; Wed, 26 Jul 2017 11:27:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1501064858; bh=krG7VX3lV9PRd1B1S1CR9wXhcmd12lHGckff5ZxeVzc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=DPMG8ra3dhhlXb1HRQW22jku2L2CpKAslIjfpY8srL27fBrvvn4wUhFrbJP1lFTYF
         72oWhzFbudnNs6M0cLqkqIqZ3rLxZJcwd4mp0dhkmS+4v5OgujLJT2H7CKTIA2M9ld
         aQfpxNygoui4Zj5JYhen97+c6EE382QBKuOwoMX8=
X-Originating-IP: [92.22.28.33]
X-Spam: 0
X-OAuthority: v=2.2 cv=QqEc5h6d c=1 sm=1 tr=0 a=BeSdjzhxhZnKGFP9cxuqMA==:117
 a=BeSdjzhxhZnKGFP9cxuqMA==:17 a=evINK-nbAAAA:8 a=iJeqRuWp17NkU_KW1ooA:9
 a=Ak0huoSASxWQl5gX:21 a=JDRHe9OTiVs9Qw74:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [RFC PATCH 2/5] rebase -i: improve --continue --autostage
Date:   Wed, 26 Jul 2017 11:27:17 +0100
Message-Id: <20170726102720.15274-3-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.13.3
In-Reply-To: <20170726102720.15274-1-phillip.wood@talktalk.net>
References: <20170726102720.15274-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfDOU1ByDaVzc65QMnjuHzlWH75gIxA/3/jSKpcv4xDOQviVNFVCxjP7sIbz2aQdFX8ndiDtNaILAi8+JkiK8Q/0WJtKdd7R6n9SuFJEb7+NW53FWv09M
 GA1Q3ubDz3Xip7v5aPtpaTa/iwsz/1SQfxPg/flduIyEQdW+hhkHz9MvbcB50S8vAarPvSgFKKm7V9T8vW2Td/a0YcJdXispEMpi+ccEkCP8pNV5yMdmHrw0
 PXQJmBeRSWLwG8N40Jf8g1e/jzwtNd49gbJ9Oc2sNTSymYoqWpap4ePmBpmIYGm6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

If HEAD has changed since the rebase stopped or rebase stopped due to
a failed exec then 'git rebase --continue --autostage' will autostage
changes that cannot be commited. Fix this by reordering some of the
checks so that 'git rebase --continue --autostage' never stages
changes unless they can be committed. Also reword some error
messages to account of --autostage and try and make them clearer.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---

This could do with some tests the check the correct error message is
given in each failure case. However I'm expecting to change the error
messages based on the feedback I get to this patch so I'll add the
tests once the messages are finalized. I've tried to give a bit more
explanation in the error messages as I found some of the previous
messages didn't explain why rebase couldn't continue. Splitting the
advice out means it is consistent between different code paths and
should make it easier to optionally disable it in future if anyone
wanted to add that. As for the formatting of the messages I wonder if
they would be better without so many empty lines (I find the current
messages a bit intimating as they seem so long). e.g.

If you wish to squash the unstaged changes into the last commit, run:
    git add -u
    git commit --amend \$gpg_sign_opt_quoted
If they are meant to go into a new commit, run:
    git add -u
    git commit \$gpg_sign_opt_quoted
In both cases, once you're done, continue with:
    git rebase --continue

Instead of

If you wish to squash the unstaged changes into the last commit, run:

  git add -u
  git commit --amend \$gpg_sign_opt_quoted

If they are meant to go into a new commit, run:

  git add -u
  git commit \$gpg_sign_opt_quoted

In both cases, once you're done, continue with:

  git rebase --continue


 git-rebase--interactive.sh    | 104 ++++++++++++++++++++++++++++++++----------
 t/t3404-rebase-interactive.sh |   2 +-
 2 files changed, 81 insertions(+), 25 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 4c037a3f7a9e01406c4205bf8786a3da5060381f..8140c88839b4f3a86f53faaaa2ba4433ecc7f58b 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -1056,6 +1056,42 @@ The possible behaviours are: ignore, warn, error.")"
 	fi
 }
 
+unstaged_advice () {
+	gpg_sign_opt_quoted=${gpg_sign_opt:+$(git rev-parse --sq-quote "$gpg_sign_opt")}
+	eval_gettext "\
+If you wish to squash the unstaged changes into the last commit, run:
+
+  git add -u
+  git commit --amend \$gpg_sign_opt_quoted
+
+If they are meant to go into a new commit, run:
+
+  git add -u
+  git commit \$gpg_sign_opt_quoted
+
+In both cases, once you're done, continue with:
+
+  git rebase --continue
+"
+}
+
+staged_advice () {
+	gpg_sign_opt_quoted=${gpg_sign_opt:+$(git rev-parse --sq-quote "$gpg_sign_opt")}
+	eval_gettext "\
+If you wish to squash the staged changes into the last commit, run:
+
+  git commit --amend \$gpg_sign_opt_quoted
+
+If they are meant to go into a new commit, run:
+
+  git commit \$gpg_sign_opt_quoted
+
+In both cases, once you're done, continue with:
+
+  git rebase --continue
+"
+}
+
 # The whole contents of this file is run by dot-sourcing it from
 # inside a shell function.  It used to be that "return"s we see
 # below were not inside any function, and expected to return
@@ -1067,9 +1103,50 @@ The possible behaviours are: ignore, warn, error.")"
 # here, and immediately call it after defining it.
 git_rebase__interactive () {
 
+amend_head='' amend_ok=''
 case "$action" in
 continue)
-	check_unstaged
+	test -f "$amend" &&
+		amend_head=$(cat "$amend") &&
+		test $amend_head = $(git rev-parse HEAD) &&
+		amend_ok=1
+	git update-index --refresh --ignore-submodules >/dev/null
+	git diff-files --quiet --ignore-submodules
+	unstaged=$?
+	if ! test -f "$author_script"
+	then
+		if test $unstaged = 1
+		then
+			die "$(gettext "Not expecting unstaged changes.")
+$(unstaged_advice)"
+		elif ! git diff-index --cached --quiet --ignore-submodules HEAD --
+		then
+			die "$(gettext "Not expecting staged changes.")
+$(staged_advice)"
+		fi
+	fi
+	if test $unstaged = 1 && test $autostage = true
+	then
+		if test -n "$amend_head" && test -z "$amend_ok"
+		then
+			die "$(gettext "\
+Unable to commit changes as HEAD has changed since git rebase stopped.")
+$(unstaged_advice)"
+		else
+			check_autostage
+		fi
+	elif test $unstaged = 1
+	then
+		if test -n "$amend_head" && test -z "$amend_ok"
+		then
+			die "$(gettext "\
+Unable to continue rebasing as there are unstaged changes and
+HEAD has changed since git rebase stopped.")
+$(unstaged_advice)"
+		else
+			die "$(autostage_advice)"
+		fi
+	fi
 	if test ! -d "$rewritten"
 	then
 		exec git rebase--helper ${force_rebase:+--no-ff} --continue
@@ -1083,31 +1160,11 @@ continue)
 		rm "$GIT_DIR"/CHERRY_PICK_HEAD ||
 		die "$(gettext "Could not remove CHERRY_PICK_HEAD")"
 	else
-		if ! test -f "$author_script"
-		then
-			gpg_sign_opt_quoted=${gpg_sign_opt:+$(git rev-parse --sq-quote "$gpg_sign_opt")}
-			die "$(eval_gettext "\
-You have staged changes in your working tree.
-If these changes are meant to be
-squashed into the previous commit, run:
-
-  git commit --amend \$gpg_sign_opt_quoted
-
-If they are meant to go into a new commit, run:
-
-  git commit \$gpg_sign_opt_quoted
-
-In both cases, once you're done, continue with:
-
-  git rebase --continue
-")"
-		fi
 		. "$author_script" ||
 			die "$(gettext "Error trying to find the author identity to amend commit")"
-		if test -f "$amend"
+		if test -n "$amend_head"
 		then
-			current_head=$(git rev-parse --verify HEAD)
-			test "$current_head" = $(cat "$amend") ||
+			test -n "$amend_ok" ||
 			die "$(gettext "\
 You have uncommitted changes in your working tree. Please commit them
 first and then run 'git rebase --continue' again.")"
@@ -1126,7 +1183,6 @@ first and then run 'git rebase --continue' again.")"
 		record_in_rewritten "$(cat "$state_dir"/stopped-sha)"
 	fi
 
-	require_clean_work_tree "rebase"
 	do_rest
 	return 0
 	;;
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 37821d245433f757fa13f0a3e27da0312bebb7db..3eed8a3bc5a8e9c3bae32e181d367d9a9c0aff80 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -563,7 +563,7 @@ test_expect_success 'clean error after failed "exec"' '
 	echo "edited again" > file7 &&
 	git add file7 &&
 	test_must_fail git rebase --continue 2>error &&
-	test_i18ngrep "you have staged changes in your working tree" error
+	test_i18ngrep "Not expecting staged changes" error
 '
 
 test_expect_success 'rebase a detached HEAD' '
-- 
2.13.3

