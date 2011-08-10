From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 3/5] revert: Allow mixed pick and revert instructions
Date: Wed, 10 Aug 2011 15:25:49 +0530
Message-ID: <1312970151-18906-4-git-send-email-artagnon@gmail.com>
References: <1312970151-18906-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 10 11:59:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qr5ZG-0001ol-VN
	for gcvg-git-2@lo.gmane.org; Wed, 10 Aug 2011 11:59:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753632Ab1HJJ7M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Aug 2011 05:59:12 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:61802 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753627Ab1HJJ7J (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2011 05:59:09 -0400
Received: by mail-pz0-f42.google.com with SMTP id 37so1583833pzk.1
        for <git@vger.kernel.org>; Wed, 10 Aug 2011 02:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=GqQE96hKN10HaTxEikM0Yy8p+2lEuYx9HZivJnzPoX8=;
        b=nPf7hxKF8744aLpWdZqCbF3+rzhWCevVexrykd8n4rVd4EtxKRDwkvwBEw1tY0Vc/t
         4JWeIK22yVOnY5RcTDdPhnbdONGCyG7d50mxsLvnx0fWb5SR+0JPUuqOd77JCVHlDS2l
         6tTFa0iKFs+Ar3KhtIK5GuCNigHdVQ/zJSnbY=
Received: by 10.142.238.8 with SMTP id l8mr7111873wfh.330.1312970349353;
        Wed, 10 Aug 2011 02:59:09 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id s7sm725394pbj.69.2011.08.10.02.59.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 10 Aug 2011 02:59:08 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.351.gb35ac.dirty
In-Reply-To: <1312970151-18906-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179060>

Change the way the instruction parser works, allowing arbitrary
(action, operand) pairs to be parsed.  So now, you can do:

  pick fdc0b12 picked
  revert 965fed4 anotherpick

For cherry-pick and revert, this means that a 'git cherry-pick
--continue' can continue an ongoing revert operation and viceversa.
This patch lays the foundation for extending the parser to support
more actions.

Helped-by: Jonathan Nieder <jrnider@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/revert.c                |  110 +++++++++++++++++++--------------------
 sequencer.h                     |    6 ++
 t/t3510-cherry-pick-sequence.sh |   58 ++++++++++++++++++++
 3 files changed, 117 insertions(+), 57 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 81502d4..d48a92e 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -639,89 +639,84 @@ static void read_and_refresh_cache(struct replay_opts *opts)
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
+	struct replay_insn_list *new = xmalloc(sizeof(struct replay_insn_list));
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
+	struct replay_insn_list *cur = NULL;
 	struct commit_message msg = { NULL, NULL, NULL, NULL, NULL };
 	const char *sha1_abbrev = NULL;
-	const char *action_str = opts->action == REPLAY_REVERT ? "revert" : "pick";
+	const char *action_str;
 
 	for (cur = todo_list; cur; cur = cur->next) {
-		sha1_abbrev = find_unique_abbrev(cur->item->object.sha1, DEFAULT_ABBREV);
-		if (get_message(cur->item, &msg))
+		action_str = cur->action == REPLAY_REVERT ? "revert" : "pick";
+
+		sha1_abbrev = find_unique_abbrev(cur->operand->object.sha1, DEFAULT_ABBREV);
+		if (get_message(cur->operand, &msg))
 			return error(_("Cannot get commit message for %s"), sha1_abbrev);
 		strbuf_addf(buf, "%s %s %s\n", action_str, sha1_abbrev, msg.subject);
 	}
 	return 0;
 }
 
-static struct commit *parse_insn_line(char *start, struct replay_opts *opts)
+static int parse_insn_line(char *start, enum replay_action *action,
+			struct commit **operand)
 {
 	unsigned char commit_sha1[20];
 	char sha1_abbrev[40];
-	enum replay_action action;
-	int insn_len = 0;
+	int keyword_len;
 	char *p, *q;
 
 	if (!prefixcmp(start, "pick ")) {
-		action = REPLAY_PICK;
-		insn_len = strlen("pick");
-		p = start + insn_len + 1;
+		*action = REPLAY_PICK;
+		keyword_len = strlen("pick");
+		p = start + keyword_len + 1;
 	} else if (!prefixcmp(start, "revert ")) {
-		action = REPLAY_REVERT;
-		insn_len = strlen("revert");
-		p = start + insn_len + 1;
+		*action = REPLAY_REVERT;
+		keyword_len = strlen("revert");
+		p = start + keyword_len + 1;
 	} else
-		return NULL;
+		return -1;
 
 	q = strchr(p, ' ');
 	if (!q)
-		return NULL;
+		return -1;
 	q++;
 
 	strlcpy(sha1_abbrev, p, q - p);
 
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
 	if (get_sha1(sha1_abbrev, commit_sha1) < 0)
-		return NULL;
+		return -1;
+
+	*operand = lookup_commit_reference(commit_sha1);
+	if (!*operand)
+		return -1;
 
-	return lookup_commit_reference(commit_sha1);
+	return 0;
 }
 
-static int parse_insn_buffer(char *buf, struct commit_list **todo_list,
-			struct replay_opts *opts)
+static int parse_insn_buffer(char *buf, struct replay_insn_list **todo_list)
 {
-	struct commit_list **next = todo_list;
-	struct commit *commit;
+	struct replay_insn_list **next = todo_list;
+	enum replay_action action;
+	struct commit *operand;
 	char *p = buf;
 	int i;
 
 	for (i = 1; *p; i++) {
-		commit = parse_insn_line(p, opts);
-		if (!commit)
+		if (parse_insn_line(p, &action, &operand) < 0)
 			return error(_("Could not parse line %d."), i);
-		next = commit_list_append(commit, next);
+		next = replay_insn_list_append(action, operand, next);
 		p = strchrnul(p, '\n');
 		if (*p)
 			p++;
@@ -731,8 +726,7 @@ static int parse_insn_buffer(char *buf, struct commit_list **todo_list,
 	return 0;
 }
 
-static void read_populate_todo(struct commit_list **todo_list,
-			struct replay_opts *opts)
+static void read_populate_todo(struct replay_insn_list **todo_list)
 {
 	const char *todo_file = git_path(SEQ_TODO_FILE);
 	struct strbuf buf = STRBUF_INIT;
@@ -748,7 +742,7 @@ static void read_populate_todo(struct commit_list **todo_list,
 	}
 	close(fd);
 
-	res = parse_insn_buffer(buf.buf, todo_list, opts);
+	res = parse_insn_buffer(buf.buf, todo_list);
 	strbuf_release(&buf);
 	if (res)
 		die(_("Unusable instruction sheet: %s"), todo_file);
@@ -797,18 +791,18 @@ static void read_populate_opts(struct replay_opts **opts_ptr)
 		die(_("Malformed options sheet: %s"), opts_file);
 }
 
-static void walk_revs_populate_todo(struct commit_list **todo_list,
+static void walk_revs_populate_todo(struct replay_insn_list **todo_list,
 				struct replay_opts *opts)
 {
 	struct rev_info revs;
-	struct commit *commit;
-	struct commit_list **next;
+	struct commit *operand;
+	struct replay_insn_list **next;
 
 	prepare_revs(&revs, opts);
 
 	next = todo_list;
-	while ((commit = get_revision(&revs)))
-		next = commit_list_append(commit, next);
+	while ((operand = get_revision(&revs)))
+		next = replay_insn_list_append(opts->action, operand, next);
 }
 
 static int create_seq_dir(void)
@@ -837,7 +831,7 @@ static void save_head(const char *head)
 		die(_("Error wrapping up %s."), head_file);
 }
 
-static void save_todo(struct commit_list *todo_list, struct replay_opts *opts)
+static void save_todo(struct replay_insn_list *todo_list)
 {
 	const char *todo_file = git_path(SEQ_TODO_FILE);
 	static struct lock_file todo_lock;
@@ -845,7 +839,7 @@ static void save_todo(struct commit_list *todo_list, struct replay_opts *opts)
 	int fd;
 
 	fd = hold_lock_file_for_update(&todo_lock, todo_file, LOCK_DIE_ON_ERROR);
-	if (format_todo(&buf, todo_list, opts) < 0)
+	if (format_todo(&buf, todo_list) < 0)
 		die(_("Could not format %s."), todo_file);
 	if (write_in_full(fd, buf.buf, buf.len) < 0) {
 		strbuf_release(&buf);
@@ -889,9 +883,10 @@ static void save_opts(struct replay_opts *opts)
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
@@ -901,8 +896,9 @@ static int pick_commits(struct commit_list *todo_list, struct replay_opts *opts)
 	read_and_refresh_cache(opts);
 
 	for (cur = todo_list; cur; cur = cur->next) {
-		save_todo(cur, opts);
-		res = do_pick_commit(cur->item, opts);
+		save_todo(cur);
+		opts->action = cur->action;
+		res = do_pick_commit(cur->operand, opts);
 		if (res) {
 			if (!cur->next && res > 0)
 				/*
@@ -927,7 +923,7 @@ static int pick_commits(struct commit_list *todo_list, struct replay_opts *opts)
 
 static int pick_revisions(struct replay_opts *opts)
 {
-	struct commit_list *todo_list = NULL;
+	struct replay_insn_list *todo_list = NULL;
 	unsigned char sha1[20];
 
 	read_and_refresh_cache(opts);
@@ -944,7 +940,7 @@ static int pick_revisions(struct replay_opts *opts)
 		if (!file_exists(git_path(SEQ_TODO_FILE)))
 			goto error;
 		read_populate_opts(&opts);
-		read_populate_todo(&todo_list, opts);
+		read_populate_todo(&todo_list);
 
 		/* Verify that the conflict has been resolved */
 		if (!index_differs_from("HEAD", 0))
diff --git a/sequencer.h b/sequencer.h
index 0b5d94e..01caa8a 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -32,6 +32,12 @@ struct replay_opts {
 	size_t xopts_nr, xopts_alloc;
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
index 3bca2b3..f85372c 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -211,4 +211,62 @@ test_expect_success 'malformed instruction sheet 2' '
 	test_must_fail git cherry-pick --continue
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
