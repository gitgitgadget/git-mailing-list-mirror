From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 6/6] sequencer: factor code out of revert builtin
Date: Sun,  8 Jan 2012 17:57:33 +0530
Message-ID: <1326025653-11922-7-git-send-email-artagnon@gmail.com>
References: <1326025653-11922-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 08 13:29:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rjrsh-0008M1-H3
	for gcvg-git-2@lo.gmane.org; Sun, 08 Jan 2012 13:29:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753490Ab2AHM3i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jan 2012 07:29:38 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:64499 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753435Ab2AHM3g (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jan 2012 07:29:36 -0500
Received: by mail-iy0-f174.google.com with SMTP id h11so5271273iae.19
        for <git@vger.kernel.org>; Sun, 08 Jan 2012 04:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=edMR9WEzRotCRbeArX00nbjYXJGrzOHIN3okoRl57fg=;
        b=S3DSZR30Z2cIak2PzxCIoGxq1gIJov9dU7v4Vo9VrMBISpkvrU4S16phq62G18lGN4
         otJS6/2Vg5CZVUsH3SuMxzG6sSFgxZMA/98xEQll7XQUvabLTc3JjoGUmhnSyLYgX8GW
         +2NCBvH6dVGTu1SrsWne7kK6DOUEj+VRBgnak=
Received: by 10.42.159.195 with SMTP id m3mr12279266icx.33.1326025775611;
        Sun, 08 Jan 2012 04:29:35 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.205])
        by mx.google.com with ESMTPS id r5sm106707878igl.3.2012.01.08.04.29.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 08 Jan 2012 04:29:33 -0800 (PST)
X-Mailer: git-send-email 1.7.8.2
In-Reply-To: <1326025653-11922-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188112>

Expose the cherry-picking machinery through a public
sequencer_pick_revisions() (renamed from pick_revisions() in
builtin/revert.c), so that cherry-picking and reverting are special
cases of a general sequencer operation.  The cherry-pick builtin is
now a thin wrapper that does command-line argument parsing before
calling into sequencer_pick_revisions().  In the future, we can write
a new "foo" builtin that calls into the sequencer like:

  memset(&opts, 0, sizeof(opts));
  opts.command = REPLAY_CMD_FOO;
  opts.revisions = xmalloc(sizeof(*opts.revs));
  parse_args_populate_opts(argc, argv, &opts);
  init_revisions(opts.revs);
  sequencer_pick_revisions(&opts);

This patch does not intend to make any functional changes.  Check
with:

  $ git blame -s -C HEAD^..HEAD -- sequencer.c | grep -C3 '^[^^]'

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/revert.c | 1006 +-----------------------------------------------------
 sequencer.c      |  987 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 sequencer.h      |   25 ++
 3 files changed, 1013 insertions(+), 1005 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 35553e7..47f71f3 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -1,19 +1,9 @@
 #include "cache.h"
 #include "builtin.h"
-#include "object.h"
-#include "commit.h"
-#include "tag.h"
-#include "run-command.h"
-#include "exec_cmd.h"
-#include "utf8.h"
 #include "parse-options.h"
-#include "cache-tree.h"
 #include "diff.h"
 #include "revision.h"
 #include "rerere.h"
-#include "merge-recursive.h"
-#include "refs.h"
-#include "dir.h"
 #include "sequencer.h"
 
 /*
@@ -39,43 +29,11 @@ static const char * const cherry_pick_usage[] = {
 	NULL
 };
 
-struct replay_opts {
-	enum replay_command command;
-	enum replay_subcommand subcommand;
-
-	/* Boolean options */
-	int edit;
-	int record_origin;
-	int no_commit;
-	int signoff;
-	int allow_ff;
-	int allow_rerere_auto;
-
-	int mainline;
-
-	/* Merge strategy */
-	const char *strategy;
-	const char **xopts;
-	size_t xopts_nr, xopts_alloc;
-
-	/* Only used by REPLAY_NONE */
-	struct rev_info *revs;
-};
-
-#define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
-
 static const char *command_name(struct replay_opts *opts)
 {
 	return opts->command == REPLAY_CMD_REVERT ? "revert" : "cherry-pick";
 }
 
-static const char *action_name(enum replay_action action)
-{
-	return action == REPLAY_REVERT ? "revert" : "pick";
-}
-
-static char *get_encoding(const char *message);
-
 static const char * const *revert_or_cherry_pick_usage(struct replay_opts *opts)
 {
 	return opts->command == REPLAY_CMD_REVERT ? revert_usage : cherry_pick_usage;
@@ -234,966 +192,6 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 		usage_with_options(usage_str, options);
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
-static void free_message(struct commit_message *msg)
-{
-	free(msg->parent_label);
-	free(msg->reencoded_message);
-}
-
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
-static void write_cherry_pick_head(struct commit *commit, const char *pseudoref)
-{
-	const char *filename;
-	int fd;
-	struct strbuf buf = STRBUF_INIT;
-
-	strbuf_addf(&buf, "%s\n", sha1_to_hex(commit->object.sha1));
-
-	filename = git_path("%s", pseudoref);
-	fd = open(filename, O_WRONLY | O_CREAT, 0666);
-	if (fd < 0)
-		die_errno(_("Could not open '%s' for writing"), filename);
-	if (write_in_full(fd, buf.buf, buf.len) != buf.len || close(fd))
-		die_errno(_("Could not write to '%s'"), filename);
-	strbuf_release(&buf);
-}
-
-static void print_advice(int show_hint)
-{
-	char *msg = getenv("GIT_CHERRY_PICK_HELP");
-
-	if (msg) {
-		fprintf(stderr, "%s\n", msg);
-		/*
-		 * A conflict has occured but the porcelain
-		 * (typically rebase --interactive) wants to take care
-		 * of the commit itself so remove CHERRY_PICK_HEAD
-		 */
-		unlink(git_path("CHERRY_PICK_HEAD"));
-		return;
-	}
-
-	if (show_hint) {
-		advise("after resolving the conflicts, mark the corrected paths");
-		advise("with 'git add <paths>' or 'git rm <paths>'");
-		advise("and commit the result with 'git commit'");
-	}
-}
-
-static void write_message(struct strbuf *msgbuf, const char *filename)
-{
-	static struct lock_file msg_file;
-
-	int msg_fd = hold_lock_file_for_update(&msg_file, filename,
-					       LOCK_DIE_ON_ERROR);
-	if (write_in_full(msg_fd, msgbuf->buf, msgbuf->len) < 0)
-		die_errno(_("Could not write to %s"), filename);
-	strbuf_release(msgbuf);
-	if (commit_lock_file(&msg_file) < 0)
-		die(_("Error wrapping up %s"), filename);
-}
-
-static struct tree *empty_tree(void)
-{
-	return lookup_tree((const unsigned char *)EMPTY_TREE_SHA1_BIN);
-}
-
-static int error_dirty_index(struct replay_opts *opts)
-{
-	if (read_cache_unmerged())
-		return error_resolve_conflict(command_name(opts));
-
-	/* Different translation strings for cherry-pick and revert */
-	if (opts->command == REPLAY_CMD_CHERRY_PICK)
-		error(_("Your local changes would be overwritten by cherry-pick."));
-	else
-		error(_("Your local changes would be overwritten by revert."));
-
-	if (advice_commit_before_merge)
-		advise(_("Commit your changes or stash them to proceed."));
-	return -1;
-}
-
-static int fast_forward_to(const unsigned char *to, const unsigned char *from)
-{
-	struct ref_lock *ref_lock;
-
-	read_cache();
-	if (checkout_fast_forward(from, to))
-		exit(1); /* the callee should have complained already */
-	ref_lock = lock_any_ref_for_update("HEAD", from, 0);
-	return write_ref_sha1(ref_lock, to, "cherry-pick");
-}
-
-static int do_recursive_merge(struct commit *base, struct commit *next,
-			      const char *base_label, const char *next_label,
-			      unsigned char *head, struct strbuf *msgbuf,
-			      struct replay_opts *opts)
-{
-	struct merge_options o;
-	struct tree *result, *next_tree, *base_tree, *head_tree;
-	int clean, index_fd;
-	const char **xopt;
-	static struct lock_file index_lock;
-
-	index_fd = hold_locked_index(&index_lock, 1);
-
-	read_cache();
-
-	init_merge_options(&o);
-	o.ancestor = base ? base_label : "(empty tree)";
-	o.branch1 = "HEAD";
-	o.branch2 = next ? next_label : "(empty tree)";
-
-	head_tree = parse_tree_indirect(head);
-	next_tree = next ? next->tree : empty_tree();
-	base_tree = base ? base->tree : empty_tree();
-
-	for (xopt = opts->xopts; xopt != opts->xopts + opts->xopts_nr; xopt++)
-		parse_merge_opt(&o, *xopt);
-
-	clean = merge_trees(&o,
-			    head_tree,
-			    next_tree, base_tree, &result);
-
-	if (active_cache_changed &&
-	    (write_cache(index_fd, active_cache, active_nr) ||
-	     commit_locked_index(&index_lock)))
-		/* TRANSLATORS: %s will be "revert" or "cherry-pick" */
-		die(_("%s: Unable to write new index file"), command_name(opts));
-	rollback_lock_file(&index_lock);
-
-	if (!clean) {
-		int i;
-		strbuf_addstr(msgbuf, "\nConflicts:\n\n");
-		for (i = 0; i < active_nr;) {
-			struct cache_entry *ce = active_cache[i++];
-			if (ce_stage(ce)) {
-				strbuf_addch(msgbuf, '\t');
-				strbuf_addstr(msgbuf, ce->name);
-				strbuf_addch(msgbuf, '\n');
-				while (i < active_nr && !strcmp(ce->name,
-						active_cache[i]->name))
-					i++;
-			}
-		}
-	}
-
-	return !clean;
-}
-
-/*
- * If we are cherry-pick, and if the merge did not result in
- * hand-editing, we will hit this commit and inherit the original
- * author date and name.
- * If we are revert, or if our cherry-pick results in a hand merge,
- * we had better say that the current user is responsible for that.
- */
-static int run_git_commit(const char *defmsg, struct replay_opts *opts)
-{
-	/* 6 is max possible length of our args array including NULL */
-	const char *args[6];
-	int i = 0;
-
-	args[i++] = "commit";
-	args[i++] = "-n";
-	if (opts->signoff)
-		args[i++] = "-s";
-	if (!opts->edit) {
-		args[i++] = "-F";
-		args[i++] = defmsg;
-	}
-	args[i] = NULL;
-
-	return run_command_v_opt(args, RUN_GIT_CMD);
-}
-
-static int do_pick_commit(struct commit *commit, enum replay_action action,
-			struct replay_opts *opts)
-{
-	unsigned char head[20];
-	struct commit *base, *next, *parent;
-	const char *base_label, *next_label;
-	struct commit_message msg = { NULL, NULL, NULL, NULL, NULL };
-	char *defmsg = NULL;
-	struct strbuf msgbuf = STRBUF_INIT;
-	int res;
-
-	if (opts->no_commit) {
-		/*
-		 * We do not intend to commit immediately.  We just want to
-		 * merge the differences in, so let's compute the tree
-		 * that represents the "current" state for merge-recursive
-		 * to work on.
-		 */
-		if (write_cache_as_tree(head, 0, NULL))
-			die (_("Your index file is unmerged."));
-	} else {
-		if (get_sha1("HEAD", head))
-			return error(_("You do not have a valid HEAD"));
-		if (index_differs_from("HEAD", 0))
-			return error_dirty_index(opts);
-	}
-	discard_cache();
-
-	if (!commit->parents) {
-		parent = NULL;
-	}
-	else if (commit->parents->next) {
-		/* Reverting or cherry-picking a merge commit */
-		int cnt;
-		struct commit_list *p;
-
-		if (!opts->mainline)
-			return error(_("Commit %s is a merge but no -m option was given."),
-				sha1_to_hex(commit->object.sha1));
-
-		for (cnt = 1, p = commit->parents;
-		     cnt != opts->mainline && p;
-		     cnt++)
-			p = p->next;
-		if (cnt != opts->mainline || !p)
-			return error(_("Commit %s does not have parent %d"),
-				sha1_to_hex(commit->object.sha1), opts->mainline);
-		parent = p->item;
-	} else if (0 < opts->mainline)
-		return error(_("Mainline was specified but commit %s is not a merge."),
-			sha1_to_hex(commit->object.sha1));
-	else
-		parent = commit->parents->item;
-
-	if (opts->allow_ff && parent && !hashcmp(parent->object.sha1, head))
-		return fast_forward_to(commit->object.sha1, head);
-
-	if (parent && parse_commit(parent) < 0)
-		/* TRANSLATORS: The first %s will be "revert" or
-		   "cherry-pick", the second %s a SHA1 */
-		return error(_("%s: cannot parse parent commit %s"),
-			command_name(opts), sha1_to_hex(parent->object.sha1));
-
-	if (get_message(commit, &msg) != 0)
-		return error(_("Cannot get commit message for %s"),
-			sha1_to_hex(commit->object.sha1));
-
-	/*
-	 * "commit" is an existing commit.  We would want to apply
-	 * the difference it introduces since its first parent "prev"
-	 * on top of the current HEAD if we are cherry-pick.  Or the
-	 * reverse of it if we are revert.
-	 */
-
-	defmsg = git_pathdup("MERGE_MSG");
-
-	if (action == REPLAY_REVERT) {
-		base = commit;
-		base_label = msg.label;
-		next = parent;
-		next_label = msg.parent_label;
-		strbuf_addstr(&msgbuf, "Revert \"");
-		strbuf_addstr(&msgbuf, msg.subject);
-		strbuf_addstr(&msgbuf, "\"\n\nThis reverts commit ");
-		strbuf_addstr(&msgbuf, sha1_to_hex(commit->object.sha1));
-
-		if (commit->parents && commit->parents->next) {
-			strbuf_addstr(&msgbuf, ", reversing\nchanges made to ");
-			strbuf_addstr(&msgbuf, sha1_to_hex(parent->object.sha1));
-		}
-		strbuf_addstr(&msgbuf, ".\n");
-	} else {
-		const char *p;
-
-		base = parent;
-		base_label = msg.parent_label;
-		next = commit;
-		next_label = msg.label;
-
-		/*
-		 * Append the commit log message to msgbuf; it starts
-		 * after the tree, parent, author, committer
-		 * information followed by "\n\n".
-		 */
-		p = strstr(msg.message, "\n\n");
-		if (p) {
-			p += 2;
-			strbuf_addstr(&msgbuf, p);
-		}
-
-		if (opts->record_origin) {
-			strbuf_addstr(&msgbuf, "(cherry picked from commit ");
-			strbuf_addstr(&msgbuf, sha1_to_hex(commit->object.sha1));
-			strbuf_addstr(&msgbuf, ")\n");
-		}
-	}
-
-	if (!opts->strategy || !strcmp(opts->strategy, "recursive") || action == REPLAY_REVERT) {
-		res = do_recursive_merge(base, next, base_label, next_label,
-					 head, &msgbuf, opts);
-		write_message(&msgbuf, defmsg);
-	} else {
-		struct commit_list *common = NULL;
-		struct commit_list *remotes = NULL;
-
-		write_message(&msgbuf, defmsg);
-
-		commit_list_insert(base, &common);
-		commit_list_insert(next, &remotes);
-		res = try_merge_command(opts->strategy, opts->xopts_nr, opts->xopts,
-					common, sha1_to_hex(head), remotes);
-		free_commit_list(common);
-		free_commit_list(remotes);
-	}
-
-	/*
-	 * If the merge was clean or if it failed due to conflict, we write
-	 * CHERRY_PICK_HEAD for the subsequent invocation of commit to use.
-	 * However, if the merge did not even start, then we don't want to
-	 * write it at all.
-	 */
-	if (action == REPLAY_PICK && !opts->no_commit && (res == 0 || res == 1))
-		write_cherry_pick_head(commit, "CHERRY_PICK_HEAD");
-	if (action == REPLAY_REVERT && ((opts->no_commit && res == 0) || res == 1))
-		write_cherry_pick_head(commit, "REVERT_HEAD");
-
-	if (res) {
-		error(action == REPLAY_REVERT
-		      ? _("could not revert %s... %s")
-		      : _("could not apply %s... %s"),
-		      find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV),
-		      msg.subject);
-		print_advice(res == 1);
-		rerere(opts->allow_rerere_auto);
-	} else {
-		if (!opts->no_commit)
-			res = run_git_commit(defmsg, opts);
-	}
-
-	free_message(&msg);
-	free(defmsg);
-
-	return res;
-}
-
-static void prepare_revs(struct replay_opts *opts)
-{
-	if (opts->command != REPLAY_CMD_REVERT)
-		opts->revs->reverse ^= 1;
-
-	if (prepare_revision_walk(opts->revs))
-		die(_("revision walk setup failed"));
-
-	if (!opts->revs->commits)
-		die(_("empty commit set passed"));
-}
-
-static void read_and_refresh_cache(struct replay_opts *opts)
-{
-	static struct lock_file index_lock;
-	int index_fd = hold_locked_index(&index_lock, 0);
-	if (read_index_preload(&the_index, NULL) < 0)
-		die(_("git %s: failed to read the index"), command_name(opts));
-	refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED, NULL, NULL, NULL);
-	if (the_index.cache_changed) {
-		if (write_index(&the_index, index_fd) ||
-		    commit_locked_index(&index_lock))
-			die(_("git %s: failed to refresh the index"),
-				command_name(opts));
-	}
-	rollback_lock_file(&index_lock);
-}
-
-/*
- * Append a (commit, action) to the end of the replay_insn_list.
- *
- * next starts by pointing to the variable that holds the head of an
- * empty replay_insn_list, and is updated to point to the "next" field of
- * the last item on the list as new (commit, action) pairs are appended.
- *
- * Usage example:
- *
- *     struct replay_insn_list *list;
- *     struct replay_insn_list **next = &list;
- *
- *     next = replay_insn_list_append(c1, a1, next);
- *     next = replay_insn_list_append(c2, a2, next);
- *     assert(len(list) == 2);
- *     return list;
- */
-static struct replay_insn_list **replay_insn_list_append(struct commit *operand,
-							enum replay_action action,
-							struct replay_insn_list **next)
-{
-	struct replay_insn_list *new = xmalloc(sizeof(*new));
-	new->action = action;
-	new->operand = operand;
-	*next = new;
-	new->next = NULL;
-	return &new->next;
-}
-
-static int format_todo(struct strbuf *buf, struct replay_insn_list *todo_list)
-{
-	struct replay_insn_list *cur;
-
-	for (cur = todo_list; cur; cur = cur->next) {
-		const char *sha1_abbrev, *action_str, *subject;
-		int subject_len;
-
-		action_str = action_name(cur->action);
-		sha1_abbrev = find_unique_abbrev(cur->operand->object.sha1, DEFAULT_ABBREV);
-		subject_len = find_commit_subject(cur->operand->buffer, &subject);
-		strbuf_addf(buf, "%s %s %.*s\n", action_str, sha1_abbrev,
-			subject_len, subject);
-	}
-	return 0;
-}
-
-static int parse_insn_line(char *bol, char *eol,
-			struct replay_insn_list *item, int lineno)
-{
-	const char *todo_file = git_path(SEQ_TODO_FILE);
-	unsigned char commit_sha1[20];
-	char *end_of_object_name;
-	int saved, status;
-	size_t error_len;
-
-	if (!prefixcmp(bol, "pick ") || !prefixcmp(bol, "pick\t")) {
-		item->action = REPLAY_PICK;
-		bol += strlen("pick ");
-	} else if (!prefixcmp(bol, "revert ") || !prefixcmp(bol, "revert\t")) {
-		item->action = REPLAY_REVERT;
-		bol += strlen("revert ");
-	} else {
-		error_len = eol - bol > 255 ? 255 : eol - bol;
-		return error(_("%s:%d: Unrecognized action: %.*s"),
-			todo_file, lineno, (int)error_len, bol);
-	}
-
-	/* Eat up extra spaces/ tabs before object name */
-	bol += strspn(bol, " \t");
-
-	end_of_object_name = bol + strcspn(bol, " \t\n");
-	saved = *end_of_object_name;
-	*end_of_object_name = '\0';
-	status = get_sha1(bol, commit_sha1);
-	*end_of_object_name = saved;
-
-	if (status < 0) {
-		error_len = eol - bol > 255 ? 255 : eol - bol;
-		return error(_("%s:%d: Malformed object name: %.*s"),
-			todo_file, lineno, (int)error_len, bol);
-	}
-
-	item->operand = lookup_commit_reference(commit_sha1);
-	if (!item->operand) {
-		error_len = eol - bol > 255 ? 255 : eol - bol;
-		return error(_("%s:%d: Not a valid commit: %.*s"),
-			todo_file, lineno, (int)error_len, bol);
-	}
-
-	item->next = NULL;
-	return 0;
-}
-
-static int parse_insn_buffer(char *buf, struct replay_insn_list **todo_list)
-{
-	struct replay_insn_list **next = todo_list;
-	struct replay_insn_list item = { NULL, 0, NULL };
-	char *p = buf;
-	int i;
-
-	for (i = 1; *p; i++) {
-		char *eol = strchrnul(p, '\n');
-		if (parse_insn_line(p, eol, &item, i) < 0)
-			return -1;
-		next = replay_insn_list_append(item.operand, item.action, next);
-		p = *eol ? eol + 1 : eol;
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
-		die_errno(_("Could not open %s"), todo_file);
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
-static void walk_revs_populate_todo(struct replay_insn_list **todo_list,
-				struct replay_opts *opts)
-{
-	struct commit *commit;
-	struct replay_insn_list **next;
-	enum replay_action action;
-
-	prepare_revs(opts);
-
-	next = todo_list;
-	action = opts->command == REPLAY_CMD_REVERT ? REPLAY_REVERT : REPLAY_PICK;
-	while ((commit = get_revision(opts->revs)))
-		next = replay_insn_list_append(commit, action, next);
-}
-
-static int create_seq_dir(void)
-{
-	const char *seq_dir = git_path(SEQ_DIR);
-
-	if (file_exists(seq_dir)) {
-		error(_("a cherry-pick or revert is already in progress"));
-		advise(_("try \"git cherry-pick (--continue | --quit | --abort)\""));
-		return -1;
-	}
-	else if (mkdir(seq_dir, 0777) < 0)
-		die_errno(_("Could not create sequencer directory %s"), seq_dir);
-	return 0;
-}
-
-static enum replay_command read_cmd(void)
-{
-	const char *cmd_file = git_path(SEQ_CMD_FILE);
-	struct strbuf buf = STRBUF_INIT;
-	enum replay_command res;
-	int fd;
-
-	fd = open(cmd_file, O_RDONLY);
-	if (fd < 0)
-		die_errno(_("Could not open %s"), cmd_file);
-	if (strbuf_read(&buf, fd, 0) < 0) {
-		close(fd);
-		strbuf_release(&buf);
-		die(_("Could not read %s."), cmd_file);
-	}
-	close(fd);
-
-	if (!strcmp(buf.buf, "revert\n"))
-		res = REPLAY_CMD_REVERT;
-	else if (!strcmp(buf.buf, "cherry-pick\n"))
-		res = REPLAY_CMD_CHERRY_PICK;
-	else {
-		strbuf_release(&buf);
-		die(_("Malformed command file: %s"), cmd_file);
-	}
-	strbuf_release(&buf);
-	return res;
-}
-
-static void save_cmd(struct replay_opts *opts)
-{
-	const char *cmd_file = git_path(SEQ_CMD_FILE);
-	static struct lock_file cmd_lock;
-	struct strbuf buf = STRBUF_INIT;
-	int fd;
-
-	fd = hold_lock_file_for_update(&cmd_lock, cmd_file, LOCK_DIE_ON_ERROR);
-	strbuf_addf(&buf, "%s\n", command_name(opts));
-	if (write_in_full(fd, buf.buf, buf.len) < 0)
-		die_errno(_("Could not write to %s"), cmd_file);
-	if (commit_lock_file(&cmd_lock) < 0)
-		die(_("Error wrapping up %s."), cmd_file);
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
-		die_errno(_("Could not write to %s"), head_file);
-	if (commit_lock_file(&head_lock) < 0)
-		die(_("Error wrapping up %s."), head_file);
-}
-
-static int reset_for_rollback(const unsigned char *sha1)
-{
-	const char *argv[4];	/* reset --merge <arg> + NULL */
-	argv[0] = "reset";
-	argv[1] = "--merge";
-	argv[2] = sha1_to_hex(sha1);
-	argv[3] = NULL;
-	return run_command_v_opt(argv, RUN_GIT_CMD);
-}
-
-static int rollback_single_pick(void)
-{
-	unsigned char head_sha1[20];
-
-	if (!file_exists(git_path("CHERRY_PICK_HEAD")) &&
-	    !file_exists(git_path("REVERT_HEAD")))
-		return error(_("no cherry-pick or revert in progress"));
-	if (read_ref_full("HEAD", head_sha1, 0, NULL))
-		return error(_("cannot resolve HEAD"));
-	if (is_null_sha1(head_sha1))
-		return error(_("cannot abort from a branch yet to be born"));
-	return reset_for_rollback(head_sha1);
-}
-
-static int sequencer_rollback(struct replay_opts *opts)
-{
-	const char *filename;
-	FILE *f;
-	unsigned char sha1[20];
-	struct strbuf buf = STRBUF_INIT;
-
-	filename = git_path(SEQ_HEAD_FILE);
-	f = fopen(filename, "r");
-	if (!f && errno == ENOENT) {
-		/*
-		 * There is no multiple-cherry-pick in progress.
-		 * If CHERRY_PICK_HEAD or REVERT_HEAD indicates
-		 * a single-cherry-pick in progress, abort that.
-		 */
-		return rollback_single_pick();
-	}
-	if (!f)
-		return error(_("cannot open %s: %s"), filename,
-						strerror(errno));
-	if (strbuf_getline(&buf, f, '\n')) {
-		error(_("cannot read %s: %s"), filename, ferror(f) ?
-			strerror(errno) : _("unexpected end of file"));
-		fclose(f);
-		goto fail;
-	}
-	fclose(f);
-	if (get_sha1_hex(buf.buf, sha1) || buf.buf[40] != '\0') {
-		error(_("stored pre-cherry-pick HEAD file '%s' is corrupt"),
-			filename);
-		goto fail;
-	}
-	if (reset_for_rollback(sha1))
-		goto fail;
-	remove_sequencer_state();
-	strbuf_release(&buf);
-	return 0;
-fail:
-	strbuf_release(&buf);
-	return -1;
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
-		die_errno(_("Could not write to %s"), todo_file);
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
-static int pick_commits(struct replay_insn_list *todo_list, struct replay_opts *opts)
-{
-	struct replay_insn_list *cur;
-	int res;
-
-	setenv(GIT_REFLOG_ACTION, command_name(opts), 0);
-	if (opts->allow_ff)
-		assert(!(opts->signoff || opts->no_commit ||
-				opts->record_origin || opts->edit));
-	read_and_refresh_cache(opts);
-
-	for (cur = todo_list; cur; cur = cur->next) {
-		save_todo(cur);
-		res = do_pick_commit(cur->operand, cur->action, opts);
-		if (res)
-			return res;
-	}
-
-	/*
-	 * Sequence of picks finished successfully; cleanup by
-	 * removing the .git/sequencer directory
-	 */
-	remove_sequencer_state();
-	return 0;
-}
-
-static int continue_single_pick(void)
-{
-	const char *argv[] = { "commit", NULL };
-
-	if (!file_exists(git_path("CHERRY_PICK_HEAD")) &&
-	    !file_exists(git_path("REVERT_HEAD")))
-		return error(_("no cherry-pick or revert in progress"));
-	return run_command_v_opt(argv, RUN_GIT_CMD);
-}
-
-static int sequencer_continue(struct replay_opts *opts)
-{
-	struct replay_insn_list *todo_list = NULL;
-	enum replay_command cmd;
-
-	if (!file_exists(git_path(SEQ_TODO_FILE)))
-		return continue_single_pick();
-
-	/*
-	 * Disallow continuing a cherry-pick with 'git revert
-	 * --continue' and viceversa
-	 */
-	cmd = read_cmd();
-	if (cmd != opts->command)
-		return error(_("cannot %s: a %s is in progress."),
-			command_name(opts),
-			cmd == REPLAY_CMD_REVERT ? "revert" : "cherry-pick");
-
-	read_populate_opts(&opts);
-	read_populate_todo(&todo_list);
-
-	/* Verify that the conflict has been resolved */
-	if (file_exists(git_path("CHERRY_PICK_HEAD")) ||
-	    file_exists(git_path("REVERT_HEAD"))) {
-		int ret = continue_single_pick();
-		if (ret)
-			return ret;
-	}
-	if (index_differs_from("HEAD", 0))
-		return error_dirty_index(opts);
-	todo_list = todo_list->next;
-	return pick_commits(todo_list, opts);
-}
-
-static int single_pick(struct commit *cmit, struct replay_opts *opts)
-{
-	enum replay_action action;
-	action = opts->command == REPLAY_CMD_REVERT ? REPLAY_REVERT : REPLAY_PICK;
-
-	setenv(GIT_REFLOG_ACTION, command_name(opts), 0);
-	return do_pick_commit(cmit, action, opts);
-}
-
-static int pick_revisions(struct replay_opts *opts)
-{
-	struct replay_insn_list *todo_list = NULL;
-	unsigned char sha1[20];
-
-	if (opts->subcommand == REPLAY_NONE)
-		assert(opts->revs);
-
-	read_and_refresh_cache(opts);
-
-	/*
-	 * Decide what to do depending on the arguments; a fresh
-	 * cherry-pick should be handled differently from an existing
-	 * one that is being continued
-	 */
-	if (opts->subcommand == REPLAY_REMOVE_STATE) {
-		remove_sequencer_state();
-		return 0;
-	}
-	if (opts->subcommand == REPLAY_ROLLBACK)
-		return sequencer_rollback(opts);
-	if (opts->subcommand == REPLAY_CONTINUE)
-		return sequencer_continue(opts);
-
-	/*
-	 * If we were called as "git cherry-pick <commit>", just
-	 * cherry-pick/revert it, set CHERRY_PICK_HEAD /
-	 * REVERT_HEAD, and don't touch the sequencer state.
-	 * This means it is possible to cherry-pick in the middle
-	 * of a cherry-pick sequence.
-	 */
-	if (opts->revs->cmdline.nr == 1 &&
-	    opts->revs->cmdline.rev->whence == REV_CMD_REV &&
-	    opts->revs->no_walk &&
-	    !opts->revs->cmdline.rev->flags) {
-		struct commit *cmit;
-		if (prepare_revision_walk(opts->revs))
-			die(_("revision walk setup failed"));
-		cmit = get_revision(opts->revs);
-		if (!cmit || get_revision(opts->revs))
-			die("BUG: expected exactly one commit from walk");
-		return single_pick(cmit, opts);
-	}
-
-	/*
-	 * Start a new cherry-pick/ revert sequence; but
-	 * first, make sure that an existing one isn't in
-	 * progress
-	 */
-
-	walk_revs_populate_todo(&todo_list, opts);
-	if (create_seq_dir() < 0)
-		return -1;
-	if (get_sha1("HEAD", sha1)) {
-		if (opts->command == REPLAY_CMD_REVERT)
-			return error(_("Can't revert as initial commit"));
-		return error(_("Can't cherry-pick into empty head"));
-	}
-	save_cmd(opts);
-	save_head(sha1_to_hex(sha1));
-	save_opts(opts);
-	return pick_commits(todo_list, opts);
-}
-
 int cmd_revert(int argc, const char **argv, const char *prefix)
 {
 	struct replay_opts opts;
@@ -1205,7 +203,7 @@ int cmd_revert(int argc, const char **argv, const char *prefix)
 	opts.command = REPLAY_CMD_REVERT;
 	git_config(git_default_config, NULL);
 	parse_args(argc, argv, &opts);
-	res = pick_revisions(&opts);
+	res = sequencer_pick_revisions(&opts);
 	if (res < 0)
 		die(_("revert failed"));
 	return res;
@@ -1220,7 +218,7 @@ int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
 	opts.command = REPLAY_CMD_CHERRY_PICK;
 	git_config(git_default_config, NULL);
 	parse_args(argc, argv, &opts);
-	res = pick_revisions(&opts);
+	res = sequencer_pick_revisions(&opts);
 	if (res < 0)
 		die(_("cherry-pick failed"));
 	return res;
diff --git a/sequencer.c b/sequencer.c
index d1f28a6..a7e494c 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1,7 +1,20 @@
 #include "cache.h"
 #include "sequencer.h"
-#include "strbuf.h"
 #include "dir.h"
+#include "object.h"
+#include "commit.h"
+#include "tag.h"
+#include "run-command.h"
+#include "exec_cmd.h"
+#include "utf8.h"
+#include "cache-tree.h"
+#include "diff.h"
+#include "revision.h"
+#include "rerere.h"
+#include "merge-recursive.h"
+#include "refs.h"
+
+#define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
 void remove_sequencer_state(void)
 {
@@ -11,3 +24,975 @@ void remove_sequencer_state(void)
 	remove_dir_recursively(&seq_dir, 0);
 	strbuf_release(&seq_dir);
 }
+
+static const char *command_name(struct replay_opts *opts)
+{
+	return opts->command == REPLAY_CMD_REVERT ? "revert" : "cherry-pick";
+}
+
+static const char *action_name(enum replay_action action)
+{
+	return action == REPLAY_REVERT ? "revert" : "pick";
+}
+
+struct commit_message {
+	char *parent_label;
+	const char *label;
+	const char *subject;
+	char *reencoded_message;
+	const char *message;
+};
+
+static char *get_encoding(const char *message);
+
+static int get_message(struct commit *commit, struct commit_message *out)
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
+static void free_message(struct commit_message *msg)
+{
+	free(msg->parent_label);
+	free(msg->reencoded_message);
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
+static void write_cherry_pick_head(struct commit *commit, const char *pseudoref)
+{
+	const char *filename;
+	int fd;
+	struct strbuf buf = STRBUF_INIT;
+
+	strbuf_addf(&buf, "%s\n", sha1_to_hex(commit->object.sha1));
+
+	filename = git_path("%s", pseudoref);
+	fd = open(filename, O_WRONLY | O_CREAT, 0666);
+	if (fd < 0)
+		die_errno(_("Could not open '%s' for writing"), filename);
+	if (write_in_full(fd, buf.buf, buf.len) != buf.len || close(fd))
+		die_errno(_("Could not write to '%s'"), filename);
+	strbuf_release(&buf);
+}
+
+static void print_advice(int show_hint)
+{
+	char *msg = getenv("GIT_CHERRY_PICK_HELP");
+
+	if (msg) {
+		fprintf(stderr, "%s\n", msg);
+		/*
+		 * A conflict has occured but the porcelain
+		 * (typically rebase --interactive) wants to take care
+		 * of the commit itself so remove CHERRY_PICK_HEAD
+		 */
+		unlink(git_path("CHERRY_PICK_HEAD"));
+		return;
+	}
+
+	if (show_hint) {
+		advise("after resolving the conflicts, mark the corrected paths");
+		advise("with 'git add <paths>' or 'git rm <paths>'");
+		advise("and commit the result with 'git commit'");
+	}
+}
+
+static void write_message(struct strbuf *msgbuf, const char *filename)
+{
+	static struct lock_file msg_file;
+
+	int msg_fd = hold_lock_file_for_update(&msg_file, filename,
+					       LOCK_DIE_ON_ERROR);
+	if (write_in_full(msg_fd, msgbuf->buf, msgbuf->len) < 0)
+		die_errno(_("Could not write to %s"), filename);
+	strbuf_release(msgbuf);
+	if (commit_lock_file(&msg_file) < 0)
+		die(_("Error wrapping up %s"), filename);
+}
+
+static struct tree *empty_tree(void)
+{
+	return lookup_tree((const unsigned char *)EMPTY_TREE_SHA1_BIN);
+}
+
+static int error_dirty_index(struct replay_opts *opts)
+{
+	if (read_cache_unmerged())
+		return error_resolve_conflict(command_name(opts));
+
+	/* Different translation strings for cherry-pick and revert */
+	if (opts->command == REPLAY_CMD_CHERRY_PICK)
+		error(_("Your local changes would be overwritten by cherry-pick."));
+	else
+		error(_("Your local changes would be overwritten by revert."));
+
+	if (advice_commit_before_merge)
+		advise(_("Commit your changes or stash them to proceed."));
+	return -1;
+}
+
+static int fast_forward_to(const unsigned char *to, const unsigned char *from)
+{
+	struct ref_lock *ref_lock;
+
+	read_cache();
+	if (checkout_fast_forward(from, to))
+		exit(1); /* the callee should have complained already */
+	ref_lock = lock_any_ref_for_update("HEAD", from, 0);
+	return write_ref_sha1(ref_lock, to, "cherry-pick");
+}
+
+static int do_recursive_merge(struct commit *base, struct commit *next,
+			      const char *base_label, const char *next_label,
+			      unsigned char *head, struct strbuf *msgbuf,
+			      struct replay_opts *opts)
+{
+	struct merge_options o;
+	struct tree *result, *next_tree, *base_tree, *head_tree;
+	int clean, index_fd;
+	const char **xopt;
+	static struct lock_file index_lock;
+
+	index_fd = hold_locked_index(&index_lock, 1);
+
+	read_cache();
+
+	init_merge_options(&o);
+	o.ancestor = base ? base_label : "(empty tree)";
+	o.branch1 = "HEAD";
+	o.branch2 = next ? next_label : "(empty tree)";
+
+	head_tree = parse_tree_indirect(head);
+	next_tree = next ? next->tree : empty_tree();
+	base_tree = base ? base->tree : empty_tree();
+
+	for (xopt = opts->xopts; xopt != opts->xopts + opts->xopts_nr; xopt++)
+		parse_merge_opt(&o, *xopt);
+
+	clean = merge_trees(&o,
+			    head_tree,
+			    next_tree, base_tree, &result);
+
+	if (active_cache_changed &&
+	    (write_cache(index_fd, active_cache, active_nr) ||
+	     commit_locked_index(&index_lock)))
+		/* TRANSLATORS: %s will be "revert" or "cherry-pick" */
+		die(_("%s: Unable to write new index file"), command_name(opts));
+	rollback_lock_file(&index_lock);
+
+	if (!clean) {
+		int i;
+		strbuf_addstr(msgbuf, "\nConflicts:\n\n");
+		for (i = 0; i < active_nr;) {
+			struct cache_entry *ce = active_cache[i++];
+			if (ce_stage(ce)) {
+				strbuf_addch(msgbuf, '\t');
+				strbuf_addstr(msgbuf, ce->name);
+				strbuf_addch(msgbuf, '\n');
+				while (i < active_nr && !strcmp(ce->name,
+						active_cache[i]->name))
+					i++;
+			}
+		}
+	}
+
+	return !clean;
+}
+
+/*
+ * If we are cherry-pick, and if the merge did not result in
+ * hand-editing, we will hit this commit and inherit the original
+ * author date and name.
+ * If we are revert, or if our cherry-pick results in a hand merge,
+ * we had better say that the current user is responsible for that.
+ */
+static int run_git_commit(const char *defmsg, struct replay_opts *opts)
+{
+	/* 6 is max possible length of our args array including NULL */
+	const char *args[6];
+	int i = 0;
+
+	args[i++] = "commit";
+	args[i++] = "-n";
+	if (opts->signoff)
+		args[i++] = "-s";
+	if (!opts->edit) {
+		args[i++] = "-F";
+		args[i++] = defmsg;
+	}
+	args[i] = NULL;
+
+	return run_command_v_opt(args, RUN_GIT_CMD);
+}
+
+static int do_pick_commit(struct commit *commit, enum replay_action action,
+			struct replay_opts *opts)
+{
+	unsigned char head[20];
+	struct commit *base, *next, *parent;
+	const char *base_label, *next_label;
+	struct commit_message msg = { NULL, NULL, NULL, NULL, NULL };
+	char *defmsg = NULL;
+	struct strbuf msgbuf = STRBUF_INIT;
+	int res;
+
+	if (opts->no_commit) {
+		/*
+		 * We do not intend to commit immediately.  We just want to
+		 * merge the differences in, so let's compute the tree
+		 * that represents the "current" state for merge-recursive
+		 * to work on.
+		 */
+		if (write_cache_as_tree(head, 0, NULL))
+			die (_("Your index file is unmerged."));
+	} else {
+		if (get_sha1("HEAD", head))
+			return error(_("You do not have a valid HEAD"));
+		if (index_differs_from("HEAD", 0))
+			return error_dirty_index(opts);
+	}
+	discard_cache();
+
+	if (!commit->parents) {
+		parent = NULL;
+	}
+	else if (commit->parents->next) {
+		/* Reverting or cherry-picking a merge commit */
+		int cnt;
+		struct commit_list *p;
+
+		if (!opts->mainline)
+			return error(_("Commit %s is a merge but no -m option was given."),
+				sha1_to_hex(commit->object.sha1));
+
+		for (cnt = 1, p = commit->parents;
+		     cnt != opts->mainline && p;
+		     cnt++)
+			p = p->next;
+		if (cnt != opts->mainline || !p)
+			return error(_("Commit %s does not have parent %d"),
+				sha1_to_hex(commit->object.sha1), opts->mainline);
+		parent = p->item;
+	} else if (0 < opts->mainline)
+		return error(_("Mainline was specified but commit %s is not a merge."),
+			sha1_to_hex(commit->object.sha1));
+	else
+		parent = commit->parents->item;
+
+	if (opts->allow_ff && parent && !hashcmp(parent->object.sha1, head))
+		return fast_forward_to(commit->object.sha1, head);
+
+	if (parent && parse_commit(parent) < 0)
+		/* TRANSLATORS: The first %s will be "revert" or
+		   "cherry-pick", the second %s a SHA1 */
+		return error(_("%s: cannot parse parent commit %s"),
+			command_name(opts), sha1_to_hex(parent->object.sha1));
+
+	if (get_message(commit, &msg) != 0)
+		return error(_("Cannot get commit message for %s"),
+			sha1_to_hex(commit->object.sha1));
+
+	/*
+	 * "commit" is an existing commit.  We would want to apply
+	 * the difference it introduces since its first parent "prev"
+	 * on top of the current HEAD if we are cherry-pick.  Or the
+	 * reverse of it if we are revert.
+	 */
+
+	defmsg = git_pathdup("MERGE_MSG");
+
+	if (action == REPLAY_REVERT) {
+		base = commit;
+		base_label = msg.label;
+		next = parent;
+		next_label = msg.parent_label;
+		strbuf_addstr(&msgbuf, "Revert \"");
+		strbuf_addstr(&msgbuf, msg.subject);
+		strbuf_addstr(&msgbuf, "\"\n\nThis reverts commit ");
+		strbuf_addstr(&msgbuf, sha1_to_hex(commit->object.sha1));
+
+		if (commit->parents && commit->parents->next) {
+			strbuf_addstr(&msgbuf, ", reversing\nchanges made to ");
+			strbuf_addstr(&msgbuf, sha1_to_hex(parent->object.sha1));
+		}
+		strbuf_addstr(&msgbuf, ".\n");
+	} else {
+		const char *p;
+
+		base = parent;
+		base_label = msg.parent_label;
+		next = commit;
+		next_label = msg.label;
+
+		/*
+		 * Append the commit log message to msgbuf; it starts
+		 * after the tree, parent, author, committer
+		 * information followed by "\n\n".
+		 */
+		p = strstr(msg.message, "\n\n");
+		if (p) {
+			p += 2;
+			strbuf_addstr(&msgbuf, p);
+		}
+
+		if (opts->record_origin) {
+			strbuf_addstr(&msgbuf, "(cherry picked from commit ");
+			strbuf_addstr(&msgbuf, sha1_to_hex(commit->object.sha1));
+			strbuf_addstr(&msgbuf, ")\n");
+		}
+	}
+
+	if (!opts->strategy || !strcmp(opts->strategy, "recursive") || action == REPLAY_REVERT) {
+		res = do_recursive_merge(base, next, base_label, next_label,
+					 head, &msgbuf, opts);
+		write_message(&msgbuf, defmsg);
+	} else {
+		struct commit_list *common = NULL;
+		struct commit_list *remotes = NULL;
+
+		write_message(&msgbuf, defmsg);
+
+		commit_list_insert(base, &common);
+		commit_list_insert(next, &remotes);
+		res = try_merge_command(opts->strategy, opts->xopts_nr, opts->xopts,
+					common, sha1_to_hex(head), remotes);
+		free_commit_list(common);
+		free_commit_list(remotes);
+	}
+
+	/*
+	 * If the merge was clean or if it failed due to conflict, we write
+	 * CHERRY_PICK_HEAD for the subsequent invocation of commit to use.
+	 * However, if the merge did not even start, then we don't want to
+	 * write it at all.
+	 */
+	if (action == REPLAY_PICK && !opts->no_commit && (res == 0 || res == 1))
+		write_cherry_pick_head(commit, "CHERRY_PICK_HEAD");
+	if (action == REPLAY_REVERT && ((opts->no_commit && res == 0) || res == 1))
+		write_cherry_pick_head(commit, "REVERT_HEAD");
+
+	if (res) {
+		error(action == REPLAY_REVERT
+		      ? _("could not revert %s... %s")
+		      : _("could not apply %s... %s"),
+		      find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV),
+		      msg.subject);
+		print_advice(res == 1);
+		rerere(opts->allow_rerere_auto);
+	} else {
+		if (!opts->no_commit)
+			res = run_git_commit(defmsg, opts);
+	}
+
+	free_message(&msg);
+	free(defmsg);
+
+	return res;
+}
+
+static void prepare_revs(struct replay_opts *opts)
+{
+	if (opts->command != REPLAY_CMD_REVERT)
+		opts->revs->reverse ^= 1;
+
+	if (prepare_revision_walk(opts->revs))
+		die(_("revision walk setup failed"));
+
+	if (!opts->revs->commits)
+		die(_("empty commit set passed"));
+}
+
+static void read_and_refresh_cache(struct replay_opts *opts)
+{
+	static struct lock_file index_lock;
+	int index_fd = hold_locked_index(&index_lock, 0);
+	if (read_index_preload(&the_index, NULL) < 0)
+		die(_("git %s: failed to read the index"), command_name(opts));
+	refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED, NULL, NULL, NULL);
+	if (the_index.cache_changed) {
+		if (write_index(&the_index, index_fd) ||
+		    commit_locked_index(&index_lock))
+			die(_("git %s: failed to refresh the index"),
+				command_name(opts));
+	}
+	rollback_lock_file(&index_lock);
+}
+
+/*
+ * Append a (commit, action) to the end of the replay_insn_list.
+ *
+ * next starts by pointing to the variable that holds the head of an
+ * empty replay_insn_list, and is updated to point to the "next" field of
+ * the last item on the list as new (commit, action) pairs are appended.
+ *
+ * Usage example:
+ *
+ *     struct replay_insn_list *list;
+ *     struct replay_insn_list **next = &list;
+ *
+ *     next = replay_insn_list_append(c1, a1, next);
+ *     next = replay_insn_list_append(c2, a2, next);
+ *     assert(len(list) == 2);
+ *     return list;
+ */
+static struct replay_insn_list **replay_insn_list_append(struct commit *operand,
+							enum replay_action action,
+							struct replay_insn_list **next)
+{
+	struct replay_insn_list *new = xmalloc(sizeof(*new));
+	new->action = action;
+	new->operand = operand;
+	*next = new;
+	new->next = NULL;
+	return &new->next;
+}
+
+static int format_todo(struct strbuf *buf, struct replay_insn_list *todo_list)
+{
+	struct replay_insn_list *cur;
+
+	for (cur = todo_list; cur; cur = cur->next) {
+		const char *sha1_abbrev, *action_str, *subject;
+		int subject_len;
+
+		action_str = action_name(cur->action);
+		sha1_abbrev = find_unique_abbrev(cur->operand->object.sha1, DEFAULT_ABBREV);
+		subject_len = find_commit_subject(cur->operand->buffer, &subject);
+		strbuf_addf(buf, "%s %s %.*s\n", action_str, sha1_abbrev,
+			subject_len, subject);
+	}
+	return 0;
+}
+
+static int parse_insn_line(char *bol, char *eol,
+			struct replay_insn_list *item, int lineno)
+{
+	const char *todo_file = git_path(SEQ_TODO_FILE);
+	unsigned char commit_sha1[20];
+	char *end_of_object_name;
+	int saved, status;
+	size_t error_len;
+
+	if (!prefixcmp(bol, "pick ") || !prefixcmp(bol, "pick\t")) {
+		item->action = REPLAY_PICK;
+		bol += strlen("pick ");
+	} else if (!prefixcmp(bol, "revert ") || !prefixcmp(bol, "revert\t")) {
+		item->action = REPLAY_REVERT;
+		bol += strlen("revert ");
+	} else {
+		error_len = eol - bol > 255 ? 255 : eol - bol;
+		return error(_("%s:%d: Unrecognized action: %.*s"),
+			todo_file, lineno, (int)error_len, bol);
+	}
+
+	/* Eat up extra spaces/ tabs before object name */
+	bol += strspn(bol, " \t");
+
+	end_of_object_name = bol + strcspn(bol, " \t\n");
+	saved = *end_of_object_name;
+	*end_of_object_name = '\0';
+	status = get_sha1(bol, commit_sha1);
+	*end_of_object_name = saved;
+
+	if (status < 0) {
+		error_len = eol - bol > 255 ? 255 : eol - bol;
+		return error(_("%s:%d: Malformed object name: %.*s"),
+			todo_file, lineno, (int)error_len, bol);
+	}
+
+	item->operand = lookup_commit_reference(commit_sha1);
+	if (!item->operand) {
+		error_len = eol - bol > 255 ? 255 : eol - bol;
+		return error(_("%s:%d: Not a valid commit: %.*s"),
+			todo_file, lineno, (int)error_len, bol);
+	}
+
+	item->next = NULL;
+	return 0;
+}
+
+static int parse_insn_buffer(char *buf, struct replay_insn_list **todo_list)
+{
+	struct replay_insn_list **next = todo_list;
+	struct replay_insn_list item = { NULL, 0, NULL };
+	char *p = buf;
+	int i;
+
+	for (i = 1; *p; i++) {
+		char *eol = strchrnul(p, '\n');
+		if (parse_insn_line(p, eol, &item, i) < 0)
+			return -1;
+		next = replay_insn_list_append(item.operand, item.action, next);
+		p = *eol ? eol + 1 : eol;
+	}
+	if (!*todo_list)
+		return error(_("No commits parsed."));
+	return 0;
+}
+
+static void read_populate_todo(struct replay_insn_list **todo_list)
+{
+	const char *todo_file = git_path(SEQ_TODO_FILE);
+	struct strbuf buf = STRBUF_INIT;
+	int fd, res;
+
+	fd = open(todo_file, O_RDONLY);
+	if (fd < 0)
+		die_errno(_("Could not open %s"), todo_file);
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
+static void read_populate_opts(struct replay_opts **opts_ptr)
+{
+	const char *opts_file = git_path(SEQ_OPTS_FILE);
+
+	if (!file_exists(opts_file))
+		return;
+	if (git_config_from_file(populate_opts_cb, opts_file, *opts_ptr) < 0)
+		die(_("Malformed options sheet: %s"), opts_file);
+}
+
+static void walk_revs_populate_todo(struct replay_insn_list **todo_list,
+				struct replay_opts *opts)
+{
+	struct commit *commit;
+	struct replay_insn_list **next;
+	enum replay_action action;
+
+	prepare_revs(opts);
+
+	next = todo_list;
+	action = opts->command == REPLAY_CMD_REVERT ? REPLAY_REVERT : REPLAY_PICK;
+	while ((commit = get_revision(opts->revs)))
+		next = replay_insn_list_append(commit, action, next);
+}
+
+static int create_seq_dir(void)
+{
+	const char *seq_dir = git_path(SEQ_DIR);
+
+	if (file_exists(seq_dir)) {
+		error(_("a cherry-pick or revert is already in progress"));
+		advise(_("try \"git cherry-pick (--continue | --quit | --abort)\""));
+		return -1;
+	}
+	else if (mkdir(seq_dir, 0777) < 0)
+		die_errno(_("Could not create sequencer directory %s"), seq_dir);
+	return 0;
+}
+
+static enum replay_command read_cmd(void)
+{
+	const char *cmd_file = git_path(SEQ_CMD_FILE);
+	struct strbuf buf = STRBUF_INIT;
+	enum replay_command res;
+	int fd;
+
+	fd = open(cmd_file, O_RDONLY);
+	if (fd < 0)
+		die_errno(_("Could not open %s"), cmd_file);
+	if (strbuf_read(&buf, fd, 0) < 0) {
+		close(fd);
+		strbuf_release(&buf);
+		die(_("Could not read %s."), cmd_file);
+	}
+	close(fd);
+
+	if (!strcmp(buf.buf, "revert\n"))
+		res = REPLAY_CMD_REVERT;
+	else if (!strcmp(buf.buf, "cherry-pick\n"))
+		res = REPLAY_CMD_CHERRY_PICK;
+	else {
+		strbuf_release(&buf);
+		die(_("Malformed command file: %s"), cmd_file);
+	}
+	strbuf_release(&buf);
+	return res;
+}
+
+static void save_cmd(struct replay_opts *opts)
+{
+	const char *cmd_file = git_path(SEQ_CMD_FILE);
+	static struct lock_file cmd_lock;
+	struct strbuf buf = STRBUF_INIT;
+	int fd;
+
+	fd = hold_lock_file_for_update(&cmd_lock, cmd_file, LOCK_DIE_ON_ERROR);
+	strbuf_addf(&buf, "%s\n", command_name(opts));
+	if (write_in_full(fd, buf.buf, buf.len) < 0)
+		die_errno(_("Could not write to %s"), cmd_file);
+	if (commit_lock_file(&cmd_lock) < 0)
+		die(_("Error wrapping up %s."), cmd_file);
+}
+
+static void save_head(const char *head)
+{
+	const char *head_file = git_path(SEQ_HEAD_FILE);
+	static struct lock_file head_lock;
+	struct strbuf buf = STRBUF_INIT;
+	int fd;
+
+	fd = hold_lock_file_for_update(&head_lock, head_file, LOCK_DIE_ON_ERROR);
+	strbuf_addf(&buf, "%s\n", head);
+	if (write_in_full(fd, buf.buf, buf.len) < 0)
+		die_errno(_("Could not write to %s"), head_file);
+	if (commit_lock_file(&head_lock) < 0)
+		die(_("Error wrapping up %s."), head_file);
+}
+
+static int reset_for_rollback(const unsigned char *sha1)
+{
+	const char *argv[4];	/* reset --merge <arg> + NULL */
+	argv[0] = "reset";
+	argv[1] = "--merge";
+	argv[2] = sha1_to_hex(sha1);
+	argv[3] = NULL;
+	return run_command_v_opt(argv, RUN_GIT_CMD);
+}
+
+static int rollback_single_pick(void)
+{
+	unsigned char head_sha1[20];
+
+	if (!file_exists(git_path("CHERRY_PICK_HEAD")) &&
+	    !file_exists(git_path("REVERT_HEAD")))
+		return error(_("no cherry-pick or revert in progress"));
+	if (read_ref_full("HEAD", head_sha1, 0, NULL))
+		return error(_("cannot resolve HEAD"));
+	if (is_null_sha1(head_sha1))
+		return error(_("cannot abort from a branch yet to be born"));
+	return reset_for_rollback(head_sha1);
+}
+
+static int sequencer_rollback(struct replay_opts *opts)
+{
+	const char *filename;
+	FILE *f;
+	unsigned char sha1[20];
+	struct strbuf buf = STRBUF_INIT;
+
+	filename = git_path(SEQ_HEAD_FILE);
+	f = fopen(filename, "r");
+	if (!f && errno == ENOENT) {
+		/*
+		 * There is no multiple-cherry-pick in progress.
+		 * If CHERRY_PICK_HEAD or REVERT_HEAD indicates
+		 * a single-cherry-pick in progress, abort that.
+		 */
+		return rollback_single_pick();
+	}
+	if (!f)
+		return error(_("cannot open %s: %s"), filename,
+						strerror(errno));
+	if (strbuf_getline(&buf, f, '\n')) {
+		error(_("cannot read %s: %s"), filename, ferror(f) ?
+			strerror(errno) : _("unexpected end of file"));
+		fclose(f);
+		goto fail;
+	}
+	fclose(f);
+	if (get_sha1_hex(buf.buf, sha1) || buf.buf[40] != '\0') {
+		error(_("stored pre-cherry-pick HEAD file '%s' is corrupt"),
+			filename);
+		goto fail;
+	}
+	if (reset_for_rollback(sha1))
+		goto fail;
+	remove_sequencer_state();
+	strbuf_release(&buf);
+	return 0;
+fail:
+	strbuf_release(&buf);
+	return -1;
+}
+
+static void save_todo(struct replay_insn_list *todo_list)
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
+		die_errno(_("Could not write to %s"), todo_file);
+	}
+	if (commit_lock_file(&todo_lock) < 0) {
+		strbuf_release(&buf);
+		die(_("Error wrapping up %s."), todo_file);
+	}
+	strbuf_release(&buf);
+}
+
+static void save_opts(struct replay_opts *opts)
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
+
+static int pick_commits(struct replay_insn_list *todo_list, struct replay_opts *opts)
+{
+	struct replay_insn_list *cur;
+	int res;
+
+	setenv(GIT_REFLOG_ACTION, command_name(opts), 0);
+	if (opts->allow_ff)
+		assert(!(opts->signoff || opts->no_commit ||
+				opts->record_origin || opts->edit));
+	read_and_refresh_cache(opts);
+
+	for (cur = todo_list; cur; cur = cur->next) {
+		save_todo(cur);
+		res = do_pick_commit(cur->operand, cur->action, opts);
+		if (res)
+			return res;
+	}
+
+	/*
+	 * Sequence of picks finished successfully; cleanup by
+	 * removing the .git/sequencer directory
+	 */
+	remove_sequencer_state();
+	return 0;
+}
+
+static int continue_single_pick(void)
+{
+	const char *argv[] = { "commit", NULL };
+
+	if (!file_exists(git_path("CHERRY_PICK_HEAD")) &&
+	    !file_exists(git_path("REVERT_HEAD")))
+		return error(_("no cherry-pick or revert in progress"));
+	return run_command_v_opt(argv, RUN_GIT_CMD);
+}
+
+static int sequencer_continue(struct replay_opts *opts)
+{
+	struct replay_insn_list *todo_list = NULL;
+	enum replay_command cmd;
+
+	if (!file_exists(git_path(SEQ_TODO_FILE)))
+		return continue_single_pick();
+
+	/*
+	 * Disallow continuing a cherry-pick with 'git revert
+	 * --continue' and viceversa
+	 */
+	cmd = read_cmd();
+	if (cmd != opts->command)
+		return error(_("cannot %s: a %s is in progress."),
+			command_name(opts),
+			cmd == REPLAY_CMD_REVERT ? "revert" : "cherry-pick");
+
+	read_populate_opts(&opts);
+	read_populate_todo(&todo_list);
+
+	/* Verify that the conflict has been resolved */
+	if (file_exists(git_path("CHERRY_PICK_HEAD")) ||
+	    file_exists(git_path("REVERT_HEAD"))) {
+		int ret = continue_single_pick();
+		if (ret)
+			return ret;
+	}
+	if (index_differs_from("HEAD", 0))
+		return error_dirty_index(opts);
+	todo_list = todo_list->next;
+	return pick_commits(todo_list, opts);
+}
+
+static int single_pick(struct commit *cmit, struct replay_opts *opts)
+{
+	enum replay_action action;
+	action = opts->command == REPLAY_CMD_REVERT ? REPLAY_REVERT : REPLAY_PICK;
+
+	setenv(GIT_REFLOG_ACTION, command_name(opts), 0);
+	return do_pick_commit(cmit, action, opts);
+}
+
+int sequencer_pick_revisions(struct replay_opts *opts)
+{
+	struct replay_insn_list *todo_list = NULL;
+	unsigned char sha1[20];
+
+	if (opts->subcommand == REPLAY_NONE)
+		assert(opts->revs);
+
+	read_and_refresh_cache(opts);
+
+	/*
+	 * Decide what to do depending on the arguments; a fresh
+	 * cherry-pick should be handled differently from an existing
+	 * one that is being continued
+	 */
+	if (opts->subcommand == REPLAY_REMOVE_STATE) {
+		remove_sequencer_state();
+		return 0;
+	}
+	if (opts->subcommand == REPLAY_ROLLBACK)
+		return sequencer_rollback(opts);
+	if (opts->subcommand == REPLAY_CONTINUE)
+		return sequencer_continue(opts);
+
+	/*
+	 * If we were called as "git cherry-pick <commit>", just
+	 * cherry-pick/revert it, set CHERRY_PICK_HEAD /
+	 * REVERT_HEAD, and don't touch the sequencer state.
+	 * This means it is possible to cherry-pick in the middle
+	 * of a cherry-pick sequence.
+	 */
+	if (opts->revs->cmdline.nr == 1 &&
+	    opts->revs->cmdline.rev->whence == REV_CMD_REV &&
+	    opts->revs->no_walk &&
+	    !opts->revs->cmdline.rev->flags) {
+		struct commit *cmit;
+		if (prepare_revision_walk(opts->revs))
+			die(_("revision walk setup failed"));
+		cmit = get_revision(opts->revs);
+		if (!cmit || get_revision(opts->revs))
+			die("BUG: expected exactly one commit from walk");
+		return single_pick(cmit, opts);
+	}
+
+	/*
+	 * Start a new cherry-pick/ revert sequence; but
+	 * first, make sure that an existing one isn't in
+	 * progress
+	 */
+
+	walk_revs_populate_todo(&todo_list, opts);
+	if (create_seq_dir() < 0)
+		return -1;
+	if (get_sha1("HEAD", sha1)) {
+		if (opts->command == REPLAY_CMD_REVERT)
+			return error(_("Can't revert as initial commit"));
+		return error(_("Can't cherry-pick into empty head"));
+	}
+	save_cmd(opts);
+	save_head(sha1_to_hex(sha1));
+	save_opts(opts);
+	return pick_commits(todo_list, opts);
+}
diff --git a/sequencer.h b/sequencer.h
index d1cb5c2..58482f1 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -24,6 +24,29 @@ enum replay_subcommand {
 	REPLAY_ROLLBACK
 };
 
+struct replay_opts {
+	enum replay_command command;
+	enum replay_subcommand subcommand;
+
+	/* Boolean options */
+	int edit;
+	int record_origin;
+	int no_commit;
+	int signoff;
+	int allow_ff;
+	int allow_rerere_auto;
+
+	int mainline;
+
+	/* Merge strategy */
+	const char *strategy;
+	const char **xopts;
+	size_t xopts_nr, xopts_alloc;
+
+	/* Only used by REPLAY_NONE */
+	struct rev_info *revs;
+};
+
 struct replay_insn_list {
 	struct commit *operand;
 	enum replay_action action;
@@ -33,4 +56,6 @@ struct replay_insn_list {
 /* Removes SEQ_DIR. */
 extern void remove_sequencer_state(void);
 
+int sequencer_pick_revisions(struct replay_opts *opts);
+
 #endif
-- 
1.7.8.2
