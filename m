From: Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH 1/6] revert: libify cherry-pick and revert functionnality
Date: Mon, 01 Feb 2010 08:55:36 +0100
Message-ID: <20100201075542.3929.38404.chriscool@tuxfamily.org>
References: <20100201074835.3929.11509.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 01 08:53:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nbr6B-0005ho-Pe
	for gcvg-git-2@lo.gmane.org; Mon, 01 Feb 2010 08:53:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754147Ab0BAHxO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2010 02:53:14 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:49828 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751845Ab0BAHw4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2010 02:52:56 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id DFB9C818040;
	Mon,  1 Feb 2010 08:52:48 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id AE1778180D6;
	Mon,  1 Feb 2010 08:52:45 +0100 (CET)
X-git-sha1: c6a57b43339a697df16f2ba61b3bcc5890b41c4d 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20100201074835.3929.11509.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138591>

From: Stephan Beyer <s-beyer@gmx.net>

The goal of this commit is to abstract out "git cherry-pick" and
"git revert" functionnality into a new pick_commit() function made
of code from "builtin-revert.c".

The new pick_commit() function is in a new "pick.c" file with an
associated "pick.h".

This function starts from the current index (not HEAD), and allow
the effect of one commit replayed (either forward or backward) to
that state, leaving the result in the index. So it makes it
possible to replay many commits to the index in sequence without
commiting in between.

This commit is made of code from the sequencer GSoC project:

git://repo.or.cz/git/sbeyer.git

(at commit 5a78908b70ceb5a4ea9fd4b82f07ceba1f019079)

And it contains some changes and comments suggested by Junio.

The original commit in the sequencer project that introduced
this change is: 94a568a78d243d7a6c13778bc6b7ac1eb46e48cc

Mentored-by: Daniel Barkalow <barkalow@iabervon.org>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Makefile         |    2 +
 builtin-revert.c |  272 +++++++++---------------------------------------------
 pick.c           |  218 +++++++++++++++++++++++++++++++++++++++++++
 pick.h           |   13 +++
 4 files changed, 277 insertions(+), 228 deletions(-)
 create mode 100644 pick.c
 create mode 100644 pick.h

diff --git a/Makefile b/Makefile
index d624530..71901c8 100644
--- a/Makefile
+++ b/Makefile
@@ -458,6 +458,7 @@ LIB_H += pack-refs.h
 LIB_H += pack-revindex.h
 LIB_H += parse-options.h
 LIB_H += patch-ids.h
+LIB_H += pick.h
 LIB_H += pkt-line.h
 LIB_H += progress.h
 LIB_H += quote.h
@@ -550,6 +551,7 @@ LIB_OBJS += parse-options.o
 LIB_OBJS += patch-delta.o
 LIB_OBJS += patch-ids.o
 LIB_OBJS += path.o
+LIB_OBJS += pick.o
 LIB_OBJS += pkt-line.o
 LIB_OBJS += preload-index.o
 LIB_OBJS += pretty.o
diff --git a/builtin-revert.c b/builtin-revert.c
index 8ac86f0..3cbeab7 100644
--- a/builtin-revert.c
+++ b/builtin-revert.c
@@ -1,18 +1,14 @@
 #include "cache.h"
 #include "builtin.h"
-#include "object.h"
 #include "commit.h"
 #include "tag.h"
-#include "wt-status.h"
-#include "run-command.h"
 #include "exec_cmd.h"
 #include "utf8.h"
 #include "parse-options.h"
-#include "cache-tree.h"
 #include "diff.h"
 #include "revision.h"
 #include "rerere.h"
-#include "merge-recursive.h"
+#include "pick.h"
 
 /*
  * This implements the builtins revert and cherry-pick.
@@ -35,26 +31,24 @@ static const char * const cherry_pick_usage[] = {
 	NULL
 };
 
-static int edit, no_replay, no_commit, mainline, signoff;
-static enum { REVERT, CHERRY_PICK } action;
+static int edit, no_commit, mainline, signoff;
+static int flags;
 static struct commit *commit;
 static int allow_rerere_auto;
 
-static const char *me;
-
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
 static void parse_args(int argc, const char **argv)
 {
 	const char * const * usage_str =
-		action == REVERT ?  revert_usage : cherry_pick_usage;
+		flags & PICK_REVERSE ? revert_usage : cherry_pick_usage;
 	unsigned char sha1[20];
 	const char *arg;
 	int noop;
 	struct option options[] = {
 		OPT_BOOLEAN('n', "no-commit", &no_commit, "don't automatically commit"),
 		OPT_BOOLEAN('e', "edit", &edit, "edit the commit message"),
-		OPT_BOOLEAN('x', NULL, &no_replay, "append commit name when cherry-picking"),
+		OPT_BIT('x', NULL, &flags, "append commit name when cherry-picking", PICK_ADD_NOTE),
 		OPT_BOOLEAN('r', NULL, &noop, "no-op (backward compatibility)"),
 		OPT_BOOLEAN('s', "signoff", &signoff, "add Signed-off-by:"),
 		OPT_INTEGER('m', "mainline", &mainline, "parent number"),
@@ -79,42 +73,12 @@ static void parse_args(int argc, const char **argv)
 		die ("'%s' does not point to a commit", arg);
 }
 
-static char *get_oneline(const char *message)
-{
-	char *result;
-	const char *p = message, *abbrev, *eol;
-	int abbrev_len, oneline_len;
-
-	if (!p)
-		die ("Could not read commit message of %s",
-				sha1_to_hex(commit->object.sha1));
-	while (*p && (*p != '\n' || p[1] != '\n'))
-		p++;
-
-	if (*p) {
-		p += 2;
-		for (eol = p + 1; *eol && *eol != '\n'; eol++)
-			; /* do nothing */
-	} else
-		eol = p;
-	abbrev = find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV);
-	abbrev_len = strlen(abbrev);
-	oneline_len = eol - p;
-	result = xmalloc(abbrev_len + 5 + oneline_len);
-	memcpy(result, abbrev, abbrev_len);
-	memcpy(result + abbrev_len, "... ", 4);
-	memcpy(result + abbrev_len + 4, p, oneline_len);
-	result[abbrev_len + 4 + oneline_len] = '\0';
-	return result;
-}
-
 static char *get_encoding(const char *message)
 {
 	const char *p = message, *eol;
 
 	if (!p)
-		die ("Could not read commit message of %s",
-				sha1_to_hex(commit->object.sha1));
+		return NULL;
 	while (*p && *p != '\n') {
 		for (eol = p + 1; *eol && *eol != '\n'; eol++)
 			; /* do nothing */
@@ -130,30 +94,6 @@ static char *get_encoding(const char *message)
 	return NULL;
 }
 
-static struct lock_file msg_file;
-static int msg_fd;
-
-static void add_to_msg(const char *string)
-{
-	int len = strlen(string);
-	if (write_in_full(msg_fd, string, len) < 0)
-		die_errno ("Could not write to MERGE_MSG");
-}
-
-static void add_message_to_msg(const char *message)
-{
-	const char *p = message;
-	while (*p && (*p != '\n' || p[1] != '\n'))
-		p++;
-
-	if (!*p)
-		add_to_msg(sha1_to_hex(commit->object.sha1));
-
-	p += 2;
-	add_to_msg(p);
-	return;
-}
-
 static void set_author_ident_env(const char *message)
 {
 	const char *p = message;
@@ -216,7 +156,7 @@ static char *help_msg(const unsigned char *sha1)
 	       "mark the corrected paths with 'git add <paths>' "
 	       "or 'git rm <paths>' and commit the result.");
 
-	if (action == CHERRY_PICK) {
+	if (!(flags & PICK_REVERSE)) {
 		sprintf(helpbuf + strlen(helpbuf),
 			"\nWhen commiting, use the option "
 			"'-c %s' to retain authorship and message.",
@@ -225,14 +165,17 @@ static char *help_msg(const unsigned char *sha1)
 	return helpbuf;
 }
 
-static struct tree *empty_tree(void)
+static void write_message(struct strbuf *msgbuf, const char *filename)
 {
-	struct tree *tree = xcalloc(1, sizeof(struct tree));
-
-	tree->object.parsed = 1;
-	tree->object.type = OBJ_TREE;
-	pretend_sha1_file(NULL, 0, OBJ_TREE, tree->object.sha1);
-	return tree;
+	struct lock_file msg_file;
+	int msg_fd;
+	msg_fd = hold_lock_file_for_update(&msg_file, filename,
+					   LOCK_DIE_ON_ERROR);
+	if (write_in_full(msg_fd, msgbuf->buf, msgbuf->len) < 0)
+		die_errno("Could not write to %s.", filename);
+	strbuf_release(msgbuf);
+	if (commit_lock_file(&msg_file) < 0)
+		die("Error wrapping up %s", filename);
 }
 
 static NORETURN void die_dirty_index(const char *me)
@@ -250,175 +193,53 @@ static NORETURN void die_dirty_index(const char *me)
 
 static int revert_or_cherry_pick(int argc, const char **argv)
 {
-	unsigned char head[20];
-	struct commit *base, *next, *parent;
-	int i, index_fd, clean;
-	char *oneline, *reencoded_message = NULL;
-	const char *message, *encoding;
-	char *defmsg = git_pathdup("MERGE_MSG");
-	struct merge_options o;
-	struct tree *result, *next_tree, *base_tree, *head_tree;
-	static struct lock_file index_lock;
+	const char *me;
+	struct strbuf msgbuf;
+	char *reencoded_message = NULL;
+	const char *encoding;
+	int failed;
 
 	git_config(git_default_config, NULL);
-	me = action == REVERT ? "revert" : "cherry-pick";
+	me = flags & PICK_REVERSE ? "revert" : "cherry-pick";
 	setenv(GIT_REFLOG_ACTION, me, 0);
 	parse_args(argc, argv);
 
-	/* this is copied from the shell script, but it's never triggered... */
-	if (action == REVERT && !no_replay)
-		die("revert is incompatible with replay");
-
 	if (read_cache() < 0)
 		die("git %s: failed to read the index", me);
-	if (no_commit) {
-		/*
-		 * We do not intend to commit immediately.  We just want to
-		 * merge the differences in, so let's compute the tree
-		 * that represents the "current" state for merge-recursive
-		 * to work on.
-		 */
-		if (write_cache_as_tree(head, 0, NULL))
-			die ("Your index file is unmerged.");
-	} else {
-		if (get_sha1("HEAD", head))
-			die ("You do not have a valid HEAD");
-		if (index_differs_from("HEAD", 0))
-			die_dirty_index(me);
-	}
-	discard_cache();
-
-	index_fd = hold_locked_index(&index_lock, 1);
+	if (!no_commit && index_differs_from("HEAD", 0))
+		die_dirty_index(me);
 
-	if (!commit->parents) {
-		if (action == REVERT)
-			die ("Cannot revert a root commit");
-		parent = NULL;
-	}
-	else if (commit->parents->next) {
-		/* Reverting or cherry-picking a merge commit */
-		int cnt;
-		struct commit_list *p;
-
-		if (!mainline)
-			die("Commit %s is a merge but no -m option was given.",
-			    sha1_to_hex(commit->object.sha1));
-
-		for (cnt = 1, p = commit->parents;
-		     cnt != mainline && p;
-		     cnt++)
-			p = p->next;
-		if (cnt != mainline || !p)
-			die("Commit %s does not have parent %d",
-			    sha1_to_hex(commit->object.sha1), mainline);
-		parent = p->item;
-	} else if (0 < mainline)
-		die("Mainline was specified but commit %s is not a merge.",
-		    sha1_to_hex(commit->object.sha1));
-	else
-		parent = commit->parents->item;
-
-	if (!(message = commit->buffer))
-		die ("Cannot get commit message for %s",
+	if (!commit->buffer)
+		return error("Cannot get commit message for %s",
 				sha1_to_hex(commit->object.sha1));
-
-	if (parent && parse_commit(parent) < 0)
-		die("%s: cannot parse parent commit %s",
-		    me, sha1_to_hex(parent->object.sha1));
-
-	/*
-	 * "commit" is an existing commit.  We would want to apply
-	 * the difference it introduces since its first parent "prev"
-	 * on top of the current HEAD if we are cherry-pick.  Or the
-	 * reverse of it if we are revert.
-	 */
-
-	msg_fd = hold_lock_file_for_update(&msg_file, defmsg,
-					   LOCK_DIE_ON_ERROR);
-
-	encoding = get_encoding(message);
+	encoding = get_encoding(commit->buffer);
 	if (!encoding)
 		encoding = "UTF-8";
 	if (!git_commit_encoding)
 		git_commit_encoding = "UTF-8";
-	if ((reencoded_message = reencode_string(message,
+	if ((reencoded_message = reencode_string(commit->buffer,
 					git_commit_encoding, encoding)))
-		message = reencoded_message;
-
-	oneline = get_oneline(message);
-
-	if (action == REVERT) {
-		char *oneline_body = strchr(oneline, ' ');
-
-		base = commit;
-		next = parent;
-		add_to_msg("Revert \"");
-		add_to_msg(oneline_body + 1);
-		add_to_msg("\"\n\nThis reverts commit ");
-		add_to_msg(sha1_to_hex(commit->object.sha1));
-
-		if (commit->parents->next) {
-			add_to_msg(", reversing\nchanges made to ");
-			add_to_msg(sha1_to_hex(parent->object.sha1));
-		}
-		add_to_msg(".\n");
-	} else {
-		base = parent;
-		next = commit;
-		set_author_ident_env(message);
-		add_message_to_msg(message);
-		if (no_replay) {
-			add_to_msg("(cherry picked from commit ");
-			add_to_msg(sha1_to_hex(commit->object.sha1));
-			add_to_msg(")\n");
-		}
-	}
-
-	read_cache();
-	init_merge_options(&o);
-	o.branch1 = "HEAD";
-	o.branch2 = oneline;
+		commit->buffer = reencoded_message;
 
-	head_tree = parse_tree_indirect(head);
-	next_tree = next ? next->tree : empty_tree();
-	base_tree = base ? base->tree : empty_tree();
-
-	clean = merge_trees(&o,
-			    head_tree,
-			    next_tree, base_tree, &result);
-
-	if (active_cache_changed &&
-	    (write_cache(index_fd, active_cache, active_nr) ||
-	     commit_locked_index(&index_lock)))
-		die("%s: Unable to write new index file", me);
-	rollback_lock_file(&index_lock);
-
-	if (!clean) {
-		add_to_msg("\nConflicts:\n\n");
-		for (i = 0; i < active_nr;) {
-			struct cache_entry *ce = active_cache[i++];
-			if (ce_stage(ce)) {
-				add_to_msg("\t");
-				add_to_msg(ce->name);
-				add_to_msg("\n");
-				while (i < active_nr && !strcmp(ce->name,
-						active_cache[i]->name))
-					i++;
-			}
-		}
-		if (commit_lock_file(&msg_file) < 0)
-			die ("Error wrapping up %s", defmsg);
+	failed = pick_commit(commit, mainline, flags, &msgbuf);
+	if (failed < 0) {
+		exit(1);
+	} else if (failed > 0) {
 		fprintf(stderr, "Automatic %s failed.%s\n",
 			me, help_msg(commit->object.sha1));
+		write_message(&msgbuf, git_path("MERGE_MSG"));
 		rerere(allow_rerere_auto);
 		exit(1);
 	}
-	if (commit_lock_file(&msg_file) < 0)
-		die ("Error wrapping up %s", defmsg);
+	if (!(flags & PICK_REVERSE))
+		set_author_ident_env(commit->buffer);
+	free(reencoded_message);
+
 	fprintf(stderr, "Finished one %s.\n", me);
 
+	write_message(&msgbuf, git_path("MERGE_MSG"));
+
 	/*
-	 *
 	 * If we are cherry-pick, and if the merge did not result in
 	 * hand-editing, we will hit this commit and inherit the original
 	 * author date and name.
@@ -436,14 +257,11 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 			args[i++] = "-s";
 		if (!edit) {
 			args[i++] = "-F";
-			args[i++] = defmsg;
+			args[i++] = git_path("MERGE_MSG");
 		}
 		args[i] = NULL;
 		return execv_git_cmd(args);
 	}
-	free(reencoded_message);
-	free(defmsg);
-
 	return 0;
 }
 
@@ -451,14 +269,12 @@ int cmd_revert(int argc, const char **argv, const char *prefix)
 {
 	if (isatty(0))
 		edit = 1;
-	no_replay = 1;
-	action = REVERT;
+	flags = PICK_REVERSE | PICK_ADD_NOTE;
 	return revert_or_cherry_pick(argc, argv);
 }
 
 int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
 {
-	no_replay = 0;
-	action = CHERRY_PICK;
+	flags = 0;
 	return revert_or_cherry_pick(argc, argv);
 }
diff --git a/pick.c b/pick.c
new file mode 100644
index 0000000..bb04c68
--- /dev/null
+++ b/pick.c
@@ -0,0 +1,218 @@
+#include "cache.h"
+#include "commit.h"
+#include "run-command.h"
+#include "cache-tree.h"
+#include "pick.h"
+#include "merge-recursive.h"
+
+static struct commit *commit;
+
+static char *get_oneline(const char *message)
+{
+	char *result;
+	const char *p = message, *abbrev, *eol;
+	int abbrev_len, oneline_len;
+
+	if (!p)
+		return NULL;
+	while (*p && (*p != '\n' || p[1] != '\n'))
+		p++;
+
+	if (*p) {
+		p += 2;
+		for (eol = p + 1; *eol && *eol != '\n'; eol++)
+			; /* do nothing */
+	} else
+		eol = p;
+	abbrev = find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV);
+	abbrev_len = strlen(abbrev);
+	oneline_len = eol - p;
+	result = xmalloc(abbrev_len + 5 + oneline_len);
+	memcpy(result, abbrev, abbrev_len);
+	memcpy(result + abbrev_len, "... ", 4);
+	memcpy(result + abbrev_len + 4, p, oneline_len);
+	result[abbrev_len + 4 + oneline_len] = '\0';
+	return result;
+}
+
+static void add_message_to_msg(struct strbuf *msg, const char *message)
+{
+	const char *p = message;
+	while (*p && (*p != '\n' || p[1] != '\n'))
+		p++;
+
+	if (!*p)
+		strbuf_addstr(msg, sha1_to_hex(commit->object.sha1));
+
+	p += 2;
+	strbuf_addstr(msg, p);
+	return;
+}
+
+static struct tree *empty_tree(void)
+{
+	struct tree *tree = xcalloc(1, sizeof(struct tree));
+
+	tree->object.parsed = 1;
+	tree->object.type = OBJ_TREE;
+	pretend_sha1_file(NULL, 0, OBJ_TREE, tree->object.sha1);
+	return tree;
+}
+
+/*
+ * Pick changes introduced by "commit" argument into current working
+ * tree and index.
+ *
+ * It starts from the current index (not HEAD), and allow the effect
+ * of one commit replayed (either forward or backward) to that state,
+ * leaving the result in the index.
+ *
+ * You do not have to start from a commit, so you can replay many commits
+ * to the index in sequence without commiting in between to squash multiple
+ * steps if you wanted to.
+ *
+ * Return 0 on success.
+ * Return negative value on error before picking,
+ * and a positive value after picking,
+ * and return 1 if and only if a conflict occurs but no other error.
+ */
+int pick_commit(struct commit *pick_commit, int mainline, int flags,
+		struct strbuf *msg)
+{
+	unsigned char head[20];
+	struct commit *base, *next, *parent;
+	int i, index_fd, clean;
+	int ret = 0;
+	char *oneline;
+	const char *message;
+	struct merge_options o;
+	struct tree *result, *next_tree, *base_tree, *head_tree;
+	static struct lock_file index_lock;
+
+	strbuf_init(msg, 0);
+	commit = pick_commit;
+
+	/*
+	 * Let's compute the tree that represents the "current" state
+	 * for merge-recursive to work on.
+	 */
+	if (write_cache_as_tree(head, 0, NULL))
+		return error("Your index file is unmerged.");
+	discard_cache();
+
+	index_fd = hold_locked_index(&index_lock, 0);
+	if (index_fd < 0)
+		return error("Unable to create locked index: %s",
+			     strerror(errno));
+
+	if (!commit->parents) {
+		if (flags & PICK_REVERSE)
+			return error("Cannot revert a root commit");
+		parent = NULL;
+	}
+	else if (commit->parents->next) {
+		/* Reverting or cherry-picking a merge commit */
+		int cnt;
+		struct commit_list *p;
+
+		if (!mainline)
+			return error("Commit %s is a merge but no mainline was given.",
+				     sha1_to_hex(commit->object.sha1));
+
+		for (cnt = 1, p = commit->parents;
+		     cnt != mainline && p;
+		     cnt++)
+			p = p->next;
+		if (cnt != mainline || !p)
+			return error("Commit %s does not have parent %d",
+				     sha1_to_hex(commit->object.sha1),
+				     mainline);
+		parent = p->item;
+	} else if (0 < mainline)
+		return error("Mainline was specified but commit %s is not a merge.",
+			     sha1_to_hex(commit->object.sha1));
+	else
+		parent = commit->parents->item;
+
+	if (!(message = commit->buffer))
+		return error("Cannot get commit message for %s",
+			     sha1_to_hex(commit->object.sha1));
+
+	if (parent && parse_commit(parent) < 0)
+		return error("Cannot parse parent commit %s",
+			     sha1_to_hex(parent->object.sha1));
+
+	oneline = get_oneline(message);
+
+	if (flags & PICK_REVERSE) {
+		char *oneline_body = strchr(oneline, ' ');
+
+		base = commit;
+		next = parent;
+		strbuf_addstr(msg, "Revert \"");
+		strbuf_addstr(msg, oneline_body + 1);
+		strbuf_addstr(msg, "\"\n\nThis reverts commit ");
+		strbuf_addstr(msg, sha1_to_hex(commit->object.sha1));
+
+		if (commit->parents->next) {
+			strbuf_addstr(msg, ", reversing\nchanges made to ");
+			strbuf_addstr(msg, sha1_to_hex(parent->object.sha1));
+		}
+		strbuf_addstr(msg, ".\n");
+	} else {
+		base = parent;
+		next = commit;
+		add_message_to_msg(msg, message);
+		if (flags & PICK_ADD_NOTE) {
+			strbuf_addstr(msg, "(cherry picked from commit ");
+			strbuf_addstr(msg, sha1_to_hex(commit->object.sha1));
+			strbuf_addstr(msg, ")\n");
+		}
+	}
+
+	read_cache();
+	init_merge_options(&o);
+	o.branch1 = "HEAD";
+	o.branch2 = oneline;
+
+	head_tree = parse_tree_indirect(head);
+	next_tree = next ? next->tree : empty_tree();
+	base_tree = base ? base->tree : empty_tree();
+
+	clean = merge_trees(&o,
+			    head_tree,
+			    next_tree, base_tree, &result);
+
+	if (active_cache_changed &&
+	    (write_cache(index_fd, active_cache, active_nr) ||
+	     commit_locked_index(&index_lock))) {
+		error("Unable to write new index file");
+		return 2;
+	}
+	rollback_lock_file(&index_lock);
+
+	if (!clean) {
+		strbuf_addstr(msg, "\nConflicts:\n\n");
+		for (i = 0; i < active_nr;) {
+			struct cache_entry *ce = active_cache[i++];
+			if (ce_stage(ce)) {
+				strbuf_addstr(msg, "\t");
+				strbuf_addstr(msg, ce->name);
+				strbuf_addstr(msg, "\n");
+				while (i < active_nr && !strcmp(ce->name,
+						active_cache[i]->name))
+					i++;
+			}
+		}
+		ret = 1;
+	}
+	free(oneline);
+
+	discard_cache();
+	if (read_cache() < 0) {
+		error("Cannot read the index");
+		return 2;
+	}
+
+	return ret;
+}
diff --git a/pick.h b/pick.h
new file mode 100644
index 0000000..7a74ad8
--- /dev/null
+++ b/pick.h
@@ -0,0 +1,13 @@
+#ifndef PICK_H
+#define PICK_H
+
+#include "commit.h"
+
+/* Pick flags: */
+#define PICK_REVERSE   1 /* pick the reverse changes ("revert") */
+#define PICK_ADD_NOTE  2 /* add note about original commit (unless conflict) */
+/* We don't need a PICK_QUIET. This is done by
+ *	setenv("GIT_MERGE_VERBOSITY", "0", 1); */
+extern int pick_commit(struct commit *commit, int mainline, int flags, struct strbuf *msg);
+
+#endif
-- 
1.6.6.1.557.g77031
