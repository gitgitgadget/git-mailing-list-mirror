From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 09/10] revert: allow mixed pick and revert instructions
Date: Wed, 14 Dec 2011 22:24:36 +0530
Message-ID: <1323881677-11117-10-git-send-email-artagnon@gmail.com>
References: <CALkWK0kbV2WFfGVrA9m_Uwd4J8+U9Yde9Wxb-OZE9Y8K+Ta_4A@mail.gmail.com>
 <1323881677-11117-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 14 17:55:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ras7E-0004kJ-9X
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 17:55:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757641Ab1LNQzZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Dec 2011 11:55:25 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:61872 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757627Ab1LNQzV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2011 11:55:21 -0500
Received: by mail-vx0-f174.google.com with SMTP id fk14so763696vcb.19
        for <git@vger.kernel.org>; Wed, 14 Dec 2011 08:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=gdWMDoON6PUJwc6wqLs0Yp22PeH1yUb1etZTdNER41E=;
        b=notZGSld2J9YoXVlw1XBELdJu53XAL5suWZbCjIrJ25qjIED+gv938/FiOvIJJuqRf
         vAK7eUMkqYeMDakvVVBJXr0cnevyOarIrNAx34kCrJ80y2MWZOOYmeFmLrsLqyDhegWm
         8alTSWo9QYLqamPoDTS1NfSmY7PE98TDK6ef8=
Received: by 10.52.33.50 with SMTP id o18mr5377290vdi.42.1323881720968;
        Wed, 14 Dec 2011 08:55:20 -0800 (PST)
Received: from localhost.localdomain ([122.174.116.246])
        by mx.google.com with ESMTPS id ir2sm2963127vdb.9.2011.12.14.08.55.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 14 Dec 2011 08:55:19 -0800 (PST)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1323881677-11117-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187154>

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
 builtin/revert.c                |  107 ++++++++++++++++++---------------------
 sequencer.h                     |    6 ++
 t/t3510-cherry-pick-sequence.sh |   58 +++++++++++++++++++++
 3 files changed, 114 insertions(+), 57 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index ed062ea..50af439 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -459,7 +459,8 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts)
 	return run_command_v_opt(args, RUN_GIT_CMD);
 }
 
-static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
+static int do_pick_commit(struct commit *commit, enum replay_action action,
+			struct replay_opts *opts)
 {
 	unsigned char head[20];
 	struct commit *base, *next, *parent;
@@ -534,7 +535,7 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 
 	defmsg = git_pathdup("MERGE_MSG");
 
-	if (opts->action == REPLAY_REVERT) {
+	if (action == REPLAY_REVERT) {
 		base = commit;
 		base_label = msg.label;
 		next = parent;
@@ -575,7 +576,7 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 		}
 	}
 
-	if (!opts->strategy || !strcmp(opts->strategy, "recursive") || opts->action == REPLAY_REVERT) {
+	if (!opts->strategy || !strcmp(opts->strategy, "recursive") || action == REPLAY_REVERT) {
 		res = do_recursive_merge(base, next, base_label, next_label,
 					 head, &msgbuf, opts);
 		write_message(&msgbuf, defmsg);
@@ -605,7 +606,7 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 		write_cherry_pick_head(commit, "REVERT_HEAD");
 
 	if (res) {
-		error(opts->action == REPLAY_REVERT
+		error(action == REPLAY_REVERT
 		      ? _("could not revert %s... %s")
 		      : _("could not apply %s... %s"),
 		      find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV),
@@ -675,54 +676,54 @@ static void read_and_refresh_cache(struct replay_opts *opts)
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
-	const char *action_str = opts->action == REPLAY_REVERT ? "revert" : "pick";
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
@@ -731,37 +732,29 @@ static struct commit *parse_insn_line(char *bol, char *eol, struct replay_opts *
 	status = get_sha1(bol, commit_sha1);
 	*end_of_object_name = saved;
 
-	/*
-	 * Verify that the action matches up with the one in
-	 * opts; we don't support arbitrary instructions
-	 */
-	if (action != opts->action) {
-		const char *action_str;
-		action_str = action == REPLAY_REVERT ? "revert" : "cherry-pick";
-		error(_("Cannot %s during a %s"), action_str, action_name(opts));
-		return NULL;
-	}
-
 	if (status < 0)
-		return NULL;
+		return -1;
 
-	return lookup_commit_reference(commit_sha1);
+	item->operand = lookup_commit_reference(commit_sha1);
+	if (!item->operand)
+		return -1;
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
@@ -769,8 +762,7 @@ static int parse_insn_buffer(char *buf, struct commit_list **todo_list,
 	return 0;
 }
 
-static void read_populate_todo(struct commit_list **todo_list,
-			struct replay_opts *opts)
+static void read_populate_todo(struct replay_insn_list **todo_list)
 {
 	const char *todo_file = git_path(SEQ_TODO_FILE);
 	struct strbuf buf = STRBUF_INIT;
@@ -786,7 +778,7 @@ static void read_populate_todo(struct commit_list **todo_list,
 	}
 	close(fd);
 
-	res = parse_insn_buffer(buf.buf, todo_list, opts);
+	res = parse_insn_buffer(buf.buf, todo_list);
 	strbuf_release(&buf);
 	if (res)
 		die(_("Unusable instruction sheet: %s"), todo_file);
@@ -835,18 +827,18 @@ static void read_populate_opts(struct replay_opts **opts_ptr)
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
@@ -944,7 +936,7 @@ fail:
 	return -1;
 }
 
-static void save_todo(struct commit_list *todo_list, struct replay_opts *opts)
+static void save_todo(struct replay_insn_list *todo_list)
 {
 	const char *todo_file = git_path(SEQ_TODO_FILE);
 	static struct lock_file todo_lock;
@@ -952,7 +944,7 @@ static void save_todo(struct commit_list *todo_list, struct replay_opts *opts)
 	int fd;
 
 	fd = hold_lock_file_for_update(&todo_lock, todo_file, LOCK_DIE_ON_ERROR);
-	if (format_todo(&buf, todo_list, opts) < 0)
+	if (format_todo(&buf, todo_list) < 0)
 		die(_("Could not format %s."), todo_file);
 	if (write_in_full(fd, buf.buf, buf.len) < 0) {
 		strbuf_release(&buf);
@@ -996,9 +988,10 @@ static void save_opts(struct replay_opts *opts)
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
@@ -1008,8 +1001,8 @@ static int pick_commits(struct commit_list *todo_list, struct replay_opts *opts)
 	read_and_refresh_cache(opts);
 
 	for (cur = todo_list; cur; cur = cur->next) {
-		save_todo(cur, opts);
-		res = do_pick_commit(cur->item, opts);
+		save_todo(cur);
+		res = do_pick_commit(cur->operand, cur->action, opts);
 		if (res) {
 			if (!cur->next)
 				/*
@@ -1034,7 +1027,7 @@ static int pick_commits(struct commit_list *todo_list, struct replay_opts *opts)
 
 static int pick_revisions(struct replay_opts *opts)
 {
-	struct commit_list *todo_list = NULL;
+	struct replay_insn_list *todo_list = NULL;
 	unsigned char sha1[20];
 
 	read_and_refresh_cache(opts);
@@ -1054,7 +1047,7 @@ static int pick_revisions(struct replay_opts *opts)
 		if (!file_exists(git_path(SEQ_TODO_FILE)))
 			return error(_("No %s in progress"), action_name(opts));
 		read_populate_opts(&opts);
-		read_populate_todo(&todo_list, opts);
+		read_populate_todo(&todo_list);
 
 		/* Verify that the conflict has been resolved */
 		if (!index_differs_from("HEAD", 0))
diff --git a/sequencer.h b/sequencer.h
index 9b1b94d..648f7bf 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -19,6 +19,12 @@ enum replay_subcommand {
 	REPLAY_ROLLBACK
 };
 
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
index 1bfbe41..9b19917 100755
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
1.7.4.1
