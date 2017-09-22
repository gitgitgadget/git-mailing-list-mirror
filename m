Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62D34202A5
	for <e@80x24.org>; Fri, 22 Sep 2017 20:31:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752072AbdIVUbO (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Sep 2017 16:31:14 -0400
Received: from siwi.pair.com ([209.68.5.199]:41334 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751845AbdIVUbN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2017 16:31:13 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id E934184709;
        Fri, 22 Sep 2017 16:31:12 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 6EE1984708;
        Fri, 22 Sep 2017 16:31:12 -0400 (EDT)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH 05/13] list-objects-filter-large: add large blob filter to list-objects
Date:   Fri, 22 Sep 2017 20:30:09 +0000
Message-Id: <20170922203017.53986-6-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Create a filter for traverse_commit_list_worker() to omit blobs
larger than a requested size from the result, but always include
".git*" special files.

Signed-off-by: Jeff Hostetler <jeffhost>@microsoft.com>
---
 Makefile                    |   1 +
 list-objects-filter-large.c | 108 ++++++++++++++++++++++++++++++++++++++++++++
 list-objects-filter-large.h |  18 ++++++++
 3 files changed, 127 insertions(+)
 create mode 100644 list-objects-filter-large.c
 create mode 100644 list-objects-filter-large.h

diff --git a/Makefile b/Makefile
index b98e3dc..f1f3979 100644
--- a/Makefile
+++ b/Makefile
@@ -799,6 +799,7 @@ LIB_OBJS += line-log.o
 LIB_OBJS += line-range.o
 LIB_OBJS += list-objects.o
 LIB_OBJS += list-objects-filter-all.o
+LIB_OBJS += list-objects-filter-large.o
 LIB_OBJS += ll-merge.o
 LIB_OBJS += lockfile.o
 LIB_OBJS += log-tree.o
diff --git a/list-objects-filter-large.c b/list-objects-filter-large.c
new file mode 100644
index 0000000..1af39b6
--- /dev/null
+++ b/list-objects-filter-large.c
@@ -0,0 +1,108 @@
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
+#include "list-objects-filter-large.h"
+
+/*
+ * A filter for list-objects to omit large blobs,
+ * but always include ".git*" special files.
+ */
+struct filter_omit_large_blobs_data {
+	struct oidset2 omits;
+	int64_t max_bytes;
+};
+
+static list_objects_filter_result filter_omit_large_blobs(
+	list_objects_filter_type filter_type,
+	struct object *obj,
+	const char *pathname,
+	const char *filename,
+	void *filter_data_)
+{
+	struct filter_omit_large_blobs_data *filter_data = filter_data_;
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
+		 * If previously provisionally omitted (because of size), see if the
+		 * current filename is special and force it to be included.
+		 */
+		if (oidset2_contains(&filter_data->omits, &obj->oid)) {
+			if ((strncmp(filename, ".git", 4) == 0) && filename[4]) {
+				oidset2_remove(&filter_data->omits, &obj->oid);
+				return LOFR_MARK_SEEN | LOFR_SHOW;
+			}
+			return LOFR_ZERO; /* continue provisionally omitting it */
+		}
+
+		t = sha1_object_info(obj->oid.hash, &s);
+		assert(t == OBJ_BLOB);
+		object_length = (int64_t)((uint64_t)(s));
+
+		if (object_length < filter_data->max_bytes)
+			return LOFR_MARK_SEEN | LOFR_SHOW;
+
+		/*
+		 * Provisionally omit it.  We've already established that this blob
+		 * is too big and doesn't have a special filename, so we WANT to
+		 * omit it.  However, there may be a special file elsewhere in the
+		 * tree that references this same blob, so we cannot reject it yet.
+		 * Leave the LOFR_ bits unset so that if the blob appears again in
+		 * the traversal, we will be asked again.
+		 *
+		 * No need for a pathname, since we only test for special filenames
+		 * above.
+		 */
+		oidset2_insert(&filter_data->omits, &obj->oid, t, object_length,
+			       NULL);
+		return LOFR_ZERO;
+	}
+}
+
+void traverse_commit_list_omit_large_blobs(
+	struct rev_info *revs,
+	show_commit_fn show_commit,
+	show_object_fn show_object,
+	oidset2_foreach_cb print_omitted_object,
+	void *ctx_data,
+	int64_t large_byte_limit)
+{
+	struct filter_omit_large_blobs_data d;
+
+	memset(&d, 0, sizeof(d));
+	d.max_bytes = large_byte_limit;
+
+	traverse_commit_list_worker(revs, show_commit, show_object, ctx_data,
+				    filter_omit_large_blobs, &d);
+
+	if (print_omitted_object)
+		oidset2_foreach(&d.omits, print_omitted_object, ctx_data);
+
+	oidset2_clear(&d.omits);
+}
diff --git a/list-objects-filter-large.h b/list-objects-filter-large.h
new file mode 100644
index 0000000..4a5c772
--- /dev/null
+++ b/list-objects-filter-large.h
@@ -0,0 +1,18 @@
+#ifndef LIST_OBJECTS_FILTER_LARGE_H
+#define LIST_OBJECTS_FILTER_LARGE_H
+
+#include "oidset2.h"
+
+/*
+ * A filter for list-objects to omit large blobs,
+ * but always include ".git*" special files.
+ */
+void traverse_commit_list_omit_large_blobs(
+	struct rev_info *revs,
+	show_commit_fn show_commit,
+	show_object_fn show_object,
+	oidset2_foreach_cb print_omitted_object,
+	void *ctx_data,
+	int64_t large_byte_limit);
+
+#endif /* LIST_OBJECTS_FILTER_LARGE_H */
-- 
2.9.3

