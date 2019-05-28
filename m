Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FCD91F462
	for <e@80x24.org>; Tue, 28 May 2019 22:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbfE1WkW (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 18:40:22 -0400
Received: from resqmta-po-08v.sys.comcast.net ([96.114.154.167]:53824 "EHLO
        resqmta-po-08v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726463AbfE1WkW (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 May 2019 18:40:22 -0400
Received: from resomta-po-08v.sys.comcast.net ([96.114.154.232])
        by resqmta-po-08v.sys.comcast.net with ESMTP
        id Vi6Hh5oWHFpWYVklWhJkXz; Tue, 28 May 2019 22:40:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=20190202a; t=1559083218;
        bh=c6iLm/MoNEerOQ6ffIPZStKoFmg8lvYxMW35NiKBtRM=;
        h=Received:Received:Date:From:To:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=McErqMxMVERvivBNVXVmI+DL9eOEAcecMpIGOw2zP0myT4J73TO1YfMSULF13TPGB
         mARAYDL+vrH9E/sf3cDfwOKujIm6rCLMDyTJgnXU2jgg19sML6HMTzvhw18pLCQh0O
         31HFSWPSZgxhEuQVa0bieh43nFXwP/Fswkle9Q4zkuFjurn4Bqpkr68E8SQ4NTbOo2
         Z0a9wlD0IBVegdI9j4yYNBRjnnoQpCbuRMdBJTMtAlKkwYlRGvnzTdleS5Dc/Rv1Kn
         iwmS8JMcpMG3E/JY+1GzJwd/Qsrkk1vkgI9qUiOx9i/JZxmHPqelzQlPJMn9Q4rbAg
         6HIwiF44bJRPw==
Received: from comcast.net ([IPv6:2601:647:4b02:2491:b43f:cfdf:8f71:b59d])
        by resomta-po-08v.sys.comcast.net with ESMTPSA
        id VklOhp2CrtVCgVklVhTHTu; Tue, 28 May 2019 22:40:17 +0000
X-Xfinity-VMeta: sc=-100;st=legit
Date:   Tue, 28 May 2019 15:40:10 -0700
From:   Matthew DeVore <matvore@comcast.net>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Matthew DeVore <matvore@google.com>, jonathantanmy@google.com,
        jrn@google.com, git@vger.kernel.org, dstolee@microsoft.com,
        jeffhost@microsoft.com, jrnieder@gmail.com, pclouds@gmail.com
Subject: [PATCH] list-objects-filter: merge filter data structs
Message-ID: <20190528224010.GA4700@comcast.net>
References: <cover.1558484115.git.matvore@google.com>
 <341bc55d4a3f5438b1523525cf683f96d75e8c3e.1558484115.git.matvore@google.com>
 <20190524004938.GB46998@google.com>
 <20190528184801.GA4556@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528184801.GA4556@comcast.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[This is what I had in mind re:merging the different filter type structs. This
is essentially a clean-up which makes the following patches a little simpler,
even more simpler than the previous version of the patchset.]

Before this patch, there is a lot of boilerplate code associated with
invoking a filter and maintaining its running state. This makes creating
a composite filter more cumbersome than it needs to be.

Simplify the filter execution data logic and structs by putting all
execution data for all filter types in a single struct. This results in
a tiny overhead for each filter instance, and in exchange, invoking
filters is not only easier but the list-objects-filter public API is
simpler and more opaque.

Helped-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Matthew DeVore <matvore@google.com>
---
 list-objects-filter-options.h |  19 +++
 list-objects-filter.c         | 227 +++++++++++++---------------------
 list-objects-filter.h         |  29 ++---
 list-objects.c                |  44 +++----
 4 files changed, 139 insertions(+), 180 deletions(-)

diff --git a/list-objects-filter-options.h b/list-objects-filter-options.h
index e3adc78ebf..ac320c3312 100644
--- a/list-objects-filter-options.h
+++ b/list-objects-filter-options.h
@@ -2,25 +2,44 @@
 #define LIST_OBJECTS_FILTER_OPTIONS_H
 
 #include "parse-options.h"
 #include "strbuf.h"
 
 /*
  * The list of defined filters for list-objects.
  */
 enum list_objects_filter_choice {
 	LOFC_DISABLED = 0,
+
+	/* A filter for list-objects to omit ALL blobs from the traversal. */
 	LOFC_BLOB_NONE,
+
+	/* A filter for list-objects to omit large blobs. */
 	LOFC_BLOB_LIMIT,
+
+	/*
+	 * A filter for list-objects to omit ALL trees and blobs from the
+	 * traversal.
+	 */
 	LOFC_TREE_DEPTH,
+
+	/*
+	 * Filters driven by a sparse-checkout specification to only include
+	 * blobs that a sparse checkout would populate.
+	 *
+	 * The sparse-checkout spec can be loaded from a blob with the given
+	 * OID or from a local pathname.  We allow an OID because the repo may
+	 * be bare or we may be doing the filtering on the server.
+	 */
 	LOFC_SPARSE_OID,
 	LOFC_SPARSE_PATH,
+
 	LOFC__COUNT /* must be last */
 };
 
 struct list_objects_filter_options {
 	/*
 	 * 'filter_spec' is the raw argument value given on the command line
 	 * or protocol request.  (The part after the "--keyword=".)  For
 	 * commands that launch filtering sub-processes, or for communication
 	 * over the network, don't use this value; use the result of
 	 * expand_list_objects_filter_spec() instead.
diff --git a/list-objects-filter.c b/list-objects-filter.c
index ee449de3f7..334b0d959b 100644
--- a/list-objects-filter.c
+++ b/list-objects-filter.c
@@ -19,38 +19,67 @@
  * FILTER_SHOWN_BUT_REVISIT -- we set this bit on tree objects
  * that have been shown, but should be revisited if they appear
  * in the traversal (until we mark it SEEN).  This is a way to
  * let us silently de-dup calls to show() in the caller.  This
  * is subtly different from the "revision.h:SHOWN" and the
  * "sha1-name.c:ONELINE_SEEN" bits.  And also different from
  * the non-de-dup usage in pack-bitmap.c
  */
 #define FILTER_SHOWN_BUT_REVISIT (1<<21)
 
-/*
- * A filter for list-objects to omit ALL blobs from the traversal.
- * And to OPTIONALLY collect a list of the omitted OIDs.
- */
-struct filter_blobs_none_data {
+struct filter_data {
+	/* Used by all filter types. */
 	struct oidset *omits;
+
+	enum list_objects_filter_result (*filter_object_fn)(
+		struct repository *r,
+		enum list_objects_filter_situation filter_situation,
+		struct object *obj,
+		const char *pathname,
+		const char *filename,
+		struct filter_data *filter_data);
+
+	/* BEGIN tree:<depth> filter data */
+
+	/*
+	 * Maps trees to the minimum depth at which they were seen. It is not
+	 * necessary to re-traverse a tree at deeper or equal depths than it has
+	 * already been traversed.
+	 *
+	 * We can't use LOFR_MARK_SEEN for tree objects since this will prevent
+	 * it from being traversed at shallower depths.
+	 */
+	struct oidmap seen_at_depth;
+
+	unsigned long exclude_depth;
+	unsigned long current_depth;
+
+	/* BEGIN blobs:limit=<limit> filter data */
+
+	unsigned long max_bytes;
+
+	/* BEGIN sparse:... filter data */
+
+	struct exclude_list el;
+
+	size_t nr, alloc;
+	struct frame *array_frame;
 };
 
 static enum list_objects_filter_result filter_blobs_none(
 	struct repository *r,
 	enum list_objects_filter_situation filter_situation,
 	struct object *obj,
 	const char *pathname,
 	const char *filename,
-	void *filter_data_)
+	struct filter_data *filter_data)
 {
-	struct filter_blobs_none_data *filter_data = filter_data_;
-
 	switch (filter_situation) {
 	default:
 		BUG("unknown filter_situation: %d", filter_situation);
 
 	case LOFS_BEGIN_TREE:
 		assert(obj->type == OBJ_TREE);
 		/* always include all tree objects */
 		return LOFR_MARK_SEEN | LOFR_DO_SHOW;
 
 	case LOFS_END_TREE:
@@ -60,84 +89,55 @@ static enum list_objects_filter_result filter_blobs_none(
 	case LOFS_BLOB:
 		assert(obj->type == OBJ_BLOB);
 		assert((obj->flags & SEEN) == 0);
 
 		if (filter_data->omits)
 			oidset_insert(filter_data->omits, &obj->oid);
 		return LOFR_MARK_SEEN; /* but not LOFR_DO_SHOW (hard omit) */
 	}
 }
 
-static void *filter_blobs_none__init(
-	struct oidset *omitted,
+static void filter_blobs_none__init(
 	struct list_objects_filter_options *filter_options,
-	filter_object_fn *filter_fn,
-	filter_free_fn *filter_free_fn)
+	struct filter_data *d)
 {
-	struct filter_blobs_none_data *d = xcalloc(1, sizeof(*d));
-	d->omits = omitted;
-
-	*filter_fn = filter_blobs_none;
-	*filter_free_fn = free;
-	return d;
+	d->filter_object_fn = filter_blobs_none;
 }
 
-/*
- * A filter for list-objects to omit ALL trees and blobs from the traversal.
- * Can OPTIONALLY collect a list of the omitted OIDs.
- */
-struct filter_trees_depth_data {
-	struct oidset *omits;
-
-	/*
-	 * Maps trees to the minimum depth at which they were seen. It is not
-	 * necessary to re-traverse a tree at deeper or equal depths than it has
-	 * already been traversed.
-	 *
-	 * We can't use LOFR_MARK_SEEN for tree objects since this will prevent
-	 * it from being traversed at shallower depths.
-	 */
-	struct oidmap seen_at_depth;
-
-	unsigned long exclude_depth;
-	unsigned long current_depth;
-};
-
 struct seen_map_entry {
 	struct oidmap_entry base;
 	size_t depth;
 };
 
 /* Returns 1 if the oid was in the omits set before it was invoked. */
 static int filter_trees_update_omits(
 	struct object *obj,
-	struct filter_trees_depth_data *filter_data,
+	struct filter_data *filter_data,
 	int include_it)
 {
 	if (!filter_data->omits)
 		return 0;
 
 	if (include_it)
 		return oidset_remove(filter_data->omits, &obj->oid);
 	else
 		return oidset_insert(filter_data->omits, &obj->oid);
 }
 
 static enum list_objects_filter_result filter_trees_depth(
 	struct repository *r,
 	enum list_objects_filter_situation filter_situation,
 	struct object *obj,
 	const char *pathname,
 	const char *filename,
-	void *filter_data_)
+	struct filter_data *filter_data)
 {
-	struct filter_trees_depth_data *filter_data = filter_data_;
 	struct seen_map_entry *seen_info;
 	int include_it = filter_data->current_depth <
 		filter_data->exclude_depth;
 	int filter_res;
 	int already_seen;
 
 	/*
 	 * Note that we do not use _MARK_SEEN in order to allow re-traversal in
 	 * case we encounter a tree or blob again at a shallower depth.
 	 */
@@ -186,63 +186,38 @@ static enum list_objects_filter_result filter_trees_depth(
 				filter_res = LOFR_ZERO;
 			else
 				filter_res = LOFR_SKIP_TREE;
 		}
 
 		filter_data->current_depth++;
 		return filter_res;
 	}
 }
 
-static void filter_trees_free(void *filter_data) {
-	struct filter_trees_depth_data *d = filter_data;
-	if (!d)
-		return;
-	oidmap_free(&d->seen_at_depth, 1);
-	free(d);
-}
-
-static void *filter_trees_depth__init(
-	struct oidset *omitted,
+static void filter_trees_depth__init(
 	struct list_objects_filter_options *filter_options,
-	filter_object_fn *filter_fn,
-	filter_free_fn *filter_free_fn)
+	struct filter_data *d)
 {
-	struct filter_trees_depth_data *d = xcalloc(1, sizeof(*d));
-	d->omits = omitted;
 	oidmap_init(&d->seen_at_depth, 0);
 	d->exclude_depth = filter_options->tree_exclude_depth;
 	d->current_depth = 0;
-
-	*filter_fn = filter_trees_depth;
-	*filter_free_fn = filter_trees_free;
-	return d;
+	d->filter_object_fn = filter_trees_depth;
 }
 
-/*
- * A filter for list-objects to omit large blobs.
- * And to OPTIONALLY collect a list of the omitted OIDs.
- */
-struct filter_blobs_limit_data {
-	struct oidset *omits;
-	unsigned long max_bytes;
-};
-
 static enum list_objects_filter_result filter_blobs_limit(
 	struct repository *r,
 	enum list_objects_filter_situation filter_situation,
 	struct object *obj,
 	const char *pathname,
 	const char *filename,
-	void *filter_data_)
+	struct filter_data *filter_data)
 {
-	struct filter_blobs_limit_data *filter_data = filter_data_;
 	unsigned long object_length;
 	enum object_type t;
 
 	switch (filter_situation) {
 	default:
 		BUG("unknown filter_situation: %d", filter_situation);
 
 	case LOFS_BEGIN_TREE:
 		assert(obj->type == OBJ_TREE);
 		/* always include all tree objects */
@@ -274,81 +249,57 @@ static enum list_objects_filter_result filter_blobs_limit(
 			oidset_insert(filter_data->omits, &obj->oid);
 		return LOFR_MARK_SEEN; /* but not LOFR_DO_SHOW (hard omit) */
 	}
 
 include_it:
 	if (filter_data->omits)
 		oidset_remove(filter_data->omits, &obj->oid);
 	return LOFR_MARK_SEEN | LOFR_DO_SHOW;
 }
 
-static void *filter_blobs_limit__init(
-	struct oidset *omitted,
+static void filter_blobs_limit__init(
 	struct list_objects_filter_options *filter_options,
-	filter_object_fn *filter_fn,
-	filter_free_fn *filter_free_fn)
+	struct filter_data *d)
 {
-	struct filter_blobs_limit_data *d = xcalloc(1, sizeof(*d));
-	d->omits = omitted;
 	d->max_bytes = filter_options->blob_limit_value;
-
-	*filter_fn = filter_blobs_limit;
-	*filter_free_fn = free;
-	return d;
+	d->filter_object_fn = filter_blobs_limit;
 }
 
-/*
- * A filter driven by a sparse-checkout specification to only
- * include blobs that a sparse checkout would populate.
- *
- * The sparse-checkout spec can be loaded from a blob with the
- * given OID or from a local pathname.  We allow an OID because
- * the repo may be bare or we may be doing the filtering on the
- * server.
- */
+/* For use with sparse checkout filters. */
 struct frame {
 	/*
 	 * defval is the usual default include/exclude value that
 	 * should be inherited as we recurse into directories based
 	 * upon pattern matching of the directory itself or of a
 	 * containing directory.
 	 */
 	int defval;
 
 	/*
 	 * 1 if the directory (recursively) contains any provisionally
 	 * omitted objects.
 	 *
 	 * 0 if everything (recursively) contained in this directory
 	 * has been explicitly included (SHOWN) in the result and
 	 * the directory may be short-cut later in the traversal.
 	 */
 	unsigned child_prov_omit : 1;
 };
 
-struct filter_sparse_data {
-	struct oidset *omits;
-	struct exclude_list el;
-
-	size_t nr, alloc;
-	struct frame *array_frame;
-};
-
 static enum list_objects_filter_result filter_sparse(
 	struct repository *r,
 	enum list_objects_filter_situation filter_situation,
 	struct object *obj,
 	const char *pathname,
 	const char *filename,
-	void *filter_data_)
+	struct filter_data *filter_data)
 {
-	struct filter_sparse_data *filter_data = filter_data_;
 	int val, dtype;
 	struct frame *frame;
 
 	switch (filter_situation) {
 	default:
 		BUG("unknown filter_situation: %d", filter_situation);
 
 	case LOFS_BEGIN_TREE:
 		assert(obj->type == OBJ_TREE);
 		dtype = DT_DIR;
@@ -442,100 +393,96 @@ static enum list_objects_filter_result filter_sparse(
 		/*
 		 * Remember that at least 1 blob in this tree was
 		 * provisionally omitted.  This prevents us from short
 		 * cutting the tree in future iterations.
 		 */
 		frame->child_prov_omit = 1;
 		return LOFR_ZERO;
 	}
 }
 
-
-static void filter_sparse_free(void *filter_data)
-{
-	struct filter_sparse_data *d = filter_data;
-	/* TODO free contents of 'd' */
-	free(d);
-}
-
-static void *filter_sparse_oid__init(
-	struct oidset *omitted,
+static void filter_sparse_oid__init(
 	struct list_objects_filter_options *filter_options,
-	filter_object_fn *filter_fn,
-	filter_free_fn *filter_free_fn)
+	struct filter_data *d)
 {
-	struct filter_sparse_data *d = xcalloc(1, sizeof(*d));
-	d->omits = omitted;
 	if (add_excludes_from_blob_to_list(filter_options->sparse_oid_value,
 					   NULL, 0, &d->el) < 0)
 		die("could not load filter specification");
 
 	ALLOC_GROW(d->array_frame, d->nr + 1, d->alloc);
 	d->array_frame[d->nr].defval = 0; /* default to include */
 	d->array_frame[d->nr].child_prov_omit = 0;
 
-	*filter_fn = filter_sparse;
-	*filter_free_fn = filter_sparse_free;
-	return d;
+	d->filter_object_fn = filter_sparse;
 }
 
-static void *filter_sparse_path__init(
-	struct oidset *omitted,
+static void filter_sparse_path__init(
 	struct list_objects_filter_options *filter_options,
-	filter_object_fn *filter_fn,
-	filter_free_fn *filter_free_fn)
+	struct filter_data *d)
 {
-	struct filter_sparse_data *d = xcalloc(1, sizeof(*d));
-	d->omits = omitted;
 	if (add_excludes_from_file_to_list(filter_options->sparse_path_value,
 					   NULL, 0, &d->el, NULL) < 0)
 		die("could not load filter specification");
 
 	ALLOC_GROW(d->array_frame, d->nr + 1, d->alloc);
 	d->array_frame[d->nr].defval = 0; /* default to include */
 	d->array_frame[d->nr].child_prov_omit = 0;
 
-	*filter_fn = filter_sparse;
-	*filter_free_fn = filter_sparse_free;
-	return d;
+	d->filter_object_fn = filter_sparse;
 }
 
-typedef void *(*filter_init_fn)(
-	struct oidset *omitted,
+typedef void (*filter_init_fn)(
 	struct list_objects_filter_options *filter_options,
-	filter_object_fn *filter_fn,
-	filter_free_fn *filter_free_fn);
+	struct filter_data *filter_data);
 
 /*
  * Must match "enum list_objects_filter_choice".
  */
 static filter_init_fn s_filters[] = {
 	NULL,
 	filter_blobs_none__init,
 	filter_blobs_limit__init,
 	filter_trees_depth__init,
 	filter_sparse_oid__init,
 	filter_sparse_path__init,
 };
 
-void *list_objects_filter__init(
+struct filter_data *list_objects_filter__init(
 	struct oidset *omitted,
-	struct list_objects_filter_options *filter_options,
-	filter_object_fn *filter_fn,
-	filter_free_fn *filter_free_fn)
+	struct list_objects_filter_options *filter_options)
 {
 	filter_init_fn init_fn;
+	struct filter_data *filter_data;
 
 	assert((sizeof(s_filters) / sizeof(s_filters[0])) == LOFC__COUNT);
 
 	if (filter_options->choice >= LOFC__COUNT)
 		BUG("invalid list-objects filter choice: %d",
 		    filter_options->choice);
 
 	init_fn = s_filters[filter_options->choice];
-	if (init_fn)
-		return init_fn(omitted, filter_options,
-			       filter_fn, filter_free_fn);
-	*filter_fn = NULL;
-	*filter_free_fn = NULL;
-	return NULL;
+	if (!init_fn)
+		return NULL;
+
+	filter_data = xcalloc(1, sizeof(*filter_data));
+	filter_data->omits = omitted;
+	init_fn(filter_options, filter_data);
+
+	return filter_data;
+}
+
+enum list_objects_filter_result list_objects_filter__filter_object(
+	struct repository *r,
+	enum list_objects_filter_situation filter_situation,
+	struct object *obj,
+	const char *pathname,
+	const char *filename,
+	struct filter_data *filter_data)
+{
+	return filter_data->filter_object_fn(
+		r, filter_situation, obj, pathname, filename, filter_data);
+}
+
+void list_objects_filter__free(struct filter_data *d) {
+	oidmap_free(&d->seen_at_depth, 1);
+	free(d);
 }
diff --git a/list-objects-filter.h b/list-objects-filter.h
index 1d45a4ad57..2bc59147a7 100644
--- a/list-objects-filter.h
+++ b/list-objects-filter.h
@@ -53,37 +53,34 @@ enum list_objects_filter_result {
 	LOFR_DO_SHOW   = 1<<1,
 	LOFR_SKIP_TREE = 1<<2,
 };
 
 enum list_objects_filter_situation {
 	LOFS_BEGIN_TREE,
 	LOFS_END_TREE,
 	LOFS_BLOB
 };
 
-typedef enum list_objects_filter_result (*filter_object_fn)(
-	struct repository *r,
-	enum list_objects_filter_situation filter_situation,
-	struct object *obj,
-	const char *pathname,
-	const char *filename,
-	void *filter_data);
-
-typedef void (*filter_free_fn)(void *filter_data);
+struct filter_data;
 
 /*
  * Constructor for the set of defined list-objects filters.
  * Returns a generic "void *filter_data".
  *
  * The returned "filter_fn" will be used by traverse_commit_list()
  * to filter the results.
- *
- * The returned "filter_free_fn" is a destructor for the
- * filter_data.
  */
-void *list_objects_filter__init(
+struct filter_data *list_objects_filter__init(
 	struct oidset *omitted,
-	struct list_objects_filter_options *filter_options,
-	filter_object_fn *filter_fn,
-	filter_free_fn *filter_free_fn);
+	struct list_objects_filter_options *filter_options);
+
+enum list_objects_filter_result list_objects_filter__filter_object(
+	struct repository *r,
+	enum list_objects_filter_situation filter_situation,
+	struct object *obj,
+	const char *pathname,
+	const char *filename,
+	struct filter_data *filter_data);
+
+void list_objects_filter__free(struct filter_data *filter_data);
 
 #endif /* LIST_OBJECTS_FILTER_H */
diff --git a/list-objects.c b/list-objects.c
index b5651ddd5b..9d5cd1b1e5 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -11,22 +11,21 @@
 #include "list-objects-filter-options.h"
 #include "packfile.h"
 #include "object-store.h"
 #include "trace.h"
 
 struct traversal_context {
 	struct rev_info *revs;
 	show_object_fn show_object;
 	show_commit_fn show_commit;
 	void *show_data;
-	filter_object_fn filter_fn;
-	void *filter_data;
+	struct filter_data *filter_data;
 };
 
 static void process_blob(struct traversal_context *ctx,
 			 struct blob *blob,
 			 struct strbuf *path,
 			 const char *name)
 {
 	struct object *obj = &blob->object;
 	size_t pathlen;
 	enum list_objects_filter_result r = LOFR_MARK_SEEN | LOFR_DO_SHOW;
@@ -47,25 +46,26 @@ static void process_blob(struct traversal_context *ctx,
 	 * may cause the actual filter to report an incomplete list
 	 * of missing objects.
 	 */
 	if (ctx->revs->exclude_promisor_objects &&
 	    !has_object_file(&obj->oid) &&
 	    is_promisor_object(&obj->oid))
 		return;
 
 	pathlen = path->len;
 	strbuf_addstr(path, name);
-	if ((obj->flags & NOT_USER_GIVEN) && ctx->filter_fn)
-		r = ctx->filter_fn(ctx->revs->repo,
-				   LOFS_BLOB, obj,
-				   path->buf, &path->buf[pathlen],
-				   ctx->filter_data);
+	if ((obj->flags & NOT_USER_GIVEN) && ctx->filter_data)
+		r = list_objects_filter__filter_object(
+			ctx->revs->repo,
+			LOFS_BLOB, obj,
+			path->buf, &path->buf[pathlen],
+			ctx->filter_data);
 	if (r & LOFR_MARK_SEEN)
 		obj->flags |= SEEN;
 	if (r & LOFR_DO_SHOW)
 		ctx->show_object(obj, path->buf, ctx->show_data);
 	strbuf_setlen(path, pathlen);
 }
 
 /*
  * Processing a gitlink entry currently does nothing, since
  * we do not recurse into the subproject.
@@ -179,42 +179,44 @@ static void process_tree(struct traversal_context *ctx,
 		 */
 		if (revs->exclude_promisor_objects &&
 		    is_promisor_object(&obj->oid))
 			return;
 
 		if (!revs->do_not_die_on_missing_tree)
 			die("bad tree object %s", oid_to_hex(&obj->oid));
 	}
 
 	strbuf_addstr(base, name);
-	if ((obj->flags & NOT_USER_GIVEN) && ctx->filter_fn)
-		r = ctx->filter_fn(ctx->revs->repo,
-				   LOFS_BEGIN_TREE, obj,
-				   base->buf, &base->buf[baselen],
-				   ctx->filter_data);
+	if ((obj->flags & NOT_USER_GIVEN) && ctx->filter_data)
+		r = list_objects_filter__filter_object(
+			ctx->revs->repo,
+			LOFS_BEGIN_TREE, obj,
+			base->buf, &base->buf[baselen],
+			ctx->filter_data);
 	if (r & LOFR_MARK_SEEN)
 		obj->flags |= SEEN;
 	if (r & LOFR_DO_SHOW)
 		ctx->show_object(obj, base->buf, ctx->show_data);
 	if (base->len)
 		strbuf_addch(base, '/');
 
 	if (r & LOFR_SKIP_TREE)
 		trace_printf("Skipping contents of tree %s...\n", base->buf);
 	else if (!failed_parse)
 		process_tree_contents(ctx, tree, base);
 
-	if ((obj->flags & NOT_USER_GIVEN) && ctx->filter_fn) {
-		r = ctx->filter_fn(ctx->revs->repo,
-				   LOFS_END_TREE, obj,
-				   base->buf, &base->buf[baselen],
-				   ctx->filter_data);
+	if ((obj->flags & NOT_USER_GIVEN) && ctx->filter_data) {
+		r = list_objects_filter__filter_object(
+			ctx->revs->repo,
+			LOFS_END_TREE, obj,
+			base->buf, &base->buf[baselen],
+			ctx->filter_data);
 		if (r & LOFR_MARK_SEEN)
 			obj->flags |= SEEN;
 		if (r & LOFR_DO_SHOW)
 			ctx->show_object(obj, base->buf, ctx->show_data);
 	}
 
 	strbuf_setlen(base, baselen);
 	free_tree_buffer(tree);
 }
 
@@ -395,38 +397,32 @@ static void do_traverse(struct traversal_context *ctx)
 void traverse_commit_list(struct rev_info *revs,
 			  show_commit_fn show_commit,
 			  show_object_fn show_object,
 			  void *show_data)
 {
 	struct traversal_context ctx;
 	ctx.revs = revs;
 	ctx.show_commit = show_commit;
 	ctx.show_object = show_object;
 	ctx.show_data = show_data;
-	ctx.filter_fn = NULL;
 	ctx.filter_data = NULL;
 	do_traverse(&ctx);
 }
 
 void traverse_commit_list_filtered(
 	struct list_objects_filter_options *filter_options,
 	struct rev_info *revs,
 	show_commit_fn show_commit,
 	show_object_fn show_object,
 	void *show_data,
 	struct oidset *omitted)
 {
 	struct traversal_context ctx;
-	filter_free_fn filter_free_fn = NULL;
 
 	ctx.revs = revs;
 	ctx.show_object = show_object;
 	ctx.show_commit = show_commit;
 	ctx.show_data = show_data;
-	ctx.filter_fn = NULL;
 
-	ctx.filter_data = list_objects_filter__init(omitted, filter_options,
-						    &ctx.filter_fn, &filter_free_fn);
+	ctx.filter_data = list_objects_filter__init(omitted, filter_options);
 	do_traverse(&ctx);
-	if (ctx.filter_data && filter_free_fn)
-		filter_free_fn(ctx.filter_data);
 }
-- 
2.17.1
