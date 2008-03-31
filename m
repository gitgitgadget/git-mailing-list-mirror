From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/3] diff-index: careful when inspecting work tree items
Date: Sun, 30 Mar 2008 17:29:48 -0700
Message-ID: <7vprtbu45f.fsf@gitster.siamese.dyndns.org>
References: <200803290813.08419.chriscool@tuxfamily.org>
 <7v4panyduy.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 31 02:30:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jg7vG-0006qY-Ti
	for gcvg-git-2@gmane.org; Mon, 31 Mar 2008 02:30:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753902AbYCaAaG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Mar 2008 20:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752465AbYCaAaG
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Mar 2008 20:30:06 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42630 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751094AbYCaAaE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Mar 2008 20:30:04 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 25F61210A;
	Sun, 30 Mar 2008 20:30:03 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id D31032107; Sun, 30 Mar 2008 20:29:57 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78538>

Earlier, if you changed a staged path into a directory in the work tree,
we happily ran lstat(2) on it and found that it exists, and declared that
the user changed it to a gitlink.

This is wrong for two reasons:

 (1) It may be a directory, but it may not be a submodule, and in the
     latter case, the change we need to report is "the blob at the path
     has disappeared".  We need to check with resolve_gitlink_ref() to be
     consistent with what "git add" and "git update-index --add" does.

 (2) lstat(2) may have succeeded only because a leading component of the
     path was turned into a symbolic link that points at something that
     exists in the work tree.  In such a case, the path itself does not
     exist anymore, as far as the index is concerned.

This fixes these breakages in diff-index that the previous patch has
exposed.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff-lib.c                       |   69 ++++++++++++++++++++++++++++++--------
 t/t2201-add-update-typechange.sh |    2 +-
 2 files changed, 56 insertions(+), 15 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index 52dbac3..a8e107a 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -10,6 +10,7 @@
 #include "cache-tree.h"
 #include "path-list.h"
 #include "unpack-trees.h"
+#include "refs.h"
 
 /*
  * diff-files
@@ -333,6 +334,26 @@ int run_diff_files_cmd(struct rev_info *revs, int argc, const char **argv)
 	}
 	return run_diff_files(revs, options);
 }
+/*
+ * See if work tree has an entity that can be staged.  Return 0 if so,
+ * return 1 if not and return -1 if error.
+ */
+static int check_work_tree_entity(const struct cache_entry *ce, struct stat *st, char *symcache)
+{
+	if (lstat(ce->name, st) < 0) {
+		if (errno != ENOENT && errno != ENOTDIR)
+			return -1;
+		return 1;
+	}
+	if (has_symlink_leading_path(ce->name, symcache))
+		return 1;
+	if (S_ISDIR(st->st_mode)) {
+		unsigned char sub[20];
+		if (resolve_gitlink_ref(ce->name, "HEAD", sub))
+			return 1;
+	}
+	return 0;
+}
 
 int run_diff_files(struct rev_info *revs, unsigned int option)
 {
@@ -468,6 +489,11 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
  * diff-index
  */
 
+struct oneway_unpack_data {
+	struct rev_info *revs;
+	char symcache[PATH_MAX];
+};
+
 /* A file entry went away or appeared */
 static void diff_index_show_file(struct rev_info *revs,
 				 const char *prefix,
@@ -481,7 +507,8 @@ static void diff_index_show_file(struct rev_info *revs,
 static int get_stat_data(struct cache_entry *ce,
 			 const unsigned char **sha1p,
 			 unsigned int *modep,
-			 int cached, int match_missing)
+			 int cached, int match_missing,
+			 struct oneway_unpack_data *cbdata)
 {
 	const unsigned char *sha1 = ce->sha1;
 	unsigned int mode = ce->ce_mode;
@@ -489,8 +516,11 @@ static int get_stat_data(struct cache_entry *ce,
 	if (!cached) {
 		int changed;
 		struct stat st;
-		if (lstat(ce->name, &st) < 0) {
-			if (errno == ENOENT && match_missing) {
+		changed = check_work_tree_entity(ce, &st, NULL);
+		if (changed < 0)
+			return -1;
+		else if (changed) {
+			if (match_missing) {
 				*sha1p = sha1;
 				*modep = mode;
 				return 0;
@@ -509,23 +539,25 @@ static int get_stat_data(struct cache_entry *ce,
 	return 0;
 }
 
-static void show_new_file(struct rev_info *revs,
+static void show_new_file(struct oneway_unpack_data *cbdata,
 			  struct cache_entry *new,
 			  int cached, int match_missing)
 {
 	const unsigned char *sha1;
 	unsigned int mode;
+	struct rev_info *revs = cbdata->revs;
 
-	/* New file in the index: it might actually be different in
+	/*
+	 * New file in the index: it might actually be different in
 	 * the working copy.
 	 */
-	if (get_stat_data(new, &sha1, &mode, cached, match_missing) < 0)
+	if (get_stat_data(new, &sha1, &mode, cached, match_missing, cbdata) < 0)
 		return;
 
 	diff_index_show_file(revs, "+", new, sha1, mode);
 }
 
-static int show_modified(struct rev_info *revs,
+static int show_modified(struct oneway_unpack_data *cbdata,
 			 struct cache_entry *old,
 			 struct cache_entry *new,
 			 int report_missing,
@@ -533,8 +565,9 @@ static int show_modified(struct rev_info *revs,
 {
 	unsigned int mode, oldmode;
 	const unsigned char *sha1;
+	struct rev_info *revs = cbdata->revs;
 
-	if (get_stat_data(new, &sha1, &mode, cached, match_missing) < 0) {
+	if (get_stat_data(new, &sha1, &mode, cached, match_missing, cbdata) < 0) {
 		if (report_missing)
 			diff_index_show_file(revs, "-", old,
 					     old->sha1, old->ce_mode);
@@ -602,7 +635,8 @@ static void do_oneway_diff(struct unpack_trees_options *o,
 	struct cache_entry *idx,
 	struct cache_entry *tree)
 {
-	struct rev_info *revs = o->unpack_data;
+	struct oneway_unpack_data *cbdata = o->unpack_data;
+	struct rev_info *revs = cbdata->revs;
 	int match_missing, cached;
 
 	/*
@@ -625,7 +659,7 @@ static void do_oneway_diff(struct unpack_trees_options *o,
 	 * Something added to the tree?
 	 */
 	if (!tree) {
-		show_new_file(revs, idx, cached, match_missing);
+		show_new_file(cbdata, idx, cached, match_missing);
 		return;
 	}
 
@@ -638,7 +672,7 @@ static void do_oneway_diff(struct unpack_trees_options *o,
 	}
 
 	/* Show difference between old and new */
-	show_modified(revs, tree, idx, 1, cached, match_missing);
+	show_modified(cbdata, tree, idx, 1, cached, match_missing);
 }
 
 static inline void skip_same_name(struct cache_entry *ce, struct unpack_trees_options *o)
@@ -675,7 +709,8 @@ static int oneway_diff(struct cache_entry **src, struct unpack_trees_options *o)
 {
 	struct cache_entry *idx = src[0];
 	struct cache_entry *tree = src[1];
-	struct rev_info *revs = o->unpack_data;
+	struct oneway_unpack_data *cbdata = o->unpack_data;
+	struct rev_info *revs = cbdata->revs;
 
 	if (idx && ce_stage(idx))
 		skip_same_name(idx, o);
@@ -702,6 +737,7 @@ int run_diff_index(struct rev_info *revs, int cached)
 	const char *tree_name;
 	struct unpack_trees_options opts;
 	struct tree_desc t;
+	struct oneway_unpack_data unpack_cb;
 
 	mark_merge_entries();
 
@@ -711,12 +747,14 @@ int run_diff_index(struct rev_info *revs, int cached)
 	if (!tree)
 		return error("bad tree object %s", tree_name);
 
+	unpack_cb.revs = revs;
+	unpack_cb.symcache[0] = '\0';
 	memset(&opts, 0, sizeof(opts));
 	opts.head_idx = 1;
 	opts.index_only = cached;
 	opts.merge = 1;
 	opts.fn = oneway_diff;
-	opts.unpack_data = revs;
+	opts.unpack_data = &unpack_cb;
 	opts.src_index = &the_index;
 	opts.dst_index = NULL;
 
@@ -738,6 +776,7 @@ int do_diff_cache(const unsigned char *tree_sha1, struct diff_options *opt)
 	struct cache_entry *last = NULL;
 	struct unpack_trees_options opts;
 	struct tree_desc t;
+	struct oneway_unpack_data unpack_cb;
 
 	/*
 	 * This is used by git-blame to run diff-cache internally;
@@ -766,12 +805,14 @@ int do_diff_cache(const unsigned char *tree_sha1, struct diff_options *opt)
 	if (!tree)
 		die("bad tree object %s", sha1_to_hex(tree_sha1));
 
+	unpack_cb.revs = &revs;
+	unpack_cb.symcache[0] = '\0';
 	memset(&opts, 0, sizeof(opts));
 	opts.head_idx = 1;
 	opts.index_only = 1;
 	opts.merge = 1;
 	opts.fn = oneway_diff;
-	opts.unpack_data = &revs;
+	opts.unpack_data = &unpack_cb;
 	opts.src_index = &the_index;
 	opts.dst_index = &the_index;
 
diff --git a/t/t2201-add-update-typechange.sh b/t/t2201-add-update-typechange.sh
index 75c440c..469a8e0 100755
--- a/t/t2201-add-update-typechange.sh
+++ b/t/t2201-add-update-typechange.sh
@@ -109,7 +109,7 @@ test_expect_failure diff-files '
 	diff -u expect-files actual
 '
 
-test_expect_failure diff-index '
+test_expect_success diff-index '
 	git diff-index --raw HEAD -- >actual &&
 	diff -u expect-index actual
 '
-- 
1.5.5.rc2.131.g3d2f0
