Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4806A1FF72
	for <e@80x24.org>; Tue, 24 Oct 2017 18:54:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751803AbdJXSyG (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Oct 2017 14:54:06 -0400
Received: from siwi.pair.com ([209.68.5.199]:59239 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751705AbdJXSyC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Oct 2017 14:54:02 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id D0D07845A4;
        Tue, 24 Oct 2017 14:54:00 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 3E4DB84597;
        Tue, 24 Oct 2017 14:54:00 -0400 (EDT)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH 05/13] list-objects-filter-blobs-limit: add large blob filtering
Date:   Tue, 24 Oct 2017 18:53:24 +0000
Message-Id: <20171024185332.57261-6-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20171024185332.57261-1-git@jeffhostetler.com>
References: <20171024185332.57261-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Create a filter for traverse_commit_list_worker() to omit blobs
larger than a requested size from the result, but always include
".git*" special files.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Makefile                          |   1 +
 list-objects-filter-blobs-limit.c | 146 ++++++++++++++++++++++++++++++++++++++
 list-objects-filter-blobs-limit.h |  18 +++++
 3 files changed, 165 insertions(+)
 create mode 100644 list-objects-filter-blobs-limit.c
 create mode 100644 list-objects-filter-blobs-limit.h

diff --git a/Makefile b/Makefile
index 7e9d1f4..0fdeabb 100644
--- a/Makefile
+++ b/Makefile
@@ -807,6 +807,7 @@ LIB_OBJS += levenshtein.o
 LIB_OBJS += line-log.o
 LIB_OBJS += line-range.o
 LIB_OBJS += list-objects.o
+LIB_OBJS += list-objects-filter-blobs-limit.o
 LIB_OBJS += list-objects-filter-blobs-none.o
 LIB_OBJS += list-objects-filter-map.o
 LIB_OBJS += ll-merge.o
diff --git a/list-objects-filter-blobs-limit.c b/list-objects-filter-blobs-limit.c
new file mode 100644
index 0000000..f68963d
--- /dev/null
+++ b/list-objects-filter-blobs-limit.c
@@ -0,0 +1,146 @@
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
+#include "list-objects-filter-blobs-limit.h"
+
+#define DEFAULT_MAP_SIZE (16*1024)
+
+/*
+ * A filter for list-objects to omit large blobs,
+ * but always include ".git*" special files.
+ * And to OPTIONALLY collect a list of the omitted OIDs.
+ */
+struct filter_blobs_limit_data {
+	struct oidmap *omits;
+	unsigned long max_bytes;
+};
+
+static list_objects_filter_result filter_blobs_limit(
+	list_objects_filter_type filter_type,
+	struct object *obj,
+	const char *pathname,
+	const char *filename,
+	void *filter_data_)
+{
+	struct filter_blobs_limit_data *filter_data = filter_data_;
+	struct list_objects_filter_data_entry *entry;
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
+
+		/*
+		 * If we are keeping a list of the omitted objects
+		 * for the caller *AND* we previously "provisionally"
+		 * omitted this object (because of size) *AND* it now
+		 * has a special filename, make it not-omitted.
+		 * Otherwise, continue to provisionally omit it.
+		 */
+		if (filter_data->omits &&
+		    oidmap_get(filter_data->omits, &obj->oid)) {
+			if (!is_special_filename)
+				return LOFR_ZERO;
+			entry = oidmap_remove(filter_data->omits, &obj->oid);
+			free(entry);
+			return LOFR_MARK_SEEN | LOFR_SHOW;
+		}
+
+		/*
+		 * If filename matches ".git*", always include it (regardless
+		 * of size).  (This may include blobs that we do not have
+		 * locally.)
+		 */
+		if (is_special_filename)
+			return LOFR_MARK_SEEN | LOFR_SHOW;
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
+			return LOFR_MARK_SEEN | LOFR_SHOW;
+		}
+
+		if (object_length < filter_data->max_bytes)
+			return LOFR_MARK_SEEN | LOFR_SHOW;
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
+			list_objects_filter_map_insert(filter_data->omits,
+						       &obj->oid, pathname,
+						       obj->type);
+
+		return LOFR_ZERO;
+	}
+}
+
+void traverse_commit_list__blobs_limit(
+	struct rev_info *revs,
+	show_commit_fn show_commit,
+	show_object_fn show_object,
+	list_objects_filter_map_foreach_cb print_omitted_object,
+	void *ctx_data,
+	unsigned long large_byte_limit)
+{
+	struct filter_blobs_limit_data d;
+
+	memset(&d, 0, sizeof(d));
+	if (print_omitted_object) {
+		d.omits = xcalloc(1, sizeof(*d.omits));
+		oidmap_init(d.omits, DEFAULT_MAP_SIZE);
+	}
+	d.max_bytes = large_byte_limit;
+
+	traverse_commit_list_worker(revs, show_commit, show_object, ctx_data,
+				    filter_blobs_limit, &d);
+
+	if (print_omitted_object) {
+		list_objects_filter_map_foreach(d.omits, print_omitted_object,
+						ctx_data);
+		oidmap_free(d.omits, 1);
+	}
+}
diff --git a/list-objects-filter-blobs-limit.h b/list-objects-filter-blobs-limit.h
new file mode 100644
index 0000000..ea05088
--- /dev/null
+++ b/list-objects-filter-blobs-limit.h
@@ -0,0 +1,18 @@
+#ifndef LIST_OBJECTS_FILTER_BLOBS_LIMIT_H
+#define LIST_OBJECTS_FILTER_BLOBS_LIMIT_H
+
+#include "list-objects-filter-map.h"
+
+/*
+ * A filter for list-objects to omit large blobs,
+ * but always include ".git*" special files.
+ */
+void traverse_commit_list__blobs_limit(
+	struct rev_info *revs,
+	show_commit_fn show_commit,
+	show_object_fn show_object,
+	list_objects_filter_map_foreach_cb print_omitted_object,
+	void *ctx_data,
+	unsigned long large_byte_limit);
+
+#endif /* LIST_OBJECTS_FILTER_BLOBS_LIMIT_H */
-- 
2.9.3

