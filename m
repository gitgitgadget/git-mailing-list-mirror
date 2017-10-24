Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5E201FF72
	for <e@80x24.org>; Tue, 24 Oct 2017 18:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751755AbdJXSyE (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Oct 2017 14:54:04 -0400
Received: from siwi.pair.com ([209.68.5.199]:10690 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751573AbdJXSyA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Oct 2017 14:54:00 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 10D18845A3;
        Tue, 24 Oct 2017 14:54:00 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 6C14184597;
        Tue, 24 Oct 2017 14:53:59 -0400 (EDT)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH 04/13] list-objects-filter-blobs-none: add filter to omit all blobs
Date:   Tue, 24 Oct 2017 18:53:23 +0000
Message-Id: <20171024185332.57261-5-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20171024185332.57261-1-git@jeffhostetler.com>
References: <20171024185332.57261-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Create a simple filter for traverse_commit_list_worker() to omit
all blobs from the result.

This filter will be used in a future commit by rev-list and pack-objects
to create a "commits and trees" result.  This is intended for partial
clone and fetch support.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Makefile                         |  1 +
 list-objects-filter-blobs-none.c | 83 ++++++++++++++++++++++++++++++++++++++++
 list-objects-filter-blobs-none.h | 18 +++++++++
 3 files changed, 102 insertions(+)
 create mode 100644 list-objects-filter-blobs-none.c
 create mode 100644 list-objects-filter-blobs-none.h

diff --git a/Makefile b/Makefile
index e59f12d..7e9d1f4 100644
--- a/Makefile
+++ b/Makefile
@@ -807,6 +807,7 @@ LIB_OBJS += levenshtein.o
 LIB_OBJS += line-log.o
 LIB_OBJS += line-range.o
 LIB_OBJS += list-objects.o
+LIB_OBJS += list-objects-filter-blobs-none.o
 LIB_OBJS += list-objects-filter-map.o
 LIB_OBJS += ll-merge.o
 LIB_OBJS += lockfile.o
diff --git a/list-objects-filter-blobs-none.c b/list-objects-filter-blobs-none.c
new file mode 100644
index 0000000..1b548b9
--- /dev/null
+++ b/list-objects-filter-blobs-none.c
@@ -0,0 +1,83 @@
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
+#include "list-objects-filter-blobs-none.h"
+
+#define DEFAULT_MAP_SIZE (16*1024)
+
+/*
+ * A filter for list-objects to omit ALL blobs from the traversal.
+ * And to OPTIONALLY collect a list of the omitted OIDs.
+ */
+struct filter_blobs_none_data {
+	struct oidmap *omits;
+};
+
+static list_objects_filter_result filter_blobs_none(
+	list_objects_filter_type filter_type,
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
+			list_objects_filter_map_insert(
+				filter_data->omits, &obj->oid, pathname,
+				obj->type);
+
+		return LOFR_MARK_SEEN; /* but not LOFR_SHOW (hard omit) */
+	}
+}
+
+void traverse_commit_list__blobs_none(
+	struct rev_info *revs,
+	show_commit_fn show_commit,
+	show_object_fn show_object,
+	list_objects_filter_map_foreach_cb print_omitted_object,
+	void *ctx_data)
+{
+	struct filter_blobs_none_data d;
+
+	memset(&d, 0, sizeof(d));
+	if (print_omitted_object) {
+		d.omits = xcalloc(1, sizeof(*d.omits));
+		oidmap_init(d.omits, DEFAULT_MAP_SIZE);
+	}
+
+	traverse_commit_list_worker(revs, show_commit, show_object, ctx_data,
+				    filter_blobs_none, &d);
+
+	if (print_omitted_object) {
+		list_objects_filter_map_foreach(d.omits,
+						print_omitted_object,
+						ctx_data);
+		oidmap_free(d.omits, 1);
+	}
+}
diff --git a/list-objects-filter-blobs-none.h b/list-objects-filter-blobs-none.h
new file mode 100644
index 0000000..363c9de
--- /dev/null
+++ b/list-objects-filter-blobs-none.h
@@ -0,0 +1,18 @@
+#ifndef LIST_OBJECTS_FILTER_BLOBS_NONE_H
+#define LIST_OBJECTS_FILTER_BLOBS_NONE_H
+
+#include "list-objects-filter-map.h"
+
+/*
+ * A filter for list-objects to omit ALL blobs
+ * from the traversal.
+ */
+void traverse_commit_list__blobs_none(
+	struct rev_info *revs,
+	show_commit_fn show_commit,
+	show_object_fn show_object,
+	list_objects_filter_map_foreach_cb print_omitted_object,
+	void *ctx_data);
+
+#endif /* LIST_OBJECTS_FILTER_BLOBS_NONE_H */
+
-- 
2.9.3

