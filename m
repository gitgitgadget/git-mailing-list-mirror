Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DAA6206A4
	for <e@80x24.org>; Tue, 13 Dec 2016 15:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934183AbcLMPcH (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 10:32:07 -0500
Received: from mout.gmx.net ([212.227.17.22]:55225 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933787AbcLMPbq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 10:31:46 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LgeFd-1cvx3m0THZ-00nwzV; Tue, 13
 Dec 2016 16:30:03 +0100
Date:   Tue, 13 Dec 2016 16:30:01 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: [PATCH v2 07/34] sequencer (rebase -i): add support for the 'fixup'
 and 'squash' commands
In-Reply-To: <cover.1481642927.git.johannes.schindelin@gmx.de>
Message-ID: <ae521f75a105c6b9e54595d68bda3c5b62f313b6.1481642927.git.johannes.schindelin@gmx.de>
References: <cover.1472633606.git.johannes.schindelin@gmx.de> <cover.1481642927.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:utylXX/eLcWlt9jzKmj66whfo2fGg1qeTE8Akb/Xv8Vwboq0s88
 FR6pgT37WgNE6O901W/+b0ej9GvSiJfH22IUEDnPqfKKtcKfpWagL1wTQUJsAJYJIVIVJz/
 NNQpkVadYPkXZYIfPNkt692H1w6z5xDsMEdgHouvsjEiwS4y4Ffvbi9o/oVtUXMVhQJK3Kb
 SrHB10P+Ub94Cck8ij5jQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:eLHeP6r/SXM=:oOWbNA/SXEXAc0oWjBEuv1
 DCl0hAQ9i+bo32+WcCTYYdtrlGrSP9Dof1BDQrkvBOpHProGk44c5Ma3XqWE799wqoeVpEdyh
 MCsBykSnDx/HUIdF+DCgkrr2fJvtzRjRyP59zE9507GOaJRTboaqZQBxLBLLNQm6ZWG5wSbWE
 i6Q6hzMuSEfK2XenHRRuUWs9tKMn8aRgqtgWU12JWsJZDqqygOMI6o0tMkK2UrLgjSfzA4/ms
 QDjtbA6K002SzBtRR7FzT0WoGiY3ufL0ZZ/GB26ipAJxfofI8W+dtg2RcKqxI5x00zPJ/2/aW
 hc9ktKmNFnuuALSHZMPPz2D8fK75MjL2XDzUNRUpaRpptNxRmGcU6/ntKT7TS1wHK8Cu9f711
 q94EEIZqfDHW5w9xFdGwlSXiN0+dwQ1AgeW22AF4w+RL8D3/vaJibD4LFrTBG9PFZe1hmu7OO
 8wd26l39OcS43+hyXoqKy0yTHBVqZafIcmOuK2qBHd6msYUeJB0No+E2L0Z7oyp9aRBqyvdeC
 7I1O0DdLu/eh7vIFIy6O9+LOc/MQ4dHRof0WONxDn49378KKb1otLeeeBER0fN+aIAGdnrDNq
 FsdDZnOIwVT0v9RCab1rSsojnmshc+Us927uC/49R7F1X6jGRVovjGV8gvcVJghjRBuMQrTth
 EW9QkFRnEkRxvh4yL+N1lVpzvgA0CU1+rB+Bq8hxIg0OSbsq7+iGKBF9UMLNcVyFubTymqq4H
 AdSZG3BLTKWeawuV4ozgt5MgzpxzUpSc98j+AywMRP6Jms5A2UlQMz8bvqI7mkhu7okIHUDM1
 tpg8Ald
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a huge patch, and at the same time a huge step forward to
execute the performance-critical parts of the interactive rebase in a
builtin command.

Since 'fixup' and 'squash' are not only similar, but also need to know
about each other (we want to reduce a series of fixups/squashes into a
single, final commit message edit, from the user's point of view), we
really have to implement them both at the same time.

Most of the actual work is done by the existing code path that already
handles the "pick" and the "edit" commands; We added support for other
features (e.g. to amend the commit message) in the patches leading up to
this one, yet there are still quite a few bits in this patch that simply
would not make sense as individual patches (such as: determining whether
there was anything to "fix up" in the "todo" script, etc).

In theory, it would be possible to reuse the fast-forward code path also
for the fixup and the squash code paths, but in practice this would make
the code less readable. The end result cannot be fast-forwarded anyway,
therefore let's just extend the cherry-picking code path for now.

Since the sequencer parses the entire `git-rebase-todo` script in one go,
fixup or squash commands without a preceding pick can be reported early
(in git-rebase--interactive, we could only report such errors just before
executing the fixup/squash).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 232 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 222 insertions(+), 10 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index f6e20b142a..271c21581d 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -45,6 +45,35 @@ static GIT_PATH_FUNC(rebase_path_todo, "rebase-merge/git-rebase-todo")
  */
 static GIT_PATH_FUNC(rebase_path_done, "rebase-merge/done")
 /*
+ * The commit message that is planned to be used for any changes that
+ * need to be committed following a user interaction.
+ */
+static GIT_PATH_FUNC(rebase_path_message, "rebase-merge/message")
+/*
+ * The file into which is accumulated the suggested commit message for
+ * squash/fixup commands. When the first of a series of squash/fixups
+ * is seen, the file is created and the commit message from the
+ * previous commit and from the first squash/fixup commit are written
+ * to it. The commit message for each subsequent squash/fixup commit
+ * is appended to the file as it is processed.
+ *
+ * The first line of the file is of the form
+ *     # This is a combination of $count commits.
+ * where $count is the number of commits whose messages have been
+ * written to the file so far (including the initial "pick" commit).
+ * Each time that a commit message is processed, this line is read and
+ * updated. It is deleted just before the combined commit is made.
+ */
+static GIT_PATH_FUNC(rebase_path_squash_msg, "rebase-merge/message-squash")
+/*
+ * If the current series of squash/fixups has not yet included a squash
+ * command, then this file exists and holds the commit message of the
+ * original "pick" commit.  (If the series ends without a "squash"
+ * command, then this can be used as the commit message of the combined
+ * commit without opening the editor.)
+ */
+static GIT_PATH_FUNC(rebase_path_fixup_msg, "rebase-merge/message-fixup")
+/*
  * A script to set the GIT_AUTHOR_NAME, GIT_AUTHOR_EMAIL, and
  * GIT_AUTHOR_DATE that will be used for the commit that is currently
  * being rebased.
@@ -673,6 +702,8 @@ enum todo_command {
 	TODO_PICK = 0,
 	TODO_REVERT,
 	TODO_EDIT,
+	TODO_FIXUP,
+	TODO_SQUASH,
 	/* commands that do something else than handling a single commit */
 	TODO_EXEC,
 	/* commands that do nothing but are counted for reporting progress */
@@ -683,6 +714,8 @@ static const char *todo_command_strings[] = {
 	"pick",
 	"revert",
 	"edit",
+	"fixup",
+	"squash",
 	"exec",
 	"noop"
 };
@@ -694,16 +727,119 @@ static const char *command_to_string(const enum todo_command command)
 	die("Unknown command: %d", command);
 }
 
+static int is_fixup(enum todo_command command)
+{
+	return command == TODO_FIXUP || command == TODO_SQUASH;
+}
+
+static int update_squash_messages(enum todo_command command,
+		struct commit *commit, struct replay_opts *opts)
+{
+	struct strbuf buf = STRBUF_INIT;
+	int count, res;
+	const char *message, *body;
+
+	if (file_exists(rebase_path_squash_msg())) {
+		char *p, *p2;
+
+		if (strbuf_read_file(&buf, rebase_path_squash_msg(), 2048) <= 0)
+			return error(_("could not read '%s'"),
+				rebase_path_squash_msg());
+
+		if (buf.buf[0] != comment_line_char ||
+		    !skip_prefix(buf.buf + 1, " This is a combination of ",
+				 (const char **)&p))
+			return error(_("unexpected 1st line of squash message:"
+				       "\n\n\t%.*s"),
+				     (int)(strchrnul(buf.buf, '\n') - buf.buf),
+				     buf.buf);
+		count = strtol(p, &p2, 10);
+
+		if (count < 1 || *p2 != ' ')
+			return error(_("invalid 1st line of squash message:\n"
+				       "\n\t%.*s"),
+				     (int)(strchrnul(buf.buf, '\n') - buf.buf),
+				     buf.buf);
+
+		sprintf((char *)p, "%d", ++count);
+		if (!*p2)
+			*p2 = ' ';
+		else {
+			*(++p2) = 'c';
+			strbuf_insert(&buf, p2 - buf.buf, " ", 1);
+		}
+	}
+	else {
+		unsigned char head[20];
+		struct commit *head_commit;
+		const char *head_message, *body;
+
+		if (get_sha1("HEAD", head))
+			return error(_("need a HEAD to fixup"));
+		if (!(head_commit = lookup_commit_reference(head)))
+			return error(_("could not read HEAD"));
+		if (!(head_message = get_commit_buffer(head_commit, NULL)))
+			return error(_("could not read HEAD's commit message"));
+
+		body = strstr(head_message, "\n\n");
+		if (!body)
+			body = "";
+		else
+			body = skip_blank_lines(body + 2);
+		if (write_message(body, strlen(body),
+				  rebase_path_fixup_msg(), 0))
+			return error(_("cannot write '%s'"),
+				     rebase_path_fixup_msg());
+
+		count = 2;
+		strbuf_addf(&buf, _("%c This is a combination of 2 commits.\n"
+				    "%c The first commit's message is:\n\n%s"),
+			    comment_line_char, comment_line_char, body);
+
+		unuse_commit_buffer(head_commit, head_message);
+	}
+
+	if (!(message = get_commit_buffer(commit, NULL)))
+		return error(_("could not read commit message of %s"),
+			     oid_to_hex(&commit->object.oid));
+	body = strstr(message, "\n\n");
+	if (!body)
+		body = "";
+	else
+		body = skip_blank_lines(body + 2);
+
+	if (command == TODO_SQUASH) {
+		unlink(rebase_path_fixup_msg());
+		strbuf_addf(&buf, _("\n%c This is the commit message #%d:\n"
+				    "\n%s"),
+			    comment_line_char, count, body);
+	}
+	else if (command == TODO_FIXUP) {
+		strbuf_addf(&buf, _("\n%c The commit message #%d "
+				    "will be skipped:\n\n"),
+			    comment_line_char, count);
+		strbuf_add_commented_lines(&buf, body, strlen(body));
+	}
+	else
+		return error(_("unknown command: %d"), command);
+	unuse_commit_buffer(commit, message);
+
+	res = write_message(buf.buf, buf.len, rebase_path_squash_msg(), 0);
+	strbuf_release(&buf);
+	return res;
+}
 
 static int do_pick_commit(enum todo_command command, struct commit *commit,
-		struct replay_opts *opts)
+		struct replay_opts *opts, int final_fixup)
 {
+	int edit = opts->edit, cleanup_commit_message = 0;
+	const char *msg_file = edit ? NULL : git_path_merge_msg();
 	unsigned char head[20];
 	struct commit *base, *next, *parent;
 	const char *base_label, *next_label;
 	struct commit_message msg = { NULL, NULL, NULL, NULL };
 	struct strbuf msgbuf = STRBUF_INIT;
-	int res, unborn = 0, allow;
+	int res, unborn = 0, amend = 0, allow;
 
 	if (opts->no_commit) {
 		/*
@@ -749,7 +885,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 	else
 		parent = commit->parents->item;
 
-	if (opts->allow_ff &&
+	if (opts->allow_ff && !is_fixup(command) &&
 	    ((parent && !hashcmp(parent->object.oid.hash, head)) ||
 	     (!parent && unborn)))
 		return fast_forward_to(commit->object.oid.hash, head, unborn, opts);
@@ -813,6 +949,28 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 		}
 	}
 
+	if (is_fixup(command)) {
+		if (update_squash_messages(command, commit, opts))
+			return -1;
+		amend = 1;
+		if (!final_fixup)
+			msg_file = rebase_path_squash_msg();
+		else if (file_exists(rebase_path_fixup_msg())) {
+			cleanup_commit_message = 1;
+			msg_file = rebase_path_fixup_msg();
+		}
+		else {
+			const char *dest = git_path("SQUASH_MSG");
+			unlink(dest);
+			if (copy_file(dest, rebase_path_squash_msg(), 0666))
+				return error(_("could not rename '%s' to '%s'"),
+					     rebase_path_squash_msg(), dest);
+			unlink(git_path("MERGE_MSG"));
+			msg_file = dest;
+			edit = 1;
+		}
+	}
+
 	if (!opts->strategy || !strcmp(opts->strategy, "recursive") || command == TODO_REVERT) {
 		res = do_recursive_merge(base, next, base_label, next_label,
 					 head, &msgbuf, opts);
@@ -868,8 +1026,13 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 		goto leave;
 	}
 	if (!opts->no_commit)
-		res = run_git_commit(opts->edit ? NULL : git_path_merge_msg(),
-				     opts, allow, opts->edit, 0, 0);
+		res = run_git_commit(msg_file, opts, allow, edit, amend,
+				     cleanup_commit_message);
+
+	if (!res && final_fixup) {
+		unlink(rebase_path_fixup_msg());
+		unlink(rebase_path_squash_msg());
+	}
 
 leave:
 	free_message(commit, &msg);
@@ -1009,7 +1172,7 @@ static int parse_insn_buffer(char *buf, struct todo_list *todo_list)
 {
 	struct todo_item *item;
 	char *p = buf, *next_p;
-	int i, res = 0;
+	int i, res = 0, fixup_okay = file_exists(rebase_path_done());
 
 	for (i = 1; *p; i++, p = next_p) {
 		char *eol = strchrnul(p, '\n');
@@ -1024,8 +1187,16 @@ static int parse_insn_buffer(char *buf, struct todo_list *todo_list)
 		if (parse_insn_line(item, p, eol)) {
 			res = error(_("invalid line %d: %.*s"),
 				i, (int)(eol - p), p);
-			item->command = -1;
+			item->command = TODO_NOOP;
 		}
+
+		if (fixup_okay)
+			; /* do nothing */
+		else if (is_fixup(item->command))
+			return error(_("cannot '%s' without a previous commit"),
+				command_to_string(item->command));
+		else if (item->command != TODO_NOOP)
+			fixup_okay = 1;
 	}
 	if (!todo_list->nr)
 		return error(_("no commits parsed."));
@@ -1434,6 +1605,20 @@ static int error_with_patch(struct commit *commit,
 	return exit_code;
 }
 
+static int error_failed_squash(struct commit *commit,
+	struct replay_opts *opts, int subject_len, const char *subject)
+{
+	if (rename(rebase_path_squash_msg(), rebase_path_message()))
+		return error(_("could not rename '%s' to '%s'"),
+			rebase_path_squash_msg(), rebase_path_message());
+	unlink(rebase_path_fixup_msg());
+	unlink(git_path("MERGE_MSG"));
+	if (copy_file(git_path("MERGE_MSG"), rebase_path_message(), 0666))
+		return error(_("could not copy '%s' to '%s'"),
+			     rebase_path_message(), git_path("MERGE_MSG"));
+	return error_with_patch(commit, subject, subject_len, opts, 1, 0);
+}
+
 static int do_exec(const char *command_line)
 {
 	const char *child_argv[] = { NULL, NULL };
@@ -1475,6 +1660,21 @@ static int do_exec(const char *command_line)
 	return status;
 }
 
+static int is_final_fixup(struct todo_list *todo_list)
+{
+	int i = todo_list->current;
+
+	if (!is_fixup(todo_list->items[i].command))
+		return 0;
+
+	while (++i < todo_list->nr)
+		if (is_fixup(todo_list->items[i].command))
+			return 0;
+		else if (todo_list->items[i].command < TODO_NOOP)
+			break;
+	return 1;
+}
+
 static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 {
 	int res = 0;
@@ -1490,9 +1690,15 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 		struct todo_item *item = todo_list->items + todo_list->current;
 		if (save_todo(todo_list, opts))
 			return -1;
-		if (item->command <= TODO_EDIT) {
+		if (is_rebase_i(opts)) {
+			unlink(rebase_path_message());
+			unlink(rebase_path_author_script());
+			unlink(rebase_path_stopped_sha());
+			unlink(rebase_path_amend());
+		}
+		if (item->command <= TODO_SQUASH) {
 			res = do_pick_commit(item->command, item->commit,
-					opts);
+					opts, is_final_fixup(todo_list));
 			if (item->command == TODO_EDIT) {
 				struct commit *commit = item->commit;
 				if (!res)
@@ -1503,6 +1709,12 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 					item->arg, item->arg_len, opts, res,
 					!res);
 			}
+			if (res && is_fixup(item->command)) {
+				if (res == 1)
+					intend_to_amend();
+				return error_failed_squash(item->commit, opts,
+					item->arg_len, item->arg);
+			}
 		}
 		else if (item->command == TODO_EXEC) {
 			char *end_of_arg = (char *)(item->arg + item->arg_len);
@@ -1597,7 +1809,7 @@ static int single_pick(struct commit *cmit, struct replay_opts *opts)
 {
 	setenv(GIT_REFLOG_ACTION, action_name(opts), 0);
 	return do_pick_commit(opts->action == REPLAY_PICK ?
-		TODO_PICK : TODO_REVERT, cmit, opts);
+		TODO_PICK : TODO_REVERT, cmit, opts, 0);
 }
 
 int sequencer_pick_revisions(struct replay_opts *opts)
-- 
2.11.0.rc3.windows.1


