Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8684F1F404
	for <e@80x24.org>; Sun,  4 Feb 2018 20:08:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752547AbeBDUIQ (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Feb 2018 15:08:16 -0500
Received: from genki.is ([159.203.135.224]:41526 "EHLO genki.is"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751797AbeBDUIP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Feb 2018 15:08:15 -0500
Received: from localhost (209-6-130-225.s991.c3-0.bkl-cbr1.sbo-bkl.ma.cable.rcncustomer.com [209.6.130.225])
        by genki.is (Postfix) with ESMTPSA id 9B5794000E;
        Sun,  4 Feb 2018 20:08:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 genki.is 9B5794000E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=genki.is;
        s=genkimail; t=1517774893;
        bh=GpycYVeK3m9tiPfHN3zcA253Lnn6/Sv3nxn855BJgmk=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=htG7Qfx9iTpxo1aj/pEIldH439AdbrfvNJQJ8DMU6YuGfN2vcFPXL6gGMADJgJEWc
         dYlpIFyLx/g0pbiXWNSAge8Hlh6Vphp1J68XrRW9cDWOPHEi7VaReukPNmZ88TtamE
         W9Kc1gK9qxfKBRizu//x2mzLSmoaNDHFoPH+gey8=
Date:   Sun, 04 Feb 2018 15:08:13 -0500
Message-Id: <05bedbb20d5f02a9fe1a74996038f7ca42e35829.1517774326.git.sky@genki.is>
In-Reply-To: <9d0414b869f21f38b81f92ee0619fd76410cbcfc.1517552392.git.sky@genki.is>
References: <9d0414b869f21f38b81f92ee0619fd76410cbcfc.1517552392.git.sky@genki.is>
From:   Genki Sky <sky@genki.is>
Subject: [PATCH v2] rebase: add --allow-empty-message option
To:     git@vger.kernel.org
Cc:     sky@genki.is, Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This option allows commits with empty commit messages to be rebased,
matching the same option in git-commit and git-cherry-pick. While empty
log messages are frowned upon, sometimes one finds them in older
repositories (e.g. translated from another VCS [0]), or have other
reasons for desiring them. The option is available in git-commit and
git-cherry-pick, so it is natural to make other git tools play nicely
with them. Adding this as an option allows the default to be "give the
user a chance to fix", while not interrupting the user's workflow
otherwise [1].

  [0]: https://stackoverflow.com/q/8542304
  [1]: https://public-inbox.org/git/7vd33afqjh.fsf@alter.siamese.dyndns.org/

To implement this, add a new --allow-empty-message flag. Then propagate
it to all calls of 'git commit', 'git cherry-pick', and 'git rebase--helper'
within the rebase scripts.

Signed-off-by: Genki Sky <sky@genki.is>
---

Notes:

  Thanks for the initial feedback, here are the changes from [v1]:
  - Made my commit message include the main motivations inline.
  - Moved new tests to t/t3405-rebase-malformed.sh, which has the
    relevant test description: "rebase should handle arbitrary git
    message".
  - Accordingly re-used existing test setup.
  - Minimized tests to just one for git-rebase--interactive.sh and one
    for git-rebase--merge.sh. First, one test per file keeps things
    focused while getting most benefit (other code within same file is
    likely to be noticed by modifiers). And, while git-rebase--am.sh
    does have one cherry-pick, it is only for a special case with
    --keep-empty. So git-rebase--am.sh otherwise doesn't have this
    empty-message issue.

  In general, there was a concern of over-testing, and over-checking
  implementation details. So, this time, I erred on the conservative
  side.

  [v1]: https://public-inbox.org/git/9d0414b869f21f38b81f92ee0619fd76410cbcfc.1517552392.git.sky@genki.is/t/

 Documentation/git-rebase.txt |  5 +++++
 builtin/rebase--helper.c     |  2 ++
 git-rebase--am.sh            |  1 +
 git-rebase--interactive.sh   | 25 +++++++++++++++----------
 git-rebase--merge.sh         |  3 ++-
 git-rebase.sh                |  5 +++++
 t/t3405-rebase-malformed.sh  | 23 +++++++++++++++++++++++
 7 files changed, 53 insertions(+), 11 deletions(-)

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
diff --git a/t/t3405-rebase-malformed.sh b/t/t3405-rebase-malformed.sh
index ff8c360cd..cb7c6de84 100755
--- a/t/t3405-rebase-malformed.sh
+++ b/t/t3405-rebase-malformed.sh
@@ -3,6 +3,7 @@
 test_description='rebase should handle arbitrary git message'

 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-rebase.sh

 cat >F <<\EOF
 This is an example of a commit log message
@@ -25,6 +26,7 @@ test_expect_success setup '
 	test_tick &&
 	git commit -m "Initial commit" &&
 	git branch diff-in-message &&
+	git branch empty-message-merge &&

 	git checkout -b multi-line-subject &&
 	cat F >file2 &&
@@ -45,6 +47,11 @@ test_expect_success setup '

 	git cat-file commit HEAD | sed -e "1,/^\$/d" >G0 &&

+	git checkout empty-message-merge &&
+	echo file3 >file3 &&
+	git add file3 &&
+	git commit --allow-empty-message -m "" &&
+
 	git checkout master &&

 	echo One >file1 &&
@@ -69,4 +76,20 @@ test_expect_success 'rebase commit with diff in message' '
 	test_cmp G G0
 '

+test_expect_success 'rebase -m commit with empty message' '
+	test_must_fail git rebase -m master empty-message-merge &&
+	git rebase --abort &&
+	git rebase -m --allow-empty-message master empty-message-merge
+'
+
+test_expect_success 'rebase -i commit with empty message' '
+	git checkout diff-in-message &&
+	set_fake_editor &&
+	test_must_fail env FAKE_COMMIT_MESSAGE=" " FAKE_LINES="reword 1" \
+		git rebase -i HEAD^ &&
+	git rebase --abort &&
+	FAKE_COMMIT_MESSAGE=" " FAKE_LINES="reword 1" \
+		git rebase -i --allow-empty-message HEAD^
+'
+
 test_done
--
2.16.1.73.g3d9791bdf

