From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 16/17] revert: Introduce --reset to remove sequencer state
Date: Mon, 11 Jul 2011 14:54:07 +0000
Message-ID: <1310396048-24925-17-git-send-email-artagnon@gmail.com>
References: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 11 16:55:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgHtE-0005dD-3i
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jul 2011 16:55:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757884Ab1GKOym (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jul 2011 10:54:42 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:55920 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757838Ab1GKOyj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2011 10:54:39 -0400
Received: by mail-vx0-f174.google.com with SMTP id 39so2716880vxb.19
        for <git@vger.kernel.org>; Mon, 11 Jul 2011 07:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=8Az+EYZ66FFcxj+LvjMTrkIouNZB6Pw59dbBimp3nuc=;
        b=otsF6OK7p7aSBWcCcTHKNXTzJ/08pGSX8ZtSYa7PipY9H1/m/b2vzgyKCJUJx9uQiL
         mMd5qtjr04OXK0NoIA1sxuO7tzZ6vOVpxN78Ak7E9LXGegkjbRYGK/Y0JfLSIDJeZ25C
         Hl1IJVY6PZHRsLFImQ2xTCWeZG/QNnjsG9KQA=
Received: by 10.52.117.235 with SMTP id kh11mr2373280vdb.423.1310396079160;
        Mon, 11 Jul 2011 07:54:39 -0700 (PDT)
Received: from localhost.localdomain (ec2-184-72-137-52.compute-1.amazonaws.com [184.72.137.52])
        by mx.google.com with ESMTPS id b9sm4510527vdk.25.2011.07.11.07.54.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 11 Jul 2011 07:54:38 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176856>

Protect the sequencer state from accidentally being stomped by a new
cherry-pick or revert invocation by ensuring that an existing one
isn't in progress.  While this patch would normally be expected to
break many tests, the earlier patches "reset: Make hard reset remove
the sequencer state" and "revert: Remove sequencer state when no
commits are pending" make sure that they don't.

To explicitly remove the sequencer state for a fresh cherry-pick or
revert invocation, introduce a new subcommand called '--reset' which
really removes the sequencer state on the very first invocation.

Ensure that the "rebase -i" script which invokes cherry-pick or revert
doesn't change its behavior by using '--reset' to to clear the state
after every failed pick.  Effectively, the script will remain unaware
and unaffected by introduction of further subcommands like
'--continue'.

Helped-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/git-cherry-pick.txt |    5 +++
 Documentation/git-revert.txt      |    5 +++
 Documentation/sequencer.txt       |    4 ++
 builtin/reset.c                   |    2 +-
 builtin/revert.c                  |   66 ++++++++++++++++++++++++++++++------
 git-rebase--interactive.sh        |   25 +++++++++++---
 sequencer.c                       |    4 ++-
 sequencer.h                       |    6 +++-
 t/t3510-cherry-pick-sequence.sh   |   17 ++++++++-
 9 files changed, 113 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/sequencer.txt

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index 9d8fe0d..138a292 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -8,6 +8,7 @@ git-cherry-pick - Apply the changes introduced by some existing commits
 SYNOPSIS
 --------
 'git cherry-pick' [--edit] [-n] [-m parent-number] [-s] [-x] [--ff] <commit>...
+'git cherry-pick' --reset
 
 DESCRIPTION
 -----------
@@ -109,6 +110,10 @@ effect to your index in a row.
 	Pass the merge strategy-specific option through to the
 	merge strategy.  See linkgit:git-merge[1] for details.
 
+SEQUENCER SUBCOMMANDS
+---------------------
+include::sequencer.txt[]
+
 EXAMPLES
 --------
 git cherry-pick master::
diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
index ac10cfb..783ffb4 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -8,6 +8,7 @@ git-revert - Revert some existing commits
 SYNOPSIS
 --------
 'git revert' [--edit | --no-edit] [-n] [-m parent-number] [-s] <commit>...
+'git revert' --reset
 
 DESCRIPTION
 -----------
@@ -90,6 +91,10 @@ effect to your index in a row.
 	Pass the merge strategy-specific option through to the
 	merge strategy.  See linkgit:git-merge[1] for details.
 
+SEQUENCER SUBCOMMANDS
+---------------------
+include::sequencer.txt[]
+
 EXAMPLES
 --------
 git revert HEAD~3::
diff --git a/Documentation/sequencer.txt b/Documentation/sequencer.txt
new file mode 100644
index 0000000..16ce88c
--- /dev/null
+++ b/Documentation/sequencer.txt
@@ -0,0 +1,4 @@
+--reset::
+	Forget about the current operation in progress.  Can be used
+	to clear the sequencer state after a failed cherry-pick or
+	revert.
diff --git a/builtin/reset.c b/builtin/reset.c
index 899e250..ec0e5d0 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -368,7 +368,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 
 	switch (reset_type) {
 	case HARD:
-		remove_sequencer_state();
+		remove_sequencer_state(0);
 		if (!update_ref_status && !quiet)
 			print_new_head_line(commit);
 		break;
diff --git a/builtin/revert.c b/builtin/revert.c
index 3936516..409d88f 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -29,19 +29,23 @@
 
 static const char * const revert_usage[] = {
 	"git revert [options] <commit-ish>",
+	"git revert <subcommand>",
 	NULL
 };
 
 static const char * const cherry_pick_usage[] = {
 	"git cherry-pick [options] <commit-ish>",
+	"git cherry-pick <subcommand>",
 	NULL
 };
 
 static const char *me;
 enum replay_action { REVERT, CHERRY_PICK };
+enum replay_subcommand { REPLAY_NONE, REPLAY_RESET };
 
 struct replay_opts {
 	enum replay_action action;
+	enum replay_subcommand subcommand;
 
 	/* Boolean options */
 	int edit;
@@ -104,7 +108,9 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 {
 	const char * const * usage_str = revert_or_cherry_pick_usage(opts);
 	int noop;
+	int reset = 0;
 	struct option options[] = {
+		OPT_BOOLEAN(0, "reset", &reset, "forget the current operation"),
 		OPT_BOOLEAN('n', "no-commit", &opts->no_commit, "don't automatically commit"),
 		OPT_BOOLEAN('e', "edit", &opts->edit, "edit the commit message"),
 		{ OPTION_BOOLEAN, 'r', NULL, &noop, NULL, "no-op (backward compatibility)",
@@ -133,7 +139,27 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 	opts->commit_argc = parse_options(argc, argv, NULL, options, usage_str,
 					PARSE_OPT_KEEP_ARGV0 |
 					PARSE_OPT_KEEP_UNKNOWN);
-	if (opts->commit_argc < 2)
+
+	/* Set the subcommand */
+	if (reset)
+		opts->subcommand = REPLAY_RESET;
+	else
+		opts->subcommand = REPLAY_NONE;
+
+	/* Check for incompatible command line arguments */
+	if (opts->subcommand == REPLAY_RESET) {
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
@@ -916,8 +942,11 @@ static void walk_revs_populate_todo(struct commit_list **todo_list,
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
@@ -999,7 +1028,7 @@ static int pick_commits(struct commit_list *todo_list, struct replay_opts *opts)
 				 * the user simply needs to resolve
 				 * the conflict and commit
 				 */
-				remove_sequencer_state();
+				remove_sequencer_state(0);
 			return res;
 		}
 	}
@@ -1008,7 +1037,7 @@ static int pick_commits(struct commit_list *todo_list, struct replay_opts *opts)
 	 * Sequence of picks finished successfully; cleanup by
 	 * removing the .git/sequencer directory
 	 */
-	remove_sequencer_state();
+	remove_sequencer_state(1);
 	return 0;
 }
 
@@ -1019,13 +1048,28 @@ static int process_subcommand(struct replay_opts *opts)
 
 	read_and_refresh_cache(me, opts);
 
-	walk_revs_populate_todo(&todo_list, opts);
-	create_seq_dir();
-	if (!get_sha1("HEAD", sha1))
-		save_head(sha1_to_hex(sha1));
-	save_opts(opts);
-	save_todo(todo_list, opts);
+	if (opts->subcommand == REPLAY_RESET) {
+		remove_sequencer_state(1);
+		return 0;
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
+		save_opts(opts);
+		save_todo(todo_list, opts);
+	}
 	return pick_commits(todo_list, opts);
 }
 
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
diff --git a/sequencer.c b/sequencer.c
index 8c1de63..bc2c046 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3,7 +3,7 @@
 #include "strbuf.h"
 #include "dir.h"
 
-void remove_sequencer_state(void)
+void remove_sequencer_state(int aggressive)
 {
 	struct strbuf seq_dir = STRBUF_INIT;
 	struct strbuf seq_old_dir = STRBUF_INIT;
@@ -12,6 +12,8 @@ void remove_sequencer_state(void)
 	strbuf_addf(&seq_old_dir, "%s", git_path(SEQ_OLD_DIR));
 	remove_dir_recursively(&seq_old_dir, 0);
 	rename(git_path(SEQ_DIR), git_path(SEQ_OLD_DIR));
+	if (aggressive)
+		remove_dir_recursively(&seq_old_dir, 0);
 	strbuf_release(&seq_dir);
 	strbuf_release(&seq_old_dir);
 }
diff --git a/sequencer.h b/sequencer.h
index dcb51b1..e1951cc 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -9,7 +9,11 @@
 
 /* Removes SEQ_OLD_DIR and renames SEQ_DIR to SEQ_OLD_DIR, ignoring
  * any errors.  Intended to be used by 'git reset --hard'.
+ *
+ * With the aggressive flag, it additionally removes SEQ_OLD_DIR,
+ * ignoring any errors.  Inteded to be used by the sequencer's
+ * '--reset' subcommand.
  */
-void remove_sequencer_state(void);
+void remove_sequencer_state(int aggressive);
 
 #endif
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index 0a8b093..c21b345 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -37,7 +37,7 @@ test_expect_success 'cherry-pick persists data on failure' '
 	test_path_is_file .git/sequencer/head &&
 	test_path_is_file .git/sequencer/todo &&
 	test_path_is_file .git/sequencer/opts &&
-	rm -rf .git/sequencer
+	git cherry-pick --reset
 '
 
 test_expect_success 'cherry-pick persists opts correctly' '
@@ -54,7 +54,7 @@ test_expect_success 'cherry-pick persists opts correctly' '
 	strategy-option = patience | ours
 	EOF
 	test_cmp expect .git/sequencer/opts &&
-	rm -rf .git/sequencer
+	git cherry-pick --reset
 '
 
 test_expect_success 'cherry-pick cleans up sequencer state upon success' '
@@ -88,4 +88,17 @@ test_expect_success 'cherry-pick cleans up sequencer state when one commit is le
 	test_cmp expect actual
 '
 
+test_expect_success '--reset does not complain when no cherry-pick is in progress' '
+	pristine_detach initial &&
+	git cherry-pick --reset
+'
+
+test_expect_success '--reset cleans up sequencer state' '
+	pristine_detach initial &&
+	head=$(git rev-parse HEAD) &&
+	test_must_fail git cherry-pick base..picked &&
+	git cherry-pick --reset &&
+	test_path_is_missing .git/sequencer
+'
+
 test_done
-- 
1.7.5.GIT
