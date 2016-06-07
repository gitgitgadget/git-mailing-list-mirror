From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 7/8] merge-recursive: convert leaf functions to use struct object_id
Date: Tue,  7 Jun 2016 00:57:15 +0000
Message-ID: <20160607005716.69222-8-sandals@crustytoothpaste.net>
References: <20160607005716.69222-2-sandals@crustytoothpaste.net>
Cc: Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 07 02:59:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bA5MB-00042D-R7
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 02:59:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753870AbcFGA61 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2016 20:58:27 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:40764 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751044AbcFGA52 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jun 2016 20:57:28 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id E603E282AE;
	Tue,  7 Jun 2016 00:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1465261046;
	bh=fuL1/tUWQGsv5zaTupi4joovfOWPHdZIuQVHR5KSiTo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s3am9rhmlsBnEGEhqK9pmsaseeGNKNsNRycQznVXDnl2H+6ZoYM1cJyg9AvJjEwfw
	 K7mpNrBoIPMVxOlS76pAQMW8VznnkpF7sM+UNJ/fE/toWGyL2Dy0blNNlbbdBv/URf
	 p8cu5uaT6ZL1ahEARpT6UNCgVfHrjAidXZ9NDZVf0QRpwxoQy2jb2YAPayUUeWnYHg
	 y5wA+v3k81e0g9ShoY10VRi/bIgB2GVA5kw+6dPQP4Tnh/RLQGeBYN8U0NxI+t9iLv
	 YuToA2nUO1wWc3npFJQ8OBhd2jSDr7dP7+su0dxvFI4hvkDTfjkfzDyWxqYRmLh6ZC
	 JT3rzSdEA9Kg7wzt1hj9GroCjIczPjSdpdkbeC5gWO0f8gIyuvGBvQ5o152stUveIp
	 0EG0gkVf1KRdTD9+8Uha2irfHg/ZY/bWgaXC97lB8vDDApHm5aTJPwYnmU7z52dTho
	 i6rexhvNzyhORGF3zga5Dy6l1uHBni1kb+bt5cX51Mq9qKvTzjm
X-Mailer: git-send-email 2.8.1.369.geae769a
In-Reply-To: <20160607005716.69222-2-sandals@crustytoothpaste.net>
X-Spam-Score: -0.262 BAYES_00,RDNS_NONE,T_DKIM_INVALID
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296589>

Convert all but two of the static functions in this file to use struct
object_id.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 merge-recursive.c | 236 +++++++++++++++++++++++++++---------------------------
 1 file changed, 118 insertions(+), 118 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index bc455491..7bbd4aea 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -56,11 +56,11 @@ static struct commit *make_virtual_commit(struct tree *tree, const char *comment
  * Since we use get_tree_entry(), which does not put the read object into
  * the object pool, we cannot rely on a == b.
  */
-static int sha_eq(const unsigned char *a, const unsigned char *b)
+static int oid_eq(const struct object_id *a, const struct object_id *b)
 {
 	if (!a && !b)
 		return 2;
-	return a && b && hashcmp(a, b) == 0;
+	return a && b && oidcmp(a, b) == 0;
 }
 
 enum rename_type {
@@ -198,11 +198,11 @@ static void output_commit_title(struct merge_options *o, struct commit *commit)
 	}
 }
 
-static int add_cacheinfo(unsigned int mode, const unsigned char *sha1,
+static int add_cacheinfo(unsigned int mode, const struct object_id *oid,
 		const char *path, int stage, int refresh, int options)
 {
 	struct cache_entry *ce;
-	ce = make_cache_entry(mode, sha1 ? sha1 : null_sha1, path, stage,
+	ce = make_cache_entry(mode, oid ? oid->hash : null_sha1, path, stage,
 			      (refresh ? (CE_MATCH_REFRESH |
 					  CE_MATCH_IGNORE_MISSING) : 0 ));
 	if (!ce)
@@ -552,13 +552,13 @@ static int update_stages(const char *path, const struct diff_filespec *o,
 		if (remove_file_from_cache(path))
 			return -1;
 	if (o)
-		if (add_cacheinfo(o->mode, o->oid.hash, path, 1, 0, options))
+		if (add_cacheinfo(o->mode, &o->oid, path, 1, 0, options))
 			return -1;
 	if (a)
-		if (add_cacheinfo(a->mode, a->oid.hash, path, 2, 0, options))
+		if (add_cacheinfo(a->mode, &a->oid, path, 2, 0, options))
 			return -1;
 	if (b)
-		if (add_cacheinfo(b->mode, b->oid.hash, path, 3, 0, options))
+		if (add_cacheinfo(b->mode, &b->oid, path, 3, 0, options))
 			return -1;
 	return 0;
 }
@@ -736,7 +736,7 @@ static int make_room_for_path(struct merge_options *o, const char *path)
 }
 
 static void update_file_flags(struct merge_options *o,
-			      const unsigned char *sha,
+			      const struct object_id *oid,
 			      unsigned mode,
 			      const char *path,
 			      int update_cache,
@@ -760,11 +760,11 @@ static void update_file_flags(struct merge_options *o,
 			goto update_index;
 		}
 
-		buf = read_sha1_file(sha, &type, &size);
+		buf = read_sha1_file(oid->hash, &type, &size);
 		if (!buf)
-			die(_("cannot read object %s '%s'"), sha1_to_hex(sha), path);
+			die(_("cannot read object %s '%s'"), oid_to_hex(oid), path);
 		if (type != OBJ_BLOB)
-			die(_("blob expected for %s '%s'"), sha1_to_hex(sha), path);
+			die(_("blob expected for %s '%s'"), oid_to_hex(oid), path);
 		if (S_ISREG(mode)) {
 			struct strbuf strbuf = STRBUF_INIT;
 			if (convert_to_working_tree(path, buf, size, &strbuf)) {
@@ -799,21 +799,21 @@ static void update_file_flags(struct merge_options *o,
 			free(lnk);
 		} else
 			die(_("do not know what to do with %06o %s '%s'"),
-			    mode, sha1_to_hex(sha), path);
+			    mode, oid_to_hex(oid), path);
 		free(buf);
 	}
  update_index:
 	if (update_cache)
-		add_cacheinfo(mode, sha, path, 0, update_wd, ADD_CACHE_OK_TO_ADD);
+		add_cacheinfo(mode, oid, path, 0, update_wd, ADD_CACHE_OK_TO_ADD);
 }
 
 static void update_file(struct merge_options *o,
 			int clean,
-			const unsigned char *sha,
+			const struct object_id *oid,
 			unsigned mode,
 			const char *path)
 {
-	update_file_flags(o, sha, mode, path, o->call_depth || clean, !o->call_depth);
+	update_file_flags(o, oid, mode, path, o->call_depth || clean, !o->call_depth);
 }
 
 /* Low level file merging, update and removal */
@@ -908,7 +908,7 @@ static struct merge_file_info merge_file_1(struct merge_options *o,
 			oidcpy(&result.oid, &b->oid);
 		}
 	} else {
-		if (!sha_eq(a->oid.hash, one->oid.hash) && !sha_eq(b->oid.hash, one->oid.hash))
+		if (!oid_eq(&a->oid, &one->oid) && !oid_eq(&b->oid, &one->oid))
 			result.merge = 1;
 
 		/*
@@ -924,9 +924,9 @@ static struct merge_file_info merge_file_1(struct merge_options *o,
 			}
 		}
 
-		if (sha_eq(a->oid.hash, b->oid.hash) || sha_eq(a->oid.hash, one->oid.hash))
+		if (oid_eq(&a->oid, &b->oid) || oid_eq(&a->oid, &one->oid))
 			oidcpy(&result.oid, &b->oid);
-		else if (sha_eq(b->oid.hash, one->oid.hash))
+		else if (oid_eq(&b->oid, &one->oid))
 			oidcpy(&result.oid, &a->oid);
 		else if (S_ISREG(a->mode)) {
 			mmbuffer_t result_buf;
@@ -955,7 +955,7 @@ static struct merge_file_info merge_file_1(struct merge_options *o,
 		} else if (S_ISLNK(a->mode)) {
 			oidcpy(&result.oid, &a->oid);
 
-			if (!sha_eq(a->oid.hash, b->oid.hash))
+			if (!oid_eq(&a->oid, &b->oid))
 				result.clean = 0;
 		} else {
 			die(_("unsupported object type in the tree"));
@@ -993,34 +993,34 @@ merge_file_special_markers(struct merge_options *o,
 
 static struct merge_file_info merge_file_one(struct merge_options *o,
 					 const char *path,
-					 const unsigned char *o_sha, int o_mode,
-					 const unsigned char *a_sha, int a_mode,
-					 const unsigned char *b_sha, int b_mode,
+					 const struct object_id *o_oid, int o_mode,
+					 const struct object_id *a_oid, int a_mode,
+					 const struct object_id *b_oid, int b_mode,
 					 const char *branch1,
 					 const char *branch2)
 {
 	struct diff_filespec one, a, b;
 
 	one.path = a.path = b.path = (char *)path;
-	hashcpy(one.oid.hash, o_sha);
+	oidcpy(&one.oid, o_oid);
 	one.mode = o_mode;
-	hashcpy(a.oid.hash, a_sha);
+	oidcpy(&a.oid, a_oid);
 	a.mode = a_mode;
-	hashcpy(b.oid.hash, b_sha);
+	oidcpy(&b.oid, b_oid);
 	b.mode = b_mode;
 	return merge_file_1(o, &one, &a, &b, branch1, branch2);
 }
 
 static void handle_change_delete(struct merge_options *o,
 				 const char *path,
-				 const unsigned char *o_sha, int o_mode,
-				 const unsigned char *a_sha, int a_mode,
-				 const unsigned char *b_sha, int b_mode,
+				 const struct object_id *o_oid, int o_mode,
+				 const struct object_id *a_oid, int a_mode,
+				 const struct object_id *b_oid, int b_mode,
 				 const char *change, const char *change_past)
 {
 	char *renamed = NULL;
 	if (dir_in_way(path, !o->call_depth)) {
-		renamed = unique_path(o, path, a_sha ? o->branch1 : o->branch2);
+		renamed = unique_path(o, path, a_oid ? o->branch1 : o->branch2);
 	}
 
 	if (o->call_depth) {
@@ -1030,20 +1030,20 @@ static void handle_change_delete(struct merge_options *o,
 		 * them, simply reuse the base version for virtual merge base.
 		 */
 		remove_file_from_cache(path);
-		update_file(o, 0, o_sha, o_mode, renamed ? renamed : path);
-	} else if (!a_sha) {
+		update_file(o, 0, o_oid, o_mode, renamed ? renamed : path);
+	} else if (!a_oid) {
 		if (!renamed) {
 			output(o, 1, _("CONFLICT (%s/delete): %s deleted in %s "
 			       "and %s in %s. Version %s of %s left in tree."),
 			       change, path, o->branch1, change_past,
 			       o->branch2, o->branch2, path);
-			update_file(o, 0, b_sha, b_mode, path);
+			update_file(o, 0, b_oid, b_mode, path);
 		} else {
 			output(o, 1, _("CONFLICT (%s/delete): %s deleted in %s "
 			       "and %s in %s. Version %s of %s left in tree at %s."),
 			       change, path, o->branch1, change_past,
 			       o->branch2, o->branch2, path, renamed);
-			update_file(o, 0, b_sha, b_mode, renamed);
+			update_file(o, 0, b_oid, b_mode, renamed);
 		}
 	} else {
 		if (!renamed) {
@@ -1056,7 +1056,7 @@ static void handle_change_delete(struct merge_options *o,
 			       "and %s in %s. Version %s of %s left in tree at %s."),
 			       change, path, o->branch2, change_past,
 			       o->branch1, o->branch1, path, renamed);
-			update_file(o, 0, a_sha, a_mode, renamed);
+			update_file(o, 0, a_oid, a_mode, renamed);
 		}
 		/*
 		 * No need to call update_file() on path when !renamed, since
@@ -1075,24 +1075,24 @@ static void conflict_rename_delete(struct merge_options *o,
 {
 	const struct diff_filespec *orig = pair->one;
 	const struct diff_filespec *dest = pair->two;
-	const unsigned char *a_sha = NULL;
-	const unsigned char *b_sha = NULL;
+	const struct object_id *a_oid = NULL;
+	const struct object_id *b_oid = NULL;
 	int a_mode = 0;
 	int b_mode = 0;
 
 	if (rename_branch == o->branch1) {
-		a_sha = dest->oid.hash;
+		a_oid = &dest->oid;
 		a_mode = dest->mode;
 	} else {
-		b_sha = dest->oid.hash;
+		b_oid = &dest->oid;
 		b_mode = dest->mode;
 	}
 
 	handle_change_delete(o,
 			     o->call_depth ? orig->path : dest->path,
-			     orig->oid.hash, orig->mode,
-			     a_sha, a_mode,
-			     b_sha, b_mode,
+			     &orig->oid, orig->mode,
+			     a_oid, a_mode,
+			     b_oid, b_mode,
 			     _("rename"), _("renamed"));
 
 	if (o->call_depth) {
@@ -1109,11 +1109,11 @@ static struct diff_filespec *filespec_from_entry(struct diff_filespec *target,
 						 struct stage_data *entry,
 						 int stage)
 {
-	unsigned char *sha = entry->stages[stage].oid.hash;
+	struct object_id *oid = &entry->stages[stage].oid;
 	unsigned mode = entry->stages[stage].mode;
-	if (mode == 0 || is_null_sha1(sha))
+	if (mode == 0 || is_null_oid(oid))
 		return NULL;
-	hashcpy(target->oid.hash, sha);
+	oidcpy(&target->oid, oid);
 	target->mode = mode;
 	return target;
 }
@@ -1142,7 +1142,7 @@ static void handle_file(struct merge_options *o,
 	add = filespec_from_entry(&other, dst_entry, stage ^ 1);
 	if (add) {
 		char *add_name = unique_path(o, rename->path, other_branch);
-		update_file(o, 0, add->oid.hash, add->mode, add_name);
+		update_file(o, 0, &add->oid, add->mode, add_name);
 
 		remove_file(o, 0, rename->path, 0);
 		dst_name = unique_path(o, rename->path, cur_branch);
@@ -1153,7 +1153,7 @@ static void handle_file(struct merge_options *o,
 			       rename->path, other_branch, dst_name);
 		}
 	}
-	update_file(o, 0, rename->oid.hash, rename->mode, dst_name);
+	update_file(o, 0, &rename->oid, rename->mode, dst_name);
 	if (stage == 2)
 		update_stages(rename->path, NULL, rename, add);
 	else
@@ -1182,9 +1182,9 @@ static void conflict_rename_rename_1to2(struct merge_options *o,
 		struct diff_filespec other;
 		struct diff_filespec *add;
 		mfi = merge_file_one(o, one->path,
-				 one->oid.hash, one->mode,
-				 a->oid.hash, a->mode,
-				 b->oid.hash, b->mode,
+				 &one->oid, one->mode,
+				 &a->oid, a->mode,
+				 &b->oid, b->mode,
 				 ci->branch1, ci->branch2);
 		/*
 		 * FIXME: For rename/add-source conflicts (if we could detect
@@ -1192,7 +1192,7 @@ static void conflict_rename_rename_1to2(struct merge_options *o,
 		 * pathname and then either rename the add-source file to that
 		 * unique path, or use that unique path instead of src here.
 		 */
-		update_file(o, 0, mfi.oid.hash, mfi.mode, one->path);
+		update_file(o, 0, &mfi.oid, mfi.mode, one->path);
 
 		/*
 		 * Above, we put the merged content at the merge-base's
@@ -1204,12 +1204,12 @@ static void conflict_rename_rename_1to2(struct merge_options *o,
 		 */
 		add = filespec_from_entry(&other, ci->dst_entry1, 2 ^ 1);
 		if (add)
-			update_file(o, 0, add->oid.hash, add->mode, a->path);
+			update_file(o, 0, &add->oid, add->mode, a->path);
 		else
 			remove_file_from_cache(a->path);
 		add = filespec_from_entry(&other, ci->dst_entry2, 3 ^ 1);
 		if (add)
-			update_file(o, 0, add->oid.hash, add->mode, b->path);
+			update_file(o, 0, &add->oid, add->mode, b->path);
 		else
 			remove_file_from_cache(b->path);
 	} else {
@@ -1255,16 +1255,16 @@ static void conflict_rename_rename_2to1(struct merge_options *o,
 		 * again later for the non-recursive merge.
 		 */
 		remove_file(o, 0, path, 0);
-		update_file(o, 0, mfi_c1.oid.hash, mfi_c1.mode, a->path);
-		update_file(o, 0, mfi_c2.oid.hash, mfi_c2.mode, b->path);
+		update_file(o, 0, &mfi_c1.oid, mfi_c1.mode, a->path);
+		update_file(o, 0, &mfi_c2.oid, mfi_c2.mode, b->path);
 	} else {
 		char *new_path1 = unique_path(o, path, ci->branch1);
 		char *new_path2 = unique_path(o, path, ci->branch2);
 		output(o, 1, _("Renaming %s to %s and %s to %s instead"),
 		       a->path, new_path1, b->path, new_path2);
 		remove_file(o, 0, path, 0);
-		update_file(o, 0, mfi_c1.oid.hash, mfi_c1.mode, new_path1);
-		update_file(o, 0, mfi_c2.oid.hash, mfi_c2.mode, new_path2);
+		update_file(o, 0, &mfi_c1.oid, mfi_c1.mode, new_path1);
+		update_file(o, 0, &mfi_c2.oid, mfi_c2.mode, new_path2);
 		free(new_path2);
 		free(new_path1);
 	}
@@ -1431,7 +1431,7 @@ static int process_renames(struct merge_options *o,
 			dst_other.mode = ren1->dst_entry->stages[other_stage].mode;
 			try_merge = 0;
 
-			if (sha_eq(src_other.oid.hash, null_sha1)) {
+			if (oid_eq(&src_other.oid, &null_oid)) {
 				setup_rename_conflict_info(RENAME_DELETE,
 							   ren1->pair,
 							   NULL,
@@ -1443,7 +1443,7 @@ static int process_renames(struct merge_options *o,
 							   NULL,
 							   NULL);
 			} else if ((dst_other.mode == ren1->pair->two->mode) &&
-				   sha_eq(dst_other.oid.hash, ren1->pair->two->oid.hash)) {
+				   oid_eq(&dst_other.oid, &ren1->pair->two->oid)) {
 				/*
 				 * Added file on the other side identical to
 				 * the file being renamed: clean merge.
@@ -1453,12 +1453,12 @@ static int process_renames(struct merge_options *o,
 				 * update_file().
 				 */
 				update_file_flags(o,
-						  ren1->pair->two->oid.hash,
+						  &ren1->pair->two->oid,
 						  ren1->pair->two->mode,
 						  ren1_dst,
 						  1, /* update_cache */
 						  0  /* update_wd    */);
-			} else if (!sha_eq(dst_other.oid.hash, null_sha1)) {
+			} else if (!oid_eq(&dst_other.oid, &null_oid)) {
 				clean_merge = 0;
 				try_merge = 1;
 				output(o, 1, _("CONFLICT (rename/add): Rename %s->%s in %s. "
@@ -1467,20 +1467,20 @@ static int process_renames(struct merge_options *o,
 				       ren1_dst, branch2);
 				if (o->call_depth) {
 					struct merge_file_info mfi;
-					mfi = merge_file_one(o, ren1_dst, null_sha1, 0,
-							 ren1->pair->two->oid.hash,
+					mfi = merge_file_one(o, ren1_dst, &null_oid, 0,
+							 &ren1->pair->two->oid,
 							 ren1->pair->two->mode,
-							 dst_other.oid.hash,
+							 &dst_other.oid,
 							 dst_other.mode,
 							 branch1, branch2);
 					output(o, 1, _("Adding merged %s"), ren1_dst);
-					update_file(o, 0, mfi.oid.hash,
+					update_file(o, 0, &mfi.oid,
 						    mfi.mode, ren1_dst);
 					try_merge = 0;
 				} else {
 					char *new_path = unique_path(o, ren1_dst, branch2);
 					output(o, 1, _("Adding as %s instead"), new_path);
-					update_file(o, 0, dst_other.oid.hash,
+					update_file(o, 0, &dst_other.oid,
 						    dst_other.mode, new_path);
 					free(new_path);
 				}
@@ -1519,30 +1519,30 @@ static int process_renames(struct merge_options *o,
 	return clean_merge;
 }
 
-static unsigned char *stage_sha(const unsigned char *sha, unsigned mode)
+static struct object_id *stage_oid(const struct object_id *oid, unsigned mode)
 {
-	return (is_null_sha1(sha) || mode == 0) ? NULL: (unsigned char *)sha;
+	return (is_null_oid(oid) || mode == 0) ? NULL: (struct object_id *)oid;
 }
 
-static int read_sha1_strbuf(const unsigned char *sha1, struct strbuf *dst)
+static int read_oid_strbuf(const struct object_id *oid, struct strbuf *dst)
 {
 	void *buf;
 	enum object_type type;
 	unsigned long size;
-	buf = read_sha1_file(sha1, &type, &size);
+	buf = read_sha1_file(oid->hash, &type, &size);
 	if (!buf)
-		return error(_("cannot read object %s"), sha1_to_hex(sha1));
+		return error(_("cannot read object %s"), oid_to_hex(oid));
 	if (type != OBJ_BLOB) {
 		free(buf);
-		return error(_("object %s is not a blob"), sha1_to_hex(sha1));
+		return error(_("object %s is not a blob"), oid_to_hex(oid));
 	}
 	strbuf_attach(dst, buf, size, size + 1);
 	return 0;
 }
 
-static int blob_unchanged(const unsigned char *o_sha,
+static int blob_unchanged(const struct object_id *o_oid,
 			  unsigned o_mode,
-			  const unsigned char *a_sha,
+			  const struct object_id *a_oid,
 			  unsigned a_mode,
 			  int renormalize, const char *path)
 {
@@ -1552,13 +1552,13 @@ static int blob_unchanged(const unsigned char *o_sha,
 
 	if (a_mode != o_mode)
 		return 0;
-	if (sha_eq(o_sha, a_sha))
+	if (oid_eq(o_oid, a_oid))
 		return 1;
 	if (!renormalize)
 		return 0;
 
-	assert(o_sha && a_sha);
-	if (read_sha1_strbuf(o_sha, &o) || read_sha1_strbuf(a_sha, &a))
+	assert(o_oid && a_oid);
+	if (read_oid_strbuf(o_oid, &o) || read_oid_strbuf(a_oid, &a))
 		goto error_return;
 	/*
 	 * Note: binary | is used so that both renormalizations are
@@ -1577,23 +1577,23 @@ error_return:
 
 static void handle_modify_delete(struct merge_options *o,
 				 const char *path,
-				 unsigned char *o_sha, int o_mode,
-				 unsigned char *a_sha, int a_mode,
-				 unsigned char *b_sha, int b_mode)
+				 struct object_id *o_oid, int o_mode,
+				 struct object_id *a_oid, int a_mode,
+				 struct object_id *b_oid, int b_mode)
 {
 	handle_change_delete(o,
 			     path,
-			     o_sha, o_mode,
-			     a_sha, a_mode,
-			     b_sha, b_mode,
+			     o_oid, o_mode,
+			     a_oid, a_mode,
+			     b_oid, b_mode,
 			     _("modify"), _("modified"));
 }
 
 static int merge_content(struct merge_options *o,
 			 const char *path,
-			 unsigned char *o_sha, int o_mode,
-			 unsigned char *a_sha, int a_mode,
-			 unsigned char *b_sha, int b_mode,
+			 struct object_id *o_oid, int o_mode,
+			 struct object_id *a_oid, int a_mode,
+			 struct object_id *b_oid, int b_mode,
 			 struct rename_conflict_info *rename_conflict_info)
 {
 	const char *reason = _("content");
@@ -1602,16 +1602,16 @@ static int merge_content(struct merge_options *o,
 	struct diff_filespec one, a, b;
 	unsigned df_conflict_remains = 0;
 
-	if (!o_sha) {
+	if (!o_oid) {
 		reason = _("add/add");
-		o_sha = (unsigned char *)null_sha1;
+		o_oid = (struct object_id *)&null_oid;
 	}
 	one.path = a.path = b.path = (char *)path;
-	hashcpy(one.oid.hash, o_sha);
+	oidcpy(&one.oid, o_oid);
 	one.mode = o_mode;
-	hashcpy(a.oid.hash, a_sha);
+	oidcpy(&a.oid, a_oid);
 	a.mode = a_mode;
-	hashcpy(b.oid.hash, b_sha);
+	oidcpy(&b.oid, b_oid);
 	b.mode = b_mode;
 
 	if (rename_conflict_info) {
@@ -1635,7 +1635,7 @@ static int merge_content(struct merge_options *o,
 					 o->branch2, path2);
 
 	if (mfi.clean && !df_conflict_remains &&
-	    sha_eq(mfi.oid.hash, a_sha) && mfi.mode == a_mode) {
+	    oid_eq(&mfi.oid, a_oid) && mfi.mode == a_mode) {
 		int path_renamed_outside_HEAD;
 		output(o, 3, _("Skipped %s (merged same as existing)"), path);
 		/*
@@ -1646,7 +1646,7 @@ static int merge_content(struct merge_options *o,
 		 */
 		path_renamed_outside_HEAD = !path2 || !strcmp(path, path2);
 		if (!path_renamed_outside_HEAD) {
-			add_cacheinfo(mfi.mode, mfi.oid.hash, path,
+			add_cacheinfo(mfi.mode, &mfi.oid, path,
 				      0, (!o->call_depth), 0);
 			return mfi.clean;
 		}
@@ -1683,11 +1683,11 @@ static int merge_content(struct merge_options *o,
 		}
 		new_path = unique_path(o, path, rename_conflict_info->branch1);
 		output(o, 1, _("Adding as %s instead"), new_path);
-		update_file(o, 0, mfi.oid.hash, mfi.mode, new_path);
+		update_file(o, 0, &mfi.oid, mfi.mode, new_path);
 		free(new_path);
 		mfi.clean = 0;
 	} else {
-		update_file(o, mfi.clean, mfi.oid.hash, mfi.mode, path);
+		update_file(o, mfi.clean, &mfi.oid, mfi.mode, path);
 	}
 	return mfi.clean;
 
@@ -1702,9 +1702,9 @@ static int process_entry(struct merge_options *o,
 	unsigned o_mode = entry->stages[1].mode;
 	unsigned a_mode = entry->stages[2].mode;
 	unsigned b_mode = entry->stages[3].mode;
-	unsigned char *o_sha = stage_sha(entry->stages[1].oid.hash, o_mode);
-	unsigned char *a_sha = stage_sha(entry->stages[2].oid.hash, a_mode);
-	unsigned char *b_sha = stage_sha(entry->stages[3].oid.hash, b_mode);
+	struct object_id *o_oid = stage_oid(&entry->stages[1].oid, o_mode);
+	struct object_id *a_oid = stage_oid(&entry->stages[2].oid, a_mode);
+	struct object_id *b_oid = stage_oid(&entry->stages[3].oid, b_mode);
 
 	entry->processed = 1;
 	if (entry->rename_conflict_info) {
@@ -1713,7 +1713,7 @@ static int process_entry(struct merge_options *o,
 		case RENAME_NORMAL:
 		case RENAME_ONE_FILE_TO_ONE:
 			clean_merge = merge_content(o, path,
-						    o_sha, o_mode, a_sha, a_mode, b_sha, b_mode,
+						    o_oid, o_mode, a_oid, a_mode, b_oid, b_mode,
 						    conflict_info);
 			break;
 		case RENAME_DELETE:
@@ -1734,45 +1734,45 @@ static int process_entry(struct merge_options *o,
 			entry->processed = 0;
 			break;
 		}
-	} else if (o_sha && (!a_sha || !b_sha)) {
+	} else if (o_oid && (!a_oid || !b_oid)) {
 		/* Case A: Deleted in one */
-		if ((!a_sha && !b_sha) ||
-		    (!b_sha && blob_unchanged(o_sha, o_mode, a_sha, a_mode, normalize, path)) ||
-		    (!a_sha && blob_unchanged(o_sha, o_mode, b_sha, b_mode, normalize, path))) {
+		if ((!a_oid && !b_oid) ||
+		    (!b_oid && blob_unchanged(o_oid, o_mode, a_oid, a_mode, normalize, path)) ||
+		    (!a_oid && blob_unchanged(o_oid, o_mode, b_oid, b_mode, normalize, path))) {
 			/* Deleted in both or deleted in one and
 			 * unchanged in the other */
-			if (a_sha)
+			if (a_oid)
 				output(o, 2, _("Removing %s"), path);
 			/* do not touch working file if it did not exist */
-			remove_file(o, 1, path, !a_sha);
+			remove_file(o, 1, path, !a_oid);
 		} else {
 			/* Modify/delete; deleted side may have put a directory in the way */
 			clean_merge = 0;
-			handle_modify_delete(o, path, o_sha, o_mode,
-					     a_sha, a_mode, b_sha, b_mode);
+			handle_modify_delete(o, path, o_oid, o_mode,
+					     a_oid, a_mode, b_oid, b_mode);
 		}
-	} else if ((!o_sha && a_sha && !b_sha) ||
-		   (!o_sha && !a_sha && b_sha)) {
+	} else if ((!o_oid && a_oid && !b_oid) ||
+		   (!o_oid && !a_oid && b_oid)) {
 		/* Case B: Added in one. */
 		/* [nothing|directory] -> ([nothing|directory], file) */
 
 		const char *add_branch;
 		const char *other_branch;
 		unsigned mode;
-		const unsigned char *sha;
+		const struct object_id *oid;
 		const char *conf;
 
-		if (a_sha) {
+		if (a_oid) {
 			add_branch = o->branch1;
 			other_branch = o->branch2;
 			mode = a_mode;
-			sha = a_sha;
+			oid = a_oid;
 			conf = _("file/directory");
 		} else {
 			add_branch = o->branch2;
 			other_branch = o->branch1;
 			mode = b_mode;
-			sha = b_sha;
+			oid = b_oid;
 			conf = _("directory/file");
 		}
 		if (dir_in_way(path, !o->call_depth)) {
@@ -1781,22 +1781,22 @@ static int process_entry(struct merge_options *o,
 			output(o, 1, _("CONFLICT (%s): There is a directory with name %s in %s. "
 			       "Adding %s as %s"),
 			       conf, path, other_branch, path, new_path);
-			update_file(o, 0, sha, mode, new_path);
+			update_file(o, 0, oid, mode, new_path);
 			if (o->call_depth)
 				remove_file_from_cache(path);
 			free(new_path);
 		} else {
 			output(o, 2, _("Adding %s"), path);
 			/* do not overwrite file if already present */
-			update_file_flags(o, sha, mode, path, 1, !a_sha);
+			update_file_flags(o, oid, mode, path, 1, !a_oid);
 		}
-	} else if (a_sha && b_sha) {
+	} else if (a_oid && b_oid) {
 		/* Case C: Added in both (check for same permissions) and */
 		/* case D: Modified in both, but differently. */
 		clean_merge = merge_content(o, path,
-					    o_sha, o_mode, a_sha, a_mode, b_sha, b_mode,
+					    o_oid, o_mode, a_oid, a_mode, b_oid, b_mode,
 					    NULL);
-	} else if (!o_sha && !a_sha && !b_sha) {
+	} else if (!o_oid && !a_oid && !b_oid) {
 		/*
 		 * this entry was deleted altogether. a_mode == 0 means
 		 * we had that path and want to actively remove it.
@@ -1821,7 +1821,7 @@ int merge_trees(struct merge_options *o,
 		common = shift_tree_object(head, common, o->subtree_shift);
 	}
 
-	if (sha_eq(common->object.oid.hash, merge->object.oid.hash)) {
+	if (oid_eq(&common->object.oid, &merge->object.oid)) {
 		output(o, 0, _("Already up-to-date!"));
 		*result = head;
 		return 1;
