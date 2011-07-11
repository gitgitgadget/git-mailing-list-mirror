From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 17/17] revert: Introduce --continue to continue the operation
Date: Mon, 11 Jul 2011 14:54:08 +0000
Message-ID: <1310396048-24925-18-git-send-email-artagnon@gmail.com>
References: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 11 16:55:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgHtE-0005dD-O7
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jul 2011 16:55:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757885Ab1GKOyq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jul 2011 10:54:46 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:46637 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757878Ab1GKOyl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2011 10:54:41 -0400
Received: by mail-vx0-f174.google.com with SMTP id 39so2716724vxb.19
        for <git@vger.kernel.org>; Mon, 11 Jul 2011 07:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=aGfnSGbqou/QNrMzYj7igRYFZozRa70SueVjoN8rLI8=;
        b=SOZhTmXSOi4puLTuS3eu3lUJR7/F479p2X8+2unvtpKmGN/xrb+elyELvVJK3iIs1f
         iQt7MLnkcKkEM3X4C4FIzAX9Qin26rE2WH/hyvnBEpkfYAAmWjoTbL7svDuxFDGRBa1k
         uLpFXhEisvu3oVaG03exsSJh8gpiR4qYsMc+Q=
Received: by 10.52.175.162 with SMTP id cb2mr2230385vdc.432.1310396080712;
        Mon, 11 Jul 2011 07:54:40 -0700 (PDT)
Received: from localhost.localdomain (ec2-184-72-137-52.compute-1.amazonaws.com [184.72.137.52])
        by mx.google.com with ESMTPS id b9sm4510527vdk.25.2011.07.11.07.54.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 11 Jul 2011 07:54:39 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176855>

Using the information in ".git/sequencer", it is now possible to
continue a cherry-pick or continue after a conflict.  To do this, we
have to parse the information in ".git/sequencer/opts" into the
replay_opts structure and build a commit_list from the information in
".git/sequencer/todo" before calling into the cherry-picking
machinery.  Introduce a new subcommand called '--continue' to
facilitate this.  It is imperative to note that this subcommand will
blindly drop the first instruction and attempt to perform the rest of
the instructions in ".git/sequencer/todo" to affect the current HEAD
provided that the index matches HEAD.  The resulting end-user workflow
is as follows:

$ git cherry-pick foo..bar
... conflict in commit moo ...
$ git cherry-pick --continue
error: 'cherry-pick' is not possible because you have unmerged files.
...
$ echo "resolved" >conflictingfile
$ git commit # this is a replacement for "moo"
$ git cherry-pick --continue # drops "moo" and replays everything else

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

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/git-cherry-pick.txt |    1 +
 Documentation/git-revert.txt      |    1 +
 Documentation/sequencer.txt       |    5 ++
 builtin/revert.c                  |   60 ++++++++++++++++++++++--
 t/t3510-cherry-pick-sequence.sh   |   93 +++++++++++++++++++++++++++++++++++++
 5 files changed, 156 insertions(+), 4 deletions(-)

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
index 783ffb4..9be2fe2 100644
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
index 409d88f..f974ee0 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -41,7 +41,7 @@ static const char * const cherry_pick_usage[] = {
 
 static const char *me;
 enum replay_action { REVERT, CHERRY_PICK };
-enum replay_subcommand { REPLAY_NONE, REPLAY_RESET };
+enum replay_subcommand { REPLAY_NONE, REPLAY_RESET, REPLAY_CONTINUE };
 
 struct replay_opts {
 	enum replay_action action;
@@ -104,13 +104,39 @@ static void verify_opt_compatible(const char *me, const char *base_opt, ...)
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
 	int noop;
 	int reset = 0;
+	int contin = 0;
 	struct option options[] = {
 		OPT_BOOLEAN(0, "reset", &reset, "forget the current operation"),
+		OPT_BOOLEAN(0, "continue", &contin, "continue the current operation"),
 		OPT_BOOLEAN('n', "no-commit", &opts->no_commit, "don't automatically commit"),
 		OPT_BOOLEAN('e', "edit", &opts->edit, "edit the commit message"),
 		{ OPTION_BOOLEAN, 'r', NULL, &noop, NULL, "no-op (backward compatibility)",
@@ -140,15 +166,29 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
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
@@ -1051,6 +1091,15 @@ static int process_subcommand(struct replay_opts *opts)
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
@@ -1059,7 +1108,8 @@ static int process_subcommand(struct replay_opts *opts)
 		 */
 		if (file_exists(git_path(SEQ_TODO_FILE))) {
 			error(_("A %s is already in progress"), me);
-			advise(_("Use %s --reset to forget about it"), me);
+			advise(_("Use %s --continue to continue the operation"), me);
+			advise(_("or use %s --reset to forget about it"), me);
 			return -1;
 		}
 
@@ -1071,6 +1121,8 @@ static int process_subcommand(struct replay_opts *opts)
 		save_todo(todo_list, opts);
 	}
 	return pick_commits(todo_list, opts);
+error:
+	return error(_("No %s in progress"), me);
 }
 
 int cmd_revert(int argc, const char **argv, const char *prefix)
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index c21b345..635a45e 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -101,4 +101,97 @@ test_expect_success '--reset cleans up sequencer state' '
 	test_path_is_missing .git/sequencer
 '
 
+test_expect_success '--continue complains when no cherry-pick is in progress' '
+	pristine_detach initial &&
+	test_must_fail git cherry-pick --continue >actual 2>&1 &&
+	test_i18ngrep "error" actual
+'
+
+test_expect_success '--continue complains when there are unresolved conflicts' '
+	pristine_detach initial &&
+	head=$(git rev-parse HEAD) &&
+	test_must_fail git cherry-pick base..picked &&
+	test_must_fail git cherry-pick --continue &&
+	git cherry-pick --reset
+'
+
+test_expect_success '--continue continues after conflicts are resolved' '
+	pristine_detach initial &&
+	head=$(git rev-parse HEAD) &&
+	test_must_fail git cherry-pick base..anotherpick &&
+	echo "c" >foo &&
+	git add foo &&
+	git commit &&
+	git cherry-pick --continue &&
+	test_path_is_missing .git/sequencer &&
+	{
+		git rev-list HEAD |
+		git diff-tree --root --stdin |
+		sed "s/[0-9a-f]\{40\}/OBJID/g"
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
+	head=$(git rev-parse HEAD) &&
+	test_must_fail git cherry-pick -s -x base..anotherpick &&
+	echo "c" >foo &&
+	git add foo &&
+	git commit -s &&
+	git cherry-pick --continue &&
+	test_path_is_missing .git/sequencer &&
+	git cat-file commit HEAD >anotherpick_msg &&
+	git cat-file commit HEAD~1 >picked_msg &&
+	git cat-file commit HEAD~2 >unrelatedpick_msg &&
+	git cat-file commit HEAD~3 >initial_msg &&
+	test_must_fail test_i18ngrep "Signed-off-by:" initial_msg &&
+	test_i18ngrep "Signed-off-by:" unrelatedpick_msg &&
+	test_i18ngrep "Signed-off-by:" picked_msg &&
+	test_i18ngrep "Signed-off-by:" anotherpick_msg &&
+	test_must_fail test_i18ngrep "cherry picked from" initial_msg &&
+	test_i18ngrep "cherry picked from" unrelatedpick_msg &&
+	test_i18ngrep "cherry picked from" picked_msg &&
+	test_i18ngrep "cherry picked from" anotherpick_msg
+'
+
+test_expect_success 'malformed instruction sheet 1' '
+	pristine_detach initial &&
+	head=$(git rev-parse HEAD) &&
+	test_must_fail git cherry-pick base..picked &&
+	echo "resolved" >foo &&
+	git add foo &&
+	git commit &&
+	sed "s/pick /pick/" .git/sequencer/todo >new_sheet
+	cp new_sheet .git/sequencer/todo
+	test_must_fail git cherry-pick --continue >actual 2>&1 &&
+	git cherry-pick --reset &&
+	test_i18ngrep "fatal" actual
+'
+
+test_expect_success 'malformed instruction sheet 2' '
+	pristine_detach initial &&
+	head=$(git rev-parse HEAD) &&
+	test_must_fail git cherry-pick base..picked &&
+	echo "resolved" >foo &&
+	git add foo &&
+	git commit &&
+	sed "s/pick/revert/" .git/sequencer/todo >new_sheet
+	cp new_sheet .git/sequencer/todo
+	test_must_fail git cherry-pick --continue >actual 2>&1 &&
+	git cherry-pick --reset &&
+	test_i18ngrep "fatal" actual
+'
+
 test_done
-- 
1.7.5.GIT
