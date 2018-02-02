Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EE431F576
	for <e@80x24.org>; Fri,  2 Feb 2018 06:29:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750773AbeBBG3I (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Feb 2018 01:29:08 -0500
Received: from genki.is ([159.203.135.224]:56012 "EHLO genki.is"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750714AbeBBG3G (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Feb 2018 01:29:06 -0500
X-Greylist: delayed 495 seconds by postgrey-1.27 at vger.kernel.org; Fri, 02 Feb 2018 01:29:06 EST
Received: from localhost (c-73-47-239-165.hsd1.nh.comcast.net [73.47.239.165])
        by genki.is (Postfix) with ESMTPSA id 891D240731;
        Fri,  2 Feb 2018 06:20:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 genki.is 891D240731
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=genki.is;
        s=genkimail; t=1517552450;
        bh=RwUdCZrIFcDjLa1QkDspto1XSSOI2uAG0zy4Q/jKJ0U=;
        h=Date:From:Subject:To:Cc:From;
        b=KsXLFZ1Z1bB59QJw3xYRFkJKYy0Jhjvdwn6Xaff/RWLtQ0OPHjFmYh17mkTSVhnNX
         ZaobBW+3roALT5QwAyuPTfdrP/4ZvspoK8YICnqmd71Oa4+EUxAWi4enRNl3CrERAN
         K+g7mcAkzXye5fj5d3Up+8i/rmbomHVqQfpW+wmg=
Date:   Fri, 02 Feb 2018 01:20:49 -0500
Message-Id: <9d0414b869f21f38b81f92ee0619fd76410cbcfc.1517552392.git.sky@genki.is>
From:   Genki Sky <sky@genki.is>
Subject: [PATCH] rebase: add --allow-empty-message option
To:     git@vger.kernel.org
Cc:     sky@genki.is, Chris Webb <chris@arachsys.com>,
        Junio C Hamano <gitster@pobox.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--> Motivation

commit 4bee95847 ("cherry-pick: add --allow-empty-message option", 2012-08-02)
started doing this work, but it was never completed. For more discussion
on why this approach was chosen, see the thread beginning here:

  https://public-inbox.org/git/20120801111658.GA21272@arachsys.com/

https://stackoverflow.com/q/8542304 also shows this as a desirable
feature, and that the workaround is non-trivial to get right.

--> Implementation

Add a new --allow-empty-message flag. Propagate it to all calls of 'git
commit', 'git cherry-pick', and 'git rebase--helper' within the rebase
scripts.

Signed-off-by: Genki Sky <sky@genki.is>
---
 Documentation/git-rebase.txt    |  5 +++
 builtin/rebase--helper.c        |  2 ++
 git-rebase--am.sh               |  1 +
 git-rebase--interactive.sh      | 25 +++++++------
 git-rebase--merge.sh            |  3 +-
 git-rebase.sh                   |  5 +++
 t/t3430-rebase-empty-message.sh | 79 +++++++++++++++++++++++++++++++++++++++++
 7 files changed, 109 insertions(+), 11 deletions(-)
 create mode 100755 t/t3430-rebase-empty-message.sh

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 8a861c1e0..d713951b8 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -244,6 +244,11 @@ leave out at most one of A and B, in which case it defaults to HEAD.
 	Keep the commits that do not change anything from its
 	parents in the result.

+--allow-empty-message::
+	By default, rebasing commits with an empty message will fail.
+	This option overrides that behavior, allowing commits with empty
+	messages to be rebased.
+
 --skip::
 	Restart the rebasing process by skipping the current patch.

diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
index 7daee544b..2090114e9 100644
--- a/builtin/rebase--helper.c
+++ b/builtin/rebase--helper.c
@@ -22,6 +22,8 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT_BOOL(0, "ff", &opts.allow_ff, N_("allow fast-forward")),
 		OPT_BOOL(0, "keep-empty", &keep_empty, N_("keep empty commits")),
+		OPT_BOOL(0, "allow-empty-message", &opts.allow_empty_message,
+			N_("allow commits with empty messages")),
 		OPT_CMDMODE(0, "continue", &command, N_("continue rebase"),
 				CONTINUE),
 		OPT_CMDMODE(0, "abort", &command, N_("abort rebase"),
diff --git a/git-rebase--am.sh b/git-rebase--am.sh
index 14c50782e..0f7805179 100644
--- a/git-rebase--am.sh
+++ b/git-rebase--am.sh
@@ -46,6 +46,7 @@ then
 	# makes this easy
 	git cherry-pick ${gpg_sign_opt:+"$gpg_sign_opt"} --allow-empty \
 		$allow_rerere_autoupdate --right-only "$revisions" \
+		$allow_empty_message \
 		${restrict_revision+^$restrict_revision}
 	ret=$?
 else
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index d47bd2959..81c5b4287 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -281,7 +281,7 @@ pick_one () {

 	test -d "$rewritten" &&
 		pick_one_preserving_merges "$@" && return
-	output eval git cherry-pick $allow_rerere_autoupdate \
+	output eval git cherry-pick $allow_rerere_autoupdate $allow_empty_message \
 			${gpg_sign_opt:+$(git rev-parse --sq-quote "$gpg_sign_opt")} \
 			"$strategy_args" $empty_args $ff "$@"

@@ -406,6 +406,7 @@ pick_one_preserving_merges () {
 			;;
 		*)
 			output eval git cherry-pick $allow_rerere_autoupdate \
+				$allow_empty_message \
 				${gpg_sign_opt:+$(git rev-parse --sq-quote "$gpg_sign_opt")} \
 				"$strategy_args" "$@" ||
 				die_with_patch $sha1 "$(eval_gettext "Could not pick \$sha1")"
@@ -559,7 +560,8 @@ do_next () {

 		mark_action_done
 		do_pick $sha1 "$rest"
-		git commit --amend --no-post-rewrite ${gpg_sign_opt:+"$gpg_sign_opt"} || {
+		git commit --amend --no-post-rewrite ${gpg_sign_opt:+"$gpg_sign_opt"} \
+			$allow_empty_message || {
 			warn "$(eval_gettext "\
 Could not amend commit after successfully picking \$sha1... \$rest
 This is most likely due to an empty commit message, or the pre-commit hook
@@ -607,7 +609,7 @@ you are able to reword the commit.")"
 			# This is an intermediate commit; its message will only be
 			# used in case of trouble.  So use the long version:
 			do_with_author output git commit --amend --no-verify -F "$squash_msg" \
-				${gpg_sign_opt:+"$gpg_sign_opt"} ||
+				${gpg_sign_opt:+"$gpg_sign_opt"} $allow_empty_message ||
 				die_failed_squash $sha1 "$rest"
 			;;
 		*)
@@ -615,13 +617,13 @@ you are able to reword the commit.")"
 			if test -f "$fixup_msg"
 			then
 				do_with_author git commit --amend --no-verify -F "$fixup_msg" \
-					${gpg_sign_opt:+"$gpg_sign_opt"} ||
+					${gpg_sign_opt:+"$gpg_sign_opt"} $allow_empty_message ||
 					die_failed_squash $sha1 "$rest"
 			else
 				cp "$squash_msg" "$GIT_DIR"/SQUASH_MSG || exit
 				rm -f "$GIT_DIR"/MERGE_MSG
 				do_with_author git commit --amend --no-verify -F "$GIT_DIR"/SQUASH_MSG -e \
-					${gpg_sign_opt:+"$gpg_sign_opt"} ||
+					${gpg_sign_opt:+"$gpg_sign_opt"} $allow_empty_message ||
 					die_failed_squash $sha1 "$rest"
 			fi
 			rm -f "$squash_msg" "$fixup_msg"
@@ -754,7 +756,8 @@ case "$action" in
 continue)
 	if test ! -d "$rewritten"
 	then
-		exec git rebase--helper ${force_rebase:+--no-ff} --continue
+		exec git rebase--helper ${force_rebase:+--no-ff} $allow_empty_message \
+			--continue
 	fi
 	# do we have anything to commit?
 	if git diff-index --cached --quiet HEAD --
@@ -794,11 +797,11 @@ In both cases, once you're done, continue with:
 You have uncommitted changes in your working tree. Please commit them
 first and then run 'git rebase --continue' again.")"
 			do_with_author git commit --amend --no-verify -F "$msg" -e \
-				${gpg_sign_opt:+"$gpg_sign_opt"} ||
+				${gpg_sign_opt:+"$gpg_sign_opt"} $allow_empty_message ||
 				die "$(gettext "Could not commit staged changes.")"
 		else
 			do_with_author git commit --no-verify -F "$msg" -e \
-				${gpg_sign_opt:+"$gpg_sign_opt"} ||
+				${gpg_sign_opt:+"$gpg_sign_opt"} $allow_empty_message ||
 				die "$(gettext "Could not commit staged changes.")"
 		fi
 	fi
@@ -817,7 +820,8 @@ skip)

 	if test ! -d "$rewritten"
 	then
-		exec git rebase--helper ${force_rebase:+--no-ff} --continue
+		exec git rebase--helper ${force_rebase:+--no-ff} $allow_empty_message \
+			--continue
 	fi
 	do_rest
 	return 0
@@ -1016,7 +1020,8 @@ checkout_onto
 if test -z "$rebase_root" && test ! -d "$rewritten"
 then
 	require_clean_work_tree "rebase"
-	exec git rebase--helper ${force_rebase:+--no-ff} --continue
+	exec git rebase--helper ${force_rebase:+--no-ff} $allow_empty_message \
+		--continue
 fi
 do_rest

diff --git a/git-rebase--merge.sh b/git-rebase--merge.sh
index 06a4723d4..1831e589b 100644
--- a/git-rebase--merge.sh
+++ b/git-rebase--merge.sh
@@ -27,7 +27,8 @@ continue_merge () {
 	cmt=$(cat "$state_dir/current")
 	if ! git diff-index --quiet --ignore-submodules HEAD --
 	then
-		if ! git commit ${gpg_sign_opt:+"$gpg_sign_opt"} --no-verify -C "$cmt"
+		if ! git commit ${gpg_sign_opt:+"$gpg_sign_opt"} $allow_empty_message \
+			--no-verify -C "$cmt"
 		then
 			echo "Commit failed, please do not call \"git commit\""
 			echo "directly, but instead do one of the following: "
diff --git a/git-rebase.sh b/git-rebase.sh
index fd72a35c6..b353c33d4 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -24,6 +24,7 @@ m,merge!           use merging strategies to rebase
 i,interactive!     let the user edit the list of commits to rebase
 x,exec=!           add exec lines after each commit of the editable list
 k,keep-empty	   preserve empty commits during rebase
+allow-empty-message allow rebasing commits with empty messages
 f,force-rebase!    force rebase even if branch is up to date
 X,strategy-option=! pass the argument through to the merge strategy
 stat!              display a diffstat of what changed upstream
@@ -89,6 +90,7 @@ action=
 preserve_merges=
 autosquash=
 keep_empty=
+allow_empty_message=
 test "$(git config --bool rebase.autosquash)" = "true" && autosquash=t
 case "$(git config --bool commit.gpgsign)" in
 true)	gpg_sign_opt=-S ;;
@@ -262,6 +264,9 @@ do
 	--keep-empty)
 		keep_empty=yes
 		;;
+	--allow-empty-message)
+		allow_empty_message=--allow-empty-message
+		;;
 	--preserve-merges)
 		preserve_merges=t
 		test -z "$interactive_rebase" && interactive_rebase=implied
diff --git a/t/t3430-rebase-empty-message.sh b/t/t3430-rebase-empty-message.sh
new file mode 100755
index 000000000..74af73f3c
--- /dev/null
+++ b/t/t3430-rebase-empty-message.sh
@@ -0,0 +1,79 @@
+#!/bin/sh
+
+test_description='rebase: option to allow empty commit messages'
+
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-rebase.sh
+
+test_expect_success 'setup: three regular commits' '
+	test_commit A &&
+	test_commit B &&
+	test_commit C
+'
+
+test_expect_success 'rebase -i "reword" should fail to create an empty commit message' '
+	set_fake_editor &&
+	test_must_fail env FAKE_COMMIT_MESSAGE=" " FAKE_LINES="1 reword 2" \
+		git rebase -i HEAD~2
+'
+
+test_expect_success '... but should succeed with --allow-empty-message' '
+	git rebase --abort &&
+	set_fake_editor &&
+	FAKE_COMMIT_MESSAGE=" " FAKE_LINES="1 reword 2" \
+		git rebase -i --allow-empty-message HEAD~2
+'
+
+test_expect_success 'rebase -i "fixup" should fail to fixup an empty commit message' '
+	test_commit D &&
+	set_fake_editor &&
+	test_must_fail env FAKE_LINES="1 fixup 2" git rebase -i HEAD~2
+'
+
+test_expect_success '... but should succeed with --allow-empty-message' '
+	git rebase --abort &&
+	FAKE_LINES="1 fixup 2" git rebase -i --allow-empty-message HEAD~2
+'
+
+# The test expects the following rebase to fail. It will only fail if it
+# actually has to cmd_commit() a new [empty message] commit. However, this
+# rebase makes no actual changes. So if the date does not change in time, it is
+# possible for it to simply take the original commits exactly as they are.
+# So, we test_tick() just to be safe.
+test_expect_success 'rebase --root should fail on an empty commit message' '
+	test_tick &&
+	test_must_fail git rebase --root
+'
+
+test_expect_success '... but should succeed with --allow-empty-message' '
+	git rebase --abort &&
+	git rebase --root --allow-empty-message
+'
+
+test_expect_success 'setup: multiple branches' '
+	git checkout -b branch-keep-empty HEAD^1 &&
+	echo E >E &&
+	git add E &&
+	git commit --allow-empty-message -m "" &&
+	git branch branch-merge
+'
+
+test_expect_success 'rebase --keep-empty should fail on an empty commit message' '
+	test_must_fail git rebase --keep-empty master branch-keep-empty
+'
+
+test_expect_success '... but should succeed with --allow-empty-message' '
+	git cherry-pick --abort &&
+	git rebase --keep-empty --allow-empty-message master branch-keep-empty
+'
+
+test_expect_success 'rebase -m should fail on an empty commit message' '
+	test_must_fail git rebase -m master branch-merge
+'
+
+test_expect_success '... but should succeed with --allow-empty-message' '
+	git rebase --abort &&
+	git rebase -m --allow-empty-message master branch-merge
+'
+
+test_done
--
2.16.1.73.g13f648520

