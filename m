From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 12/14] revert: Introduce --reset to cleanup sequencer data
Date: Wed,  6 Jul 2011 07:54:26 +0000
Message-ID: <1309938868-2028-13-git-send-email-artagnon@gmail.com>
References: <1309938868-2028-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 06 09:55:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeMx4-00068m-Dv
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 09:55:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751695Ab1GFHzI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jul 2011 03:55:08 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:48564 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751711Ab1GFHzG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2011 03:55:06 -0400
Received: by mail-qy0-f174.google.com with SMTP id 29so1924487qyk.19
        for <git@vger.kernel.org>; Wed, 06 Jul 2011 00:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=UBSNDHAheMYfiByC9jD1SoikDhG1+G3UZIdcvX1mKbc=;
        b=JIkJ216ZXXT3KYXZOoaZP5m7e4efgyrJLOXTEKOcEnUwoKbKrzxuDpesMPj83wthO6
         lbij++WiCnLOIofjgrY+MEiRmioElB2Dhy6/RuNV3SO3dqiu9oj7LRXjZs6PfxKNEflo
         CcH/4UMNexMbp8B+/F/Fs0R0ygyxaYk2KFOYo=
Received: by 10.224.33.82 with SMTP id g18mr6522366qad.105.1309938890106;
        Wed, 06 Jul 2011 00:54:50 -0700 (PDT)
Received: from localhost.localdomain (ec2-184-72-137-52.compute-1.amazonaws.com [184.72.137.52])
        by mx.google.com with ESMTPS id e18sm6212790qcs.5.2011.07.06.00.54.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Jul 2011 00:54:49 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1309938868-2028-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176660>

When the sequencer data is persisted after a failed cherry-pick, don't
allow subsequent calls to cherry-pick to clobber this state: instead,
error out with the complaint that an existing cherry-pick is in
progress.  To fix existing tests and the "rebase -i" script, introduce
a new "--reset" command-line option to call after every failed
cherry-pick; it essentially clears out the sequencer data, thereby
allowing subsequent calls.

Helped-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 This is perfect but for the fact that 'git reset --hard' doesn't blow
 away the sequencer state.  Why I haven't implemented that yet: should
 ONLY a hard reset blow away the state?

 builtin/revert.c                   |   54 ++++++++++++++++++++++++++++++-----
 git-rebase--interactive.sh         |   25 +++++++++++++---
 t/t3032-merge-recursive-options.sh |    2 +
 t/t3501-revert-cherry-pick.sh      |    1 +
 t/t3502-cherry-pick-merge.sh       |    9 ++++-
 t/t3504-cherry-pick-rerere.sh      |    2 +
 t/t3505-cherry-pick-empty.sh       |   14 ++++-----
 t/t3506-cherry-pick-ff.sh          |    3 ++
 t/t3507-cherry-pick-conflict.sh    |   24 ++++++++++++---
 t/t3510-cherry-pick-sequence.sh    |   14 +++++++++
 t/t7502-commit.sh                  |    1 +
 11 files changed, 121 insertions(+), 28 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 8cdcdb6..9e18d64 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -46,6 +46,8 @@ enum replay_action { REVERT, CHERRY_PICK };
 struct replay_opts {
 	enum replay_action action;
 
+	int reset;
+
 	/* Boolean options */
 	int edit;
 	int record_origin;
@@ -108,6 +110,7 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 	const char * const * usage_str = revert_or_cherry_pick_usage(opts);
 	int noop;
 	struct option options[] = {
+		OPT_BOOLEAN(0, "reset", &opts->reset, "forget the current operation"),
 		OPT_BOOLEAN('n', "no-commit", &opts->no_commit, "don't automatically commit"),
 		OPT_BOOLEAN('e', "edit", &opts->edit, "edit the commit message"),
 		{ OPTION_BOOLEAN, 'r', NULL, &noop, NULL, "no-op (backward compatibility)",
@@ -136,7 +139,21 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 	opts->commit_argc = parse_options(argc, argv, NULL, options, usage_str,
 					PARSE_OPT_KEEP_ARGV0 |
 					PARSE_OPT_KEEP_UNKNOWN);
-	if (opts->commit_argc < 2)
+
+	/* Check for incompatible command line arguments */
+	if (opts->reset) {
+		verify_opt_compatible(me, "--reset",
+				"--no-commit", opts->no_commit,
+				"--signoff", opts->signoff,
+				"--mainline", opts->mainline,
+				"--strategy", opts->strategy ? 1 : 0,
+				"--strategy-option", opts->xopts ? 1 : 0,
+				"-x", opts->record_origin,
+				"--ff", opts->allow_ff,
+				NULL);
+	}
+
+	else if (opts->commit_argc < 2)
 		usage_with_options(usage_str, options);
 
 	if (opts->allow_ff)
@@ -625,8 +642,11 @@ static void walk_revs_populate_todo(struct commit_list **todo_list,
 static void create_seq_dir(void)
 {
 	if (file_exists(git_path(SEQ_DIR))) {
-		if (!is_directory(git_path(SEQ_DIR)) && remove_path(git_path(SEQ_DIR)) < 0)
-			die(_("Could not remove %s"), git_path(SEQ_DIR));
+		error(_("%s already exists."), git_path(SEQ_DIR));
+		advise(_("This usually means that a %s operation is in progress."), me);
+		advise(_("Use %s --continue to continue the operation"), me);
+		advise(_("or use %s --reset to forget about it"), me);
+		die(_("%s failed"), me);
 	} else if (mkdir(git_path(SEQ_DIR), 0777) < 0)
 		die_errno(_("Could not create sequencer directory '%s'."), git_path(SEQ_DIR));
 }
@@ -709,13 +729,31 @@ static int process_continuation(struct replay_opts *opts)
 
 	read_and_refresh_cache(me, opts);
 
-	walk_revs_populate_todo(&todo_list, opts);
-	create_seq_dir();
-	if (!get_sha1("HEAD", sha1))
-		persist_head(sha1_to_hex(sha1));
-	persist_todo(todo_list, opts);
+	if (opts->reset) {
+		if (!file_exists(git_path(SEQ_TODO_FILE)))
+			goto error;
+		return cleanup_sequencer_data();
+	} else {
+		/*
+		 * Start a new cherry-pick/ revert sequence; but
+		 * first, make sure that an existing one isn't in
+		 * progress
+		 */
+		if (file_exists(git_path(SEQ_TODO_FILE))) {
+			error(_("A %s is already in progress"), me);
+			advise(_("Use %s --reset to forget about it"), me);
+			return -1;
+		}
 
+		walk_revs_populate_todo(&todo_list, opts);
+		create_seq_dir();
+		if (!get_sha1("HEAD", sha1))
+			save_head(sha1_to_hex(sha1));
+		save_todo(todo_list, opts);
+	}
 	return pick_commits(todo_list, opts);
+error:
+	return error(_("No %s in progress"), me);
 }
 
 int cmd_revert(int argc, const char **argv, const char *prefix)
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 65690af..14c57dd 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -136,6 +136,10 @@ make_patch () {
 		get_author_ident_from_commit "$1" > "$author_script"
 }
 
+clear_cherry_pick_state () {
+	git cherry-pick --reset
+}
+
 die_with_patch () {
 	echo "$1" > "$state_dir"/stopped-sha
 	make_patch "$1"
@@ -279,8 +283,10 @@ pick_one_preserving_merges () {
 			echo "$sha1 $(git rev-parse HEAD^0)" >> "$rewritten_list"
 			;;
 		*)
-			output git cherry-pick "$@" ||
+			output git cherry-pick "$@" || {
+				clear_cherry_pick_state
 				die_with_patch $sha1 "Could not pick $sha1"
+			}
 			;;
 		esac
 		;;
@@ -385,16 +391,20 @@ do_next () {
 		comment_for_reflog pick
 
 		mark_action_done
-		pick_one $sha1 ||
+		pick_one $sha1 || {
+			clear_cherry_pick_state
 			die_with_patch $sha1 "Could not apply $sha1... $rest"
+		}
 		record_in_rewritten $sha1
 		;;
 	reword|r)
 		comment_for_reflog reword
 
 		mark_action_done
-		pick_one $sha1 ||
+		pick_one $sha1 || {
+			clear_cherry_pick_state
 			die_with_patch $sha1 "Could not apply $sha1... $rest"
+		}
 		git commit --amend --no-post-rewrite
 		record_in_rewritten $sha1
 		;;
@@ -402,8 +412,10 @@ do_next () {
 		comment_for_reflog edit
 
 		mark_action_done
-		pick_one $sha1 ||
+		pick_one $sha1 || {
+			clear_cherry_pick_state
 			die_with_patch $sha1 "Could not apply $sha1... $rest"
+		}
 		echo "$sha1" > "$state_dir"/stopped-sha
 		make_patch $sha1
 		git rev-parse --verify HEAD > "$amend"
@@ -438,7 +450,10 @@ do_next () {
 		echo "$author_script_content" > "$author_script"
 		eval "$author_script_content"
 		output git reset --soft HEAD^
-		pick_one -n $sha1 || die_failed_squash $sha1 "$rest"
+		pick_one -n $sha1 || {
+			clear_cherry_pick_state
+			die_failed_squash $sha1 "$rest"
+		}
 		case "$(peek_next_command)" in
 		squash|s|fixup|f)
 			# This is an intermediate commit; its message will only be
diff --git a/t/t3032-merge-recursive-options.sh b/t/t3032-merge-recursive-options.sh
index 2b17311..81191ae 100755
--- a/t/t3032-merge-recursive-options.sh
+++ b/t/t3032-merge-recursive-options.sh
@@ -113,8 +113,10 @@ test_expect_success '--ignore-space-change makes merge succeed' '
 test_expect_success 'naive cherry-pick fails' '
 	git read-tree --reset -u HEAD &&
 	test_must_fail git cherry-pick --no-commit remote &&
+	git cherry-pick --reset &&
 	git read-tree --reset -u HEAD &&
 	test_must_fail git cherry-pick remote &&
+	git cherry-pick --reset &&
 	test_must_fail git update-index --refresh &&
 	grep "<<<<<<" text.txt
 '
diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
index 595d2ff..e0c805d 100755
--- a/t/t3501-revert-cherry-pick.sh
+++ b/t/t3501-revert-cherry-pick.sh
@@ -96,6 +96,7 @@ test_expect_success 'revert forbidden on dirty working tree' '
 	echo content >extra_file &&
 	git add extra_file &&
 	test_must_fail git revert HEAD 2>errors &&
+	git revert --reset &&
 	test_i18ngrep "Your local changes would be overwritten by " errors
 
 '
diff --git a/t/t3502-cherry-pick-merge.sh b/t/t3502-cherry-pick-merge.sh
index 0ab52da..db21e47 100755
--- a/t/t3502-cherry-pick-merge.sh
+++ b/t/t3502-cherry-pick-merge.sh
@@ -36,6 +36,7 @@ test_expect_success 'cherry-pick a non-merge with -m should fail' '
 	git reset --hard &&
 	git checkout a^0 &&
 	test_must_fail git cherry-pick -m 1 b &&
+	git cherry-pick --reset &&
 	git diff --exit-code a --
 
 '
@@ -45,6 +46,7 @@ test_expect_success 'cherry pick a merge without -m should fail' '
 	git reset --hard &&
 	git checkout a^0 &&
 	test_must_fail git cherry-pick c &&
+	git cherry-pick --reset &&
 	git diff --exit-code a --
 
 '
@@ -71,8 +73,8 @@ test_expect_success 'cherry pick a merge relative to nonexistent parent should f
 
 	git reset --hard &&
 	git checkout b^0 &&
-	test_must_fail git cherry-pick -m 3 c
-
+	test_must_fail git cherry-pick -m 3 c &&
+	git cherry-pick --reset
 '
 
 test_expect_success 'revert a non-merge with -m should fail' '
@@ -80,6 +82,7 @@ test_expect_success 'revert a non-merge with -m should fail' '
 	git reset --hard &&
 	git checkout c^0 &&
 	test_must_fail git revert -m 1 b &&
+	git cherry-pick --reset &&
 	git diff --exit-code c
 
 '
@@ -89,6 +92,7 @@ test_expect_success 'revert a merge without -m should fail' '
 	git reset --hard &&
 	git checkout c^0 &&
 	test_must_fail git revert c &&
+	git cherry-pick --reset &&
 	git diff --exit-code c
 
 '
@@ -116,6 +120,7 @@ test_expect_success 'revert a merge relative to nonexistent parent should fail'
 	git reset --hard &&
 	git checkout c^0 &&
 	test_must_fail git revert -m 3 c &&
+	git cherry-pick --reset &&
 	git diff --exit-code c
 
 '
diff --git a/t/t3504-cherry-pick-rerere.sh b/t/t3504-cherry-pick-rerere.sh
index e6a6481..85d5fc1 100755
--- a/t/t3504-cherry-pick-rerere.sh
+++ b/t/t3504-cherry-pick-rerere.sh
@@ -29,6 +29,7 @@ test_expect_success 'fixup' '
 
 test_expect_success 'cherry-pick conflict' '
 	test_must_fail git cherry-pick master &&
+	git cherry-pick --reset &&
 	test_cmp expect foo
 '
 
@@ -39,6 +40,7 @@ test_expect_success 'reconfigure' '
 
 test_expect_success 'cherry-pick conflict without rerere' '
 	test_must_fail git cherry-pick master &&
+	git cherry-pick --reset &&
 	test_must_fail test_cmp expect foo
 '
 
diff --git a/t/t3505-cherry-pick-empty.sh b/t/t3505-cherry-pick-empty.sh
index c10b28c..dc02227 100755
--- a/t/t3505-cherry-pick-empty.sh
+++ b/t/t3505-cherry-pick-empty.sh
@@ -23,10 +23,9 @@ test_expect_success setup '
 '
 
 test_expect_success 'cherry-pick an empty commit' '
-	git checkout master && {
-		git cherry-pick empty-branch^
-		test "$?" = 1
-	}
+	git checkout master &&
+	test_expect_code 1 git cherry-pick empty-branch^
+	git cherry-pick --reset
 '
 
 test_expect_success 'index lockfile was removed' '
@@ -36,10 +35,9 @@ test_expect_success 'index lockfile was removed' '
 '
 
 test_expect_success 'cherry-pick a commit with an empty message' '
-	git checkout master && {
-		git cherry-pick empty-branch
-		test "$?" = 1
-	}
+	git checkout master &&
+	test_expect_code 1 git cherry-pick empty-branch &&
+	git cherry-pick --reset
 '
 
 test_expect_success 'index lockfile was removed' '
diff --git a/t/t3506-cherry-pick-ff.sh b/t/t3506-cherry-pick-ff.sh
index 51ca391..abd63a5 100755
--- a/t/t3506-cherry-pick-ff.sh
+++ b/t/t3506-cherry-pick-ff.sh
@@ -67,12 +67,14 @@ test_expect_success 'merge setup' '
 test_expect_success 'cherry-pick a non-merge with --ff and -m should fail' '
 	git reset --hard A -- &&
 	test_must_fail git cherry-pick --ff -m 1 B &&
+	git cherry-pick --reset &&
 	git diff --exit-code A --
 '
 
 test_expect_success 'cherry pick a merge with --ff but without -m should fail' '
 	git reset --hard A -- &&
 	test_must_fail git cherry-pick --ff C &&
+	git cherry-pick --reset &&
 	git diff --exit-code A --
 '
 
@@ -93,6 +95,7 @@ test_expect_success 'cherry pick with --ff a merge (2)' '
 test_expect_success 'cherry pick a merge relative to nonexistent parent with --ff should fail' '
 	git reset --hard B -- &&
 	test_must_fail git cherry-pick --ff -m 3 C
+	git cherry-pick --reset
 '
 
 test_expect_success 'cherry pick a root commit with --ff' '
diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
index 212ec54..86f8626 100755
--- a/t/t3507-cherry-pick-conflict.sh
+++ b/t/t3507-cherry-pick-conflict.sh
@@ -39,6 +39,7 @@ test_expect_success 'failed cherry-pick does not advance HEAD' '
 
 	head=$(git rev-parse HEAD) &&
 	test_must_fail git cherry-pick picked &&
+	git cherry-pick --reset &&
 	newhead=$(git rev-parse HEAD) &&
 
 	test "$head" = "$newhead"
@@ -55,6 +56,7 @@ test_expect_success 'advice from failed cherry-pick' "
 	hint: and commit the result with 'git commit'
 	EOF
 	test_must_fail git cherry-pick picked 2>actual &&
+	git cherry-pick --reset &&
 
 	test_i18ncmp expected actual
 "
@@ -62,7 +64,8 @@ test_expect_success 'advice from failed cherry-pick' "
 test_expect_success 'failed cherry-pick sets CHERRY_PICK_HEAD' '
 	pristine_detach initial &&
 	test_must_fail git cherry-pick picked &&
-	test_cmp_rev picked CHERRY_PICK_HEAD
+	test_cmp_rev picked CHERRY_PICK_HEAD &&
+	git cherry-pick --reset
 '
 
 test_expect_success 'successful cherry-pick does not set CHERRY_PICK_HEAD' '
@@ -84,13 +87,15 @@ test_expect_success 'GIT_CHERRY_PICK_HELP suppresses CHERRY_PICK_HEAD' '
 		export GIT_CHERRY_PICK_HELP &&
 		test_must_fail git cherry-pick picked
 	) &&
-	test_must_fail git rev-parse --verify CHERRY_PICK_HEAD
+	test_must_fail git rev-parse --verify CHERRY_PICK_HEAD &&
+	git cherry-pick --reset
 '
 
 test_expect_success 'git reset clears CHERRY_PICK_HEAD' '
 	pristine_detach initial &&
 
 	test_must_fail git cherry-pick picked &&
+	git cherry-pick --reset &&
 	git reset &&
 
 	test_must_fail git rev-parse --verify CHERRY_PICK_HEAD
@@ -102,7 +107,8 @@ test_expect_success 'failed commit does not clear CHERRY_PICK_HEAD' '
 	test_must_fail git cherry-pick picked &&
 	test_must_fail git commit &&
 
-	test_cmp_rev picked CHERRY_PICK_HEAD
+	test_cmp_rev picked CHERRY_PICK_HEAD &&
+	git cherry-pick --reset
 '
 
 test_expect_success 'cancelled commit does not clear CHERRY_PICK_HEAD' '
@@ -119,7 +125,8 @@ test_expect_success 'cancelled commit does not clear CHERRY_PICK_HEAD' '
 		test_must_fail git commit
 	) &&
 
-	test_cmp_rev picked CHERRY_PICK_HEAD
+	test_cmp_rev picked CHERRY_PICK_HEAD &&
+	git cherry-pick --reset
 '
 
 test_expect_success 'successful commit clears CHERRY_PICK_HEAD' '
@@ -130,13 +137,15 @@ test_expect_success 'successful commit clears CHERRY_PICK_HEAD' '
 	git add foo &&
 	git commit &&
 
-	test_must_fail git rev-parse --verify CHERRY_PICK_HEAD
+	test_must_fail git rev-parse --verify CHERRY_PICK_HEAD &&
+	git cherry-pick --reset
 '
 
 test_expect_success 'failed cherry-pick produces dirty index' '
 	pristine_detach initial &&
 
 	test_must_fail git cherry-pick picked &&
+	git cherry-pick --reset &&
 
 	test_must_fail git update-index --refresh -q &&
 	test_must_fail git diff-index --exit-code HEAD
@@ -160,6 +169,7 @@ test_expect_success 'failed cherry-pick registers participants in index' '
 	git read-tree -u --reset HEAD &&
 
 	test_must_fail git cherry-pick picked &&
+	git cherry-pick --reset &&
 	git ls-files --stage --unmerged > actual &&
 
 	test_cmp expected actual
@@ -176,6 +186,7 @@ test_expect_success 'failed cherry-pick describes conflict in work tree' '
 	EOF
 
 	test_must_fail git cherry-pick picked &&
+	git cherry-pick --reset &&
 
 	sed "s/[a-f0-9]*\.\.\./objid/" foo > actual &&
 	test_cmp expected actual
@@ -195,6 +206,7 @@ test_expect_success 'diff3 -m style' '
 	EOF
 
 	test_must_fail git cherry-pick picked &&
+	git cherry-pick --reset &&
 
 	sed "s/[a-f0-9]*\.\.\./objid/" foo > actual &&
 	test_cmp expected actual
@@ -227,6 +239,7 @@ test_expect_success 'revert also handles conflicts sanely' '
 
 	head=$(git rev-parse HEAD) &&
 	test_must_fail git revert picked &&
+	git revert --reset &&
 	newhead=$(git rev-parse HEAD) &&
 	git ls-files --stage --unmerged > actual-stages &&
 
@@ -252,6 +265,7 @@ test_expect_success 'revert conflict, diff3 -m style' '
 	EOF
 
 	test_must_fail git revert picked &&
+	git revert --reset &&
 
 	sed "s/[a-f0-9]*\.\.\./objid/" foo > actual &&
 	test_cmp expected actual
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index 83e2722..9e97a7b 100644
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -34,4 +34,18 @@ test_expect_success 'cherry-pick cleans up sequencer directory upon success' '
 	test_path_is_missing .git/sequencer
 '
 
+test_expect_success '--reset complains when no cherry-pick is in progress' '
+	pristine_detach initial &&
+	test_must_fail git cherry-pick --reset >actual 2>&1 &&
+	test_i18ngrep "error" actual
+'
+
+test_expect_success '--reset cleans up sequencer directory' '
+	pristine_detach initial &&
+	head=$(git rev-parse HEAD) &&
+	test_must_fail git cherry-pick base..picked &&
+	git cherry-pick --reset &&
+	test_path_is_missing .git/sequencer
+'
+
 test_done
diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
index 3f3adc3..0d54027 100755
--- a/t/t7502-commit.sh
+++ b/t/t7502-commit.sh
@@ -291,6 +291,7 @@ test_expect_success 'do not fire editor in the presence of conflicts' '
 	git commit -m second &&
 	# Must fail due to conflict
 	test_must_fail git cherry-pick -n master &&
+	git cherry-pick --reset &&
 	echo "editor not started" >.git/result &&
 	(
 		GIT_EDITOR="$(pwd)/.git/FAKE_EDITOR" &&
-- 
1.7.5.GIT
