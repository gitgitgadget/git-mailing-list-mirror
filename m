From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 17/18] revert: Introduce --continue to continue the operation
Date: Thu, 28 Jul 2011 22:22:30 +0530
Message-ID: <1311871951-3497-18-git-send-email-artagnon@gmail.com>
References: <1311871951-3497-1-git-send-email-artagnon@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 28 18:57:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmTtL-00049i-Hk
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jul 2011 18:57:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755900Ab1G1Q4y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jul 2011 12:56:54 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:45850 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755780Ab1G1Q4v (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2011 12:56:51 -0400
Received: by gyh3 with SMTP id 3so1953475gyh.19
        for <git@vger.kernel.org>; Thu, 28 Jul 2011 09:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=OOO1OzNBB/2JlXIjytUqnAnAg68sVJwR4jyObmyEqaw=;
        b=Vg8ykzbn7ezV+SzpCk74jfBq0rjX35PKzlMbPahI9ezblz6gHRSZSIPmnRzU9TXpxu
         CY0X0m/TEEOrgNEeS24eSzqshgh+aw+6c/nv1ptDFVWdZq88tVCzAghKq5eqag9uZGGp
         svzYjU9piITgZbb5NzPZfVi21PH5S+KnZkLlg=
Received: by 10.42.197.72 with SMTP id ej8mr169986icb.258.1311872210314;
        Thu, 28 Jul 2011 09:56:50 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id ue1sm1497759icb.8.2011.07.28.09.56.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 28 Jul 2011 09:56:49 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
In-Reply-To: <1311871951-3497-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178096>

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
during commit time.  Note that the "--signoff" option specified at
cherry-pick invocation time is not reflected in the commit message
provided by CHERRY_PICK_HEAD; the user must take care to add
"--signoff" during the "git commit" invocation.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-cherry-pick.txt |    1 +
 Documentation/git-revert.txt      |    1 +
 Documentation/sequencer.txt       |    5 +
 builtin/revert.c                  |  184 ++++++++++++++++++++++++++++++++++++-
 t/t3510-cherry-pick-sequence.sh   |  102 ++++++++++++++++++++
 5 files changed, 289 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index 12a85ba..b4a2d74 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -10,6 +10,7 @@ SYNOPSIS
 [verse]
 'git cherry-pick' [--edit] [-n] [-m parent-number] [-s] [-x] [--ff] <commit>...
 'git cherry-pick' --reset
+'git cherry-pick' --continue
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
index 31c85b4..68f8e68 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -10,6 +10,7 @@ SYNOPSIS
 [verse]
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
index e173c71..985f49f 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -40,7 +40,7 @@ static const char * const cherry_pick_usage[] = {
 };
 
 enum replay_action { REVERT, CHERRY_PICK };
-enum replay_subcommand { REPLAY_NONE, REPLAY_RESET };
+enum replay_subcommand { REPLAY_NONE, REPLAY_RESET, REPLAY_CONTINUE };
 
 struct replay_opts {
 	enum replay_action action;
@@ -117,14 +117,40 @@ static void verify_opt_compatible(const char *me, const char *base_opt, ...)
 	va_end(ap);
 }
 
+static void verify_opt_mutually_compatible(const char *me, ...)
+{
+	const char *opt1, *opt2;
+	va_list ap;
+	int set;
+
+	va_start(ap, me);
+	while ((opt1 = va_arg(ap, const char *))) {
+		set = va_arg(ap, int);
+		if (set)
+			break;
+	}
+	if (!opt1)
+		goto ok;
+	while ((opt2 = va_arg(ap, const char *))) {
+		set = va_arg(ap, int);
+		if (set)
+			die(_("%s: %s cannot be used with %s"),
+				me, opt1, opt2);
+	}
+ok:
+	va_end(ap);
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
@@ -154,15 +180,29 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
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
@@ -668,6 +708,130 @@ static int format_todo(struct strbuf *buf, struct commit_list *todo_list,
 	return 0;
 }
 
+static struct commit *parse_insn_line(char *start, struct replay_opts *opts)
+{
+	unsigned char commit_sha1[20];
+	char sha1_abbrev[40];
+	enum replay_action action;
+	int insn_len = 0;
+	char *p, *q;
+
+	if (!prefixcmp(start, "pick ")) {
+		action = CHERRY_PICK;
+		insn_len = strlen("pick");
+		p = start + insn_len + 1;
+	} else if (!prefixcmp(start, "revert ")) {
+		action = REVERT;
+		insn_len = strlen("revert");
+		p = start + insn_len + 1;
+	} else
+		return NULL;
+
+	q = strchr(p, ' ');
+	if (!q)
+		return NULL;
+	q++;
+
+	strlcpy(sha1_abbrev, p, q - p);
+
+	/*
+	 * Verify that the action matches up with the one in
+	 * opts; we don't support arbitrary instructions
+	 */
+	if (action != opts->action) {
+		const char *action_str;
+		action_str = action == REVERT ? "revert" : "cherry-pick";
+		error(_("Cannot %s during a %s"), action_str, action_name(opts));
+		return NULL;
+	}
+
+	if (get_sha1(sha1_abbrev, commit_sha1) < 0)
+		return NULL;
+
+	return lookup_commit_reference(commit_sha1);
+}
+
+static void read_populate_todo(struct commit_list **todo_list,
+			struct replay_opts *opts)
+{
+	const char *todo_file = git_path(SEQ_TODO_FILE);
+	struct strbuf buf = STRBUF_INIT;
+	struct commit_list **next;
+	struct commit *commit;
+	char *p;
+	int fd;
+
+	fd = open(todo_file, O_RDONLY);
+	if (fd < 0) {
+		strbuf_release(&buf);
+		die_errno(_("Could not open %s."), todo_file);
+	}
+	if (strbuf_read(&buf, fd, 0) < buf.len) {
+		close(fd);
+		strbuf_release(&buf);
+		die(_("Could not read %s."), todo_file);
+	}
+	close(fd);
+
+	next = todo_list;
+	for (p = buf.buf; *p; p = strchr(p, '\n') + 1) {
+		commit = parse_insn_line(p, opts);
+		if (!commit)
+			goto error;
+		next = commit_list_append(commit, next);
+	}
+	if (!*todo_list)
+		goto error;
+	strbuf_release(&buf);
+	return;
+error:
+	strbuf_release(&buf);
+	die(_("Unusable instruction sheet: %s"), todo_file);
+}
+
+static int populate_opts_cb(const char *key, const char *value, void *data)
+{
+	struct replay_opts *opts = data;
+	int error_flag = 1;
+
+	if (!value)
+		error_flag = 0;
+	else if (!strcmp(key, "options.no-commit"))
+		opts->no_commit = git_config_bool_or_int(key, value, &error_flag);
+	else if (!strcmp(key, "options.edit"))
+		opts->edit = git_config_bool_or_int(key, value, &error_flag);
+	else if (!strcmp(key, "options.signoff"))
+		opts->signoff = git_config_bool_or_int(key, value, &error_flag);
+	else if (!strcmp(key, "options.record-origin"))
+		opts->record_origin = git_config_bool_or_int(key, value, &error_flag);
+	else if (!strcmp(key, "options.allow-ff"))
+		opts->allow_ff = git_config_bool_or_int(key, value, &error_flag);
+	else if (!strcmp(key, "options.mainline"))
+		opts->mainline = git_config_int(key, value);
+	else if (!strcmp(key, "options.strategy"))
+		git_config_string(&opts->strategy, key, value);
+	else if (!strcmp(key, "options.strategy-option")) {
+		ALLOC_GROW(opts->xopts, opts->xopts_nr + 1, opts->xopts_alloc);
+		opts->xopts[opts->xopts_nr++] = xstrdup(value);
+	} else
+		return error(_("Invalid key: %s"), key);
+
+	if (!error_flag)
+		return error(_("Invalid value for %s: %s"), key, value);
+
+	return 0;
+}
+
+static void read_populate_opts(struct replay_opts **opts_ptr)
+{
+	const char *opts_file = git_path(SEQ_OPTS_FILE);
+
+	if (!file_exists(opts_file))
+		return;
+	if (git_config_from_file(populate_opts_cb, opts_file, *opts_ptr) < 0)
+		die(_("Malformed options sheet: %s"), opts_file);
+}
+
 static void walk_revs_populate_todo(struct commit_list **todo_list,
 				struct replay_opts *opts)
 {
@@ -808,6 +972,15 @@ static int pick_revisions(struct replay_opts *opts)
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
@@ -818,7 +991,8 @@ static int pick_revisions(struct replay_opts *opts)
 		walk_revs_populate_todo(&todo_list, opts);
 		if (create_seq_dir() < 0) {
 			fatal(_("A cherry-pick or revert is in progress."));
-			advise(_("Use --reset to forget about it"));
+			advise(_("Use --continue to continue the operation"));
+			advise(_("or --reset to forget about it"));
 			exit(128);
 		}
 		if (get_sha1("HEAD", sha1)) {
@@ -830,6 +1004,8 @@ static int pick_revisions(struct replay_opts *opts)
 		save_opts(opts);
 	}
 	return pick_commits(todo_list, opts);
+error:
+	die(_("No %s in progress"), action_name(opts));
 }
 
 int cmd_revert(int argc, const char **argv, const char *prefix)
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index 342cab3..88ea6a4 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -120,4 +120,106 @@ test_expect_success 'cherry-pick does not implicitly stomp an existing operation
 	test_cmp expect actual
 '
 
+test_expect_success '--continue complains when no cherry-pick is in progress' '
+	git cherry-pick --reset &&
+	pristine_detach initial &&
+	test_must_fail git cherry-pick --continue
+'
+
+test_expect_success '--continue complains when there are unresolved conflicts' '
+	git cherry-pick --reset &&
+	pristine_detach initial &&
+	test_must_fail git cherry-pick base..picked &&
+	test_must_fail git cherry-pick --continue
+'
+
+test_expect_success '--continue continues after conflicts are resolved' '
+	git cherry-pick --reset &&
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
+	git cherry-pick --reset &&
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
+	git cherry-pick --reset &&
+	pristine_detach initial &&
+	test_must_fail git cherry-pick base..picked &&
+	echo "resolved" >foo &&
+	git add foo &&
+	git commit &&
+	sed "s/pick /pick/" .git/sequencer/todo >new_sheet
+	cp new_sheet .git/sequencer/todo
+	test_must_fail git cherry-pick --continue
+'
+
+test_expect_success 'malformed instruction sheet 2' '
+	git cherry-pick --reset &&
+	pristine_detach initial &&
+	test_must_fail git cherry-pick base..picked &&
+	echo "resolved" >foo &&
+	git add foo &&
+	git commit &&
+	sed "s/pick/revert/" .git/sequencer/todo >new_sheet
+	cp new_sheet .git/sequencer/todo
+	test_must_fail git cherry-pick --continue
+'
+
 test_done
-- 
1.7.4.rc1.7.g2cf08.dirty
