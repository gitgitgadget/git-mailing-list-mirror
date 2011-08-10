From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 4/5] sequencer: Expose code that handles files in .git/sequencer
Date: Wed, 10 Aug 2011 15:25:50 +0530
Message-ID: <1312970151-18906-5-git-send-email-artagnon@gmail.com>
References: <1312970151-18906-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 10 11:59:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qr5Zi-00021r-QG
	for gcvg-git-2@lo.gmane.org; Wed, 10 Aug 2011 11:59:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753669Ab1HJJ7T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Aug 2011 05:59:19 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:61802 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753656Ab1HJJ7Q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2011 05:59:16 -0400
Received: by mail-pz0-f42.google.com with SMTP id 37so1583833pzk.1
        for <git@vger.kernel.org>; Wed, 10 Aug 2011 02:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=fEm3lpj+byd12pcjIes20MqDdd8PnchBPLF7mS0bqvA=;
        b=FjeqXnr/cPdazhCE3oTXxI+XRI4Qqi3I+HVtS5PPWxMLKLOCC3lvUeTTSAn0rmpF5/
         Mi4sDdA6L8kiSChenMt9yj0iMrvMH0LQn7g39SO2COifc3M5hvoxgiGiVXdFUfze2alg
         v7uAG1ei1EtT25nPKcuWU+c/y9LbTC9hWZHRc=
Received: by 10.142.75.15 with SMTP id x15mr109051wfa.329.1312970356476;
        Wed, 10 Aug 2011 02:59:16 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id s7sm725394pbj.69.2011.08.10.02.59.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 10 Aug 2011 02:59:15 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.351.gb35ac.dirty
In-Reply-To: <1312970151-18906-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179062>

Move the saving and parsing functions for files in '.git/sequencer'
from 'builtin/revert.c' into 'sequencer.c' and expose them using a
sane API.  This is the first step towards a generalized sequencer.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/revert.c |  332 +----------------------------------------------------
 sequencer.c      |  309 ++++++++++++++++++++++++++++++++++++++++++++++++++
 sequencer.h      |   21 ++++
 3 files changed, 337 insertions(+), 325 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index d48a92e..491c10a 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -5,7 +5,6 @@
 #include "tag.h"
 #include "run-command.h"
 #include "exec_cmd.h"
-#include "utf8.h"
 #include "parse-options.h"
 #include "cache-tree.h"
 #include "diff.h"
@@ -46,8 +45,6 @@ static const char *action_name(const struct replay_opts *opts)
 	return opts->action == REPLAY_REVERT ? "revert" : "cherry-pick";
 }
 
-static char *get_encoding(const char *message);
-
 static const char * const *revert_or_cherry_pick_usage(struct replay_opts *opts)
 {
 	return opts->action == REPLAY_REVERT ? revert_usage : cherry_pick_usage;
@@ -189,80 +186,12 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 	opts->commit_argv = argv;
 }
 
-struct commit_message {
-	char *parent_label;
-	const char *label;
-	const char *subject;
-	char *reencoded_message;
-	const char *message;
-};
-
-static int get_message(struct commit *commit, struct commit_message *out)
-{
-	const char *encoding;
-	const char *abbrev, *subject;
-	int abbrev_len, subject_len;
-	char *q;
-
-	if (!commit->buffer)
-		return -1;
-	encoding = get_encoding(commit->buffer);
-	if (!encoding)
-		encoding = "UTF-8";
-	if (!git_commit_encoding)
-		git_commit_encoding = "UTF-8";
-
-	out->reencoded_message = NULL;
-	out->message = commit->buffer;
-	if (strcmp(encoding, git_commit_encoding))
-		out->reencoded_message = reencode_string(commit->buffer,
-					git_commit_encoding, encoding);
-	if (out->reencoded_message)
-		out->message = out->reencoded_message;
-
-	abbrev = find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV);
-	abbrev_len = strlen(abbrev);
-
-	subject_len = find_commit_subject(out->message, &subject);
-
-	out->parent_label = xmalloc(strlen("parent of ") + abbrev_len +
-			      strlen("... ") + subject_len + 1);
-	q = out->parent_label;
-	q = mempcpy(q, "parent of ", strlen("parent of "));
-	out->label = q;
-	q = mempcpy(q, abbrev, abbrev_len);
-	q = mempcpy(q, "... ", strlen("... "));
-	out->subject = q;
-	q = mempcpy(q, subject, subject_len);
-	*q = '\0';
-	return 0;
-}
-
 static void free_message(struct commit_message *msg)
 {
 	free(msg->parent_label);
 	free(msg->reencoded_message);
 }
 
-static char *get_encoding(const char *message)
-{
-	const char *p = message, *eol;
-
-	while (*p && *p != '\n') {
-		for (eol = p + 1; *eol && *eol != '\n'; eol++)
-			; /* do nothing */
-		if (!prefixcmp(p, "encoding ")) {
-			char *result = xmalloc(eol - 8 - p);
-			strlcpy(result, p + 9, eol - 8 - p);
-			return result;
-		}
-		p = eol;
-		if (*p == '\n')
-			p++;
-	}
-	return NULL;
-}
-
 static void write_cherry_pick_head(struct commit *commit)
 {
 	int fd;
@@ -494,7 +423,7 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 		return error(_("%s: cannot parse parent commit %s"),
 			action_name(opts), sha1_to_hex(parent->object.sha1));
 
-	if (get_message(commit, &msg) != 0)
+	if (get_commit_message(commit, &msg) != 0)
 		return error(_("Cannot get commit message for %s"),
 			sha1_to_hex(commit->object.sha1));
 
@@ -622,175 +551,6 @@ static void read_and_refresh_cache(struct replay_opts *opts)
 	rollback_lock_file(&index_lock);
 }
 
-/*
- * Append a commit to the end of the commit_list.
- *
- * next starts by pointing to the variable that holds the head of an
- * empty commit_list, and is updated to point to the "next" field of
- * the last item on the list as new commits are appended.
- *
- * Usage example:
- *
- *     struct commit_list *list;
- *     struct commit_list **next = &list;
- *
- *     next = commit_list_append(c1, next);
- *     next = commit_list_append(c2, next);
- *     assert(commit_list_count(list) == 2);
- *     return list;
- */
-struct replay_insn_list **replay_insn_list_append(enum replay_action action,
-						struct commit *operand,
-						struct replay_insn_list **next)
-{
-	struct replay_insn_list *new = xmalloc(sizeof(struct replay_insn_list));
-	new->action = action;
-	new->operand = operand;
-	*next = new;
-	new->next = NULL;
-	return &new->next;
-}
-
-static int format_todo(struct strbuf *buf, struct replay_insn_list *todo_list)
-{
-	struct replay_insn_list *cur = NULL;
-	struct commit_message msg = { NULL, NULL, NULL, NULL, NULL };
-	const char *sha1_abbrev = NULL;
-	const char *action_str;
-
-	for (cur = todo_list; cur; cur = cur->next) {
-		action_str = cur->action == REPLAY_REVERT ? "revert" : "pick";
-
-		sha1_abbrev = find_unique_abbrev(cur->operand->object.sha1, DEFAULT_ABBREV);
-		if (get_message(cur->operand, &msg))
-			return error(_("Cannot get commit message for %s"), sha1_abbrev);
-		strbuf_addf(buf, "%s %s %s\n", action_str, sha1_abbrev, msg.subject);
-	}
-	return 0;
-}
-
-static int parse_insn_line(char *start, enum replay_action *action,
-			struct commit **operand)
-{
-	unsigned char commit_sha1[20];
-	char sha1_abbrev[40];
-	int keyword_len;
-	char *p, *q;
-
-	if (!prefixcmp(start, "pick ")) {
-		*action = REPLAY_PICK;
-		keyword_len = strlen("pick");
-		p = start + keyword_len + 1;
-	} else if (!prefixcmp(start, "revert ")) {
-		*action = REPLAY_REVERT;
-		keyword_len = strlen("revert");
-		p = start + keyword_len + 1;
-	} else
-		return -1;
-
-	q = strchr(p, ' ');
-	if (!q)
-		return -1;
-	q++;
-
-	strlcpy(sha1_abbrev, p, q - p);
-
-	if (get_sha1(sha1_abbrev, commit_sha1) < 0)
-		return -1;
-
-	*operand = lookup_commit_reference(commit_sha1);
-	if (!*operand)
-		return -1;
-
-	return 0;
-}
-
-static int parse_insn_buffer(char *buf, struct replay_insn_list **todo_list)
-{
-	struct replay_insn_list **next = todo_list;
-	enum replay_action action;
-	struct commit *operand;
-	char *p = buf;
-	int i;
-
-	for (i = 1; *p; i++) {
-		if (parse_insn_line(p, &action, &operand) < 0)
-			return error(_("Could not parse line %d."), i);
-		next = replay_insn_list_append(action, operand, next);
-		p = strchrnul(p, '\n');
-		if (*p)
-			p++;
-	}
-	if (!*todo_list)
-		return error(_("No commits parsed."));
-	return 0;
-}
-
-static void read_populate_todo(struct replay_insn_list **todo_list)
-{
-	const char *todo_file = git_path(SEQ_TODO_FILE);
-	struct strbuf buf = STRBUF_INIT;
-	int fd, res;
-
-	fd = open(todo_file, O_RDONLY);
-	if (fd < 0)
-		die_errno(_("Could not open %s."), todo_file);
-	if (strbuf_read(&buf, fd, 0) < 0) {
-		close(fd);
-		strbuf_release(&buf);
-		die(_("Could not read %s."), todo_file);
-	}
-	close(fd);
-
-	res = parse_insn_buffer(buf.buf, todo_list);
-	strbuf_release(&buf);
-	if (res)
-		die(_("Unusable instruction sheet: %s"), todo_file);
-}
-
-static int populate_opts_cb(const char *key, const char *value, void *data)
-{
-	struct replay_opts *opts = data;
-	int error_flag = 1;
-
-	if (!value)
-		error_flag = 0;
-	else if (!strcmp(key, "options.no-commit"))
-		opts->no_commit = git_config_bool_or_int(key, value, &error_flag);
-	else if (!strcmp(key, "options.edit"))
-		opts->edit = git_config_bool_or_int(key, value, &error_flag);
-	else if (!strcmp(key, "options.signoff"))
-		opts->signoff = git_config_bool_or_int(key, value, &error_flag);
-	else if (!strcmp(key, "options.record-origin"))
-		opts->record_origin = git_config_bool_or_int(key, value, &error_flag);
-	else if (!strcmp(key, "options.allow-ff"))
-		opts->allow_ff = git_config_bool_or_int(key, value, &error_flag);
-	else if (!strcmp(key, "options.mainline"))
-		opts->mainline = git_config_int(key, value);
-	else if (!strcmp(key, "options.strategy"))
-		git_config_string(&opts->strategy, key, value);
-	else if (!strcmp(key, "options.strategy-option")) {
-		ALLOC_GROW(opts->xopts, opts->xopts_nr + 1, opts->xopts_alloc);
-		opts->xopts[opts->xopts_nr++] = xstrdup(value);
-	} else
-		return error(_("Invalid key: %s"), key);
-
-	if (!error_flag)
-		return error(_("Invalid value for %s: %s"), key, value);
-
-	return 0;
-}
-
-static void read_populate_opts(struct replay_opts **opts_ptr)
-{
-	const char *opts_file = git_path(SEQ_OPTS_FILE);
-
-	if (!file_exists(opts_file))
-		return;
-	if (git_config_from_file(populate_opts_cb, opts_file, *opts_ptr) < 0)
-		die(_("Malformed options sheet: %s"), opts_file);
-}
-
 static void walk_revs_populate_todo(struct replay_insn_list **todo_list,
 				struct replay_opts *opts)
 {
@@ -805,84 +565,6 @@ static void walk_revs_populate_todo(struct replay_insn_list **todo_list,
 		next = replay_insn_list_append(opts->action, operand, next);
 }
 
-static int create_seq_dir(void)
-{
-	const char *seq_dir = git_path(SEQ_DIR);
-
-	if (file_exists(seq_dir))
-		return error(_("%s already exists."), seq_dir);
-	else if (mkdir(seq_dir, 0777) < 0)
-		die_errno(_("Could not create sequencer directory '%s'."), seq_dir);
-	return 0;
-}
-
-static void save_head(const char *head)
-{
-	const char *head_file = git_path(SEQ_HEAD_FILE);
-	static struct lock_file head_lock;
-	struct strbuf buf = STRBUF_INIT;
-	int fd;
-
-	fd = hold_lock_file_for_update(&head_lock, head_file, LOCK_DIE_ON_ERROR);
-	strbuf_addf(&buf, "%s\n", head);
-	if (write_in_full(fd, buf.buf, buf.len) < 0)
-		die_errno(_("Could not write to %s."), head_file);
-	if (commit_lock_file(&head_lock) < 0)
-		die(_("Error wrapping up %s."), head_file);
-}
-
-static void save_todo(struct replay_insn_list *todo_list)
-{
-	const char *todo_file = git_path(SEQ_TODO_FILE);
-	static struct lock_file todo_lock;
-	struct strbuf buf = STRBUF_INIT;
-	int fd;
-
-	fd = hold_lock_file_for_update(&todo_lock, todo_file, LOCK_DIE_ON_ERROR);
-	if (format_todo(&buf, todo_list) < 0)
-		die(_("Could not format %s."), todo_file);
-	if (write_in_full(fd, buf.buf, buf.len) < 0) {
-		strbuf_release(&buf);
-		die_errno(_("Could not write to %s."), todo_file);
-	}
-	if (commit_lock_file(&todo_lock) < 0) {
-		strbuf_release(&buf);
-		die(_("Error wrapping up %s."), todo_file);
-	}
-	strbuf_release(&buf);
-}
-
-static void save_opts(struct replay_opts *opts)
-{
-	const char *opts_file = git_path(SEQ_OPTS_FILE);
-
-	if (opts->no_commit)
-		git_config_set_in_file(opts_file, "options.no-commit", "true");
-	if (opts->edit)
-		git_config_set_in_file(opts_file, "options.edit", "true");
-	if (opts->signoff)
-		git_config_set_in_file(opts_file, "options.signoff", "true");
-	if (opts->record_origin)
-		git_config_set_in_file(opts_file, "options.record-origin", "true");
-	if (opts->allow_ff)
-		git_config_set_in_file(opts_file, "options.allow-ff", "true");
-	if (opts->mainline) {
-		struct strbuf buf = STRBUF_INIT;
-		strbuf_addf(&buf, "%d", opts->mainline);
-		git_config_set_in_file(opts_file, "options.mainline", buf.buf);
-		strbuf_release(&buf);
-	}
-	if (opts->strategy)
-		git_config_set_in_file(opts_file, "options.strategy", opts->strategy);
-	if (opts->xopts) {
-		int i;
-		for (i = 0; i < opts->xopts_nr; i++)
-			git_config_set_multivar_in_file(opts_file,
-							"options.strategy-option",
-							opts->xopts[i], "^$", 0);
-	}
-}
-
 static int pick_commits(struct replay_insn_list *todo_list,
 			struct replay_opts *opts)
 {
@@ -896,7 +578,7 @@ static int pick_commits(struct replay_insn_list *todo_list,
 	read_and_refresh_cache(opts);
 
 	for (cur = todo_list; cur; cur = cur->next) {
-		save_todo(cur);
+		sequencer_save_todo(cur);
 		opts->action = cur->action;
 		res = do_pick_commit(cur->operand, opts);
 		if (res) {
@@ -939,8 +621,8 @@ static int pick_revisions(struct replay_opts *opts)
 	} else if (opts->subcommand == REPLAY_CONTINUE) {
 		if (!file_exists(git_path(SEQ_TODO_FILE)))
 			goto error;
-		read_populate_opts(&opts);
-		read_populate_todo(&todo_list);
+		sequencer_read_opts(&opts);
+		sequencer_read_todo(&todo_list);
 
 		/* Verify that the conflict has been resolved */
 		if (!index_differs_from("HEAD", 0))
@@ -953,7 +635,7 @@ static int pick_revisions(struct replay_opts *opts)
 		 */
 
 		walk_revs_populate_todo(&todo_list, opts);
-		if (create_seq_dir() < 0) {
+		if (sequencer_create_dir() < 0) {
 			error(_("A cherry-pick or revert is in progress."));
 			advise(_("Use --continue to continue the operation"));
 			advise(_("or --reset to forget about it"));
@@ -964,8 +646,8 @@ static int pick_revisions(struct replay_opts *opts)
 				return error(_("Can't revert as initial commit"));
 			return error(_("Can't cherry-pick into empty head"));
 		}
-		save_head(sha1_to_hex(sha1));
-		save_opts(opts);
+		sequencer_save_head(sha1_to_hex(sha1));
+		sequencer_save_opts(opts);
 	}
 	return pick_commits(todo_list, opts);
 error:
diff --git a/sequencer.c b/sequencer.c
index bc2c046..2993846 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2,6 +2,8 @@
 #include "sequencer.h"
 #include "strbuf.h"
 #include "dir.h"
+#include "commit.h"
+#include "utf8.h"
 
 void remove_sequencer_state(int aggressive)
 {
@@ -17,3 +19,310 @@ void remove_sequencer_state(int aggressive)
 	strbuf_release(&seq_dir);
 	strbuf_release(&seq_old_dir);
 }
+
+/*
+ * Append a commit to the end of the commit_list.
+ *
+ * next starts by pointing to the variable that holds the head of an
+ * empty commit_list, and is updated to point to the "next" field of
+ * the last item on the list as new commits are appended.
+ *
+ * Usage example:
+ *
+ *     struct commit_list *list;
+ *     struct commit_list **next = &list;
+ *
+ *     next = commit_list_append(c1, next);
+ *     next = commit_list_append(c2, next);
+ *     assert(commit_list_count(list) == 2);
+ *     return list;
+ */
+struct replay_insn_list **replay_insn_list_append(enum replay_action action,
+						struct commit *operand,
+						struct replay_insn_list **next)
+{
+	struct replay_insn_list *new = xmalloc(sizeof(struct replay_insn_list));
+	new->action = action;
+	new->operand = operand;
+	*next = new;
+	new->next = NULL;
+	return &new->next;
+}
+
+static int parse_insn_line(char *start, enum replay_action *action,
+			struct commit **operand)
+{
+	unsigned char commit_sha1[20];
+	char sha1_abbrev[40];
+	int keyword_len;
+	char *p, *q;
+
+	if (!prefixcmp(start, "pick ")) {
+		*action = REPLAY_PICK;
+		keyword_len = strlen("pick");
+		p = start + keyword_len + 1;
+	} else if (!prefixcmp(start, "revert ")) {
+		*action = REPLAY_REVERT;
+		keyword_len = strlen("revert");
+		p = start + keyword_len + 1;
+	} else
+		return -1;
+
+	q = strchr(p, ' ');
+	if (!q)
+		return -1;
+	q++;
+
+	strlcpy(sha1_abbrev, p, q - p);
+
+	if (get_sha1(sha1_abbrev, commit_sha1) < 0)
+		return -1;
+
+	*operand = lookup_commit_reference(commit_sha1);
+	if (!*operand)
+		return -1;
+
+	return 0;
+}
+
+static int parse_insn_buffer(char *buf, struct replay_insn_list **todo_list)
+{
+	struct replay_insn_list **next = todo_list;
+	enum replay_action action;
+	struct commit *operand;
+	char *p = buf;
+	int i;
+
+	for (i = 1; *p; i++) {
+		if (parse_insn_line(p, &action, &operand) < 0)
+			return error(_("Could not parse line %d."), i);
+		next = replay_insn_list_append(action, operand, next);
+		p = strchrnul(p, '\n');
+		if (*p)
+			p++;
+	}
+	if (!*todo_list)
+		return error(_("No commits parsed."));
+	return 0;
+}
+
+void sequencer_read_todo(struct replay_insn_list **todo_list)
+{
+	const char *todo_file = git_path(SEQ_TODO_FILE);
+	struct strbuf buf = STRBUF_INIT;
+	int fd, res;
+
+	fd = open(todo_file, O_RDONLY);
+	if (fd < 0)
+		die_errno(_("Could not open %s."), todo_file);
+	if (strbuf_read(&buf, fd, 0) < 0) {
+		close(fd);
+		strbuf_release(&buf);
+		die(_("Could not read %s."), todo_file);
+	}
+	close(fd);
+
+	res = parse_insn_buffer(buf.buf, todo_list);
+	strbuf_release(&buf);
+	if (res)
+		die(_("Unusable instruction sheet: %s"), todo_file);
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
+static char *get_encoding(const char *message)
+{
+	const char *p = message, *eol;
+
+	while (*p && *p != '\n') {
+		for (eol = p + 1; *eol && *eol != '\n'; eol++)
+			; /* do nothing */
+		if (!prefixcmp(p, "encoding ")) {
+			char *result = xmalloc(eol - 8 - p);
+			strlcpy(result, p + 9, eol - 8 - p);
+			return result;
+		}
+		p = eol;
+		if (*p == '\n')
+			p++;
+	}
+	return NULL;
+}
+
+int get_commit_message(struct commit *commit, struct commit_message *out)
+{
+	const char *encoding;
+	const char *abbrev, *subject;
+	int abbrev_len, subject_len;
+	char *q;
+
+	if (!commit->buffer)
+		return -1;
+	encoding = get_encoding(commit->buffer);
+	if (!encoding)
+		encoding = "UTF-8";
+	if (!git_commit_encoding)
+		git_commit_encoding = "UTF-8";
+
+	out->reencoded_message = NULL;
+	out->message = commit->buffer;
+	if (strcmp(encoding, git_commit_encoding))
+		out->reencoded_message = reencode_string(commit->buffer,
+					git_commit_encoding, encoding);
+	if (out->reencoded_message)
+		out->message = out->reencoded_message;
+
+	abbrev = find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV);
+	abbrev_len = strlen(abbrev);
+
+	subject_len = find_commit_subject(out->message, &subject);
+
+	out->parent_label = xmalloc(strlen("parent of ") + abbrev_len +
+			      strlen("... ") + subject_len + 1);
+	q = out->parent_label;
+	q = mempcpy(q, "parent of ", strlen("parent of "));
+	out->label = q;
+	q = mempcpy(q, abbrev, abbrev_len);
+	q = mempcpy(q, "... ", strlen("... "));
+	out->subject = q;
+	q = mempcpy(q, subject, subject_len);
+	*q = '\0';
+	return 0;
+}
+
+void sequencer_read_opts(struct replay_opts **opts_ptr)
+{
+	const char *opts_file = git_path(SEQ_OPTS_FILE);
+
+	if (!file_exists(opts_file))
+		return;
+	if (git_config_from_file(populate_opts_cb, opts_file, *opts_ptr) < 0)
+		die(_("Malformed options sheet: %s"), opts_file);
+}
+
+static int format_todo(struct strbuf *buf, struct replay_insn_list *todo_list)
+{
+	struct replay_insn_list *cur = NULL;
+	struct commit_message msg = { NULL, NULL, NULL, NULL, NULL };
+	const char *sha1_abbrev = NULL;
+	const char *action_str;
+
+	for (cur = todo_list; cur; cur = cur->next) {
+		action_str = cur->action == REPLAY_REVERT ? "revert" : "pick";
+
+		sha1_abbrev = find_unique_abbrev(cur->operand->object.sha1, DEFAULT_ABBREV);
+		if (get_commit_message(cur->operand, &msg))
+			return error(_("Cannot get commit message for %s"), sha1_abbrev);
+		strbuf_addf(buf, "%s %s %s\n", action_str, sha1_abbrev, msg.subject);
+	}
+	return 0;
+}
+
+int sequencer_create_dir(void)
+{
+	const char *seq_dir = git_path(SEQ_DIR);
+
+	if (file_exists(seq_dir))
+		return error(_("%s already exists."), seq_dir);
+	else if (mkdir(seq_dir, 0777) < 0)
+		die_errno(_("Could not create sequencer directory '%s'."), seq_dir);
+	return 0;
+}
+
+void sequencer_save_head(const char *head)
+{
+	const char *head_file = git_path(SEQ_HEAD_FILE);
+	static struct lock_file head_lock;
+	struct strbuf buf = STRBUF_INIT;
+	int fd;
+
+	fd = hold_lock_file_for_update(&head_lock, head_file, LOCK_DIE_ON_ERROR);
+	strbuf_addf(&buf, "%s\n", head);
+	if (write_in_full(fd, buf.buf, buf.len) < 0)
+		die_errno(_("Could not write to %s."), head_file);
+	if (commit_lock_file(&head_lock) < 0)
+		die(_("Error wrapping up %s."), head_file);
+}
+
+void sequencer_save_todo(struct replay_insn_list *todo_list)
+{
+	const char *todo_file = git_path(SEQ_TODO_FILE);
+	static struct lock_file todo_lock;
+	struct strbuf buf = STRBUF_INIT;
+	int fd;
+
+	fd = hold_lock_file_for_update(&todo_lock, todo_file, LOCK_DIE_ON_ERROR);
+	if (format_todo(&buf, todo_list) < 0)
+		die(_("Could not format %s."), todo_file);
+	if (write_in_full(fd, buf.buf, buf.len) < 0) {
+		strbuf_release(&buf);
+		die_errno(_("Could not write to %s."), todo_file);
+	}
+	if (commit_lock_file(&todo_lock) < 0) {
+		strbuf_release(&buf);
+		die(_("Error wrapping up %s."), todo_file);
+	}
+	strbuf_release(&buf);
+}
+
+void sequencer_save_opts(struct replay_opts *opts)
+{
+	const char *opts_file = git_path(SEQ_OPTS_FILE);
+
+	if (opts->no_commit)
+		git_config_set_in_file(opts_file, "options.no-commit", "true");
+	if (opts->edit)
+		git_config_set_in_file(opts_file, "options.edit", "true");
+	if (opts->signoff)
+		git_config_set_in_file(opts_file, "options.signoff", "true");
+	if (opts->record_origin)
+		git_config_set_in_file(opts_file, "options.record-origin", "true");
+	if (opts->allow_ff)
+		git_config_set_in_file(opts_file, "options.allow-ff", "true");
+	if (opts->mainline) {
+		struct strbuf buf = STRBUF_INIT;
+		strbuf_addf(&buf, "%d", opts->mainline);
+		git_config_set_in_file(opts_file, "options.mainline", buf.buf);
+		strbuf_release(&buf);
+	}
+	if (opts->strategy)
+		git_config_set_in_file(opts_file, "options.strategy", opts->strategy);
+	if (opts->xopts) {
+		int i;
+		for (i = 0; i < opts->xopts_nr; i++)
+			git_config_set_multivar_in_file(opts_file,
+							"options.strategy-option",
+							opts->xopts[i], "^$", 0);
+	}
+}
diff --git a/sequencer.h b/sequencer.h
index 01caa8a..a5b951d 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -38,6 +38,17 @@ struct replay_insn_list {
 	struct replay_insn_list *next;
 };
 
+/* Unrelated commit_message helper */
+struct commit_message {
+	char *parent_label;
+	const char *label;
+	const char *subject;
+	char *reencoded_message;
+	const char *message;
+};
+
+int get_commit_message(struct commit *commit, struct commit_message *out);
+
 /*
  * Removes SEQ_OLD_DIR and renames SEQ_DIR to SEQ_OLD_DIR, ignoring
  * any errors.  Intended to be used by 'git reset'.
@@ -48,4 +59,14 @@ struct replay_insn_list {
  */
 void remove_sequencer_state(int aggressive);
 
+struct replay_insn_list **replay_insn_list_append(enum replay_action action,
+						struct commit *operand,
+						struct replay_insn_list **next);
+void sequencer_read_todo(struct replay_insn_list **todo_list);
+void sequencer_read_opts(struct replay_opts **opts_ptr);
+int sequencer_create_dir(void);
+void sequencer_save_head(const char *head);
+void sequencer_save_todo(struct replay_insn_list *todo_list);
+void sequencer_save_opts(struct replay_opts *opts);
+
 #endif
-- 
1.7.6.351.gb35ac.dirty
