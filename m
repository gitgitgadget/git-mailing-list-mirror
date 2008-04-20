From: Luciano Rocha <luciano@eurotux.com>
Subject: [PATCH 02/02/RFC] make use of the stat cache
Date: Sun, 20 Apr 2008 12:15:31 +0100
Message-ID: <20080420111531.GB13411@bit.office.eurotux.com>
References: <1208633300-74603-1-git-send-email-pdebie@ai.rug.nl> <alpine.LFD.1.10.0804191443550.2779@woody.linux-foundation.org> <FEFAB19F-742A-452E-87C1-CD55AD0996DB@ai.rug.nl> <alpine.LFD.1.10.0804191515120.2779@woody.linux-foundation.org> <20080420111346.GA13411@bit.office.eurotux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pieter de Bie <pdebie@ai.rug.nl>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Apr 20 13:16:37 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JnXX3-0003Ft-UV
	for gcvg-git-2@gmane.org; Sun, 20 Apr 2008 13:16:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752539AbYDTLPn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2008 07:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752373AbYDTLPm
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Apr 2008 07:15:42 -0400
Received: from os.eurotux.com ([216.75.63.6]:58816 "EHLO os.eurotux.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752148AbYDTLPj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2008 07:15:39 -0400
Received: (qmail 9294 invoked from network); 20 Apr 2008 11:15:35 -0000
Received: from nc.eurotux.com (HELO bit.office.eurotux.com) (luciano@81.84.255.161)
  by os.eurotux.com with AES256-SHA encrypted SMTP; 20 Apr 2008 11:15:35 -0000
Content-Disposition: inline
In-Reply-To: <20080420111346.GA13411@bit.office.eurotux.com>
User-Agent: Mutt/1.5.14 (2007-03-31)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79954>

Replace stat/lstat calls with cstat/clstat.

Signed-off-by: Luciano Rocha <strange@nsk.no-ip.org>

---
 Makefile                  |    2 ++
 builtin-apply.c           |   13 +++++++------
 builtin-blame.c           |    7 ++++---
 builtin-clean.c           |    3 ++-
 builtin-commit.c          |    7 ++++---
 builtin-count-objects.c   |    3 ++-
 builtin-diff.c            |    3 ++-
 builtin-fetch-pack.c      |    5 +++--
 builtin-grep.c            |    3 ++-
 builtin-init-db.c         |   11 ++++++-----
 builtin-ls-files.c        |    3 ++-
 builtin-mailsplit.c       |    3 ++-
 builtin-merge-recursive.c |    3 ++-
 builtin-mv.c              |    9 +++++----
 builtin-pack-objects.c    |    3 ++-
 builtin-prune.c           |    5 +++--
 builtin-rerere.c          |   15 ++++++++-------
 builtin-rm.c              |    3 ++-
 builtin-update-index.c    |    3 ++-
 check-racy.c              |    3 ++-
 combine-diff.c            |    3 ++-
 daemon.c                  |    3 ++-
 diff-lib.c                |    5 +++--
 diff.c                    |    9 +++++----
 dir.c                     |    7 ++++---
 entry.c                   |   11 ++++++-----
 help.c                    |    5 +++--
 http-push.c               |    3 ++-
 http-walker.c             |    3 ++-
 path.c                    |    9 +++++----
 read-cache.c              |    7 ++++---
 refs.c                    |   11 ++++++-----
 setup.c                   |    5 +++--
 sha1_file.c               |   15 ++++++++-------
 sha1_name.c               |    5 +++--
 symlinks.c                |    3 ++-
 test-chmtime.c            |    3 ++-
 transport.c               |    3 ++-
 unpack-trees.c            |    7 ++++---
 xdiff-interface.c         |    3 ++-
 40 files changed, 134 insertions(+), 93 deletions(-)

diff --git a/Makefile b/Makefile
index 2cf38f0..7f01b71 100644
--- a/Makefile
+++ b/Makefile
@@ -374,6 +374,7 @@ LIB_H += tree.h
 LIB_H += tree-walk.h
 LIB_H += unpack-trees.h
 LIB_H += utf8.h
+LIB_H += stat-cache.h
 
 LIB_OBJS += alias.o
 LIB_OBJS += alloc.o
@@ -465,6 +466,7 @@ LIB_OBJS += write_or_die.o
 LIB_OBJS += ws.o
 LIB_OBJS += wt-status.o
 LIB_OBJS += xdiff-interface.o
+LIB_OBJS += stat-cache.o
 
 BUILTIN_OBJS += builtin-add.o
 BUILTIN_OBJS += builtin-annotate.o
diff --git a/builtin-apply.c b/builtin-apply.c
index caa3f2a..bedc7f4 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -12,6 +12,7 @@
 #include "blob.h"
 #include "delta.h"
 #include "builtin.h"
+#include "stat-cache.h"
 
 /*
  *  --check turns on checking that the working tree matches the
@@ -2237,7 +2238,7 @@ static int apply_data(struct patch *patch, struct stat *st, struct cache_entry *
 static int check_to_create_blob(const char *new_name, int ok_if_exists)
 {
 	struct stat nst;
-	if (!lstat(new_name, &nst)) {
+	if (!clstat(new_name, &nst)) {
 		if (S_ISDIR(nst.st_mode) || ok_if_exists)
 			return 0;
 		/*
@@ -2289,7 +2290,7 @@ static int check_patch(struct patch *patch, struct patch *prev_patch)
 		unsigned st_mode = 0;
 
 		if (!cached)
-			stat_ret = lstat(old_name, &st);
+			stat_ret = clstat(old_name, &st);
 		if (check_index) {
 			int pos = cache_name_pos(old_name, strlen(old_name));
 			if (pos < 0)
@@ -2311,7 +2312,7 @@ static int check_patch(struct patch *patch, struct patch *prev_patch)
 				if (checkout_entry(ce,
 						   &costate,
 						   NULL) ||
-				    lstat(old_name, &st))
+				    clstat(old_name, &st))
 					return -1;
 			}
 			if (!cached && verify_index_match(ce, &st))
@@ -2632,7 +2633,7 @@ static void add_index_file(const char *path, unsigned mode, void *buf, unsigned
 			die("corrupt patch for subproject %s", path);
 	} else {
 		if (!cached) {
-			if (lstat(path, &st) < 0)
+			if (clstat(path, &st) < 0)
 				die("unable to stat newly created file %s",
 				    path);
 			fill_stat_cache_info(ce, &st);
@@ -2651,7 +2652,7 @@ static int try_create_file(const char *path, unsigned int mode, const char *buf,
 
 	if (S_ISGITLINK(mode)) {
 		struct stat st;
-		if (!lstat(path, &st) && S_ISDIR(st.st_mode))
+		if (!clstat(path, &st) && S_ISDIR(st.st_mode))
 			return 0;
 		return mkdir(path, 0777);
 	}
@@ -2703,7 +2704,7 @@ static void create_one_file(char *path, unsigned mode, const char *buf, unsigned
 		 * used to be.
 		 */
 		struct stat st;
-		if (!lstat(path, &st) && (!S_ISDIR(st.st_mode) || !rmdir(path)))
+		if (!clstat(path, &st) && (!S_ISDIR(st.st_mode) || !rmdir(path)))
 			errno = EEXIST;
 	}
 
diff --git a/builtin-blame.c b/builtin-blame.c
index bfd562d..ca52fa8 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -18,6 +18,7 @@
 #include "cache-tree.h"
 #include "path-list.h"
 #include "mailmap.h"
+#include "stat-cache.h"
 
 static char blame_usage[] =
 "git-blame [-c] [-b] [-l] [--root] [-t] [-f] [-n] [-s] [-p] [-w] [-L n,m] [-S <revs-file>] [-M] [-C] [-C] [--contents <filename>] [--incremental] [commit] [--] file\n"
@@ -1879,7 +1880,7 @@ static void sanity_check_refcnt(struct scoreboard *sb)
 static int has_path_in_work_tree(const char *path)
 {
 	struct stat st;
-	return !lstat(path, &st);
+	return !clstat(path, &st);
 }
 
 static unsigned parse_score(const char *arg)
@@ -2038,12 +2039,12 @@ static struct commit *fake_working_tree_commit(const char *path, const char *con
 		unsigned long fin_size;
 
 		if (contents_from) {
-			if (stat(contents_from, &st) < 0)
+			if (cstat(contents_from, &st) < 0)
 				die("Cannot stat %s", contents_from);
 			read_from = contents_from;
 		}
 		else {
-			if (lstat(path, &st) < 0)
+			if (clstat(path, &st) < 0)
 				die("Cannot lstat %s", path);
 			read_from = path;
 		}
diff --git a/builtin-clean.c b/builtin-clean.c
index 6778a03..97a8ec6 100644
--- a/builtin-clean.c
+++ b/builtin-clean.c
@@ -11,6 +11,7 @@
 #include "dir.h"
 #include "parse-options.h"
 #include "quote.h"
+#include "stat-cache.h"
 
 static int force = -1; /* unset */
 
@@ -123,7 +124,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 		 * recursive directory removal, so lstat() here could
 		 * fail with ENOENT.
 		 */
-		if (lstat(ent->name, &st))
+		if (clstat(ent->name, &st))
 			continue;
 
 		if (pathspec) {
diff --git a/builtin-commit.c b/builtin-commit.c
index bcb7aaa..f5ce6f1 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -23,6 +23,7 @@
 #include "parse-options.h"
 #include "path-list.h"
 #include "unpack-trees.h"
+#include "stat-cache.h"
 
 static const char * const builtin_commit_usage[] = {
 	"git-commit [options] [--] <filepattern>...",
@@ -430,15 +431,15 @@ static int prepare_to_commit(const char *index_file, const char *prefix)
 		strbuf_add(&sb, buffer + 2, strlen(buffer + 2));
 		hook_arg1 = "commit";
 		hook_arg2 = use_message;
-	} else if (!stat(git_path("MERGE_MSG"), &statbuf)) {
+	} else if (!cstat(git_path("MERGE_MSG"), &statbuf)) {
 		if (strbuf_read_file(&sb, git_path("MERGE_MSG"), 0) < 0)
 			die("could not read MERGE_MSG: %s", strerror(errno));
 		hook_arg1 = "merge";
-	} else if (!stat(git_path("SQUASH_MSG"), &statbuf)) {
+	} else if (!cstat(git_path("SQUASH_MSG"), &statbuf)) {
 		if (strbuf_read_file(&sb, git_path("SQUASH_MSG"), 0) < 0)
 			die("could not read SQUASH_MSG: %s", strerror(errno));
 		hook_arg1 = "squash";
-	} else if (template_file && !stat(template_file, &statbuf)) {
+	} else if (template_file && !cstat(template_file, &statbuf)) {
 		if (strbuf_read_file(&sb, template_file, 0) < 0)
 			die("could not read %s: %s",
 			    template_file, strerror(errno));
diff --git a/builtin-count-objects.c b/builtin-count-objects.c
index f00306f..fd4832e 100644
--- a/builtin-count-objects.c
+++ b/builtin-count-objects.c
@@ -7,6 +7,7 @@
 #include "cache.h"
 #include "builtin.h"
 #include "parse-options.h"
+#include "stat-cache.h"
 
 static void count_objects(DIR *d, char *path, int len, int verbose,
 			  unsigned long *loose,
@@ -40,7 +41,7 @@ static void count_objects(DIR *d, char *path, int len, int verbose,
 			memcpy(path + len + 3, ent->d_name, 38);
 			path[len + 2] = '/';
 			path[len + 41] = 0;
-			if (lstat(path, &st) || !S_ISREG(st.st_mode))
+			if (clstat(path, &st) || !S_ISREG(st.st_mode))
 				bad = 1;
 			else
 				(*loose_size) += xsize_t(st.st_blocks);
diff --git a/builtin-diff.c b/builtin-diff.c
index 7c2a841..fab2f79 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -13,6 +13,7 @@
 #include "revision.h"
 #include "log-tree.h"
 #include "builtin.h"
+#include "stat-cache.h"
 
 struct blobinfo {
 	unsigned char sha1[20];
@@ -69,7 +70,7 @@ static int builtin_diff_b_f(struct rev_info *revs,
 	if (argc > 1)
 		usage(builtin_diff_usage);
 
-	if (lstat(path, &st))
+	if (clstat(path, &st))
 		die("'%s': %s", path, strerror(errno));
 	if (!(S_ISREG(st.st_mode) || S_ISLNK(st.st_mode)))
 		die("'%s': not a regular file or symlink", path);
diff --git a/builtin-fetch-pack.c b/builtin-fetch-pack.c
index 65350ca..b3aba25 100644
--- a/builtin-fetch-pack.c
+++ b/builtin-fetch-pack.c
@@ -9,6 +9,7 @@
 #include "fetch-pack.h"
 #include "remote.h"
 #include "run-command.h"
+#include "stat-cache.h"
 
 static int transfer_unpack_limit = -1;
 static int fetch_unpack_limit = -1;
@@ -780,7 +781,7 @@ struct ref *fetch_pack(struct fetch_pack_args *my_args,
 	fetch_pack_setup();
 	memcpy(&args, my_args, sizeof(args));
 	if (args.depth > 0) {
-		if (stat(git_path("shallow"), &st))
+		if (cstat(git_path("shallow"), &st))
 			st.st_mtime = 0;
 	}
 
@@ -801,7 +802,7 @@ struct ref *fetch_pack(struct fetch_pack_args *my_args,
 #ifdef USE_NSEC
 		mtime.usec = st.st_mtim.usec;
 #endif
-		if (stat(shallow, &st)) {
+		if (cstat(shallow, &st)) {
 			if (mtime.sec)
 				die("shallow file was removed during fetch");
 		} else if (st.st_mtime != mtime.sec
diff --git a/builtin-grep.c b/builtin-grep.c
index ef29910..1fd1c58 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -11,6 +11,7 @@
 #include "tree-walk.h"
 #include "builtin.h"
 #include "grep.h"
+#include "stat-cache.h"
 
 #ifndef NO_EXTERNAL_GREP
 #ifdef __unix__
@@ -132,7 +133,7 @@ static int grep_file(struct grep_opt *opt, const char *filename)
 	char *data;
 	size_t sz;
 
-	if (lstat(filename, &st) < 0) {
+	if (clstat(filename, &st) < 0) {
 	err_ret:
 		if (errno != ENOENT)
 			error("'%s': %s", filename, strerror(errno));
diff --git a/builtin-init-db.c b/builtin-init-db.c
index 2854868..3060c1a 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -6,6 +6,7 @@
 #include "cache.h"
 #include "builtin.h"
 #include "exec_cmd.h"
+#include "stat-cache.h"
 
 #ifndef DEFAULT_GIT_TEMPLATE_DIR
 #define DEFAULT_GIT_TEMPLATE_DIR "/usr/share/git-core/templates"
@@ -56,14 +57,14 @@ static void copy_templates_1(char *path, int baselen,
 			die("insanely long template name %s", de->d_name);
 		memcpy(path + baselen, de->d_name, namelen+1);
 		memcpy(template + template_baselen, de->d_name, namelen+1);
-		if (lstat(path, &st_git)) {
+		if (clstat(path, &st_git)) {
 			if (errno != ENOENT)
 				die("cannot stat %s", path);
 		}
 		else
 			exists = 1;
 
-		if (lstat(template, &st_template))
+		if (clstat(template, &st_template))
 			die("cannot stat template %s", template);
 
 		if (S_ISDIR(st_template.st_mode)) {
@@ -235,10 +236,10 @@ static int create_default_files(const char *git_dir, const char *template_path)
 
 	/* Check filemode trustability */
 	filemode = TEST_FILEMODE;
-	if (TEST_FILEMODE && !lstat(path, &st1)) {
+	if (TEST_FILEMODE && !clstat(path, &st1)) {
 		struct stat st2;
 		filemode = (!chmod(path, st1.st_mode ^ S_IXUSR) &&
-				!lstat(path, &st2) &&
+				!clstat(path, &st2) &&
 				st1.st_mode != st2.st_mode);
 	}
 	git_config_set("core.filemode", filemode ? "true" : "false");
@@ -262,7 +263,7 @@ static int create_default_files(const char *git_dir, const char *template_path)
 		if (!close(xmkstemp(path)) &&
 		    !unlink(path) &&
 		    !symlink("testing", path) &&
-		    !lstat(path, &st1) &&
+		    !clstat(path, &st1) &&
 		    S_ISLNK(st1.st_mode))
 			unlink(path); /* good */
 		else
diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index dc7eab8..be4a0fa 100644
--- a/builtin-ls-files.c
+++ b/builtin-ls-files.c
@@ -10,6 +10,7 @@
 #include "dir.h"
 #include "builtin.h"
 #include "tree.h"
+#include "stat-cache.h"
 
 static int abbrev;
 static int show_deleted;
@@ -256,7 +257,7 @@ static void show_files(struct dir_struct *dir, const char *prefix)
 			int dtype = ce_to_dtype(ce);
 			if (excluded(dir, ce->name, &dtype) != dir->show_ignored)
 				continue;
-			err = lstat(ce->name, &st);
+			err = clstat(ce->name, &st);
 			if (show_deleted && err)
 				show_ce_entry(tag_removed, ce);
 			if (show_modified && ce_modified(ce, &st, 0))
diff --git a/builtin-mailsplit.c b/builtin-mailsplit.c
index 46b27cd..838c52f 100644
--- a/builtin-mailsplit.c
+++ b/builtin-mailsplit.c
@@ -7,6 +7,7 @@
 #include "cache.h"
 #include "builtin.h"
 #include "path-list.h"
+#include "stat-cache.h"
 
 static const char git_mailsplit_usage[] =
 "git-mailsplit [-d<prec>] [-f<n>] [-b] -o<directory> <mbox>|<Maildir>...";
@@ -278,7 +279,7 @@ int cmd_mailsplit(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 
-		if (stat(arg, &argstat) == -1) {
+		if (cstat(arg, &argstat) == -1) {
 			error("cannot stat %s (%s)", arg, strerror(errno));
 			return 1;
 		}
diff --git a/builtin-merge-recursive.c b/builtin-merge-recursive.c
index 910c0d2..5eb2407 100644
--- a/builtin-merge-recursive.c
+++ b/builtin-merge-recursive.c
@@ -19,6 +19,7 @@
 #include "interpolate.h"
 #include "attr.h"
 #include "merge-recursive.h"
+#include "stat-cache.h"
 
 static int subtree_merge;
 
@@ -470,7 +471,7 @@ static char *unique_path(const char *path, const char *branch)
 			*p = '_';
 	while (path_list_has_path(&current_file_set, newpath) ||
 	       path_list_has_path(&current_directory_set, newpath) ||
-	       lstat(newpath, &st) == 0)
+	       clstat(newpath, &st) == 0)
 		sprintf(p, "_%d", suffix++);
 
 	path_list_insert(newpath, &current_file_set);
diff --git a/builtin-mv.c b/builtin-mv.c
index 94f6dd2..807984a 100644
--- a/builtin-mv.c
+++ b/builtin-mv.c
@@ -9,6 +9,7 @@
 #include "cache-tree.h"
 #include "path-list.h"
 #include "parse-options.h"
+#include "stat-cache.h"
 
 static const char * const builtin_mv_usage[] = {
 	"git-mv [options] <source>... <destination>",
@@ -98,7 +99,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 	if (dest_path[0][0] == '\0')
 		/* special case: "." was normalized to "" */
 		destination = copy_pathspec(dest_path[0], argv, argc, 1);
-	else if (!lstat(dest_path[0], &st) &&
+	else if (!clstat(dest_path[0], &st) &&
 			S_ISDIR(st.st_mode)) {
 		dest_path[0] = add_slash(dest_path[0]);
 		destination = copy_pathspec(dest_path[0], argv, argc, 1);
@@ -118,13 +119,13 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 			printf("Checking rename of '%s' to '%s'\n", src, dst);
 
 		length = strlen(src);
-		if (lstat(src, &st) < 0)
+		if (clstat(src, &st) < 0)
 			bad = "bad source";
 		else if (!strncmp(src, dst, length) &&
 				(dst[length] == 0 || dst[length] == '/')) {
 			bad = "can not move directory into itself";
 		} else if ((src_is_dir = S_ISDIR(st.st_mode))
-				&& lstat(dst, &st) == 0)
+				&& clstat(dst, &st) == 0)
 			bad = "cannot move directory over file";
 		else if (src_is_dir) {
 			const char *src_w_slash = add_slash(src);
@@ -177,7 +178,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 				}
 				argc += last - first;
 			}
-		} else if (lstat(dst, &st) == 0) {
+		} else if (clstat(dst, &st) == 0) {
 			bad = "destination exists";
 			if (force) {
 				/*
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 777f272..50da2fa 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -16,6 +16,7 @@
 #include "list-objects.h"
 #include "progress.h"
 #include "refs.h"
+#include "stat-cache.h"
 
 #ifdef THREADED_DELTA_SEARCH
 #include "thread-utils.h"
@@ -530,7 +531,7 @@ static void write_pack_file(void)
 			 * packs then we should modify the mtime of later ones
 			 * to preserve this property.
 			 */
-			if (stat(tmpname, &st) < 0) {
+			if (cstat(tmpname, &st) < 0) {
 				warning("failed to stat %s: %s",
 					tmpname, strerror(errno));
 			} else if (!last_mtime) {
diff --git a/builtin-prune.c b/builtin-prune.c
index 25f9304..ca4f636 100644
--- a/builtin-prune.c
+++ b/builtin-prune.c
@@ -5,6 +5,7 @@
 #include "builtin.h"
 #include "reachable.h"
 #include "parse-options.h"
+#include "stat-cache.h"
 
 static const char * const prune_usage[] = {
 	"git-prune [-n] [--expire <time>] [--] [<head>...]",
@@ -18,7 +19,7 @@ static int prune_object(char *path, const char *filename, const unsigned char *s
 	const char *fullpath = mkpath("%s/%s", path, filename);
 	if (expire) {
 		struct stat st;
-		if (lstat(fullpath, &st))
+		if (clstat(fullpath, &st))
 			return error("Could not stat '%s'", fullpath);
 		if (st.st_mtime > expire)
 			return 0;
@@ -114,7 +115,7 @@ static void remove_temporary_files(void)
 				continue;
 			if (expire) {
 				struct stat st;
-				if (stat(name, &st) != 0 || st.st_mtime >= expire)
+				if (cstat(name, &st) != 0 || st.st_mtime >= expire)
 					continue;
 			}
 			printf("Removing stale temporary file %s\n", name);
diff --git a/builtin-rerere.c b/builtin-rerere.c
index c607aad..ff18ea9 100644
--- a/builtin-rerere.c
+++ b/builtin-rerere.c
@@ -3,6 +3,7 @@
 #include "path-list.h"
 #include "xdiff/xdiff.h"
 #include "xdiff-interface.h"
+#include "stat-cache.h"
 
 #include <time.h>
 
@@ -219,11 +220,11 @@ static void garbage_collect(struct path_list *rr)
 			continue;
 		i = snprintf(buf + len, sizeof(buf) - len, "%s", name);
 		strlcpy(buf + len + i, "/preimage", sizeof(buf) - len - i);
-		if (stat(buf, &st))
+		if (cstat(buf, &st))
 			continue;
 		then = st.st_mtime;
 		strlcpy(buf + len + i, "/postimage", sizeof(buf) - len - i);
-		cutoff = stat(buf, &st) ? cutoff_noresolve : cutoff_resolve;
+		cutoff = cstat(buf, &st) ? cutoff_noresolve : cutoff_resolve;
 		if (then < now - cutoff * 86400) {
 			buf[len + i] = '\0';
 			path_list_insert(xstrdup(name), &to_remove);
@@ -311,8 +312,8 @@ static int do_plain_rerere(struct path_list *rr, int fd)
 		const char *path = rr->items[i].path;
 		const char *name = (const char *)rr->items[i].util;
 
-		if (!stat(rr_path(name, "preimage"), &st) &&
-				!stat(rr_path(name, "postimage"), &st)) {
+		if (!cstat(rr_path(name, "preimage"), &st) &&
+				!cstat(rr_path(name, "postimage"), &st)) {
 			if (!merge(name, path)) {
 				fprintf(stderr, "Resolved '%s' using "
 						"previous resolution.\n", path);
@@ -362,7 +363,7 @@ static int is_rerere_enabled(void)
 		return 0;
 
 	rr_cache = git_path("rr-cache");
-	rr_cache_exists = !stat(rr_cache, &st) && S_ISDIR(st.st_mode);
+	rr_cache_exists = !cstat(rr_cache, &st) && S_ISDIR(st.st_mode);
 	if (rerere_enabled < 0)
 		return rr_cache_exists;
 
@@ -412,9 +413,9 @@ int cmd_rerere(int argc, const char **argv, const char *prefix)
 		for (i = 0; i < merge_rr.nr; i++) {
 			struct stat st;
 			const char *name = (const char *)merge_rr.items[i].util;
-			if (!stat(git_path("rr-cache/%s", name), &st) &&
+			if (!cstat(git_path("rr-cache/%s", name), &st) &&
 					S_ISDIR(st.st_mode) &&
-					stat(rr_path(name, "postimage"), &st))
+					cstat(rr_path(name, "postimage"), &st))
 				unlink_rr_item(name);
 		}
 		unlink(merge_rr_path);
diff --git a/builtin-rm.c b/builtin-rm.c
index c0a8bb6..4039a44 100644
--- a/builtin-rm.c
+++ b/builtin-rm.c
@@ -9,6 +9,7 @@
 #include "cache-tree.h"
 #include "tree-walk.h"
 #include "parse-options.h"
+#include "stat-cache.h"
 
 static const char * const builtin_rm_usage[] = {
 	"git-rm [options] [--] <file>...",
@@ -76,7 +77,7 @@ static int check_local_mod(unsigned char *head, int index_only)
 			continue; /* removing unmerged entry */
 		ce = active_cache[pos];
 
-		if (lstat(ce->name, &st) < 0) {
+		if (clstat(ce->name, &st) < 0) {
 			if (errno != ENOENT)
 				fprintf(stderr, "warning: '%s': %s",
 					ce->name, strerror(errno));
diff --git a/builtin-update-index.c b/builtin-update-index.c
index a8795d3..e88cd95 100644
--- a/builtin-update-index.c
+++ b/builtin-update-index.c
@@ -9,6 +9,7 @@
 #include "tree-walk.h"
 #include "builtin.h"
 #include "refs.h"
+#include "stat-cache.h"
 
 /*
  * Default to not allowing changes to the list of files. The
@@ -198,7 +199,7 @@ static int process_path(const char *path)
 	 * First things first: get the stat information, to decide
 	 * what to do about the pathname!
 	 */
-	if (lstat(path, &st) < 0)
+	if (clstat(path, &st) < 0)
 		return process_lstat_error(path, errno);
 
 	len = strlen(path);
diff --git a/check-racy.c b/check-racy.c
index 00d92a1..a33029f 100644
--- a/check-racy.c
+++ b/check-racy.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "stat-cache.h"
 
 int main(int ac, char **av)
 {
@@ -11,7 +12,7 @@ int main(int ac, char **av)
 		struct cache_entry *ce = active_cache[i];
 		struct stat st;
 
-		if (lstat(ce->name, &st)) {
+		if (clstat(ce->name, &st)) {
 			error("lstat(%s): %s", ce->name, strerror(errno));
 			continue;
 		}
diff --git a/combine-diff.c b/combine-diff.c
index 0e19cba..1e0af00 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -6,6 +6,7 @@
 #include "quote.h"
 #include "xdiff-interface.h"
 #include "log-tree.h"
+#include "stat-cache.h"
 
 static struct combine_diff_path *intersect_paths(struct combine_diff_path *curr, int n, int num_parent)
 {
@@ -683,7 +684,7 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 		struct stat st;
 		int fd = -1;
 
-		if (lstat(elem->path, &st) < 0)
+		if (clstat(elem->path, &st) < 0)
 			goto deleted_file;
 
 		if (S_ISLNK(st.st_mode)) {
diff --git a/daemon.c b/daemon.c
index 2b4a6f1..ac4943b 100644
--- a/daemon.c
+++ b/daemon.c
@@ -2,6 +2,7 @@
 #include "pkt-line.h"
 #include "exec_cmd.h"
 #include "interpolate.h"
+#include "stat-cache.h"
 
 #include <syslog.h>
 
@@ -1187,7 +1188,7 @@ int main(int argc, char **argv)
 	if (base_path) {
 		struct stat st;
 
-		if (stat(base_path, &st) || !S_ISDIR(st.st_mode))
+		if (cstat(base_path, &st) || !S_ISDIR(st.st_mode))
 			die("base-path '%s' does not exist or "
 			    "is not a directory", base_path);
 	}
diff --git a/diff-lib.c b/diff-lib.c
index 069e450..be594ba 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -11,6 +11,7 @@
 #include "path-list.h"
 #include "unpack-trees.h"
 #include "refs.h"
+#include "stat-cache.h"
 
 /*
  * diff-files
@@ -40,7 +41,7 @@ static int get_mode(const char *path, int *mode)
 		*mode = 0;
 	else if (!strcmp(path, "-"))
 		*mode = create_ce_mode(0666);
-	else if (stat(path, &st))
+	else if (cstat(path, &st))
 		return error("Could not access '%s'", path);
 	else
 		*mode = st.st_mode;
@@ -340,7 +341,7 @@ int run_diff_files_cmd(struct rev_info *revs, int argc, const char **argv)
  */
 static int check_work_tree_entity(const struct cache_entry *ce, struct stat *st, char *symcache)
 {
-	if (lstat(ce->name, st) < 0) {
+	if (clstat(ce->name, st) < 0) {
 		if (errno != ENOENT && errno != ENOTDIR)
 			return -1;
 		return 1;
diff --git a/diff.c b/diff.c
index 8022e67..4508000 100644
--- a/diff.c
+++ b/diff.c
@@ -11,6 +11,7 @@
 #include "attr.h"
 #include "run-command.h"
 #include "utf8.h"
+#include "stat-cache.h"
 
 #ifdef NO_FAST_WORKING_DIRECTORY
 #define FAST_WORKING_DIRECTORY 0
@@ -1624,7 +1625,7 @@ static int reuse_worktree_file(const char *name, const unsigned char *sha1, int
 	 * If ce matches the file in the work tree, we can reuse it.
 	 */
 	if (ce_uptodate(ce) ||
-	    (!lstat(name, &st) && !ce_match_stat(ce, &st, 0)))
+	    (!clstat(name, &st) && !ce_match_stat(ce, &st, 0)))
 		return 1;
 
 	return 0;
@@ -1694,7 +1695,7 @@ int diff_populate_filespec(struct diff_filespec *s, int size_only)
 		if (!strcmp(s->path, "-"))
 			return populate_from_stdin(s);
 
-		if (lstat(s->path, &st) < 0) {
+		if (clstat(s->path, &st) < 0) {
 			if (errno == ENOENT) {
 			err_empty:
 				err = -1;
@@ -1810,7 +1811,7 @@ static void prepare_temp_file(const char *name,
 	if (!one->sha1_valid ||
 	    reuse_worktree_file(name, one->sha1, 1)) {
 		struct stat st;
-		if (lstat(name, &st) < 0) {
+		if (clstat(name, &st) < 0) {
 			if (errno == ENOENT)
 				goto not_a_valid_file;
 			die("stat(%s): %s", name, strerror(errno));
@@ -1996,7 +1997,7 @@ static void diff_fill_sha1_info(struct diff_filespec *one)
 				hashcpy(one->sha1, null_sha1);
 				return;
 			}
-			if (lstat(one->path, &st) < 0)
+			if (clstat(one->path, &st) < 0)
 				die("stat %s", one->path);
 			if (index_path(one->sha1, one->path, &st, 0))
 				die("cannot hash %s\n", one->path);
diff --git a/dir.c b/dir.c
index d79762c..6bdab38 100644
--- a/dir.c
+++ b/dir.c
@@ -8,6 +8,7 @@
 #include "cache.h"
 #include "dir.h"
 #include "refs.h"
+#include "stat-cache.h"
 
 struct path_simplify {
 	int len;
@@ -538,7 +539,7 @@ static int get_dtype(struct dirent *de, const char *path)
 
 	if (dtype != DT_UNKNOWN)
 		return dtype;
-	if (lstat(path, &st))
+	if (clstat(path, &st))
 		return dtype;
 	if (S_ISREG(st.st_mode))
 		return DT_REG;
@@ -721,7 +722,7 @@ int read_directory(struct dir_struct *dir, const char *path, const char *base, i
 int file_exists(const char *f)
 {
 	struct stat sb;
-	return lstat(f, &sb) == 0;
+	return clstat(f, &sb) == 0;
 }
 
 /*
@@ -788,7 +789,7 @@ int remove_dir_recursively(struct strbuf *path, int only_empty)
 
 		strbuf_setlen(path, len);
 		strbuf_addstr(path, e->d_name);
-		if (lstat(path->buf, &st))
+		if (clstat(path->buf, &st))
 			; /* fall thru */
 		else if (S_ISDIR(st.st_mode)) {
 			if (!remove_dir_recursively(path, only_empty))
diff --git a/entry.c b/entry.c
index 222aaa3..6d31ac3 100644
--- a/entry.c
+++ b/entry.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "blob.h"
+#include "stat-cache.h"
 
 static void create_directories(const char *path, const struct checkout *state)
 {
@@ -21,13 +22,13 @@ static void create_directories(const char *path, const struct checkout *state)
 			 * allowed to be a symlink to an existing
 			 * directory.
 			 */
-			stat_status = stat(buf, &st);
+			stat_status = cstat(buf, &st);
 		else
 			/*
 			 * if there currently is a symlink, we would
 			 * want to replace it with a real directory.
 			 */
-			stat_status = lstat(buf, &st);
+			stat_status = clstat(buf, &st);
 
 		if (!stat_status && S_ISDIR(st.st_mode))
 			continue; /* ok, it is already a directory. */
@@ -67,7 +68,7 @@ static void remove_subtree(const char *path)
 		     ((de->d_name[1] == '.') && de->d_name[2] == 0)))
 			continue;
 		strcpy(name, de->d_name);
-		if (lstat(pathbuf, &st))
+		if (clstat(pathbuf, &st))
 			die("cannot lstat %s (%s)", pathbuf, strerror(errno));
 		if (S_ISDIR(st.st_mode))
 			remove_subtree(pathbuf);
@@ -184,7 +185,7 @@ static int write_entry(struct cache_entry *ce, char *path, const struct checkout
 
 	if (state->refresh_cache) {
 		struct stat st;
-		lstat(ce->name, &st);
+		clstat(ce->name, &st);
 		fill_stat_cache_info(ce, &st);
 	}
 	return 0;
@@ -202,7 +203,7 @@ int checkout_entry(struct cache_entry *ce, const struct checkout *state, char *t
 	memcpy(path, state->base_dir, len);
 	strcpy(path + len, ce->name);
 
-	if (!lstat(path, &st)) {
+	if (!clstat(path, &st)) {
 		unsigned changed = ce_match_stat(ce, &st, CE_MATCH_IGNORE_VALID);
 		if (!changed)
 			return 0;
diff --git a/help.c b/help.c
index 10298fb..6616f25 100644
--- a/help.c
+++ b/help.c
@@ -9,6 +9,7 @@
 #include "common-cmds.h"
 #include "parse-options.h"
 #include "run-command.h"
+#include "stat-cache.h"
 
 static struct man_viewer_list {
 	void (*exec)(const char *);
@@ -299,7 +300,7 @@ static unsigned int list_commands_in_dir(struct cmdnames *cmds,
 		if (prefixcmp(de->d_name, prefix))
 			continue;
 
-		if (stat(de->d_name, &st) || /* stat, not lstat */
+		if (cstat(de->d_name, &st) || /* stat, not lstat */
 		    !S_ISREG(st.st_mode) ||
 		    !(st.st_mode & S_IXUSR))
 			continue;
@@ -479,7 +480,7 @@ static void get_html_page_path(struct strbuf *page_path, const char *page)
 	struct stat st;
 
 	/* Check that we have a git documentation directory. */
-	if (stat(GIT_HTML_PATH "/git.html", &st) || !S_ISREG(st.st_mode))
+	if (cstat(GIT_HTML_PATH "/git.html", &st) || !S_ISREG(st.st_mode))
 		die("'%s': not a documentation directory.", GIT_HTML_PATH);
 
 	strbuf_init(page_path, 0);
diff --git a/http-push.c b/http-push.c
index 5b23038..f536a8b 100644
--- a/http-push.c
+++ b/http-push.c
@@ -9,6 +9,7 @@
 #include "revision.h"
 #include "exec_cmd.h"
 #include "remote.h"
+#include "stat-cache.h"
 
 #include <expat.h>
 
@@ -732,7 +733,7 @@ static void finish_request(struct transfer_request *request)
 
 		if (request->curl_result != CURLE_OK &&
 		    request->http_code != 416) {
-			if (stat(request->tmpfile, &st) == 0) {
+			if (cstat(request->tmpfile, &st) == 0) {
 				if (st.st_size == 0)
 					unlink(request->tmpfile);
 			}
diff --git a/http-walker.c b/http-walker.c
index 7bda34d..cd16036 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -3,6 +3,7 @@
 #include "pack.h"
 #include "walker.h"
 #include "http.h"
+#include "stat-cache.h"
 
 #define PREV_BUF_SIZE 4096
 #define RANGE_HEADER_SIZE 30
@@ -237,7 +238,7 @@ static void finish_object_request(struct object_request *obj_req)
 	if (obj_req->http_code == 416) {
 		fprintf(stderr, "Warning: requested range invalid; we may already have all the data.\n");
 	} else if (obj_req->curl_result != CURLE_OK) {
-		if (stat(obj_req->tmpfile, &st) == 0)
+		if (cstat(obj_req->tmpfile, &st) == 0)
 			if (st.st_size == 0)
 				unlink(obj_req->tmpfile);
 		return;
diff --git a/path.c b/path.c
index f4ed979..401ab0f 100644
--- a/path.c
+++ b/path.c
@@ -11,6 +11,7 @@
  * which is what it's designed for.
  */
 #include "cache.h"
+#include "stat-cache.h"
 
 static char bad_path[] = "/bad-path/";
 
@@ -93,7 +94,7 @@ int validate_headref(const char *path)
 	unsigned char sha1[20];
 	int len, fd;
 
-	if (lstat(path, &st) < 0)
+	if (clstat(path, &st) < 0)
 		return -1;
 
 	/* Make sure it is a "refs/.." symlink */
@@ -263,7 +264,7 @@ int adjust_shared_perm(const char *path)
 
 	if (!shared_repository)
 		return 0;
-	if (lstat(path, &st) < 0)
+	if (clstat(path, &st) < 0)
 		return -1;
 	mode = st.st_mode;
 	if (mode & S_IRUSR)
@@ -306,7 +307,7 @@ const char *make_absolute_path(const char *path)
 		die ("Too long path: %.*s", 60, path);
 
 	while (depth--) {
-		if (stat(buf, &st) || !S_ISDIR(st.st_mode)) {
+		if (cstat(buf, &st) || !S_ISDIR(st.st_mode)) {
 			char *last_slash = strrchr(buf, '/');
 			if (last_slash) {
 				*last_slash = '\0';
@@ -338,7 +339,7 @@ const char *make_absolute_path(const char *path)
 			last_elem = NULL;
 		}
 
-		if (!lstat(buf, &st) && S_ISLNK(st.st_mode)) {
+		if (!clstat(buf, &st) && S_ISLNK(st.st_mode)) {
 			len = readlink(buf, next_buf, PATH_MAX);
 			if (len < 0)
 				die ("Invalid symlink: %s", buf);
diff --git a/read-cache.c b/read-cache.c
index a92b25b..a80af56 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -8,6 +8,7 @@
 #include "cache-tree.h"
 #include "refs.h"
 #include "dir.h"
+#include "stat-cache.h"
 
 /* Index extensions.
  *
@@ -495,7 +496,7 @@ int add_file_to_index(struct index_state *istate, const char *path, int verbose)
 	struct cache_entry *ce;
 	unsigned ce_option = CE_MATCH_IGNORE_VALID|CE_MATCH_RACY_IS_DIRTY;
 
-	if (lstat(path, &st))
+	if (clstat(path, &st))
 		die("%s: unable to stat (%s)", path, strerror(errno));
 
 	if (!S_ISREG(st.st_mode) && !S_ISLNK(st.st_mode) && !S_ISDIR(st.st_mode))
@@ -902,7 +903,7 @@ static struct cache_entry *refresh_cache_ent(struct index_state *istate,
 	if (ce_uptodate(ce))
 		return ce;
 
-	if (lstat(ce->name, &st) < 0) {
+	if (clstat(ce->name, &st) < 0) {
 		if (err)
 			*err = errno;
 		return NULL;
@@ -1290,7 +1291,7 @@ static void ce_smudge_racily_clean_entry(struct cache_entry *ce)
 	 */
 	struct stat st;
 
-	if (lstat(ce->name, &st) < 0)
+	if (clstat(ce->name, &st) < 0)
 		return;
 	if (ce_match_stat_basic(ce, &st))
 		return;
diff --git a/refs.c b/refs.c
index 1b0050e..35d2f2b 100644
--- a/refs.c
+++ b/refs.c
@@ -3,6 +3,7 @@
 #include "object.h"
 #include "tag.h"
 #include "dir.h"
+#include "stat-cache.h"
 
 /* ISSYMREF=01 and ISPACKED=02 are public interfaces */
 #define REF_KNOWS_PEELED 04
@@ -256,7 +257,7 @@ static struct ref_list *get_ref_dir(const char *base, struct ref_list *list)
 			if (has_extension(de->d_name, ".lock"))
 				continue;
 			memcpy(ref + baselen, de->d_name, namelen+1);
-			if (stat(git_path("%s", ref), &st) < 0)
+			if (cstat(git_path("%s", ref), &st) < 0)
 				continue;
 			if (S_ISDIR(st.st_mode)) {
 				list = get_ref_dir(ref, list);
@@ -391,7 +392,7 @@ const char *resolve_ref(const char *ref, unsigned char *sha1, int reading, int *
 		 * born.  It is NOT OK if we are resolving for
 		 * reading.
 		 */
-		if (lstat(path, &st) < 0) {
+		if (clstat(path, &st) < 0) {
 			struct ref_list *list = get_packed_refs();
 			while (list) {
 				if (!strcmp(ref, list->name)) {
@@ -805,7 +806,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *ref, const unsigned char
 	lock->ref_name = xstrdup(ref);
 	lock->orig_ref_name = xstrdup(orig_ref);
 	ref_file = git_path("%s", ref);
-	if (lstat(ref_file, &st) && errno == ENOENT)
+	if (clstat(ref_file, &st) && errno == ENOENT)
 		lock->force_write = 1;
 	if ((flags & REF_NODEREF) && (type & REF_ISSYMREF))
 		lock->force_write = 1;
@@ -924,7 +925,7 @@ int rename_ref(const char *oldref, const char *newref, const char *logmsg)
 	int flag = 0, logmoved = 0;
 	struct ref_lock *lock;
 	struct stat loginfo;
-	int log = !lstat(git_path("logs/%s", oldref), &loginfo);
+	int log = !clstat(git_path("logs/%s", oldref), &loginfo);
 
 	if (S_ISLNK(loginfo.st_mode))
 		return error("reflog for %s is a symlink", oldref);
@@ -1465,7 +1466,7 @@ static int do_for_each_reflog(const char *base, each_ref_fn fn, void *cb_data)
 			if (has_extension(de->d_name, ".lock"))
 				continue;
 			memcpy(log + baselen, de->d_name, namelen+1);
-			if (stat(git_path("logs/%s", log), &st) < 0)
+			if (cstat(git_path("logs/%s", log), &st) < 0)
 				continue;
 			if (S_ISDIR(st.st_mode)) {
 				retval = do_for_each_reflog(log, fn, cb_data);
diff --git a/setup.c b/setup.c
index 3d2d958..e72b48e 100644
--- a/setup.c
+++ b/setup.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "dir.h"
+#include "stat-cache.h"
 
 static int inside_git_dir = -1;
 static int inside_work_tree = -1;
@@ -148,7 +149,7 @@ void verify_filename(const char *prefix, const char *arg)
 	if (*arg == '-')
 		die("bad flag '%s' used after filename", arg);
 	name = prefix ? prefix_filename(prefix, strlen(prefix), arg) : arg;
-	if (!lstat(name, &st))
+	if (!clstat(name, &st))
 		return;
 	if (errno == ENOENT)
 		die("ambiguous argument '%s': unknown revision or path not in the working tree.\n"
@@ -171,7 +172,7 @@ void verify_non_filename(const char *prefix, const char *arg)
 	if (*arg == '-')
 		return; /* flag */
 	name = prefix ? prefix_filename(prefix, strlen(prefix), arg) : arg;
-	if (!lstat(name, &st))
+	if (!clstat(name, &st))
 		die("ambiguous argument '%s': both revision and filename\n"
 		    "Use '--' to separate filenames from revisions", arg);
 	if (errno != ENOENT && errno != ENOTDIR)
diff --git a/sha1_file.c b/sha1_file.c
index 445a871..777f47d 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -15,6 +15,7 @@
 #include "tree.h"
 #include "refs.h"
 #include "pack-revindex.h"
+#include "stat-cache.h"
 
 #ifndef O_NOATIME
 #if defined(__linux__) && (defined(__i386__) || defined(__PPC__))
@@ -97,7 +98,7 @@ int safe_create_leading_directories(char *path)
 		if (!pos)
 			break;
 		*pos = 0;
-		if (!stat(path, &st)) {
+		if (!cstat(path, &st)) {
 			/* path exists */
 			if (!S_ISDIR(st.st_mode)) {
 				*pos = '/';
@@ -278,7 +279,7 @@ static int link_alt_odb_entry(const char * entry, int len, const char * relative
 	ent->base[pfxlen] = ent->base[entlen-1] = 0;
 
 	/* Detect cases where alternate disappeared */
-	if (stat(ent->base, &st) || !S_ISDIR(st.st_mode)) {
+	if (cstat(ent->base, &st) || !S_ISDIR(st.st_mode)) {
 		error("object directory %s does not exist; "
 		      "check .git/objects/info/alternates.",
 		      ent->base);
@@ -400,13 +401,13 @@ static char *find_sha1_file(const unsigned char *sha1, struct stat *st)
 	char *name = sha1_file_name(sha1);
 	struct alternate_object_database *alt;
 
-	if (!stat(name, st))
+	if (!cstat(name, st))
 		return name;
 	prepare_alt_odb();
 	for (alt = alt_odb_list; alt; alt = alt->next) {
 		name = alt->name;
 		fill_sha1_path(name, sha1);
-		if (!stat(alt->base, st))
+		if (!cstat(alt->base, st))
 			return alt->base;
 	}
 	return NULL;
@@ -804,7 +805,7 @@ struct packed_git *add_packed_git(const char *path, int path_len, int local)
 		return NULL;
 	memcpy(p->pack_name, path, path_len);
 	strcpy(p->pack_name + path_len, ".pack");
-	if (stat(p->pack_name, &st) || !S_ISREG(st.st_mode)) {
+	if (cstat(p->pack_name, &st) || !S_ISREG(st.st_mode)) {
 		free(p);
 		return NULL;
 	}
@@ -2303,7 +2304,7 @@ int write_sha1_from_fd(const unsigned char *sha1, int fd, char *buffer,
 int has_pack_index(const unsigned char *sha1)
 {
 	struct stat st;
-	if (stat(sha1_pack_index_name(sha1), &st))
+	if (cstat(sha1_pack_index_name(sha1), &st))
 		return 0;
 	return 1;
 }
@@ -2311,7 +2312,7 @@ int has_pack_index(const unsigned char *sha1)
 int has_pack_file(const unsigned char *sha1)
 {
 	struct stat st;
-	if (stat(sha1_pack_name(sha1), &st))
+	if (cstat(sha1_pack_name(sha1), &st))
 		return 0;
 	return 1;
 }
diff --git a/sha1_name.c b/sha1_name.c
index 491d2e7..df8b36c 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -5,6 +5,7 @@
 #include "blob.h"
 #include "tree-walk.h"
 #include "refs.h"
+#include "stat-cache.h"
 
 static int find_short_object_filename(int len, const char *name, unsigned char *sha1)
 {
@@ -276,11 +277,11 @@ int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
 		ref = resolve_ref(path, hash, 0, NULL);
 		if (!ref)
 			continue;
-		if (!stat(git_path("logs/%s", path), &st) &&
+		if (!cstat(git_path("logs/%s", path), &st) &&
 		    S_ISREG(st.st_mode))
 			it = path;
 		else if (strcmp(ref, path) &&
-			 !stat(git_path("logs/%s", ref), &st) &&
+			 !cstat(git_path("logs/%s", ref), &st) &&
 			 S_ISREG(st.st_mode))
 			it = ref;
 		else
diff --git a/symlinks.c b/symlinks.c
index be9ace6..2a167a2 100644
--- a/symlinks.c
+++ b/symlinks.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "stat-cache.h"
 
 int has_symlink_leading_path(const char *name, char *last_symlink)
 {
@@ -32,7 +33,7 @@ int has_symlink_leading_path(const char *name, char *last_symlink)
 		memcpy(dp, sp, len);
 		dp[len] = 0;
 
-		if (lstat(path, &st))
+		if (clstat(path, &st))
 			return 0;
 		if (S_ISLNK(st.st_mode)) {
 			if (last_symlink)
diff --git a/test-chmtime.c b/test-chmtime.c
index 90da448..fec5ae2 100644
--- a/test-chmtime.c
+++ b/test-chmtime.c
@@ -1,4 +1,5 @@
 #include "git-compat-util.h"
+#include "stat-cache.h"
 #include <utime.h>
 
 static const char usage_str[] = "(+|=|=+|=-|-)<seconds> <file>...";
@@ -37,7 +38,7 @@ int main(int argc, const char *argv[])
 		struct stat sb;
 		struct utimbuf utb;
 
-		if (stat(argv[i], &sb) < 0) {
+		if (cstat(argv[i], &sb) < 0) {
 			fprintf(stderr, "Failed to stat %s: %s\n",
 			        argv[i], strerror(errno));
 			return -1;
diff --git a/transport.c b/transport.c
index 393e0e8..aace948 100644
--- a/transport.c
+++ b/transport.c
@@ -11,6 +11,7 @@
 #include "bundle.h"
 #include "dir.h"
 #include "refs.h"
+#include "stat-cache.h"
 
 /* rsync support */
 
@@ -703,7 +704,7 @@ static int is_local(const char *url)
 static int is_file(const char *url)
 {
 	struct stat buf;
-	if (stat(url, &buf))
+	if (cstat(url, &buf))
 		return 0;
 	return S_ISREG(buf.st_mode);
 }
diff --git a/unpack-trees.c b/unpack-trees.c
index a59f475..ef7ac26 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -7,6 +7,7 @@
 #include "unpack-trees.h"
 #include "progress.h"
 #include "refs.h"
+#include "stat-cache.h"
 
 static void add_entry(struct unpack_trees_options *o, struct cache_entry *ce,
 	unsigned int set, unsigned int clear)
@@ -409,7 +410,7 @@ static int verify_uptodate(struct cache_entry *ce,
 	if (o->index_only || o->reset)
 		return 0;
 
-	if (!lstat(ce->name, &st)) {
+	if (!clstat(ce->name, &st)) {
 		unsigned changed = ie_match_stat(o->src_index, ce, &st, CE_MATCH_IGNORE_VALID);
 		if (!changed)
 			return 0;
@@ -535,7 +536,7 @@ static int verify_absent(struct cache_entry *ce, const char *action,
 	if (has_symlink_leading_path(ce->name, NULL))
 		return 0;
 
-	if (!lstat(ce->name, &st)) {
+	if (!clstat(ce->name, &st)) {
 		int cnt;
 		int dtype = ce_to_dtype(ce);
 
@@ -931,7 +932,7 @@ int oneway_merge(struct cache_entry **src, struct unpack_trees_options *o)
 		int update = 0;
 		if (o->reset) {
 			struct stat st;
-			if (lstat(old->name, &st) ||
+			if (clstat(old->name, &st) ||
 			    ie_match_stat(o->src_index, old, &st, CE_MATCH_IGNORE_VALID))
 				update |= CE_UPDATE;
 		}
diff --git a/xdiff-interface.c b/xdiff-interface.c
index 61dc5c5..7eb4a9e 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "xdiff-interface.h"
+#include "stat-cache.h"
 
 static int parse_num(char **cp_p, int *num_p)
 {
@@ -147,7 +148,7 @@ int read_mmfile(mmfile_t *ptr, const char *filename)
 	FILE *f;
 	size_t sz;
 
-	if (stat(filename, &st))
+	if (cstat(filename, &st))
 		return error("Could not stat %s", filename);
 	if ((f = fopen(filename, "rb")) == NULL)
 		return error("Could not open %s", filename);
-- 
1.5.5.76.gbb45.dirty
