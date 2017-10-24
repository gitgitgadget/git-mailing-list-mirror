Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1666D1FF72
	for <e@80x24.org>; Tue, 24 Oct 2017 18:54:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932124AbdJXSyd (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Oct 2017 14:54:33 -0400
Received: from siwi.pair.com ([209.68.5.199]:42881 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751711AbdJXSyD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Oct 2017 14:54:03 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 767B1845A3;
        Tue, 24 Oct 2017 14:54:02 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id D831984597;
        Tue, 24 Oct 2017 14:54:01 -0400 (EDT)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH 07/13] list-objects-filter-options: common argument parsing
Date:   Tue, 24 Oct 2017 18:53:26 +0000
Message-Id: <20171024185332.57261-8-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20171024185332.57261-1-git@jeffhostetler.com>
References: <20171024185332.57261-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Create common routines and defines for parsing
list-objects-filter-related command line arguments and
pack-protocol fields.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Makefile                      |   1 +
 list-objects-filter-options.c | 101 ++++++++++++++++++++++++++++++++++++++++++
 list-objects-filter-options.h |  50 +++++++++++++++++++++
 3 files changed, 152 insertions(+)
 create mode 100644 list-objects-filter-options.c
 create mode 100644 list-objects-filter-options.h

diff --git a/Makefile b/Makefile
index fc82664..b9ff0b4 100644
--- a/Makefile
+++ b/Makefile
@@ -810,6 +810,7 @@ LIB_OBJS += list-objects.o
 LIB_OBJS += list-objects-filter-blobs-limit.o
 LIB_OBJS += list-objects-filter-blobs-none.o
 LIB_OBJS += list-objects-filter-map.o
+LIB_OBJS += list-objects-filter-options.o
 LIB_OBJS += list-objects-filter-sparse.o
 LIB_OBJS += ll-merge.o
 LIB_OBJS += lockfile.o
diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
new file mode 100644
index 0000000..40f48ac
--- /dev/null
+++ b/list-objects-filter-options.c
@@ -0,0 +1,101 @@
+#include "cache.h"
+#include "commit.h"
+#include "config.h"
+#include "revision.h"
+#include "list-objects.h"
+#include "list-objects-filter-options.h"
+
+/*
+ * Parse value of the argument to the "filter" keword.
+ * On the command line this looks like: --filter=<arg>
+ * and in the pack protocol as: filter <arg>
+ *
+ * <arg> ::= blob:none
+ *           blob:limit:<n>[kmg]
+ *           sparse:oid:<oid-expression>
+ *           sparse:path:<pathname>
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
diff --git a/list-objects-filter-options.h b/list-objects-filter-options.h
new file mode 100644
index 0000000..23bd68e
--- /dev/null
+++ b/list-objects-filter-options.h
@@ -0,0 +1,50 @@
+#ifndef LIST_OBJECTS_FILTER_OPTIONS_H
+#define LIST_OBJECTS_FILTER_OPTIONS_H
+
+#include "parse-options.h"
+
+/*
+ * Common declarations and utilities for filtering objects (such as omitting
+ * large blobs) in list_objects:traverse_commit_list() and git-rev-list.
+ */
+
+enum list_objects_filter_choice {
+	LOFC_DISABLED = 0,
+	LOFC_BLOB_NONE,
+	LOFC_BLOB_LIMIT,
+	LOFC_SPARSE_OID,
+	LOFC_SPARSE_PATH,
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
+int parse_list_objects_filter(struct list_objects_filter_options *filter_options,
+			      const char *arg);
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
-- 
2.9.3

