Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CFB41F6C1
	for <e@80x24.org>; Mon, 29 Aug 2016 08:05:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932605AbcH2IFj (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 04:05:39 -0400
Received: from mout.gmx.net ([212.227.15.18]:54243 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756125AbcH2IFh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 04:05:37 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0LcT2M-1bEG9p3wBi-00jtIz; Mon, 29 Aug 2016 10:05:28
 +0200
Date:   Mon, 29 Aug 2016 10:05:13 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 09/22] sequencer: completely revamp the "todo" script
 parsing
In-Reply-To: <cover.1472457609.git.johannes.schindelin@gmx.de>
Message-ID: <163aaa2a64ddf6dfb28c77c821726e14cc78619e.1472457609.git.johannes.schindelin@gmx.de>
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:pqunWov2Fcwg3wHcCrs5X4Yz5CvrbtQ+9Z4NCvTjbQw6nGpqctU
 IOS02VN8dRELA3QWjsRNDFkCuLvsIGlmQnA65mRIinRAYPwNLTThZAyef9jQWqEV/wrMGfB
 iQDVSsYcIP62wynfr2ut0s1FhK2ay7uoYci6EqHXZzPXIsLSSSAEtq1XxLIOu8Szwz5dkal
 tpoBalTrbW+7RuUDSWpzQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:SSrmN8hBLdk=:nopa6zv/Hv4RMOleCU7dHQ
 i9nvYQiBosDteKCP26QTOnSWHat48eM0C8bq4+3uhSVRnKd969uJK48PwJdp/Q9osz8R1QDCr
 E5IVU9mlhj6dUarGuR9fYRYlE55dmusQJSucfg8a+VA3I04XVnqvcX/Tqo5pCJaJ2Lfr3z5mm
 AQiPWeChduVYDynALBkIVb228tqNLVZJvXDOX2kV7rFmhkzlUphgppgURvGOJk51/hYnQxPbm
 OdeQgT75xyKR+czWQzjuMwceJa+u1q67yFLh6qgonBKGLJVokkjnJb8szdeflkUBv08vaZYiC
 8FozPZ9kwb1CB24g9Ty1widREDypKlfwberucscS7j9r7muZzUjqSBjj63azVfezAlpQwtBC/
 tLfo1wQQ44iZ4a4BVtug6lU0WzU1iS68kKL7NnNpnJOfmBIAVDEBwS5Y0DHv4D5uOc0qnKHqO
 sjA1QcEkzfOvXPJvdOn7QxJXxIbI+nv2ALWaVxejzSyjFECLgwZJdtCzen2wH4EqkDnOeRMJv
 QL5874VR0Nkueq/73BzpJahHSrI2Z+ctn8JBSrYtago29in0isv2jgfnUIhMRhtVSu8ciwaT8
 a93fZOqCwuCf/r9gjHyAahv5FeoJgvTKGwKASPlKETRJxQi6dUuW2CguhOVbNkCCd2j4xRbMm
 m1CC/hqr8wcOxQUgzncjXoJDRGr2tcqJpeNlKg9t+PqZA0vqTATIy6tnAoB/VftIo+oOF3Goq
 bZ0KkEulgMAYIHAsGDa+k13lTqG3HXBboUqTEeGHxlzBZoPWLqS1uJIdjk1V6NwKZ+0ACAi7Z
 fALrmxp
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we came up with the "sequencer" idea, we really wanted to have
kind of a plumbing equivalent of the interactive rebase. Hence the
choice of words: the "todo" script, a "pick", etc.

However, when it came time to implement the entire shebang, somehow this
idea got lost and the sequencer was used as working horse for
cherry-pick and revert instead. So as not to interfere with the
interactive rebase, it even uses a separate directory to store its
state.

Furthermore, it also is stupidly strict about the "todo" script it
accepts: while it parses commands in a way that was *designed* to be
similar to the interactive rebase, it then goes on to *error out* if the
commands disagree with the overall action (cherry-pick or revert).

Finally, the sequencer code chose to deviate from the interactive rebase
code insofar that it *reformats* the "todo" script instead of just
writing the part of the parsed script that were not yet processed. This
is not only unnecessary churn, but might well lose information that is
valuable to the user (i.e. comments after the commands).

Let's just bite the bullet and rewrite the entire parser; the code now
becomes not only more elegant: it allows us to go on and teach the
sequencer how to parse *true* "todo" scripts as used by the interactive
rebase itself. In a way, the sequencer is about to grow up to do its
older brother's job. Better.

While at it, do not stop at the first problem, but list *all* of the
problems. This helps the user by allowing to address all issues in
one go rather than going back and forth until the todo list is valid.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 241 +++++++++++++++++++++++++++++++++---------------------------
 1 file changed, 134 insertions(+), 107 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 982b6e9..cbdce6d 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -473,7 +473,26 @@ static int allow_empty(struct replay_opts *opts, struct commit *commit)
 		return 1;
 }
 
-static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
+enum todo_command {
+	TODO_PICK,
+	TODO_REVERT
+};
+
+static const char *todo_command_strings[] = {
+	"pick",
+	"revert"
+};
+
+static const char *command_to_string(const enum todo_command command)
+{
+	if (command < ARRAY_SIZE(todo_command_strings))
+		return todo_command_strings[command];
+	die("Unknown command: %d", command);
+}
+
+
+static int do_pick_commit(enum todo_command command, struct commit *commit,
+		struct replay_opts *opts)
 {
 	unsigned char head[20];
 	struct commit *base, *next, *parent;
@@ -535,7 +554,8 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 		/* TRANSLATORS: The first %s will be "revert" or
 		   "cherry-pick", the second %s a SHA1 */
 		return error(_("%s: cannot parse parent commit %s"),
-			action_name(opts), oid_to_hex(&parent->object.oid));
+			command_to_string(command),
+			oid_to_hex(&parent->object.oid));
 
 	if (get_message(commit, &msg) != 0)
 		return error(_("Cannot get commit message for %s"),
@@ -548,7 +568,7 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 	 * reverse of it if we are revert.
 	 */
 
-	if (opts->action == REPLAY_REVERT) {
+	if (command == TODO_REVERT) {
 		base = commit;
 		base_label = msg.label;
 		next = parent;
@@ -589,7 +609,7 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 		}
 	}
 
-	if (!opts->strategy || !strcmp(opts->strategy, "recursive") || opts->action == REPLAY_REVERT) {
+	if (!opts->strategy || !strcmp(opts->strategy, "recursive") || command == TODO_REVERT) {
 		res = do_recursive_merge(base, next, base_label, next_label,
 					 head, &msgbuf, opts);
 		if (res < 0)
@@ -615,17 +635,17 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 	 * However, if the merge did not even start, then we don't want to
 	 * write it at all.
 	 */
-	if (opts->action == REPLAY_PICK && !opts->no_commit && (res == 0 || res == 1) &&
+	if (command == TODO_PICK && !opts->no_commit && (res == 0 || res == 1) &&
 	    update_ref(NULL, "CHERRY_PICK_HEAD", commit->object.oid.hash, NULL,
 		       REF_NODEREF, UPDATE_REFS_MSG_ON_ERR))
 		res = -1;
-	if (opts->action == REPLAY_REVERT && ((opts->no_commit && res == 0) || res == 1) &&
+	if (command == TODO_REVERT && ((opts->no_commit && res == 0) || res == 1) &&
 	    update_ref(NULL, "REVERT_HEAD", commit->object.oid.hash, NULL,
 		       REF_NODEREF, UPDATE_REFS_MSG_ON_ERR))
 		res = -1;
 
 	if (res) {
-		error(opts->action == REPLAY_REVERT
+		error(command == TODO_REVERT
 		      ? _("could not revert %s... %s")
 		      : _("could not apply %s... %s"),
 		      find_unique_abbrev(commit->object.oid.hash, DEFAULT_ABBREV),
@@ -683,116 +703,107 @@ static int read_and_refresh_cache(struct replay_opts *opts)
 	return 0;
 }
 
-static int format_todo(struct strbuf *buf, struct commit_list *todo_list,
-		struct replay_opts *opts)
+struct todo_item {
+	enum todo_command command;
+	struct commit *commit;
+	size_t offset_in_buf;
+};
+
+struct todo_list {
+	struct strbuf buf;
+	struct todo_item *items;
+	int nr, alloc, current;
+};
+
+#define TODO_LIST_INIT { STRBUF_INIT, NULL, 0, 0, 0 }
+
+static void todo_list_release(struct todo_list *todo_list)
 {
-	struct commit_list *cur = NULL;
-	const char *sha1_abbrev = NULL;
-	const char *action_str = opts->action == REPLAY_REVERT ? "revert" : "pick";
-	const char *subject;
-	int subject_len;
+	strbuf_release(&todo_list->buf);
+	free(todo_list->items);
+	todo_list->items = NULL;
+	todo_list->nr = todo_list->alloc = 0;
+}
 
-	for (cur = todo_list; cur; cur = cur->next) {
-		const char *commit_buffer = get_commit_buffer(cur->item, NULL);
-		sha1_abbrev = find_unique_abbrev(cur->item->object.oid.hash, DEFAULT_ABBREV);
-		subject_len = find_commit_subject(commit_buffer, &subject);
-		strbuf_addf(buf, "%s %s %.*s\n", action_str, sha1_abbrev,
-			subject_len, subject);
-		unuse_commit_buffer(cur->item, commit_buffer);
-	}
-	return 0;
+struct todo_item *append_todo(struct todo_list *todo_list)
+{
+	ALLOC_GROW(todo_list->items, todo_list->nr + 1, todo_list->alloc);
+	return todo_list->items + todo_list->nr++;
 }
 
-static struct commit *parse_insn_line(char *bol, char *eol, struct replay_opts *opts)
+static int parse_insn_line(struct todo_item *item, const char *bol, char *eol)
 {
 	unsigned char commit_sha1[20];
-	enum replay_action action;
 	char *end_of_object_name;
-	int saved, status, padding;
-
-	if (starts_with(bol, "pick")) {
-		action = REPLAY_PICK;
-		bol += strlen("pick");
-	} else if (starts_with(bol, "revert")) {
-		action = REPLAY_REVERT;
-		bol += strlen("revert");
-	} else
-		return NULL;
+	int i, saved, status, padding;
+
+	for (i = 0; i < ARRAY_SIZE(todo_command_strings); i++)
+		if (skip_prefix(bol, todo_command_strings[i], &bol)) {
+			item->command = i;
+			break;
+		}
+	if (i >= ARRAY_SIZE(todo_command_strings))
+		return -1;
 
 	/* Eat up extra spaces/ tabs before object name */
 	padding = strspn(bol, " \t");
 	if (!padding)
-		return NULL;
+		return -1;
 	bol += padding;
 
-	end_of_object_name = bol + strcspn(bol, " \t\n");
+	end_of_object_name = (char *) bol + strcspn(bol, " \t\n");
 	saved = *end_of_object_name;
 	*end_of_object_name = '\0';
 	status = get_sha1(bol, commit_sha1);
 	*end_of_object_name = saved;
 
-	/*
-	 * Verify that the action matches up with the one in
-	 * opts; we don't support arbitrary instructions
-	 */
-	if (action != opts->action) {
-		if (action == REPLAY_REVERT)
-		      error((opts->action == REPLAY_REVERT)
-			    ? _("Cannot revert during another revert.")
-			    : _("Cannot revert during a cherry-pick."));
-		else
-		      error((opts->action == REPLAY_REVERT)
-			    ? _("Cannot cherry-pick during a revert.")
-			    : _("Cannot cherry-pick during another cherry-pick."));
-		return NULL;
-	}
-
 	if (status < 0)
-		return NULL;
+		return -1;
 
-	return lookup_commit_reference(commit_sha1);
+	item->commit = lookup_commit_reference(commit_sha1);
+	return !item->commit;
 }
 
-static int parse_insn_buffer(char *buf, struct commit_list **todo_list,
-			struct replay_opts *opts)
+static int parse_insn_buffer(char *buf, struct todo_list *todo_list)
 {
-	struct commit_list **next = todo_list;
-	struct commit *commit;
+	struct todo_item *item;
 	char *p = buf;
-	int i;
+	int i, res = 0;
 
 	for (i = 1; *p; i++) {
 		char *eol = strchrnul(p, '\n');
-		commit = parse_insn_line(p, eol, opts);
-		if (!commit)
-			return error(_("Could not parse line %d."), i);
-		next = commit_list_append(commit, next);
+
+		item = append_todo(todo_list);
+		item->offset_in_buf = p - todo_list->buf.buf;
+		if (parse_insn_line(item, p, eol)) {
+			error("Invalid line: %.*s", (int)(eol - p), p);
+			res |= error(_("Could not parse line %d."), i);
+			item->command = -1;
+		}
 		p = *eol ? eol + 1 : eol;
 	}
-	if (!*todo_list)
+	if (!todo_list->nr)
 		return error(_("No commits parsed."));
-	return 0;
+	return res;
 }
 
-static int read_populate_todo(struct commit_list **todo_list,
+static int read_populate_todo(struct todo_list *todo_list,
 			struct replay_opts *opts)
 {
 	const char *todo_file = get_todo_path(opts);
-	struct strbuf buf = STRBUF_INIT;
 	int fd, res;
 
+	strbuf_reset(&todo_list->buf);
 	fd = open(todo_file, O_RDONLY);
 	if (fd < 0)
 		return error_errno(_("Could not open %s"), todo_file);
-	if (strbuf_read(&buf, fd, 0) < 0) {
+	if (strbuf_read(&todo_list->buf, fd, 0) < 0) {
 		close(fd);
-		strbuf_release(&buf);
 		return error(_("Could not read %s."), todo_file);
 	}
 	close(fd);
 
-	res = parse_insn_buffer(buf.buf, todo_list, opts);
-	strbuf_release(&buf);
+	res = parse_insn_buffer(todo_list->buf.buf, todo_list);
 	if (res)
 		return error(_("Unusable instruction sheet: %s"), todo_file);
 	return 0;
@@ -848,18 +859,33 @@ static int read_populate_opts(struct replay_opts *opts)
 	return 0;
 }
 
-static int walk_revs_populate_todo(struct commit_list **todo_list,
+static int walk_revs_populate_todo(struct todo_list *todo_list,
 				struct replay_opts *opts)
 {
+	enum todo_command command = opts->action == REPLAY_PICK ?
+		TODO_PICK : TODO_REVERT;
 	struct commit *commit;
-	struct commit_list **next;
 
 	if (prepare_revs(opts))
 		return -1;
 
-	next = todo_list;
-	while ((commit = get_revision(opts->revs)))
-		next = commit_list_append(commit, next);
+	while ((commit = get_revision(opts->revs))) {
+		struct todo_item *item = append_todo(todo_list);
+		const char *commit_buffer = get_commit_buffer(commit, NULL);
+		const char *subject;
+		int subject_len;
+
+		item->command = command;
+		item->commit = commit;
+		item->offset_in_buf = todo_list->buf.len;
+		subject_len = find_commit_subject(commit_buffer, &subject);
+		strbuf_addf(&todo_list->buf, "%s %s %.*s\n",
+			opts->action == REPLAY_PICK ?  "pick" : "revert",
+			find_unique_abbrev(commit->object.oid.hash,
+				DEFAULT_ABBREV),
+			subject_len, subject);
+		unuse_commit_buffer(commit, commit_buffer);
+	}
 	return 0;
 }
 
@@ -964,30 +990,24 @@ static int sequencer_rollback(struct replay_opts *opts)
 	return -1;
 }
 
-static int save_todo(struct commit_list *todo_list, struct replay_opts *opts)
+static int save_todo(struct todo_list *todo_list, struct replay_opts *opts)
 {
 	static struct lock_file todo_lock;
-	struct strbuf buf = STRBUF_INIT;
-	int fd;
+	const char *todo_path = get_todo_path(opts);
+	int next = todo_list->current, offset, fd;
 
-	fd = hold_lock_file_for_update(&todo_lock, git_path_todo_file(), 0);
+	fd = hold_lock_file_for_update(&todo_lock, todo_path, 0);
 	if (fd < 0)
 		return error_errno(_("Could not lock '%s'"),
 				   git_path_todo_file());
-	if (format_todo(&buf, todo_list, opts) < 0) {
-		strbuf_release(&buf);
-		return error(_("Could not format %s."), git_path_todo_file());
-	}
-	if (write_in_full(fd, buf.buf, buf.len) < 0) {
-		strbuf_release(&buf);
-		return error_errno(_("Could not write to %s"),
-				   git_path_todo_file());
-	}
-	if (commit_lock_file(&todo_lock) < 0) {
-		strbuf_release(&buf);
-		return error(_("Error wrapping up %s."), git_path_todo_file());
-	}
-	strbuf_release(&buf);
+	offset = next < todo_list->nr ?
+		todo_list->items[next].offset_in_buf : todo_list->buf.len;
+	if (write_in_full(fd, todo_list->buf.buf + offset,
+			todo_list->buf.len - offset) < 0)
+		return error(_("Could not write to %s (%s)"),
+			todo_path, strerror(errno));
+	if (commit_lock_file(&todo_lock) < 0)
+		return error(_("Error wrapping up %s."), todo_path);
 	return 0;
 }
 
@@ -1026,9 +1046,8 @@ static int save_opts(struct replay_opts *opts)
 	return res;
 }
 
-static int pick_commits(struct commit_list *todo_list, struct replay_opts *opts)
+static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 {
-	struct commit_list *cur;
 	int res;
 
 	setenv(GIT_REFLOG_ACTION, action_name(opts), 0);
@@ -1038,10 +1057,12 @@ static int pick_commits(struct commit_list *todo_list, struct replay_opts *opts)
 	if (read_and_refresh_cache(opts))
 		return -1;
 
-	for (cur = todo_list; cur; cur = cur->next) {
-		if (save_todo(cur, opts))
+	while (todo_list->current < todo_list->nr) {
+		struct todo_item *item = todo_list->items + todo_list->current;
+		if (save_todo(todo_list, opts))
 			return -1;
-		res = do_pick_commit(cur->item, opts);
+		res = do_pick_commit(item->command, item->commit, opts);
+		todo_list->current++;
 		if (res)
 			return res;
 	}
@@ -1066,7 +1087,8 @@ static int continue_single_pick(void)
 
 static int sequencer_continue(struct replay_opts *opts)
 {
-	struct commit_list *todo_list = NULL;
+	struct todo_list todo_list = TODO_LIST_INIT;
+	int res;
 
 	if (!file_exists(get_todo_path(opts)))
 		return continue_single_pick();
@@ -1083,21 +1105,24 @@ static int sequencer_continue(struct replay_opts *opts)
 	}
 	if (index_differs_from("HEAD", 0))
 		return error_dirty_index(opts);
-	todo_list = todo_list->next;
-	return pick_commits(todo_list, opts);
+	todo_list.current++;
+	res = pick_commits(&todo_list, opts);
+	todo_list_release(&todo_list);
+	return res;
 }
 
 static int single_pick(struct commit *cmit, struct replay_opts *opts)
 {
 	setenv(GIT_REFLOG_ACTION, action_name(opts), 0);
-	return do_pick_commit(cmit, opts);
+	return do_pick_commit(opts->action == REPLAY_PICK ?
+		TODO_PICK : TODO_REVERT, cmit, opts);
 }
 
 int sequencer_pick_revisions(struct replay_opts *opts)
 {
-	struct commit_list *todo_list = NULL;
+	struct todo_list todo_list = TODO_LIST_INIT;
 	unsigned char sha1[20];
-	int i;
+	int i, res;
 
 	if (opts->subcommand == REPLAY_NONE)
 		assert(opts->revs);
@@ -1171,7 +1196,9 @@ int sequencer_pick_revisions(struct replay_opts *opts)
 	if (save_head(sha1_to_hex(sha1)) ||
 			save_opts(opts))
 		return -1;
-	return pick_commits(todo_list, opts);
+	res = pick_commits(&todo_list, opts);
+	todo_list_release(&todo_list);
+	return res;
 }
 
 void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag)
-- 
2.10.0.rc1.114.g2bd6b38


