From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 13/14] revert: Introduce --continue to continue the operation
Date: Wed,  6 Jul 2011 07:54:27 +0000
Message-ID: <1309938868-2028-14-git-send-email-artagnon@gmail.com>
References: <1309938868-2028-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 06 09:55:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeMx3-00068m-Aw
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 09:55:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752695Ab1GFHy5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jul 2011 03:54:57 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:43982 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752517Ab1GFHyz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2011 03:54:55 -0400
Received: by mail-qw0-f46.google.com with SMTP id 3so3221737qwk.19
        for <git@vger.kernel.org>; Wed, 06 Jul 2011 00:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=uPFc1vlub7N3Q1V2pK8GhRADFxZw/5FN7PZc5SEXgeY=;
        b=EMIoCIn+UFQHIbc0vEyYNoMHMGvpspAJ5ns/fAzt/HL2fGK/OrNX4VQENePMECmk1c
         KK8GQd7gHHrJ9NI1JCzERPP3iyHztUZhLwvpcrNDAFTNB4LvBWpmVWGcr0vXl0z8ChnT
         IsSWInnx77P9Tndmzeh/DDvTVgAxvA9cMUS+g=
Received: by 10.224.199.69 with SMTP id er5mr5921514qab.239.1309938894702;
        Wed, 06 Jul 2011 00:54:54 -0700 (PDT)
Received: from localhost.localdomain (ec2-184-72-137-52.compute-1.amazonaws.com [184.72.137.52])
        by mx.google.com with ESMTPS id e18sm6212790qcs.5.2011.07.06.00.54.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Jul 2011 00:54:53 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1309938868-2028-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176659>

After resolving a conflict, the user simply has to `git commit`
(CHERRY_PICK_HEAD will help), and then `git cherry-pick --continue` to
continue the operation.  Command-line options are currently
unsupported.  Note that a cherry-pick operation cannot be resumed with
a `git revert --continue` and vice-versa.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 As suggested by Miles and Junio, I've obfuscated the variable name to
 "contin".  Would it make sense to persist the entire replay_opts
 structure (so that it applies to all the commits, and no
 commit-specific command-line options are supported) somewhere?  Where
 and how?  My idea is that patch can be considered for inclusion then.
 Patch 14 onwards can then start adding features like "commit-specific
 command-line options", "mixed commands" etc.

 builtin/revert.c                |  130 ++++++++++++++++++++++++++++++++++++++-
 t/t3510-cherry-pick-sequence.sh |   68 ++++++++++++++++++++
 2 files changed, 195 insertions(+), 3 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 9e18d64..6ef56ee 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -47,6 +47,7 @@ struct replay_opts {
 	enum replay_action action;
 
 	int reset;
+	int contin;
 
 	/* Boolean options */
 	int edit;
@@ -105,12 +106,37 @@ static void verify_opt_compatible(const char *me, const char *base_opt, ...)
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
 	int noop;
 	struct option options[] = {
 		OPT_BOOLEAN(0, "reset", &opts->reset, "forget the current operation"),
+		OPT_BOOLEAN(0, "continue", &opts->contin, "continue the current operation"),
 		OPT_BOOLEAN('n', "no-commit", &opts->no_commit, "don't automatically commit"),
 		OPT_BOOLEAN('e', "edit", &opts->edit, "edit the commit message"),
 		{ OPTION_BOOLEAN, 'r', NULL, &noop, NULL, "no-op (backward compatibility)",
@@ -140,9 +166,21 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 					PARSE_OPT_KEEP_ARGV0 |
 					PARSE_OPT_KEEP_UNKNOWN);
 
+	/* Check for mutually incompatible command line arguments */
+	verify_opt_mutually_compatible(me,
+				"--reset", opts->reset,
+				"--continue", opts->contin,
+				NULL);
+
 	/* Check for incompatible command line arguments */
-	if (opts->reset) {
-		verify_opt_compatible(me, "--reset",
+	if (opts->reset || opts->contin) {
+		char *this_operation;
+		if (opts->reset)
+			this_operation = "--reset";
+		else
+			this_operation = "--continue";
+
+		verify_opt_compatible(me, this_operation,
 				"--no-commit", opts->no_commit,
 				"--signoff", opts->signoff,
 				"--mainline", opts->mainline,
@@ -617,6 +655,83 @@ static void format_todo(struct strbuf *buf, struct commit_list *todo_list,
 	}
 }
 
+static struct commit *parse_insn_line(char *start, struct replay_opts *opts)
+{
+	unsigned char commit_sha1[20];
+	char sha1_abbrev[40];
+	struct commit *commit;
+	enum replay_action action;
+	int insn_len = 0;
+	char *p;
+
+	p = start;
+	if (!(p = strchr(p, ' ')))
+		return NULL;
+	insn_len = p - start;
+	if (!(p = strchr(p + 1, ' ')))
+		return NULL;
+	p += 1;
+	strlcpy(sha1_abbrev, start + insn_len + 1,
+		p - (start + insn_len + 1));
+
+	if (!strncmp(start, "pick", insn_len))
+		action = CHERRY_PICK;
+	else if (!strncmp(start, "revert", insn_len))
+		action = REVERT;
+	else
+		return NULL;
+
+	/*
+	 * Verify that the action matches up with the one in
+	 * opts; we don't support arbitrary instructions
+	 */
+	if (action != opts->action)
+		return NULL;
+
+	if ((get_sha1(sha1_abbrev, commit_sha1) < 0)
+		|| !(commit = lookup_commit_reference(commit_sha1)))
+		return NULL;
+
+	return commit;
+}
+
+static void read_populate_todo(struct commit_list **todo_list,
+			struct replay_opts *opts)
+{
+	struct strbuf buf = STRBUF_INIT;
+	struct commit_list *new;
+	struct commit_list **next;
+	struct commit *commit;
+	char *p;
+	int fd;
+
+	fd = open(git_path(SEQ_TODO_FILE), O_RDONLY);
+	if (fd < 0) {
+		strbuf_release(&buf);
+		die_errno(_("Could not open %s."), git_path(SEQ_TODO_FILE));
+	}
+	if (strbuf_read(&buf, fd, 0) < buf.len) {
+		close(fd);
+		strbuf_release(&buf);
+		die(_("Could not read %s."), git_path(SEQ_TODO_FILE));
+	}
+	close(fd);
+
+	next = todo_list;
+	for (p = buf.buf; *p; p = strchr(p, '\n') + 1) {
+		if (!(commit = parse_insn_line(p, opts))) {
+			strbuf_release(&buf);
+			die(_("Malformed instruction sheet: %s"), git_path(SEQ_TODO_FILE));
+		}
+		new = xmalloc(sizeof(struct commit_list));
+		new->item = commit;
+		*next = new;
+		next = &new->next;
+	}
+	*next = NULL;
+	strbuf_release(&buf);
+}
+
 static void walk_revs_populate_todo(struct commit_list **todo_list,
 				struct replay_opts *opts)
 {
@@ -733,6 +848,14 @@ static int process_continuation(struct replay_opts *opts)
 		if (!file_exists(git_path(SEQ_TODO_FILE)))
 			goto error;
 		return cleanup_sequencer_data();
+	} else if (opts->contin) {
+		if (!file_exists(git_path(SEQ_TODO_FILE)))
+			goto error;
+		read_populate_todo(&todo_list, opts);
+
+		/* Verify that the conflict has been resolved */
+		if (!index_differs_from("HEAD", 0))
+			todo_list = todo_list->next;
 	} else {
 		/*
 		 * Start a new cherry-pick/ revert sequence; but
@@ -741,7 +864,8 @@ static int process_continuation(struct replay_opts *opts)
 		 */
 		if (file_exists(git_path(SEQ_TODO_FILE))) {
 			error(_("A %s is already in progress"), me);
-			advise(_("Use %s --reset to forget about it"), me);
+			advise(_("Use %s --continue to continue the operation"), me);
+			advise(_("or use %s --reset to forget about it"), me);
 			return -1;
 		}
 
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index 9e97a7b..7a57216 100644
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -48,4 +48,72 @@ test_expect_success '--reset cleans up sequencer directory' '
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
+	test_must_fail git cherry-pick base..picked &&
+	echo "resolved" >foo &&
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
+	:100644 100644 OBJID OBJID M	unrelated
+	OBJID
+	:000000 100644 OBJID OBJID A	foo
+	:000000 100644 OBJID OBJID A	unrelated
+	EOF
+	test_cmp expect actual
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
