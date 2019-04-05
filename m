Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC69120248
	for <e@80x24.org>; Fri,  5 Apr 2019 15:01:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731385AbfDEPBM (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Apr 2019 11:01:12 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:40228 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731359AbfDEPBL (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 5 Apr 2019 11:01:11 -0400
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x35EwSns001751;
        Fri, 5 Apr 2019 08:00:42 -0700
Received: from mail.palantir.com ([8.4.231.70])
        by mx0a-00153501.pphosted.com with ESMTP id 2rmg324g4c-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 05 Apr 2019 08:00:41 -0700
Received: from sj-prod-exch-01.YOJOE.local (10.129.18.26) by
 sj-prod-exch-01.YOJOE.local (10.129.18.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Fri, 5 Apr 2019 08:00:39 -0700
Received: from smtp-transport.yojoe.local (10.129.56.124) by
 sj-prod-exch-01.YOJOE.local (10.129.18.26) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Fri, 5 Apr 2019 08:00:39 -0700
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp-transport.yojoe.local (Postfix) with ESMTPS id 0CBBF220CB17;
        Fri,  5 Apr 2019 08:00:39 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     <git@vger.kernel.org>
CC:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Linus Nilsson <Linus.Nilsson@trimma.se>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 02/15] merge-recursive: rename merge_options argument from 'o' to 'opt'
Date:   Fri, 5 Apr 2019 08:00:13 -0700
Message-ID: <20190405150026.5260-3-newren@gmail.com>
X-Mailer: git-send-email 2.21.0.211.g719c25afaf.dirty
In-Reply-To: <20190405150026.5260-1-newren@gmail.com>
References: <20190330003336.21940-1-newren@gmail.com>
 <20190405150026.5260-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-05_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=15
 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=999 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.0.1-1810050000 definitions=main-1904050102
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The name 'o' was used for the merge_options struct pointer taken by many
functions, but in a few places it was named 'opt'.  Several functions
that didn't need merge_options instead used 'o' for a diff_filespec
argument or local.  Some functions needed both an inconsistently either
renamed the merge_options to 'opt' or the diff_filespec to 'one'.  I
want to remove the weird split in the codebase between using a
diff_filespec and a pair of (oid,mode) values in favor of using a
diff_filespec everywhere, but that dramatically increases the number of
cases where we want to use 'o' as a diff_filespec.  Rename the
merge_options argument to 'opt' to make room.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 984 +++++++++++++++++++++++-----------------------
 1 file changed, 492 insertions(+), 492 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index fcf37be2a7..09b76d596e 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -115,32 +115,32 @@ static void collision_init(struct hashmap *map)
 	hashmap_init(map, (hashmap_cmp_fn) collision_cmp, NULL, 0);
 }
 
-static void flush_output(struct merge_options *o)
+static void flush_output(struct merge_options *opt)
 {
-	if (o->buffer_output < 2 && o->obuf.len) {
-		fputs(o->obuf.buf, stdout);
-		strbuf_reset(&o->obuf);
+	if (opt->buffer_output < 2 && opt->obuf.len) {
+		fputs(opt->obuf.buf, stdout);
+		strbuf_reset(&opt->obuf);
 	}
 }
 
-static int err(struct merge_options *o, const char *err, ...)
+static int err(struct merge_options *opt, const char *err, ...)
 {
 	va_list params;
 
-	if (o->buffer_output < 2)
-		flush_output(o);
+	if (opt->buffer_output < 2)
+		flush_output(opt);
 	else {
-		strbuf_complete(&o->obuf, '\n');
-		strbuf_addstr(&o->obuf, "error: ");
+		strbuf_complete(&opt->obuf, '\n');
+		strbuf_addstr(&opt->obuf, "error: ");
 	}
 	va_start(params, err);
-	strbuf_vaddf(&o->obuf, err, params);
+	strbuf_vaddf(&opt->obuf, err, params);
 	va_end(params);
-	if (o->buffer_output > 1)
-		strbuf_addch(&o->obuf, '\n');
+	if (opt->buffer_output > 1)
+		strbuf_addch(&opt->obuf, '\n');
 	else {
-		error("%s", o->obuf.buf);
-		strbuf_reset(&o->obuf);
+		error("%s", opt->obuf.buf);
+		strbuf_reset(&opt->obuf);
 	}
 
 	return -1;
@@ -228,7 +228,7 @@ static inline void setup_rename_conflict_info(enum rename_type rename_type,
 					      const char *branch2,
 					      struct stage_data *dst_entry1,
 					      struct stage_data *dst_entry2,
-					      struct merge_options *o,
+					      struct merge_options *opt,
 					      struct stage_data *src_entry1,
 					      struct stage_data *src_entry2)
 {
@@ -239,15 +239,15 @@ static inline void setup_rename_conflict_info(enum rename_type rename_type,
 	 * When we have two renames involved, it's easiest to get the
 	 * correct things into stage 2 and 3, and to make sure that the
 	 * content merge puts HEAD before the other branch if we just
-	 * ensure that branch1 == o->branch1.  So, simply flip arguments
+	 * ensure that branch1 == opt->branch1.  So, simply flip arguments
 	 * around if we don't have that.
 	 */
-	if (dst_entry2 && branch1 != o->branch1) {
+	if (dst_entry2 && branch1 != opt->branch1) {
 		setup_rename_conflict_info(rename_type,
 					   pair2,      pair1,
 					   branch2,    branch1,
 					   dst_entry2, dst_entry1,
-					   o,
+					   opt,
 					   src_entry2, src_entry1);
 		return;
 	}
@@ -276,7 +276,7 @@ static inline void setup_rename_conflict_info(enum rename_type rename_type,
 	 */
 	if (rename_type == RENAME_ADD ||
 	    rename_type == RENAME_TWO_FILES_TO_ONE) {
-		ostage1 = o->branch1 == branch1 ? 3 : 2;
+		ostage1 = opt->branch1 == branch1 ? 3 : 2;
 
 		ci->ren1_other.path = pair1->one->path;
 		oidcpy(&ci->ren1_other.oid, &src_entry1->stages[ostage1].oid);
@@ -292,67 +292,67 @@ static inline void setup_rename_conflict_info(enum rename_type rename_type,
 	}
 }
 
-static int show(struct merge_options *o, int v)
+static int show(struct merge_options *opt, int v)
 {
-	return (!o->call_depth && o->verbosity >= v) || o->verbosity >= 5;
+	return (!opt->call_depth && opt->verbosity >= v) || opt->verbosity >= 5;
 }
 
 __attribute__((format (printf, 3, 4)))
-static void output(struct merge_options *o, int v, const char *fmt, ...)
+static void output(struct merge_options *opt, int v, const char *fmt, ...)
 {
 	va_list ap;
 
-	if (!show(o, v))
+	if (!show(opt, v))
 		return;
 
-	strbuf_addchars(&o->obuf, ' ', o->call_depth * 2);
+	strbuf_addchars(&opt->obuf, ' ', opt->call_depth * 2);
 
 	va_start(ap, fmt);
-	strbuf_vaddf(&o->obuf, fmt, ap);
+	strbuf_vaddf(&opt->obuf, fmt, ap);
 	va_end(ap);
 
-	strbuf_addch(&o->obuf, '\n');
-	if (!o->buffer_output)
-		flush_output(o);
+	strbuf_addch(&opt->obuf, '\n');
+	if (!opt->buffer_output)
+		flush_output(opt);
 }
 
-static void output_commit_title(struct merge_options *o, struct commit *commit)
+static void output_commit_title(struct merge_options *opt, struct commit *commit)
 {
 	struct merge_remote_desc *desc;
 
-	strbuf_addchars(&o->obuf, ' ', o->call_depth * 2);
+	strbuf_addchars(&opt->obuf, ' ', opt->call_depth * 2);
 	desc = merge_remote_util(commit);
 	if (desc)
-		strbuf_addf(&o->obuf, "virtual %s\n", desc->name);
+		strbuf_addf(&opt->obuf, "virtual %s\n", desc->name);
 	else {
-		strbuf_add_unique_abbrev(&o->obuf, &commit->object.oid,
+		strbuf_add_unique_abbrev(&opt->obuf, &commit->object.oid,
 					 DEFAULT_ABBREV);
-		strbuf_addch(&o->obuf, ' ');
+		strbuf_addch(&opt->obuf, ' ');
 		if (parse_commit(commit) != 0)
-			strbuf_addstr(&o->obuf, _("(bad commit)\n"));
+			strbuf_addstr(&opt->obuf, _("(bad commit)\n"));
 		else {
 			const char *title;
 			const char *msg = get_commit_buffer(commit, NULL);
 			int len = find_commit_subject(msg, &title);
 			if (len)
-				strbuf_addf(&o->obuf, "%.*s\n", len, title);
+				strbuf_addf(&opt->obuf, "%.*s\n", len, title);
 			unuse_commit_buffer(commit, msg);
 		}
 	}
-	flush_output(o);
+	flush_output(opt);
 }
 
-static int add_cacheinfo(struct merge_options *o,
+static int add_cacheinfo(struct merge_options *opt,
 			 unsigned int mode, const struct object_id *oid,
 			 const char *path, int stage, int refresh, int options)
 {
-	struct index_state *istate = o->repo->index;
+	struct index_state *istate = opt->repo->index;
 	struct cache_entry *ce;
 	int ret;
 
 	ce = make_cache_entry(istate, mode, oid ? oid : &null_oid, path, stage, 0);
 	if (!ce)
-		return err(o, _("add_cacheinfo failed for path '%s'; merge aborting."), path);
+		return err(opt, _("add_cacheinfo failed for path '%s'; merge aborting."), path);
 
 	ret = add_index_entry(istate, ce, options);
 	if (refresh) {
@@ -361,7 +361,7 @@ static int add_cacheinfo(struct merge_options *o,
 		nce = refresh_cache_entry(istate, ce,
 					  CE_MATCH_REFRESH | CE_MATCH_IGNORE_MISSING);
 		if (!nce)
-			return err(o, _("add_cacheinfo failed to refresh for path '%s'; merge aborting."), path);
+			return err(opt, _("add_cacheinfo failed to refresh for path '%s'; merge aborting."), path);
 		if (nce != ce)
 			ret = add_index_entry(istate, nce, options);
 	}
@@ -374,7 +374,7 @@ static void init_tree_desc_from_tree(struct tree_desc *desc, struct tree *tree)
 	init_tree_desc(desc, tree->buffer, tree->size);
 }
 
-static int unpack_trees_start(struct merge_options *o,
+static int unpack_trees_start(struct merge_options *opt,
 			      struct tree *common,
 			      struct tree *head,
 			      struct tree *merge)
@@ -383,49 +383,49 @@ static int unpack_trees_start(struct merge_options *o,
 	struct tree_desc t[3];
 	struct index_state tmp_index = { NULL };
 
-	memset(&o->unpack_opts, 0, sizeof(o->unpack_opts));
-	if (o->call_depth)
-		o->unpack_opts.index_only = 1;
+	memset(&opt->unpack_opts, 0, sizeof(opt->unpack_opts));
+	if (opt->call_depth)
+		opt->unpack_opts.index_only = 1;
 	else
-		o->unpack_opts.update = 1;
-	o->unpack_opts.merge = 1;
-	o->unpack_opts.head_idx = 2;
-	o->unpack_opts.fn = threeway_merge;
-	o->unpack_opts.src_index = o->repo->index;
-	o->unpack_opts.dst_index = &tmp_index;
-	o->unpack_opts.aggressive = !merge_detect_rename(o);
-	setup_unpack_trees_porcelain(&o->unpack_opts, "merge");
+		opt->unpack_opts.update = 1;
+	opt->unpack_opts.merge = 1;
+	opt->unpack_opts.head_idx = 2;
+	opt->unpack_opts.fn = threeway_merge;
+	opt->unpack_opts.src_index = opt->repo->index;
+	opt->unpack_opts.dst_index = &tmp_index;
+	opt->unpack_opts.aggressive = !merge_detect_rename(opt);
+	setup_unpack_trees_porcelain(&opt->unpack_opts, "merge");
 
 	init_tree_desc_from_tree(t+0, common);
 	init_tree_desc_from_tree(t+1, head);
 	init_tree_desc_from_tree(t+2, merge);
 
-	rc = unpack_trees(3, t, &o->unpack_opts);
-	cache_tree_free(&o->repo->index->cache_tree);
+	rc = unpack_trees(3, t, &opt->unpack_opts);
+	cache_tree_free(&opt->repo->index->cache_tree);
 
 	/*
-	 * Update o->repo->index to match the new results, AFTER saving a copy
-	 * in o->orig_index.  Update src_index to point to the saved copy.
+	 * Update opt->repo->index to match the new results, AFTER saving a copy
+	 * in opt->orig_index.  Update src_index to point to the saved copy.
 	 * (verify_uptodate() checks src_index, and the original index is
 	 * the one that had the necessary modification timestamps.)
 	 */
-	o->orig_index = *o->repo->index;
-	*o->repo->index = tmp_index;
-	o->unpack_opts.src_index = &o->orig_index;
+	opt->orig_index = *opt->repo->index;
+	*opt->repo->index = tmp_index;
+	opt->unpack_opts.src_index = &opt->orig_index;
 
 	return rc;
 }
 
-static void unpack_trees_finish(struct merge_options *o)
+static void unpack_trees_finish(struct merge_options *opt)
 {
-	discard_index(&o->orig_index);
-	clear_unpack_trees_porcelain(&o->unpack_opts);
+	discard_index(&opt->orig_index);
+	clear_unpack_trees_porcelain(&opt->unpack_opts);
 }
 
-struct tree *write_tree_from_memory(struct merge_options *o)
+struct tree *write_tree_from_memory(struct merge_options *opt)
 {
 	struct tree *result = NULL;
-	struct index_state *istate = o->repo->index;
+	struct index_state *istate = opt->repo->index;
 
 	if (unmerged_index(istate)) {
 		int i;
@@ -444,11 +444,11 @@ struct tree *write_tree_from_memory(struct merge_options *o)
 
 	if (!cache_tree_fully_valid(istate->cache_tree) &&
 	    cache_tree_update(istate, 0) < 0) {
-		err(o, _("error building trees"));
+		err(opt, _("error building trees"));
 		return NULL;
 	}
 
-	result = lookup_tree(o->repo, &istate->cache_tree->oid);
+	result = lookup_tree(opt->repo, &istate->cache_tree->oid);
 
 	return result;
 }
@@ -459,24 +459,24 @@ static int save_files_dirs(const struct object_id *oid,
 {
 	struct path_hashmap_entry *entry;
 	int baselen = base->len;
-	struct merge_options *o = context;
+	struct merge_options *opt = context;
 
 	strbuf_addstr(base, path);
 
 	FLEX_ALLOC_MEM(entry, path, base->buf, base->len);
 	hashmap_entry_init(entry, path_hash(entry->path));
-	hashmap_add(&o->current_file_dir_set, entry);
+	hashmap_add(&opt->current_file_dir_set, entry);
 
 	strbuf_setlen(base, baselen);
 	return (S_ISDIR(mode) ? READ_TREE_RECURSIVE : 0);
 }
 
-static void get_files_dirs(struct merge_options *o, struct tree *tree)
+static void get_files_dirs(struct merge_options *opt, struct tree *tree)
 {
 	struct pathspec match_all;
 	memset(&match_all, 0, sizeof(match_all));
 	read_tree_recursive(the_repository, tree, "", 0, 0,
-			    &match_all, save_files_dirs, o);
+			    &match_all, save_files_dirs, opt);
 }
 
 static int get_tree_entry_if_blob(const struct object_id *tree,
@@ -573,7 +573,7 @@ static int string_list_df_name_compare(const char *one, const char *two)
 	return onelen - twolen;
 }
 
-static void record_df_conflict_files(struct merge_options *o,
+static void record_df_conflict_files(struct merge_options *opt,
 				     struct string_list *entries)
 {
 	/* If there is a D/F conflict and the file for such a conflict
@@ -598,7 +598,7 @@ static void record_df_conflict_files(struct merge_options *o,
 	 * If we're merging merge-bases, we don't want to bother with
 	 * any working directory changes.
 	 */
-	if (o->call_depth)
+	if (opt->call_depth)
 		return;
 
 	/* Ensure D/F conflicts are adjacent in the entries list. */
@@ -610,7 +610,7 @@ static void record_df_conflict_files(struct merge_options *o,
 	df_sorted_entries.cmp = string_list_df_name_compare;
 	string_list_sort(&df_sorted_entries);
 
-	string_list_clear(&o->df_conflict_file_set, 1);
+	string_list_clear(&opt->df_conflict_file_set, 1);
 	for (i = 0; i < df_sorted_entries.nr; i++) {
 		const char *path = df_sorted_entries.items[i].string;
 		int len = strlen(path);
@@ -626,7 +626,7 @@ static void record_df_conflict_files(struct merge_options *o,
 		    len > last_len &&
 		    memcmp(path, last_file, last_len) == 0 &&
 		    path[last_len] == '/') {
-			string_list_insert(&o->df_conflict_file_set, last_file);
+			string_list_insert(&opt->df_conflict_file_set, last_file);
 		}
 
 		/*
@@ -717,20 +717,20 @@ static void update_entry(struct stage_data *entry,
 	oidcpy(&entry->stages[3].oid, &b->oid);
 }
 
-static int remove_file(struct merge_options *o, int clean,
+static int remove_file(struct merge_options *opt, int clean,
 		       const char *path, int no_wd)
 {
-	int update_cache = o->call_depth || clean;
-	int update_working_directory = !o->call_depth && !no_wd;
+	int update_cache = opt->call_depth || clean;
+	int update_working_directory = !opt->call_depth && !no_wd;
 
 	if (update_cache) {
-		if (remove_file_from_index(o->repo->index, path))
+		if (remove_file_from_index(opt->repo->index, path))
 			return -1;
 	}
 	if (update_working_directory) {
 		if (ignore_case) {
 			struct cache_entry *ce;
-			ce = index_file_exists(o->repo->index, path, strlen(path),
+			ce = index_file_exists(opt->repo->index, path, strlen(path),
 					       ignore_case);
 			if (ce && ce_stage(ce) == 0 && strcmp(path, ce->name))
 				return 0;
@@ -751,7 +751,7 @@ static void add_flattened_path(struct strbuf *out, const char *s)
 			out->buf[i] = '_';
 }
 
-static char *unique_path(struct merge_options *o, const char *path, const char *branch)
+static char *unique_path(struct merge_options *opt, const char *path, const char *branch)
 {
 	struct path_hashmap_entry *entry;
 	struct strbuf newpath = STRBUF_INIT;
@@ -762,16 +762,16 @@ static char *unique_path(struct merge_options *o, const char *path, const char *
 	add_flattened_path(&newpath, branch);
 
 	base_len = newpath.len;
-	while (hashmap_get_from_hash(&o->current_file_dir_set,
+	while (hashmap_get_from_hash(&opt->current_file_dir_set,
 				     path_hash(newpath.buf), newpath.buf) ||
-	       (!o->call_depth && file_exists(newpath.buf))) {
+	       (!opt->call_depth && file_exists(newpath.buf))) {
 		strbuf_setlen(&newpath, base_len);
 		strbuf_addf(&newpath, "_%d", suffix++);
 	}
 
 	FLEX_ALLOC_MEM(entry, path, newpath.buf, newpath.len);
 	hashmap_entry_init(entry, path_hash(entry->path));
-	hashmap_add(&o->current_file_dir_set, entry);
+	hashmap_add(&opt->current_file_dir_set, entry);
 	return strbuf_detach(&newpath, NULL);
 }
 
@@ -810,10 +810,10 @@ static int dir_in_way(struct index_state *istate, const char *path,
  * Returns whether path was tracked in the index before the merge started,
  * and its oid and mode match the specified values
  */
-static int was_tracked_and_matches(struct merge_options *o, const char *path,
+static int was_tracked_and_matches(struct merge_options *opt, const char *path,
 				   const struct object_id *oid, unsigned mode)
 {
-	int pos = index_name_pos(&o->orig_index, path, strlen(path));
+	int pos = index_name_pos(&opt->orig_index, path, strlen(path));
 	struct cache_entry *ce;
 
 	if (0 > pos)
@@ -821,16 +821,16 @@ static int was_tracked_and_matches(struct merge_options *o, const char *path,
 		return 0;
 
 	/* See if the file we were tracking before matches */
-	ce = o->orig_index.cache[pos];
+	ce = opt->orig_index.cache[pos];
 	return (oid_eq(&ce->oid, oid) && ce->ce_mode == mode);
 }
 
 /*
  * Returns whether path was tracked in the index before the merge started
  */
-static int was_tracked(struct merge_options *o, const char *path)
+static int was_tracked(struct merge_options *opt, const char *path)
 {
-	int pos = index_name_pos(&o->orig_index, path, strlen(path));
+	int pos = index_name_pos(&opt->orig_index, path, strlen(path));
 
 	if (0 <= pos)
 		/* we were tracking this path before the merge */
@@ -839,13 +839,13 @@ static int was_tracked(struct merge_options *o, const char *path)
 	return 0;
 }
 
-static int would_lose_untracked(struct merge_options *o, const char *path)
+static int would_lose_untracked(struct merge_options *opt, const char *path)
 {
-	struct index_state *istate = o->repo->index;
+	struct index_state *istate = opt->repo->index;
 
 	/*
 	 * This may look like it can be simplified to:
-	 *   return !was_tracked(o, path) && file_exists(path)
+	 *   return !was_tracked(opt, path) && file_exists(path)
 	 * but it can't.  This function needs to know whether path was in
 	 * the working tree due to EITHER having been tracked in the index
 	 * before the merge OR having been put into the working copy and
@@ -882,38 +882,38 @@ static int would_lose_untracked(struct merge_options *o, const char *path)
 	return file_exists(path);
 }
 
-static int was_dirty(struct merge_options *o, const char *path)
+static int was_dirty(struct merge_options *opt, const char *path)
 {
 	struct cache_entry *ce;
 	int dirty = 1;
 
-	if (o->call_depth || !was_tracked(o, path))
+	if (opt->call_depth || !was_tracked(opt, path))
 		return !dirty;
 
-	ce = index_file_exists(o->unpack_opts.src_index,
+	ce = index_file_exists(opt->unpack_opts.src_index,
 			       path, strlen(path), ignore_case);
-	dirty = verify_uptodate(ce, &o->unpack_opts) != 0;
+	dirty = verify_uptodate(ce, &opt->unpack_opts) != 0;
 	return dirty;
 }
 
-static int make_room_for_path(struct merge_options *o, const char *path)
+static int make_room_for_path(struct merge_options *opt, const char *path)
 {
 	int status, i;
 	const char *msg = _("failed to create path '%s'%s");
 
 	/* Unlink any D/F conflict files that are in the way */
-	for (i = 0; i < o->df_conflict_file_set.nr; i++) {
-		const char *df_path = o->df_conflict_file_set.items[i].string;
+	for (i = 0; i < opt->df_conflict_file_set.nr; i++) {
+		const char *df_path = opt->df_conflict_file_set.items[i].string;
 		size_t pathlen = strlen(path);
 		size_t df_pathlen = strlen(df_path);
 		if (df_pathlen < pathlen &&
 		    path[df_pathlen] == '/' &&
 		    strncmp(path, df_path, df_pathlen) == 0) {
-			output(o, 3,
+			output(opt, 3,
 			       _("Removing %s to make room for subdirectory\n"),
 			       df_path);
 			unlink(df_path);
-			unsorted_string_list_delete_item(&o->df_conflict_file_set,
+			unsorted_string_list_delete_item(&opt->df_conflict_file_set,
 							 i, 0);
 			break;
 		}
@@ -924,16 +924,16 @@ static int make_room_for_path(struct merge_options *o, const char *path)
 	if (status) {
 		if (status == SCLD_EXISTS)
 			/* something else exists */
-			return err(o, msg, path, _(": perhaps a D/F conflict?"));
-		return err(o, msg, path, "");
+			return err(opt, msg, path, _(": perhaps a D/F conflict?"));
+		return err(opt, msg, path, "");
 	}
 
 	/*
 	 * Do not unlink a file in the work tree if we are not
 	 * tracking it.
 	 */
-	if (would_lose_untracked(o, path))
-		return err(o, _("refusing to lose untracked file at '%s'"),
+	if (would_lose_untracked(opt, path))
+		return err(opt, _("refusing to lose untracked file at '%s'"),
 			   path);
 
 	/* Successful unlink is good.. */
@@ -943,10 +943,10 @@ static int make_room_for_path(struct merge_options *o, const char *path)
 	if (errno == ENOENT)
 		return 0;
 	/* .. but not some other error (who really cares what?) */
-	return err(o, msg, path, _(": perhaps a D/F conflict?"));
+	return err(opt, msg, path, _(": perhaps a D/F conflict?"));
 }
 
-static int update_file_flags(struct merge_options *o,
+static int update_file_flags(struct merge_options *opt,
 			     const struct object_id *oid,
 			     unsigned mode,
 			     const char *path,
@@ -955,7 +955,7 @@ static int update_file_flags(struct merge_options *o,
 {
 	int ret = 0;
 
-	if (o->call_depth)
+	if (opt->call_depth)
 		update_wd = 0;
 
 	if (update_wd) {
@@ -975,21 +975,21 @@ static int update_file_flags(struct merge_options *o,
 
 		buf = read_object_file(oid, &type, &size);
 		if (!buf)
-			return err(o, _("cannot read object %s '%s'"), oid_to_hex(oid), path);
+			return err(opt, _("cannot read object %s '%s'"), oid_to_hex(oid), path);
 		if (type != OBJ_BLOB) {
-			ret = err(o, _("blob expected for %s '%s'"), oid_to_hex(oid), path);
+			ret = err(opt, _("blob expected for %s '%s'"), oid_to_hex(oid), path);
 			goto free_buf;
 		}
 		if (S_ISREG(mode)) {
 			struct strbuf strbuf = STRBUF_INIT;
-			if (convert_to_working_tree(o->repo->index, path, buf, size, &strbuf)) {
+			if (convert_to_working_tree(opt->repo->index, path, buf, size, &strbuf)) {
 				free(buf);
 				size = strbuf.len;
 				buf = strbuf_detach(&strbuf, NULL);
 			}
 		}
 
-		if (make_room_for_path(o, path) < 0) {
+		if (make_room_for_path(opt, path) < 0) {
 			update_wd = 0;
 			goto free_buf;
 		}
@@ -1001,7 +1001,7 @@ static int update_file_flags(struct merge_options *o,
 				mode = 0666;
 			fd = open(path, O_WRONLY | O_TRUNC | O_CREAT, mode);
 			if (fd < 0) {
-				ret = err(o, _("failed to open '%s': %s"),
+				ret = err(opt, _("failed to open '%s': %s"),
 					  path, strerror(errno));
 				goto free_buf;
 			}
@@ -1012,11 +1012,11 @@ static int update_file_flags(struct merge_options *o,
 			safe_create_leading_directories_const(path);
 			unlink(path);
 			if (symlink(lnk, path))
-				ret = err(o, _("failed to symlink '%s': %s"),
+				ret = err(opt, _("failed to symlink '%s': %s"),
 					  path, strerror(errno));
 			free(lnk);
 		} else
-			ret = err(o,
+			ret = err(opt,
 				  _("do not know what to do with %06o %s '%s'"),
 				  mode, oid_to_hex(oid), path);
 	free_buf:
@@ -1024,19 +1024,19 @@ static int update_file_flags(struct merge_options *o,
 	}
 update_index:
 	if (!ret && update_cache)
-		if (add_cacheinfo(o, mode, oid, path, 0, update_wd,
+		if (add_cacheinfo(opt, mode, oid, path, 0, update_wd,
 				  ADD_CACHE_OK_TO_ADD))
 			return -1;
 	return ret;
 }
 
-static int update_file(struct merge_options *o,
+static int update_file(struct merge_options *opt,
 		       int clean,
 		       const struct object_id *oid,
 		       unsigned mode,
 		       const char *path)
 {
-	return update_file_flags(o, oid, mode, path, o->call_depth || clean, !o->call_depth);
+	return update_file_flags(opt, oid, mode, path, opt->call_depth || clean, !opt->call_depth);
 }
 
 /* Low level file merging, update and removal */
@@ -1048,7 +1048,7 @@ struct merge_file_info {
 		 merge:1;
 };
 
-static int merge_3way(struct merge_options *o,
+static int merge_3way(struct merge_options *opt,
 		      mmbuffer_t *result_buf,
 		      const struct diff_filespec *one,
 		      const struct diff_filespec *a,
@@ -1062,15 +1062,15 @@ static int merge_3way(struct merge_options *o,
 	char *base_name, *name1, *name2;
 	int merge_status;
 
-	ll_opts.renormalize = o->renormalize;
+	ll_opts.renormalize = opt->renormalize;
 	ll_opts.extra_marker_size = extra_marker_size;
-	ll_opts.xdl_opts = o->xdl_opts;
+	ll_opts.xdl_opts = opt->xdl_opts;
 
-	if (o->call_depth) {
+	if (opt->call_depth) {
 		ll_opts.virtual_ancestor = 1;
 		ll_opts.variant = 0;
 	} else {
-		switch (o->recursive_variant) {
+		switch (opt->recursive_variant) {
 		case MERGE_RECURSIVE_OURS:
 			ll_opts.variant = XDL_MERGE_FAVOR_OURS;
 			break;
@@ -1084,14 +1084,14 @@ static int merge_3way(struct merge_options *o,
 	}
 
 	if (strcmp(a->path, b->path) ||
-	    (o->ancestor != NULL && strcmp(a->path, one->path) != 0)) {
-		base_name = o->ancestor == NULL ? NULL :
-			mkpathdup("%s:%s", o->ancestor, one->path);
+	    (opt->ancestor != NULL && strcmp(a->path, one->path) != 0)) {
+		base_name = opt->ancestor == NULL ? NULL :
+			mkpathdup("%s:%s", opt->ancestor, one->path);
 		name1 = mkpathdup("%s:%s", branch1, a->path);
 		name2 = mkpathdup("%s:%s", branch2, b->path);
 	} else {
-		base_name = o->ancestor == NULL ? NULL :
-			mkpathdup("%s", o->ancestor);
+		base_name = opt->ancestor == NULL ? NULL :
+			mkpathdup("%s", opt->ancestor);
 		name1 = mkpathdup("%s", branch1);
 		name2 = mkpathdup("%s", branch2);
 	}
@@ -1102,7 +1102,7 @@ static int merge_3way(struct merge_options *o,
 
 	merge_status = ll_merge(result_buf, a->path, &orig, base_name,
 				&src1, name1, &src2, name2,
-				o->repo->index, &ll_opts);
+				opt->repo->index, &ll_opts);
 
 	free(base_name);
 	free(name1);
@@ -1184,7 +1184,7 @@ static void print_commit(struct commit *commit)
 	strbuf_release(&sb);
 }
 
-static int merge_submodule(struct merge_options *o,
+static int merge_submodule(struct merge_options *opt,
 			   struct object_id *result, const char *path,
 			   const struct object_id *base, const struct object_id *a,
 			   const struct object_id *b)
@@ -1194,7 +1194,7 @@ static int merge_submodule(struct merge_options *o,
 	struct object_array merges;
 
 	int i;
-	int search = !o->call_depth;
+	int search = !opt->call_depth;
 
 	/* store a in result in case we fail */
 	oidcpy(result, a);
@@ -1208,32 +1208,32 @@ static int merge_submodule(struct merge_options *o,
 		return 0;
 
 	if (add_submodule_odb(path)) {
-		output(o, 1, _("Failed to merge submodule %s (not checked out)"), path);
+		output(opt, 1, _("Failed to merge submodule %s (not checked out)"), path);
 		return 0;
 	}
 
-	if (!(commit_base = lookup_commit_reference(o->repo, base)) ||
-	    !(commit_a = lookup_commit_reference(o->repo, a)) ||
-	    !(commit_b = lookup_commit_reference(o->repo, b))) {
-		output(o, 1, _("Failed to merge submodule %s (commits not present)"), path);
+	if (!(commit_base = lookup_commit_reference(opt->repo, base)) ||
+	    !(commit_a = lookup_commit_reference(opt->repo, a)) ||
+	    !(commit_b = lookup_commit_reference(opt->repo, b))) {
+		output(opt, 1, _("Failed to merge submodule %s (commits not present)"), path);
 		return 0;
 	}
 
 	/* check whether both changes are forward */
 	if (!in_merge_bases(commit_base, commit_a) ||
 	    !in_merge_bases(commit_base, commit_b)) {
-		output(o, 1, _("Failed to merge submodule %s (commits don't follow merge-base)"), path);
+		output(opt, 1, _("Failed to merge submodule %s (commits don't follow merge-base)"), path);
 		return 0;
 	}
 
 	/* Case #1: a is contained in b or vice versa */
 	if (in_merge_bases(commit_a, commit_b)) {
 		oidcpy(result, b);
-		if (show(o, 3)) {
-			output(o, 3, _("Fast-forwarding submodule %s to the following commit:"), path);
-			output_commit_title(o, commit_b);
-		} else if (show(o, 2))
-			output(o, 2, _("Fast-forwarding submodule %s"), path);
+		if (show(opt, 3)) {
+			output(opt, 3, _("Fast-forwarding submodule %s to the following commit:"), path);
+			output_commit_title(opt, commit_b);
+		} else if (show(opt, 2))
+			output(opt, 2, _("Fast-forwarding submodule %s"), path);
 		else
 			; /* no output */
 
@@ -1241,11 +1241,11 @@ static int merge_submodule(struct merge_options *o,
 	}
 	if (in_merge_bases(commit_b, commit_a)) {
 		oidcpy(result, a);
-		if (show(o, 3)) {
-			output(o, 3, _("Fast-forwarding submodule %s to the following commit:"), path);
-			output_commit_title(o, commit_a);
-		} else if (show(o, 2))
-			output(o, 2, _("Fast-forwarding submodule %s"), path);
+		if (show(opt, 3)) {
+			output(opt, 3, _("Fast-forwarding submodule %s to the following commit:"), path);
+			output_commit_title(opt, commit_a);
+		} else if (show(opt, 2))
+			output(opt, 2, _("Fast-forwarding submodule %s"), path);
 		else
 			; /* no output */
 
@@ -1264,18 +1264,18 @@ static int merge_submodule(struct merge_options *o,
 		return 0;
 
 	/* find commit which merges them */
-	parent_count = find_first_merges(o->repo, &merges, path,
+	parent_count = find_first_merges(opt->repo, &merges, path,
 					 commit_a, commit_b);
 	switch (parent_count) {
 	case 0:
-		output(o, 1, _("Failed to merge submodule %s (merge following commits not found)"), path);
+		output(opt, 1, _("Failed to merge submodule %s (merge following commits not found)"), path);
 		break;
 
 	case 1:
-		output(o, 1, _("Failed to merge submodule %s (not fast-forward)"), path);
-		output(o, 2, _("Found a possible merge resolution for the submodule:\n"));
+		output(opt, 1, _("Failed to merge submodule %s (not fast-forward)"), path);
+		output(opt, 2, _("Found a possible merge resolution for the submodule:\n"));
 		print_commit((struct commit *) merges.objects[0].item);
-		output(o, 2, _(
+		output(opt, 2, _(
 		       "If this is correct simply add it to the index "
 		       "for example\n"
 		       "by using:\n\n"
@@ -1285,7 +1285,7 @@ static int merge_submodule(struct merge_options *o,
 		break;
 
 	default:
-		output(o, 1, _("Failed to merge submodule %s (multiple merges found)"), path);
+		output(opt, 1, _("Failed to merge submodule %s (multiple merges found)"), path);
 		for (i = 0; i < merges.nr; i++)
 			print_commit((struct commit *) merges.objects[i].item);
 	}
@@ -1294,7 +1294,7 @@ static int merge_submodule(struct merge_options *o,
 	return 0;
 }
 
-static int merge_mode_and_contents(struct merge_options *o,
+static int merge_mode_and_contents(struct merge_options *opt,
 				   const struct diff_filespec *one,
 				   const struct diff_filespec *a,
 				   const struct diff_filespec *b,
@@ -1304,13 +1304,13 @@ static int merge_mode_and_contents(struct merge_options *o,
 				   const int extra_marker_size,
 				   struct merge_file_info *result)
 {
-	if (o->branch1 != branch1) {
+	if (opt->branch1 != branch1) {
 		/*
 		 * It's weird getting a reverse merge with HEAD on the bottom
 		 * side of the conflict markers and the other branch on the
 		 * top.  Fix that.
 		 */
-		return merge_mode_and_contents(o, one, b, a,
+		return merge_mode_and_contents(opt, one, b, a,
 					       filename,
 					       branch2, branch1,
 					       extra_marker_size, result);
@@ -1353,17 +1353,17 @@ static int merge_mode_and_contents(struct merge_options *o,
 			mmbuffer_t result_buf;
 			int ret = 0, merge_status;
 
-			merge_status = merge_3way(o, &result_buf, one, a, b,
+			merge_status = merge_3way(opt, &result_buf, one, a, b,
 						  branch1, branch2,
 						  extra_marker_size);
 
 			if ((merge_status < 0) || !result_buf.ptr)
-				ret = err(o, _("Failed to execute internal merge"));
+				ret = err(opt, _("Failed to execute internal merge"));
 
 			if (!ret &&
 			    write_object_file(result_buf.ptr, result_buf.size,
 					      blob_type, &result->oid))
-				ret = err(o, _("Unable to add %s to database"),
+				ret = err(opt, _("Unable to add %s to database"),
 					  a->path);
 
 			free(result_buf.ptr);
@@ -1371,13 +1371,13 @@ static int merge_mode_and_contents(struct merge_options *o,
 				return ret;
 			result->clean = (merge_status == 0);
 		} else if (S_ISGITLINK(a->mode)) {
-			result->clean = merge_submodule(o, &result->oid,
+			result->clean = merge_submodule(opt, &result->oid,
 							one->path,
 							&one->oid,
 							&a->oid,
 							&b->oid);
 		} else if (S_ISLNK(a->mode)) {
-			switch (o->recursive_variant) {
+			switch (opt->recursive_variant) {
 			case MERGE_RECURSIVE_NORMAL:
 				oidcpy(&result->oid, &a->oid);
 				if (!oid_eq(&a->oid, &b->oid))
@@ -1395,12 +1395,12 @@ static int merge_mode_and_contents(struct merge_options *o,
 	}
 
 	if (result->merge)
-		output(o, 2, _("Auto-merging %s"), filename);
+		output(opt, 2, _("Auto-merging %s"), filename);
 
 	return 0;
 }
 
-static int handle_rename_via_dir(struct merge_options *o,
+static int handle_rename_via_dir(struct merge_options *opt,
 				 struct diff_filepair *pair,
 				 const char *rename_branch)
 {
@@ -1412,10 +1412,10 @@ static int handle_rename_via_dir(struct merge_options *o,
 	 */
 	const struct diff_filespec *dest = pair->two;
 
-	if (!o->call_depth && would_lose_untracked(o, dest->path)) {
-		char *alt_path = unique_path(o, dest->path, rename_branch);
+	if (!opt->call_depth && would_lose_untracked(opt, dest->path)) {
+		char *alt_path = unique_path(opt, dest->path, rename_branch);
 
-		output(o, 1, _("Error: Refusing to lose untracked file at %s; "
+		output(opt, 1, _("Error: Refusing to lose untracked file at %s; "
 			       "writing to %s instead."),
 		       dest->path, alt_path);
 		/*
@@ -1423,21 +1423,21 @@ static int handle_rename_via_dir(struct merge_options *o,
 		 * index.  Instead, write to dest->path for the index but
 		 * only at the higher appropriate stage.
 		 */
-		if (update_file(o, 0, &dest->oid, dest->mode, alt_path))
+		if (update_file(opt, 0, &dest->oid, dest->mode, alt_path))
 			return -1;
 		free(alt_path);
-		return update_stages(o, dest->path, NULL,
-				     rename_branch == o->branch1 ? dest : NULL,
-				     rename_branch == o->branch1 ? NULL : dest);
+		return update_stages(opt, dest->path, NULL,
+				     rename_branch == opt->branch1 ? dest : NULL,
+				     rename_branch == opt->branch1 ? NULL : dest);
 	}
 
 	/* Update dest->path both in index and in worktree */
-	if (update_file(o, 1, &dest->oid, dest->mode, dest->path))
+	if (update_file(opt, 1, &dest->oid, dest->mode, dest->path))
 		return -1;
 	return 0;
 }
 
-static int handle_change_delete(struct merge_options *o,
+static int handle_change_delete(struct merge_options *opt,
 				const char *path, const char *old_path,
 				const struct object_id *o_oid, int o_mode,
 				const struct object_id *changed_oid,
@@ -1450,20 +1450,20 @@ static int handle_change_delete(struct merge_options *o,
 	const char *update_path = path;
 	int ret = 0;
 
-	if (dir_in_way(o->repo->index, path, !o->call_depth, 0) ||
-	    (!o->call_depth && would_lose_untracked(o, path))) {
-		update_path = alt_path = unique_path(o, path, change_branch);
+	if (dir_in_way(opt->repo->index, path, !opt->call_depth, 0) ||
+	    (!opt->call_depth && would_lose_untracked(opt, path))) {
+		update_path = alt_path = unique_path(opt, path, change_branch);
 	}
 
-	if (o->call_depth) {
+	if (opt->call_depth) {
 		/*
 		 * We cannot arbitrarily accept either a_sha or b_sha as
 		 * correct; since there is no true "middle point" between
 		 * them, simply reuse the base version for virtual merge base.
 		 */
-		ret = remove_file_from_index(o->repo->index, path);
+		ret = remove_file_from_index(opt->repo->index, path);
 		if (!ret)
-			ret = update_file(o, 0, o_oid, o_mode, update_path);
+			ret = update_file(opt, 0, o_oid, o_mode, update_path);
 	} else {
 		/*
 		 * Despite the four nearly duplicate messages and argument
@@ -1482,24 +1482,24 @@ static int handle_change_delete(struct merge_options *o,
 		 */
 		if (!alt_path) {
 			if (!old_path) {
-				output(o, 1, _("CONFLICT (%s/delete): %s deleted in %s "
+				output(opt, 1, _("CONFLICT (%s/delete): %s deleted in %s "
 				       "and %s in %s. Version %s of %s left in tree."),
 				       change, path, delete_branch, change_past,
 				       change_branch, change_branch, path);
 			} else {
-				output(o, 1, _("CONFLICT (%s/delete): %s deleted in %s "
+				output(opt, 1, _("CONFLICT (%s/delete): %s deleted in %s "
 				       "and %s to %s in %s. Version %s of %s left in tree."),
 				       change, old_path, delete_branch, change_past, path,
 				       change_branch, change_branch, path);
 			}
 		} else {
 			if (!old_path) {
-				output(o, 1, _("CONFLICT (%s/delete): %s deleted in %s "
+				output(opt, 1, _("CONFLICT (%s/delete): %s deleted in %s "
 				       "and %s in %s. Version %s of %s left in tree at %s."),
 				       change, path, delete_branch, change_past,
 				       change_branch, change_branch, path, alt_path);
 			} else {
-				output(o, 1, _("CONFLICT (%s/delete): %s deleted in %s "
+				output(opt, 1, _("CONFLICT (%s/delete): %s deleted in %s "
 				       "and %s to %s in %s. Version %s of %s left in tree at %s."),
 				       change, old_path, delete_branch, change_past, path,
 				       change_branch, change_branch, path, alt_path);
@@ -1507,19 +1507,19 @@ static int handle_change_delete(struct merge_options *o,
 		}
 		/*
 		 * No need to call update_file() on path when change_branch ==
-		 * o->branch1 && !alt_path, since that would needlessly touch
+		 * opt->branch1 && !alt_path, since that would needlessly touch
 		 * path.  We could call update_file_flags() with update_cache=0
 		 * and update_wd=0, but that's a no-op.
 		 */
-		if (change_branch != o->branch1 || alt_path)
-			ret = update_file(o, 0, changed_oid, changed_mode, update_path);
+		if (change_branch != opt->branch1 || alt_path)
+			ret = update_file(opt, 0, changed_oid, changed_mode, update_path);
 	}
 	free(alt_path);
 
 	return ret;
 }
 
-static int handle_rename_delete(struct merge_options *o,
+static int handle_rename_delete(struct merge_options *opt,
 				struct diff_filepair *pair,
 				const char *rename_branch,
 				const char *delete_branch)
@@ -1527,21 +1527,21 @@ static int handle_rename_delete(struct merge_options *o,
 	const struct diff_filespec *orig = pair->one;
 	const struct diff_filespec *dest = pair->two;
 
-	if (handle_change_delete(o,
-				 o->call_depth ? orig->path : dest->path,
-				 o->call_depth ? NULL : orig->path,
+	if (handle_change_delete(opt,
+				 opt->call_depth ? orig->path : dest->path,
+				 opt->call_depth ? NULL : orig->path,
 				 &orig->oid, orig->mode,
 				 &dest->oid, dest->mode,
 				 rename_branch, delete_branch,
 				 _("rename"), _("renamed")))
 		return -1;
 
-	if (o->call_depth)
-		return remove_file_from_index(o->repo->index, dest->path);
+	if (opt->call_depth)
+		return remove_file_from_index(opt->repo->index, dest->path);
 	else
-		return update_stages(o, dest->path, NULL,
-				     rename_branch == o->branch1 ? dest : NULL,
-				     rename_branch == o->branch1 ? NULL : dest);
+		return update_stages(opt, dest->path, NULL,
+				     rename_branch == opt->branch1 ? dest : NULL,
+				     rename_branch == opt->branch1 ? NULL : dest);
 }
 
 static struct diff_filespec *filespec_from_entry(struct diff_filespec *target,
@@ -1557,7 +1557,7 @@ static struct diff_filespec *filespec_from_entry(struct diff_filespec *target,
 	return target;
 }
 
-static int handle_file_collision(struct merge_options *o,
+static int handle_file_collision(struct merge_options *opt,
 				 const char *collide_path,
 				 const char *prev_path1,
 				 const char *prev_path2,
@@ -1575,11 +1575,11 @@ static int handle_file_collision(struct merge_options *o,
 	/*
 	 * It's easiest to get the correct things into stage 2 and 3, and
 	 * to make sure that the content merge puts HEAD before the other
-	 * branch if we just ensure that branch1 == o->branch1.  So, simply
+	 * branch if we just ensure that branch1 == opt->branch1.  So, simply
 	 * flip arguments around if we don't have that.
 	 */
-	if (branch1 != o->branch1) {
-		return handle_file_collision(o, collide_path,
+	if (branch1 != opt->branch1) {
+		return handle_file_collision(opt, collide_path,
 					     prev_path2, prev_path1,
 					     branch2, branch1,
 					     b_oid, b_mode,
@@ -1589,60 +1589,60 @@ static int handle_file_collision(struct merge_options *o,
 	/*
 	 * In the recursive case, we just opt to undo renames
 	 */
-	if (o->call_depth && (prev_path1 || prev_path2)) {
+	if (opt->call_depth && (prev_path1 || prev_path2)) {
 		/* Put first file (a_oid, a_mode) in its original spot */
 		if (prev_path1) {
-			if (update_file(o, 1, a_oid, a_mode, prev_path1))
+			if (update_file(opt, 1, a_oid, a_mode, prev_path1))
 				return -1;
 		} else {
-			if (update_file(o, 1, a_oid, a_mode, collide_path))
+			if (update_file(opt, 1, a_oid, a_mode, collide_path))
 				return -1;
 		}
 
 		/* Put second file (b_oid, b_mode) in its original spot */
 		if (prev_path2) {
-			if (update_file(o, 1, b_oid, b_mode, prev_path2))
+			if (update_file(opt, 1, b_oid, b_mode, prev_path2))
 				return -1;
 		} else {
-			if (update_file(o, 1, b_oid, b_mode, collide_path))
+			if (update_file(opt, 1, b_oid, b_mode, collide_path))
 				return -1;
 		}
 
 		/* Don't leave something at collision path if unrenaming both */
 		if (prev_path1 && prev_path2)
-			remove_file(o, 1, collide_path, 0);
+			remove_file(opt, 1, collide_path, 0);
 
 		return 0;
 	}
 
 	/* Remove rename sources if rename/add or rename/rename(2to1) */
 	if (prev_path1)
-		remove_file(o, 1, prev_path1,
-			    o->call_depth || would_lose_untracked(o, prev_path1));
+		remove_file(opt, 1, prev_path1,
+			    opt->call_depth || would_lose_untracked(opt, prev_path1));
 	if (prev_path2)
-		remove_file(o, 1, prev_path2,
-			    o->call_depth || would_lose_untracked(o, prev_path2));
+		remove_file(opt, 1, prev_path2,
+			    opt->call_depth || would_lose_untracked(opt, prev_path2));
 
 	/*
 	 * Remove the collision path, if it wouldn't cause dirty contents
 	 * or an untracked file to get lost.  We'll either overwrite with
 	 * merged contents, or just write out to differently named files.
 	 */
-	if (was_dirty(o, collide_path)) {
-		output(o, 1, _("Refusing to lose dirty file at %s"),
+	if (was_dirty(opt, collide_path)) {
+		output(opt, 1, _("Refusing to lose dirty file at %s"),
 		       collide_path);
-		update_path = alt_path = unique_path(o, collide_path, "merged");
-	} else if (would_lose_untracked(o, collide_path)) {
+		update_path = alt_path = unique_path(opt, collide_path, "merged");
+	} else if (would_lose_untracked(opt, collide_path)) {
 		/*
 		 * Only way we get here is if both renames were from
 		 * a directory rename AND user had an untracked file
 		 * at the location where both files end up after the
 		 * two directory renames.  See testcase 10d of t6043.
 		 */
-		output(o, 1, _("Refusing to lose untracked file at "
+		output(opt, 1, _("Refusing to lose untracked file at "
 			       "%s, even though it's in the way."),
 		       collide_path);
-		update_path = alt_path = unique_path(o, collide_path, "merged");
+		update_path = alt_path = unique_path(opt, collide_path, "merged");
 	} else {
 		/*
 		 * FIXME: It's possible that the two files are identical
@@ -1654,7 +1654,7 @@ static int handle_file_collision(struct merge_options *o,
 		 * merge-recursive interoperate anyway, so punting for
 		 * now...
 		 */
-		remove_file(o, 0, collide_path, 0);
+		remove_file(opt, 0, collide_path, 0);
 	}
 
 	/* Store things in diff_filespecs for functions that need it */
@@ -1670,14 +1670,14 @@ static int handle_file_collision(struct merge_options *o,
 	b.mode = b_mode;
 	b.oid_valid = 1;
 
-	if (merge_mode_and_contents(o, &null, &a, &b, collide_path,
-				    branch1, branch2, o->call_depth * 2, &mfi))
+	if (merge_mode_and_contents(opt, &null, &a, &b, collide_path,
+				    branch1, branch2, opt->call_depth * 2, &mfi))
 		return -1;
 	mfi.clean &= !alt_path;
-	if (update_file(o, mfi.clean, &mfi.oid, mfi.mode, update_path))
+	if (update_file(opt, mfi.clean, &mfi.oid, mfi.mode, update_path))
 		return -1;
-	if (!mfi.clean && !o->call_depth &&
-	    update_stages(o, collide_path, NULL, &a, &b))
+	if (!mfi.clean && !opt->call_depth &&
+	    update_stages(opt, collide_path, NULL, &a, &b))
 		return -1;
 	free(alt_path);
 	/*
@@ -1690,7 +1690,7 @@ static int handle_file_collision(struct merge_options *o,
 	return mfi.clean;
 }
 
-static int handle_rename_add(struct merge_options *o,
+static int handle_rename_add(struct merge_options *opt,
 			     struct rename_conflict_info *ci)
 {
 	/* a was renamed to c, and a separate c was added. */
@@ -1700,21 +1700,21 @@ static int handle_rename_add(struct merge_options *o,
 	char *prev_path_desc;
 	struct merge_file_info mfi;
 
-	int other_stage = (ci->branch1 == o->branch1 ? 3 : 2);
+	int other_stage = (ci->branch1 == opt->branch1 ? 3 : 2);
 
-	output(o, 1, _("CONFLICT (rename/add): "
+	output(opt, 1, _("CONFLICT (rename/add): "
 	       "Rename %s->%s in %s.  Added %s in %s"),
 	       a->path, c->path, ci->branch1,
 	       c->path, ci->branch2);
 
 	prev_path_desc = xstrfmt("version of %s from %s", path, a->path);
-	if (merge_mode_and_contents(o, a, c, &ci->ren1_other, prev_path_desc,
-				    o->branch1, o->branch2,
-				    1 + o->call_depth * 2, &mfi))
+	if (merge_mode_and_contents(opt, a, c, &ci->ren1_other, prev_path_desc,
+				    opt->branch1, opt->branch2,
+				    1 + opt->call_depth * 2, &mfi))
 		return -1;
 	free(prev_path_desc);
 
-	return handle_file_collision(o,
+	return handle_file_collision(opt,
 				     c->path, a->path, NULL,
 				     ci->branch1, ci->branch2,
 				     &mfi.oid, mfi.mode,
@@ -1722,20 +1722,20 @@ static int handle_rename_add(struct merge_options *o,
 				     ci->dst_entry1->stages[other_stage].mode);
 }
 
-static char *find_path_for_conflict(struct merge_options *o,
+static char *find_path_for_conflict(struct merge_options *opt,
 				    const char *path,
 				    const char *branch1,
 				    const char *branch2)
 {
 	char *new_path = NULL;
-	if (dir_in_way(o->repo->index, path, !o->call_depth, 0)) {
-		new_path = unique_path(o, path, branch1);
-		output(o, 1, _("%s is a directory in %s adding "
+	if (dir_in_way(opt->repo->index, path, !opt->call_depth, 0)) {
+		new_path = unique_path(opt, path, branch1);
+		output(opt, 1, _("%s is a directory in %s adding "
 			       "as %s instead"),
 		       path, branch2, new_path);
-	} else if (would_lose_untracked(o, path)) {
-		new_path = unique_path(o, path, branch1);
-		output(o, 1, _("Refusing to lose untracked file"
+	} else if (would_lose_untracked(opt, path)) {
+		new_path = unique_path(opt, path, branch1);
+		output(opt, 1, _("Refusing to lose untracked file"
 			       " at %s; adding as %s instead"),
 		       path, new_path);
 	}
@@ -1743,7 +1743,7 @@ static char *find_path_for_conflict(struct merge_options *o,
 	return new_path;
 }
 
-static int handle_rename_rename_1to2(struct merge_options *o,
+static int handle_rename_rename_1to2(struct merge_options *opt,
 				     struct rename_conflict_info *ci)
 {
 	/* One file was renamed in both branches, but to different names. */
@@ -1755,29 +1755,29 @@ static int handle_rename_rename_1to2(struct merge_options *o,
 	struct diff_filespec *b = ci->pair2->two;
 	char *path_desc;
 
-	output(o, 1, _("CONFLICT (rename/rename): "
+	output(opt, 1, _("CONFLICT (rename/rename): "
 	       "Rename \"%s\"->\"%s\" in branch \"%s\" "
 	       "rename \"%s\"->\"%s\" in \"%s\"%s"),
 	       one->path, a->path, ci->branch1,
 	       one->path, b->path, ci->branch2,
-	       o->call_depth ? _(" (left unresolved)") : "");
+	       opt->call_depth ? _(" (left unresolved)") : "");
 
 	path_desc = xstrfmt("%s and %s, both renamed from %s",
 			    a->path, b->path, one->path);
-	if (merge_mode_and_contents(o, one, a, b, path_desc,
+	if (merge_mode_and_contents(opt, one, a, b, path_desc,
 				    ci->branch1, ci->branch2,
-				    o->call_depth * 2, &mfi))
+				    opt->call_depth * 2, &mfi))
 		return -1;
 	free(path_desc);
 
-	if (o->call_depth) {
+	if (opt->call_depth) {
 		/*
 		 * FIXME: For rename/add-source conflicts (if we could detect
 		 * such), this is wrong.  We should instead find a unique
 		 * pathname and then either rename the add-source file to that
 		 * unique path, or use that unique path instead of src here.
 		 */
-		if (update_file(o, 0, &mfi.oid, mfi.mode, one->path))
+		if (update_file(opt, 0, &mfi.oid, mfi.mode, one->path))
 			return -1;
 
 		/*
@@ -1790,18 +1790,18 @@ static int handle_rename_rename_1to2(struct merge_options *o,
 		 */
 		add = filespec_from_entry(&other, ci->dst_entry1, 2 ^ 1);
 		if (add) {
-			if (update_file(o, 0, &add->oid, add->mode, a->path))
+			if (update_file(opt, 0, &add->oid, add->mode, a->path))
 				return -1;
 		}
 		else
-			remove_file_from_index(o->repo->index, a->path);
+			remove_file_from_index(opt->repo->index, a->path);
 		add = filespec_from_entry(&other, ci->dst_entry2, 3 ^ 1);
 		if (add) {
-			if (update_file(o, 0, &add->oid, add->mode, b->path))
+			if (update_file(opt, 0, &add->oid, add->mode, b->path))
 				return -1;
 		}
 		else
-			remove_file_from_index(o->repo->index, b->path);
+			remove_file_from_index(opt->repo->index, b->path);
 	} else {
 		/*
 		 * For each destination path, we need to see if there is a
@@ -1810,39 +1810,39 @@ static int handle_rename_rename_1to2(struct merge_options *o,
 		 */
 		add = filespec_from_entry(&other, ci->dst_entry1, 2 ^ 1);
 		if (add) {
-			if (handle_file_collision(o, a->path,
+			if (handle_file_collision(opt, a->path,
 						  NULL, NULL,
 						  ci->branch1, ci->branch2,
 						  &mfi.oid, mfi.mode,
 						  &add->oid, add->mode) < 0)
 				return -1;
 		} else {
-			char *new_path = find_path_for_conflict(o, a->path,
+			char *new_path = find_path_for_conflict(opt, a->path,
 								ci->branch1,
 								ci->branch2);
-			if (update_file(o, 0, &mfi.oid, mfi.mode, new_path ? new_path : a->path))
+			if (update_file(opt, 0, &mfi.oid, mfi.mode, new_path ? new_path : a->path))
 				return -1;
 			free(new_path);
-			if (update_stages(o, a->path, NULL, a, NULL))
+			if (update_stages(opt, a->path, NULL, a, NULL))
 				return -1;
 		}
 
 		add = filespec_from_entry(&other, ci->dst_entry2, 3 ^ 1);
 		if (add) {
-			if (handle_file_collision(o, b->path,
+			if (handle_file_collision(opt, b->path,
 						  NULL, NULL,
 						  ci->branch1, ci->branch2,
 						  &add->oid, add->mode,
 						  &mfi.oid, mfi.mode) < 0)
 				return -1;
 		} else {
-			char *new_path = find_path_for_conflict(o, b->path,
+			char *new_path = find_path_for_conflict(opt, b->path,
 								ci->branch2,
 								ci->branch1);
-			if (update_file(o, 0, &mfi.oid, mfi.mode, new_path ? new_path : b->path))
+			if (update_file(opt, 0, &mfi.oid, mfi.mode, new_path ? new_path : b->path))
 				return -1;
 			free(new_path);
-			if (update_stages(o, b->path, NULL, NULL, b))
+			if (update_stages(opt, b->path, NULL, NULL, b))
 				return -1;
 		}
 	}
@@ -1850,7 +1850,7 @@ static int handle_rename_rename_1to2(struct merge_options *o,
 	return 0;
 }
 
-static int handle_rename_rename_2to1(struct merge_options *o,
+static int handle_rename_rename_2to1(struct merge_options *opt,
 				     struct rename_conflict_info *ci)
 {
 	/* Two files, a & b, were renamed to the same thing, c. */
@@ -1864,7 +1864,7 @@ static int handle_rename_rename_2to1(struct merge_options *o,
 	struct merge_file_info mfi_c1;
 	struct merge_file_info mfi_c2;
 
-	output(o, 1, _("CONFLICT (rename/rename): "
+	output(opt, 1, _("CONFLICT (rename/rename): "
 	       "Rename %s->%s in %s. "
 	       "Rename %s->%s in %s"),
 	       a->path, c1->path, ci->branch1,
@@ -1872,17 +1872,17 @@ static int handle_rename_rename_2to1(struct merge_options *o,
 
 	path_side_1_desc = xstrfmt("version of %s from %s", path, a->path);
 	path_side_2_desc = xstrfmt("version of %s from %s", path, b->path);
-	if (merge_mode_and_contents(o, a, c1, &ci->ren1_other, path_side_1_desc,
-				    o->branch1, o->branch2,
-				    1 + o->call_depth * 2, &mfi_c1) ||
-	    merge_mode_and_contents(o, b, &ci->ren2_other, c2, path_side_2_desc,
-				    o->branch1, o->branch2,
-				    1 + o->call_depth * 2, &mfi_c2))
+	if (merge_mode_and_contents(opt, a, c1, &ci->ren1_other, path_side_1_desc,
+				    opt->branch1, opt->branch2,
+				    1 + opt->call_depth * 2, &mfi_c1) ||
+	    merge_mode_and_contents(opt, b, &ci->ren2_other, c2, path_side_2_desc,
+				    opt->branch1, opt->branch2,
+				    1 + opt->call_depth * 2, &mfi_c2))
 		return -1;
 	free(path_side_1_desc);
 	free(path_side_2_desc);
 
-	return handle_file_collision(o, path, a->path, b->path,
+	return handle_file_collision(opt, path, a->path, b->path,
 				     ci->branch1, ci->branch2,
 				     &mfi_c1.oid, mfi_c1.mode,
 				     &mfi_c2.oid, mfi_c2.mode);
@@ -1891,17 +1891,17 @@ static int handle_rename_rename_2to1(struct merge_options *o,
 /*
  * Get the diff_filepairs changed between o_tree and tree.
  */
-static struct diff_queue_struct *get_diffpairs(struct merge_options *o,
+static struct diff_queue_struct *get_diffpairs(struct merge_options *opt,
 					       struct tree *o_tree,
 					       struct tree *tree)
 {
 	struct diff_queue_struct *ret;
 	struct diff_options opts;
 
-	repo_diff_setup(o->repo, &opts);
+	repo_diff_setup(opt->repo, &opts);
 	opts.flags.recursive = 1;
 	opts.flags.rename_empty = 0;
-	opts.detect_rename = merge_detect_rename(o);
+	opts.detect_rename = merge_detect_rename(opt);
 	/*
 	 * We do not have logic to handle the detection of copies.  In
 	 * fact, it may not even make sense to add such logic: would we
@@ -1910,17 +1910,17 @@ static struct diff_queue_struct *get_diffpairs(struct merge_options *o,
 	 */
 	if (opts.detect_rename > DIFF_DETECT_RENAME)
 		opts.detect_rename = DIFF_DETECT_RENAME;
-	opts.rename_limit = o->merge_rename_limit >= 0 ? o->merge_rename_limit :
-			    o->diff_rename_limit >= 0 ? o->diff_rename_limit :
+	opts.rename_limit = opt->merge_rename_limit >= 0 ? opt->merge_rename_limit :
+			    opt->diff_rename_limit >= 0 ? opt->diff_rename_limit :
 			    1000;
-	opts.rename_score = o->rename_score;
-	opts.show_rename_progress = o->show_rename_progress;
+	opts.rename_score = opt->rename_score;
+	opts.show_rename_progress = opt->show_rename_progress;
 	opts.output_format = DIFF_FORMAT_NO_OUTPUT;
 	diff_setup_done(&opts);
 	diff_tree_oid(&o_tree->object.oid, &tree->object.oid, "", &opts);
 	diffcore_std(&opts);
-	if (opts.needed_rename_limit > o->needed_rename_limit)
-		o->needed_rename_limit = opts.needed_rename_limit;
+	if (opts.needed_rename_limit > opt->needed_rename_limit)
+		opt->needed_rename_limit = opts.needed_rename_limit;
 
 	ret = xmalloc(sizeof(*ret));
 	*ret = diff_queued_diff;
@@ -2039,7 +2039,7 @@ static void remove_hashmap_entries(struct hashmap *dir_renames,
  * level conflicts for the renamed location.  If there is a rename and
  * there are no conflicts, return the new name.  Otherwise, return NULL.
  */
-static char *handle_path_level_conflicts(struct merge_options *o,
+static char *handle_path_level_conflicts(struct merge_options *opt,
 					 const char *path,
 					 struct dir_rename_entry *entry,
 					 struct hashmap *collisions,
@@ -2060,7 +2060,7 @@ static char *handle_path_level_conflicts(struct merge_options *o,
 		/* This should only happen when entry->non_unique_new_dir set */
 		if (!entry->non_unique_new_dir)
 			BUG("entry->non_unqiue_dir not set and !new_path");
-		output(o, 1, _("CONFLICT (directory rename split): "
+		output(opt, 1, _("CONFLICT (directory rename split): "
 			       "Unclear where to place %s because directory "
 			       "%s was renamed to multiple other directories, "
 			       "with no destination getting a majority of the "
@@ -2092,7 +2092,7 @@ static char *handle_path_level_conflicts(struct merge_options *o,
 		collision_ent->reported_already = 1;
 		strbuf_add_separated_string_list(&collision_paths, ", ",
 						 &collision_ent->source_files);
-		output(o, 1, _("CONFLICT (implicit dir rename): Existing "
+		output(opt, 1, _("CONFLICT (implicit dir rename): Existing "
 			       "file/dir at %s in the way of implicit "
 			       "directory rename(s) putting the following "
 			       "path(s) there: %s."),
@@ -2102,7 +2102,7 @@ static char *handle_path_level_conflicts(struct merge_options *o,
 		collision_ent->reported_already = 1;
 		strbuf_add_separated_string_list(&collision_paths, ", ",
 						 &collision_ent->source_files);
-		output(o, 1, _("CONFLICT (implicit dir rename): Cannot map "
+		output(opt, 1, _("CONFLICT (implicit dir rename): Cannot map "
 			       "more than one path to %s; implicit directory "
 			       "renames tried to put these paths there: %s"),
 		       new_path, collision_paths.buf);
@@ -2139,7 +2139,7 @@ static char *handle_path_level_conflicts(struct merge_options *o,
  *         causes conflicts for files within those merged directories, then
  *         that should be detected at the individual path level.
  */
-static void handle_directory_level_conflicts(struct merge_options *o,
+static void handle_directory_level_conflicts(struct merge_options *opt,
 					     struct hashmap *dir_re_head,
 					     struct tree *head,
 					     struct hashmap *dir_re_merge,
@@ -2194,11 +2194,11 @@ static void handle_directory_level_conflicts(struct merge_options *o,
 			 * know that head_ent->new_dir and merge_ent->new_dir
 			 * are different strings.
 			 */
-			output(o, 1, _("CONFLICT (rename/rename): "
+			output(opt, 1, _("CONFLICT (rename/rename): "
 				       "Rename directory %s->%s in %s. "
 				       "Rename directory %s->%s in %s"),
-			       head_ent->dir, head_ent->new_dir.buf, o->branch1,
-			       head_ent->dir, merge_ent->new_dir.buf, o->branch2);
+			       head_ent->dir, head_ent->new_dir.buf, opt->branch1,
+			       head_ent->dir, merge_ent->new_dir.buf, opt->branch2);
 			string_list_append(&remove_from_head,
 					   head_ent->dir)->util = head_ent;
 			strbuf_release(&head_ent->new_dir);
@@ -2397,7 +2397,7 @@ static void compute_collisions(struct hashmap *collisions,
 	}
 }
 
-static char *check_for_directory_rename(struct merge_options *o,
+static char *check_for_directory_rename(struct merge_options *opt,
 					const char *path,
 					struct tree *tree,
 					struct hashmap *dir_renames,
@@ -2438,11 +2438,11 @@ static char *check_for_directory_rename(struct merge_options *o,
 	 */
 	oentry = dir_rename_find_entry(dir_rename_exclusions, entry->new_dir.buf);
 	if (oentry) {
-		output(o, 1, _("WARNING: Avoiding applying %s -> %s rename "
+		output(opt, 1, _("WARNING: Avoiding applying %s -> %s rename "
 			       "to %s, because %s itself was renamed."),
 		       entry->dir, entry->new_dir.buf, path, entry->new_dir.buf);
 	} else {
-		new_path = handle_path_level_conflicts(o, path, entry,
+		new_path = handle_path_level_conflicts(opt, path, entry,
 						       collisions, tree);
 		*clean_merge &= (new_path != NULL);
 	}
@@ -2450,7 +2450,7 @@ static char *check_for_directory_rename(struct merge_options *o,
 	return new_path;
 }
 
-static void apply_directory_rename_modifications(struct merge_options *o,
+static void apply_directory_rename_modifications(struct merge_options *opt,
 						 struct diff_filepair *pair,
 						 char *new_path,
 						 struct rename *re,
@@ -2473,11 +2473,11 @@ static void apply_directory_rename_modifications(struct merge_options *o,
 	 * saying the file would have been overwritten), but it might
 	 * be dirty, though.
 	 */
-	update_wd = !was_dirty(o, pair->two->path);
+	update_wd = !was_dirty(opt, pair->two->path);
 	if (!update_wd)
-		output(o, 1, _("Refusing to lose dirty file at %s"),
+		output(opt, 1, _("Refusing to lose dirty file at %s"),
 		       pair->two->path);
-	remove_file(o, 1, pair->two->path, !update_wd);
+	remove_file(opt, 1, pair->two->path, !update_wd);
 
 	/* Find or create a new re->dst_entry */
 	item = string_list_lookup(entries, new_path);
@@ -2566,7 +2566,7 @@ static void apply_directory_rename_modifications(struct merge_options *o,
  * to be able to associate the correct cache entries with the rename
  * information; tree is always equal to either a_tree or b_tree.
  */
-static struct string_list *get_renames(struct merge_options *o,
+static struct string_list *get_renames(struct merge_options *opt,
 				       struct diff_queue_struct *pairs,
 				       struct hashmap *dir_renames,
 				       struct hashmap *dir_rename_exclusions,
@@ -2596,7 +2596,7 @@ static struct string_list *get_renames(struct merge_options *o,
 			diff_free_filepair(pair);
 			continue;
 		}
-		new_path = check_for_directory_rename(o, pair->two->path, tree,
+		new_path = check_for_directory_rename(opt, pair->two->path, tree,
 						      dir_renames,
 						      dir_rename_exclusions,
 						      &collisions,
@@ -2626,7 +2626,7 @@ static struct string_list *get_renames(struct merge_options *o,
 		item = string_list_insert(renames, pair->one->path);
 		item->util = re;
 		if (new_path)
-			apply_directory_rename_modifications(o, pair, new_path,
+			apply_directory_rename_modifications(opt, pair, new_path,
 							     re, tree, o_tree,
 							     a_tree, b_tree,
 							     entries);
@@ -2641,7 +2641,7 @@ static struct string_list *get_renames(struct merge_options *o,
 	return renames;
 }
 
-static int process_renames(struct merge_options *o,
+static int process_renames(struct merge_options *opt,
 			   struct string_list *a_renames,
 			   struct string_list *b_renames)
 {
@@ -2685,13 +2685,13 @@ static int process_renames(struct merge_options *o,
 		if (ren1) {
 			renames1 = a_renames;
 			renames2Dst = &b_by_dst;
-			branch1 = o->branch1;
-			branch2 = o->branch2;
+			branch1 = opt->branch1;
+			branch2 = opt->branch2;
 		} else {
 			renames1 = b_renames;
 			renames2Dst = &a_by_dst;
-			branch1 = o->branch2;
-			branch2 = o->branch1;
+			branch1 = opt->branch2;
+			branch2 = opt->branch1;
 			SWAP(ren2, ren1);
 		}
 
@@ -2725,7 +2725,7 @@ static int process_renames(struct merge_options *o,
 				 * the base stage (think of rename +
 				 * add-source cases).
 				 */
-				remove_file(o, 1, ren1_src, 1);
+				remove_file(opt, 1, ren1_src, 1);
 				update_entry(ren1->dst_entry,
 					     ren1->pair->one,
 					     ren1->pair->two,
@@ -2738,7 +2738,7 @@ static int process_renames(struct merge_options *o,
 						   branch2,
 						   ren1->dst_entry,
 						   ren2->dst_entry,
-						   o,
+						   opt,
 						   NULL,
 						   NULL);
 		} else if ((lookup = string_list_lookup(renames2Dst, ren1_dst))) {
@@ -2765,7 +2765,7 @@ static int process_renames(struct merge_options *o,
 						   branch2,
 						   ren1->dst_entry,
 						   ren2->dst_entry,
-						   o,
+						   opt,
 						   ren1->src_entry,
 						   ren2->src_entry);
 
@@ -2788,8 +2788,8 @@ static int process_renames(struct merge_options *o,
 			 * stage and in other_stage (think of rename +
 			 * add-source case).
 			 */
-			remove_file(o, 1, ren1_src,
-				    renamed_stage == 2 || !was_tracked(o, ren1_src));
+			remove_file(opt, 1, ren1_src,
+				    renamed_stage == 2 || !was_tracked(opt, ren1_src));
 
 			oidcpy(&src_other.oid,
 			       &ren1->src_entry->stages[other_stage].oid);
@@ -2808,7 +2808,7 @@ static int process_renames(struct merge_options *o,
 							   branch2,
 							   ren1->dst_entry,
 							   NULL,
-							   o,
+							   opt,
 							   NULL,
 							   NULL);
 			} else if (oid_eq(&src_other.oid, &null_oid)) {
@@ -2819,7 +2819,7 @@ static int process_renames(struct merge_options *o,
 							   branch2,
 							   ren1->dst_entry,
 							   NULL,
-							   o,
+							   opt,
 							   NULL,
 							   NULL);
 			} else if ((dst_other.mode == ren1->pair->two->mode) &&
@@ -2832,7 +2832,7 @@ static int process_renames(struct merge_options *o,
 				 * update_file_flags() instead of
 				 * update_file().
 				 */
-				if (update_file_flags(o,
+				if (update_file_flags(opt,
 						      &ren1->pair->two->oid,
 						      ren1->pair->two->mode,
 						      ren1_dst,
@@ -2854,7 +2854,7 @@ static int process_renames(struct merge_options *o,
 							   branch2,
 							   ren1->dst_entry,
 							   NULL,
-							   o,
+							   opt,
 							   ren1->src_entry,
 							   NULL);
 			} else
@@ -2882,7 +2882,7 @@ static int process_renames(struct merge_options *o,
 							   NULL,
 							   ren1->dst_entry,
 							   NULL,
-							   o,
+							   opt,
 							   NULL,
 							   NULL);
 			}
@@ -2919,7 +2919,7 @@ static void initial_cleanup_rename(struct diff_queue_struct *pairs,
 	free(pairs);
 }
 
-static int detect_and_process_renames(struct merge_options *o,
+static int detect_and_process_renames(struct merge_options *opt,
 				      struct tree *common,
 				      struct tree *head,
 				      struct tree *merge,
@@ -2933,17 +2933,17 @@ static int detect_and_process_renames(struct merge_options *o,
 	ri->head_renames = NULL;
 	ri->merge_renames = NULL;
 
-	if (!merge_detect_rename(o))
+	if (!merge_detect_rename(opt))
 		return 1;
 
-	head_pairs = get_diffpairs(o, common, head);
-	merge_pairs = get_diffpairs(o, common, merge);
+	head_pairs = get_diffpairs(opt, common, head);
+	merge_pairs = get_diffpairs(opt, common, merge);
 
-	if (o->detect_directory_renames) {
+	if (opt->detect_directory_renames) {
 		dir_re_head = get_directory_renames(head_pairs);
 		dir_re_merge = get_directory_renames(merge_pairs);
 
-		handle_directory_level_conflicts(o,
+		handle_directory_level_conflicts(opt,
 						 dir_re_head, head,
 						 dir_re_merge, merge);
 	} else {
@@ -2953,19 +2953,19 @@ static int detect_and_process_renames(struct merge_options *o,
 		dir_rename_init(dir_re_merge);
 	}
 
-	ri->head_renames  = get_renames(o, head_pairs,
+	ri->head_renames  = get_renames(opt, head_pairs,
 					dir_re_merge, dir_re_head, head,
 					common, head, merge, entries,
 					&clean);
 	if (clean < 0)
 		goto cleanup;
-	ri->merge_renames = get_renames(o, merge_pairs,
+	ri->merge_renames = get_renames(opt, merge_pairs,
 					dir_re_head, dir_re_merge, merge,
 					common, head, merge, entries,
 					&clean);
 	if (clean < 0)
 		goto cleanup;
-	clean &= process_renames(o, ri->head_renames, ri->merge_renames);
+	clean &= process_renames(opt, ri->head_renames, ri->merge_renames);
 
 cleanup:
 	/*
@@ -3006,7 +3006,7 @@ static struct object_id *stage_oid(const struct object_id *oid, unsigned mode)
 	return (is_null_oid(oid) || mode == 0) ? NULL: (struct object_id *)oid;
 }
 
-static int read_oid_strbuf(struct merge_options *o,
+static int read_oid_strbuf(struct merge_options *opt,
 			   const struct object_id *oid,
 			   struct strbuf *dst)
 {
@@ -3015,10 +3015,10 @@ static int read_oid_strbuf(struct merge_options *o,
 	unsigned long size;
 	buf = read_object_file(oid, &type, &size);
 	if (!buf)
-		return err(o, _("cannot read object %s"), oid_to_hex(oid));
+		return err(opt, _("cannot read object %s"), oid_to_hex(oid));
 	if (type != OBJ_BLOB) {
 		free(buf);
-		return err(o, _("object %s is not a blob"), oid_to_hex(oid));
+		return err(opt, _("object %s is not a blob"), oid_to_hex(oid));
 	}
 	strbuf_attach(dst, buf, size, size + 1);
 	return 0;
@@ -3060,7 +3060,7 @@ static int blob_unchanged(struct merge_options *opt,
 	return ret;
 }
 
-static int handle_modify_delete(struct merge_options *o,
+static int handle_modify_delete(struct merge_options *opt,
 				const char *path,
 				struct object_id *o_oid, int o_mode,
 				struct object_id *a_oid, int a_mode,
@@ -3071,18 +3071,18 @@ static int handle_modify_delete(struct merge_options *o,
 	int changed_mode;
 
 	if (a_oid) {
-		modify_branch = o->branch1;
-		delete_branch = o->branch2;
+		modify_branch = opt->branch1;
+		delete_branch = opt->branch2;
 		changed_oid = a_oid;
 		changed_mode = a_mode;
 	} else {
-		modify_branch = o->branch2;
-		delete_branch = o->branch1;
+		modify_branch = opt->branch2;
+		delete_branch = opt->branch1;
 		changed_oid = b_oid;
 		changed_mode = b_mode;
 	}
 
-	return handle_change_delete(o,
+	return handle_change_delete(opt,
 				    path, NULL,
 				    o_oid, o_mode,
 				    changed_oid, changed_mode,
@@ -3090,7 +3090,7 @@ static int handle_modify_delete(struct merge_options *o,
 				    _("modify"), _("modified"));
 }
 
-static int handle_content_merge(struct merge_options *o,
+static int handle_content_merge(struct merge_options *opt,
 				const char *path,
 				int is_dirty,
 				struct object_id *o_oid, int o_mode,
@@ -3119,26 +3119,26 @@ static int handle_content_merge(struct merge_options *o,
 	if (rename_conflict_info) {
 		struct diff_filepair *pair1 = rename_conflict_info->pair1;
 
-		path1 = (o->branch1 == rename_conflict_info->branch1) ?
+		path1 = (opt->branch1 == rename_conflict_info->branch1) ?
 			pair1->two->path : pair1->one->path;
 		/* If rename_conflict_info->pair2 != NULL, we are in
 		 * RENAME_ONE_FILE_TO_ONE case.  Otherwise, we have a
 		 * normal rename.
 		 */
 		path2 = (rename_conflict_info->pair2 ||
-			 o->branch2 == rename_conflict_info->branch1) ?
+			 opt->branch2 == rename_conflict_info->branch1) ?
 			pair1->two->path : pair1->one->path;
 		one.path = pair1->one->path;
 		a.path = (char *)path1;
 		b.path = (char *)path2;
 
-		if (dir_in_way(o->repo->index, path, !o->call_depth,
+		if (dir_in_way(opt->repo->index, path, !opt->call_depth,
 			       S_ISGITLINK(pair1->two->mode)))
 			df_conflict_remains = 1;
 	}
-	if (merge_mode_and_contents(o, &one, &a, &b, path,
-				    o->branch1, o->branch2,
-				    o->call_depth * 2, &mfi))
+	if (merge_mode_and_contents(opt, &one, &a, &b, path,
+				    opt->branch1, opt->branch2,
+				    opt->call_depth * 2, &mfi))
 		return -1;
 
 	/*
@@ -3148,14 +3148,14 @@ static int handle_content_merge(struct merge_options *o,
 	 *   c) The target path is usable (i.e. not involved in D/F conflict)
 	 */
 	if (mfi.clean &&
-	    was_tracked_and_matches(o, path, &mfi.oid, mfi.mode) &&
+	    was_tracked_and_matches(opt, path, &mfi.oid, mfi.mode) &&
 	    !df_conflict_remains) {
 		int pos;
 		struct cache_entry *ce;
 
-		output(o, 3, _("Skipped %s (merged same as existing)"), path);
-		if (add_cacheinfo(o, mfi.mode, &mfi.oid, path,
-				  0, (!o->call_depth && !is_dirty), 0))
+		output(opt, 3, _("Skipped %s (merged same as existing)"), path);
+		if (add_cacheinfo(opt, mfi.mode, &mfi.oid, path,
+				  0, (!opt->call_depth && !is_dirty), 0))
 			return -1;
 		/*
 		 * However, add_cacheinfo() will delete the old cache entry
@@ -3163,11 +3163,11 @@ static int handle_content_merge(struct merge_options *o,
 		 * flag to avoid making the file appear as if it were
 		 * deleted by the user.
 		 */
-		pos = index_name_pos(&o->orig_index, path, strlen(path));
-		ce = o->orig_index.cache[pos];
+		pos = index_name_pos(&opt->orig_index, path, strlen(path));
+		ce = opt->orig_index.cache[pos];
 		if (ce_skip_worktree(ce)) {
-			pos = index_name_pos(o->repo->index, path, strlen(path));
-			ce = o->repo->index->cache[pos];
+			pos = index_name_pos(opt->repo->index, path, strlen(path));
+			ce = opt->repo->index->cache[pos];
 			ce->ce_flags |= CE_SKIP_WORKTREE;
 		}
 		return mfi.clean;
@@ -3176,52 +3176,52 @@ static int handle_content_merge(struct merge_options *o,
 	if (!mfi.clean) {
 		if (S_ISGITLINK(mfi.mode))
 			reason = _("submodule");
-		output(o, 1, _("CONFLICT (%s): Merge conflict in %s"),
+		output(opt, 1, _("CONFLICT (%s): Merge conflict in %s"),
 				reason, path);
 		if (rename_conflict_info && !df_conflict_remains)
-			if (update_stages(o, path, &one, &a, &b))
+			if (update_stages(opt, path, &one, &a, &b))
 				return -1;
 	}
 
 	if (df_conflict_remains || is_dirty) {
 		char *new_path;
-		if (o->call_depth) {
-			remove_file_from_index(o->repo->index, path);
+		if (opt->call_depth) {
+			remove_file_from_index(opt->repo->index, path);
 		} else {
 			if (!mfi.clean) {
-				if (update_stages(o, path, &one, &a, &b))
+				if (update_stages(opt, path, &one, &a, &b))
 					return -1;
 			} else {
-				int file_from_stage2 = was_tracked(o, path);
+				int file_from_stage2 = was_tracked(opt, path);
 				struct diff_filespec merged;
 				oidcpy(&merged.oid, &mfi.oid);
 				merged.mode = mfi.mode;
 
-				if (update_stages(o, path, NULL,
+				if (update_stages(opt, path, NULL,
 						  file_from_stage2 ? &merged : NULL,
 						  file_from_stage2 ? NULL : &merged))
 					return -1;
 			}
 
 		}
-		new_path = unique_path(o, path, rename_conflict_info->branch1);
+		new_path = unique_path(opt, path, rename_conflict_info->branch1);
 		if (is_dirty) {
-			output(o, 1, _("Refusing to lose dirty file at %s"),
+			output(opt, 1, _("Refusing to lose dirty file at %s"),
 			       path);
 		}
-		output(o, 1, _("Adding as %s instead"), new_path);
-		if (update_file(o, 0, &mfi.oid, mfi.mode, new_path)) {
+		output(opt, 1, _("Adding as %s instead"), new_path);
+		if (update_file(opt, 0, &mfi.oid, mfi.mode, new_path)) {
 			free(new_path);
 			return -1;
 		}
 		free(new_path);
 		mfi.clean = 0;
-	} else if (update_file(o, mfi.clean, &mfi.oid, mfi.mode, path))
+	} else if (update_file(opt, mfi.clean, &mfi.oid, mfi.mode, path))
 		return -1;
 	return !is_dirty && mfi.clean;
 }
 
-static int handle_rename_normal(struct merge_options *o,
+static int handle_rename_normal(struct merge_options *opt,
 				const char *path,
 				struct object_id *o_oid, unsigned int o_mode,
 				struct object_id *a_oid, unsigned int a_mode,
@@ -3229,17 +3229,17 @@ static int handle_rename_normal(struct merge_options *o,
 				struct rename_conflict_info *ci)
 {
 	/* Merge the content and write it out */
-	return handle_content_merge(o, path, was_dirty(o, path),
+	return handle_content_merge(opt, path, was_dirty(opt, path),
 				    o_oid, o_mode, a_oid, a_mode, b_oid, b_mode,
 				    ci);
 }
 
 /* Per entry merge function */
-static int process_entry(struct merge_options *o,
+static int process_entry(struct merge_options *opt,
 			 const char *path, struct stage_data *entry)
 {
 	int clean_merge = 1;
-	int normalize = o->renormalize;
+	int normalize = opt->renormalize;
 	unsigned o_mode = entry->stages[1].mode;
 	unsigned a_mode = entry->stages[2].mode;
 	unsigned b_mode = entry->stages[3].mode;
@@ -3253,7 +3253,7 @@ static int process_entry(struct merge_options *o,
 		switch (conflict_info->rename_type) {
 		case RENAME_NORMAL:
 		case RENAME_ONE_FILE_TO_ONE:
-			clean_merge = handle_rename_normal(o,
+			clean_merge = handle_rename_normal(opt,
 							   path,
 							   o_oid, o_mode,
 							   a_oid, a_mode,
@@ -3262,7 +3262,7 @@ static int process_entry(struct merge_options *o,
 			break;
 		case RENAME_VIA_DIR:
 			clean_merge = 1;
-			if (handle_rename_via_dir(o,
+			if (handle_rename_via_dir(opt,
 						  conflict_info->pair1,
 						  conflict_info->branch1))
 				clean_merge = -1;
@@ -3274,11 +3274,11 @@ static int process_entry(struct merge_options *o,
 			 * two-way merged cleanly with the added file, I
 			 * guess it's a clean merge?
 			 */
-			clean_merge = handle_rename_add(o, conflict_info);
+			clean_merge = handle_rename_add(opt, conflict_info);
 			break;
 		case RENAME_DELETE:
 			clean_merge = 0;
-			if (handle_rename_delete(o,
+			if (handle_rename_delete(opt,
 						 conflict_info->pair1,
 						 conflict_info->branch1,
 						 conflict_info->branch2))
@@ -3286,7 +3286,7 @@ static int process_entry(struct merge_options *o,
 			break;
 		case RENAME_ONE_FILE_TO_TWO:
 			clean_merge = 0;
-			if (handle_rename_rename_1to2(o, conflict_info))
+			if (handle_rename_rename_1to2(opt, conflict_info))
 				clean_merge = -1;
 			break;
 		case RENAME_TWO_FILES_TO_ONE:
@@ -3296,7 +3296,7 @@ static int process_entry(struct merge_options *o,
 			 * can then be two-way merged cleanly, I guess it's
 			 * a clean merge?
 			 */
-			clean_merge = handle_rename_rename_2to1(o,
+			clean_merge = handle_rename_rename_2to1(opt,
 								conflict_info);
 			break;
 		default:
@@ -3306,18 +3306,18 @@ static int process_entry(struct merge_options *o,
 	} else if (o_oid && (!a_oid || !b_oid)) {
 		/* Case A: Deleted in one */
 		if ((!a_oid && !b_oid) ||
-		    (!b_oid && blob_unchanged(o, o_oid, o_mode, a_oid, a_mode, normalize, path)) ||
-		    (!a_oid && blob_unchanged(o, o_oid, o_mode, b_oid, b_mode, normalize, path))) {
+		    (!b_oid && blob_unchanged(opt, o_oid, o_mode, a_oid, a_mode, normalize, path)) ||
+		    (!a_oid && blob_unchanged(opt, o_oid, o_mode, b_oid, b_mode, normalize, path))) {
 			/* Deleted in both or deleted in one and
 			 * unchanged in the other */
 			if (a_oid)
-				output(o, 2, _("Removing %s"), path);
+				output(opt, 2, _("Removing %s"), path);
 			/* do not touch working file if it did not exist */
-			remove_file(o, 1, path, !a_oid);
+			remove_file(opt, 1, path, !a_oid);
 		} else {
 			/* Modify/delete; deleted side may have put a directory in the way */
 			clean_merge = 0;
-			if (handle_modify_delete(o, path, o_oid, o_mode,
+			if (handle_modify_delete(opt, path, o_oid, o_mode,
 						 a_oid, a_mode, b_oid, b_mode))
 				clean_merge = -1;
 		}
@@ -3333,53 +3333,53 @@ static int process_entry(struct merge_options *o,
 		const char *conf;
 
 		if (a_oid) {
-			add_branch = o->branch1;
-			other_branch = o->branch2;
+			add_branch = opt->branch1;
+			other_branch = opt->branch2;
 			mode = a_mode;
 			oid = a_oid;
 			conf = _("file/directory");
 		} else {
-			add_branch = o->branch2;
-			other_branch = o->branch1;
+			add_branch = opt->branch2;
+			other_branch = opt->branch1;
 			mode = b_mode;
 			oid = b_oid;
 			conf = _("directory/file");
 		}
-		if (dir_in_way(o->repo->index, path,
-			       !o->call_depth && !S_ISGITLINK(a_mode),
+		if (dir_in_way(opt->repo->index, path,
+			       !opt->call_depth && !S_ISGITLINK(a_mode),
 			       0)) {
-			char *new_path = unique_path(o, path, add_branch);
+			char *new_path = unique_path(opt, path, add_branch);
 			clean_merge = 0;
-			output(o, 1, _("CONFLICT (%s): There is a directory with name %s in %s. "
+			output(opt, 1, _("CONFLICT (%s): There is a directory with name %s in %s. "
 			       "Adding %s as %s"),
 			       conf, path, other_branch, path, new_path);
-			if (update_file(o, 0, oid, mode, new_path))
+			if (update_file(opt, 0, oid, mode, new_path))
 				clean_merge = -1;
-			else if (o->call_depth)
-				remove_file_from_index(o->repo->index, path);
+			else if (opt->call_depth)
+				remove_file_from_index(opt->repo->index, path);
 			free(new_path);
 		} else {
-			output(o, 2, _("Adding %s"), path);
+			output(opt, 2, _("Adding %s"), path);
 			/* do not overwrite file if already present */
-			if (update_file_flags(o, oid, mode, path, 1, !a_oid))
+			if (update_file_flags(opt, oid, mode, path, 1, !a_oid))
 				clean_merge = -1;
 		}
 	} else if (a_oid && b_oid) {
 		if (!o_oid) {
 			/* Case C: Added in both (check for same permissions) */
-			output(o, 1,
+			output(opt, 1,
 			       _("CONFLICT (add/add): Merge conflict in %s"),
 			       path);
-			clean_merge = handle_file_collision(o,
+			clean_merge = handle_file_collision(opt,
 							    path, NULL, NULL,
-							    o->branch1,
-							    o->branch2,
+							    opt->branch1,
+							    opt->branch2,
 							    a_oid, a_mode,
 							    b_oid, b_mode);
 		} else {
 			/* case D: Modified in both, but differently. */
 			int is_dirty = 0; /* unpack_trees would have bailed if dirty */
-			clean_merge = handle_content_merge(o, path,
+			clean_merge = handle_content_merge(opt, path,
 							   is_dirty,
 							   o_oid, o_mode,
 							   a_oid, a_mode,
@@ -3391,48 +3391,48 @@ static int process_entry(struct merge_options *o,
 		 * this entry was deleted altogether. a_mode == 0 means
 		 * we had that path and want to actively remove it.
 		 */
-		remove_file(o, 1, path, !a_mode);
+		remove_file(opt, 1, path, !a_mode);
 	} else
 		BUG("fatal merge failure, shouldn't happen.");
 
 	return clean_merge;
 }
 
-int merge_trees(struct merge_options *o,
+int merge_trees(struct merge_options *opt,
 		struct tree *head,
 		struct tree *merge,
 		struct tree *common,
 		struct tree **result)
 {
-	struct index_state *istate = o->repo->index;
+	struct index_state *istate = opt->repo->index;
 	int code, clean;
 	struct strbuf sb = STRBUF_INIT;
 
-	if (!o->call_depth && repo_index_has_changes(o->repo, head, &sb)) {
-		err(o, _("Your local changes to the following files would be overwritten by merge:\n  %s"),
+	if (!opt->call_depth && repo_index_has_changes(opt->repo, head, &sb)) {
+		err(opt, _("Your local changes to the following files would be overwritten by merge:\n  %s"),
 		    sb.buf);
 		return -1;
 	}
 
-	if (o->subtree_shift) {
-		merge = shift_tree_object(o->repo, head, merge, o->subtree_shift);
-		common = shift_tree_object(o->repo, head, common, o->subtree_shift);
+	if (opt->subtree_shift) {
+		merge = shift_tree_object(opt->repo, head, merge, opt->subtree_shift);
+		common = shift_tree_object(opt->repo, head, common, opt->subtree_shift);
 	}
 
 	if (oid_eq(&common->object.oid, &merge->object.oid)) {
-		output(o, 0, _("Already up to date!"));
+		output(opt, 0, _("Already up to date!"));
 		*result = head;
 		return 1;
 	}
 
-	code = unpack_trees_start(o, common, head, merge);
+	code = unpack_trees_start(opt, common, head, merge);
 
 	if (code != 0) {
-		if (show(o, 4) || o->call_depth)
-			err(o, _("merging of trees %s and %s failed"),
+		if (show(opt, 4) || opt->call_depth)
+			err(opt, _("merging of trees %s and %s failed"),
 			    oid_to_hex(&head->object.oid),
 			    oid_to_hex(&merge->object.oid));
-		unpack_trees_finish(o);
+		unpack_trees_finish(opt);
 		return -1;
 	}
 
@@ -3447,21 +3447,21 @@ int merge_trees(struct merge_options *o,
 		 * opposed to decaring a local hashmap is for convenience
 		 * so that we don't have to pass it to around.
 		 */
-		hashmap_init(&o->current_file_dir_set, path_hashmap_cmp, NULL, 512);
-		get_files_dirs(o, head);
-		get_files_dirs(o, merge);
+		hashmap_init(&opt->current_file_dir_set, path_hashmap_cmp, NULL, 512);
+		get_files_dirs(opt, head);
+		get_files_dirs(opt, merge);
 
-		entries = get_unmerged(o->repo->index);
-		clean = detect_and_process_renames(o, common, head, merge,
+		entries = get_unmerged(opt->repo->index);
+		clean = detect_and_process_renames(opt, common, head, merge,
 						   entries, &re_info);
-		record_df_conflict_files(o, entries);
+		record_df_conflict_files(opt, entries);
 		if (clean < 0)
 			goto cleanup;
 		for (i = entries->nr-1; 0 <= i; i--) {
 			const char *path = entries->items[i].string;
 			struct stage_data *e = entries->items[i].util;
 			if (!e->processed) {
-				int ret = process_entry(o, path, e);
+				int ret = process_entry(opt, path, e);
 				if (!ret)
 					clean = 0;
 				else if (ret < 0) {
@@ -3483,19 +3483,19 @@ int merge_trees(struct merge_options *o,
 		string_list_clear(entries, 1);
 		free(entries);
 
-		hashmap_free(&o->current_file_dir_set, 1);
+		hashmap_free(&opt->current_file_dir_set, 1);
 
 		if (clean < 0) {
-			unpack_trees_finish(o);
+			unpack_trees_finish(opt);
 			return clean;
 		}
 	}
 	else
 		clean = 1;
 
-	unpack_trees_finish(o);
+	unpack_trees_finish(opt);
 
-	if (o->call_depth && !(*result = write_tree_from_memory(o)))
+	if (opt->call_depth && !(*result = write_tree_from_memory(opt)))
 		return -1;
 
 	return clean;
@@ -3516,7 +3516,7 @@ static struct commit_list *reverse_commit_list(struct commit_list *list)
  * Merge the commits h1 and h2, return the resulting virtual
  * commit object and a flag indicating the cleanness of the merge.
  */
-int merge_recursive(struct merge_options *o,
+int merge_recursive(struct merge_options *opt,
 		    struct commit *h1,
 		    struct commit *h2,
 		    struct commit_list *ca,
@@ -3527,10 +3527,10 @@ int merge_recursive(struct merge_options *o,
 	struct tree *mrtree;
 	int clean;
 
-	if (show(o, 4)) {
-		output(o, 4, _("Merging:"));
-		output_commit_title(o, h1);
-		output_commit_title(o, h2);
+	if (show(opt, 4)) {
+		output(opt, 4, _("Merging:"));
+		output_commit_title(opt, h1);
+		output_commit_title(opt, h2);
 	}
 
 	if (!ca) {
@@ -3538,13 +3538,13 @@ int merge_recursive(struct merge_options *o,
 		ca = reverse_commit_list(ca);
 	}
 
-	if (show(o, 5)) {
+	if (show(opt, 5)) {
 		unsigned cnt = commit_list_count(ca);
 
-		output(o, 5, Q_("found %u common ancestor:",
+		output(opt, 5, Q_("found %u common ancestor:",
 				"found %u common ancestors:", cnt), cnt);
 		for (iter = ca; iter; iter = iter->next)
-			output_commit_title(o, iter->item);
+			output_commit_title(opt, iter->item);
 	}
 
 	merged_common_ancestors = pop_commit(&ca);
@@ -3552,13 +3552,13 @@ int merge_recursive(struct merge_options *o,
 		/* if there is no common ancestor, use an empty tree */
 		struct tree *tree;
 
-		tree = lookup_tree(o->repo, o->repo->hash_algo->empty_tree);
-		merged_common_ancestors = make_virtual_commit(o->repo, tree, "ancestor");
+		tree = lookup_tree(opt->repo, opt->repo->hash_algo->empty_tree);
+		merged_common_ancestors = make_virtual_commit(opt->repo, tree, "ancestor");
 	}
 
 	for (iter = ca; iter; iter = iter->next) {
 		const char *saved_b1, *saved_b2;
-		o->call_depth++;
+		opt->call_depth++;
 		/*
 		 * When the merge fails, the result contains files
 		 * with conflict markers. The cleanness flag is
@@ -3567,46 +3567,46 @@ int merge_recursive(struct merge_options *o,
 		 * overwritten it: the committed "conflicts" were
 		 * already resolved.
 		 */
-		discard_index(o->repo->index);
-		saved_b1 = o->branch1;
-		saved_b2 = o->branch2;
-		o->branch1 = "Temporary merge branch 1";
-		o->branch2 = "Temporary merge branch 2";
-		if (merge_recursive(o, merged_common_ancestors, iter->item,
+		discard_index(opt->repo->index);
+		saved_b1 = opt->branch1;
+		saved_b2 = opt->branch2;
+		opt->branch1 = "Temporary merge branch 1";
+		opt->branch2 = "Temporary merge branch 2";
+		if (merge_recursive(opt, merged_common_ancestors, iter->item,
 				    NULL, &merged_common_ancestors) < 0)
 			return -1;
-		o->branch1 = saved_b1;
-		o->branch2 = saved_b2;
-		o->call_depth--;
+		opt->branch1 = saved_b1;
+		opt->branch2 = saved_b2;
+		opt->call_depth--;
 
 		if (!merged_common_ancestors)
-			return err(o, _("merge returned no commit"));
+			return err(opt, _("merge returned no commit"));
 	}
 
-	discard_index(o->repo->index);
-	if (!o->call_depth)
-		repo_read_index(o->repo);
+	discard_index(opt->repo->index);
+	if (!opt->call_depth)
+		repo_read_index(opt->repo);
 
-	o->ancestor = "merged common ancestors";
-	clean = merge_trees(o, get_commit_tree(h1), get_commit_tree(h2),
+	opt->ancestor = "merged common ancestors";
+	clean = merge_trees(opt, get_commit_tree(h1), get_commit_tree(h2),
 			    get_commit_tree(merged_common_ancestors),
 			    &mrtree);
 	if (clean < 0) {
-		flush_output(o);
+		flush_output(opt);
 		return clean;
 	}
 
-	if (o->call_depth) {
-		*result = make_virtual_commit(o->repo, mrtree, "merged tree");
+	if (opt->call_depth) {
+		*result = make_virtual_commit(opt->repo, mrtree, "merged tree");
 		commit_list_insert(h1, &(*result)->parents);
 		commit_list_insert(h2, &(*result)->parents->next);
 	}
-	flush_output(o);
-	if (!o->call_depth && o->buffer_output < 2)
-		strbuf_release(&o->obuf);
-	if (show(o, 2))
+	flush_output(opt);
+	if (!opt->call_depth && opt->buffer_output < 2)
+		strbuf_release(&opt->obuf);
+	if (show(opt, 2))
 		diff_warn_rename_limit("merge.renamelimit",
-				       o->needed_rename_limit, 0);
+				       opt->needed_rename_limit, 0);
 	return clean;
 }
 
@@ -3628,7 +3628,7 @@ static struct commit *get_ref(struct repository *repo, const struct object_id *o
 	return (struct commit *)object;
 }
 
-int merge_recursive_generic(struct merge_options *o,
+int merge_recursive_generic(struct merge_options *opt,
 			    const struct object_id *head,
 			    const struct object_id *merge,
 			    int num_base_list,
@@ -3637,127 +3637,127 @@ int merge_recursive_generic(struct merge_options *o,
 {
 	int clean;
 	struct lock_file lock = LOCK_INIT;
-	struct commit *head_commit = get_ref(o->repo, head, o->branch1);
-	struct commit *next_commit = get_ref(o->repo, merge, o->branch2);
+	struct commit *head_commit = get_ref(opt->repo, head, opt->branch1);
+	struct commit *next_commit = get_ref(opt->repo, merge, opt->branch2);
 	struct commit_list *ca = NULL;
 
 	if (base_list) {
 		int i;
 		for (i = 0; i < num_base_list; ++i) {
 			struct commit *base;
-			if (!(base = get_ref(o->repo, base_list[i], oid_to_hex(base_list[i]))))
-				return err(o, _("Could not parse object '%s'"),
+			if (!(base = get_ref(opt->repo, base_list[i], oid_to_hex(base_list[i]))))
+				return err(opt, _("Could not parse object '%s'"),
 					   oid_to_hex(base_list[i]));
 			commit_list_insert(base, &ca);
 		}
 	}
 
-	repo_hold_locked_index(o->repo, &lock, LOCK_DIE_ON_ERROR);
-	clean = merge_recursive(o, head_commit, next_commit, ca,
+	repo_hold_locked_index(opt->repo, &lock, LOCK_DIE_ON_ERROR);
+	clean = merge_recursive(opt, head_commit, next_commit, ca,
 				result);
 	if (clean < 0) {
 		rollback_lock_file(&lock);
 		return clean;
 	}
 
-	if (write_locked_index(o->repo->index, &lock,
+	if (write_locked_index(opt->repo->index, &lock,
 			       COMMIT_LOCK | SKIP_IF_UNCHANGED))
-		return err(o, _("Unable to write index."));
+		return err(opt, _("Unable to write index."));
 
 	return clean ? 0 : 1;
 }
 
-static void merge_recursive_config(struct merge_options *o)
+static void merge_recursive_config(struct merge_options *opt)
 {
 	char *value = NULL;
-	git_config_get_int("merge.verbosity", &o->verbosity);
-	git_config_get_int("diff.renamelimit", &o->diff_rename_limit);
-	git_config_get_int("merge.renamelimit", &o->merge_rename_limit);
+	git_config_get_int("merge.verbosity", &opt->verbosity);
+	git_config_get_int("diff.renamelimit", &opt->diff_rename_limit);
+	git_config_get_int("merge.renamelimit", &opt->merge_rename_limit);
 	if (!git_config_get_string("diff.renames", &value)) {
-		o->diff_detect_rename = git_config_rename("diff.renames", value);
+		opt->diff_detect_rename = git_config_rename("diff.renames", value);
 		free(value);
 	}
 	if (!git_config_get_string("merge.renames", &value)) {
-		o->merge_detect_rename = git_config_rename("merge.renames", value);
+		opt->merge_detect_rename = git_config_rename("merge.renames", value);
 		free(value);
 	}
 	git_config(git_xmerge_config, NULL);
 }
 
-void init_merge_options(struct merge_options *o,
+void init_merge_options(struct merge_options *opt,
 			struct repository *repo)
 {
 	const char *merge_verbosity;
-	memset(o, 0, sizeof(struct merge_options));
-	o->repo = repo;
-	o->verbosity = 2;
-	o->buffer_output = 1;
-	o->diff_rename_limit = -1;
-	o->merge_rename_limit = -1;
-	o->renormalize = 0;
-	o->diff_detect_rename = -1;
-	o->merge_detect_rename = -1;
-	o->detect_directory_renames = 1;
-	merge_recursive_config(o);
+	memset(opt, 0, sizeof(struct merge_options));
+	opt->repo = repo;
+	opt->verbosity = 2;
+	opt->buffer_output = 1;
+	opt->diff_rename_limit = -1;
+	opt->merge_rename_limit = -1;
+	opt->renormalize = 0;
+	opt->diff_detect_rename = -1;
+	opt->merge_detect_rename = -1;
+	opt->detect_directory_renames = 1;
+	merge_recursive_config(opt);
 	merge_verbosity = getenv("GIT_MERGE_VERBOSITY");
 	if (merge_verbosity)
-		o->verbosity = strtol(merge_verbosity, NULL, 10);
-	if (o->verbosity >= 5)
-		o->buffer_output = 0;
-	strbuf_init(&o->obuf, 0);
-	string_list_init(&o->df_conflict_file_set, 1);
+		opt->verbosity = strtol(merge_verbosity, NULL, 10);
+	if (opt->verbosity >= 5)
+		opt->buffer_output = 0;
+	strbuf_init(&opt->obuf, 0);
+	string_list_init(&opt->df_conflict_file_set, 1);
 }
 
-int parse_merge_opt(struct merge_options *o, const char *s)
+int parse_merge_opt(struct merge_options *opt, const char *s)
 {
 	const char *arg;
 
 	if (!s || !*s)
 		return -1;
 	if (!strcmp(s, "ours"))
-		o->recursive_variant = MERGE_RECURSIVE_OURS;
+		opt->recursive_variant = MERGE_RECURSIVE_OURS;
 	else if (!strcmp(s, "theirs"))
-		o->recursive_variant = MERGE_RECURSIVE_THEIRS;
+		opt->recursive_variant = MERGE_RECURSIVE_THEIRS;
 	else if (!strcmp(s, "subtree"))
-		o->subtree_shift = "";
+		opt->subtree_shift = "";
 	else if (skip_prefix(s, "subtree=", &arg))
-		o->subtree_shift = arg;
+		opt->subtree_shift = arg;
 	else if (!strcmp(s, "patience"))
-		o->xdl_opts = DIFF_WITH_ALG(o, PATIENCE_DIFF);
+		opt->xdl_opts = DIFF_WITH_ALG(opt, PATIENCE_DIFF);
 	else if (!strcmp(s, "histogram"))
-		o->xdl_opts = DIFF_WITH_ALG(o, HISTOGRAM_DIFF);
+		opt->xdl_opts = DIFF_WITH_ALG(opt, HISTOGRAM_DIFF);
 	else if (skip_prefix(s, "diff-algorithm=", &arg)) {
 		long value = parse_algorithm_value(arg);
 		if (value < 0)
 			return -1;
 		/* clear out previous settings */
-		DIFF_XDL_CLR(o, NEED_MINIMAL);
-		o->xdl_opts &= ~XDF_DIFF_ALGORITHM_MASK;
-		o->xdl_opts |= value;
+		DIFF_XDL_CLR(opt, NEED_MINIMAL);
+		opt->xdl_opts &= ~XDF_DIFF_ALGORITHM_MASK;
+		opt->xdl_opts |= value;
 	}
 	else if (!strcmp(s, "ignore-space-change"))
-		DIFF_XDL_SET(o, IGNORE_WHITESPACE_CHANGE);
+		DIFF_XDL_SET(opt, IGNORE_WHITESPACE_CHANGE);
 	else if (!strcmp(s, "ignore-all-space"))
-		DIFF_XDL_SET(o, IGNORE_WHITESPACE);
+		DIFF_XDL_SET(opt, IGNORE_WHITESPACE);
 	else if (!strcmp(s, "ignore-space-at-eol"))
-		DIFF_XDL_SET(o, IGNORE_WHITESPACE_AT_EOL);
+		DIFF_XDL_SET(opt, IGNORE_WHITESPACE_AT_EOL);
 	else if (!strcmp(s, "ignore-cr-at-eol"))
-		DIFF_XDL_SET(o, IGNORE_CR_AT_EOL);
+		DIFF_XDL_SET(opt, IGNORE_CR_AT_EOL);
 	else if (!strcmp(s, "renormalize"))
-		o->renormalize = 1;
+		opt->renormalize = 1;
 	else if (!strcmp(s, "no-renormalize"))
-		o->renormalize = 0;
+		opt->renormalize = 0;
 	else if (!strcmp(s, "no-renames"))
-		o->merge_detect_rename = 0;
+		opt->merge_detect_rename = 0;
 	else if (!strcmp(s, "find-renames")) {
-		o->merge_detect_rename = 1;
-		o->rename_score = 0;
+		opt->merge_detect_rename = 1;
+		opt->rename_score = 0;
 	}
 	else if (skip_prefix(s, "find-renames=", &arg) ||
 		 skip_prefix(s, "rename-threshold=", &arg)) {
-		if ((o->rename_score = parse_rename_score(&arg)) == -1 || *arg != 0)
+		if ((opt->rename_score = parse_rename_score(&arg)) == -1 || *arg != 0)
 			return -1;
-		o->merge_detect_rename = 1;
+		opt->merge_detect_rename = 1;
 	}
 	/*
 	 * Please update $__git_merge_strategy_options in
-- 
2.21.0.211.g719c25afaf.dirty

