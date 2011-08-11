From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 4/6] revert: Allow mixed pick and revert instructions
Date: Fri, 12 Aug 2011 00:21:43 +0530
Message-ID: <1313088705-32222-5-git-send-email-artagnon@gmail.com>
References: <1313088705-32222-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 11 20:55:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QraPQ-0003Eq-Pm
	for gcvg-git-2@lo.gmane.org; Thu, 11 Aug 2011 20:55:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753173Ab1HKSzD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Aug 2011 14:55:03 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:63951 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752938Ab1HKSzA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2011 14:55:00 -0400
Received: by mail-pz0-f42.google.com with SMTP id 37so4115440pzk.1
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 11:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=IcfwkmcfwdCQAo8j4gaLxtlHpXIqKefk0dGZZLjiX/s=;
        b=NV1KNuoycwCuKPsWNPbXj6wQCbX3zldVS/GdDkrnX0nw4O0qrGl+KQWJrjES3p38ya
         e0MyYnOnGF3m/MsPgH8DWrRoB53M3TNmFAb1kDtVwIUIuowbnB0e/iVnyclXaZoHBa1M
         emJnjiXes6swbAxlx8idZ/NqFtWKCwyXNLNG0=
Received: by 10.142.156.20 with SMTP id d20mr7658093wfe.119.1313088900378;
        Thu, 11 Aug 2011 11:55:00 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id t7sm1117355wfl.2.2011.08.11.11.54.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 11 Aug 2011 11:54:59 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.351.gb35ac.dirty
In-Reply-To: <1313088705-32222-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179132>

Change the way the instruction parser works, allowing arbitrary
(action, operand) pairs to be parsed.  So now, you can do:

  pick fdc0b12 picked
  revert 965fed4 anotherpick

For cherry-pick and revert, this means that a 'git cherry-pick
--continue' can continue an ongoing revert operation and viceversa.
This patch lays the foundation for extending the parser to support
more actions so 'git rebase -i' can reuse this machinery in the
future.

Helped-by: Jonathan Nieder <jrnider@gmail.com>
Acked-by: Jonathan Nieder <jrnider@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/revert.c                |  128 ++++++++++++++++++--------------------
 sequencer.h                     |    8 +++
 t/t3510-cherry-pick-sequence.sh |   58 ++++++++++++++++++
 3 files changed, 127 insertions(+), 67 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index f44f749..483c957 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -39,7 +39,6 @@ static const char * const cherry_pick_usage[] = {
 	NULL
 };
 
-enum replay_action { REVERT, CHERRY_PICK };
 enum replay_subcommand { REPLAY_NONE, REPLAY_RESET, REPLAY_CONTINUE };
 
 struct replay_opts {
@@ -68,14 +67,14 @@ struct replay_opts {
 
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
@@ -154,7 +153,7 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 		OPT_END(),
 	};
 
-	if (opts->action == CHERRY_PICK) {
+	if (opts->action == REPLAY_PICK) {
 		struct option cp_extra[] = {
 			OPT_BOOLEAN('x', NULL, &opts->record_origin, "append commit name"),
 			OPT_BOOLEAN(0, "ff", &opts->allow_ff, "allow fast-forward"),
@@ -353,7 +352,7 @@ static int error_dirty_index(struct replay_opts *opts)
 		return error_resolve_conflict(action_name(opts));
 
 	/* Different translation strings for cherry-pick and revert */
-	if (opts->action == CHERRY_PICK)
+	if (opts->action == REPLAY_PICK)
 		error(_("Your local changes would be overwritten by cherry-pick."));
 	else
 		error(_("Your local changes would be overwritten by revert."));
@@ -457,7 +456,8 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts)
 	return run_command_v_opt(args, RUN_GIT_CMD);
 }
 
-static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
+static int do_pick_commit(struct commit *commit, enum replay_action action,
+			struct replay_opts *opts)
 {
 	unsigned char head[20];
 	struct commit *base, *next, *parent;
@@ -517,7 +517,8 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 		/* TRANSLATORS: The first %s will be "revert" or
 		   "cherry-pick", the second %s a SHA1 */
 		return error(_("%s: cannot parse parent commit %s"),
-			action_name(opts), sha1_to_hex(parent->object.sha1));
+			action == REPLAY_REVERT ? "revert" : "cherry-pick",
+			sha1_to_hex(parent->object.sha1));
 
 	if (get_message(commit, &msg) != 0)
 		return error(_("Cannot get commit message for %s"),
@@ -532,7 +533,7 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 
 	defmsg = git_pathdup("MERGE_MSG");
 
-	if (opts->action == REVERT) {
+	if (action == REPLAY_REVERT) {
 		base = commit;
 		base_label = msg.label;
 		next = parent;
@@ -575,7 +576,7 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 			write_cherry_pick_head(commit);
 	}
 
-	if (!opts->strategy || !strcmp(opts->strategy, "recursive") || opts->action == REVERT) {
+	if (!opts->strategy || !strcmp(opts->strategy, "recursive") || action == REPLAY_REVERT) {
 		res = do_recursive_merge(base, next, base_label, next_label,
 					 head, &msgbuf, opts);
 		write_message(&msgbuf, defmsg);
@@ -594,7 +595,7 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 	}
 
 	if (res) {
-		error(opts->action == REVERT
+		error(action == REPLAY_REVERT
 		      ? _("could not revert %s... %s")
 		      : _("could not apply %s... %s"),
 		      find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV),
@@ -618,7 +619,7 @@ static void prepare_revs(struct rev_info *revs, struct replay_opts *opts)
 
 	init_revisions(revs, NULL);
 	revs->no_walk = 1;
-	if (opts->action != REVERT)
+	if (opts->action != REPLAY_REVERT)
 		revs->reverse = 1;
 
 	argc = setup_revisions(opts->commit_argc, opts->commit_argv, revs, NULL);
@@ -664,88 +665,81 @@ static void read_and_refresh_cache(struct replay_opts *opts)
  *     assert(commit_list_count(list) == 2);
  *     return list;
  */
-struct commit_list **commit_list_append(struct commit *commit,
-					struct commit_list **next)
+struct replay_insn_list **replay_insn_list_append(enum replay_action action,
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
-	struct commit_message msg = { NULL, NULL, NULL, NULL, NULL };
-	const char *sha1_abbrev = NULL;
-	const char *action_str = opts->action == REVERT ? "revert" : "pick";
+	struct replay_insn_list *cur;
 
 	for (cur = todo_list; cur; cur = cur->next) {
-		sha1_abbrev = find_unique_abbrev(cur->item->object.sha1, DEFAULT_ABBREV);
-		if (get_message(cur->item, &msg))
+		const char *sha1_abbrev, *action_str;
+		struct commit_message msg = { NULL, NULL, NULL, NULL, NULL };
+
+		action_str = cur->action == REPLAY_REVERT ? "revert" : "pick";
+		sha1_abbrev = find_unique_abbrev(cur->operand->object.sha1, DEFAULT_ABBREV);
+		if (get_message(cur->operand, &msg))
 			return error(_("Cannot get commit message for %s"), sha1_abbrev);
 		strbuf_addf(buf, "%s %s %s\n", action_str, sha1_abbrev, msg.subject);
+		free_message(&msg);
 	}
-	free_message(&msg);
 	return 0;
 }
 
-static struct commit *parse_insn_line(char *start, struct replay_opts *opts)
+static int parse_insn_line(char *start, struct replay_insn_list *item)
 {
 	unsigned char commit_sha1[20];
 	char sha1_abbrev[40];
-	enum replay_action action;
 	char *p = start, *q, *end = strchrnul(start, '\n');
 
 	if (!prefixcmp(start, "pick ")) {
-		action = CHERRY_PICK;
+		item->action = REPLAY_PICK;
 		p += strlen("pick ");
 	} else if (!prefixcmp(start, "revert ")) {
-		action = REVERT;
+		item->action = REPLAY_REVERT;
 		p += strlen("revert ");
 	} else
-		return NULL;
+		return error(_("Unrecognized action: %s"), start);
 
 	q = strchrnul(p, ' ');
 	if (q > end)
 		q = end;
 	if (q - p + 1 > sizeof(sha1_abbrev))
-		return NULL;
+		return error(_("Object name too large: %s"), p);
 	memcpy(sha1_abbrev, p, q - p);
 	sha1_abbrev[q - p] = '\0';
 
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
 	if (get_sha1(sha1_abbrev, commit_sha1) < 0)
-		return NULL;
+		return error(_("Malformed object name: %s"), sha1_abbrev);
+
+	item->operand = lookup_commit_reference(commit_sha1);
+	if (!item->operand)
+		return error(_("Not a valid commit: %s"), sha1_abbrev);
 
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
+	struct replay_insn_list item = {0, NULL, NULL};
 	char *p = buf;
 	int i;
 
 	for (i = 1; *p; i++) {
-		commit = parse_insn_line(p, opts);
-		if (!commit)
+		if (parse_insn_line(p, &item) < 0)
 			return error(_("Could not parse line %d."), i);
-		next = commit_list_append(commit, next);
+		next = replay_insn_list_append(item.action, item.operand, next);
 		p = strchrnul(p, '\n');
 		if (*p)
 			p++;
@@ -755,8 +749,7 @@ static int parse_insn_buffer(char *buf, struct commit_list **todo_list,
 	return 0;
 }
 
-static void read_populate_todo(struct commit_list **todo_list,
-			struct replay_opts *opts)
+static void read_populate_todo(struct replay_insn_list **todo_list)
 {
 	const char *todo_file = git_path(SEQ_TODO_FILE);
 	struct strbuf buf = STRBUF_INIT;
@@ -772,7 +765,7 @@ static void read_populate_todo(struct commit_list **todo_list,
 	}
 	close(fd);
 
-	res = parse_insn_buffer(buf.buf, todo_list, opts);
+	res = parse_insn_buffer(buf.buf, todo_list);
 	strbuf_release(&buf);
 	if (res)
 		die(_("Unusable instruction sheet: %s"), todo_file);
@@ -821,18 +814,18 @@ static void read_populate_opts(struct replay_opts **opts_ptr)
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
@@ -861,7 +854,7 @@ static void save_head(const char *head)
 		die(_("Error wrapping up %s."), head_file);
 }
 
-static void save_todo(struct commit_list *todo_list, struct replay_opts *opts)
+static void save_todo(struct replay_insn_list *todo_list)
 {
 	const char *todo_file = git_path(SEQ_TODO_FILE);
 	static struct lock_file todo_lock;
@@ -869,7 +862,7 @@ static void save_todo(struct commit_list *todo_list, struct replay_opts *opts)
 	int fd;
 
 	fd = hold_lock_file_for_update(&todo_lock, todo_file, LOCK_DIE_ON_ERROR);
-	if (format_todo(&buf, todo_list, opts) < 0)
+	if (format_todo(&buf, todo_list) < 0)
 		die(_("Could not format %s."), todo_file);
 	if (write_in_full(fd, buf.buf, buf.len) < 0) {
 		strbuf_release(&buf);
@@ -913,9 +906,10 @@ static void save_opts(struct replay_opts *opts)
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
@@ -925,8 +919,8 @@ static int pick_commits(struct commit_list *todo_list, struct replay_opts *opts)
 	read_and_refresh_cache(opts);
 
 	for (cur = todo_list; cur; cur = cur->next) {
-		save_todo(cur, opts);
-		res = do_pick_commit(cur->item, opts);
+		save_todo(cur);
+		res = do_pick_commit(cur->operand, cur->action, opts);
 		if (res) {
 			if (!cur->next && res > 0)
 				/*
@@ -951,7 +945,7 @@ static int pick_commits(struct commit_list *todo_list, struct replay_opts *opts)
 
 static int pick_revisions(struct replay_opts *opts)
 {
-	struct commit_list *todo_list = NULL;
+	struct replay_insn_list *todo_list = NULL;
 	unsigned char sha1[20];
 
 	read_and_refresh_cache(opts);
@@ -968,7 +962,7 @@ static int pick_revisions(struct replay_opts *opts)
 		if (!file_exists(git_path(SEQ_TODO_FILE)))
 			goto error;
 		read_populate_opts(&opts);
-		read_populate_todo(&todo_list, opts);
+		read_populate_todo(&todo_list);
 
 		/* Verify that the conflict has been resolved */
 		if (!index_differs_from("HEAD", 0))
@@ -988,7 +982,7 @@ static int pick_revisions(struct replay_opts *opts)
 			return -1;
 		}
 		if (get_sha1("HEAD", sha1)) {
-			if (opts->action == REVERT)
+			if (opts->action == REPLAY_REVERT)
 				return error(_("Can't revert as initial commit"));
 			return error(_("Can't cherry-pick into empty head"));
 		}
@@ -1008,7 +1002,7 @@ int cmd_revert(int argc, const char **argv, const char *prefix)
 	memset(&opts, 0, sizeof(opts));
 	if (isatty(0))
 		opts.edit = 1;
-	opts.action = REVERT;
+	opts.action = REPLAY_REVERT;
 	git_config(git_default_config, NULL);
 	parse_args(argc, argv, &opts);
 	res = pick_revisions(&opts);
@@ -1023,7 +1017,7 @@ int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
 	int res;
 
 	memset(&opts, 0, sizeof(opts));
-	opts.action = CHERRY_PICK;
+	opts.action = REPLAY_PICK;
 	git_config(git_default_config, NULL);
 	parse_args(argc, argv, &opts);
 	res = pick_revisions(&opts);
diff --git a/sequencer.h b/sequencer.h
index 905d295..f4db257 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -7,6 +7,14 @@
 #define SEQ_TODO_FILE	"sequencer/todo"
 #define SEQ_OPTS_FILE	"sequencer/opts"
 
+enum replay_action { REPLAY_REVERT, REPLAY_PICK };
+
+struct replay_insn_list {
+	enum replay_action action;
+	struct commit *operand;
+	struct replay_insn_list *next;
+};
+
 /*
  * Removes SEQ_OLD_DIR and renames SEQ_DIR to SEQ_OLD_DIR, ignoring
  * any errors.  Intended to be used by 'git reset'.
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index bc5f0b8..bc7fb13 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -240,4 +240,62 @@ test_expect_success 'missing commit descriptions in instruction sheet' '
 	test_cmp expect actual
 '
 
+test_expect_success 'revert --continue continues after cherry-pick' '
+	pristine_detach initial &&
+	test_must_fail git cherry-pick base..anotherpick &&
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
+	test_must_fail git cherry-pick base..anotherpick &&
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
1.7.6.351.gb35ac.dirty
