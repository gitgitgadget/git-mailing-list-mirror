Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6237D202AC
	for <e@80x24.org>; Thu, 13 Jul 2017 17:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752602AbdGMRfi (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 13:35:38 -0400
Received: from siwi.pair.com ([209.68.5.199]:11031 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752569AbdGMRfg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 13:35:36 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 84CEF844EE;
        Thu, 13 Jul 2017 13:35:35 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id C4A54844E5;
        Thu, 13 Jul 2017 13:35:34 -0400 (EDT)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, ethomson@edwardthomson.com,
        jonathantanmy@google.com, jrnieder@gmail.com,
        jeffhost@microsoft.com
Subject: [PATCH v2 07/19] object-filter: common declarations for object filtering
Date:   Thu, 13 Jul 2017 17:34:47 +0000
Message-Id: <20170713173459.3559-8-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170713173459.3559-1-git@jeffhostetler.com>
References: <20170713173459.3559-1-git@jeffhostetler.com>
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
 object-filter.c | 201 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 object-filter.h | 145 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 347 insertions(+)
 create mode 100644 object-filter.c
 create mode 100644 object-filter.h

diff --git a/Makefile b/Makefile
index 48fdcf2..daa9ea2 100644
--- a/Makefile
+++ b/Makefile
@@ -791,6 +791,7 @@ LIB_OBJS += notes-cache.o
 LIB_OBJS += notes-merge.o
 LIB_OBJS += notes-utils.o
 LIB_OBJS += object.o
+LIB_OBJS += object-filter.o
 LIB_OBJS += oidset.o
 LIB_OBJS += oidset2.o
 LIB_OBJS += pack-bitmap.o
diff --git a/object-filter.c b/object-filter.c
new file mode 100644
index 0000000..5be6129
--- /dev/null
+++ b/object-filter.c
@@ -0,0 +1,201 @@
+#include "cache.h"
+#include "commit.h"
+#include "revision.h"
+#include "list-objects.h"
+#include "oidset2.h"
+#include "list-objects-filters.h"
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
+int parse_filter_use_sparse(struct object_filter_options *filter_options,
+			    const char *arg)
+{
+	struct object_context oc;
+
+	if (object_filter_enabled(filter_options))
+		die(_("multiple object filter types cannot be combined"));
+
+	filter_options->use_sparse = 1;
+
+	/*
+	 * The command line argument needs to resolve to an known OID
+	 * representing the content of the desired sparse-checkout file.
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
+	
+	return 0;
+}
+
+int parse_filter_print_manifest(struct object_filter_options *filter_options)
+{
+	filter_options->print_manifest = 1;
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
+int opt_parse_filter_use_sparse(const struct option *opt,
+				const char *arg, int unset)
+{
+	struct object_filter_options *filter_options = opt->value;
+
+	assert(arg);
+	assert(!unset);
+
+	return parse_filter_use_sparse(filter_options, arg);
+}
+
+int opt_parse_filter_print_manifest(const struct option *opt,
+				    const char *arg, int unset)
+{
+	struct object_filter_options *filter_options = opt->value;
+
+	assert(!arg);
+	assert(!unset);
+
+	return parse_filter_print_manifest(filter_options);
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
+				 int allow_print_manifest,
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
+	if (skip_prefix(arg, ("--"CL_ARG_FILTER_USE_SPARSE"="), &arg)) {
+		parse_filter_use_sparse(filter_options, arg);
+		return 1;
+	}
+
+	if (allow_print_manifest &&
+	    !strcmp(arg, ("--"CL_ARG_FILTER_PRINT_MANIFEST))) {
+		parse_filter_print_manifest(filter_options);
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
+				      int allow_print_manifest,
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
+	if (skip_prefix(arg, (CL_ARG_FILTER_USE_SPARSE" "), &arg)) {
+		parse_filter_use_sparse(filter_options, arg);
+		return 1;
+	}
+
+	if (allow_print_manifest &&
+	    !strcmp(arg, CL_ARG_FILTER_PRINT_MANIFEST)) {
+		parse_filter_print_manifest(filter_options);
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
index 0000000..f1ca5fb
--- /dev/null
+++ b/object-filter.h
@@ -0,0 +1,145 @@
+#ifndef OBJECT_FILTER_H
+#define OBJECT_FILTER_H
+
+#include "parse-options.h"
+
+/*
+ * Common declarations and utilities for filtering objects (such as omitting
+ * large blobs) during fetch-pack, upload-pack, and the pack-protocol.  These
+ * are intended for partial/narrow clone/fetch.
+ */
+
+struct object_filter_options {
+	/*
+	 * blob-ish path or value that get_sha1_with_context() can turn into
+	 * an OID to find the blob containing the sparse-checkout specification.
+	 * only used when use_sparse is set.
+	 */
+	const char *sparse_value;
+	struct object_id sparse_oid;
+
+	/*
+	 * blob size byte limit for filtering.  only blobs smaller than this
+	 * value will be included.  a value of zero, omits all blobs.
+	 * only used when omit_large_blobs is set.  Integer and string versions
+	 * of this are kept for convenience.
+	 */
+	unsigned long large_byte_limit;
+	const char *large_byte_limit_string;
+
+	/* valid filter types (only one may be used at a time) */
+	unsigned omit_all_blobs : 1;
+	unsigned omit_large_blobs : 1;
+	unsigned use_sparse : 1;
+
+	/* true if the filter should output a manifest of the omitted objects. */
+	unsigned print_manifest : 1;
+
+	/* true to suppress missing object errors during consistency checks */
+	unsigned relax : 1;
+};
+
+/*
+ * Return true if a filter is enabled.
+ */
+inline int object_filter_enabled(const struct object_filter_options *p)
+{
+	return p->omit_all_blobs || p->omit_large_blobs || p->use_sparse;
+}
+
+/* See Documentation/technical/protocol-capabilities.txt */
+#define PROTOCOL_CAPABILITY_FILTER_OBJECTS         "filter-objects"
+
+/* See Documentation/technical/pack-protocol.txt */
+#define PROTOCOL_REQUEST_FILTER_OMIT_ALL_BLOBS     "filter-omit-all-blobs"
+#define PROTOCOL_REQUEST_FILTER_OMIT_LARGE_BLOBS   "filter-omit-large-blobs"
+#define PROTOCOL_REQUEST_FILTER_USE_SPARSE         "filter-use-sparse"
+
+/* Normalized command line arguments */
+#define CL_ARG_FILTER_OMIT_ALL_BLOBS     "filter-omit-all-blobs"
+#define CL_ARG_FILTER_OMIT_LARGE_BLOBS   "filter-omit-large-blobs"
+#define CL_ARG_FILTER_USE_SPARSE         "filter-use-sparse"
+#define CL_ARG_FILTER_PRINT_MANIFEST     "filter-print-manifest"
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
+int parse_filter_use_sparse(struct object_filter_options *filter_options,
+			    const char *arg);
+int parse_filter_print_manifest(struct object_filter_options *filter_options);
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
+int opt_parse_filter_use_sparse(const struct option *opt,
+				const char *arg, int unset);
+int opt_parse_filter_print_manifest(const struct option *opt,
+				    const char *arg, int unset);
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
+#define OPT_PARSE_FILTER_USE_SPARSE(fo) \
+	{ OPTION_CALLBACK, 0, CL_ARG_FILTER_USE_SPARSE, fo, N_("object"), \
+	  N_("filter results using sparse-checkout specification"), PARSE_OPT_NONEG, \
+	  opt_parse_filter_use_sparse }
+
+#define OPT_PARSE_FILTER_PRINT_MANIFEST(fo) \
+	{ OPTION_CALLBACK, 0, CL_ARG_FILTER_PRINT_MANIFEST, fo, NULL,	\
+	  N_("print manifest of omitted objects"), PARSE_OPT_NOARG | PARSE_OPT_NONEG, \
+	  opt_parse_filter_print_manifest }
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
+				 int allow_print_manifest,
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
+				      int allow_print_manifest,
+				      int allow_relax);
+
+#endif /* OBJECT_FILTER_H */
-- 
2.9.3

