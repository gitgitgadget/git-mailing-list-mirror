Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E302202A5
	for <e@80x24.org>; Fri, 22 Sep 2017 20:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752115AbdIVU1J (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Sep 2017 16:27:09 -0400
Received: from siwi.pair.com ([209.68.5.199]:27076 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752005AbdIVU1D (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2017 16:27:03 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 61EEB8470B;
        Fri, 22 Sep 2017 16:27:03 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id DC78884706;
        Fri, 22 Sep 2017 16:27:02 -0400 (EDT)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com,
        jeffhost@microsoft.com
Subject: [PATCH 04/13] list-objects-filter-all: add filter to omit all blobs
Date:   Fri, 22 Sep 2017 20:26:23 +0000
Message-Id: <20170922202632.53714-5-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170922202632.53714-1-git@jeffhostetler.com>
References: <20170922202632.53714-1-git@jeffhostetler.com>
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
 Makefile                  |  1 +
 list-objects-filter-all.c | 85 +++++++++++++++++++++++++++++++++++++++++++++++
 list-objects-filter-all.h | 18 ++++++++++
 3 files changed, 104 insertions(+)
 create mode 100644 list-objects-filter-all.c
 create mode 100644 list-objects-filter-all.h

diff --git a/Makefile b/Makefile
index 4e0cc39..b98e3dc 100644
--- a/Makefile
+++ b/Makefile
@@ -798,6 +798,7 @@ LIB_OBJS += levenshtein.o
 LIB_OBJS += line-log.o
 LIB_OBJS += line-range.o
 LIB_OBJS += list-objects.o
+LIB_OBJS += list-objects-filter-all.o
 LIB_OBJS += ll-merge.o
 LIB_OBJS += lockfile.o
 LIB_OBJS += log-tree.o
diff --git a/list-objects-filter-all.c b/list-objects-filter-all.c
new file mode 100644
index 0000000..2faccb3
--- /dev/null
+++ b/list-objects-filter-all.c
@@ -0,0 +1,85 @@
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
+#include "list-objects-filter-all.h"
+
+/*
+ * A filter for list-objects to omit ALL blobs from the traversal.
+ */
+struct filter_omit_all_blobs_data {
+	struct oidset2 omits;
+};
+
+static list_objects_filter_result filter_omit_all_blobs(
+	list_objects_filter_type filter_type,
+	struct object *obj,
+	const char *pathname,
+	const char *filename,
+	void *filter_data_)
+{
+	struct filter_omit_all_blobs_data *filter_data = filter_data_;
+	int64_t object_length = -1;
+	unsigned long s;
+	enum object_type t;
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
+		/*
+		 * Since we always omit all blobs (and never provisionally omit),
+		 * we should never see a blob twice.
+		 */
+		assert(!oidset2_contains(&filter_data->omits, &obj->oid));
+
+		t = sha1_object_info(obj->oid.hash, &s);
+		assert(t == OBJ_BLOB);
+		object_length = (int64_t)((uint64_t)(s));
+
+		/* Insert OID into the omitted list. No need for a pathname. */
+		oidset2_insert(&filter_data->omits, &obj->oid, t, object_length,
+			       NULL);
+		return LOFR_MARK_SEEN; /* but not LOFR_SHOW (hard omit) */
+	}
+}
+
+void traverse_commit_list_omit_all_blobs(
+	struct rev_info *revs,
+	show_commit_fn show_commit,
+	show_object_fn show_object,
+	oidset2_foreach_cb print_omitted_object,
+	void *ctx_data)
+{
+	struct filter_omit_all_blobs_data d;
+
+	memset(&d, 0, sizeof(d));
+
+	traverse_commit_list_worker(revs, show_commit, show_object, ctx_data,
+				    filter_omit_all_blobs, &d);
+
+	if (print_omitted_object)
+		oidset2_foreach(&d.omits, print_omitted_object, ctx_data);
+
+	oidset2_clear(&d.omits);
+}
diff --git a/list-objects-filter-all.h b/list-objects-filter-all.h
new file mode 100644
index 0000000..591589f
--- /dev/null
+++ b/list-objects-filter-all.h
@@ -0,0 +1,18 @@
+#ifndef LIST_OBJECTS_FILTER_ALL_H
+#define LIST_OBJECTS_FILTER_ALL_H
+
+#include "oidset2.h"
+
+/*
+ * A filter for list-objects to omit ALL blobs
+ * from the traversal.
+ */
+void traverse_commit_list_omit_all_blobs(
+	struct rev_info *revs,
+	show_commit_fn show_commit,
+	show_object_fn show_object,
+	oidset2_foreach_cb print_omitted_object,
+	void *ctx_data);
+
+#endif /* LIST_OBJECTS_FILTER_ALL_H */
+
-- 
2.9.3

