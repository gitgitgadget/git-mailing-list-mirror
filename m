From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [RFC/ PATCH] revert: Allow arbitrary sequencer instructions
Date: Tue,  2 Aug 2011 10:24:44 +0530
Message-ID: <1312260884-5087-2-git-send-email-artagnon@gmail.com>
References: <1312260884-5087-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 02 06:58:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qo73M-0004iY-OB
	for gcvg-git-2@lo.gmane.org; Tue, 02 Aug 2011 06:58:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346Ab1HBE56 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Aug 2011 00:57:58 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:34635 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750807Ab1HBE54 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2011 00:57:56 -0400
Received: by mail-pz0-f42.google.com with SMTP id 37so12781727pzk.1
        for <git@vger.kernel.org>; Mon, 01 Aug 2011 21:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ZxzJxP/DE8kuZLUn9KBe9nSMK9bsrVw4xOZQTTMb9Xc=;
        b=lXrAznuWGsYGr5YwLfjn2tFHKohqtgrgTMes7bXCBtou9La1T4VcV1l9OphA2K3LyF
         GxwFIinhbH8ryAvXwbJKQv3HKfBHSmZdl0R45mWORoq1TzJJncdqkkCMjbnESjWycl73
         icciNxHyN049nbjDzbUJOs9mbsFggGY/Pngqg=
Received: by 10.68.25.65 with SMTP id a1mr8441851pbg.407.1312261076192;
        Mon, 01 Aug 2011 21:57:56 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id k3sm6324675pbj.77.2011.08.01.21.57.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 01 Aug 2011 21:57:55 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.351.gb35ac.dirty
In-Reply-To: <1312260884-5087-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178441>

Allow arbitrary sequencer instructions in the instruction sheet.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/revert.c |  101 +++++++++++++++++++++++++++++-------------------------
 sequencer.h      |   10 +++++
 2 files changed, 64 insertions(+), 47 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index bca1490..127b97e 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -646,49 +646,54 @@ static void read_and_refresh_cache(struct replay_opts *opts)
  *     assert(commit_list_count(list) == 2);
  *     return list;
  */
-struct commit_list **commit_list_append(struct commit *commit,
-					struct commit_list **next)
+struct replay_insn_list **replay_insn_list_append(struct replay_insn *insn,
+						struct replay_insn_list **next)
 {
-	struct commit_list *new = xmalloc(sizeof(struct commit_list));
-	new->item = commit;
+	struct replay_insn_list *new = xmalloc(sizeof(struct replay_insn_list));
+	new->item = insn;
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
+	struct commit *commit;
 	struct commit_message msg = { NULL, NULL, NULL, NULL, NULL };
 	const char *sha1_abbrev = NULL;
-	const char *action_str = opts->action == REVERT ? "revert" : "pick";
+	const char *action_str;
 
 	for (cur = todo_list; cur; cur = cur->next) {
-		sha1_abbrev = find_unique_abbrev(cur->item->object.sha1, DEFAULT_ABBREV);
-		if (get_message(cur->item, &msg))
+		commit = cur->item->commit;
+		action_str = cur->item->action == REVERT ? "revert" : "pick";
+
+		sha1_abbrev = find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV);
+		if (get_message(commit, &msg))
 			return error(_("Cannot get commit message for %s"), sha1_abbrev);
 		strbuf_addf(buf, "%s %s %s\n", action_str, sha1_abbrev, msg.subject);
 	}
 	return 0;
 }
 
-static struct commit *parse_insn_line(char *start, struct replay_opts *opts)
+static struct replay_insn *parse_insn_line(char *start)
 {
 	unsigned char commit_sha1[20];
 	char sha1_abbrev[40];
+	struct commit *commit;
+	struct replay_insn *insn;
 	enum replay_action action;
-	int insn_len = 0;
+	int keyword_len;
 	char *p, *q;
 
 	if (!prefixcmp(start, "pick ")) {
 		action = CHERRY_PICK;
-		insn_len = strlen("pick");
-		p = start + insn_len + 1;
+		keyword_len = strlen("pick");
+		p = start + keyword_len + 1;
 	} else if (!prefixcmp(start, "revert ")) {
 		action = REVERT;
-		insn_len = strlen("revert");
-		p = start + insn_len + 1;
+		keyword_len = strlen("revert");
+		p = start + keyword_len + 1;
 	} else
 		return NULL;
 
@@ -699,30 +704,25 @@ static struct commit *parse_insn_line(char *start, struct replay_opts *opts)
 
 	strlcpy(sha1_abbrev, p, q - p);
 
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
 		return NULL;
 
-	return lookup_commit_reference(commit_sha1);
+	commit = lookup_commit_reference(commit_sha1);
+	if (commit) {
+		insn = xmalloc(sizeof(struct replay_insn));
+		insn->commit = commit;
+		insn->action = action;
+		return insn;
+	}
+	return NULL;
 }
 
-static void read_populate_todo(struct commit_list **todo_list,
-			struct replay_opts *opts)
+static void read_populate_todo(struct replay_insn_list **todo_list)
 {
 	const char *todo_file = git_path(SEQ_TODO_FILE);
 	struct strbuf buf = STRBUF_INIT;
-	struct commit_list **next;
-	struct commit *commit;
+	struct replay_insn *insn;
+	struct replay_insn_list **next;
 	char *p;
 	int fd;
 
@@ -738,10 +738,10 @@ static void read_populate_todo(struct commit_list **todo_list,
 
 	next = todo_list;
 	for (p = buf.buf; *p; p = strchr(p, '\n') + 1) {
-		commit = parse_insn_line(p, opts);
-		if (!commit)
+		insn = parse_insn_line(p);
+		if (!insn)
 			goto error;
-		next = commit_list_append(commit, next);
+		next = replay_insn_list_append(insn, next);
 	}
 	if (!*todo_list)
 		goto error;
@@ -795,18 +795,23 @@ static void read_populate_opts(struct replay_opts **opts_ptr)
 		die(_("Malformed options sheet: %s"), opts_file);
 }
 
-static void walk_revs_populate_todo(struct commit_list **todo_list,
+static void walk_revs_populate_todo(struct replay_insn_list **todo_list,
 				struct replay_opts *opts)
 {
 	struct rev_info revs;
 	struct commit *commit;
-	struct commit_list **next;
+	struct replay_insn *insn;
+	struct replay_insn_list **next;
 
 	prepare_revs(&revs, opts);
 
 	next = todo_list;
-	while ((commit = get_revision(&revs)))
-		next = commit_list_append(commit, next);
+	while ((commit = get_revision(&revs))) {
+		insn = xmalloc(sizeof(struct replay_insn));
+		insn->commit = commit;
+		insn->action = opts->action;
+		next = replay_insn_list_append(insn, next);
+	}
 }
 
 static int create_seq_dir(void)
@@ -835,7 +840,7 @@ static void save_head(const char *head)
 		die(_("Error wrapping up %s."), head_file);
 }
 
-static void save_todo(struct commit_list *todo_list, struct replay_opts *opts)
+static void save_todo(struct replay_insn_list *todo_list)
 {
 	const char *todo_file = git_path(SEQ_TODO_FILE);
 	static struct lock_file todo_lock;
@@ -843,7 +848,7 @@ static void save_todo(struct commit_list *todo_list, struct replay_opts *opts)
 	int fd;
 
 	fd = hold_lock_file_for_update(&todo_lock, todo_file, LOCK_DIE_ON_ERROR);
-	if (format_todo(&buf, todo_list, opts) < 0)
+	if (format_todo(&buf, todo_list) < 0)
 		die(_("Could not format %s."), todo_file);
 	if (write_in_full(fd, buf.buf, buf.len) < 0) {
 		strbuf_release(&buf);
@@ -887,9 +892,10 @@ static void save_opts(struct replay_opts *opts)
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
@@ -899,8 +905,9 @@ static int pick_commits(struct commit_list *todo_list, struct replay_opts *opts)
 	read_and_refresh_cache(opts);
 
 	for (cur = todo_list; cur; cur = cur->next) {
-		save_todo(cur, opts);
-		res = do_pick_commit(cur->item, opts);
+		save_todo(cur);
+		opts->action = cur->item->action;
+		res = do_pick_commit(cur->item->commit, opts);
 		if (res) {
 			if (!cur->next)
 				/*
@@ -925,7 +932,7 @@ static int pick_commits(struct commit_list *todo_list, struct replay_opts *opts)
 
 static int pick_revisions(struct replay_opts *opts)
 {
-	struct commit_list *todo_list = NULL;
+	struct replay_insn_list *todo_list = NULL;
 	unsigned char sha1[20];
 
 	read_and_refresh_cache(opts);
@@ -942,7 +949,7 @@ static int pick_revisions(struct replay_opts *opts)
 		if (!file_exists(git_path(SEQ_TODO_FILE)))
 			goto error;
 		read_populate_opts(&opts);
-		read_populate_todo(&todo_list, opts);
+		read_populate_todo(&todo_list);
 
 		/* Verify that the conflict has been resolved */
 		if (!index_differs_from("HEAD", 0))
diff --git a/sequencer.h b/sequencer.h
index 931733c..eebee65 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -32,6 +32,16 @@ struct replay_opts {
 	size_t xopts_nr, xopts_alloc;
 };
 
+struct replay_insn {
+	struct commit *commit;
+	enum replay_action action;
+};
+
+struct replay_insn_list {
+	struct replay_insn *item;
+	struct replay_insn_list *next;
+};
+
 /*
  * Removes SEQ_OLD_DIR and renames SEQ_DIR to SEQ_OLD_DIR, ignoring
  * any errors.  Intended to be used by 'git reset'.
-- 
1.7.6.351.gb35ac.dirty
