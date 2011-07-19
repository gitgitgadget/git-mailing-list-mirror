From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 18/18] revert: Introduce --continue to continue the operation
Date: Tue, 19 Jul 2011 22:47:56 +0530
Message-ID: <1311095876-3098-19-git-send-email-artagnon@gmail.com>
References: <1311095876-3098-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 19 19:20:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjDy1-0003ZF-Nw
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jul 2011 19:20:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751508Ab1GSRUQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jul 2011 13:20:16 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:36451 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751100Ab1GSRUP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2011 13:20:15 -0400
Received: by mail-pv0-f174.google.com with SMTP id 12so4030753pvg.19
        for <git@vger.kernel.org>; Tue, 19 Jul 2011 10:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ckq29Uf3Ts9HdR0Gv1YgAOdzDF1AkVGeV67a9Qagqso=;
        b=WE9pMzX1jCYdwu74DwhMfQj2KK3FrBHcf4rPWAogOxO30HIIUNafF+dUEZsWv6UABZ
         0Jj8LOrevHF//Rb76lXJI/cAmiZwuc9EwwGz0j1Kg6bME28DfFTfeMtk+TMMUUDaUsLe
         JtkrCAliFoT/j89aaLnY6l+7HFBQD+piLdkjY=
Received: by 10.142.254.5 with SMTP id b5mr3759748wfi.110.1311096015474;
        Tue, 19 Jul 2011 10:20:15 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id r12sm4276415wfe.1.2011.07.19.10.20.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 19 Jul 2011 10:20:14 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
In-Reply-To: <1311095876-3098-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177483>

Introduce a new "git cherry-pick --continue" command which uses the
information in ".git/sequencer" to continue a cherry-pick that stopped
because of a conflict or other error.  It works by dropping the first
instruction from .git/sequencer/todo and performing the remaining
cherry-picks listed there, with options (think "-s" and "-X") from the
initial command listed in ".git/sequencer/opts".

So now you can do:

$ git cherry-pick -Xpatience foo..bar
... description conflict in commit moo ...
$ git cherry-pick --continue
error: 'cherry-pick' is not possible because you have unmerged files.
fatal: failed to resume cherry-pick
$ echo resolved >conflictingfile
$ git add conflictingfile && git commit
$ git cherry-pick --continue; # resumes with the commit after "moo"

During the "git commit" stage, CHERRY_PICK_HEAD will aid by providing
the commit message from the conflicting "moo" commit.  Note that the
cherry-pick mechanism has no control at this stage, so the user is
free to violate anything that was specified during the first
cherry-pick invocation.  For example, if "-x" was specified during the
first cherry-pick invocation, the user is free to edit out the message
during commit time.  One glitch to note is that the "--signoff" option
specified at cherry-pick invocation time is not reflected in the
commit message provided by CHERRY_PICK_HEAD; the user must take care
to add "--signoff" during the "git commit" invocation.

Helped-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/git-cherry-pick.txt |    1 +
 Documentation/git-revert.txt      |    1 +
 Documentation/sequencer.txt       |    5 ++
 builtin/revert.c                  |   67 ++++++++++++++++++++++---
 t/t3510-cherry-pick-sequence.sh   |   99 +++++++++++++++++++++++++++++++++++++
 5 files changed, 165 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index 138a292..663186b 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -9,6 +9,7 @@ SYNOPSIS
 --------
 'git cherry-pick' [--edit] [-n] [-m parent-number] [-s] [-x] [--ff] <commit>...
 'git cherry-pick' --reset
+'git cherry-pick' --continue
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
index b6789be..923ae51 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -9,6 +9,7 @@ SYNOPSIS
 --------
 'git revert' [--edit | --no-edit] [-n] [-m parent-number] [-s] <commit>...
 'git revert' --reset
+'git revert' --continue
 
 DESCRIPTION
 -----------
diff --git a/Documentation/sequencer.txt b/Documentation/sequencer.txt
index 16ce88c..3e6df33 100644
--- a/Documentation/sequencer.txt
+++ b/Documentation/sequencer.txt
@@ -2,3 +2,8 @@
 	Forget about the current operation in progress.  Can be used
 	to clear the sequencer state after a failed cherry-pick or
 	revert.
+
+--continue::
+	Continue the operation in progress using the information in
+	'.git/sequencer'.  Can be used to continue after resolving
+	conflicts in a failed cherry-pick or revert.
diff --git a/builtin/revert.c b/builtin/revert.c
index 82a919a..6b5869e 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -40,7 +40,7 @@ static const char * const cherry_pick_usage[] = {
 };
 
 enum replay_action { REVERT, CHERRY_PICK };
-enum replay_subcommand { REPLAY_NONE, REPLAY_RESET };
+enum replay_subcommand { REPLAY_NONE, REPLAY_RESET, REPLAY_CONTINUE };
 
 struct replay_opts {
 	enum replay_action action;
@@ -65,7 +65,6 @@ struct replay_opts {
 };
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
-#define MAYBE_UNUSED __attribute__((__unused__))
 
 static const char *action_name(const struct replay_opts *opts)
 {
@@ -109,14 +108,40 @@ static void verify_opt_compatible(const char *me, const char *base_opt, ...)
 	va_end(ap);
 }
 
+static void verify_opt_mutually_compatible(const char *me, ...)
+{
+       const char *opt1, *opt2;
+       va_list ap;
+       int set;
+
+       va_start(ap, me);
+       while ((opt1 = va_arg(ap, const char *))) {
+	       set = va_arg(ap, int);
+	       if (set)
+		       break;
+       }
+       if (!opt1)
+	       goto ok;
+       while ((opt2 = va_arg(ap, const char *))) {
+	       set = va_arg(ap, int);
+	       if (set)
+		       die(_("%s: %s cannot be used with %s"),
+			       me, opt1, opt2);
+       }
+ok:
+       va_end(ap);
+}
+
 static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 {
 	const char * const * usage_str = revert_or_cherry_pick_usage(opts);
 	const char *me = action_name(opts);
 	int noop;
 	int reset = 0;
+	int contin = 0;
 	struct option options[] = {
 		OPT_BOOLEAN(0, "reset", &reset, "forget the current operation"),
+		OPT_BOOLEAN(0, "continue", &contin, "continue the current operation"),
 		OPT_BOOLEAN('n', "no-commit", &opts->no_commit, "don't automatically commit"),
 		OPT_BOOLEAN('e', "edit", &opts->edit, "edit the commit message"),
 		{ OPTION_BOOLEAN, 'r', NULL, &noop, NULL, "no-op (backward compatibility)",
@@ -146,15 +171,29 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 					PARSE_OPT_KEEP_ARGV0 |
 					PARSE_OPT_KEEP_UNKNOWN);
 
+	/* Check for incompatible subcommands */
+	verify_opt_mutually_compatible(me,
+				"--reset", reset,
+				"--continue", contin,
+				NULL);
+
 	/* Set the subcommand */
 	if (reset)
 		opts->subcommand = REPLAY_RESET;
+	else if (contin)
+		opts->subcommand = REPLAY_CONTINUE;
 	else
 		opts->subcommand = REPLAY_NONE;
 
 	/* Check for incompatible command line arguments */
-	if (opts->subcommand == REPLAY_RESET) {
-		verify_opt_compatible(me, "--reset",
+	if (opts->subcommand != REPLAY_NONE) {
+		char *this_operation;
+		if (opts->subcommand == REPLAY_RESET)
+			this_operation = "--reset";
+		else
+			this_operation = "--continue";
+
+		verify_opt_compatible(me, this_operation,
 				"--no-commit", opts->no_commit,
 				"--signoff", opts->signoff,
 				"--mainline", opts->mainline,
@@ -702,8 +741,8 @@ static struct commit *parse_insn_line(char *start, struct replay_opts *opts)
 	return commit;
 }
 
-static void MAYBE_UNUSED read_populate_todo(struct commit_list **todo_list,
-					struct replay_opts *opts)
+static void read_populate_todo(struct commit_list **todo_list,
+			struct replay_opts *opts)
 {
 	const char *todo_file = git_path(SEQ_TODO_FILE);
 	struct strbuf buf = STRBUF_INIT;
@@ -772,7 +811,7 @@ static int populate_opts_cb(const char *key, const char *value, void *data)
 	return 0;
 }
 
-static void MAYBE_UNUSED read_populate_opts(struct replay_opts **opts_ptr)
+static void read_populate_opts(struct replay_opts **opts_ptr)
 {
 	const char *opts_file = git_path(SEQ_OPTS_FILE);
 
@@ -923,6 +962,15 @@ static int pick_revisions(struct replay_opts *opts)
 	if (opts->subcommand == REPLAY_RESET) {
 		remove_sequencer_state(1);
 		return 0;
+	} else if (opts->subcommand == REPLAY_CONTINUE) {
+		if (!file_exists(git_path(SEQ_TODO_FILE)))
+			goto error;
+		read_populate_opts(&opts);
+		read_populate_todo(&todo_list, opts);
+
+		/* Verify that the conflict has been resolved */
+		if (!index_differs_from("HEAD", 0))
+			todo_list = todo_list->next;
 	} else {
 		/*
 		 * Start a new cherry-pick/ revert sequence; but
@@ -933,7 +981,8 @@ static int pick_revisions(struct replay_opts *opts)
 		walk_revs_populate_todo(&todo_list, opts);
 		if (create_seq_dir() < 0) {
 			advise(_("A cherry-pick or revert is in progress."));
-			advise(_("Use --reset to forget about it"));
+			advise(_("Use --continue to continue the operation"));
+			advise(_("or --reset to forget about it"));
 			return -1;
 		}
 		if (get_sha1("HEAD", sha1)) {
@@ -946,6 +995,8 @@ static int pick_revisions(struct replay_opts *opts)
 		save_todo(todo_list, opts);
 	}
 	return pick_commits(todo_list, opts);
+error:
+	return error(_("No %s in progress"), me);
 }
 
 int cmd_revert(int argc, const char **argv, const char *prefix)
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index 44277f5..0267714 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -117,4 +117,103 @@ test_expect_success 'cherry-pick does not implicitly stomp an existing operation
 	git cherry-pick --reset
 '
 
+test_expect_success '--continue complains when no cherry-pick is in progress' '
+	pristine_detach initial &&
+	test_must_fail git cherry-pick --continue
+'
+
+test_expect_success '--continue complains when there are unresolved conflicts' '
+	pristine_detach initial &&
+	test_must_fail git cherry-pick base..picked &&
+	test_must_fail git cherry-pick --continue &&
+	git cherry-pick --reset
+'
+
+test_expect_success '--continue continues after conflicts are resolved' '
+	pristine_detach initial &&
+	test_must_fail git cherry-pick base..anotherpick &&
+	echo "c" >foo &&
+	git add foo &&
+	git commit &&
+	git cherry-pick --continue &&
+	test_path_is_missing .git/sequencer &&
+	{
+		git rev-list HEAD |
+		git diff-tree --root --stdin |
+		sed "s/$_x40/OBJID/g"
+	} >actual &&
+	cat >expect <<-\EOF &&
+	OBJID
+	:100644 100644 OBJID OBJID M	foo
+	OBJID
+	:100644 100644 OBJID OBJID M	foo
+	OBJID
+	:100644 100644 OBJID OBJID M	unrelated
+	OBJID
+	:000000 100644 OBJID OBJID A	foo
+	:000000 100644 OBJID OBJID A	unrelated
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success '--continue respects opts' '
+	pristine_detach initial &&
+	test_must_fail git cherry-pick -x base..anotherpick &&
+	echo "c" >foo &&
+	git add foo &&
+	git commit &&
+	git cherry-pick --continue &&
+	test_path_is_missing .git/sequencer &&
+	git cat-file commit HEAD >anotherpick_msg &&
+	git cat-file commit HEAD~1 >picked_msg &&
+	git cat-file commit HEAD~2 >unrelatedpick_msg &&
+	git cat-file commit HEAD~3 >initial_msg &&
+	test_must_fail grep "cherry picked from" initial_msg &&
+	grep "cherry picked from" unrelatedpick_msg &&
+	grep "cherry picked from" picked_msg &&
+	grep "cherry picked from" anotherpick_msg
+'
+
+test_expect_success '--signoff is not automatically propogated to resolved conflict' '
+	pristine_detach initial &&
+	test_must_fail git cherry-pick --signoff base..anotherpick &&
+	echo "c" >foo &&
+	git add foo &&
+	git commit &&
+	git cherry-pick --continue &&
+	test_path_is_missing .git/sequencer &&
+	git cat-file commit HEAD >anotherpick_msg &&
+	git cat-file commit HEAD~1 >picked_msg &&
+	git cat-file commit HEAD~2 >unrelatedpick_msg &&
+	git cat-file commit HEAD~3 >initial_msg &&
+	test_must_fail grep "Signed-off-by:" initial_msg &&
+	grep "Signed-off-by:" unrelatedpick_msg &&
+	test_must_fail grep "Signed-off-by:" picked_msg &&
+	grep "Signed-off-by:" anotherpick_msg
+'
+
+test_expect_success 'malformed instruction sheet 1' '
+	pristine_detach initial &&
+	test_must_fail git cherry-pick base..picked &&
+	echo "resolved" >foo &&
+	git add foo &&
+	git commit &&
+	sed "s/pick /pick/" .git/sequencer/todo >new_sheet
+	cp new_sheet .git/sequencer/todo
+	test_must_fail git cherry-pick --continue &&
+	git cherry-pick --reset
+'
+
+test_expect_success 'malformed instruction sheet 2' '
+	pristine_detach initial &&
+	test_must_fail git cherry-pick base..picked &&
+	echo "resolved" >foo &&
+	git add foo &&
+	git commit &&
+	sed "s/pick/revert/" .git/sequencer/todo >new_sheet
+	cp new_sheet .git/sequencer/todo
+	test_must_fail git cherry-pick --continue &&
+	git cherry-pick --reset
+'
+
 test_done
-- 
1.7.4.rc1.7.g2cf08.dirty
