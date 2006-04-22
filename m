From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Libify diff-index.
Date: Sat, 22 Apr 2006 03:14:52 -0700
Message-ID: <7v64l1lxwj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: torvalds@osdl.org
X-From: git-owner@vger.kernel.org Sat Apr 22 19:15:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FXLhR-000771-P9
	for gcvg-git@gmane.org; Sat, 22 Apr 2006 19:15:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750707AbWDVRPH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 22 Apr 2006 13:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750740AbWDVRPH
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Apr 2006 13:15:07 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:50835 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1750707AbWDVRPF (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 Apr 2006 13:15:05 -0400
Received: from fed1rmmtao07.cox.net (fed1rmmtao07.cox.net [68.230.241.32])
	by zeus1.kernel.org (8.13.1/8.13.1) with ESMTP id k3MAFMP5010153
	for <git@vger.kernel.org>; Sat, 22 Apr 2006 10:15:22 GMT
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060422101453.SFNR8660.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 22 Apr 2006 06:14:53 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
X-Virus-Scanned: ClamAV 0.88/1414/Fri Apr 21 22:58:39 2006 on zeus1.kernel.org
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19036>

The second installment to libify diff brothers.  The pathname
arguments are checked more strictly than before because we now
use the revision.c::setup_revisions() infrastructure.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 diff-index.c             |  254 ++++------------------------------------------
 diff-lib.c               |  203 +++++++++++++++++++++++++++++++++++++
 diff.h                   |    2 
 t/t4010-diff-pathspec.sh |   10 +-
 4 files changed, 231 insertions(+), 238 deletions(-)

diff --git a/diff-index.c b/diff-index.c
index e376d65..4a243b3 100644
--- a/diff-index.c
+++ b/diff-index.c
@@ -1,166 +1,7 @@
 #include "cache.h"
-#include "tree.h"
 #include "diff.h"
-
-static int cached_only = 0;
-static int match_nonexisting = 0;
-static struct diff_options diff_options;
-
-/* A file entry went away or appeared */
-static void show_file(const char *prefix,
-		      struct cache_entry *ce,
-		      unsigned char *sha1, unsigned int mode)
-{
-	diff_addremove(&diff_options, prefix[0], ntohl(mode),
-		       sha1, ce->name, NULL);
-}
-
-static int get_stat_data(struct cache_entry *ce,
-			 unsigned char ** sha1p, unsigned int *modep)
-{
-	unsigned char *sha1 = ce->sha1;
-	unsigned int mode = ce->ce_mode;
-
-	if (!cached_only) {
-		static unsigned char no_sha1[20];
-		int changed;
-		struct stat st;
-		if (lstat(ce->name, &st) < 0) {
-			if (errno == ENOENT && match_nonexisting) {
-				*sha1p = sha1;
-				*modep = mode;
-				return 0;
-			}
-			return -1;
-		}
-		changed = ce_match_stat(ce, &st, 0);
-		if (changed) {
-			mode = create_ce_mode(st.st_mode);
-			if (!trust_executable_bit && S_ISREG(st.st_mode))
-				mode = ce->ce_mode;
-			sha1 = no_sha1;
-		}
-	}
-
-	*sha1p = sha1;
-	*modep = mode;
-	return 0;
-}
-
-static void show_new_file(struct cache_entry *new)
-{
-	unsigned char *sha1;
-	unsigned int mode;
-
-	/* New file in the index: it might actually be different in
-	 * the working copy.
-	 */
-	if (get_stat_data(new, &sha1, &mode) < 0)
-		return;
-
-	show_file("+", new, sha1, mode);
-}
-
-static int show_modified(struct cache_entry *old,
-			 struct cache_entry *new,
-			 int report_missing)
-{
-	unsigned int mode, oldmode;
-	unsigned char *sha1;
-
-	if (get_stat_data(new, &sha1, &mode) < 0) {
-		if (report_missing)
-			show_file("-", old, old->sha1, old->ce_mode);
-		return -1;
-	}
-
-	oldmode = old->ce_mode;
-	if (mode == oldmode && !memcmp(sha1, old->sha1, 20) &&
-	    !diff_options.find_copies_harder)
-		return 0;
-
-	mode = ntohl(mode);
-	oldmode = ntohl(oldmode);
-
-	diff_change(&diff_options, oldmode, mode,
-		    old->sha1, sha1, old->name, NULL);
-	return 0;
-}
-
-static int diff_cache(struct cache_entry **ac, int entries, const char **pathspec)
-{
-	while (entries) {
-		struct cache_entry *ce = *ac;
-		int same = (entries > 1) && ce_same_name(ce, ac[1]);
-
-		if (!ce_path_match(ce, pathspec))
-			goto skip_entry;
-
-		switch (ce_stage(ce)) {
-		case 0:
-			/* No stage 1 entry? That means it's a new file */
-			if (!same) {
-				show_new_file(ce);
-				break;
-			}
-			/* Show difference between old and new */
-			show_modified(ac[1], ce, 1);
-			break;
-		case 1:
-			/* No stage 3 (merge) entry? That means it's been deleted */
-			if (!same) {
-				show_file("-", ce, ce->sha1, ce->ce_mode);
-				break;
-			}
-			/* We come here with ce pointing at stage 1
-			 * (original tree) and ac[1] pointing at stage
-			 * 3 (unmerged).  show-modified with
-			 * report-missing set to false does not say the
-			 * file is deleted but reports true if work
-			 * tree does not have it, in which case we
-			 * fall through to report the unmerged state.
-			 * Otherwise, we show the differences between
-			 * the original tree and the work tree.
-			 */
-			if (!cached_only && !show_modified(ce, ac[1], 0))
-				break;
-			/* fallthru */
-		case 3:
-			diff_unmerge(&diff_options, ce->name);
-			break;
-
-		default:
-			die("impossible cache entry stage");
-		}
-
-skip_entry:
-		/*
-		 * Ignore all the different stages for this file,
-		 * we've handled the relevant cases now.
-		 */
-		do {
-			ac++;
-			entries--;
-		} while (entries && ce_same_name(ce, ac[0]));
-	}
-	return 0;
-}
-
-/*
- * This turns all merge entries into "stage 3". That guarantees that
- * when we read in the new tree (into "stage 1"), we won't lose sight
- * of the fact that we had unmerged entries.
- */
-static void mark_merge_entries(void)
-{
-	int i;
-	for (i = 0; i < active_nr; i++) {
-		struct cache_entry *ce = active_cache[i];
-		if (!ce_stage(ce))
-			continue;
-		ce->ce_flags |= htons(CE_STAGEMASK);
-	}
-}
+#include "commit.h"
+#include "revision.h"
 
 static const char diff_cache_usage[] =
 "git-diff-index [-m] [--cached] "
@@ -169,85 +10,32 @@ COMMON_DIFF_OPTIONS_HELP;
 
 int main(int argc, const char **argv)
 {
-	const char *tree_name = NULL;
-	unsigned char sha1[20];
-	const char *prefix = setup_git_directory();
-	const char **pathspec = NULL;
-	struct tree *tree;
-	int ret;
-	int allow_options = 1;
+	struct rev_info rev;
+	int match_missing = 0;
+	int cached = 0;
 	int i;
 
 	git_config(git_diff_config);
-	diff_setup(&diff_options);
+	init_revisions(&rev);
+	rev.abbrev = 0;
+
+	argc = setup_revisions(argc, argv, &rev, NULL);
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
-		int diff_opt_cnt;
-
-		if (!allow_options || *arg != '-') {
-			if (tree_name)
-				break;
-			tree_name = arg;
-			continue;
-		}
 			
-		if (!strcmp(arg, "--")) {
-			allow_options = 0;
-			continue;
-		}
-		if (!strcmp(arg, "-r")) {
-			/* We accept the -r flag just to look like git-diff-tree */
-			continue;
-		}
-		if (!strcmp(arg, "--cc"))
-			/*
-			 * I _think_ "diff-index --cached HEAD" with an
-			 * unmerged index could show something else
-			 * later, but pretend --cc is the same as -p for
-			 * now.  "git diff" uses --cc by default.
-			 */
-			argv[i] = arg = "-p";
-		diff_opt_cnt = diff_opt_parse(&diff_options, argv + i,
-					      argc - i);
-		if (diff_opt_cnt < 0)
+		if (!strcmp(arg, "-m"))
+			match_missing = 1; 
+		else if (!strcmp(arg, "--cached"))
+			cached = 1;
+		else
 			usage(diff_cache_usage);
-		else if (diff_opt_cnt) {
-			i += diff_opt_cnt - 1;
-			continue;
-		}
-
-		if (!strcmp(arg, "-m")) {
-			match_nonexisting = 1;
-			continue;
-		}
-		if (!strcmp(arg, "--cached")) {
-			cached_only = 1;
-			continue;
-		}
-		usage(diff_cache_usage);
 	}
-
-	pathspec = get_pathspec(prefix, argv + i);
-
-	if (diff_setup_done(&diff_options) < 0)
-		usage(diff_cache_usage);
-
-	if (!tree_name || get_sha1(tree_name, sha1))
+	/*
+	 * Make sure there is one revision (i.e. pending object),
+	 * and there is no revision filtering parameters.
+	 */
+	if (!rev.pending_objects || rev.pending_objects->next ||
+	    rev.max_count != -1 || rev.min_age != -1 || rev.max_age != -1)
 		usage(diff_cache_usage);
-
-	read_cache();
-
-	mark_merge_entries();
-
-	tree = parse_tree_indirect(sha1);
-	if (!tree)
-		die("bad tree object %s", tree_name);
-	if (read_tree(tree, 1, pathspec))
-		die("unable to read tree object %s", tree_name);
-
-	ret = diff_cache(active_cache, active_nr, pathspec);
-
-	diffcore_std(&diff_options);
-	diff_flush(&diff_options);
-	return ret;
+	return run_diff_index(&rev, cached, match_missing);
 }
diff --git a/diff-lib.c b/diff-lib.c
index a28dd3d..63da3b5 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -131,3 +131,206 @@ int run_diff_files(struct rev_info *revs
 	return 0;
 }
 
+/*
+ * diff-index
+ */
+
+/* A file entry went away or appeared */
+static void diff_index_show_file(struct rev_info *revs,
+				 const char *prefix,
+				 struct cache_entry *ce,
+				 unsigned char *sha1, unsigned int mode)
+{
+	diff_addremove(&revs->diffopt, prefix[0], ntohl(mode),
+		       sha1, ce->name, NULL);
+}
+
+static int get_stat_data(struct cache_entry *ce,
+			 unsigned char **sha1p,
+			 unsigned int *modep,
+			 int cached, int match_missing)
+{
+	unsigned char *sha1 = ce->sha1;
+	unsigned int mode = ce->ce_mode;
+
+	if (!cached) {
+		static unsigned char no_sha1[20];
+		int changed;
+		struct stat st;
+		if (lstat(ce->name, &st) < 0) {
+			if (errno == ENOENT && match_missing) {
+				*sha1p = sha1;
+				*modep = mode;
+				return 0;
+			}
+			return -1;
+		}
+		changed = ce_match_stat(ce, &st, 0);
+		if (changed) {
+			mode = create_ce_mode(st.st_mode);
+			if (!trust_executable_bit && S_ISREG(st.st_mode))
+				mode = ce->ce_mode;
+			sha1 = no_sha1;
+		}
+	}
+
+	*sha1p = sha1;
+	*modep = mode;
+	return 0;
+}
+
+static void show_new_file(struct rev_info *revs,
+			  struct cache_entry *new,
+			  int cached, int match_missing)
+{
+	unsigned char *sha1;
+	unsigned int mode;
+
+	/* New file in the index: it might actually be different in
+	 * the working copy.
+	 */
+	if (get_stat_data(new, &sha1, &mode, cached, match_missing) < 0)
+		return;
+
+	diff_index_show_file(revs, "+", new, sha1, mode);
+}
+
+static int show_modified(struct rev_info *revs,
+			 struct cache_entry *old,
+			 struct cache_entry *new,
+			 int report_missing,
+			 int cached, int match_missing)
+{
+	unsigned int mode, oldmode;
+	unsigned char *sha1;
+
+	if (get_stat_data(new, &sha1, &mode, cached, match_missing) < 0) {
+		if (report_missing)
+			diff_index_show_file(revs, "-", old,
+					     old->sha1, old->ce_mode);
+		return -1;
+	}
+
+	oldmode = old->ce_mode;
+	if (mode == oldmode && !memcmp(sha1, old->sha1, 20) &&
+	    !revs->diffopt.find_copies_harder)
+		return 0;
+
+	mode = ntohl(mode);
+	oldmode = ntohl(oldmode);
+
+	diff_change(&revs->diffopt, oldmode, mode,
+		    old->sha1, sha1, old->name, NULL);
+	return 0;
+}
+
+static int diff_cache(struct rev_info *revs,
+		      struct cache_entry **ac, int entries,
+		      const char **pathspec,
+		      int cached, int match_missing)
+{
+	while (entries) {
+		struct cache_entry *ce = *ac;
+		int same = (entries > 1) && ce_same_name(ce, ac[1]);
+
+		if (!ce_path_match(ce, pathspec))
+			goto skip_entry;
+
+		switch (ce_stage(ce)) {
+		case 0:
+			/* No stage 1 entry? That means it's a new file */
+			if (!same) {
+				show_new_file(revs, ce, cached, match_missing);
+				break;
+			}
+			/* Show difference between old and new */
+			show_modified(revs,ac[1], ce, 1,
+				      cached, match_missing);
+			break;
+		case 1:
+			/* No stage 3 (merge) entry?
+			 * That means it's been deleted.
+			 */
+			if (!same) {
+				diff_index_show_file(revs, "-", ce,
+						     ce->sha1, ce->ce_mode);
+				break;
+			}
+			/* We come here with ce pointing at stage 1
+			 * (original tree) and ac[1] pointing at stage
+			 * 3 (unmerged).  show-modified with
+			 * report-missing set to false does not say the
+			 * file is deleted but reports true if work
+			 * tree does not have it, in which case we
+			 * fall through to report the unmerged state.
+			 * Otherwise, we show the differences between
+			 * the original tree and the work tree.
+			 */
+			if (!cached &&
+			    !show_modified(revs, ce, ac[1], 0,
+					   cached, match_missing))
+				break;
+			/* fallthru */
+		case 3:
+			diff_unmerge(&revs->diffopt, ce->name);
+			break;
+
+		default:
+			die("impossible cache entry stage");
+		}
+
+skip_entry:
+		/*
+		 * Ignore all the different stages for this file,
+		 * we've handled the relevant cases now.
+		 */
+		do {
+			ac++;
+			entries--;
+		} while (entries && ce_same_name(ce, ac[0]));
+	}
+	return 0;
+}
+
+/*
+ * This turns all merge entries into "stage 3". That guarantees that
+ * when we read in the new tree (into "stage 1"), we won't lose sight
+ * of the fact that we had unmerged entries.
+ */
+static void mark_merge_entries(void)
+{
+	int i;
+	for (i = 0; i < active_nr; i++) {
+		struct cache_entry *ce = active_cache[i];
+		if (!ce_stage(ce))
+			continue;
+		ce->ce_flags |= htons(CE_STAGEMASK);
+	}
+}
+
+int run_diff_index(struct rev_info *revs, int cached, int match_missing)
+{
+	int ret;
+	struct object *ent;
+	struct tree *tree;
+	const char *tree_name;
+
+	if (read_cache() < 0) {
+		perror("read_cache");
+		return -1;
+	}
+	mark_merge_entries();
+
+	ent = revs->pending_objects->item;
+	tree_name = revs->pending_objects->name;
+	tree = parse_tree_indirect(ent->sha1);
+	if (!tree)
+		return error("bad tree object %s", tree_name);
+	if (read_tree(tree, 1, revs->prune_data))
+		return error("unable to read tree object %s", tree_name);
+	ret = diff_cache(revs, active_cache, active_nr, revs->prune_data,
+			 cached, match_missing);
+	diffcore_std(&revs->diffopt);
+	diff_flush(&revs->diffopt);
+	return ret;
+}
diff --git a/diff.h b/diff.h
index da4bd42..837d449 100644
--- a/diff.h
+++ b/diff.h
@@ -171,4 +171,6 @@ extern const char *diff_unique_abbrev(co
 
 extern int run_diff_files(struct rev_info *revs, int silent_on_removed);
 
+extern int run_diff_index(struct rev_info *revs, int cached, int match_missing);
+
 #endif /* DIFF_H */
diff --git a/t/t4010-diff-pathspec.sh b/t/t4010-diff-pathspec.sh
index 8db329d..9e1544d 100755
--- a/t/t4010-diff-pathspec.sh
+++ b/t/t4010-diff-pathspec.sh
@@ -28,7 +28,7 @@ cat >expected <<\EOF
 EOF
 test_expect_success \
     'limit to path should show nothing' \
-    'git-diff-index --cached $tree path >current &&
+    'git-diff-index --cached $tree -- path >current &&
      compare_diff_raw current expected'
 
 cat >expected <<\EOF
@@ -36,7 +36,7 @@ cat >expected <<\EOF
 EOF
 test_expect_success \
     'limit to path1 should show path1/file1' \
-    'git-diff-index --cached $tree path1 >current &&
+    'git-diff-index --cached $tree -- path1 >current &&
      compare_diff_raw current expected'
 
 cat >expected <<\EOF
@@ -44,7 +44,7 @@ cat >expected <<\EOF
 EOF
 test_expect_success \
     'limit to path1/ should show path1/file1' \
-    'git-diff-index --cached $tree path1/ >current &&
+    'git-diff-index --cached $tree -- path1/ >current &&
      compare_diff_raw current expected'
 
 cat >expected <<\EOF
@@ -52,14 +52,14 @@ cat >expected <<\EOF
 EOF
 test_expect_success \
     'limit to file0 should show file0' \
-    'git-diff-index --cached $tree file0 >current &&
+    'git-diff-index --cached $tree -- file0 >current &&
      compare_diff_raw current expected'
 
 cat >expected <<\EOF
 EOF
 test_expect_success \
     'limit to file0/ should emit nothing.' \
-    'git-diff-index --cached $tree file0/ >current &&
+    'git-diff-index --cached $tree -- file0/ >current &&
      compare_diff_raw current expected'
 
 test_done
-- 
1.3.0.g6082
