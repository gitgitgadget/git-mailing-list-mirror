Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43E27202BB
	for <e@80x24.org>; Sat, 30 Mar 2019 00:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730321AbfC3AeT (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Mar 2019 20:34:19 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:36378 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729771AbfC3AeS (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 29 Mar 2019 20:34:18 -0400
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2U0XVE0015420;
        Fri, 29 Mar 2019 17:34:04 -0700
Received: from mail.palantir.com ([198.97.14.70])
        by mx0a-00153501.pphosted.com with ESMTP id 2rht7wrark-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 29 Mar 2019 17:34:04 -0700
Received: from dc-prod-exch-01.YOJOE.local (10.193.18.14) by
 dc-prod-exch-01.YOJOE.local (10.193.18.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 29 Mar 2019 20:33:57 -0400
Received: from smtp-transport.yojoe.local (10.129.56.124) by
 dc-prod-exch-01.YOJOE.local (10.193.18.14) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Fri, 29 Mar 2019 20:33:57 -0400
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp-transport.yojoe.local (Postfix) with ESMTPS id 5E6FE220CB30;
        Fri, 29 Mar 2019 17:33:56 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     <git@vger.kernel.org>
CC:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Linus Nilsson <Linus.Nilsson@trimma.se>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 11/15] merge-recursive: switch from (oid,mode) pairs to a diff_filespec
Date:   Fri, 29 Mar 2019 17:33:32 -0700
Message-ID: <20190330003336.21940-12-newren@gmail.com>
X-Mailer: git-send-email 2.21.0.211.g078f4bef79.dirty
In-Reply-To: <20190330003336.21940-1-newren@gmail.com>
References: <20190306002744.14418-1-newren@gmail.com>
 <20190330003336.21940-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-29_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903300002
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There was a significant inconsistency in the various parts of the API
used in merge-recursive; many places used a pair of (oid, mode) to track
file version/contents, while other parts used a diff_filespec (which
have an oid and mode embedded in it).  This inconsistency caused lots of
places to need to pack and unpack data to call into other functions.
This has been the subject of some past cleanups (see e.g. commit
0270a07ad0b2 ("merge-recursive: remove final remaining caller of
merge_file_one()", 2018-09-19)), but let's just remove the underlying
mess altogether by switching to use diff_filespec.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 483 +++++++++++++++++++++-------------------------
 1 file changed, 215 insertions(+), 268 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index ada1c19ed2..1d2c9e1772 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -201,10 +201,7 @@ enum rename_type {
  * for these (temporary) data.
  */
 struct stage_data {
-	struct {
-		unsigned short mode;
-		struct object_id oid;
-	} stages[4];
+	struct diff_filespec stages[4]; /* mostly for oid & mode; maybe path */
 	struct rename_conflict_info *rename_conflict_info;
 	unsigned processed:1;
 };
@@ -269,7 +266,6 @@ static inline void setup_rename_conflict_info(enum rename_type rename_type,
 
 	ci->ren1->dst_entry->processed = 0;
 	ci->ren1->dst_entry->rename_conflict_info = ci;
-
 	if (ren2) {
 		ci->ren2->dst_entry->rename_conflict_info = ci;
 	}
@@ -326,14 +322,14 @@ static void output_commit_title(struct merge_options *opt, struct commit *commit
 }
 
 static int add_cacheinfo(struct merge_options *opt,
-			 unsigned int mode, const struct object_id *oid,
+			 const struct diff_filespec *blob,
 			 const char *path, int stage, int refresh, int options)
 {
 	struct index_state *istate = opt->repo->index;
 	struct cache_entry *ce;
 	int ret;
 
-	ce = make_cache_entry(istate, mode, oid ? oid : &null_oid, path, stage, 0);
+	ce = make_cache_entry(istate, blob->mode, &blob->oid, path, stage, 0);
 	if (!ce)
 		return err(opt, _("add_cacheinfo failed for path '%s'; merge aborting."), path);
 
@@ -464,15 +460,14 @@ static void get_files_dirs(struct merge_options *opt, struct tree *tree)
 
 static int get_tree_entry_if_blob(const struct object_id *tree,
 				  const char *path,
-				  struct object_id *hashy,
-				  unsigned short *mode_o)
+				  struct diff_filespec *dfs)
 {
 	int ret;
 
-	ret = get_tree_entry(tree, path, hashy, mode_o);
-	if (S_ISDIR(*mode_o)) {
-		oidcpy(hashy, &null_oid);
-		*mode_o = 0;
+	ret = get_tree_entry(tree, path, &dfs->oid, &dfs->mode);
+	if (S_ISDIR(dfs->mode)) {
+		oidcpy(&dfs->oid, &null_oid);
+		dfs->mode = 0;
 	}
 	return ret;
 }
@@ -487,12 +482,9 @@ static struct stage_data *insert_stage_data(const char *path,
 {
 	struct string_list_item *item;
 	struct stage_data *e = xcalloc(1, sizeof(struct stage_data));
-	get_tree_entry_if_blob(&o->object.oid, path,
-			       &e->stages[1].oid, &e->stages[1].mode);
-	get_tree_entry_if_blob(&a->object.oid, path,
-			       &e->stages[2].oid, &e->stages[2].mode);
-	get_tree_entry_if_blob(&b->object.oid, path,
-			       &e->stages[3].oid, &e->stages[3].mode);
+	get_tree_entry_if_blob(&o->object.oid, path, &e->stages[1]);
+	get_tree_entry_if_blob(&a->object.oid, path, &e->stages[2]);
+	get_tree_entry_if_blob(&b->object.oid, path, &e->stages[3]);
 	item = string_list_insert(entries, path);
 	item->util = e;
 	return e;
@@ -648,13 +640,13 @@ static int update_stages(struct merge_options *opt, const char *path,
 		if (remove_file_from_index(opt->repo->index, path))
 			return -1;
 	if (o)
-		if (add_cacheinfo(opt, o->mode, &o->oid, path, 1, 0, options))
+		if (add_cacheinfo(opt, o, path, 1, 0, options))
 			return -1;
 	if (a)
-		if (add_cacheinfo(opt, a->mode, &a->oid, path, 2, 0, options))
+		if (add_cacheinfo(opt, a, path, 2, 0, options))
 			return -1;
 	if (b)
-		if (add_cacheinfo(opt, b->mode, &b->oid, path, 3, 0, options))
+		if (add_cacheinfo(opt, b, path, 3, 0, options))
 			return -1;
 	return 0;
 }
@@ -767,7 +759,7 @@ static int dir_in_way(struct index_state *istate, const char *path,
  * and its oid and mode match the specified values
  */
 static int was_tracked_and_matches(struct merge_options *opt, const char *path,
-				   const struct object_id *oid, unsigned mode)
+				   const struct diff_filespec *blob)
 {
 	int pos = index_name_pos(&opt->orig_index, path, strlen(path));
 	struct cache_entry *ce;
@@ -778,7 +770,7 @@ static int was_tracked_and_matches(struct merge_options *opt, const char *path,
 
 	/* See if the file we were tracking before matches */
 	ce = opt->orig_index.cache[pos];
-	return (oid_eq(&ce->oid, oid) && ce->ce_mode == mode);
+	return (oid_eq(&ce->oid, &blob->oid) && ce->ce_mode == blob->mode);
 }
 
 /*
@@ -903,8 +895,7 @@ static int make_room_for_path(struct merge_options *opt, const char *path)
 }
 
 static int update_file_flags(struct merge_options *opt,
-			     const struct object_id *oid,
-			     unsigned mode,
+			     const struct diff_filespec *contents,
 			     const char *path,
 			     int update_cache,
 			     int update_wd)
@@ -919,7 +910,7 @@ static int update_file_flags(struct merge_options *opt,
 		void *buf;
 		unsigned long size;
 
-		if (S_ISGITLINK(mode)) {
+		if (S_ISGITLINK(contents->mode)) {
 			/*
 			 * We may later decide to recursively descend into
 			 * the submodule directory and update its index
@@ -929,14 +920,16 @@ static int update_file_flags(struct merge_options *opt,
 			goto update_index;
 		}
 
-		buf = read_object_file(oid, &type, &size);
+		buf = read_object_file(&contents->oid, &type, &size);
 		if (!buf)
-			return err(opt, _("cannot read object %s '%s'"), oid_to_hex(oid), path);
+			return err(opt, _("cannot read object %s '%s'"),
+				   oid_to_hex(&contents->oid), path);
 		if (type != OBJ_BLOB) {
-			ret = err(opt, _("blob expected for %s '%s'"), oid_to_hex(oid), path);
+			ret = err(opt, _("blob expected for %s '%s'"),
+				  oid_to_hex(&contents->oid), path);
 			goto free_buf;
 		}
-		if (S_ISREG(mode)) {
+		if (S_ISREG(contents->mode)) {
 			struct strbuf strbuf = STRBUF_INIT;
 			if (convert_to_working_tree(opt->repo->index, path, buf, size, &strbuf)) {
 				free(buf);
@@ -949,12 +942,11 @@ static int update_file_flags(struct merge_options *opt,
 			update_wd = 0;
 			goto free_buf;
 		}
-		if (S_ISREG(mode) || (!has_symlinks && S_ISLNK(mode))) {
+		if (S_ISREG(contents->mode) ||
+		    (!has_symlinks && S_ISLNK(contents->mode))) {
 			int fd;
-			if (mode & 0100)
-				mode = 0777;
-			else
-				mode = 0666;
+			int mode = (contents->mode & 0100 ? 0777 : 0666);
+
 			fd = open(path, O_WRONLY | O_TRUNC | O_CREAT, mode);
 			if (fd < 0) {
 				ret = err(opt, _("failed to open '%s': %s"),
@@ -963,7 +955,7 @@ static int update_file_flags(struct merge_options *opt,
 			}
 			write_in_full(fd, buf, size);
 			close(fd);
-		} else if (S_ISLNK(mode)) {
+		} else if (S_ISLNK(contents->mode)) {
 			char *lnk = xmemdupz(buf, size);
 			safe_create_leading_directories_const(path);
 			unlink(path);
@@ -974,13 +966,13 @@ static int update_file_flags(struct merge_options *opt,
 		} else
 			ret = err(opt,
 				  _("do not know what to do with %06o %s '%s'"),
-				  mode, oid_to_hex(oid), path);
+				  contents->mode, oid_to_hex(&contents->oid), path);
 	free_buf:
 		free(buf);
 	}
 update_index:
 	if (!ret && update_cache)
-		if (add_cacheinfo(opt, mode, oid, path, 0, update_wd,
+		if (add_cacheinfo(opt, contents, path, 0, update_wd,
 				  ADD_CACHE_OK_TO_ADD))
 			return -1;
 	return ret;
@@ -988,18 +980,17 @@ static int update_file_flags(struct merge_options *opt,
 
 static int update_file(struct merge_options *opt,
 		       int clean,
-		       const struct object_id *oid,
-		       unsigned mode,
+		       const struct diff_filespec *contents,
 		       const char *path)
 {
-	return update_file_flags(opt, oid, mode, path, opt->call_depth || clean, !opt->call_depth);
+	return update_file_flags(opt, contents, path,
+				 opt->call_depth || clean, !opt->call_depth);
 }
 
 /* Low level file merging, update and removal */
 
 struct merge_file_info {
-	struct object_id oid;
-	unsigned mode;
+	struct diff_filespec blob; /* mostly use oid & mode; sometimes path */
 	unsigned clean:1,
 		 merge:1;
 };
@@ -1039,6 +1030,7 @@ static int merge_3way(struct merge_options *opt,
 		}
 	}
 
+	assert(a->path && b->path);
 	if (strcmp(a->path, b->path) ||
 	    (opt->ancestor != NULL && strcmp(a->path, o->path) != 0)) {
 		base_name = opt->ancestor == NULL ? NULL :
@@ -1140,6 +1132,11 @@ static void print_commit(struct commit *commit)
 	strbuf_release(&sb);
 }
 
+static int is_valid(const struct diff_filespec *dfs)
+{
+	return dfs->mode != 0 && !is_null_oid(&dfs->oid);
+}
+
 static int merge_submodule(struct merge_options *opt,
 			   struct object_id *result, const char *path,
 			   const struct object_id *base, const struct object_id *a,
@@ -1278,11 +1275,11 @@ static int merge_mode_and_contents(struct merge_options *opt,
 	if ((S_IFMT & a->mode) != (S_IFMT & b->mode)) {
 		result->clean = 0;
 		if (S_ISREG(a->mode)) {
-			result->mode = a->mode;
-			oidcpy(&result->oid, &a->oid);
+			result->blob.mode = a->mode;
+			oidcpy(&result->blob.oid, &a->oid);
 		} else {
-			result->mode = b->mode;
-			oidcpy(&result->oid, &b->oid);
+			result->blob.mode = b->mode;
+			oidcpy(&result->blob.oid, &b->oid);
 		}
 	} else {
 		if (!oid_eq(&a->oid, &o->oid) && !oid_eq(&b->oid, &o->oid))
@@ -1292,9 +1289,9 @@ static int merge_mode_and_contents(struct merge_options *opt,
 		 * Merge modes
 		 */
 		if (a->mode == b->mode || a->mode == o->mode)
-			result->mode = b->mode;
+			result->blob.mode = b->mode;
 		else {
-			result->mode = a->mode;
+			result->blob.mode = a->mode;
 			if (b->mode != o->mode) {
 				result->clean = 0;
 				result->merge = 1;
@@ -1302,9 +1299,9 @@ static int merge_mode_and_contents(struct merge_options *opt,
 		}
 
 		if (oid_eq(&a->oid, &b->oid) || oid_eq(&a->oid, &o->oid))
-			oidcpy(&result->oid, &b->oid);
+			oidcpy(&result->blob.oid, &b->oid);
 		else if (oid_eq(&b->oid, &o->oid))
-			oidcpy(&result->oid, &a->oid);
+			oidcpy(&result->blob.oid, &a->oid);
 		else if (S_ISREG(a->mode)) {
 			mmbuffer_t result_buf;
 			int ret = 0, merge_status;
@@ -1318,7 +1315,7 @@ static int merge_mode_and_contents(struct merge_options *opt,
 
 			if (!ret &&
 			    write_object_file(result_buf.ptr, result_buf.size,
-					      blob_type, &result->oid))
+					      blob_type, &result->blob.oid))
 				ret = err(opt, _("Unable to add %s to database"),
 					  a->path);
 
@@ -1327,7 +1324,7 @@ static int merge_mode_and_contents(struct merge_options *opt,
 				return ret;
 			result->clean = (merge_status == 0);
 		} else if (S_ISGITLINK(a->mode)) {
-			result->clean = merge_submodule(opt, &result->oid,
+			result->clean = merge_submodule(opt, &result->blob.oid,
 							o->path,
 							&o->oid,
 							&a->oid,
@@ -1335,15 +1332,15 @@ static int merge_mode_and_contents(struct merge_options *opt,
 		} else if (S_ISLNK(a->mode)) {
 			switch (opt->recursive_variant) {
 			case MERGE_RECURSIVE_NORMAL:
-				oidcpy(&result->oid, &a->oid);
+				oidcpy(&result->blob.oid, &a->oid);
 				if (!oid_eq(&a->oid, &b->oid))
 					result->clean = 0;
 				break;
 			case MERGE_RECURSIVE_OURS:
-				oidcpy(&result->oid, &a->oid);
+				oidcpy(&result->blob.oid, &a->oid);
 				break;
 			case MERGE_RECURSIVE_THEIRS:
-				oidcpy(&result->oid, &b->oid);
+				oidcpy(&result->blob.oid, &b->oid);
 				break;
 			}
 		} else
@@ -1379,7 +1376,7 @@ static int handle_rename_via_dir(struct merge_options *opt,
 		 * index.  Instead, write to dest->path for the index but
 		 * only at the higher appropriate stage.
 		 */
-		if (update_file(opt, 0, &dest->oid, dest->mode, alt_path))
+		if (update_file(opt, 0, dest, alt_path))
 			return -1;
 		free(alt_path);
 		return update_stages(opt, dest->path, NULL,
@@ -1388,16 +1385,15 @@ static int handle_rename_via_dir(struct merge_options *opt,
 	}
 
 	/* Update dest->path both in index and in worktree */
-	if (update_file(opt, 1, &dest->oid, dest->mode, dest->path))
+	if (update_file(opt, 1, dest, dest->path))
 		return -1;
 	return 0;
 }
 
 static int handle_change_delete(struct merge_options *opt,
 				const char *path, const char *old_path,
-				const struct object_id *o_oid, int o_mode,
-				const struct object_id *changed_oid,
-				int changed_mode,
+				const struct diff_filespec *o,
+				const struct diff_filespec *changed,
 				const char *change_branch,
 				const char *delete_branch,
 				const char *change, const char *change_past)
@@ -1419,7 +1415,7 @@ static int handle_change_delete(struct merge_options *opt,
 		 */
 		ret = remove_file_from_index(opt->repo->index, path);
 		if (!ret)
-			ret = update_file(opt, 0, o_oid, o_mode, update_path);
+			ret = update_file(opt, 0, o, update_path);
 	} else {
 		/*
 		 * Despite the four nearly duplicate messages and argument
@@ -1468,7 +1464,7 @@ static int handle_change_delete(struct merge_options *opt,
 		 * and update_wd=0, but that's a no-op.
 		 */
 		if (change_branch != opt->branch1 || alt_path)
-			ret = update_file(opt, 0, changed_oid, changed_mode, update_path);
+			ret = update_file(opt, 0, changed, update_path);
 	}
 	free(alt_path);
 
@@ -1488,8 +1484,7 @@ static int handle_rename_delete(struct merge_options *opt,
 	if (handle_change_delete(opt,
 				 opt->call_depth ? orig->path : dest->path,
 				 opt->call_depth ? NULL : orig->path,
-				 &orig->oid, orig->mode,
-				 &dest->oid, dest->mode,
+				 orig, dest,
 				 rename_branch, delete_branch,
 				 _("rename"), _("renamed")))
 		return -1;
@@ -1502,31 +1497,16 @@ static int handle_rename_delete(struct merge_options *opt,
 				     rename_branch == opt->branch1 ? NULL : dest);
 }
 
-static struct diff_filespec *filespec_from_entry(struct diff_filespec *target,
-						 struct stage_data *entry,
-						 int stage)
-{
-	struct object_id *oid = &entry->stages[stage].oid;
-	unsigned mode = entry->stages[stage].mode;
-	if (mode == 0 || is_null_oid(oid))
-		return NULL;
-	oidcpy(&target->oid, oid);
-	target->mode = mode;
-	return target;
-}
-
 static int handle_file_collision(struct merge_options *opt,
 				 const char *collide_path,
 				 const char *prev_path1,
 				 const char *prev_path2,
 				 const char *branch1, const char *branch2,
-				 const struct object_id *a_oid,
-				 unsigned int a_mode,
-				 const struct object_id *b_oid,
-				 unsigned int b_mode)
+				 struct diff_filespec *a,
+				 struct diff_filespec *b)
 {
 	struct merge_file_info mfi;
-	struct diff_filespec null, a, b;
+	struct diff_filespec null;
 	char *alt_path = NULL;
 	const char *update_path = collide_path;
 
@@ -1540,29 +1520,28 @@ static int handle_file_collision(struct merge_options *opt,
 		return handle_file_collision(opt, collide_path,
 					     prev_path2, prev_path1,
 					     branch2, branch1,
-					     b_oid, b_mode,
-					     a_oid, a_mode);
+					     b, a);
 	}
 
 	/*
 	 * In the recursive case, we just opt to undo renames
 	 */
 	if (opt->call_depth && (prev_path1 || prev_path2)) {
-		/* Put first file (a_oid, a_mode) in its original spot */
+		/* Put first file (a->oid, a->mode) in its original spot */
 		if (prev_path1) {
-			if (update_file(opt, 1, a_oid, a_mode, prev_path1))
+			if (update_file(opt, 1, a, prev_path1))
 				return -1;
 		} else {
-			if (update_file(opt, 1, a_oid, a_mode, collide_path))
+			if (update_file(opt, 1, a, collide_path))
 				return -1;
 		}
 
-		/* Put second file (b_oid, b_mode) in its original spot */
+		/* Put second file (b->oid, b->mode) in its original spot */
 		if (prev_path2) {
-			if (update_file(opt, 1, b_oid, b_mode, prev_path2))
+			if (update_file(opt, 1, b, prev_path2))
 				return -1;
 		} else {
-			if (update_file(opt, 1, b_oid, b_mode, collide_path))
+			if (update_file(opt, 1, b, collide_path))
 				return -1;
 		}
 
@@ -1616,26 +1595,18 @@ static int handle_file_collision(struct merge_options *opt,
 	}
 
 	/* Store things in diff_filespecs for functions that need it */
-	memset(&a, 0, sizeof(struct diff_filespec));
-	memset(&b, 0, sizeof(struct diff_filespec));
-	null.path = a.path = b.path = (char *)collide_path;
+	null.path = (char *)collide_path;
 	oidcpy(&null.oid, &null_oid);
 	null.mode = 0;
-	oidcpy(&a.oid, a_oid);
-	a.mode = a_mode;
-	a.oid_valid = 1;
-	oidcpy(&b.oid, b_oid);
-	b.mode = b_mode;
-	b.oid_valid = 1;
-
-	if (merge_mode_and_contents(opt, &null, &a, &b, collide_path,
+
+	if (merge_mode_and_contents(opt, &null, a, b, collide_path,
 				    branch1, branch2, opt->call_depth * 2, &mfi))
 		return -1;
 	mfi.clean &= !alt_path;
-	if (update_file(opt, mfi.clean, &mfi.oid, mfi.mode, update_path))
+	if (update_file(opt, mfi.clean, &mfi.blob, update_path))
 		return -1;
 	if (!mfi.clean && !opt->call_depth &&
-	    update_stages(opt, collide_path, NULL, &a, &b))
+	    update_stages(opt, collide_path, NULL, a, b))
 		return -1;
 	free(alt_path);
 	/*
@@ -1654,7 +1625,6 @@ static int handle_rename_add(struct merge_options *opt,
 	/* a was renamed to c, and a separate c was added. */
 	struct diff_filespec *a = ci->ren1->pair->one;
 	struct diff_filespec *c = ci->ren1->pair->two;
-	struct diff_filespec tmp;
 	char *path = c->path;
 	char *prev_path_desc;
 	struct merge_file_info mfi;
@@ -1669,23 +1639,21 @@ static int handle_rename_add(struct merge_options *opt,
 	       a->path, c->path, rename_branch,
 	       c->path, add_branch);
 
-	filespec_from_entry(&tmp, ci->ren1->src_entry, other_stage);
-	tmp.path = a->path;
-
 	prev_path_desc = xstrfmt("version of %s from %s", path, a->path);
-	if (merge_mode_and_contents(opt, a, c, &tmp,
+	if (merge_mode_and_contents(opt, a, c,
+				    &ci->ren1->src_entry->stages[other_stage],
 				    prev_path_desc,
 				    opt->branch1, opt->branch2,
 				    1 + opt->call_depth * 2, &mfi))
 		return -1;
 	free(prev_path_desc);
 
+	ci->ren1->dst_entry->stages[other_stage].path = mfi.blob.path = c->path;
 	return handle_file_collision(opt,
 				     c->path, a->path, NULL,
 				     rename_branch, add_branch,
-				     &mfi.oid, mfi.mode,
-				     &ci->ren1->dst_entry->stages[other_stage].oid,
-				     ci->ren1->dst_entry->stages[other_stage].mode);
+				     &mfi.blob,
+				     &ci->ren1->dst_entry->stages[other_stage]);
 }
 
 static char *find_path_for_conflict(struct merge_options *opt,
@@ -1714,7 +1682,6 @@ static int handle_rename_rename_1to2(struct merge_options *opt,
 {
 	/* One file was renamed in both branches, but to different names. */
 	struct merge_file_info mfi;
-	struct diff_filespec other;
 	struct diff_filespec *add;
 	struct diff_filespec *o = ci->ren1->pair->one;
 	struct diff_filespec *a = ci->ren1->pair->two;
@@ -1743,7 +1710,7 @@ static int handle_rename_rename_1to2(struct merge_options *opt,
 		 * pathname and then either rename the add-source file to that
 		 * unique path, or use that unique path instead of src here.
 		 */
-		if (update_file(opt, 0, &mfi.oid, mfi.mode, o->path))
+		if (update_file(opt, 0, &mfi.blob, o->path))
 			return -1;
 
 		/*
@@ -1754,16 +1721,16 @@ static int handle_rename_rename_1to2(struct merge_options *opt,
 		 * such cases, we should keep the added file around,
 		 * resolving the conflict at that path in its favor.
 		 */
-		add = filespec_from_entry(&other, ci->ren1->dst_entry, 2 ^ 1);
-		if (add) {
-			if (update_file(opt, 0, &add->oid, add->mode, a->path))
+		add = &ci->ren1->dst_entry->stages[2 ^ 1];
+		if (is_valid(add)) {
+			if (update_file(opt, 0, add, a->path))
 				return -1;
 		}
 		else
 			remove_file_from_index(opt->repo->index, a->path);
-		add = filespec_from_entry(&other, ci->ren2->dst_entry, 3 ^ 1);
-		if (add) {
-			if (update_file(opt, 0, &add->oid, add->mode, b->path))
+		add = &ci->ren2->dst_entry->stages[3 ^ 1];
+		if (is_valid(add)) {
+			if (update_file(opt, 0, add, b->path))
 				return -1;
 		}
 		else
@@ -1774,40 +1741,42 @@ static int handle_rename_rename_1to2(struct merge_options *opt,
 		 * rename/add collision.  If not, we can write the file out
 		 * to the specified location.
 		 */
-		add = filespec_from_entry(&other, ci->ren1->dst_entry, 2 ^ 1);
-		if (add) {
+		add = &ci->ren1->dst_entry->stages[2 ^ 1];
+		if (is_valid(add)) {
+			add->path = mfi.blob.path = a->path;
 			if (handle_file_collision(opt, a->path,
 						  NULL, NULL,
 						  ci->ren1->branch,
 						  ci->ren2->branch,
-						  &mfi.oid, mfi.mode,
-						  &add->oid, add->mode) < 0)
+						  &mfi.blob, add) < 0)
 				return -1;
 		} else {
 			char *new_path = find_path_for_conflict(opt, a->path,
 								ci->ren1->branch,
 								ci->ren2->branch);
-			if (update_file(opt, 0, &mfi.oid, mfi.mode, new_path ? new_path : a->path))
+			if (update_file(opt, 0, &mfi.blob,
+					new_path ? new_path : a->path))
 				return -1;
 			free(new_path);
 			if (update_stages(opt, a->path, NULL, a, NULL))
 				return -1;
 		}
 
-		add = filespec_from_entry(&other, ci->ren2->dst_entry, 3 ^ 1);
-		if (add) {
+		add = &ci->ren2->dst_entry->stages[3 ^ 1];
+		if (is_valid(add)) {
+			add->path = mfi.blob.path = b->path;
 			if (handle_file_collision(opt, b->path,
 						  NULL, NULL,
 						  ci->ren1->branch,
 						  ci->ren2->branch,
-						  &add->oid, add->mode,
-						  &mfi.oid, mfi.mode) < 0)
+						  add, &mfi.blob) < 0)
 				return -1;
 		} else {
 			char *new_path = find_path_for_conflict(opt, b->path,
 								ci->ren2->branch,
 								ci->ren1->branch);
-			if (update_file(opt, 0, &mfi.oid, mfi.mode, new_path ? new_path : b->path))
+			if (update_file(opt, 0, &mfi.blob,
+					new_path ? new_path : b->path))
 				return -1;
 			free(new_path);
 			if (update_stages(opt, b->path, NULL, NULL, b))
@@ -1826,12 +1795,12 @@ static int handle_rename_rename_2to1(struct merge_options *opt,
 	struct diff_filespec *b = ci->ren2->pair->one;
 	struct diff_filespec *c1 = ci->ren1->pair->two;
 	struct diff_filespec *c2 = ci->ren2->pair->two;
-	struct diff_filespec tmp1, tmp2;
 	char *path = c1->path; /* == c2->path */
 	char *path_side_1_desc;
 	char *path_side_2_desc;
 	struct merge_file_info mfi_c1;
 	struct merge_file_info mfi_c2;
+	int ostage1, ostage2;
 
 	output(opt, 1, _("CONFLICT (rename/rename): "
 	       "Rename %s->%s in %s. "
@@ -1839,27 +1808,31 @@ static int handle_rename_rename_2to1(struct merge_options *opt,
 	       a->path, c1->path, ci->ren1->branch,
 	       b->path, c2->path, ci->ren2->branch);
 
-	filespec_from_entry(&tmp1, ci->ren1->src_entry, 3);
-	tmp1.path = a->path;
-	filespec_from_entry(&tmp2, ci->ren2->src_entry, 2);
-	tmp2.path = b->path;
-
 	path_side_1_desc = xstrfmt("version of %s from %s", path, a->path);
 	path_side_2_desc = xstrfmt("version of %s from %s", path, b->path);
-	if (merge_mode_and_contents(opt, a, c1, &tmp1, path_side_1_desc,
+	ostage1 = ci->ren1->branch == opt->branch1 ? 3 : 2;
+	ostage2 = ostage1 ^ 1;
+	ci->ren1->src_entry->stages[ostage1].path = a->path;
+	ci->ren2->src_entry->stages[ostage2].path = b->path;
+	if (merge_mode_and_contents(opt, a, c1,
+				    &ci->ren1->src_entry->stages[ostage1],
+				    path_side_1_desc,
 				    opt->branch1, opt->branch2,
 				    1 + opt->call_depth * 2, &mfi_c1) ||
-	    merge_mode_and_contents(opt, b, &tmp2, c2, path_side_2_desc,
+	    merge_mode_and_contents(opt, b,
+				    &ci->ren2->src_entry->stages[ostage2],
+				    c2, path_side_2_desc,
 				    opt->branch1, opt->branch2,
 				    1 + opt->call_depth * 2, &mfi_c2))
 		return -1;
 	free(path_side_1_desc);
 	free(path_side_2_desc);
+	mfi_c1.blob.path = path;
+	mfi_c2.blob.path = path;
 
 	return handle_file_collision(opt, path, a->path, b->path,
 				     ci->ren1->branch, ci->ren2->branch,
-				     &mfi_c1.oid, mfi_c1.mode,
-				     &mfi_c2.oid, mfi_c2.mode);
+				     &mfi_c1.blob, &mfi_c2.blob);
 }
 
 /*
@@ -2722,7 +2695,6 @@ static int process_renames(struct merge_options *opt,
 
 			setup_rename_conflict_info(RENAME_TWO_FILES_TO_ONE,
 						   opt, ren1, ren2);
-
 		} else {
 			/* Renamed in 1, maybe changed in 2 */
 			/* we only use sha1 and mode of these */
@@ -2771,8 +2743,7 @@ static int process_renames(struct merge_options *opt,
 				 * update_file().
 				 */
 				if (update_file_flags(opt,
-						      &ren1->pair->two->oid,
-						      ren1->pair->two->mode,
+						      ren1->pair->two,
 						      ren1_dst,
 						      1, /* update_cache */
 						      0  /* update_wd    */))
@@ -2923,11 +2894,6 @@ static void final_cleanup_renames(struct rename_info *re_info)
 	final_cleanup_rename(re_info->merge_renames);
 }
 
-static struct object_id *stage_oid(const struct object_id *oid, unsigned mode)
-{
-	return (is_null_oid(oid) || mode == 0) ? NULL: (struct object_id *)oid;
-}
-
 static int read_oid_strbuf(struct merge_options *opt,
 			   const struct object_id *oid,
 			   struct strbuf *dst)
@@ -2947,10 +2913,8 @@ static int read_oid_strbuf(struct merge_options *opt,
 }
 
 static int blob_unchanged(struct merge_options *opt,
-			  const struct object_id *o_oid,
-			  unsigned o_mode,
-			  const struct object_id *a_oid,
-			  unsigned a_mode,
+			  const struct diff_filespec *o,
+			  const struct diff_filespec *a,
 			  int renormalize, const char *path)
 {
 	struct strbuf obuf = STRBUF_INIT;
@@ -2958,16 +2922,15 @@ static int blob_unchanged(struct merge_options *opt,
 	int ret = 0; /* assume changed for safety */
 	const struct index_state *idx = opt->repo->index;
 
-	if (a_mode != o_mode)
+	if (a->mode != o->mode)
 		return 0;
-	if (oid_eq(o_oid, a_oid))
+	if (oid_eq(&o->oid, &a->oid))
 		return 1;
 	if (!renormalize)
 		return 0;
 
-	assert(o_oid && a_oid);
-	if (read_oid_strbuf(opt, o_oid, &obuf) ||
-	    read_oid_strbuf(opt, a_oid, &abuf))
+	if (read_oid_strbuf(opt, &o->oid, &obuf) ||
+	    read_oid_strbuf(opt, &a->oid, &abuf))
 		goto error_return;
 	/*
 	 * Note: binary | is used so that both renormalizations are
@@ -2986,30 +2949,26 @@ static int blob_unchanged(struct merge_options *opt,
 
 static int handle_modify_delete(struct merge_options *opt,
 				const char *path,
-				struct object_id *o_oid, int o_mode,
-				struct object_id *a_oid, int a_mode,
-				struct object_id *b_oid, int b_mode)
+				const struct diff_filespec *o,
+				const struct diff_filespec *a,
+				const struct diff_filespec *b)
 {
 	const char *modify_branch, *delete_branch;
-	struct object_id *changed_oid;
-	int changed_mode;
+	const struct diff_filespec *changed;
 
-	if (a_oid) {
+	if (is_valid(a)) {
 		modify_branch = opt->branch1;
 		delete_branch = opt->branch2;
-		changed_oid = a_oid;
-		changed_mode = a_mode;
+		changed = a;
 	} else {
 		modify_branch = opt->branch2;
 		delete_branch = opt->branch1;
-		changed_oid = b_oid;
-		changed_mode = b_mode;
+		changed = b;
 	}
 
 	return handle_change_delete(opt,
 				    path, NULL,
-				    o_oid, o_mode,
-				    changed_oid, changed_mode,
+				    o, changed,
 				    modify_branch, delete_branch,
 				    _("modify"), _("modified"));
 }
@@ -3017,50 +2976,24 @@ static int handle_modify_delete(struct merge_options *opt,
 static int handle_content_merge(struct merge_options *opt,
 				const char *path,
 				int is_dirty,
-				struct object_id *o_oid, int o_mode,
-				struct object_id *a_oid, int a_mode,
-				struct object_id *b_oid, int b_mode,
+				const struct diff_filespec *o,
+				const struct diff_filespec *a,
+				const struct diff_filespec *b,
 				struct rename_conflict_info *ci)
 {
 	const char *reason = _("content");
-	const char *path1 = NULL, *path2 = NULL;
 	struct merge_file_info mfi;
-	struct diff_filespec one, a, b;
 	unsigned df_conflict_remains = 0;
 
-	if (!o_oid) {
+	if (!is_valid(o))
 		reason = _("add/add");
-		o_oid = (struct object_id *)&null_oid;
-	}
-	one.path = a.path = b.path = (char *)path;
-	oidcpy(&one.oid, o_oid);
-	one.mode = o_mode;
-	oidcpy(&a.oid, a_oid);
-	a.mode = a_mode;
-	oidcpy(&b.oid, b_oid);
-	b.mode = b_mode;
-
-	if (ci) {
-		struct diff_filepair *pair1 = ci->ren1->pair;
-
-		path1 = (opt->branch1 == ci->ren1->branch) ?
-			pair1->two->path : pair1->one->path;
-		/* If ci->ren2->pair != NULL, we are in
-		 * RENAME_ONE_FILE_TO_ONE case.  Otherwise, we have a
-		 * normal rename.
-		 */
-		path2 = ((ci->ren2 && ci->ren2->pair) ||
-			 opt->branch2 == ci->ren1->branch) ?
-			pair1->two->path : pair1->one->path;
-		one.path = pair1->one->path;
-		a.path = (char *)path1;
-		b.path = (char *)path2;
-
-		if (dir_in_way(opt->repo->index, path, !opt->call_depth,
-			       S_ISGITLINK(pair1->two->mode)))
-			df_conflict_remains = 1;
-	}
-	if (merge_mode_and_contents(opt, &one, &a, &b, path,
+
+	assert(o->path && a->path && b->path);
+	if (ci && dir_in_way(opt->repo->index, path, !opt->call_depth,
+			     S_ISGITLINK(ci->ren1->pair->two->mode)))
+		df_conflict_remains = 1;
+
+	if (merge_mode_and_contents(opt, o, a, b, path,
 				    opt->branch1, opt->branch2,
 				    opt->call_depth * 2, &mfi))
 		return -1;
@@ -3071,14 +3004,13 @@ static int handle_content_merge(struct merge_options *opt,
 	 *   b) The merge matches what was in HEAD (content, mode, pathname)
 	 *   c) The target path is usable (i.e. not involved in D/F conflict)
 	 */
-	if (mfi.clean &&
-	    was_tracked_and_matches(opt, path, &mfi.oid, mfi.mode) &&
+	if (mfi.clean && was_tracked_and_matches(opt, path, &mfi.blob) &&
 	    !df_conflict_remains) {
 		int pos;
 		struct cache_entry *ce;
 
 		output(opt, 3, _("Skipped %s (merged same as existing)"), path);
-		if (add_cacheinfo(opt, mfi.mode, &mfi.oid, path,
+		if (add_cacheinfo(opt, &mfi.blob, path,
 				  0, (!opt->call_depth && !is_dirty), 0))
 			return -1;
 		/*
@@ -3098,12 +3030,12 @@ static int handle_content_merge(struct merge_options *opt,
 	}
 
 	if (!mfi.clean) {
-		if (S_ISGITLINK(mfi.mode))
+		if (S_ISGITLINK(mfi.blob.mode))
 			reason = _("submodule");
 		output(opt, 1, _("CONFLICT (%s): Merge conflict in %s"),
 				reason, path);
 		if (ci && !df_conflict_remains)
-			if (update_stages(opt, path, &one, &a, &b))
+			if (update_stages(opt, path, o, a, b))
 				return -1;
 	}
 
@@ -3113,17 +3045,14 @@ static int handle_content_merge(struct merge_options *opt,
 			remove_file_from_index(opt->repo->index, path);
 		} else {
 			if (!mfi.clean) {
-				if (update_stages(opt, path, &one, &a, &b))
+				if (update_stages(opt, path, o, a, b))
 					return -1;
 			} else {
 				int file_from_stage2 = was_tracked(opt, path);
-				struct diff_filespec merged;
-				oidcpy(&merged.oid, &mfi.oid);
-				merged.mode = mfi.mode;
 
 				if (update_stages(opt, path, NULL,
-						  file_from_stage2 ? &merged : NULL,
-						  file_from_stage2 ? NULL : &merged))
+						  file_from_stage2 ? &mfi.blob : NULL,
+						  file_from_stage2 ? NULL : &mfi.blob))
 					return -1;
 			}
 
@@ -3134,28 +3063,27 @@ static int handle_content_merge(struct merge_options *opt,
 			       path);
 		}
 		output(opt, 1, _("Adding as %s instead"), new_path);
-		if (update_file(opt, 0, &mfi.oid, mfi.mode, new_path)) {
+		if (update_file(opt, 0, &mfi.blob, new_path)) {
 			free(new_path);
 			return -1;
 		}
 		free(new_path);
 		mfi.clean = 0;
-	} else if (update_file(opt, mfi.clean, &mfi.oid, mfi.mode, path))
+	} else if (update_file(opt, mfi.clean, &mfi.blob, path))
 		return -1;
 	return !is_dirty && mfi.clean;
 }
 
 static int handle_rename_normal(struct merge_options *opt,
 				const char *path,
-				struct object_id *o_oid, unsigned int o_mode,
-				struct object_id *a_oid, unsigned int a_mode,
-				struct object_id *b_oid, unsigned int b_mode,
+				const struct diff_filespec *o,
+				const struct diff_filespec *a,
+				const struct diff_filespec *b,
 				struct rename_conflict_info *ci)
 {
 	/* Merge the content and write it out */
 	return handle_content_merge(opt, path, was_dirty(opt, path),
-				    o_oid, o_mode, a_oid, a_mode, b_oid, b_mode,
-				    ci);
+				    o, a, b, ci);
 }
 
 /* Per entry merge function */
@@ -3164,24 +3092,36 @@ static int process_entry(struct merge_options *opt,
 {
 	int clean_merge = 1;
 	int normalize = opt->renormalize;
-	unsigned o_mode = entry->stages[1].mode;
-	unsigned a_mode = entry->stages[2].mode;
-	unsigned b_mode = entry->stages[3].mode;
-	struct object_id *o_oid = stage_oid(&entry->stages[1].oid, o_mode);
-	struct object_id *a_oid = stage_oid(&entry->stages[2].oid, a_mode);
-	struct object_id *b_oid = stage_oid(&entry->stages[3].oid, b_mode);
+
+	struct diff_filespec *o = &entry->stages[1];
+	struct diff_filespec *a = &entry->stages[2];
+	struct diff_filespec *b = &entry->stages[3];
+	int o_valid = is_valid(o);
+	int a_valid = is_valid(a);
+	int b_valid = is_valid(b);
+	o->path = a->path = b->path = (char*)path;
 
 	entry->processed = 1;
 	if (entry->rename_conflict_info) {
 		struct rename_conflict_info *ci = entry->rename_conflict_info;
+		struct diff_filespec *temp;
+
+		/*
+		 * For cases with a single rename, {o,a,b}->path have all been
+		 * set to the rename target path; we need to set two of these
+		 * back to the rename source.
+		 * For rename/rename conflicts, we'll manually fix paths below.
+		 */
+		temp = (opt->branch1 == ci->ren1->branch) ? b : a;
+		o->path = temp->path = ci->ren1->pair->one->path;
+		if (ci->ren2) {
+			assert(opt->branch1 == ci->ren1->branch);
+		}
+
 		switch (ci->rename_type) {
 		case RENAME_NORMAL:
 		case RENAME_ONE_FILE_TO_ONE:
-			clean_merge = handle_rename_normal(opt,
-							   path,
-							   o_oid, o_mode,
-							   a_oid, a_mode,
-							   b_oid, b_mode,
+			clean_merge = handle_rename_normal(opt, path, o, a, b,
 							   ci);
 			break;
 		case RENAME_VIA_DIR:
@@ -3204,11 +3144,27 @@ static int process_entry(struct merge_options *opt,
 				clean_merge = -1;
 			break;
 		case RENAME_ONE_FILE_TO_TWO:
+			/*
+			 * Manually fix up paths; note:
+			 * ren[12]->pair->one->path are equal.
+			 */
+			o->path = ci->ren1->pair->one->path;
+			a->path = ci->ren1->pair->two->path;
+			b->path = ci->ren2->pair->two->path;
+
 			clean_merge = 0;
 			if (handle_rename_rename_1to2(opt, ci))
 				clean_merge = -1;
 			break;
 		case RENAME_TWO_FILES_TO_ONE:
+			/*
+			 * Manually fix up paths; note,
+			 * ren[12]->pair->two->path are actually equal.
+			 */
+			o->path = NULL;
+			a->path = ci->ren1->pair->two->path;
+			b->path = ci->ren2->pair->two->path;
+
 			/*
 			 * Probably unclean merge, but if the two renamed
 			 * files merge cleanly and the two resulting files
@@ -3221,57 +3177,53 @@ static int process_entry(struct merge_options *opt,
 			entry->processed = 0;
 			break;
 		}
-	} else if (o_oid && (!a_oid || !b_oid)) {
+	} else if (o_valid && (!a_valid || !b_valid)) {
 		/* Case A: Deleted in one */
-		if ((!a_oid && !b_oid) ||
-		    (!b_oid && blob_unchanged(opt, o_oid, o_mode, a_oid, a_mode, normalize, path)) ||
-		    (!a_oid && blob_unchanged(opt, o_oid, o_mode, b_oid, b_mode, normalize, path))) {
+		if ((!a_valid && !b_valid) ||
+		    (!b_valid && blob_unchanged(opt, o, a, normalize, path)) ||
+		    (!a_valid && blob_unchanged(opt, o, b, normalize, path))) {
 			/* Deleted in both or deleted in one and
 			 * unchanged in the other */
-			if (a_oid)
+			if (a_valid)
 				output(opt, 2, _("Removing %s"), path);
 			/* do not touch working file if it did not exist */
-			remove_file(opt, 1, path, !a_oid);
+			remove_file(opt, 1, path, !a_valid);
 		} else {
 			/* Modify/delete; deleted side may have put a directory in the way */
 			clean_merge = 0;
-			if (handle_modify_delete(opt, path, o_oid, o_mode,
-						 a_oid, a_mode, b_oid, b_mode))
+			if (handle_modify_delete(opt, path, o, a, b))
 				clean_merge = -1;
 		}
-	} else if ((!o_oid && a_oid && !b_oid) ||
-		   (!o_oid && !a_oid && b_oid)) {
+	} else if ((!o_valid && a_valid && !b_valid) ||
+		   (!o_valid && !a_valid && b_valid)) {
 		/* Case B: Added in one. */
 		/* [nothing|directory] -> ([nothing|directory], file) */
 
 		const char *add_branch;
 		const char *other_branch;
-		unsigned mode;
-		const struct object_id *oid;
 		const char *conf;
+		const struct diff_filespec *contents;
 
-		if (a_oid) {
+		if (a_valid) {
 			add_branch = opt->branch1;
 			other_branch = opt->branch2;
-			mode = a_mode;
-			oid = a_oid;
+			contents = a;
 			conf = _("file/directory");
 		} else {
 			add_branch = opt->branch2;
 			other_branch = opt->branch1;
-			mode = b_mode;
-			oid = b_oid;
+			contents = b;
 			conf = _("directory/file");
 		}
 		if (dir_in_way(opt->repo->index, path,
-			       !opt->call_depth && !S_ISGITLINK(a_mode),
+			       !opt->call_depth && !S_ISGITLINK(a->mode),
 			       0)) {
 			char *new_path = unique_path(opt, path, add_branch);
 			clean_merge = 0;
 			output(opt, 1, _("CONFLICT (%s): There is a directory with name %s in %s. "
 			       "Adding %s as %s"),
 			       conf, path, other_branch, path, new_path);
-			if (update_file(opt, 0, oid, mode, new_path))
+			if (update_file(opt, 0, contents, new_path))
 				clean_merge = -1;
 			else if (opt->call_depth)
 				remove_file_from_index(opt->repo->index, path);
@@ -3279,11 +3231,11 @@ static int process_entry(struct merge_options *opt,
 		} else {
 			output(opt, 2, _("Adding %s"), path);
 			/* do not overwrite file if already present */
-			if (update_file_flags(opt, oid, mode, path, 1, !a_oid))
+			if (update_file_flags(opt, contents, path, 1, !a_valid))
 				clean_merge = -1;
 		}
-	} else if (a_oid && b_oid) {
-		if (!o_oid) {
+	} else if (a_valid && b_valid) {
+		if (!o_valid) {
 			/* Case C: Added in both (check for same permissions) */
 			output(opt, 1,
 			       _("CONFLICT (add/add): Merge conflict in %s"),
@@ -3292,24 +3244,19 @@ static int process_entry(struct merge_options *opt,
 							    path, NULL, NULL,
 							    opt->branch1,
 							    opt->branch2,
-							    a_oid, a_mode,
-							    b_oid, b_mode);
+							    a, b);
 		} else {
 			/* case D: Modified in both, but differently. */
 			int is_dirty = 0; /* unpack_trees would have bailed if dirty */
-			clean_merge = handle_content_merge(opt, path,
-							   is_dirty,
-							   o_oid, o_mode,
-							   a_oid, a_mode,
-							   b_oid, b_mode,
-							   NULL);
+			clean_merge = handle_content_merge(opt, path, is_dirty,
+							   o, a, b, NULL);
 		}
-	} else if (!o_oid && !a_oid && !b_oid) {
+	} else if (!o_valid && !a_valid && !b_valid) {
 		/*
 		 * this entry was deleted altogether. a_mode == 0 means
 		 * we had that path and want to actively remove it.
 		 */
-		remove_file(opt, 1, path, !a_mode);
+		remove_file(opt, 1, path, !a->mode);
 	} else
 		BUG("fatal merge failure, shouldn't happen.");
 
-- 
2.21.0.211.g078f4bef79.dirty

