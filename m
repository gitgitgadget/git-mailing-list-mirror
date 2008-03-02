From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Extend interface of add_files_to_cache to allow ignore
	indexing errors
Date: Sun, 2 Mar 2008 16:43:21 +0100
Message-ID: <20080302154321.GE2973@steel.home>
References: <47C95E34.1050306@dirk.my1.cc> <20080302154154.GC2973@steel.home> <20080302154238.GD2973@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
To: Dirk =?iso-8859-15?Q?S=FCsserott?= <newsletter@dirk.my1.cc>
X-From: git-owner@vger.kernel.org Sun Mar 02 16:44:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVqMT-0002kK-Se
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 16:44:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755602AbYCBPnZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 10:43:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755872AbYCBPnZ
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 10:43:25 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:44985 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755828AbYCBPnX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 10:43:23 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3CculzwpJKcp6o=
Received: from tigra.home (Fab7c.f.strato-dslnet.de [195.4.171.124])
	by post.webmailer.de (klopstock mo11) (RZmta 16.8)
	with ESMTP id 003f18k22F7IVg ; Sun, 2 Mar 2008 16:43:21 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id BA26C277BD;
	Sun,  2 Mar 2008 16:43:21 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id B085356D24; Sun,  2 Mar 2008 16:43:21 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20080302154238.GD2973@steel.home>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75790>

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 builtin-add.c      |   37 ++++++++++++++++++++++++++++---------
 builtin-checkout.c |    2 +-
 builtin-commit.c   |    2 +-
 cache.h            |    8 +++++++-
 4 files changed, 37 insertions(+), 12 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
index abfe473..bc55a0e 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -79,12 +79,18 @@ static void fill_directory(struct dir_struct *dir, const char **pathspec,
 		prune_directory(dir, pathspec, baselen);
 }
 
+struct update_callback_data
+{
+	int flags;
+	int add_errors;
+};
+
 static void update_callback(struct diff_queue_struct *q,
 			    struct diff_options *opt, void *cbdata)
 {
-	int i, verbose;
+	int i;
+	struct update_callback_data *data = cbdata;
 
-	verbose = *((int *)cbdata);
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
 		const char *path = p->one->path;
@@ -94,28 +100,35 @@ static void update_callback(struct diff_queue_struct *q,
 		case DIFF_STATUS_UNMERGED:
 		case DIFF_STATUS_MODIFIED:
 		case DIFF_STATUS_TYPE_CHANGED:
-			if (add_file_to_cache(path, verbose))
-				exit(1);
+			if (add_file_to_cache(path, data->flags & ADD_FILES_VERBOSE)) {
+				if (!(data->flags & ADD_FILES_IGNORE_ERRORS))
+					exit(1);
+				data->add_errors++;
+			}
 			break;
 		case DIFF_STATUS_DELETED:
 			remove_file_from_cache(path);
-			if (verbose)
+			if (data->flags & ADD_FILES_VERBOSE)
 				printf("remove '%s'\n", path);
 			break;
 		}
 	}
 }
 
-void add_files_to_cache(int verbose, const char *prefix, const char **pathspec)
+int add_files_to_cache(const char *prefix, const char **pathspec, int flags)
 {
+	struct update_callback_data data;
 	struct rev_info rev;
 	init_revisions(&rev, prefix);
 	setup_revisions(0, NULL, &rev, NULL);
 	rev.prune_data = pathspec;
 	rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
 	rev.diffopt.format_callback = update_callback;
-	rev.diffopt.format_callback_data = &verbose;
+	data.flags = flags;
+	data.add_errors = 0;
+	rev.diffopt.format_callback_data = &data;
 	run_diff_files(&rev, DIFF_RACY_IS_MODIFIED);
+	return !!data.add_errors;
 }
 
 static void refresh(int verbose, const char **pathspec)
@@ -193,6 +206,7 @@ static struct option builtin_add_options[] = {
 
 int cmd_add(int argc, const char **argv, const char *prefix)
 {
+	int exit_status = 0;
 	int i, newfd;
 	const char **pathspec;
 	struct dir_struct dir;
@@ -209,11 +223,16 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	newfd = hold_locked_index(&lock_file, 1);
 
 	if (take_worktree_changes) {
+		int flags = 0;
 		const char **pathspec;
 		if (read_cache() < 0)
 			die("index file corrupt");
 		pathspec = get_pathspec(prefix, argv);
-		add_files_to_cache(verbose, prefix, pathspec);
+
+		if (verbose)
+			flags |= ADD_FILES_VERBOSE;
+
+		exit_status = add_files_to_cache(prefix, pathspec, flags);
 		goto finish;
 	}
 
@@ -277,5 +296,5 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 			die("Unable to write new index file");
 	}
 
-	return 0;
+	return exit_status;
 }
diff --git a/builtin-checkout.c b/builtin-checkout.c
index b0cd788..2def093 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -273,7 +273,7 @@ static int merge_working_tree(struct checkout_opts *opts,
 			 * entries in the index.
 			 */
 
-			add_files_to_cache(0, NULL, NULL);
+			add_files_to_cache(NULL, NULL, 0);
 			work = write_tree_from_memory();
 
 			ret = reset_to_new(new->commit->tree, opts->quiet);
diff --git a/builtin-commit.c b/builtin-commit.c
index fb1e588..d5e8c4c 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -242,7 +242,7 @@ static char *prepare_index(int argc, const char **argv, const char *prefix)
 	 */
 	if (all || (also && pathspec && *pathspec)) {
 		int fd = hold_locked_index(&index_lock, 1);
-		add_files_to_cache(0, also ? prefix : NULL, pathspec);
+		add_files_to_cache(also ? prefix : NULL, pathspec, 0);
 		refresh_cache(REFRESH_QUIET);
 		if (write_cache(fd, active_cache, active_nr) ||
 		    close_lock_file(&index_lock))
diff --git a/cache.h b/cache.h
index f16d341..c6c1659 100644
--- a/cache.h
+++ b/cache.h
@@ -748,7 +748,13 @@ extern int convert_to_git(const char *path, const char *src, size_t len,
 extern int convert_to_working_tree(const char *path, const char *src, size_t len, struct strbuf *dst);
 
 /* add */
-void add_files_to_cache(int verbose, const char *prefix, const char **pathspec);
+#define ADD_FILES_VERBOSE	01
+#define ADD_FILES_IGNORE_ERRORS	02
+/*
+ * return 0 if success, 1 - if addition of a file failed and
+ * ADD_FILES_IGNORE_ERRORS was specified in flags
+ */
+int add_files_to_cache(const char *prefix, const char **pathspec, int flags);
 
 /* diff.c */
 extern int diff_auto_refresh_index;
-- 
1.5.4.3.391.gf5a0c

