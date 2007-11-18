From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] builtin-commit: fix partial-commit support
Date: Sun, 18 Nov 2007 02:21:27 -0800
Message-ID: <1195381287-26823-4-git-send-email-gitster@pobox.com>
References: <1195381287-26823-1-git-send-email-gitster@pobox.com>
 <1195381287-26823-2-git-send-email-gitster@pobox.com>
 <1195381287-26823-3-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 18 11:22:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IthHs-0007vO-V5
	for gcvg-git-2@gmane.org; Sun, 18 Nov 2007 11:22:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753117AbXKRKVn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Nov 2007 05:21:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752148AbXKRKVm
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Nov 2007 05:21:42 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:44241 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752928AbXKRKVl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2007 05:21:41 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 208C52EF
	for <git@vger.kernel.org>; Sun, 18 Nov 2007 05:22:02 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id BD0EC96154
	for <git@vger.kernel.org>; Sun, 18 Nov 2007 05:22:00 -0500 (EST)
X-Mailer: git-send-email 1.5.3.5.1815.g9445b
In-Reply-To: <1195381287-26823-3-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65359>

When making a partial-commit, we need to prepare two index
files, one to be used to write out the tree to be committed
(temporary index) and the other to be used as the index file
after the commit is made.

The temporary index needs to be initialized to HEAD and then all
the named paths on the command line need to be staged on top of
the index.  For this, running add_files_to_cache() that compares
what is in the index and the paths given from the command line
is not enough -- the comparison will miss the paths that the
user previously ran "git add" to the index since the HEAD
because the index reset to the HEAD would not know about them.
The index file needs to get the same modification done when
preparing the temporary index as described above.

This implementation mimics the behaviour of the scripted
version of git-commit.  It first runs overlay_tree_on_cache(),
which was stolen from ls-files with the earlier change, to get
the list of paths that the user can potentially mean, and then
uses pathspec_match() to find which ones the user meant.  This
list of paths is used to update both the temporary and the real
index file.

Additionally:

 - remove the temporary index file .git/next-index-* after
   commit is done or aborted.

 - run post-commit hook with the real index file to be used
   after the commit (previously it gave the temporary commit if
   a partial commit was made).

 - resurrect the safety mechanism to refuse partial commits
   during a merge to match the scripted version.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-commit.c |  245 +++++++++++++++++++++++++++++++++++++++++++++---------
 1 files changed, 205 insertions(+), 40 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 3e7d281..e487bc0 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -7,6 +7,7 @@
 
 #include "cache.h"
 #include "cache-tree.h"
+#include "dir.h"
 #include "builtin.h"
 #include "diff.h"
 #include "diffcore.h"
@@ -19,6 +20,7 @@
 #include "strbuf.h"
 #include "utf8.h"
 #include "parse-options.h"
+#include "path-list.h"
 
 static const char * const builtin_commit_usage[] = {
 	"git-commit [options] [--] <filepattern>...",
@@ -28,7 +30,13 @@ static const char * const builtin_commit_usage[] = {
 static unsigned char head_sha1[20], merge_head_sha1[20];
 static char *use_message_buffer;
 static const char commit_editmsg[] = "COMMIT_EDITMSG";
-static struct lock_file lock_file;
+static struct lock_file index_lock; /* real index */
+static struct lock_file false_lock; /* used only for partial commits */
+static enum {
+	COMMIT_AS_IS = 1,
+	COMMIT_NORMAL,
+	COMMIT_PARTIAL,
+} commit_style;
 
 static char *logfile, *force_author, *template_file;
 static char *edit_message, *use_message;
@@ -78,41 +86,182 @@ static struct option builtin_commit_options[] = {
 	OPT_END()
 };
 
+static void rollback_index_files(void)
+{
+	switch (commit_style) {
+	case COMMIT_AS_IS:
+		break; /* nothing to do */
+	case COMMIT_NORMAL:
+		rollback_lock_file(&index_lock);
+		break;
+	case COMMIT_PARTIAL:
+		rollback_lock_file(&index_lock);
+		rollback_lock_file(&false_lock);
+		break;
+	}
+}
+
+static void commit_index_files(void)
+{
+	switch (commit_style) {
+	case COMMIT_AS_IS:
+		break; /* nothing to do */
+	case COMMIT_NORMAL:
+		commit_lock_file(&index_lock);
+		break;
+	case COMMIT_PARTIAL:
+		commit_lock_file(&index_lock);
+		rollback_lock_file(&false_lock);
+		break;
+	}
+}
+
+/*
+ * Take a union of paths in the index and the named tree (typically, "HEAD"),
+ * and return the paths that match the given pattern in list.
+ */
+static int list_paths(struct path_list *list, const char *with_tree,
+		      const char *prefix, const char **pattern)
+{
+	struct dir_struct dir;
+	int i;
+	char *m;
+
+	for (i = 0; pattern[i]; i++)
+		;
+	m = xcalloc(1, i);
+
+	memset(&dir, 0, sizeof(dir));
+	if (with_tree)
+		overlay_tree_on_cache(with_tree, prefix);
+
+	for (i = 0; i < active_nr; i++) {
+		struct cache_entry *ce = active_cache[i];
+		if (ce->ce_flags & htons(CE_UPDATE))
+			continue;
+		if (!pathspec_match(pattern, m, ce->name, 0))
+			continue;
+		if (excluded(&dir, ce->name))
+			continue;
+		path_list_insert(ce->name, list);
+	}
+
+	return report_path_error(m, pattern, prefix ? strlen(prefix) : 0);
+}
+
+static void add_remove_files(struct path_list *list)
+{
+	int i;
+	for (i = 0; i < list->nr; i++) {
+		struct path_list_item *p = &(list->items[i]);
+		if (file_exists(p->path))
+			add_file_to_cache(p->path, 0);
+		else
+			remove_file_from_cache(p->path);
+	}
+}
+
 static char *prepare_index(const char **files, const char *prefix)
 {
 	int fd;
 	struct tree *tree;
-	struct lock_file *next_index_lock;
+	struct path_list partial;
+	const char **pathspec = NULL;
 
 	if (interactive) {
 		interactive_add();
+		commit_style = COMMIT_NORMAL;
 		return get_index_file();
 	}
 
-	fd = hold_locked_index(&lock_file, 1);
 	if (read_cache() < 0)
 		die("index file corrupt");
 
-	if (all || also) {
-		add_files_to_cache(verbose, also ? prefix : NULL, files);
+	if (*files)
+		pathspec = get_pathspec(prefix, files);
+
+	/*
+	 * Non partial, non as-is commit.
+	 *
+	 * (1) get the real index;
+	 * (2) update the_index as necessary;
+	 * (3) write the_index out to the real index (still locked);
+	 * (4) return the name of the locked index file.
+	 *
+	 * The caller should run hooks on the locked real index, and
+	 * (A) if all goes well, commit the real index;
+	 * (B) on failure, rollback the real index.
+	 */
+	if (all || (also && pathspec && *pathspec)) {
+		int fd = hold_locked_index(&index_lock, 1);
+		add_files_to_cache(0, also ? prefix : NULL, pathspec);
 		refresh_cache(REFRESH_QUIET);
 		if (write_cache(fd, active_cache, active_nr) || close(fd))
 			die("unable to write new_index file");
-		return lock_file.filename;
+		commit_style = COMMIT_NORMAL;
+		return index_lock.filename;
 	}
 
-	if (*files == NULL) {
-		/* Commit index as-is. */
-		rollback_lock_file(&lock_file);
+	/*
+	 * As-is commit.
+	 *
+	 * (1) return the name of the real index file.
+	 *
+	 * The caller should run hooks on the real index, and run
+	 * hooks on the real index, and create commit from the_index.
+	 * We still need to refresh the index here.
+	 */
+	if (!pathspec || !*pathspec) {
+		fd = hold_locked_index(&index_lock, 1);
+		refresh_cache(REFRESH_QUIET);
+		if (write_cache(fd, active_cache, active_nr) ||
+		    close(fd) || commit_locked_index(&index_lock))
+			die("unable to write new_index file");
+		commit_style = COMMIT_AS_IS;
 		return get_index_file();
 	}
 
-	/* update the user index file */
-	add_files_to_cache(verbose, prefix, files);
+	/*
+	 * A partial commit.
+	 *
+	 * (0) find the set of affected paths [NEEDSWORK]
+	 * (1) get lock on the real index file;
+	 * (2) update the_index with the given paths;
+	 * (3) write the_index out to the real index (still locked);
+	 * (4) get lock on the false index file;
+	 * (5) reset the_index from HEAD, but keep the addition;
+	 * (6) update the_index the same way as (2);
+	 * (7) write the_index out to the false index file;
+	 * (8) return the name of the false index file (still locked);
+	 *
+	 * The caller should run hooks on the locked false index, and
+	 * (A) if all goes well, commit the real index;
+	 * (B) on failure, rollback the real index;
+	 * In either case, rollback the false index.
+	 */
+	commit_style = COMMIT_PARTIAL;
+
+	if (file_exists(git_path("MERGE_HEAD")))
+		die("cannot do a partial commit during a merge.");
+
+	memset(&partial, 0, sizeof(partial));
+	partial.strdup_paths = 1;
+	if (list_paths(&partial, initial_commit ? NULL : "HEAD", prefix, pathspec))
+		exit(1);
+
+	discard_cache();
+	if (read_cache() < 0)
+		die("cannot read the index");
+
+	fd = hold_locked_index(&index_lock, 1);
+	add_remove_files(&partial);
 	refresh_cache(REFRESH_QUIET);
 	if (write_cache(fd, active_cache, active_nr) || close(fd))
 		die("unable to write new_index file");
 
+	fd = hold_lock_file_for_update(&false_lock,
+				       git_path("next-index-%d", getpid()), 1);
+	discard_cache();
 	if (!initial_commit) {
 		tree = parse_tree_indirect(head_sha1);
 		if (!tree)
@@ -120,17 +269,12 @@ static char *prepare_index(const char **files, const char *prefix)
 		if (read_tree(tree, 0, NULL))
 			die("failed to read HEAD tree object");
 	}
-
-	/* Use a lock file to garbage collect the temporary index file. */
-	next_index_lock = xmalloc(sizeof(*next_index_lock));
-	fd = hold_lock_file_for_update(next_index_lock,
-				       git_path("next-index-%d", getpid()), 1);
-	add_files_to_cache(verbose, prefix, files);
+	add_remove_files(&partial);
 	refresh_cache(REFRESH_QUIET);
-	if (write_cache(fd, active_cache, active_nr) || close(fd))
-		die("unable to write new_index file");
 
-	return next_index_lock->filename;
+	if (write_cache(fd, active_cache, active_nr) || close(fd))
+		die("unable to write temporary index file");
+	return false_lock.filename;
 }
 
 static int run_status(FILE *fp, const char *index_file, const char *prefix)
@@ -437,7 +581,7 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 
 	commitable = run_status(stdout, index_file, prefix);
 
-	rollback_lock_file(&lock_file);
+	rollback_index_files();
 
 	return commitable ? 0 : 1;
 }
@@ -527,23 +671,36 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 
 	index_file = prepare_index(argv, prefix);
 
-	if (!no_verify && run_hook(index_file, "pre-commit", NULL))
-		exit(1);
+	if (!no_verify && run_hook(index_file, "pre-commit", NULL)) {
+		rollback_index_files();
+		return 1;
+	}
 
 	if (!prepare_log_message(index_file, prefix) && !in_merge) {
 		run_status(stdout, index_file, prefix);
+		rollback_index_files();
 		unlink(commit_editmsg);
 		return 1;
 	}
 
-	strbuf_init(&sb, 0);
-
-	/* Start building up the commit header */
+	/*
+	 * Re-read the index as pre-commit hook could have updated it,
+	 * and write it out as a tree.
+	 */
+	discard_cache();
 	read_cache_from(index_file);
-	active_cache_tree = cache_tree();
+	if (!active_cache_tree)
+		active_cache_tree = cache_tree();
 	if (cache_tree_update(active_cache_tree,
-			      active_cache, active_nr, 0, 0) < 0)
+			      active_cache, active_nr, 0, 0) < 0) {
+		rollback_index_files();
 		die("Error building trees");
+	}
+
+	/*
+	 * The commit object
+	 */
+	strbuf_init(&sb, 0);
 	strbuf_addf(&sb, "tree %s\n",
 		    sha1_to_hex(active_cache_tree->sha1));
 
@@ -592,20 +749,27 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	header_len = sb.len;
 	if (!no_edit)
 		launch_editor(git_path(commit_editmsg), &sb);
-	else if (strbuf_read_file(&sb, git_path(commit_editmsg), 0) < 0)
+	else if (strbuf_read_file(&sb, git_path(commit_editmsg), 0) < 0) {
+		rollback_index_files();
 		die("could not read commit message\n");
-	if (run_hook(index_file, "commit-msg", commit_editmsg))
+	}
+	if (run_hook(index_file, "commit-msg", commit_editmsg)) {
+		rollback_index_files();
 		exit(1);
+	}
 	stripspace(&sb, 1);
-	if (sb.len < header_len ||
-	    message_is_empty(&sb, header_len))
+	if (sb.len < header_len || message_is_empty(&sb, header_len)) {
+		rollback_index_files();
 		die("* no commit message?  aborting commit.");
+	}
 	strbuf_addch(&sb, '\0');
 	if (is_encoding_utf8(git_commit_encoding) && !is_utf8(sb.buf))
 		fprintf(stderr, commit_utf8_warn);
 
-	if (write_sha1_file(sb.buf, sb.len - 1, commit_type, commit_sha1))
+	if (write_sha1_file(sb.buf, sb.len - 1, commit_type, commit_sha1)) {
+		rollback_index_files();
 		die("failed to write commit object");
+	}
 
 	ref_lock = lock_any_ref_for_update("HEAD",
 					   initial_commit ? NULL : head_sha1,
@@ -620,21 +784,22 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	strbuf_insert(&sb, 0, reflog_msg, strlen(reflog_msg));
 	strbuf_insert(&sb, strlen(reflog_msg), ": ", 2);
 
-	if (!ref_lock)
+	if (!ref_lock) {
+		rollback_index_files();
 		die("cannot lock HEAD ref");
-	if (write_ref_sha1(ref_lock, commit_sha1, sb.buf) < 0)
+	}
+	if (write_ref_sha1(ref_lock, commit_sha1, sb.buf) < 0) {
+		rollback_index_files();
 		die("cannot update HEAD ref");
+	}
 
 	unlink(git_path("MERGE_HEAD"));
 	unlink(git_path("MERGE_MSG"));
 
-	if (lock_file.filename[0] && commit_locked_index(&lock_file))
-		die("failed to write new index");
+	commit_index_files();
 
 	rerere();
-
-	run_hook(index_file, "post-commit", NULL);
-
+	run_hook(get_index_file(), "post-commit", NULL);
 	if (!quiet)
 		print_summary(prefix, commit_sha1);
 
-- 
1.5.3.5.1815.g9445b
