From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [RFC PATCH] revert: Introduce skip-all to cleanup sequencer data
Date: Tue, 21 Jun 2011 06:07:38 +0000
Message-ID: <1308636458-19668-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 21 08:07:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYu7s-0005fv-60
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 08:07:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751739Ab1FUGHn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jun 2011 02:07:43 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:40982 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751157Ab1FUGHm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2011 02:07:42 -0400
Received: by vxb39 with SMTP id 39so1481529vxb.19
        for <git@vger.kernel.org>; Mon, 20 Jun 2011 23:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=Otl4jUClfqHRBT1sZu8h/g0Dv+Hp0+pWQPEwFayQAm8=;
        b=Rob3qTJcvGRw/AWq+zn0cLPknPV8GFEkOa0edNo9auXw44ozfv85wZ/DnvaGw8MYcc
         JiOM8L8dln04Ub1VQq37KY302vovVvA8wYLMMzzvEBhqBaOZ3lbB4JRmUCcM7KQwIQGF
         QrQAbxhBUHsDRZd70tDNKY0BDmz56k/qj2zF4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=W245PzgY3PaTa34y0/gCRjHiJBOxSVGIuCyzUeziV3D1L/UC+DqjIk51m4RHornhgB
         +iXE9Om4Q5M5yidzWhcy71YEPomCvrJOy7wx2k2gb1PTCfHKlLu75eyXl4ZeYG2A2ofk
         N6GaOd3cSZLU4O7KYucc90SSb+60+fgnKhAWs=
Received: by 10.220.73.15 with SMTP id o15mr2369788vcj.53.1308636461861;
        Mon, 20 Jun 2011 23:07:41 -0700 (PDT)
Received: from localhost.localdomain (ec2-184-72-137-52.compute-1.amazonaws.com [184.72.137.52])
        by mx.google.com with ESMTPS id w16sm546302vco.29.2011.06.20.23.07.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Jun 2011 23:07:40 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176124>

When the sequencer data is persisted after a failed cherry-pick, don't
allow subsequent calls to cherry-pick to clobber this state: instead,
error out with the complaint that an existing cherry-pick is in
progress.  To fix existing tests and the "rebase -i" script, introduce
a new "--skip-all" command-line option to call after every failed
cherry-pick; it essentially clears out the sequencer data, thereby
allowing subsequent calls.

Helped-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Now there's a huge problem with this -- it breaks the muscle memory
 that has been formed over many years of Git usage.  One plausible
 solution suggested by Jonathan is to make "reset --hard" move the
 .git/sequencer directory to .git/sequncer-cancelled and print a small
 hint about this.  I see no other way out, so I'm personally okay with
 it; the question now is- will that suffice, or will we need to do
 more than that?

 Thanks to Dimity and Jonathan for suggesting the "--skip-all" name.
 Although I'm personally not too happy with it, I'll let it stick
 until someone comes up with a better alternative.  I was thinking
 more along the lines of soemthing like "--forget-state".

 builtin/revert.c                   |   43 ++++++++++++++++++++++++++++++++---
 git-rebase--interactive.sh         |   25 ++++++++++++++++----
 t/t3032-merge-recursive-options.sh |    2 +
 t/t3501-revert-cherry-pick.sh      |    1 +
 t/t3502-cherry-pick-merge.sh       |    9 ++++++-
 t/t3504-cherry-pick-rerere.sh      |    2 +
 t/t3505-cherry-pick-empty.sh       |   14 +++++------
 t/t3506-cherry-pick-ff.sh          |    3 ++
 t/t3507-cherry-pick-conflict.sh    |   24 ++++++++++++++++----
 t/t3510-cherry-pick-sequence.sh    |   15 ++++++++++++
 t/t7502-commit.sh                  |    1 +
 11 files changed, 115 insertions(+), 24 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 6edc3de..6568638 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -48,6 +48,9 @@ enum replay_action { REVERT, CHERRY_PICK };
 struct replay_opts {
 	enum replay_action action;
 
+	/* --skip-all */
+	int skipall_oper;
+
 	/* Boolean options */
 	int edit;
 	int record_origin;
@@ -109,6 +112,7 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 	const char * const * usage_str = revert_or_cherry_pick_usage(opts);
 	int noop;
 	struct option options[] = {
+		OPT_BOOLEAN(0, "skip-all", &opts->skipall_oper, "skip remaining instructions"),
 		OPT_BOOLEAN('n', "no-commit", &opts->no_commit, "don't automatically commit"),
 		OPT_BOOLEAN('e', "edit", &opts->edit, "edit the commit message"),
 		{ OPTION_BOOLEAN, 'r', NULL, &noop, NULL, "no-op (backward compatibility)",
@@ -137,7 +141,21 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 	opts->commit_argc = parse_options(argc, argv, NULL, options, usage_str,
 					PARSE_OPT_KEEP_ARGV0 |
 					PARSE_OPT_KEEP_UNKNOWN);
-	if (opts->commit_argc < 2)
+
+	/* Check for incompatible command line arguments */
+	if (opts->skipall_oper) {
+		verify_opt_compatible(me, "--skip-all",
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
@@ -706,11 +724,28 @@ static int process_continuation(struct replay_opts *opts)
 	read_and_refresh_cache(me, opts);
 
 	head = find_unique_abbrev(sha1, 0);
-	populate_todo_revs(&todo_list, opts);
-	persist_head(head);
-	persist_todo(todo_list, opts);
 
+	if (opts->skipall_oper) {
+		if (!file_exists(TODO_FILE))
+			goto error;
+		return cleanup_sequencer_data();
+	} else {
+		/* Start a new cherry-pick/ revert sequence; but
+		   first, make sure that an existing one isn't in
+		   progress */
+		if (file_exists(TODO_FILE)) {
+			error(_("A %s is already in progress"), me);
+			advise(_("Use %s --skip-all to forget about it"), me);
+			return -1;
+		}
+
+		populate_todo_revs(&todo_list, opts);
+		persist_head(head);
+		persist_todo(todo_list, opts);
+	}
 	return pick_commits(todo_list, opts);
+error:
+	return error(_("No %s in progress"), me);
 }
 
 int cmd_revert(int argc, const char **argv, const char *prefix)
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 65690af..e0c9bd8 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -136,6 +136,10 @@ make_patch () {
 		get_author_ident_from_commit "$1" > "$author_script"
 }
 
+clear_cherry_pick_state () {
+	git cherry-pick --skip-all
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
index 2b17311..50e8ca9 100755
--- a/t/t3032-merge-recursive-options.sh
+++ b/t/t3032-merge-recursive-options.sh
@@ -113,8 +113,10 @@ test_expect_success '--ignore-space-change makes merge succeed' '
 test_expect_success 'naive cherry-pick fails' '
 	git read-tree --reset -u HEAD &&
 	test_must_fail git cherry-pick --no-commit remote &&
+	git cherry-pick --skip-all &&
 	git read-tree --reset -u HEAD &&
 	test_must_fail git cherry-pick remote &&
+	git cherry-pick --skip-all &&
 	test_must_fail git update-index --refresh &&
 	grep "<<<<<<" text.txt
 '
diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
index 595d2ff..8970af4 100755
--- a/t/t3501-revert-cherry-pick.sh
+++ b/t/t3501-revert-cherry-pick.sh
@@ -96,6 +96,7 @@ test_expect_success 'revert forbidden on dirty working tree' '
 	echo content >extra_file &&
 	git add extra_file &&
 	test_must_fail git revert HEAD 2>errors &&
+	git revert --skip-all &&
 	test_i18ngrep "Your local changes would be overwritten by " errors
 
 '
diff --git a/t/t3502-cherry-pick-merge.sh b/t/t3502-cherry-pick-merge.sh
index 0ab52da..cc132f8 100755
--- a/t/t3502-cherry-pick-merge.sh
+++ b/t/t3502-cherry-pick-merge.sh
@@ -36,6 +36,7 @@ test_expect_success 'cherry-pick a non-merge with -m should fail' '
 	git reset --hard &&
 	git checkout a^0 &&
 	test_must_fail git cherry-pick -m 1 b &&
+	git cherry-pick --skip-all &&
 	git diff --exit-code a --
 
 '
@@ -45,6 +46,7 @@ test_expect_success 'cherry pick a merge without -m should fail' '
 	git reset --hard &&
 	git checkout a^0 &&
 	test_must_fail git cherry-pick c &&
+	git cherry-pick --skip-all &&
 	git diff --exit-code a --
 
 '
@@ -71,8 +73,8 @@ test_expect_success 'cherry pick a merge relative to nonexistent parent should f
 
 	git reset --hard &&
 	git checkout b^0 &&
-	test_must_fail git cherry-pick -m 3 c
-
+	test_must_fail git cherry-pick -m 3 c &&
+	git cherry-pick --skip-all
 '
 
 test_expect_success 'revert a non-merge with -m should fail' '
@@ -80,6 +82,7 @@ test_expect_success 'revert a non-merge with -m should fail' '
 	git reset --hard &&
 	git checkout c^0 &&
 	test_must_fail git revert -m 1 b &&
+	git cherry-pick --skip-all &&
 	git diff --exit-code c
 
 '
@@ -89,6 +92,7 @@ test_expect_success 'revert a merge without -m should fail' '
 	git reset --hard &&
 	git checkout c^0 &&
 	test_must_fail git revert c &&
+	git cherry-pick --skip-all &&
 	git diff --exit-code c
 
 '
@@ -116,6 +120,7 @@ test_expect_success 'revert a merge relative to nonexistent parent should fail'
 	git reset --hard &&
 	git checkout c^0 &&
 	test_must_fail git revert -m 3 c &&
+	git cherry-pick --skip-all &&
 	git diff --exit-code c
 
 '
diff --git a/t/t3504-cherry-pick-rerere.sh b/t/t3504-cherry-pick-rerere.sh
index e6a6481..e7be835 100755
--- a/t/t3504-cherry-pick-rerere.sh
+++ b/t/t3504-cherry-pick-rerere.sh
@@ -29,6 +29,7 @@ test_expect_success 'fixup' '
 
 test_expect_success 'cherry-pick conflict' '
 	test_must_fail git cherry-pick master &&
+	git cherry-pick --skip-all &&
 	test_cmp expect foo
 '
 
@@ -39,6 +40,7 @@ test_expect_success 'reconfigure' '
 
 test_expect_success 'cherry-pick conflict without rerere' '
 	test_must_fail git cherry-pick master &&
+	git cherry-pick --skip-all &&
 	test_must_fail test_cmp expect foo
 '
 
diff --git a/t/t3505-cherry-pick-empty.sh b/t/t3505-cherry-pick-empty.sh
index c10b28c..c8d828f 100755
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
+	git cherry-pick --skip-all
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
+	git cherry-pick --skip-all
 '
 
 test_expect_success 'index lockfile was removed' '
diff --git a/t/t3506-cherry-pick-ff.sh b/t/t3506-cherry-pick-ff.sh
index 51ca391..de7368e 100755
--- a/t/t3506-cherry-pick-ff.sh
+++ b/t/t3506-cherry-pick-ff.sh
@@ -67,12 +67,14 @@ test_expect_success 'merge setup' '
 test_expect_success 'cherry-pick a non-merge with --ff and -m should fail' '
 	git reset --hard A -- &&
 	test_must_fail git cherry-pick --ff -m 1 B &&
+	git cherry-pick --skip-all &&
 	git diff --exit-code A --
 '
 
 test_expect_success 'cherry pick a merge with --ff but without -m should fail' '
 	git reset --hard A -- &&
 	test_must_fail git cherry-pick --ff C &&
+	git cherry-pick --skip-all &&
 	git diff --exit-code A --
 '
 
@@ -93,6 +95,7 @@ test_expect_success 'cherry pick with --ff a merge (2)' '
 test_expect_success 'cherry pick a merge relative to nonexistent parent with --ff should fail' '
 	git reset --hard B -- &&
 	test_must_fail git cherry-pick --ff -m 3 C
+	git cherry-pick --skip-all
 '
 
 test_expect_success 'cherry pick a root commit with --ff' '
diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
index 212ec54..07cd805 100755
--- a/t/t3507-cherry-pick-conflict.sh
+++ b/t/t3507-cherry-pick-conflict.sh
@@ -39,6 +39,7 @@ test_expect_success 'failed cherry-pick does not advance HEAD' '
 
 	head=$(git rev-parse HEAD) &&
 	test_must_fail git cherry-pick picked &&
+	git cherry-pick --skip-all &&
 	newhead=$(git rev-parse HEAD) &&
 
 	test "$head" = "$newhead"
@@ -55,6 +56,7 @@ test_expect_success 'advice from failed cherry-pick' "
 	hint: and commit the result with 'git commit'
 	EOF
 	test_must_fail git cherry-pick picked 2>actual &&
+	git cherry-pick --skip-all &&
 
 	test_i18ncmp expected actual
 "
@@ -62,7 +64,8 @@ test_expect_success 'advice from failed cherry-pick' "
 test_expect_success 'failed cherry-pick sets CHERRY_PICK_HEAD' '
 	pristine_detach initial &&
 	test_must_fail git cherry-pick picked &&
-	test_cmp_rev picked CHERRY_PICK_HEAD
+	test_cmp_rev picked CHERRY_PICK_HEAD &&
+	git cherry-pick --skip-all
 '
 
 test_expect_success 'successful cherry-pick does not set CHERRY_PICK_HEAD' '
@@ -84,13 +87,15 @@ test_expect_success 'GIT_CHERRY_PICK_HELP suppresses CHERRY_PICK_HEAD' '
 		export GIT_CHERRY_PICK_HELP &&
 		test_must_fail git cherry-pick picked
 	) &&
-	test_must_fail git rev-parse --verify CHERRY_PICK_HEAD
+	test_must_fail git rev-parse --verify CHERRY_PICK_HEAD &&
+	git cherry-pick --skip-all
 '
 
 test_expect_success 'git reset clears CHERRY_PICK_HEAD' '
 	pristine_detach initial &&
 
 	test_must_fail git cherry-pick picked &&
+	git cherry-pick --skip-all &&
 	git reset &&
 
 	test_must_fail git rev-parse --verify CHERRY_PICK_HEAD
@@ -102,7 +107,8 @@ test_expect_success 'failed commit does not clear CHERRY_PICK_HEAD' '
 	test_must_fail git cherry-pick picked &&
 	test_must_fail git commit &&
 
-	test_cmp_rev picked CHERRY_PICK_HEAD
+	test_cmp_rev picked CHERRY_PICK_HEAD &&
+	git cherry-pick --skip-all
 '
 
 test_expect_success 'cancelled commit does not clear CHERRY_PICK_HEAD' '
@@ -119,7 +125,8 @@ test_expect_success 'cancelled commit does not clear CHERRY_PICK_HEAD' '
 		test_must_fail git commit
 	) &&
 
-	test_cmp_rev picked CHERRY_PICK_HEAD
+	test_cmp_rev picked CHERRY_PICK_HEAD &&
+	git cherry-pick --skip-all
 '
 
 test_expect_success 'successful commit clears CHERRY_PICK_HEAD' '
@@ -130,13 +137,15 @@ test_expect_success 'successful commit clears CHERRY_PICK_HEAD' '
 	git add foo &&
 	git commit &&
 
-	test_must_fail git rev-parse --verify CHERRY_PICK_HEAD
+	test_must_fail git rev-parse --verify CHERRY_PICK_HEAD &&
+	git cherry-pick --skip-all
 '
 
 test_expect_success 'failed cherry-pick produces dirty index' '
 	pristine_detach initial &&
 
 	test_must_fail git cherry-pick picked &&
+	git cherry-pick --skip-all &&
 
 	test_must_fail git update-index --refresh -q &&
 	test_must_fail git diff-index --exit-code HEAD
@@ -160,6 +169,7 @@ test_expect_success 'failed cherry-pick registers participants in index' '
 	git read-tree -u --reset HEAD &&
 
 	test_must_fail git cherry-pick picked &&
+	git cherry-pick --skip-all &&
 	git ls-files --stage --unmerged > actual &&
 
 	test_cmp expected actual
@@ -176,6 +186,7 @@ test_expect_success 'failed cherry-pick describes conflict in work tree' '
 	EOF
 
 	test_must_fail git cherry-pick picked &&
+	git cherry-pick --skip-all &&
 
 	sed "s/[a-f0-9]*\.\.\./objid/" foo > actual &&
 	test_cmp expected actual
@@ -195,6 +206,7 @@ test_expect_success 'diff3 -m style' '
 	EOF
 
 	test_must_fail git cherry-pick picked &&
+	git cherry-pick --skip-all &&
 
 	sed "s/[a-f0-9]*\.\.\./objid/" foo > actual &&
 	test_cmp expected actual
@@ -227,6 +239,7 @@ test_expect_success 'revert also handles conflicts sanely' '
 
 	head=$(git rev-parse HEAD) &&
 	test_must_fail git revert picked &&
+	git revert --skip-all &&
 	newhead=$(git rev-parse HEAD) &&
 	git ls-files --stage --unmerged > actual-stages &&
 
@@ -252,6 +265,7 @@ test_expect_success 'revert conflict, diff3 -m style' '
 	EOF
 
 	test_must_fail git revert picked &&
+	git revert --skip-all &&
 
 	sed "s/[a-f0-9]*\.\.\./objid/" foo > actual &&
 	test_cmp expected actual
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index b3e9c1b..1e79939 100644
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -35,4 +35,19 @@ test_expect_success 'cherry-pick cleans up sequencer directory upon success' '
 	test_must_fail test -d .git/sequencer
 '
 
+test_expect_success '--skip-all complains when no cherry-pick is in progress' '
+	pristine_detach initial &&
+	test_must_fail git cherry-pick --skip-all >actual 2>&1 &&
+	echo "error: No cherry-pick in progress" >expect &&
+	test_i18ncmp expect actual
+'
+
+test_expect_success '--skip-all cleans up sequencer directory' '
+	pristine_detach initial &&
+	head=$(git rev-parse HEAD) &&
+	test_must_fail git cherry-pick base..picked &&
+	git cherry-pick --skip-all &&
+	test_must_fail test -d .git/sequencer
+'
+
 test_done
diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
index 3f3adc3..50d474d 100755
--- a/t/t7502-commit.sh
+++ b/t/t7502-commit.sh
@@ -291,6 +291,7 @@ test_expect_success 'do not fire editor in the presence of conflicts' '
 	git commit -m second &&
 	# Must fail due to conflict
 	test_must_fail git cherry-pick -n master &&
+	git cherry-pick --skip-all &&
 	echo "editor not started" >.git/result &&
 	(
 		GIT_EDITOR="$(pwd)/.git/FAKE_EDITOR" &&
-- 
1.7.5.GIT
