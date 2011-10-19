From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 5/6] revert: allow mixed pick and revert instructions
Date: Thu, 20 Oct 2011 02:33:27 +0530
Message-ID: <1319058208-17923-6-git-send-email-artagnon@gmail.com>
References: <1319058208-17923-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 19 23:06:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGdLE-0000Pc-77
	for gcvg-git-2@lo.gmane.org; Wed, 19 Oct 2011 23:06:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754153Ab1JSVGP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Oct 2011 17:06:15 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:51021 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753559Ab1JSVGN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2011 17:06:13 -0400
Received: by yxp4 with SMTP id 4so2117614yxp.19
        for <git@vger.kernel.org>; Wed, 19 Oct 2011 14:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=6QuNh4h67mYbTq/66xrO6F+o6C9sSShyaPdCR8MfdZ4=;
        b=Mtm09VI/8jajVUL9oCCR0PJONiPIWpku4JMDLU8bSYUziCtVldlmSx84MHVd29VUAk
         Iikj0q0UxgH/SFqQzoigNilKSLiwJ0SBEAWE9jj2yMszRw9j2ivD8XSUp+iJIO6dXK+5
         4LfRfu2Scg2YU2nz1Ma3GfbpsehjungEC4vr8=
Received: by 10.68.36.6 with SMTP id m6mr14732519pbj.111.1319058372538;
        Wed, 19 Oct 2011 14:06:12 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id jm5sm11111752pbc.1.2011.10.19.14.06.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 19 Oct 2011 14:06:11 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.351.gb35ac.dirty
In-Reply-To: <1319058208-17923-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183967>

Parse the instruction sheet in '.git/sequencer/todo' as a list of
(action, operand) pairs, instead of assuming that all instructions use
the same action.  Now you can do:

  pick fdc0b12 picked
  revert 965fed4 anotherpick

For cherry-pick and revert, this means that a 'git cherry-pick
--continue' can continue an ongoing revert operation and viceversa.
This patch lays the foundation for extending the parser to support
more actions so 'git rebase -i' can reuse this machinery in the
future.  While at it, also improve the error messages reported by the
insn sheet parser.

Helped-by: Jonathan Nieder <jrnider@gmail.com>
Acked-by: Jonathan Nieder <jrnider@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/revert.c                |  130 +++++++++++++++++++--------------------
 sequencer.h                     |    8 +++
 t/t3510-cherry-pick-sequence.sh |   58 +++++++++++++++++
 3 files changed, 129 insertions(+), 67 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 8e34dc0..0201e98 100644
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
@@ -152,7 +151,7 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 		OPT_END(),
 	};
 
-	if (opts->action == CHERRY_PICK) {
+	if (opts->action == REPLAY_PICK) {
 		struct option cp_extra[] = {
 			OPT_BOOLEAN('x', NULL, &opts->record_origin, "append commit name"),
 			OPT_BOOLEAN(0, "ff", &opts->allow_ff, "allow fast-forward"),
@@ -346,7 +345,7 @@ static int error_dirty_index(struct replay_opts *opts)
 		return error_resolve_conflict(action_name(opts));
 
 	/* Different translation strings for cherry-pick and revert */
-	if (opts->action == CHERRY_PICK)
+	if (opts->action == REPLAY_PICK)
 		error(_("Your local changes would be overwritten by cherry-pick."));
 	else
 		error(_("Your local changes would be overwritten by revert."));
@@ -450,7 +449,8 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts)
 	return run_command_v_opt(args, RUN_GIT_CMD);
 }
 
-static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
+static int do_pick_commit(struct commit *commit, enum replay_action action,
+			struct replay_opts *opts)
 {
 	unsigned char head[20];
 	struct commit *base, *next, *parent;
@@ -525,7 +525,7 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 
 	defmsg = git_pathdup("MERGE_MSG");
 
-	if (opts->action == REVERT) {
+	if (action == REPLAY_REVERT) {
 		base = commit;
 		base_label = msg.label;
 		next = parent;
@@ -568,7 +568,7 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 			write_cherry_pick_head(commit);
 	}
 
-	if (!opts->strategy || !strcmp(opts->strategy, "recursive") || opts->action == REVERT) {
+	if (!opts->strategy || !strcmp(opts->strategy, "recursive") || action == REPLAY_REVERT) {
 		res = do_recursive_merge(base, next, base_label, next_label,
 					 head, &msgbuf, opts);
 		write_message(&msgbuf, defmsg);
@@ -587,7 +587,7 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 	}
 
 	if (res) {
-		error(opts->action == REVERT
+		error(action == REPLAY_REVERT
 		      ? _("could not revert %s... %s")
 		      : _("could not apply %s... %s"),
 		      find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV),
@@ -611,7 +611,7 @@ static void prepare_revs(struct rev_info *revs, struct replay_opts *opts)
 
 	init_revisions(revs, NULL);
 	revs->no_walk = 1;
-	if (opts->action != REVERT)
+	if (opts->action != REPLAY_REVERT)
 		revs->reverse = 1;
 
 	argc = setup_revisions(opts->commit_argc, opts->commit_argv, revs, NULL);
@@ -657,49 +657,53 @@ static void read_and_refresh_cache(struct replay_opts *opts)
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
-	} else
-		return NULL;
+	} else {
+		size_t len = strchrnul(bol, '\n') - bol;
+		if (len > 255)
+			len = 255;
+		return error(_("Unrecognized action: %.*s"), (int)len, bol);
+	}
 
 	end_of_object_name = bol + strcspn(bol, " \n");
 	saved = *end_of_object_name;
@@ -707,37 +711,29 @@ static struct commit *parse_insn_line(char *bol, char *eol, struct replay_opts *
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
+		return error(_("Malformed object name: %s"), bol);
 
-	return lookup_commit_reference(commit_sha1);
+	item->operand = lookup_commit_reference(commit_sha1);
+	if (!item->operand)
+		return error(_("Not a valid commit: %s"), bol);
+
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
 		char *eol = strchrnul(p, '\n');
-		commit = parse_insn_line(p, eol, opts);
-		if (!commit)
-			return error(_("Could not parse line %d."), i);
-		next = commit_list_append(commit, next);
+		if (parse_insn_line(p, eol, &item) < 0)
+			return error(_("on line %d."), i);
+		next = replay_insn_list_append(item.action, item.operand, next);
 		p = *eol ? eol + 1 : eol;
 	}
 	if (!*todo_list)
@@ -745,8 +741,7 @@ static int parse_insn_buffer(char *buf, struct commit_list **todo_list,
 	return 0;
 }
 
-static void read_populate_todo(struct commit_list **todo_list,
-			struct replay_opts *opts)
+static void read_populate_todo(struct replay_insn_list **todo_list)
 {
 	const char *todo_file = git_path(SEQ_TODO_FILE);
 	struct strbuf buf = STRBUF_INIT;
@@ -762,7 +757,7 @@ static void read_populate_todo(struct commit_list **todo_list,
 	}
 	close(fd);
 
-	res = parse_insn_buffer(buf.buf, todo_list, opts);
+	res = parse_insn_buffer(buf.buf, todo_list);
 	strbuf_release(&buf);
 	if (res)
 		die(_("Unusable instruction sheet: %s"), todo_file);
@@ -811,18 +806,18 @@ static void read_populate_opts(struct replay_opts **opts_ptr)
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
@@ -851,7 +846,7 @@ static void save_head(const char *head)
 		die(_("Error wrapping up %s."), head_file);
 }
 
-static void save_todo(struct commit_list *todo_list, struct replay_opts *opts)
+static void save_todo(struct replay_insn_list *todo_list)
 {
 	const char *todo_file = git_path(SEQ_TODO_FILE);
 	static struct lock_file todo_lock;
@@ -859,7 +854,7 @@ static void save_todo(struct commit_list *todo_list, struct replay_opts *opts)
 	int fd;
 
 	fd = hold_lock_file_for_update(&todo_lock, todo_file, LOCK_DIE_ON_ERROR);
-	if (format_todo(&buf, todo_list, opts) < 0)
+	if (format_todo(&buf, todo_list) < 0)
 		die(_("Could not format %s."), todo_file);
 	if (write_in_full(fd, buf.buf, buf.len) < 0) {
 		strbuf_release(&buf);
@@ -903,9 +898,10 @@ static void save_opts(struct replay_opts *opts)
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
@@ -915,8 +911,8 @@ static int pick_commits(struct commit_list *todo_list, struct replay_opts *opts)
 	read_and_refresh_cache(opts);
 
 	for (cur = todo_list; cur; cur = cur->next) {
-		save_todo(cur, opts);
-		res = do_pick_commit(cur->item, opts);
+		save_todo(cur);
+		res = do_pick_commit(cur->operand, cur->action, opts);
 		if (res) {
 			if (!cur->next)
 				/*
@@ -941,7 +937,7 @@ static int pick_commits(struct commit_list *todo_list, struct replay_opts *opts)
 
 static int pick_revisions(struct replay_opts *opts)
 {
-	struct commit_list *todo_list = NULL;
+	struct replay_insn_list *todo_list = NULL;
 	unsigned char sha1[20];
 
 	read_and_refresh_cache(opts);
@@ -958,7 +954,7 @@ static int pick_revisions(struct replay_opts *opts)
 		if (!file_exists(git_path(SEQ_TODO_FILE)))
 			goto error;
 		read_populate_opts(&opts);
-		read_populate_todo(&todo_list, opts);
+		read_populate_todo(&todo_list);
 
 		/* Verify that the conflict has been resolved */
 		if (!index_differs_from("HEAD", 0))
@@ -978,7 +974,7 @@ static int pick_revisions(struct replay_opts *opts)
 			return -1;
 		}
 		if (get_sha1("HEAD", sha1)) {
-			if (opts->action == REVERT)
+			if (opts->action == REPLAY_REVERT)
 				return error(_("Can't revert as initial commit"));
 			return error(_("Can't cherry-pick into empty head"));
 		}
@@ -998,7 +994,7 @@ int cmd_revert(int argc, const char **argv, const char *prefix)
 	memset(&opts, 0, sizeof(opts));
 	if (isatty(0))
 		opts.edit = 1;
-	opts.action = REVERT;
+	opts.action = REPLAY_REVERT;
 	git_config(git_default_config, NULL);
 	parse_args(argc, argv, &opts);
 	res = pick_revisions(&opts);
@@ -1013,7 +1009,7 @@ int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
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
index 39b55c1..4b12244 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -239,4 +239,62 @@ test_expect_success 'commit descriptions in insn sheet are optional' '
 	test_line_count = 4 commits
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
