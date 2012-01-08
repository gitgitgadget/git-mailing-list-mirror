From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 4/6] revert: allow mixing "pick" and "revert" actions
Date: Sun,  8 Jan 2012 17:57:31 +0530
Message-ID: <1326025653-11922-5-git-send-email-artagnon@gmail.com>
References: <1326025653-11922-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 08 13:29:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rjrsg-0008M1-H4
	for gcvg-git-2@lo.gmane.org; Sun, 08 Jan 2012 13:29:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753477Ab2AHM31 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jan 2012 07:29:27 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:64499 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753435Ab2AHM3Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jan 2012 07:29:25 -0500
Received: by mail-iy0-f174.google.com with SMTP id h11so5271273iae.19
        for <git@vger.kernel.org>; Sun, 08 Jan 2012 04:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=GZnkuTeyIO8QLUZiYNzOMCmZGMEWpVPFTdpRw2JVqws=;
        b=wI5pQapGbq5QWLZZgLvJ+KAGxfikuHbuPbtBoVfeonPPvwf4LXEtqUEXKyyiMC0Kji
         7AUzf8NiBCshVLjRek9zWJBKeyGgkjH5XLW1gwVz47lKZ5qIylYNdCOGaXlM/gcT+rG1
         qC/Mfb0UXwYOMhMj9txfS/swiNzo9E/wO0Nyo=
Received: by 10.43.131.196 with SMTP id hr4mr11752096icc.55.1326025764761;
        Sun, 08 Jan 2012 04:29:24 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.205])
        by mx.google.com with ESMTPS id r5sm106707878igl.3.2012.01.08.04.29.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 08 Jan 2012 04:29:23 -0800 (PST)
X-Mailer: git-send-email 1.7.8.2
In-Reply-To: <1326025653-11922-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188109>

Parse the instruction sheet in '.git/sequencer/todo' as a list of
(action, operand) pairs, instead of assuming that all lines have the
same action.  Now, an instruction sheet like the following is
perfectly valid:

  pick fdc0b12 picked
  revert 965fed4 anotherpick

The operator can use this feature by hand-editing the instruction
sheet and using '--continue' as appropriate:

  $ git cherry-pick foo..bar
  [conflict occurs]
  $ edit problematicfile
  $ git add problematicfile
  $ edit .git/sequencer/todo
  $ git cherry-pick --continue
  [finishes successfully]

Helped-by: Jonathan Nieder <jrnider@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/revert.c                |  135 +++++++++++++++++++--------------------
 sequencer.h                     |    6 ++
 t/t3510-cherry-pick-sequence.sh |   46 ++++++++++----
 3 files changed, 105 insertions(+), 82 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 52fa115..54ea394 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -475,7 +475,8 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts)
 	return run_command_v_opt(args, RUN_GIT_CMD);
 }
 
-static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
+static int do_pick_commit(struct commit *commit, enum replay_action action,
+			struct replay_opts *opts)
 {
 	unsigned char head[20];
 	struct commit *base, *next, *parent;
@@ -550,7 +551,7 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 
 	defmsg = git_pathdup("MERGE_MSG");
 
-	if (opts->command == REPLAY_CMD_REVERT) {
+	if (action == REPLAY_REVERT) {
 		base = commit;
 		base_label = msg.label;
 		next = parent;
@@ -591,7 +592,7 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 		}
 	}
 
-	if (!opts->strategy || !strcmp(opts->strategy, "recursive") || opts->command == REPLAY_CMD_REVERT) {
+	if (!opts->strategy || !strcmp(opts->strategy, "recursive") || action == REPLAY_REVERT) {
 		res = do_recursive_merge(base, next, base_label, next_label,
 					 head, &msgbuf, opts);
 		write_message(&msgbuf, defmsg);
@@ -615,13 +616,13 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 	 * However, if the merge did not even start, then we don't want to
 	 * write it at all.
 	 */
-	if (opts->command == REPLAY_CMD_CHERRY_PICK && !opts->no_commit && (res == 0 || res == 1))
+	if (action == REPLAY_PICK && !opts->no_commit && (res == 0 || res == 1))
 		write_cherry_pick_head(commit, "CHERRY_PICK_HEAD");
-	if (opts->command == REPLAY_CMD_REVERT && ((opts->no_commit && res == 0) || res == 1))
+	if (action == REPLAY_REVERT && ((opts->no_commit && res == 0) || res == 1))
 		write_cherry_pick_head(commit, "REVERT_HEAD");
 
 	if (res) {
-		error(opts->command == REPLAY_CMD_REVERT
+		error(action == REPLAY_REVERT
 		      ? _("could not revert %s... %s")
 		      : _("could not apply %s... %s"),
 		      find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV),
@@ -668,70 +669,70 @@ static void read_and_refresh_cache(struct replay_opts *opts)
 }
 
 /*
- * Append a commit to the end of the commit_list.
+ * Append a (commit, action) to the end of the replay_insn_list.
  *
  * next starts by pointing to the variable that holds the head of an
- * empty commit_list, and is updated to point to the "next" field of
- * the last item on the list as new commits are appended.
+ * empty replay_insn_list, and is updated to point to the "next" field of
+ * the last item on the list as new (commit, action) pairs are appended.
  *
  * Usage example:
  *
- *     struct commit_list *list;
- *     struct commit_list **next = &list;
+ *     struct replay_insn_list *list;
+ *     struct replay_insn_list **next = &list;
  *
- *     next = commit_list_append(c1, next);
- *     next = commit_list_append(c2, next);
- *     assert(commit_list_count(list) == 2);
+ *     next = replay_insn_list_append(c1, a1, next);
+ *     next = replay_insn_list_append(c2, a2, next);
+ *     assert(len(list) == 2);
  *     return list;
  */
-static struct commit_list **commit_list_append(struct commit *commit,
-					       struct commit_list **next)
+static struct replay_insn_list **replay_insn_list_append(struct commit *operand,
+							enum replay_action action,
+							struct replay_insn_list **next)
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
-	const char *action_str = opts->command == REPLAY_CMD_REVERT ? "revert" : "pick";
-	const char *subject;
-	int subject_len;
+	struct replay_insn_list *cur;
 
 	for (cur = todo_list; cur; cur = cur->next) {
-		sha1_abbrev = find_unique_abbrev(cur->item->object.sha1, DEFAULT_ABBREV);
-		subject_len = find_commit_subject(cur->item->buffer, &subject);
+		const char *sha1_abbrev, *action_str, *subject;
+		int subject_len;
+
+		action_str = action_name(cur->action);
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
 	int saved, status, padding;
 
 	if (!prefixcmp(bol, "pick")) {
-		action = REPLAY_PICK;
+		item->action = REPLAY_PICK;
 		bol += strlen("pick");
 	} else if (!prefixcmp(bol, "revert")) {
-		action = REPLAY_REVERT;
+		item->action = REPLAY_REVERT;
 		bol += strlen("revert");
 	} else
-		return NULL;
+		return -1;
 
 	/* Eat up extra spaces/ tabs before object name */
 	padding = strspn(bol, " \t");
 	if (!padding)
-		return NULL;
+		return -1;
 	bol += padding;
 
 	end_of_object_name = bol + strcspn(bol, " \t\n");
@@ -740,37 +741,29 @@ static struct commit *parse_insn_line(char *bol, char *eol, struct replay_opts *
 	status = get_sha1(bol, commit_sha1);
 	*end_of_object_name = saved;
 
-	/*
-	 * Verify that the action matches up with the one in
-	 * opts; we don't support arbitrary instructions
-	 */
-	if ((action == REPLAY_PICK && opts->command == REPLAY_CMD_REVERT) ||
-		(action == REPLAY_REVERT && opts->command == REPLAY_CMD_CHERRY_PICK)) {
-		error(_("Cannot %s during a %s"), action_name(action),
-			command_name(opts));
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
+	struct replay_insn_list item = { NULL, 0, NULL };
 	char *p = buf;
 	int i;
 
 	for (i = 1; *p; i++) {
 		char *eol = strchrnul(p, '\n');
-		commit = parse_insn_line(p, eol, opts);
-		if (!commit)
+		if (parse_insn_line(p, eol, &item) < 0)
 			return error(_("Could not parse line %d."), i);
-		next = commit_list_append(commit, next);
+		next = replay_insn_list_append(item.operand, item.action, next);
 		p = *eol ? eol + 1 : eol;
 	}
 	if (!*todo_list)
@@ -778,8 +771,7 @@ static int parse_insn_buffer(char *buf, struct commit_list **todo_list,
 	return 0;
 }
 
-static void read_populate_todo(struct commit_list **todo_list,
-			struct replay_opts *opts)
+static void read_populate_todo(struct replay_insn_list **todo_list)
 {
 	const char *todo_file = git_path(SEQ_TODO_FILE);
 	struct strbuf buf = STRBUF_INIT;
@@ -795,7 +787,7 @@ static void read_populate_todo(struct commit_list **todo_list,
 	}
 	close(fd);
 
-	res = parse_insn_buffer(buf.buf, todo_list, opts);
+	res = parse_insn_buffer(buf.buf, todo_list);
 	strbuf_release(&buf);
 	if (res)
 		die(_("Unusable instruction sheet: %s"), todo_file);
@@ -844,17 +836,19 @@ static void read_populate_opts(struct replay_opts **opts_ptr)
 		die(_("Malformed options sheet: %s"), opts_file);
 }
 
-static void walk_revs_populate_todo(struct commit_list **todo_list,
+static void walk_revs_populate_todo(struct replay_insn_list **todo_list,
 				struct replay_opts *opts)
 {
 	struct commit *commit;
-	struct commit_list **next;
+	struct replay_insn_list **next;
+	enum replay_action action;
 
 	prepare_revs(opts);
 
 	next = todo_list;
+	action = opts->command == REPLAY_CMD_REVERT ? REPLAY_REVERT : REPLAY_PICK;
 	while ((commit = get_revision(opts->revs)))
-		next = commit_list_append(commit, next);
+		next = replay_insn_list_append(commit, action, next);
 }
 
 static int create_seq_dir(void)
@@ -996,7 +990,7 @@ fail:
 	return -1;
 }
 
-static void save_todo(struct commit_list *todo_list, struct replay_opts *opts)
+static void save_todo(struct replay_insn_list *todo_list)
 {
 	const char *todo_file = git_path(SEQ_TODO_FILE);
 	static struct lock_file todo_lock;
@@ -1004,7 +998,7 @@ static void save_todo(struct commit_list *todo_list, struct replay_opts *opts)
 	int fd;
 
 	fd = hold_lock_file_for_update(&todo_lock, todo_file, LOCK_DIE_ON_ERROR);
-	if (format_todo(&buf, todo_list, opts) < 0)
+	if (format_todo(&buf, todo_list) < 0)
 		die(_("Could not format %s."), todo_file);
 	if (write_in_full(fd, buf.buf, buf.len) < 0) {
 		strbuf_release(&buf);
@@ -1048,9 +1042,9 @@ static void save_opts(struct replay_opts *opts)
 	}
 }
 
-static int pick_commits(struct commit_list *todo_list, struct replay_opts *opts)
+static int pick_commits(struct replay_insn_list *todo_list, struct replay_opts *opts)
 {
-	struct commit_list *cur;
+	struct replay_insn_list *cur;
 	int res;
 
 	setenv(GIT_REFLOG_ACTION, command_name(opts), 0);
@@ -1060,8 +1054,8 @@ static int pick_commits(struct commit_list *todo_list, struct replay_opts *opts)
 	read_and_refresh_cache(opts);
 
 	for (cur = todo_list; cur; cur = cur->next) {
-		save_todo(cur, opts);
-		res = do_pick_commit(cur->item, opts);
+		save_todo(cur);
+		res = do_pick_commit(cur->operand, cur->action, opts);
 		if (res)
 			return res;
 	}
@@ -1086,7 +1080,7 @@ static int continue_single_pick(void)
 
 static int sequencer_continue(struct replay_opts *opts)
 {
-	struct commit_list *todo_list = NULL;
+	struct replay_insn_list *todo_list = NULL;
 	enum replay_command cmd;
 
 	if (!file_exists(git_path(SEQ_TODO_FILE)))
@@ -1103,7 +1097,7 @@ static int sequencer_continue(struct replay_opts *opts)
 			cmd == REPLAY_CMD_REVERT ? "revert" : "cherry-pick");
 
 	read_populate_opts(&opts);
-	read_populate_todo(&todo_list, opts);
+	read_populate_todo(&todo_list);
 
 	/* Verify that the conflict has been resolved */
 	if (file_exists(git_path("CHERRY_PICK_HEAD")) ||
@@ -1120,13 +1114,16 @@ static int sequencer_continue(struct replay_opts *opts)
 
 static int single_pick(struct commit *cmit, struct replay_opts *opts)
 {
+	enum replay_action action;
+	action = opts->command == REPLAY_CMD_REVERT ? REPLAY_REVERT : REPLAY_PICK;
+
 	setenv(GIT_REFLOG_ACTION, command_name(opts), 0);
-	return do_pick_commit(cmit, opts);
+	return do_pick_commit(cmit, action, opts);
 }
 
 static int pick_revisions(struct replay_opts *opts)
 {
-	struct commit_list *todo_list = NULL;
+	struct replay_insn_list *todo_list = NULL;
 	unsigned char sha1[20];
 
 	if (opts->subcommand == REPLAY_NONE)
diff --git a/sequencer.h b/sequencer.h
index 00ab685..d1cb5c2 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -24,6 +24,12 @@ enum replay_subcommand {
 	REPLAY_ROLLBACK
 };
 
+struct replay_insn_list {
+	struct commit *operand;
+	enum replay_action action;
+	struct replay_insn_list *next;
+};
+
 /* Removes SEQ_DIR. */
 extern void remove_sequencer_state(void);
 
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index 73298cf..f97ab79 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -456,7 +456,7 @@ test_expect_success 'sign-off needs to be reaffirmed after conflict resolution,
 	! grep Signed-off-by: msg
 '
 
-test_expect_success 'malformed instruction sheet 1' '
+test_expect_success 'malformed instruction sheet, action' '
 	pristine_detach initial &&
 	test_expect_code 1 git cherry-pick base..anotherpick &&
 	echo "resolved" >foo &&
@@ -467,23 +467,12 @@ test_expect_success 'malformed instruction sheet 1' '
 	test_expect_code 128 git cherry-pick --continue
 '
 
-test_expect_success 'malformed instruction sheet 2' '
-	pristine_detach initial &&
-	test_expect_code 1 git cherry-pick base..anotherpick &&
-	echo "resolved" >foo &&
-	git add foo &&
-	git commit &&
-	sed "s/pick/revert/" .git/sequencer/todo >new_sheet &&
-	cp new_sheet .git/sequencer/todo &&
-	test_expect_code 128 git cherry-pick --continue
-'
-
 test_expect_success 'empty commit set' '
 	pristine_detach initial &&
 	test_expect_code 128 git cherry-pick base..base
 '
 
-test_expect_success 'malformed instruction sheet 3' '
+test_expect_success 'malformed instruction sheet, object name' '
 	pristine_detach initial &&
 	test_expect_code 1 git cherry-pick base..anotherpick &&
 	echo "resolved" >foo &&
@@ -528,4 +517,35 @@ test_expect_success 'revert --continue refuses to follow cherry-pick' '
        test_expect_code 128 git revert --continue
 '
 
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
1.7.8.2
