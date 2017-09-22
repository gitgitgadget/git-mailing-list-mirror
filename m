Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C9A5202A5
	for <e@80x24.org>; Fri, 22 Sep 2017 20:31:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752158AbdIVUbZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Sep 2017 16:31:25 -0400
Received: from siwi.pair.com ([209.68.5.199]:12990 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751845AbdIVUbZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2017 16:31:25 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 520AC84709;
        Fri, 22 Sep 2017 16:31:24 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id CA00D84708;
        Fri, 22 Sep 2017 16:31:23 -0400 (EDT)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH 07/13] object-filter: common declarations for object filtering
Date:   Fri, 22 Sep 2017 20:30:11 +0000
Message-Id: <20170922203017.53986-8-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170922203017.53986-6-git@jeffhostetler.com>
References: <20170922203017.53986-6-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Create common routines and defines for parsing
object-filter-related command line arguments and
pack-protocol fields.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Makefile        |   1 +
 object-filter.c | 269 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 object-filter.h | 173 ++++++++++++++++++++++++++++++++++++
 3 files changed, 443 insertions(+)
 create mode 100644 object-filter.c
 create mode 100644 object-filter.h

diff --git a/Makefile b/Makefile
index 6e0bd91..bddd6b5 100644
--- a/Makefile
+++ b/Makefile
@@ -818,6 +818,7 @@ LIB_OBJS += notes-cache.o
 LIB_OBJS += notes-merge.o
 LIB_OBJS += notes-utils.o
 LIB_OBJS += object.o
+LIB_OBJS += object-filter.o
 LIB_OBJS += oidset.o
 LIB_OBJS += oidset2.o
 LIB_OBJS += pack-bitmap.o
diff --git a/object-filter.c b/object-filter.c
new file mode 100644
index 0000000..c88f79f
--- /dev/null
+++ b/object-filter.c
@@ -0,0 +1,269 @@
+#include "cache.h"
+#include "commit.h"
+#include "config.h"
+#include "revision.h"
+#include "list-objects.h"
+#include "oidset2.h"
+#include "list-objects-filter-all.h"
+#include "list-objects-filter-large.h"
+#include "list-objects-filter-sparse.h"
+#include "object-filter.h"
+
+int parse_filter_omit_all_blobs(struct object_filter_options *filter_options)
+{
+	if (object_filter_enabled(filter_options))
+		die(_("multiple object filter types cannot be combined"));
+
+	filter_options->omit_all_blobs = 1;
+	return 0;
+}
+
+int parse_filter_omit_large_blobs(struct object_filter_options *filter_options,
+				  const char *arg)
+{
+	if (object_filter_enabled(filter_options))
+		die(_("multiple object filter types cannot be combined"));
+
+	filter_options->omit_large_blobs = 1;
+
+	/* we allow "<digits>[kmg]" */
+	if (!git_parse_ulong(arg, &filter_options->large_byte_limit))
+		die(_("invalid size limit for large object filter"));
+
+	filter_options->large_byte_limit_string = strdup(arg);
+	return 0;
+}
+
+int parse_filter_use_blob(struct object_filter_options *filter_options,
+			  const char *arg)
+{
+	struct object_context oc;
+
+	if (object_filter_enabled(filter_options))
+		die(_("multiple object filter types cannot be combined"));
+
+	filter_options->use_blob = 1;
+
+	/*
+	 * The command line argument needs to resolve to an known OID
+	 * representing the content of the desired sparse-checkout file.
+	 *
+	 * We allow various syntax forms for the convenience of the user.
+	 * See sha1_name.c:get_sha1_with_context_1().
+	 *
+	 * Try to evaluate the arg locally in case they use one of the
+	 * convenience patterns.  This must resolve to a blob.
+	 */
+	if (get_sha1_with_context(arg, GET_SHA1_BLOB,
+				  filter_options->sparse_oid.hash, &oc)) {
+		/*
+		 * If that fails, keep the original string in case a client
+		 * command wants to send it to the server.  This allows the
+		 * client to name an OID for a blob they don't have.
+		 */
+		filter_options->sparse_value = strdup(arg);
+		oidcpy(&filter_options->sparse_oid, &null_oid);
+	} else {
+		/*
+		 * Round-trip the found OID to normalize it.
+		 */
+		filter_options->sparse_value =
+			strdup(oid_to_hex(&filter_options->sparse_oid));
+	}
+	return 0;
+}
+
+int parse_filter_use_path(struct object_filter_options *filter_options,
+			  const char *arg)
+{
+	if (object_filter_enabled(filter_options))
+		die(_("multiple object filter types cannot be combined"));
+
+	filter_options->use_path = 1;
+
+	/*
+	 * The command line argument needs to resolve to a local file
+	 * containing the content of the desired sparse-checkout file.
+	 */
+	filter_options->sparse_value = strdup(arg);
+	return 0;
+}
+
+int parse_filter_print_omitted(struct object_filter_options *filter_options)
+{
+	filter_options->print_omitted = 1;
+	return 0;
+}
+
+int parse_filter_print_missing(struct object_filter_options *filter_options)
+{
+	filter_options->print_missing = 1;
+	return 0;
+}
+
+int parse_filter_relax(struct object_filter_options *filter_options)
+{
+	filter_options->relax = 1;
+	return 0;
+}
+
+int opt_parse_filter_omit_all_blobs(const struct option *opt,
+				    const char *arg, int unset)
+{
+	struct object_filter_options *filter_options = opt->value;
+
+	assert(!arg);
+	assert(!unset);
+
+	return parse_filter_omit_all_blobs(filter_options);
+}
+
+int opt_parse_filter_omit_large_blobs(const struct option *opt,
+				      const char *arg, int unset)
+{
+	struct object_filter_options *filter_options = opt->value;
+
+	assert(arg);
+	assert(!unset);
+
+	return parse_filter_omit_large_blobs(filter_options, arg);
+}
+
+int opt_parse_filter_use_blob(const struct option *opt,
+			      const char *arg, int unset)
+{
+	struct object_filter_options *filter_options = opt->value;
+
+	assert(arg);
+	assert(!unset);
+
+	return parse_filter_use_blob(filter_options, arg);
+}
+
+int opt_parse_filter_use_path(const struct option *opt,
+			      const char *arg, int unset)
+{
+	struct object_filter_options *filter_options = opt->value;
+
+	assert(arg);
+	assert(!unset);
+
+	return parse_filter_use_path(filter_options, arg);
+}
+
+int opt_parse_filter_print_omitted(const struct option *opt,
+				   const char *arg, int unset)
+{
+	struct object_filter_options *filter_options = opt->value;
+
+	assert(!arg);
+	assert(!unset);
+
+	return parse_filter_print_omitted(filter_options);
+}
+
+int opt_parse_filter_print_missing(const struct option *opt,
+				   const char *arg, int unset)
+{
+	struct object_filter_options *filter_options = opt->value;
+
+	assert(!arg);
+	assert(!unset);
+
+	return parse_filter_print_missing(filter_options);
+}
+
+int opt_parse_filter_relax(const struct option *opt,
+			   const char *arg, int unset)
+{
+	struct object_filter_options *filter_options = opt->value;
+
+	assert(!arg);
+	assert(!unset);
+
+	return parse_filter_relax(filter_options);
+}
+
+int object_filter_hand_parse_arg(struct object_filter_options *filter_options,
+				 const char *arg,
+				 int allow_print_omitted,
+				 int allow_print_missing,
+				 int allow_relax)
+{
+	if (!strcmp(arg, ("--"CL_ARG_FILTER_OMIT_ALL_BLOBS))) {
+		parse_filter_omit_all_blobs(filter_options);
+		return 1;
+	}
+	if (skip_prefix(arg, ("--"CL_ARG_FILTER_OMIT_LARGE_BLOBS"="), &arg)) {
+		parse_filter_omit_large_blobs(filter_options, arg);
+		return 1;
+	}
+	if (skip_prefix(arg, ("--"CL_ARG_FILTER_USE_BLOB"="), &arg)) {
+		parse_filter_use_blob(filter_options, arg);
+		return 1;
+	}
+	if (skip_prefix(arg, ("--"CL_ARG_FILTER_USE_PATH"="), &arg)) {
+		parse_filter_use_path(filter_options, arg);
+		return 1;
+	}
+
+	if (allow_print_omitted &&
+	    !strcmp(arg, ("--"CL_ARG_FILTER_PRINT_OMITTED))) {
+		parse_filter_print_omitted(filter_options);
+		return 1;
+	}
+
+	if (allow_print_missing &&
+	    !strcmp(arg, ("--"CL_ARG_FILTER_PRINT_MISSING))) {
+		parse_filter_print_missing(filter_options);
+		return 1;
+	}
+
+	if (allow_relax && !strcmp(arg, ("--"CL_ARG_FILTER_RELAX))) {
+		parse_filter_relax(filter_options);
+		return 1;
+	}
+
+	return 0;
+}
+
+int object_filter_hand_parse_protocol(struct object_filter_options *filter_options,
+				      const char *arg,
+				      int allow_print_omitted,
+				      int allow_print_missing,
+				      int allow_relax)
+{
+	if (!strcmp(arg, CL_ARG_FILTER_OMIT_ALL_BLOBS)) {
+		parse_filter_omit_all_blobs(filter_options);
+		return 1;
+	}
+	if (skip_prefix(arg, (CL_ARG_FILTER_OMIT_LARGE_BLOBS" "), &arg)) {
+		parse_filter_omit_large_blobs(filter_options, arg);
+		return 1;
+	}
+	if (skip_prefix(arg, (CL_ARG_FILTER_USE_BLOB" "), &arg)) {
+		parse_filter_use_blob(filter_options, arg);
+		return 1;
+	}
+	if (skip_prefix(arg, (CL_ARG_FILTER_USE_PATH" "), &arg)) {
+		parse_filter_use_path(filter_options, arg);
+		return 1;
+	}
+
+	if (allow_print_omitted &&
+	    !strcmp(arg, CL_ARG_FILTER_PRINT_OMITTED)) {
+		parse_filter_print_omitted(filter_options);
+		return 1;
+	}
+	if (allow_print_missing &&
+	    !strcmp(arg, CL_ARG_FILTER_PRINT_MISSING)) {
+		parse_filter_print_missing(filter_options);
+		return 1;
+	}
+	if (allow_relax && !strcmp(arg, CL_ARG_FILTER_RELAX)) {
+		parse_filter_relax(filter_options);
+		return 1;
+	}
+
+	return 0;
+}
diff --git a/object-filter.h b/object-filter.h
new file mode 100644
index 0000000..13a638b
--- /dev/null
+++ b/object-filter.h
@@ -0,0 +1,173 @@
+#ifndef OBJECT_FILTER_H
+#define OBJECT_FILTER_H
+
+#include "parse-options.h"
+
+/*
+ * Common declarations and utilities for filtering objects (such as omitting
+ * large blobs) in list_objects:traverse_commit_list() and git-rev-list.
+ */
+
+struct object_filter_options {
+	/*
+	 * File pathname or blob-ish path/OID (that get_sha1_with_context() can
+	 * use to find the blob containing the sparse-checkout specification.
+	 * This is only used when use_blob or use_path is set.
+	 */
+	const char *sparse_value;
+	struct object_id sparse_oid;
+
+	/*
+	 * Blob size byte limit for filtering.  Only blobs smaller than this
+	 * value will be included.  A value of zero, omits all blobs.
+	 * only used when omit_large_blobs is set.  Integer and string versions
+	 * of this are kept for convenience.  The string version may contain
+	 * a [kmg] suffix.
+	 */
+	unsigned long large_byte_limit;
+	const char *large_byte_limit_string;
+
+	/* Valid filter types (only one may be used at a time) */
+	unsigned omit_all_blobs : 1;
+	unsigned omit_large_blobs : 1;
+	unsigned use_blob : 1;
+	unsigned use_path : 1;
+
+	/*
+	 * True if rev-list should print a list of the objects omitted
+	 * by this invocation of a filter.
+	 */
+	unsigned print_omitted : 1;
+
+	/*
+	 * True if rev-list should print a list of missing objects.
+	 * Objects can be missing because of a previously filtered
+	 * clone or fetch. The set reported here can also be filtered
+	 * by the current filter in effect.
+	 */
+	unsigned print_missing : 1;
+
+	/* True to suppress missing object errors during consistency checks */
+	unsigned relax : 1;
+};
+
+/*
+ * Return true if a filter is enabled.
+ */
+inline int object_filter_enabled(const struct object_filter_options *p)
+{
+	return p->omit_all_blobs ||
+		p->omit_large_blobs ||
+		p->use_blob ||
+		p->use_path;
+}
+
+/* Normalized command line arguments */
+#define CL_ARG_FILTER_OMIT_ALL_BLOBS     "filter-omit-all-blobs"
+#define CL_ARG_FILTER_OMIT_LARGE_BLOBS   "filter-omit-large-blobs"
+#define CL_ARG_FILTER_USE_BLOB           "filter-use-blob"
+#define CL_ARG_FILTER_USE_PATH           "filter-use-path"
+#define CL_ARG_FILTER_PRINT_OMITTED      "filter-print-omitted"
+#define CL_ARG_FILTER_PRINT_MISSING      "filter-print-missing"
+#define CL_ARG_FILTER_RELAX              "filter-relax"
+
+/*
+ * Common command line argument parsing for object-filter-related
+ * arguments (whether from a hand-parsed or parse-options style
+ * parser.
+ */
+int parse_filter_omit_all_blobs(struct object_filter_options *filter_options);
+int parse_filter_omit_large_blobs(struct object_filter_options *filter_options,
+				  const char *arg);
+int parse_filter_use_blob(struct object_filter_options *filter_options,
+			  const char *arg);
+int parse_filter_use_path(struct object_filter_options *filter_options,
+			  const char *arg);
+int parse_filter_print_omitted(struct object_filter_options *filter_options);
+int parse_filter_print_missing(struct object_filter_options *filter_options);
+int parse_filter_relax(struct object_filter_options *filter_options);
+
+/*
+ * Common command line argument parsers for object-filter-related
+ * arguments comming from parse-options style parsers.
+ */
+
+int opt_parse_filter_omit_all_blobs(const struct option *opt,
+				    const char *arg, int unset);
+int opt_parse_filter_omit_large_blobs(const struct option *opt,
+				      const char *arg, int unset);
+int opt_parse_filter_use_blob(const struct option *opt,
+			      const char *arg, int unset);
+int opt_parse_filter_use_path(const struct option *opt,
+			      const char *arg, int unset);
+int opt_parse_filter_print_omitted(const struct option *opt,
+				   const char *arg, int unset);
+int opt_parse_filter_print_missing(const struct option *opt,
+				   const char *arg, int unset);
+int opt_parse_filter_relax(const struct option *opt,
+			   const char *arg, int unset);
+
+#define OPT_PARSE_FILTER_OMIT_ALL_BLOBS(fo) \
+	{ OPTION_CALLBACK, 0, CL_ARG_FILTER_OMIT_ALL_BLOBS, fo, NULL, \
+	  N_("omit all blobs from result"), PARSE_OPT_NOARG | PARSE_OPT_NONEG, \
+	  opt_parse_filter_omit_all_blobs }
+
+#define OPT_PARSE_FILTER_OMIT_LARGE_BLOBS(fo) \
+	{ OPTION_CALLBACK, 0, CL_ARG_FILTER_OMIT_LARGE_BLOBS, fo, N_("size"), \
+	  N_("omit large blobs from result"), PARSE_OPT_NONEG, \
+	  opt_parse_filter_omit_large_blobs }
+
+#define OPT_PARSE_FILTER_USE_BLOB(fo) \
+	{ OPTION_CALLBACK, 0, CL_ARG_FILTER_USE_BLOB, fo, N_("object"), \
+	  N_("filter results using sparse-checkout specification"), PARSE_OPT_NONEG, \
+	  opt_parse_filter_use_blob }
+
+#define OPT_PARSE_FILTER_USE_PATH(fo) \
+	{ OPTION_CALLBACK, 0, CL_ARG_FILTER_USE_PATH, fo, N_("path"), \
+	  N_("filter results using sparse-checkout specification"), PARSE_OPT_NONEG, \
+	  opt_parse_filter_use_path }
+
+#define OPT_PARSE_FILTER_PRINT_OMITTED(fo) \
+	{ OPTION_CALLBACK, 0, CL_ARG_FILTER_PRINT_OMITTED, fo, NULL,	\
+	  N_("print list of omitted objects"), PARSE_OPT_NOARG | PARSE_OPT_NONEG, \
+	  opt_parse_filter_print_omitted }
+
+#define OPT_PARSE_FILTER_PRINT_MISSING(fo) \
+	{ OPTION_CALLBACK, 0, CL_ARG_FILTER_PRINT_MISSING, fo, NULL,	\
+	  N_("print list of missing objects"), PARSE_OPT_NOARG | PARSE_OPT_NONEG, \
+	  opt_parse_filter_print_missing }
+
+#define OPT_PARSE_FILTER_RELAX(fo) \
+	{ OPTION_CALLBACK, 0, CL_ARG_FILTER_RELAX, fo, NULL, \
+	  N_("relax consistency checks for previously omitted objects"), \
+	  PARSE_OPT_NOARG | PARSE_OPT_NONEG, opt_parse_filter_relax }
+
+/*
+ * Hand parse known object-filter command line options.
+ * Use this when the caller DOES NOT use the normal OPT_
+ * routines.
+ *
+ * Here we assume args of the form "--<key>" or "--<key>=<value>".
+ * Note the literal dash-dash and equals.
+ *
+ * Returns 1 if we handled the argument.
+ */
+int object_filter_hand_parse_arg(struct object_filter_options *filter_options,
+				 const char *arg,
+				 int allow_print_omitted,
+				 int allow_print_missing,
+				 int allow_relax);
+
+/*
+ * Hand parse known object-filter protocol lines.
+ *
+ * Here we assume args of the form "<key>" or "<key> <value>".
+ * Note the literal space before between the key and value.
+ */ 
+int object_filter_hand_parse_protocol(struct object_filter_options *filter_options,
+				      const char *arg,
+				      int allow_print_omitted,
+				      int allow_print_missing,
+				      int allow_relax);
+
+#endif /* OBJECT_FILTER_H */
-- 
2.9.3

