From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] merge-recursive: get rid of the index_only global variable
Date: Wed,  3 Sep 2008 02:16:59 +0200
Message-ID: <1220401019-30763-1-git-send-email-vmiklos@frugalware.org>
References: <7vk5dui34q.fsf@gitster.siamese.dyndns.org>
Cc: git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 03 02:18:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kag4t-00015A-N5
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 02:18:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754161AbYICARH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 20:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752032AbYICARG
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 20:17:06 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:33216 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754154AbYICARE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 20:17:04 -0400
Received: from vmobile.example.net (catv-80-98-230-81.catv.broadband.hu [80.98.230.81])
	by yugo.frugalware.org (Postfix) with ESMTP id 72C441DDC5B;
	Wed,  3 Sep 2008 02:17:01 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id BF7F684CA; Wed,  3 Sep 2008 02:16:59 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.1
In-Reply-To: <7vk5dui34q.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94747>

struct merge_options as already a call_depth member, where index_only ==
!!call_depth. We always use index_only as a condition, so we can just
use call_depth instead of index_only.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

On Tue, Sep 02, 2008 at 03:39:33PM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> I suspected that it always holds that "index_only === !!call_depth".

Uhm, yes. Here is an updated version that just removes the global
index_only and does not touch the header.

The patch is still large, as I still needed to introduce struct
merge_options as the first parameter in several functions.

 merge-recursive.c |  140 +++++++++++++++++++++++++---------------------------
 1 files changed, 67 insertions(+), 73 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 5bb20aa..c426589 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -165,17 +165,6 @@ static int add_cacheinfo(unsigned int mode, const unsigned char *sha1,
 	return add_cache_entry(ce, options);
 }
 
-/*
- * This is a global variable which is used in a number of places but
- * only written to in the 'merge' function.
- *
- * index_only == 1    => Don't leave any non-stage 0 entries in the cache and
- *                       don't update the working directory.
- *               0    => Leave unmerged entries in the cache and update
- *                       the working directory.
- */
-static int index_only = 0;
-
 static void init_tree_desc_from_tree(struct tree_desc *desc, struct tree *tree)
 {
 	parse_tree(tree);
@@ -428,10 +417,11 @@ static int remove_path(const char *name)
 	return ret;
 }
 
-static int remove_file(int clean, const char *path, int no_wd)
+static int remove_file(struct merge_options *o, int clean,
+		       const char *path, int no_wd)
 {
-	int update_cache = index_only || clean;
-	int update_working_directory = !index_only && !no_wd;
+	int update_cache = o->call_depth || clean;
+	int update_working_directory = !o->call_depth && !no_wd;
 
 	if (update_cache) {
 		if (remove_file_from_cache(path))
@@ -509,13 +499,14 @@ static int make_room_for_path(const char *path)
 	return error(msg, path, ": perhaps a D/F conflict?");
 }
 
-static void update_file_flags(const unsigned char *sha,
+static void update_file_flags(struct merge_options *o,
+			      const unsigned char *sha,
 			      unsigned mode,
 			      const char *path,
 			      int update_cache,
 			      int update_wd)
 {
-	if (index_only)
+	if (o->call_depth)
 		update_wd = 0;
 
 	if (update_wd) {
@@ -574,12 +565,13 @@ static void update_file_flags(const unsigned char *sha,
 		add_cacheinfo(mode, sha, path, 0, update_wd, ADD_CACHE_OK_TO_ADD);
 }
 
-static void update_file(int clean,
+static void update_file(struct merge_options *o,
+			int clean,
 			const unsigned char *sha,
 			unsigned mode,
 			const char *path)
 {
-	update_file_flags(sha, mode, path, index_only || clean, !index_only);
+	update_file_flags(o, sha, mode, path, o->call_depth || clean, !o->call_depth);
 }
 
 /* Low level file merging, update and removal */
@@ -609,8 +601,9 @@ static void fill_mm(const unsigned char *sha1, mmfile_t *mm)
 	mm->size = size;
 }
 
-static int merge_3way(mmbuffer_t *result_buf,
-		      struct diff_filespec *o,
+static int merge_3way(struct merge_options *o,
+		      mmbuffer_t *result_buf,
+		      struct diff_filespec *one,
 		      struct diff_filespec *a,
 		      struct diff_filespec *b,
 		      const char *branch1,
@@ -623,13 +616,13 @@ static int merge_3way(mmbuffer_t *result_buf,
 	name1 = xstrdup(mkpath("%s:%s", branch1, a->path));
 	name2 = xstrdup(mkpath("%s:%s", branch2, b->path));
 
-	fill_mm(o->sha1, &orig);
+	fill_mm(one->sha1, &orig);
 	fill_mm(a->sha1, &src1);
 	fill_mm(b->sha1, &src2);
 
 	merge_status = ll_merge(result_buf, a->path, &orig,
 				&src1, name1, &src2, name2,
-				index_only);
+				o->call_depth);
 
 	free(name1);
 	free(name2);
@@ -639,9 +632,12 @@ static int merge_3way(mmbuffer_t *result_buf,
 	return merge_status;
 }
 
-static struct merge_file_info merge_file(struct diff_filespec *o,
-		struct diff_filespec *a, struct diff_filespec *b,
-		const char *branch1, const char *branch2)
+static struct merge_file_info merge_file(struct merge_options *o,
+				         struct diff_filespec *one,
+					 struct diff_filespec *a,
+					 struct diff_filespec *b,
+					 const char *branch1,
+					 const char *branch2)
 {
 	struct merge_file_info result;
 	result.merge = 0;
@@ -657,31 +653,31 @@ static struct merge_file_info merge_file(struct diff_filespec *o,
 			hashcpy(result.sha, b->sha1);
 		}
 	} else {
-		if (!sha_eq(a->sha1, o->sha1) && !sha_eq(b->sha1, o->sha1))
+		if (!sha_eq(a->sha1, one->sha1) && !sha_eq(b->sha1, one->sha1))
 			result.merge = 1;
 
 		/*
 		 * Merge modes
 		 */
-		if (a->mode == b->mode || a->mode == o->mode)
+		if (a->mode == b->mode || a->mode == one->mode)
 			result.mode = b->mode;
 		else {
 			result.mode = a->mode;
-			if (b->mode != o->mode) {
+			if (b->mode != one->mode) {
 				result.clean = 0;
 				result.merge = 1;
 			}
 		}
 
-		if (sha_eq(a->sha1, b->sha1) || sha_eq(a->sha1, o->sha1))
+		if (sha_eq(a->sha1, b->sha1) || sha_eq(a->sha1, one->sha1))
 			hashcpy(result.sha, b->sha1);
-		else if (sha_eq(b->sha1, o->sha1))
+		else if (sha_eq(b->sha1, one->sha1))
 			hashcpy(result.sha, a->sha1);
 		else if (S_ISREG(a->mode)) {
 			mmbuffer_t result_buf;
 			int merge_status;
 
-			merge_status = merge_3way(&result_buf, o, a, b,
+			merge_status = merge_3way(o, &result_buf, one, a, b,
 						  branch1, branch2);
 
 			if ((merge_status < 0) || !result_buf.ptr)
@@ -726,22 +722,22 @@ static void conflict_rename_rename(struct merge_options *o,
 		dst_name1 = del[delp++] = unique_path(ren1_dst, branch1);
 		output(o, 1, "%s is a directory in %s adding as %s instead",
 		       ren1_dst, branch2, dst_name1);
-		remove_file(0, ren1_dst, 0);
+		remove_file(o, 0, ren1_dst, 0);
 	}
 	if (string_list_has_string(&current_directory_set, ren2_dst)) {
 		dst_name2 = del[delp++] = unique_path(ren2_dst, branch2);
 		output(o, 1, "%s is a directory in %s adding as %s instead",
 		       ren2_dst, branch1, dst_name2);
-		remove_file(0, ren2_dst, 0);
+		remove_file(o, 0, ren2_dst, 0);
 	}
-	if (index_only) {
+	if (o->call_depth) {
 		remove_file_from_cache(dst_name1);
 		remove_file_from_cache(dst_name2);
 		/*
 		 * Uncomment to leave the conflicting names in the resulting tree
 		 *
-		 * update_file(0, ren1->pair->two->sha1, ren1->pair->two->mode, dst_name1);
-		 * update_file(0, ren2->pair->two->sha1, ren2->pair->two->mode, dst_name2);
+		 * update_file(o, 0, ren1->pair->two->sha1, ren1->pair->two->mode, dst_name1);
+		 * update_file(o, 0, ren2->pair->two->sha1, ren2->pair->two->mode, dst_name2);
 		 */
 	} else {
 		update_stages(dst_name1, NULL, ren1->pair->two, NULL, 1);
@@ -757,8 +753,8 @@ static void conflict_rename_dir(struct merge_options *o,
 {
 	char *new_path = unique_path(ren1->pair->two->path, branch1);
 	output(o, 1, "Renaming %s to %s instead", ren1->pair->one->path, new_path);
-	remove_file(0, ren1->pair->two->path, 0);
-	update_file(0, ren1->pair->two->sha1, ren1->pair->two->mode, new_path);
+	remove_file(o, 0, ren1->pair->two->path, 0);
+	update_file(o, 0, ren1->pair->two->sha1, ren1->pair->two->mode, new_path);
 	free(new_path);
 }
 
@@ -773,9 +769,9 @@ static void conflict_rename_rename_2(struct merge_options *o,
 	output(o, 1, "Renaming %s to %s and %s to %s instead",
 	       ren1->pair->one->path, new_path1,
 	       ren2->pair->one->path, new_path2);
-	remove_file(0, ren1->pair->two->path, 0);
-	update_file(0, ren1->pair->two->sha1, ren1->pair->two->mode, new_path1);
-	update_file(0, ren2->pair->two->sha1, ren2->pair->two->mode, new_path2);
+	remove_file(o, 0, ren1->pair->two->path, 0);
+	update_file(o, 0, ren1->pair->two->sha1, ren1->pair->two->mode, new_path1);
+	update_file(o, 0, ren2->pair->two->sha1, ren2->pair->two->mode, new_path2);
 	free(new_path2);
 	free(new_path1);
 }
@@ -867,17 +863,18 @@ static int process_renames(struct merge_options *o,
 				       "rename \"%s\"->\"%s\" in \"%s\"%s",
 				       src, ren1_dst, branch1,
 				       src, ren2_dst, branch2,
-				       index_only ? " (left unresolved)": "");
-				if (index_only) {
+				       o->call_depth ? " (left unresolved)": "");
+				if (o->call_depth) {
 					remove_file_from_cache(src);
-					update_file(0, ren1->pair->one->sha1,
+					update_file(o, 0, ren1->pair->one->sha1,
 						    ren1->pair->one->mode, src);
 				}
 				conflict_rename_rename(o, ren1, branch1, ren2, branch2);
 			} else {
 				struct merge_file_info mfi;
-				remove_file(1, ren1_src, 1);
-				mfi = merge_file(ren1->pair->one,
+				remove_file(o, 1, ren1_src, 1);
+				mfi = merge_file(o,
+						 ren1->pair->one,
 						 ren1->pair->two,
 						 ren2->pair->two,
 						 branch1,
@@ -893,14 +890,14 @@ static int process_renames(struct merge_options *o,
 					       ren1_dst);
 					clean_merge = 0;
 
-					if (!index_only)
+					if (!o->call_depth)
 						update_stages(ren1_dst,
 							      ren1->pair->one,
 							      ren1->pair->two,
 							      ren2->pair->two,
 							      1 /* clear */);
 				}
-				update_file(mfi.clean, mfi.sha, mfi.mode, ren1_dst);
+				update_file(o, mfi.clean, mfi.sha, mfi.mode, ren1_dst);
 			}
 		} else {
 			/* Renamed in 1, maybe changed in 2 */
@@ -909,7 +906,7 @@ static int process_renames(struct merge_options *o,
 			struct diff_filespec src_other, dst_other;
 			int try_merge, stage = a_renames == renames1 ? 3: 2;
 
-			remove_file(1, ren1_src, index_only || stage == 3);
+			remove_file(o, 1, ren1_src, o->call_depth || stage == 3);
 
 			hashcpy(src_other.sha1, ren1->src_entry->stages[stage].sha);
 			src_other.mode = ren1->src_entry->stages[stage].mode;
@@ -931,7 +928,7 @@ static int process_renames(struct merge_options *o,
 				       "and deleted in %s",
 				       ren1_src, ren1_dst, branch1,
 				       branch2);
-				update_file(0, ren1->pair->two->sha1, ren1->pair->two->mode, ren1_dst);
+				update_file(o, 0, ren1->pair->two->sha1, ren1->pair->two->mode, ren1_dst);
 			} else if (!sha_eq(dst_other.sha1, null_sha1)) {
 				const char *new_path;
 				clean_merge = 0;
@@ -942,7 +939,7 @@ static int process_renames(struct merge_options *o,
 				       ren1_dst, branch2);
 				new_path = unique_path(ren1_dst, branch2);
 				output(o, 1, "Adding as %s instead", new_path);
-				update_file(0, dst_other.sha1, dst_other.mode, new_path);
+				update_file(o, 0, dst_other.sha1, dst_other.mode, new_path);
 			} else if ((item = string_list_lookup(ren1_dst, renames2Dst))) {
 				ren2 = item->util;
 				clean_merge = 0;
@@ -969,7 +966,7 @@ static int process_renames(struct merge_options *o,
 					b = ren1->pair->two;
 					a = &src_other;
 				}
-				mfi = merge_file(one, a, b,
+				mfi = merge_file(o, one, a, b,
 						o->branch1, o->branch2);
 
 				if (mfi.clean &&
@@ -991,11 +988,11 @@ static int process_renames(struct merge_options *o,
 						       ren1_dst);
 						clean_merge = 0;
 
-						if (!index_only)
+						if (!o->call_depth)
 							update_stages(ren1_dst,
 								      one, a, b, 1);
 					}
-					update_file(mfi.clean, mfi.sha, mfi.mode, ren1_dst);
+					update_file(o, mfi.clean, mfi.sha, mfi.mode, ren1_dst);
 				}
 			}
 		}
@@ -1037,7 +1034,7 @@ static int process_entry(struct merge_options *o,
 			if (a_sha)
 				output(o, 2, "Removing %s", path);
 			/* do not touch working file if it did not exist */
-			remove_file(1, path, !a_sha);
+			remove_file(o, 1, path, !a_sha);
 		} else {
 			/* Deleted in one and changed in the other */
 			clean_merge = 0;
@@ -1046,13 +1043,13 @@ static int process_entry(struct merge_options *o,
 				       "and modified in %s. Version %s of %s left in tree.",
 				       path, o->branch1,
 				       o->branch2, o->branch2, path);
-				update_file(0, b_sha, b_mode, path);
+				update_file(o, 0, b_sha, b_mode, path);
 			} else {
 				output(o, 1, "CONFLICT (delete/modify): %s deleted in %s "
 				       "and modified in %s. Version %s of %s left in tree.",
 				       path, o->branch2,
 				       o->branch1, o->branch1, path);
-				update_file(0, a_sha, a_mode, path);
+				update_file(o, 0, a_sha, a_mode, path);
 			}
 		}
 
@@ -1084,11 +1081,11 @@ static int process_entry(struct merge_options *o,
 			output(o, 1, "CONFLICT (%s): There is a directory with name %s in %s. "
 			       "Adding %s as %s",
 			       conf, path, other_branch, path, new_path);
-			remove_file(0, path, 0);
-			update_file(0, sha, mode, new_path);
+			remove_file(o, 0, path, 0);
+			update_file(o, 0, sha, mode, new_path);
 		} else {
 			output(o, 2, "Adding %s", path);
-			update_file(1, sha, mode, path);
+			update_file(o, 1, sha, mode, path);
 		}
 	} else if (a_sha && b_sha) {
 		/* Case C: Added in both (check for same permissions) and */
@@ -1110,12 +1107,12 @@ static int process_entry(struct merge_options *o,
 		hashcpy(b.sha1, b_sha);
 		b.mode = b_mode;
 
-		mfi = merge_file(&one, &a, &b,
+		mfi = merge_file(o, &one, &a, &b,
 				 o->branch1, o->branch2);
 
 		clean_merge = mfi.clean;
 		if (mfi.clean)
-			update_file(1, mfi.sha, mfi.mode, path);
+			update_file(o, 1, mfi.sha, mfi.mode, path);
 		else if (S_ISGITLINK(mfi.mode))
 			output(o, 1, "CONFLICT (submodule): Merge conflict in %s "
 			       "- needs %s", path, sha1_to_hex(b.sha1));
@@ -1123,10 +1120,10 @@ static int process_entry(struct merge_options *o,
 			output(o, 1, "CONFLICT (%s): Merge conflict in %s",
 					reason, path);
 
-			if (index_only)
-				update_file(0, mfi.sha, mfi.mode, path);
+			if (o->call_depth)
+				update_file(o, 0, mfi.sha, mfi.mode, path);
 			else
-				update_file_flags(mfi.sha, mfi.mode, path,
+				update_file_flags(o, mfi.sha, mfi.mode, path,
 					      0 /* update_cache */, 1 /* update_working_directory */);
 		}
 	} else if (!o_sha && !a_sha && !b_sha) {
@@ -1134,7 +1131,7 @@ static int process_entry(struct merge_options *o,
 		 * this entry was deleted altogether. a_mode == 0 means
 		 * we had that path and want to actively remove it.
 		 */
-		remove_file(1, path, !a_mode);
+		remove_file(o, 1, path, !a_mode);
 	} else
 		die("Fatal merge failure, shouldn't happen.");
 
@@ -1160,7 +1157,7 @@ int merge_trees(struct merge_options *o,
 		return 1;
 	}
 
-	code = git_merge_trees(index_only, common, head, merge);
+	code = git_merge_trees(o->call_depth, common, head, merge);
 
 	if (code != 0)
 		die("merging of trees %s and %s failed",
@@ -1195,7 +1192,7 @@ int merge_trees(struct merge_options *o,
 	else
 		clean = 1;
 
-	if (index_only)
+	if (o->call_depth)
 		*result = write_tree_from_memory(o);
 
 	return clean;
@@ -1281,16 +1278,13 @@ int merge_recursive(struct merge_options *o,
 	}
 
 	discard_cache();
-	if (!o->call_depth) {
+	if (!o->call_depth)
 		read_cache();
-		index_only = 0;
-	} else
-		index_only = 1;
 
 	clean = merge_trees(o, h1->tree, h2->tree, merged_common_ancestors->tree,
 			    &mrtree);
 
-	if (index_only) {
+	if (o->call_depth) {
 		*result = make_virtual_commit(mrtree, "merged tree");
 		commit_list_insert(h1, &(*result)->parents);
 		commit_list_insert(h2, &(*result)->parents->next);
-- 
1.6.0.1
