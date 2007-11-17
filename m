From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-commit: fix "git add x y && git commit y" committing x, too
Date: Sat, 17 Nov 2007 00:45:56 -0800
Message-ID: <7vk5ohuunv.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0711150038020.4362@racer.site>
	<1195138198-24511-1-git-send-email-krh@redhat.com>
	<Pine.LNX.4.64.0711151611090.30886@racer.site>
	<1195146094.21076.6.camel@hinata.boston.redhat.com>
	<Pine.LNX.4.64.0711160036450.30886@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kristian =?utf-8?Q?H=C3=B8gsberg?= <krh@redhat.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Nov 17 09:46:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItJKG-00024r-AF
	for gcvg-git-2@gmane.org; Sat, 17 Nov 2007 09:46:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753174AbXKQIqJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Nov 2007 03:46:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752685AbXKQIqI
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Nov 2007 03:46:08 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:48462 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753120AbXKQIqF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2007 03:46:05 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 64B1D2EF;
	Sat, 17 Nov 2007 03:46:24 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 0EF7095954;
	Sat, 17 Nov 2007 03:46:19 -0500 (EST)
In-Reply-To: <Pine.LNX.4.64.0711160036450.30886@racer.site> (Johannes
	Schindelin's message of "Fri, 16 Nov 2007 00:43:17 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65262>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> It's not only about discarding the cache.  It's also about avoiding do 
> regenerate the index completely; this would waste time, especially for big 
> trees.

I was looking at this code earlier tonight but I am too tired so
here are a few comments before I stop.

> But the code you are referencing is only updating the index.  The code I 
> added is to build the temporary index in a correct manner.

Yes, except that it is only in the partial commit codepath and
there is not much point optimizing it, as there are more to it.

If a path that was not in the HEAD was added to the index
earlier, and the path was named on the command line, the
add_files_to_index() function you are borrowing from the
implementation of "add -u" would not notice it.  Look at the
script version of git-commit.sh and look for places near
"ls-files --error-unmatch --with-tree=HEAD".

I _think_ we need to do the equivalent of this, keep the
affected paths in a path-list and use add_file_to_cache()
instead.  We need to feed the same set of paths to update the
index twice (once for the fake one for partial commit, and
another for the real index to be used after the commit is made),
and (1) using add_files_to_index() is more expensive than
walking a path-list, and (2) add_files_to_index() is a wrong
thing to use anyway (by definition you cannot notice addition
when you are comparing the index and the work tree, so I think
your patch to update_callback() is a no-op).


I noticed that the implementation left next-index crufts almost
every time it was run, and started to clean it up.  Here is
still a WIP and it does not optimize the read_tree(HEAD) part,
but you should be able to replace that part with your one-way
merge easily.  As I haven't done that ls-files --error-unmatch
equivalent, this does not pass tests that involve partial
commits with added or removed paths.

---

 builtin-commit.c |  174 +++++++++++++++++++++++++++++++++++++++++++-----------
 1 files changed, 139 insertions(+), 35 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 3e7d281..187d613 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -7,6 +7,7 @@
 
 #include "cache.h"
 #include "cache-tree.h"
+#include "dir.h"
 #include "builtin.h"
 #include "diff.h"
 #include "diffcore.h"
@@ -28,7 +29,13 @@ static const char * const builtin_commit_usage[] = {
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
@@ -78,41 +85,122 @@ static struct option builtin_commit_options[] = {
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
 static char *prepare_index(const char **files, const char *prefix)
 {
 	int fd;
 	struct tree *tree;
-	struct lock_file *next_index_lock;
 
 	if (interactive) {
 		interactive_add();
 		return get_index_file();
 	}
 
-	fd = hold_locked_index(&lock_file, 1);
 	if (read_cache() < 0)
 		die("index file corrupt");
 
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
 	if (all || also) {
+		fd = hold_locked_index(&index_lock, 1);
 		add_files_to_cache(verbose, also ? prefix : NULL, files);
 		refresh_cache(REFRESH_QUIET);
 		if (write_cache(fd, active_cache, active_nr) || close(fd))
 			die("unable to write new_index file");
-		return lock_file.filename;
+		commit_style = COMMIT_NORMAL;
+		return index_lock.filename;
 	}
 
+	/*
+	 * As-is commit.
+	 *
+	 * (1) return the name of the real index file.
+	 *
+	 * The caller should run hooks on the real index, and run
+	 * hooks on the real index, and create commit from the_index.
+	 * No lockfile is needed.
+	 */
 	if (*files == NULL) {
-		/* Commit index as-is. */
-		rollback_lock_file(&lock_file);
+		fd = hold_locked_index(&index_lock, 1);
+		refresh_cache(REFRESH_QUIET);
+		if (write_cache(fd, active_cache, active_nr) ||
+		    close(fd) || commit_locked_index(&index_lock))
+			die("unable to write new_index file");
+		commit_style = COMMIT_AS_IS;
 		return get_index_file();
 	}
 
-	/* update the user index file */
+	/*
+	 * A partial commit.
+	 *
+	 * (0) find the set of affected paths [NEEDSWORK: NOT DONE YET]
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
+	fd = hold_locked_index(&index_lock, 1);
 	add_files_to_cache(verbose, prefix, files);
 	refresh_cache(REFRESH_QUIET);
 	if (write_cache(fd, active_cache, active_nr) || close(fd))
 		die("unable to write new_index file");
 
+	fd = hold_lock_file_for_update(&false_lock,
+				       git_path("next-index-%d", getpid()), 1);
+	discard_cache();
 	if (!initial_commit) {
 		tree = parse_tree_indirect(head_sha1);
 		if (!tree)
@@ -120,17 +208,12 @@ static char *prepare_index(const char **files, const char *prefix)
 		if (read_tree(tree, 0, NULL))
 			die("failed to read HEAD tree object");
 	}
-
-	/* Use a lock file to garbage collect the temporary index file. */
-	next_index_lock = xmalloc(sizeof(*next_index_lock));
-	fd = hold_lock_file_for_update(next_index_lock,
-				       git_path("next-index-%d", getpid()), 1);
 	add_files_to_cache(verbose, prefix, files);
 	refresh_cache(REFRESH_QUIET);
-	if (write_cache(fd, active_cache, active_nr) || close(fd))
-		die("unable to write new_index file");
 
-	return next_index_lock->filename;
+	if (write_cache(fd, active_cache, active_nr) || close(fd))
+		die("unable to write temporary index file");
+	return false_lock.filename;
 }
 
 static int run_status(FILE *fp, const char *index_file, const char *prefix)
@@ -437,7 +520,7 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 
 	commitable = run_status(stdout, index_file, prefix);
 
-	rollback_lock_file(&lock_file);
+	rollback_index_files();
 
 	return commitable ? 0 : 1;
 }
@@ -527,23 +610,36 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 
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
 
@@ -592,20 +688,27 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
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
@@ -620,21 +723,22 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
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
 
