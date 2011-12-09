From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 7/9] revert: allow mixed pick and revert instructions
Date: Fri,  9 Dec 2011 21:12:04 +0530
Message-ID: <1323445326-24637-8-git-send-email-artagnon@gmail.com>
References: <1323445326-24637-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 09 16:43:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZ2br-00016w-6T
	for gcvg-git-2@lo.gmane.org; Fri, 09 Dec 2011 16:43:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754552Ab1LIPng (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Dec 2011 10:43:36 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:56207 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754480Ab1LIPnf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Dec 2011 10:43:35 -0500
Received: by qadc12 with SMTP id c12so570899qad.19
        for <git@vger.kernel.org>; Fri, 09 Dec 2011 07:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=A0gkTgQdeFwujcA/TjcsFk9yVxZUzBO8Ebz7owid3pc=;
        b=N4/HLOzDopSECtDwVVaCI12HWwWHksf/HQSNM1eHq1CFEjrukeBrTirVOVHnKZMvEd
         4ojfmtqatZ9Gxj48m1m35Ghk/kddqkKb0SxqRmLZ1F6efXCTniYjyJ2TRS2KTmrI8yet
         6co682bG97R7xFcS5bhgxlN0zJHfJyj08n0M0=
Received: by 10.50.87.167 with SMTP id az7mr3787997igb.64.1323445414801;
        Fri, 09 Dec 2011 07:43:34 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.205])
        by mx.google.com with ESMTPS id a2sm18298821igj.7.2011.12.09.07.43.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 09 Dec 2011 07:43:33 -0800 (PST)
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1323445326-24637-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186644>

Parse the instruction sheet in '.git/sequencer/todo' as a list of
(action, operand) pairs, instead of assuming that all instructions use
the same action.  Now you can do:

  pick fdc0b12 picked
  revert 965fed4 anotherpick

For cherry-pick and revert, this means that a 'git cherry-pick
--continue' can continue an ongoing revert operation and viceversa.

Helped-by: Jonathan Nieder <jrnider@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/revert.c                |  133 +++++++++++++++++++--------------------
 t/t3510-cherry-pick-sequence.sh |   58 +++++++++++++++++
 2 files changed, 124 insertions(+), 67 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 86af516..cc55823 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -39,7 +39,7 @@ static const char * const cherry_pick_usage[] = {
 	NULL
 };
 
-enum replay_action { REVERT, CHERRY_PICK };
+enum replay_action { REPLAY_REVERT, REPLAY_PICK };
 enum replay_subcommand {
 	REPLAY_NONE,
 	REPLAY_REMOVE_STATE,
@@ -47,6 +47,12 @@ enum replay_subcommand {
 	REPLAY_ROLLBACK
 };
 
+struct replay_insn_list {
+	enum replay_action action;
+	struct commit *operand;
+	struct replay_insn_list *next;
+};
+
 struct replay_opts {
 	enum replay_action action;
 	enum replay_subcommand subcommand;
@@ -73,14 +79,14 @@ struct replay_opts {
 
 static const char *action_name(const struct replay_opts *opts)
 {
-	return opts->action == REVERT ? "revert" : "cherry-pick";
+	return opts->action == REPLAY_REVERT ? "revert" : "cherry-pick";
 }
 
 static char *get_encoding(const char *message);
 
 static const char * const *revert_or_cherry_pick_usage(struct replay_opts *opts)
 {
-	return opts->action == REVERT ? revert_usage : cherry_pick_usage;
+	return opts->action == REPLAY_REVERT ? revert_usage : cherry_pick_usage;
 }
 
 static int option_parse_x(const struct option *opt,
@@ -159,7 +165,7 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 		OPT_END(),
 	};
 
-	if (opts->action == CHERRY_PICK) {
+	if (opts->action == REPLAY_PICK) {
 		struct option cp_extra[] = {
 			OPT_BOOLEAN('x', NULL, &opts->record_origin, "append commit name"),
 			OPT_BOOLEAN(0, "ff", &opts->allow_ff, "allow fast-forward"),
@@ -363,7 +369,7 @@ static int error_dirty_index(struct replay_opts *opts)
 		return error_resolve_conflict(action_name(opts));
 
 	/* Different translation strings for cherry-pick and revert */
-	if (opts->action == CHERRY_PICK)
+	if (opts->action == REPLAY_PICK)
 		error(_("Your local changes would be overwritten by cherry-pick."));
 	else
 		error(_("Your local changes would be overwritten by revert."));
@@ -467,7 +473,8 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts)
 	return run_command_v_opt(args, RUN_GIT_CMD);
 }
 
-static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
+static int do_pick_commit(struct commit *commit, enum replay_action action,
+			struct replay_opts *opts)
 {
 	unsigned char head[20];
 	struct commit *base, *next, *parent;
@@ -542,7 +549,7 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 
 	defmsg = git_pathdup("MERGE_MSG");
 
-	if (opts->action == REVERT) {
+	if (action == REPLAY_REVERT) {
 		base = commit;
 		base_label = msg.label;
 		next = parent;
@@ -583,7 +590,7 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 		}
 	}
 
-	if (!opts->strategy || !strcmp(opts->strategy, "recursive") || opts->action == REVERT) {
+	if (!opts->strategy || !strcmp(opts->strategy, "recursive") || action == REPLAY_REVERT) {
 		res = do_recursive_merge(base, next, base_label, next_label,
 					 head, &msgbuf, opts);
 		write_message(&msgbuf, defmsg);
@@ -607,13 +614,13 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 	 * However, if the merge did not even start, then we don't want to
 	 * write it at all.
 	 */
-	if (opts->action == CHERRY_PICK && !opts->no_commit && (res == 0 || res == 1))
+	if (opts->action == REPLAY_PICK && !opts->no_commit && (res == 0 || res == 1))
 		write_cherry_pick_head(commit, "CHERRY_PICK_HEAD");
-	if (opts->action == REVERT && ((opts->no_commit && res == 0) || res == 1))
+	if (opts->action == REPLAY_REVERT && ((opts->no_commit && res == 0) || res == 1))
 		write_cherry_pick_head(commit, "REVERT_HEAD");
 
 	if (res) {
-		error(opts->action == REVERT
+		error(action == REPLAY_REVERT
 		      ? _("could not revert %s... %s")
 		      : _("could not apply %s... %s"),
 		      find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV),
@@ -637,7 +644,7 @@ static void prepare_revs(struct rev_info *revs, struct replay_opts *opts)
 
 	init_revisions(revs, NULL);
 	revs->no_walk = 1;
-	if (opts->action != REVERT)
+	if (opts->action != REPLAY_REVERT)
 		revs->reverse = 1;
 
 	argc = setup_revisions(opts->commit_argc, opts->commit_argv, revs, NULL);
@@ -683,49 +690,49 @@ static void read_and_refresh_cache(struct replay_opts *opts)
  *     assert(commit_list_count(list) == 2);
  *     return list;
  */
-static struct commit_list **commit_list_append(struct commit *commit,
-					       struct commit_list **next)
+static struct replay_insn_list **replay_insn_list_append(enum replay_action action,
+						struct commit *operand,
+						struct replay_insn_list **next)
 {
-	struct commit_list *new = xmalloc(sizeof(struct commit_list));
-	new->item = commit;
+	struct replay_insn_list *new = xmalloc(sizeof(*new));
+	new->action = action;
+	new->operand = operand;
 	*next = new;
 	new->next = NULL;
 	return &new->next;
 }
 
-static int format_todo(struct strbuf *buf, struct commit_list *todo_list,
-		struct replay_opts *opts)
+static int format_todo(struct strbuf *buf, struct replay_insn_list *todo_list)
 {
-	struct commit_list *cur = NULL;
-	const char *sha1_abbrev = NULL;
-	const char *action_str = opts->action == REVERT ? "revert" : "pick";
-	const char *subject;
-	int subject_len;
+	struct replay_insn_list *cur;
 
 	for (cur = todo_list; cur; cur = cur->next) {
-		sha1_abbrev = find_unique_abbrev(cur->item->object.sha1, DEFAULT_ABBREV);
-		subject_len = find_commit_subject(cur->item->buffer, &subject);
+		const char *sha1_abbrev, *action_str, *subject;
+		int subject_len;
+
+		action_str = cur->action == REPLAY_REVERT ? "revert" : "pick";
+		sha1_abbrev = find_unique_abbrev(cur->operand->object.sha1, DEFAULT_ABBREV);
+		subject_len = find_commit_subject(cur->operand->buffer, &subject);
 		strbuf_addf(buf, "%s %s %.*s\n", action_str, sha1_abbrev,
 			subject_len, subject);
 	}
 	return 0;
 }
 
-static struct commit *parse_insn_line(char *bol, char *eol, struct replay_opts *opts)
+static int parse_insn_line(char *bol, char *eol, struct replay_insn_list *item)
 {
 	unsigned char commit_sha1[20];
-	enum replay_action action;
 	char *end_of_object_name;
 	int saved, status;
 
 	if (!prefixcmp(bol, "pick ")) {
-		action = CHERRY_PICK;
+		item->action = REPLAY_PICK;
 		bol += strlen("pick ");
 	} else if (!prefixcmp(bol, "revert ")) {
-		action = REVERT;
+		item->action = REPLAY_REVERT;
 		bol += strlen("revert ");
 	} else
-		return NULL;
+		return -1;
 
 	/* Eat up extra spaces/ tabs before object name */
 	while (*bol == ' ' || *bol == '\t')
@@ -737,37 +744,29 @@ static struct commit *parse_insn_line(char *bol, char *eol, struct replay_opts *
 	status = get_sha1(bol, commit_sha1);
 	*end_of_object_name = saved;
 
-	/*
-	 * Verify that the action matches up with the one in
-	 * opts; we don't support arbitrary instructions
-	 */
-	if (action != opts->action) {
-		const char *action_str;
-		action_str = action == REVERT ? "revert" : "cherry-pick";
-		error(_("Cannot %s during a %s"), action_str, action_name(opts));
-		return NULL;
-	}
-
 	if (status < 0)
-		return NULL;
+		return -1;
+
+	item->operand = lookup_commit_reference(commit_sha1);
+	if (!item->operand)
+		return -1;
 
-	return lookup_commit_reference(commit_sha1);
+	item->next = NULL;
+	return 0;
 }
 
-static int parse_insn_buffer(char *buf, struct commit_list **todo_list,
-			struct replay_opts *opts)
+static int parse_insn_buffer(char *buf, struct replay_insn_list **todo_list)
 {
-	struct commit_list **next = todo_list;
-	struct commit *commit;
+	struct replay_insn_list **next = todo_list;
+	struct replay_insn_list item = { 0, NULL, NULL };
 	char *p = buf;
 	int i;
 
 	for (i = 1; *p; i++) {
 		char *eol = strchrnul(p, '\n');
-		commit = parse_insn_line(p, eol, opts);
-		if (!commit)
+		if (parse_insn_line(p, eol, &item) < 0)
 			return error(_("Could not parse line %d."), i);
-		next = commit_list_append(commit, next);
+		next = replay_insn_list_append(item.action, item.operand, next);
 		p = *eol ? eol + 1 : eol;
 	}
 	if (!*todo_list)
@@ -775,8 +774,7 @@ static int parse_insn_buffer(char *buf, struct commit_list **todo_list,
 	return 0;
 }
 
-static void read_populate_todo(struct commit_list **todo_list,
-			struct replay_opts *opts)
+static void read_populate_todo(struct replay_insn_list **todo_list)
 {
 	const char *todo_file = git_path(SEQ_TODO_FILE);
 	struct strbuf buf = STRBUF_INIT;
@@ -792,7 +790,7 @@ static void read_populate_todo(struct commit_list **todo_list,
 	}
 	close(fd);
 
-	res = parse_insn_buffer(buf.buf, todo_list, opts);
+	res = parse_insn_buffer(buf.buf, todo_list);
 	strbuf_release(&buf);
 	if (res)
 		die(_("Unusable instruction sheet: %s"), todo_file);
@@ -841,18 +839,18 @@ static void read_populate_opts(struct replay_opts **opts_ptr)
 		die(_("Malformed options sheet: %s"), opts_file);
 }
 
-static void walk_revs_populate_todo(struct commit_list **todo_list,
+static void walk_revs_populate_todo(struct replay_insn_list **todo_list,
 				struct replay_opts *opts)
 {
 	struct rev_info revs;
 	struct commit *commit;
-	struct commit_list **next;
+	struct replay_insn_list **next;
 
 	prepare_revs(&revs, opts);
 
 	next = todo_list;
 	while ((commit = get_revision(&revs)))
-		next = commit_list_append(commit, next);
+		next = replay_insn_list_append(opts->action, commit, next);
 }
 
 static int create_seq_dir(void)
@@ -950,7 +948,7 @@ fail:
 	return -1;
 }
 
-static void save_todo(struct commit_list *todo_list, struct replay_opts *opts)
+static void save_todo(struct replay_insn_list *todo_list)
 {
 	const char *todo_file = git_path(SEQ_TODO_FILE);
 	static struct lock_file todo_lock;
@@ -958,7 +956,7 @@ static void save_todo(struct commit_list *todo_list, struct replay_opts *opts)
 	int fd;
 
 	fd = hold_lock_file_for_update(&todo_lock, todo_file, LOCK_DIE_ON_ERROR);
-	if (format_todo(&buf, todo_list, opts) < 0)
+	if (format_todo(&buf, todo_list) < 0)
 		die(_("Could not format %s."), todo_file);
 	if (write_in_full(fd, buf.buf, buf.len) < 0) {
 		strbuf_release(&buf);
@@ -1002,9 +1000,10 @@ static void save_opts(struct replay_opts *opts)
 	}
 }
 
-static int pick_commits(struct commit_list *todo_list, struct replay_opts *opts)
+static int pick_commits(struct replay_insn_list *todo_list,
+			struct replay_opts *opts)
 {
-	struct commit_list *cur;
+	struct replay_insn_list *cur;
 	int res;
 
 	setenv(GIT_REFLOG_ACTION, action_name(opts), 0);
@@ -1014,8 +1013,8 @@ static int pick_commits(struct commit_list *todo_list, struct replay_opts *opts)
 	read_and_refresh_cache(opts);
 
 	for (cur = todo_list; cur; cur = cur->next) {
-		save_todo(cur, opts);
-		res = do_pick_commit(cur->item, opts);
+		save_todo(cur);
+		res = do_pick_commit(cur->operand, cur->action, opts);
 		if (res) {
 			if (!cur->next)
 				/*
@@ -1040,7 +1039,7 @@ static int pick_commits(struct commit_list *todo_list, struct replay_opts *opts)
 
 static int pick_revisions(struct replay_opts *opts)
 {
-	struct commit_list *todo_list = NULL;
+	struct replay_insn_list *todo_list = NULL;
 	unsigned char sha1[20];
 
 	read_and_refresh_cache(opts);
@@ -1060,7 +1059,7 @@ static int pick_revisions(struct replay_opts *opts)
 		if (!file_exists(git_path(SEQ_TODO_FILE)))
 			return error(_("No %s in progress"), action_name(opts));
 		read_populate_opts(&opts);
-		read_populate_todo(&todo_list, opts);
+		read_populate_todo(&todo_list);
 
 		/* Verify that the conflict has been resolved */
 		if (!index_differs_from("HEAD", 0))
@@ -1078,7 +1077,7 @@ static int pick_revisions(struct replay_opts *opts)
 	if (create_seq_dir() < 0)
 		return -1;
 	if (get_sha1("HEAD", sha1)) {
-		if (opts->action == REVERT)
+		if (opts->action == REPLAY_REVERT)
 			return error(_("Can't revert as initial commit"));
 		return error(_("Can't cherry-pick into empty head"));
 	}
@@ -1095,7 +1094,7 @@ int cmd_revert(int argc, const char **argv, const char *prefix)
 	memset(&opts, 0, sizeof(opts));
 	if (isatty(0))
 		opts.edit = 1;
-	opts.action = REVERT;
+	opts.action = REPLAY_REVERT;
 	git_config(git_default_config, NULL);
 	parse_args(argc, argv, &opts);
 	res = pick_revisions(&opts);
@@ -1110,7 +1109,7 @@ int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
 	int res;
 
 	memset(&opts, 0, sizeof(opts));
-	opts.action = CHERRY_PICK;
+	opts.action = REPLAY_PICK;
 	git_config(git_default_config, NULL);
 	parse_args(argc, argv, &opts);
 	res = pick_revisions(&opts);
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index 70fd54b..aee869d 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -356,4 +356,62 @@ test_expect_success 'commit descriptions in insn sheet are optional' '
 	test_line_count = 4 commits
 '
 
+test_expect_success 'revert --continue continues after cherry-pick' '
+	pristine_detach initial &&
+	test_expect_code 1 git cherry-pick base..anotherpick &&
+	echo "c" >foo &&
+	git add foo &&
+	git commit &&
+	git revert --continue &&
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
+test_expect_success 'mixed pick and revert instructions' '
+	pristine_detach initial &&
+	test_expect_code 1 git cherry-pick base..anotherpick &&
+	echo "c" >foo &&
+	git add foo &&
+	git commit &&
+	oldsha=`git rev-parse --short HEAD~1` &&
+	echo "revert $oldsha unrelatedpick" >>.git/sequencer/todo &&
+	git cherry-pick --continue &&
+	test_path_is_missing .git/sequencer &&
+	{
+		git rev-list HEAD |
+		git diff-tree --root --stdin |
+		sed "s/$_x40/OBJID/g"
+	} >actual &&
+	cat >expect <<-\EOF &&
+	OBJID
+	:100644 100644 OBJID OBJID M	unrelated
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
 test_done
-- 
1.7.7.3
