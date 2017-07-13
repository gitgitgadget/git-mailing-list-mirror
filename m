Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36E54202AC
	for <e@80x24.org>; Thu, 13 Jul 2017 17:37:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752929AbdGMRhv (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 13:37:51 -0400
Received: from siwi.pair.com ([209.68.5.199]:11004 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752527AbdGMRfd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 13:35:33 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 07547844EE;
        Thu, 13 Jul 2017 13:35:33 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 593C1844E5;
        Thu, 13 Jul 2017 13:35:32 -0400 (EDT)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, ethomson@edwardthomson.com,
        jonathantanmy@google.com, jrnieder@gmail.com,
        jeffhost@microsoft.com
Subject: [PATCH v2 04/19] list-objects-filters: add omit-all-blobs filter
Date:   Thu, 13 Jul 2017 17:34:44 +0000
Message-Id: <20170713173459.3559-5-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170713173459.3559-1-git@jeffhostetler.com>
References: <20170713173459.3559-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Create a simple filter for traverse_commit_list_filtered() to
omit all blobs from the result.

This filter will be used in a future commit by rev-list and
pack-objects to create a "commits and trees" result.  This
is intended for a narrow/partial clone/fetch.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Makefile               |  1 +
 list-objects-filters.c | 85 ++++++++++++++++++++++++++++++++++++++++++++++++++
 list-objects-filters.h | 17 ++++++++++
 3 files changed, 103 insertions(+)
 create mode 100644 list-objects-filters.c
 create mode 100644 list-objects-filters.h

diff --git a/Makefile b/Makefile
index d590508..48fdcf2 100644
--- a/Makefile
+++ b/Makefile
@@ -773,6 +773,7 @@ LIB_OBJS += levenshtein.o
 LIB_OBJS += line-log.o
 LIB_OBJS += line-range.o
 LIB_OBJS += list-objects.o
+LIB_OBJS += list-objects-filters.o
 LIB_OBJS += ll-merge.o
 LIB_OBJS += lockfile.o
 LIB_OBJS += log-tree.o
diff --git a/list-objects-filters.c b/list-objects-filters.c
new file mode 100644
index 0000000..f29d8bc
--- /dev/null
+++ b/list-objects-filters.c
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
+#include "list-objects-filters.h"
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
+		oidset2_insert(&filter_data->omits, &obj->oid, object_length,
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
+	traverse_commit_list_filtered(revs, show_commit, show_object, ctx_data,
+				      filter_omit_all_blobs, &d);
+
+	if (print_omitted_object)
+		oidset2_foreach(&d.omits, print_omitted_object, ctx_data);
+
+	oidset2_clear(&d.omits);
+}
diff --git a/list-objects-filters.h b/list-objects-filters.h
new file mode 100644
index 0000000..b981020
--- /dev/null
+++ b/list-objects-filters.h
@@ -0,0 +1,17 @@
+#ifndef LIST_OBJECTS_FILTERS_H
+#define LIST_OBJECTS_FILTERS_H
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
+#endif /* LIST_OBJECTS_FILTERS_H */
-- 
2.9.3

