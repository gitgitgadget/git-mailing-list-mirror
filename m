Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA956202A0
	for <e@80x24.org>; Tue,  7 Nov 2017 19:36:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752456AbdKGTgO (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Nov 2017 14:36:14 -0500
Received: from siwi.pair.com ([209.68.5.199]:40503 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751830AbdKGTgB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Nov 2017 14:36:01 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id EB51284540;
        Tue,  7 Nov 2017 14:36:00 -0500 (EST)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 3810D84537;
        Tue,  7 Nov 2017 14:36:00 -0500 (EST)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v3 4/6] list-objects: filter objects in traverse_commit_list
Date:   Tue,  7 Nov 2017 19:35:44 +0000
Message-Id: <20171107193546.10017-5-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20171107193546.10017-1-git@jeffhostetler.com>
References: <20171107193546.10017-1-git@jeffhostetler.com>
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
If a packfile bitmap is present, it will not be used.  It
should be possible to extend such support in the future (at
least to simple filters that do not require object pathnames),
but that is beyond the scope of this patch series.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Makefile                      |   2 +
 list-objects-filter-options.c | 148 ++++++++++++++++
 list-objects-filter-options.h |  50 ++++++
 list-objects-filter.c         | 401 ++++++++++++++++++++++++++++++++++++++++++
 list-objects-filter.h         |  77 ++++++++
 list-objects.c                |  95 ++++++++--
 list-objects.h                |  13 +-
 object.h                      |   1 +
 8 files changed, 770 insertions(+), 17 deletions(-)
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
index 0000000..21c4830
--- /dev/null
+++ b/list-objects-filter-options.c
@@ -0,0 +1,148 @@
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
+ * Reject the arg if it contains any characters that might
+ * require quoting or escaping when handing to a sub-command.
+ */
+static int reject_injection_chars(const char *arg)
+{
+	const unsigned char *p;
+
+	for (p = (const unsigned char *)arg; *p; p++) {
+		if (*p < 0x20) /* control character */
+			return 1;
+		if (*p >= '0' && *p <= '9')
+			continue;
+		if (*p >= 'A' && *p <= 'Z')
+			continue;
+		if (*p >= 'a' && *p <= 'z')
+			continue;
+		if (*p >= 0x80)
+			continue;
+
+		switch (*p) {
+		case ' ': return 1; /* 0x20 */
+		case '!': continue; /* 0x21 */
+		case '"': return 1; /* 0x22 */
+		case '#': return 1; /* 0x23 */
+		case '$': return 1; /* 0x24 */
+		case '%': continue; /* 0x25 */
+		case '&': return 1; /* 0x26 */
+		case '\'':return 1; /* 0x27 */
+		case '(': continue; /* 0x28 */
+		case ')': continue; /* 0x29 */
+		case '*': return 1; /* 0x2a */
+		case '+': return 1; /* 0x2b */
+		case ',': continue; /* 0x2c */
+		case '-': continue; /* 0x2d */
+		case '.': continue; /* 0x2e */
+		case '/': continue; /* 0x2f */
+
+		case ':': continue; /* 0x3a */
+		case ';': return 1; /* 0x3b */
+		case '<': return 1; /* 0x3c */
+		case '=': continue; /* 0x3d */
+		case '>': return 1; /* 0x3e */
+		case '?': continue; /* 0x3f */
+
+		case '@': continue; /* 0x40 */
+
+		case '[': continue; /* 0x5b */
+		case '\\':return 1; /* 0x5c */
+		case ']': continue; /* 0x5d */
+		case '^': continue; /* 0x5e */
+		case '_': continue; /* 0x5f */
+
+		case '`': return 1; /* 0x60 */
+
+		case '{': continue; /* 0x7b */
+		case '|': return 1; /* 0x7c */
+		case '}': continue; /* 0x7d */
+		case '~': continue; /* 0x7e */
+		case 0x7f:return 1; /* 0x7f */
+		default:  continue;
+		}
+	}
+	return 0;
+}
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
+	const char *v0;
+	const char *v1;
+
+	if (filter_options->choice)
+		die(_("multiple object filter types cannot be combined"));
+
+	if (reject_injection_chars(arg))
+		die(_("invalid character in filter-spec"));
+
+	filter_options->raw_value = strdup(arg);
+
+	if (skip_prefix(arg, "blob:", &v0)) {
+
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
+
+	} else if (skip_prefix(arg, "sparse:", &v0)) {
+
+		if (skip_prefix(v0, "oid=", &v1)) {
+			struct object_context oc;
+			struct object_id sparse_oid;
+			filter_options->choice = LOFC_SPARSE_OID;
+			if (!get_oid_with_context(v1, GET_OID_BLOB,
+						  &sparse_oid, &oc))
+				filter_options->sparse_oid_value =
+					oiddup(&sparse_oid);
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
+	die(_("invalid filter-spec expression '%s'"), arg);
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
diff --git a/list-objects-filter-options.h b/list-objects-filter-options.h
new file mode 100644
index 0000000..bdb8afc
--- /dev/null
+++ b/list-objects-filter-options.h
@@ -0,0 +1,50 @@
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
+#endif /* LIST_OBJECTS_FILTER_OPTIONS_H */
diff --git a/list-objects-filter.c b/list-objects-filter.c
new file mode 100644
index 0000000..4356c45
--- /dev/null
+++ b/list-objects-filter.c
@@ -0,0 +1,401 @@
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
+/* Remember to update object flag allocation in object.h */
+/*
+ * FILTER_SHOWN_BUT_REVISIT -- we set this bit on tree objects
+ * that have been shown, but should be revisited if they appear
+ * in the traversal (until we mark it SEEN).  This is a way to
+ * let us silently de-dup calls to show() in the caller.  This
+ * is subtly different from the "revision.h:SHOWN" and the
+ * "sha1_name.c:ONELINE_SEEN" bits.  And also different from
+ * the non-de-dup usage in pack-bitmap.c
+ */
+#define FILTER_SHOWN_BUT_REVISIT (1<<21)
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
+	enum list_objects_filter_situation filter_situation,
+	struct object *obj,
+	const char *pathname,
+	const char *filename,
+	void *filter_data_)
+{
+	struct filter_blobs_none_data *filter_data = filter_data_;
+
+	switch (filter_situation) {
+	default:
+		die("unknown filter_situation");
+		return LOFR_ZERO;
+
+	case LOFS_BEGIN_TREE:
+		assert(obj->type == OBJ_TREE);
+		/* always include all tree objects */
+		return LOFR_MARK_SEEN | LOFR_DO_SHOW;
+
+	case LOFS_END_TREE:
+		assert(obj->type == OBJ_TREE);
+		return LOFR_ZERO;
+
+	case LOFS_BLOB:
+		assert(obj->type == OBJ_BLOB);
+		assert((obj->flags & SEEN) == 0);
+
+		if (filter_data->omits)
+			oidset_insert(filter_data->omits, &obj->oid);
+		return LOFR_MARK_SEEN; /* but not LOFR_DO_SHOW (hard omit) */
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
+ * A filter for list-objects to omit large blobs.
+ * And to OPTIONALLY collect a list of the omitted OIDs.
+ */
+struct filter_blobs_limit_data {
+	struct oidset *omits;
+	unsigned long max_bytes;
+};
+
+static enum list_objects_filter_result filter_blobs_limit(
+	enum list_objects_filter_situation filter_situation,
+	struct object *obj,
+	const char *pathname,
+	const char *filename,
+	void *filter_data_)
+{
+	struct filter_blobs_limit_data *filter_data = filter_data_;
+	unsigned long object_length;
+	enum object_type t;
+
+	switch (filter_situation) {
+	default:
+		die("unknown filter_situation");
+		return LOFR_ZERO;
+
+	case LOFS_BEGIN_TREE:
+		assert(obj->type == OBJ_TREE);
+		/* always include all tree objects */
+		return LOFR_MARK_SEEN | LOFR_DO_SHOW;
+
+	case LOFS_END_TREE:
+		assert(obj->type == OBJ_TREE);
+		return LOFR_ZERO;
+
+	case LOFS_BLOB:
+		assert(obj->type == OBJ_BLOB);
+		assert((obj->flags & SEEN) == 0);
+
+		t = sha1_object_info(obj->oid.hash, &object_length);
+		if (t != OBJ_BLOB) { /* probably OBJ_NONE */
+			/*
+			 * We DO NOT have the blob locally, so we cannot
+			 * apply the size filter criteria.  Be conservative
+			 * and force show it (and let the caller deal with
+			 * the ambiguity).
+			 */
+			goto include_it;
+		}
+
+		if (object_length < filter_data->max_bytes)
+			goto include_it;
+
+		if (filter_data->omits)
+			oidset_insert(filter_data->omits, &obj->oid);
+		return LOFR_MARK_SEEN; /* but not LOFR_DO_SHOW (hard omit) */
+	}
+
+include_it:
+	if (filter_data->omits)
+		oidset_remove(filter_data->omits, &obj->oid);
+	return LOFR_MARK_SEEN | LOFR_DO_SHOW;
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
+	/*
+	 * defval is the usual default include/exclude value that
+	 * should be inherited as we recurse into directories based
+	 * upon pattern matching of the directory itself or of a
+	 * containing directory.
+	 */
+	int defval;
+
+	/*
+	 * 1 if the directory (recursively) contains any provisionally
+	 * omitted objects.
+	 *
+	 * 0 if everything (recursively) contained in this directory
+	 * has been explicitly included (SHOWN) in the result and
+	 * the directory may be short-cut later in the traversal.
+	 */
+	unsigned child_prov_omit : 1;
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
+	enum list_objects_filter_situation filter_situation,
+	struct object *obj,
+	const char *pathname,
+	const char *filename,
+	void *filter_data_)
+{
+	struct filter_sparse_data *filter_data = filter_data_;
+	int val, dtype;
+	struct frame *frame;
+
+	switch (filter_situation) {
+	default:
+		die("unknown filter_situation");
+		return LOFR_ZERO;
+
+	case LOFS_BEGIN_TREE:
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
+		 * places in the tree. (Think of a directory move or copy,
+		 * with no other changes, so the OID is the same, but the
+		 * full pathnames of objects within this directory are new
+		 * and may match is_excluded() patterns differently.)
+		 * So we cannot mark this directory as SEEN (yet), since
+		 * that will prevent process_tree() from revisiting this
+		 * tree object with other pathname prefixes.
+		 *
+		 * Only _DO_SHOW the tree object the first time we visit
+		 * this tree object.
+		 *
+		 * We always show all tree objects.  A future optimization
+		 * may want to attempt to narrow this.
+		 */
+		if (obj->flags & FILTER_SHOWN_BUT_REVISIT)
+			return LOFR_ZERO;
+		obj->flags |= FILTER_SHOWN_BUT_REVISIT;
+		return LOFR_DO_SHOW;
+
+	case LOFS_END_TREE:
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
+	case LOFS_BLOB:
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
+			return LOFR_MARK_SEEN | LOFR_DO_SHOW;
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
index 0000000..a963d02
--- /dev/null
+++ b/list-objects-filter.h
@@ -0,0 +1,77 @@
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
+ * _DO_SHOW   : Show this object in the results (call show() on it).
+ *              In general, objects should only be shown once, but
+ *              this result DOES NOT imply that we mark it SEEN.
+ *
+ * Most of the time, you want the combination (_MARK_SEEN | _DO_SHOW)
+ * but they can be used independently, such as when sparse-checkout
+ * pattern matching is being applied.
+ *
+ * A _MARK_SEEN without _DO_SHOW can be called a hard-omit -- the
+ * object is not shown and will never be reconsidered (unless a
+ * previous iteration has already shown it).
+ *
+ * A _DO_SHOW without _MARK_SEEN can be used, for example, to
+ * include a directory, but then revisit it to selectively include
+ * or omit objects within it.
+ *
+ * A _ZERO can be called a provisional-omit -- the object is NOT shown,
+ * but *may* be revisited (if the object appears again in the traversal).
+ * Therefore, it will be omitted from the results *unless* a later
+ * iteration causes it to be shown.
+ */
+enum list_objects_filter_result {
+	LOFR_ZERO      = 0,
+	LOFR_MARK_SEEN = 1<<0,
+	LOFR_DO_SHOW   = 1<<1,
+};
+
+enum list_objects_filter_situation {
+	LOFS_BEGIN_TREE,
+	LOFS_END_TREE,
+	LOFS_BLOB
+};
+
+typedef enum list_objects_filter_result (*filter_object_fn)(
+	enum list_objects_filter_situation filter_situation,
+	struct object *obj,
+	const char *pathname,
+	const char *filename,
+	void *filter_data);
+
+typedef void (*filter_free_fn)(void *filter_data);
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
index b3931fa..d9e83d0 100644
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
+	enum list_objects_filter_result r = LOFR_MARK_SEEN | LOFR_DO_SHOW;
 
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
+		r = filter_fn(LOFS_BLOB, obj,
+			      path->buf, &path->buf[pathlen],
+			      filter_data);
+	if (r & LOFR_MARK_SEEN)
+		obj->flags |= SEEN;
+	if (r & LOFR_DO_SHOW)
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
+	enum list_objects_filter_result r = LOFR_MARK_SEEN | LOFR_DO_SHOW;
 
 	if (!revs->tree_objects)
 		return;
@@ -90,9 +104,15 @@ static void process_tree(struct rev_info *revs,
 		die("bad tree object %s", oid_to_hex(&obj->oid));
 	}
 
-	obj->flags |= SEEN;
 	strbuf_addstr(base, name);
-	show(obj, base->buf, cb_data);
+	if (filter_fn)
+		r = filter_fn(LOFS_BEGIN_TREE, obj,
+			      base->buf, &base->buf[baselen],
+			      filter_data);
+	if (r & LOFR_MARK_SEEN)
+		obj->flags |= SEEN;
+	if (r & LOFR_DO_SHOW)
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
+		r = filter_fn(LOFS_END_TREE, obj,
+			      base->buf, &base->buf[baselen],
+			      filter_data);
+		if (r & LOFR_MARK_SEEN)
+			obj->flags |= SEEN;
+		if (r & LOFR_DO_SHOW)
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
index 0cebf85..aa618d7 100644
--- a/list-objects.h
+++ b/list-objects.h
@@ -8,4 +8,15 @@ void traverse_commit_list(struct rev_info *, show_commit_fn, show_object_fn, voi
 typedef void (*show_edge_fn)(struct commit *);
 void mark_edges_uninteresting(struct rev_info *, show_edge_fn);
 
-#endif
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
+#endif /* LIST_OBJECTS_H */
diff --git a/object.h b/object.h
index df8abe9..f34461d 100644
--- a/object.h
+++ b/object.h
@@ -38,6 +38,7 @@ struct object_array {
  * http-push.c:                            16-----19
  * commit.c:                               16-----19
  * sha1_name.c:                                     20
+ * list-objects-filter.c:                             21
  * builtin/fsck.c:  0--3
  */
 #define FLAG_BITS  27
-- 
2.9.3

