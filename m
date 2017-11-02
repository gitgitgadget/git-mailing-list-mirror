Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68ACC20281
	for <e@80x24.org>; Thu,  2 Nov 2017 17:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964789AbdKBRun (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Nov 2017 13:50:43 -0400
Received: from siwi.pair.com ([209.68.5.199]:39971 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964781AbdKBRuj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 13:50:39 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 3896A84552;
        Thu,  2 Nov 2017 13:50:39 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 659CF84565;
        Thu,  2 Nov 2017 13:50:38 -0400 (EDT)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v2 4/6] list-objects: filter objects in traverse_commit_list
Date:   Thu,  2 Nov 2017 17:50:11 +0000
Message-Id: <20171102175013.3371-5-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20171102175013.3371-1-git@jeffhostetler.com>
References: <20171102175013.3371-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Create traverse_commit_list_filtered() and add filtering
interface to allow certain objects to be omitted from the
traversal.

Update traverse_commit_list() to be a wrapper for the above
with a null filter to minimize the number of callers that
needed to be changed.

Object filtering will be used in a future commit by rev-list
and pack-objects for partial clone and fetch to omit unwanted
objects from the result.

traverse_bitmap_commit_list() does not work with filtering.

If a packfile bitmap is present, it will not be used.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Makefile                      |   2 +
 list-objects-filter-options.c | 119 ++++++++++++
 list-objects-filter-options.h |  55 ++++++
 list-objects-filter.c         | 408 ++++++++++++++++++++++++++++++++++++++++++
 list-objects-filter.h         |  84 +++++++++
 list-objects.c                |  95 ++++++++--
 list-objects.h                |   2 +-
 7 files changed, 748 insertions(+), 17 deletions(-)
 create mode 100644 list-objects-filter-options.c
 create mode 100644 list-objects-filter-options.h
 create mode 100644 list-objects-filter.c
 create mode 100644 list-objects-filter.h

diff --git a/Makefile b/Makefile
index cd75985..ca378a4 100644
--- a/Makefile
+++ b/Makefile
@@ -807,6 +807,8 @@ LIB_OBJS += levenshtein.o
 LIB_OBJS += line-log.o
 LIB_OBJS += line-range.o
 LIB_OBJS += list-objects.o
+LIB_OBJS += list-objects-filter.o
+LIB_OBJS += list-objects-filter-options.o
 LIB_OBJS += ll-merge.o
 LIB_OBJS += lockfile.o
 LIB_OBJS += log-tree.o
diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
new file mode 100644
index 0000000..31255e7
--- /dev/null
+++ b/list-objects-filter-options.c
@@ -0,0 +1,119 @@
+#include "cache.h"
+#include "commit.h"
+#include "config.h"
+#include "revision.h"
+#include "argv-array.h"
+#include "list-objects.h"
+#include "list-objects-filter.h"
+#include "list-objects-filter-options.h"
+
+/*
+ * Parse value of the argument to the "filter" keword.
+ * On the command line this looks like:
+ *       --filter=<arg>
+ * and in the pack protocol as:
+ *       "filter" SP <arg>
+ *
+ * <arg> ::= blob:none
+ *           blob:limit=<n>[kmg]
+ *           sparse:oid=<oid-expression>
+ *           sparse:path=<pathname>
+ */
+int parse_list_objects_filter(struct list_objects_filter_options *filter_options,
+			      const char *arg)
+{
+	struct object_context oc;
+	struct object_id sparse_oid;
+	const char *v0;
+	const char *v1;
+
+	if (filter_options->choice)
+		die(_("multiple object filter types cannot be combined"));
+
+	/*
+	 * TODO consider rejecting 'arg' if it contains any
+	 * TODO injection characters (since we might send this
+	 * TODO to a sub-command or to the server and we don't
+	 * TODO want to deal with legacy quoting/escaping for
+	 * TODO a new feature).
+	 */
+
+	filter_options->raw_value = strdup(arg);
+
+	if (skip_prefix(arg, "blob:", &v0) || skip_prefix(arg, "blobs:", &v0)) {
+		if (!strcmp(v0, "none")) {
+			filter_options->choice = LOFC_BLOB_NONE;
+			return 0;
+		}
+
+		if (skip_prefix(v0, "limit=", &v1) &&
+		    git_parse_ulong(v1, &filter_options->blob_limit_value)) {
+			filter_options->choice = LOFC_BLOB_LIMIT;
+			return 0;
+		}
+	}
+	else if (skip_prefix(arg, "sparse:", &v0)) {
+		if (skip_prefix(v0, "oid=", &v1)) {
+			filter_options->choice = LOFC_SPARSE_OID;
+			if (!get_oid_with_context(v1, GET_OID_BLOB,
+						  &sparse_oid, &oc)) {
+				/*
+				 * We successfully converted the <oid-expr>
+				 * into an actual OID.  Rewrite the raw_value
+				 * in canonoical form with just the OID.
+				 * (If we send this request to the server, we
+				 * want an absolute expression rather than a
+				 * local-ref-relative expression.)
+				 */
+				free((char *)filter_options->raw_value);
+				filter_options->raw_value =
+					xstrfmt("sparse:oid=%s",
+						oid_to_hex(&sparse_oid));
+				filter_options->sparse_oid_value =
+					oiddup(&sparse_oid);
+			} else {
+				/*
+				 * We could not turn the <oid-expr> into an
+				 * OID.  Leave the raw_value as is in case
+				 * the server can parse it.  (It may refer to
+				 * a branch, commit, or blob we don't have.)
+				 */
+			}
+			return 0;
+		}
+
+		if (skip_prefix(v0, "path=", &v1)) {
+			filter_options->choice = LOFC_SPARSE_PATH;
+			filter_options->sparse_path_value = strdup(v1);
+			return 0;
+		}
+	}
+
+	die(_("invalid filter expression '%s'"), arg);
+	return 0;
+}
+
+int opt_parse_list_objects_filter(const struct option *opt,
+				  const char *arg, int unset)
+{
+	struct list_objects_filter_options *filter_options = opt->value;
+
+	assert(arg);
+	assert(!unset);
+
+	return parse_list_objects_filter(filter_options, arg);
+}
+
+void arg_format_list_objects_filter(
+	struct argv_array *argv_array,
+	const struct list_objects_filter_options *filter_options)
+{
+	if (!filter_options->choice)
+		return;
+
+	/*
+	 * TODO Think about quoting the value.
+	 */
+	argv_array_pushf(argv_array, "--%s=%s", CL_ARG__FILTER,
+			 filter_options->raw_value);
+}
diff --git a/list-objects-filter-options.h b/list-objects-filter-options.h
new file mode 100644
index 0000000..c9c5052
--- /dev/null
+++ b/list-objects-filter-options.h
@@ -0,0 +1,55 @@
+#ifndef LIST_OBJECTS_FILTER_OPTIONS_H
+#define LIST_OBJECTS_FILTER_OPTIONS_H
+
+#include "parse-options.h"
+
+/*
+ * The list of defined filters for list-objects.
+ */
+enum list_objects_filter_choice {
+	LOFC_DISABLED = 0,
+	LOFC_BLOB_NONE,
+	LOFC_BLOB_LIMIT,
+	LOFC_SPARSE_OID,
+	LOFC_SPARSE_PATH,
+	LOFC__COUNT /* must be last */
+};
+
+struct list_objects_filter_options {
+	/*
+	 * The raw argument value given on the command line or
+	 * protocol request.  (The part after the "--keyword=".)
+	 */
+	char *raw_value;
+
+	/*
+	 * Parsed values. Only 1 will be set depending on the flags below.
+	 */
+	struct object_id *sparse_oid_value;
+	char *sparse_path_value;
+	unsigned long blob_limit_value;
+
+	enum list_objects_filter_choice choice;
+};
+
+/* Normalized command line arguments */
+#define CL_ARG__FILTER "filter"
+
+int parse_list_objects_filter(
+	struct list_objects_filter_options *filter_options,
+	const char *arg);
+
+int opt_parse_list_objects_filter(const struct option *opt,
+				  const char *arg, int unset);
+
+#define OPT_PARSE_LIST_OBJECTS_FILTER(fo) \
+	{ OPTION_CALLBACK, 0, CL_ARG__FILTER, fo, N_("args"), \
+	  N_("object filtering"), PARSE_OPT_NONEG, \
+	  opt_parse_list_objects_filter }
+
+struct argv_array;
+void arg_format_list_objects_filter(
+	struct argv_array *aa,
+	const struct list_objects_filter_options *filter_options);
+
+#endif /* LIST_OBJECTS_FILTER_OPTIONS_H */
diff --git a/list-objects-filter.c b/list-objects-filter.c
new file mode 100644
index 0000000..7f28425
--- /dev/null
+++ b/list-objects-filter.c
@@ -0,0 +1,408 @@
+#include "cache.h"
+#include "dir.h"
+#include "tag.h"
+#include "commit.h"
+#include "tree.h"
+#include "blob.h"
+#include "diff.h"
+#include "tree-walk.h"
+#include "revision.h"
+#include "list-objects.h"
+#include "list-objects-filter.h"
+#include "list-objects-filter-options.h"
+#include "oidset.h"
+
+/* See object.h and revision.h */
+#define FILTER_REVISIT (1<<25)
+
+/*
+ * A filter for list-objects to omit ALL blobs from the traversal.
+ * And to OPTIONALLY collect a list of the omitted OIDs.
+ */
+struct filter_blobs_none_data {
+	struct oidset *omits;
+};
+
+static enum list_objects_filter_result filter_blobs_none(
+	enum list_objects_filter_type filter_type,
+	struct object *obj,
+	const char *pathname,
+	const char *filename,
+	void *filter_data_)
+{
+	struct filter_blobs_none_data *filter_data = filter_data_;
+
+	switch (filter_type) {
+	default:
+		die("unkown filter_type");
+		return LOFR_ZERO;
+
+	case LOFT_BEGIN_TREE:
+		assert(obj->type == OBJ_TREE);
+		/* always include all tree objects */
+		return LOFR_MARK_SEEN | LOFR_SHOW;
+
+	case LOFT_END_TREE:
+		assert(obj->type == OBJ_TREE);
+		return LOFR_ZERO;
+
+	case LOFT_BLOB:
+		assert(obj->type == OBJ_BLOB);
+		assert((obj->flags & SEEN) == 0);
+
+		if (filter_data->omits)
+			oidset_insert(filter_data->omits, &obj->oid);
+		return LOFR_MARK_SEEN; /* but not LOFR_SHOW (hard omit) */
+	}
+}
+
+static void *filter_blobs_none__init(
+	struct oidset *omitted,
+	struct list_objects_filter_options *filter_options,
+	filter_object_fn *filter_fn,
+	filter_free_fn *filter_free_fn)
+{
+	struct filter_blobs_none_data *d = xcalloc(1, sizeof(*d));
+	d->omits = omitted;
+
+	*filter_fn = filter_blobs_none;
+	*filter_free_fn = free;
+	return d;
+}
+
+/*
+ * A filter for list-objects to omit large blobs,
+ * but always include ".git*" special files.
+ * And to OPTIONALLY collect a list of the omitted OIDs.
+ */
+struct filter_blobs_limit_data {
+	struct oidset *omits;
+	unsigned long max_bytes;
+};
+
+static enum list_objects_filter_result filter_blobs_limit(
+	enum list_objects_filter_type filter_type,
+	struct object *obj,
+	const char *pathname,
+	const char *filename,
+	void *filter_data_)
+{
+	struct filter_blobs_limit_data *filter_data = filter_data_;
+	unsigned long object_length;
+	enum object_type t;
+	int is_special_filename;
+
+	switch (filter_type) {
+	default:
+		die("unkown filter_type");
+		return LOFR_ZERO;
+
+	case LOFT_BEGIN_TREE:
+		assert(obj->type == OBJ_TREE);
+		/* always include all tree objects */
+		return LOFR_MARK_SEEN | LOFR_SHOW;
+
+	case LOFT_END_TREE:
+		assert(obj->type == OBJ_TREE);
+		return LOFR_ZERO;
+
+	case LOFT_BLOB:
+		assert(obj->type == OBJ_BLOB);
+		assert((obj->flags & SEEN) == 0);
+
+		is_special_filename = ((strncmp(filename, ".git", 4) == 0) &&
+				       filename[4]);
+		if (is_special_filename) {
+			/*
+			 * Alwayse include ".git*" special files (regardless
+			 * of size).
+			 *
+			 * (This may cause us to include blobs that we do
+			 * not have locally because we are only looking at
+			 * the filename and don't actually have to read
+			 * them.)
+			 */
+			goto include_it;
+		}
+
+		t = sha1_object_info(obj->oid.hash, &object_length);
+		if (t != OBJ_BLOB) { /* probably OBJ_NONE */
+			/*
+			 * We DO NOT have the blob locally, so we cannot
+			 * apply the size filter criteria.  Be conservative
+			 * and force show it (and let the caller deal with
+			 * the ambiguity).  (This matches the behavior above
+			 * when the special filename matches.)
+			 */
+			goto include_it;
+		}
+
+		if (object_length < filter_data->max_bytes)
+			goto include_it;
+
+		/*
+		 * Provisionally omit it.  We've already established
+		 * that this blob is too big and doesn't have a special
+		 * filename, so we *WANT* to omit it.  However, there
+		 * may be a special file elsewhere in the tree that
+		 * references this same blob, so we cannot reject it
+		 * just yet.  Leave the LOFR_ bits unset so that *IF*
+		 * the blob appears again in the traversal, we will
+		 * be asked again.
+		 *
+		 * If we are keeping a list of the ommitted objects,
+		 * provisionally add it to the list.
+		 */
+
+		if (filter_data->omits)
+			oidset_insert(filter_data->omits, &obj->oid);
+		return LOFR_ZERO;
+	}
+
+include_it:
+	if (filter_data->omits)
+		oidset_remove(filter_data->omits, &obj->oid);
+	return LOFR_MARK_SEEN | LOFR_SHOW;
+}
+
+static void *filter_blobs_limit__init(
+	struct oidset *omitted,
+	struct list_objects_filter_options *filter_options,
+	filter_object_fn *filter_fn,
+	filter_free_fn *filter_free_fn)
+{
+	struct filter_blobs_limit_data *d = xcalloc(1, sizeof(*d));
+	d->omits = omitted;
+	d->max_bytes = filter_options->blob_limit_value;
+
+	*filter_fn = filter_blobs_limit;
+	*filter_free_fn = free;
+	return d;
+}
+
+/*
+ * A filter driven by a sparse-checkout specification to only
+ * include blobs that a sparse checkout would populate.
+ *
+ * The sparse-checkout spec can be loaded from a blob with the
+ * given OID or from a local pathname.  We allow an OID because
+ * the repo may be bare or we may be doing the filtering on the
+ * server.
+ */
+struct frame {
+	int defval;
+	int child_prov_omit : 1;
+};
+
+struct filter_sparse_data {
+	struct oidset *omits;
+	struct exclude_list el;
+
+	size_t nr, alloc;
+	struct frame *array_frame;
+};
+
+static enum list_objects_filter_result filter_sparse(
+	enum list_objects_filter_type filter_type,
+	struct object *obj,
+	const char *pathname,
+	const char *filename,
+	void *filter_data_)
+{
+	struct filter_sparse_data *filter_data = filter_data_;
+	int val, dtype;
+	struct frame *frame;
+
+	switch (filter_type) {
+	default:
+		die("unkown filter_type");
+		return LOFR_ZERO;
+
+	case LOFT_BEGIN_TREE:
+		assert(obj->type == OBJ_TREE);
+		dtype = DT_DIR;
+		val = is_excluded_from_list(pathname, strlen(pathname),
+					    filename, &dtype, &filter_data->el,
+					    &the_index);
+		if (val < 0)
+			val = filter_data->array_frame[filter_data->nr].defval;
+
+		ALLOC_GROW(filter_data->array_frame, filter_data->nr + 1,
+			   filter_data->alloc);
+		filter_data->nr++;
+		filter_data->array_frame[filter_data->nr].defval = val;
+		filter_data->array_frame[filter_data->nr].child_prov_omit = 0;
+
+		/*
+		 * A directory with this tree OID may appear in multiple
+		 * places in the tree. (Think of a directory move, with
+		 * no other changes.)  And with a different pathname, the
+		 * is_excluded...() results for this directory and items
+		 * contained within it may be different.  So we cannot
+		 * mark it SEEN (yet), since that will prevent process_tree()
+		 * from revisiting this tree object with other pathnames.
+		 *
+		 * Only SHOW the tree object the first time we visit this
+		 * tree object.
+		 *
+		 * We always show all tree objects.  A future optimization
+		 * may want to attempt to narrow this.
+		 */
+		if (obj->flags & FILTER_REVISIT)
+			return LOFR_ZERO;
+		obj->flags |= FILTER_REVISIT;
+		return LOFR_SHOW;
+
+	case LOFT_END_TREE:
+		assert(obj->type == OBJ_TREE);
+		assert(filter_data->nr > 0);
+
+		frame = &filter_data->array_frame[filter_data->nr];
+		filter_data->nr--;
+
+		/*
+		 * Tell our parent directory if any of our children were
+		 * provisionally omitted.
+		 */
+		filter_data->array_frame[filter_data->nr].child_prov_omit |=
+			frame->child_prov_omit;
+
+		/*
+		 * If there are NO provisionally omitted child objects (ALL child
+		 * objects in this folder were INCLUDED), then we can mark the
+		 * folder as SEEN (so we will not have to revisit it again).
+		 */
+		if (!frame->child_prov_omit)
+			return LOFR_MARK_SEEN;
+		return LOFR_ZERO;
+
+	case LOFT_BLOB:
+		assert(obj->type == OBJ_BLOB);
+		assert((obj->flags & SEEN) == 0);
+
+		frame = &filter_data->array_frame[filter_data->nr];
+
+		dtype = DT_REG;
+		val = is_excluded_from_list(pathname, strlen(pathname),
+					    filename, &dtype, &filter_data->el,
+					    &the_index);
+		if (val < 0)
+			val = frame->defval;
+		if (val > 0) {
+			if (filter_data->omits)
+				oidset_remove(filter_data->omits, &obj->oid);
+			return LOFR_MARK_SEEN | LOFR_SHOW;
+		}
+
+		/*
+		 * Provisionally omit it.  We've already established that
+		 * this pathname is not in the sparse-checkout specification
+		 * with the CURRENT pathname, so we *WANT* to omit this blob.
+		 *
+		 * However, a pathname elsewhere in the tree may also
+		 * reference this same blob, so we cannot reject it yet.
+		 * Leave the LOFR_ bits unset so that if the blob appears
+		 * again in the traversal, we will be asked again.
+		 */
+		if (filter_data->omits)
+			oidset_insert(filter_data->omits, &obj->oid);
+
+		/*
+		 * Remember that at least 1 blob in this tree was
+		 * provisionally omitted.  This prevents us from short
+		 * cutting the tree in future iterations.
+		 */
+		frame->child_prov_omit = 1;
+		return LOFR_ZERO;
+	}
+}
+
+
+static void filter_sparse_free(void *filter_data)
+{
+	struct filter_sparse_data *d = filter_data;
+	/* TODO free contents of 'd' */
+	free(d);
+}
+
+static void *filter_sparse_oid__init(
+	struct oidset *omitted,
+	struct list_objects_filter_options *filter_options,
+	filter_object_fn *filter_fn,
+	filter_free_fn *filter_free_fn)
+{
+	struct filter_sparse_data *d = xcalloc(1, sizeof(*d));
+	d->omits = omitted;
+	if (add_excludes_from_blob_to_list(filter_options->sparse_oid_value,
+					   NULL, 0, &d->el) < 0)
+		die("could not load filter specification");
+
+	ALLOC_GROW(d->array_frame, d->nr + 1, d->alloc);
+	d->array_frame[d->nr].defval = 0; /* default to include */
+	d->array_frame[d->nr].child_prov_omit = 0;
+
+	*filter_fn = filter_sparse;
+	*filter_free_fn = filter_sparse_free;
+	return d;
+}
+
+static void *filter_sparse_path__init(
+	struct oidset *omitted,
+	struct list_objects_filter_options *filter_options,
+	filter_object_fn *filter_fn,
+	filter_free_fn *filter_free_fn)
+{
+	struct filter_sparse_data *d = xcalloc(1, sizeof(*d));
+	d->omits = omitted;
+	if (add_excludes_from_file_to_list(filter_options->sparse_path_value,
+					   NULL, 0, &d->el, NULL) < 0)
+		die("could not load filter specification");
+
+	ALLOC_GROW(d->array_frame, d->nr + 1, d->alloc);
+	d->array_frame[d->nr].defval = 0; /* default to include */
+	d->array_frame[d->nr].child_prov_omit = 0;
+
+	*filter_fn = filter_sparse;
+	*filter_free_fn = filter_sparse_free;
+	return d;
+}
+
+typedef void *(*filter_init_fn)(
+	struct oidset *omitted,
+	struct list_objects_filter_options *filter_options,
+	filter_object_fn *filter_fn,
+	filter_free_fn *filter_free_fn);
+
+/*
+ * Must match "enum list_objects_filter_choice".
+ */
+static filter_init_fn s_filters[] = {
+	NULL,
+	filter_blobs_none__init,
+	filter_blobs_limit__init,
+	filter_sparse_oid__init,
+	filter_sparse_path__init,
+};
+
+void *list_objects_filter__init(
+	struct oidset *omitted,
+	struct list_objects_filter_options *filter_options,
+	filter_object_fn *filter_fn,
+	filter_free_fn *filter_free_fn)
+{
+	filter_init_fn init_fn;
+
+	assert((sizeof(s_filters) / sizeof(s_filters[0])) == LOFC__COUNT);
+
+	if (filter_options->choice >= LOFC__COUNT)
+		die("invalid list-objects filter choice: %d",
+		    filter_options->choice);
+
+	init_fn = s_filters[filter_options->choice];
+	if (init_fn)
+		return init_fn(omitted, filter_options,
+			       filter_fn, filter_free_fn);
+	*filter_fn = NULL;
+	*filter_free_fn = NULL;
+	return NULL;
+}
diff --git a/list-objects-filter.h b/list-objects-filter.h
new file mode 100644
index 0000000..f30a514
--- /dev/null
+++ b/list-objects-filter.h
@@ -0,0 +1,84 @@
+#ifndef LIST_OBJECTS_FILTER_H
+#define LIST_OBJECTS_FILTER_H
+
+/*
+ * During list-object traversal we allow certain objects to be
+ * filtered (omitted) from the result.  The active filter uses
+ * these result values to guide list-objects.
+ *
+ * _ZERO      : Do nothing with the object at this time.  It may
+ *              be revisited if it appears in another place in
+ *              the tree or in another commit during the overall
+ *              traversal.
+ *
+ * _MARK_SEEN : Mark this object as "SEEN" in the object flags.
+ *              This will prevent it from being revisited during
+ *              the remainder of the traversal.  This DOES NOT
+ *              imply that it will be included in the results.
+ *
+ * _SHOW      : Show this object in the results (call show() on it).
+ *              In general, objects should only be shown once, but
+ *              this result DOES NOT imply that we mark it SEEN.
+ *
+ * Most of the time, you want the combination (_MARK_SEEN | _SHOW)
+ * but they can be used independently, such as when sparse-checkout
+ * pattern matching is being applied.
+ *
+ * A _MARK_SEEN without _SHOW can be called a hard-omit -- the
+ * object is not shown and will never be reconsidered (unless a
+ * previous iteration has already shown it).
+ *
+ * A _ZERO is can be called a provisional-omit -- the object is
+ * not shown, but *may* be revisited (if the object appears again
+ * in the traversal).  Therefore, it will be omitted from the
+ * results *unless* a later iteration causes it to be shown.
+ */
+enum list_objects_filter_result {
+	LOFR_ZERO      = 0,
+	LOFR_MARK_SEEN = 1<<0,
+	LOFR_SHOW      = 1<<1,
+};
+
+enum list_objects_filter_type {
+	LOFT_BEGIN_TREE,
+	LOFT_END_TREE,
+	LOFT_BLOB
+};
+
+typedef enum list_objects_filter_result (*filter_object_fn)(
+	enum list_objects_filter_type filter_type,
+	struct object *obj,
+	const char *pathname,
+	const char *filename,
+	void *filter_data);
+
+typedef void (*filter_free_fn)(void *filter_data);
+
+struct oidset;
+struct list_objects_filter_options;
+
+void traverse_commit_list_filtered(
+	struct list_objects_filter_options *filter_options,
+	struct rev_info *revs,
+	show_commit_fn show_commit,
+	show_object_fn show_object,
+	void *show_data,
+	struct oidset *omitted);
+
+/*
+ * Constructor for the set of defined list-objects filters.
+ * Returns a generic "void *filter_data".
+ *
+ * The returned "filter_fn" will be used by traverse_commit_list()
+ * to filter the results.
+ *
+ * The returned "filter_free_fn" is a destructor for the
+ * filter_data.
+ */
+void *list_objects_filter__init(
+	struct oidset *omitted,
+	struct list_objects_filter_options *filter_options,
+	filter_object_fn *filter_fn,
+	filter_free_fn *filter_free_fn);
+
+#endif /* LIST_OBJECTS_FILTER_H */
diff --git a/list-objects.c b/list-objects.c
index b3931fa..848b040 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -7,16 +7,21 @@
 #include "tree-walk.h"
 #include "revision.h"
 #include "list-objects.h"
+#include "list-objects-filter.h"
+#include "list-objects-filter-options.h"
 
 static void process_blob(struct rev_info *revs,
 			 struct blob *blob,
 			 show_object_fn show,
 			 struct strbuf *path,
 			 const char *name,
-			 void *cb_data)
+			 void *cb_data,
+			 filter_object_fn filter_fn,
+			 void *filter_data)
 {
 	struct object *obj = &blob->object;
 	size_t pathlen;
+	enum list_objects_filter_result r = LOFR_MARK_SEEN | LOFR_SHOW;
 
 	if (!revs->blob_objects)
 		return;
@@ -24,11 +29,17 @@ static void process_blob(struct rev_info *revs,
 		die("bad blob object");
 	if (obj->flags & (UNINTERESTING | SEEN))
 		return;
-	obj->flags |= SEEN;
 
 	pathlen = path->len;
 	strbuf_addstr(path, name);
-	show(obj, path->buf, cb_data);
+	if (filter_fn)
+		r = filter_fn(LOFT_BLOB, obj,
+			      path->buf, &path->buf[pathlen],
+			      filter_data);
+	if (r & LOFR_MARK_SEEN)
+		obj->flags |= SEEN;
+	if (r & LOFR_SHOW)
+		show(obj, path->buf, cb_data);
 	strbuf_setlen(path, pathlen);
 }
 
@@ -69,7 +80,9 @@ static void process_tree(struct rev_info *revs,
 			 show_object_fn show,
 			 struct strbuf *base,
 			 const char *name,
-			 void *cb_data)
+			 void *cb_data,
+			 filter_object_fn filter_fn,
+			 void *filter_data)
 {
 	struct object *obj = &tree->object;
 	struct tree_desc desc;
@@ -77,6 +90,7 @@ static void process_tree(struct rev_info *revs,
 	enum interesting match = revs->diffopt.pathspec.nr == 0 ?
 		all_entries_interesting: entry_not_interesting;
 	int baselen = base->len;
+	enum list_objects_filter_result r = LOFR_MARK_SEEN | LOFR_SHOW;
 
 	if (!revs->tree_objects)
 		return;
@@ -90,9 +104,15 @@ static void process_tree(struct rev_info *revs,
 		die("bad tree object %s", oid_to_hex(&obj->oid));
 	}
 
-	obj->flags |= SEEN;
 	strbuf_addstr(base, name);
-	show(obj, base->buf, cb_data);
+	if (filter_fn)
+		r = filter_fn(LOFT_BEGIN_TREE, obj,
+			      base->buf, &base->buf[baselen],
+			      filter_data);
+	if (r & LOFR_MARK_SEEN)
+		obj->flags |= SEEN;
+	if (r & LOFR_SHOW)
+		show(obj, base->buf, cb_data);
 	if (base->len)
 		strbuf_addch(base, '/');
 
@@ -112,7 +132,7 @@ static void process_tree(struct rev_info *revs,
 			process_tree(revs,
 				     lookup_tree(entry.oid),
 				     show, base, entry.path,
-				     cb_data);
+				     cb_data, filter_fn, filter_data);
 		else if (S_ISGITLINK(entry.mode))
 			process_gitlink(revs, entry.oid->hash,
 					show, base, entry.path,
@@ -121,8 +141,19 @@ static void process_tree(struct rev_info *revs,
 			process_blob(revs,
 				     lookup_blob(entry.oid),
 				     show, base, entry.path,
-				     cb_data);
+				     cb_data, filter_fn, filter_data);
 	}
+
+	if (filter_fn) {
+		r = filter_fn(LOFT_END_TREE, obj,
+			      base->buf, &base->buf[baselen],
+			      filter_data);
+		if (r & LOFR_MARK_SEEN)
+			obj->flags |= SEEN;
+		if (r & LOFR_SHOW)
+			show(obj, base->buf, cb_data);
+	}
+
 	strbuf_setlen(base, baselen);
 	free_tree_buffer(tree);
 }
@@ -183,10 +214,12 @@ static void add_pending_tree(struct rev_info *revs, struct tree *tree)
 	add_pending_object(revs, &tree->object, "");
 }
 
-void traverse_commit_list(struct rev_info *revs,
-			  show_commit_fn show_commit,
-			  show_object_fn show_object,
-			  void *data)
+static void do_traverse(struct rev_info *revs,
+			show_commit_fn show_commit,
+			show_object_fn show_object,
+			void *show_data,
+			filter_object_fn filter_fn,
+			void *filter_data)
 {
 	int i;
 	struct commit *commit;
@@ -200,7 +233,7 @@ void traverse_commit_list(struct rev_info *revs,
 		 */
 		if (commit->tree)
 			add_pending_tree(revs, commit->tree);
-		show_commit(commit, data);
+		show_commit(commit, show_data);
 	}
 	for (i = 0; i < revs->pending.nr; i++) {
 		struct object_array_entry *pending = revs->pending.objects + i;
@@ -211,19 +244,21 @@ void traverse_commit_list(struct rev_info *revs,
 			continue;
 		if (obj->type == OBJ_TAG) {
 			obj->flags |= SEEN;
-			show_object(obj, name, data);
+			show_object(obj, name, show_data);
 			continue;
 		}
 		if (!path)
 			path = "";
 		if (obj->type == OBJ_TREE) {
 			process_tree(revs, (struct tree *)obj, show_object,
-				     &base, path, data);
+				     &base, path, show_data,
+				     filter_fn, filter_data);
 			continue;
 		}
 		if (obj->type == OBJ_BLOB) {
 			process_blob(revs, (struct blob *)obj, show_object,
-				     &base, path, data);
+				     &base, path, show_data,
+				     filter_fn, filter_data);
 			continue;
 		}
 		die("unknown pending object %s (%s)",
@@ -232,3 +267,31 @@ void traverse_commit_list(struct rev_info *revs,
 	object_array_clear(&revs->pending);
 	strbuf_release(&base);
 }
+
+void traverse_commit_list(struct rev_info *revs,
+			  show_commit_fn show_commit,
+			  show_object_fn show_object,
+			  void *show_data)
+{
+	do_traverse(revs, show_commit, show_object, show_data, NULL, NULL);
+}
+
+void traverse_commit_list_filtered(
+	struct list_objects_filter_options *filter_options,
+	struct rev_info *revs,
+	show_commit_fn show_commit,
+	show_object_fn show_object,
+	void *show_data,
+	struct oidset *omitted)
+{
+	filter_object_fn filter_fn = NULL;
+	filter_free_fn filter_free_fn = NULL;
+	void *filter_data = NULL;
+
+	filter_data = list_objects_filter__init(omitted, filter_options,
+						&filter_fn, &filter_free_fn);
+	do_traverse(revs, show_commit, show_object, show_data,
+		    filter_fn, filter_data);
+	if (filter_data && filter_free_fn)
+		filter_free_fn(filter_data);
+}
diff --git a/list-objects.h b/list-objects.h
index 0cebf85..33c964c 100644
--- a/list-objects.h
+++ b/list-objects.h
@@ -8,4 +8,4 @@ void traverse_commit_list(struct rev_info *, show_commit_fn, show_object_fn, voi
 typedef void (*show_edge_fn)(struct commit *);
 void mark_edges_uninteresting(struct rev_info *, show_edge_fn);
 
-#endif
+#endif /* LIST_OBJECTS_H */
-- 
2.9.3

