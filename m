Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AB33202D7
	for <e@80x24.org>; Wed,  8 Mar 2017 17:46:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754066AbdCHRqe (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 12:46:34 -0500
Received: from siwi.pair.com ([209.68.5.199]:46816 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754002AbdCHRp7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 12:45:59 -0500
Received: from jeffhostetler.2jll4ugiwlvuzhh55dqabi0nia.bx.internal.cloudapp.net (unknown [40.76.14.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 65A9C84650;
        Wed,  8 Mar 2017 12:38:48 -0500 (EST)
From:   Jeff Hostetler <jeffhost@microsoft.com>
To:     git@vger.kernel.org
Cc:     jeffhost@microsoft.com, peff@peff.net, gitster@pobox.com,
        markbt@efaref.net, benpeart@microsoft.com,
        jonathantanmy@google.com, Jeff Hostetler <git@jeffhostetler.com>
Subject: [PATCH 10/10] ls-partial: created command to list missing blobs
Date:   Wed,  8 Mar 2017 17:38:05 +0000
Message-Id: <1488994685-37403-11-git-send-email-jeffhost@microsoft.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1488994685-37403-1-git-send-email-jeffhost@microsoft.com>
References: <1488994685-37403-1-git-send-email-jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <git@jeffhostetler.com>

Added a command to list the missing blobs for a commit.
This can be used after a partial clone or fetch to list
the omitted blobs that the client would need to checkout
the given commit/branch.  Optionally respecting or ignoring
the current sparse-checkout definition.

This command prints a simple list of blob SHAs.  It is
expected that this would be piped into another command
with knowledge of the transport and/or blob store.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Makefile             |   2 +
 builtin.h            |   1 +
 builtin/ls-partial.c | 110 ++++++++++++++++++++
 git.c                |   1 +
 partial-utils.c      | 279 +++++++++++++++++++++++++++++++++++++++++++++++++++
 partial-utils.h      |  93 +++++++++++++++++
 6 files changed, 486 insertions(+)
 create mode 100644 builtin/ls-partial.c
 create mode 100644 partial-utils.c
 create mode 100644 partial-utils.h

diff --git a/Makefile b/Makefile
index 9ec6065..96e9e1e 100644
--- a/Makefile
+++ b/Makefile
@@ -791,6 +791,7 @@ LIB_OBJS += pack-write.o
 LIB_OBJS += pager.o
 LIB_OBJS += parse-options.o
 LIB_OBJS += parse-options-cb.o
+LIB_OBJS += partial-utils.o
 LIB_OBJS += patch-delta.o
 LIB_OBJS += patch-ids.o
 LIB_OBJS += path.o
@@ -908,6 +909,7 @@ BUILTIN_OBJS += builtin/init-db.o
 BUILTIN_OBJS += builtin/interpret-trailers.o
 BUILTIN_OBJS += builtin/log.o
 BUILTIN_OBJS += builtin/ls-files.o
+BUILTIN_OBJS += builtin/ls-partial.o
 BUILTIN_OBJS += builtin/ls-remote.o
 BUILTIN_OBJS += builtin/ls-tree.o
 BUILTIN_OBJS += builtin/mailinfo.o
diff --git a/builtin.h b/builtin.h
index 9e4a898..df00c4b 100644
--- a/builtin.h
+++ b/builtin.h
@@ -79,6 +79,7 @@ extern int cmd_interpret_trailers(int argc, const char **argv, const char *prefi
 extern int cmd_log(int argc, const char **argv, const char *prefix);
 extern int cmd_log_reflog(int argc, const char **argv, const char *prefix);
 extern int cmd_ls_files(int argc, const char **argv, const char *prefix);
+extern int cmd_ls_partial(int argc, const char **argv, const char *prefix);
 extern int cmd_ls_tree(int argc, const char **argv, const char *prefix);
 extern int cmd_ls_remote(int argc, const char **argv, const char *prefix);
 extern int cmd_mailinfo(int argc, const char **argv, const char *prefix);
diff --git a/builtin/ls-partial.c b/builtin/ls-partial.c
new file mode 100644
index 0000000..8ebf045
--- /dev/null
+++ b/builtin/ls-partial.c
@@ -0,0 +1,110 @@
+#include "cache.h"
+#include "blob.h"
+#include "tree.h"
+#include "commit.h"
+#include "quote.h"
+#include "builtin.h"
+#include "parse-options.h"
+#include "pathspec.h"
+#include "dir.h"
+#include "partial-utils.h"
+
+static struct trace_key trace_partial = TRACE_KEY_INIT(PARTIAL);
+
+static int verbose;
+static int ignore_sparse;
+struct exclude_list el;
+
+static const char * const ls_partial_usage[] = {
+	N_("git ls-partial [<options>] <tree-ish>"),
+	NULL
+};
+
+/*
+ * map <tree-ish> arg into SHA1 and get the root treenode.
+ */
+static struct tree *lookup_tree_from_treeish(const char *arg)
+{
+	unsigned char sha1[20];
+	struct tree *tree;
+
+	if (get_sha1(arg, sha1))
+		die("not a valid object name '%s'", arg);
+
+	trace_printf_key(
+		&trace_partial,
+		"ls-partial: treeish '%s' '%s'\n",
+		arg, sha1_to_hex(sha1));
+
+	if (verbose) {
+		printf("commit\t%s\n", sha1_to_hex(sha1));
+		printf("branch\t%s\n", arg);
+	}
+	
+	tree = parse_tree_indirect(sha1);
+	if (!tree)
+		die("not a tree object '%s'", arg);
+
+	return tree;
+}
+
+static void print_results(const struct pu_vec *vec)
+{
+	int k;
+
+	for (k = 0; k < vec->data_nr; k++)
+		printf("%s\n", oid_to_hex(&vec->data[k]->oid));
+}
+
+static void print_results_verbose(const struct pu_vec *vec)
+{
+	int k;
+
+	/* TODO Consider -z version */
+
+	for (k = 0; k < vec->data_nr; k++)
+		printf("%s\t%s\n", oid_to_hex(&vec->data[k]->oid), vec->data[k]->fullpath.buf);
+}
+
+int cmd_ls_partial(int argc, const char **argv, const char *prefix)
+{
+	struct exclude_list el;
+	struct tree *tree;
+	struct pu_vec *vec;
+	struct pu_vec *vec_all = NULL;
+	struct pu_vec *vec_sparse = NULL;
+	struct pu_vec *vec_missing = NULL;
+	
+	const struct option ls_partial_options[] = {
+		OPT__VERBOSE(&verbose, N_("show verbose blob details")),
+		OPT_BOOL(0, "ignore-sparse", &ignore_sparse,
+				 N_("ignore sparse-checkout settings (scan whole tree)")),
+		OPT_END()
+	};
+
+	git_config(git_default_config, NULL);
+	argc = parse_options(argc, argv, prefix,
+						 ls_partial_options, ls_partial_usage, 0);
+	if (argc < 1)
+		usage_with_options(ls_partial_usage, ls_partial_options);
+
+	tree = lookup_tree_from_treeish(argv[0]);
+
+	vec_all = pu_vec_ls_tree(tree, prefix, argv + 1);
+	if (ignore_sparse || pu_load_sparse_definitions("info/sparse-checkout", &el) < 0)
+		vec = vec_all;
+	else {
+		vec_sparse = pu_vec_filter_sparse(vec_all, &el);
+		vec = vec_sparse;
+	}
+
+	vec_missing = pu_vec_filter_missing(vec);
+	vec = vec_missing;
+
+	if (verbose)
+		print_results_verbose(vec);
+	else
+		print_results(vec);
+
+	return 0;
+}
diff --git a/git.c b/git.c
index 33f52ac..ef1e019 100644
--- a/git.c
+++ b/git.c
@@ -444,6 +444,7 @@ static struct cmd_struct commands[] = {
 	{ "interpret-trailers", cmd_interpret_trailers, RUN_SETUP_GENTLY },
 	{ "log", cmd_log, RUN_SETUP },
 	{ "ls-files", cmd_ls_files, RUN_SETUP | SUPPORT_SUPER_PREFIX },
+	{ "ls-partial", cmd_ls_partial, RUN_SETUP },
 	{ "ls-remote", cmd_ls_remote, RUN_SETUP_GENTLY },
 	{ "ls-tree", cmd_ls_tree, RUN_SETUP },
 	{ "mailinfo", cmd_mailinfo, RUN_SETUP_GENTLY },
diff --git a/partial-utils.c b/partial-utils.c
new file mode 100644
index 0000000..b75e91e
--- /dev/null
+++ b/partial-utils.c
@@ -0,0 +1,279 @@
+#include "cache.h"
+#include "blob.h"
+#include "tree.h"
+#include "commit.h"
+#include "quote.h"
+#include "builtin.h"
+#include "parse-options.h"
+#include "pathspec.h"
+#include "dir.h"
+#include "partial-utils.h"
+
+static struct trace_key trace_partial_utils = TRACE_KEY_INIT(PARTIAL_UTILS);
+
+void pu_row_trace(
+	const struct pu_row *row,
+	const char *label)
+{
+	trace_printf_key(
+		&trace_partial_utils,
+		"%s: %06o %s %.*s\n",
+		label,
+		row->mode,
+		oid_to_hex(&row->oid),
+		(int)row->fullpath.len,
+		row->fullpath.buf);
+}
+
+struct pu_row *pu_row_alloc(
+	const unsigned char *sha1,
+	const struct strbuf *base,
+	const char *entryname,
+	unsigned mode)
+{
+	struct pu_row *row = xcalloc(1, sizeof(struct pu_row));
+
+	hashcpy(row->oid.hash, sha1);
+	strbuf_init(&row->fullpath, base->len + strlen(entryname) + 1);
+	if (base->len)
+		strbuf_addbuf(&row->fullpath, base);
+	strbuf_addstr(&row->fullpath, entryname);
+	row->mode = mode;
+	row->entryname_offset = base->len;
+
+	pu_row_trace(row, "alloc");
+
+	return row;
+}
+
+struct pu_vec *pu_vec_alloc(
+	unsigned int nr_pre_alloc)
+{
+	struct pu_vec *vec = xcalloc(1, sizeof(struct pu_vec));
+
+	vec->data = xcalloc(nr_pre_alloc, sizeof(struct pu_row *));
+	vec->data_alloc = nr_pre_alloc;
+
+	return vec;
+}
+
+void pu_vec_append(
+	struct pu_vec *vec,
+	struct pu_row *row)
+{
+	ALLOC_GROW(vec->data, vec->data_nr + 1, vec->data_alloc);
+	vec->data[vec->data_nr++] = row;
+}
+
+static int ls_tree_cb(
+	const unsigned char *sha1,
+	struct strbuf *base,
+	const char *pathname,
+	unsigned mode,
+	int stage,
+	void *context)
+{
+	struct pu_vec *vec = (struct pu_vec *)context;
+
+	/* omit submodules */
+	if (S_ISGITLINK(mode))
+		return 0;
+
+	pu_vec_append(vec, pu_row_alloc(sha1, base, pathname, mode));
+
+	if (S_ISDIR(mode))
+		return READ_TREE_RECURSIVE;
+
+	return 0;
+}
+
+struct pu_vec *pu_vec_ls_tree(
+	struct tree *tree,
+	const char *prefix,
+	const char **argv)
+{
+	struct pu_vec *vec;
+	struct pathspec pathspec;
+	int k;
+
+	vec = pu_vec_alloc(PU_VEC_DEFAULT_SIZE);
+
+	parse_pathspec(
+		&pathspec, PATHSPEC_GLOB | PATHSPEC_ICASE | PATHSPEC_EXCLUDE,
+		PATHSPEC_PREFER_CWD, prefix, argv);
+	for (k = 0; k < pathspec.nr; k++)
+		pathspec.items[k].nowildcard_len = pathspec.items[k].len;
+	pathspec.has_wildcard = 0;
+
+	if (read_tree_recursive(tree, "", 0, 0, &pathspec, ls_tree_cb, vec) != 0)
+		die("Could not read tree");
+
+	return vec;
+}
+
+int pu_load_sparse_definitions(
+	const char *path,
+	struct exclude_list *pel)
+{
+	int result;
+	char *sparse = git_pathdup("info/sparse-checkout");
+	memset(pel, 0, sizeof(*pel));
+	result = add_excludes_from_file_to_list(sparse, "", 0, pel, 0);
+	free(sparse);
+	return result;
+}
+
+static int mode_to_dtype(unsigned mode)
+{
+	if (S_ISREG(mode))
+		return DT_REG;
+	if (S_ISDIR(mode) || S_ISGITLINK(mode))
+		return DT_DIR;
+	if (S_ISLNK(mode))
+		return DT_LNK;
+	return DT_UNKNOWN;
+}
+
+static int apply_excludes_1(
+	struct pu_row **subset,
+	unsigned int nr,
+	struct strbuf *prefix,
+	struct exclude_list *pel,
+	int defval,
+	struct pu_vec *vec_out);
+
+/* apply directory rules. based on clear_ce_flags_dir() */
+static int apply_excludes_dir(
+	struct pu_row **subset,
+	unsigned int nr,
+	struct strbuf *prefix,
+	char *basename,
+	struct exclude_list *pel,
+	int defval,
+	struct pu_vec *vec_out)
+{
+	struct pu_row **subset_end;
+	int dtype = DT_DIR;
+	int ret = is_excluded_from_list(
+		prefix->buf, prefix->len, basename, &dtype, pel);
+	int rc;
+
+	strbuf_addch(prefix, '/');
+
+	if (ret < 0)
+		ret = defval;
+
+	for (subset_end = subset; subset_end != subset + nr; subset_end++) {
+		struct pu_row *row = *subset_end;
+		if (strncmp(row->fullpath.buf, prefix->buf, prefix->len))
+			break;
+	}
+
+	rc = apply_excludes_1(
+		subset, subset_end - subset,
+		prefix, pel, ret,
+		vec_out);
+	strbuf_setlen(prefix, prefix->len - 1);
+	return rc;
+}
+
+/* apply sparse rules to subset[0..nr). based on clear_ce_flags_1() */
+static int apply_excludes_1(
+	struct pu_row **subset,
+	unsigned int nr,
+	struct strbuf *prefix,
+	struct exclude_list *pel,
+	int defval,
+	struct pu_vec *vec_out)
+{
+	struct pu_row **subset_end = subset + nr;
+
+	while (subset != subset_end) {
+		struct pu_row *row = *subset;
+		const char *name, *slash;
+		int len, dtype, val;
+
+		if (prefix->len && strncmp(row->fullpath.buf, prefix->buf, prefix->len))
+			break;
+
+		name = row->fullpath.buf + prefix->len;
+		slash = strchr(name, '/');
+
+		if (slash) {
+			int processed;
+
+			len = slash - name;
+			strbuf_add(prefix, name, len);
+
+			processed = apply_excludes_dir(
+				subset, subset_end - subset,
+				prefix, prefix->buf + prefix->len - len,
+				pel, defval,
+				vec_out);
+
+			if (processed) {
+				subset += processed;
+				strbuf_setlen(prefix, prefix->len - len);
+				continue;
+			}
+
+			strbuf_addch(prefix, '/');
+			subset += apply_excludes_1(
+				subset, subset_end - subset,
+				prefix, pel, defval,
+				vec_out);
+			strbuf_setlen(prefix, prefix->len - len - 1);
+			continue;
+		}
+
+		dtype = mode_to_dtype(row->mode);
+		val = is_excluded_from_list(
+			row->fullpath.buf, row->fullpath.len, name, &dtype, pel);
+		if (val < 0)
+			val = defval;
+		if (val > 0) {
+			pu_row_trace(row, "sparse");
+			pu_vec_append(vec_out, row);
+		}
+		subset++;
+	}
+
+	return nr - (subset_end - subset);
+}
+
+struct pu_vec *pu_vec_filter_sparse(
+	const struct pu_vec *vec_in,
+	struct exclude_list *pel)
+{
+	struct pu_vec *vec_out;
+	struct strbuf prefix = STRBUF_INIT;
+	int defval = 0;
+
+	vec_out = pu_vec_alloc(vec_in->data_nr);
+
+	apply_excludes_1(
+		vec_in->data, vec_in->data_nr,
+		&prefix, pel, defval,
+		vec_out);
+
+	return vec_out;
+}
+
+struct pu_vec *pu_vec_filter_missing(
+	const struct pu_vec *vec_in)
+{
+	struct pu_vec *vec_out;
+	int k;
+
+	vec_out = pu_vec_alloc(vec_in->data_nr);
+
+	for (k = 0; k < vec_in->data_nr; k++) {
+		struct pu_row *row = vec_in->data[k];
+		if (!has_sha1_file(row->oid.hash)) {
+			pu_row_trace(row, "missing");
+			pu_vec_append(vec_out, row);
+		}
+	}
+
+	return vec_out;
+}
diff --git a/partial-utils.h b/partial-utils.h
new file mode 100644
index 0000000..3bdf2e4
--- /dev/null
+++ b/partial-utils.h
@@ -0,0 +1,93 @@
+#ifndef PARTIAL_UTILS_H
+#define PARTIAL_UTILS_H
+
+/*
+ * A 'partial-utils row' represents a single item in the tree.
+ * This is conceptually equivalent to a cache_entry, but does
+ * not require an index_state and lets us operate on any commit
+ * and not be tied to the current worktree.
+ */
+struct pu_row
+{
+	struct strbuf fullpath;
+	struct object_id oid;
+	unsigned mode;
+	unsigned entryname_offset;
+};
+
+/*
+ * A 'partial-utils vec' represents a vector of 'pu row'
+ * values using the normal vector machinery.
+ */
+struct pu_vec
+{
+	struct pu_row **data;
+	unsigned int data_nr;
+	unsigned int data_alloc;
+};
+
+#define PU_VEC_DEFAULT_SIZE (1024*1024)
+
+
+void pu_row_trace(
+	const struct pu_row *row,
+	const char *label);
+
+struct pu_row *pu_row_alloc(
+	const unsigned char *sha1,
+	const struct strbuf *base,
+	const char *entryname,
+	unsigned mode);
+
+struct pu_vec *pu_vec_alloc(
+	unsigned int nr_pre_alloc);
+
+/*
+ * Append the given row onto the vector WITHOUT
+ * assuming ownership of the pointer.
+ */
+void pu_vec_append(
+	struct pu_vec *vec,
+	struct pu_row *row);
+
+/*
+ * Enumerate the contents of the tree (recursively) into
+ * a vector of rows.  This is essentially "ls-tree -r -t"
+ * into a vector.
+ */ 
+struct pu_vec *pu_vec_ls_tree(
+	struct tree *tree,
+	const char *prefix,
+	const char **argv);
+
+/*
+ * Load a sparse-checkout file into (*pel).
+ * Returns -1 if none or error.
+ */
+int pu_load_sparse_definitions(
+	const char *path,
+	struct exclude_list *pel);
+
+/*
+ * Filter the given vector using the sparse-checkout
+ * definitions and return new vector of just the paths
+ * that WOULD BE populated.
+ *
+ * The returned vector BORROWS rows from the input vector.
+ *
+ * This is loosely based upon clear_ce_flags() in unpack-trees.c
+ */
+struct pu_vec *pu_vec_filter_sparse(
+	const struct pu_vec *vec_in,
+	struct exclude_list *pel);
+
+/*
+ * Filter the given vector and return the list of blobs
+ * missing from the local ODB.
+ *
+ * The returned vector BORROWS rows from the input vector.
+ */
+struct pu_vec *pu_vec_filter_missing(
+	const struct pu_vec *vec_in);
+
+#endif /* PARTIAL_UTILS_H */
-- 
2.7.4

