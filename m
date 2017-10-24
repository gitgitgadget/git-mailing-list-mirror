Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47A4A1FF72
	for <e@80x24.org>; Tue, 24 Oct 2017 18:54:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751604AbdJXSyA (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Oct 2017 14:54:00 -0400
Received: from siwi.pair.com ([209.68.5.199]:10690 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751535AbdJXSx7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Oct 2017 14:53:59 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 7B89C8459B;
        Tue, 24 Oct 2017 14:53:58 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id DF23484597;
        Tue, 24 Oct 2017 14:53:57 -0400 (EDT)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH 02/13] list-objects-filter-map: extend oidmap to collect omitted objects
Date:   Tue, 24 Oct 2017 18:53:21 +0000
Message-Id: <20171024185332.57261-3-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20171024185332.57261-1-git@jeffhostetler.com>
References: <20171024185332.57261-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Create helper class to extend oidmap to collect a list of
omitted or missing objects during traversal.

This will be used in a later commit by the list-object filtering
code.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Makefile                  |  1 +
 list-objects-filter-map.c | 63 +++++++++++++++++++++++++++++++++++++++++++++++
 list-objects-filter-map.h | 26 +++++++++++++++++++
 3 files changed, 90 insertions(+)
 create mode 100644 list-objects-filter-map.c
 create mode 100644 list-objects-filter-map.h

diff --git a/Makefile b/Makefile
index cd75985..e59f12d 100644
--- a/Makefile
+++ b/Makefile
@@ -807,6 +807,7 @@ LIB_OBJS += levenshtein.o
 LIB_OBJS += line-log.o
 LIB_OBJS += line-range.o
 LIB_OBJS += list-objects.o
+LIB_OBJS += list-objects-filter-map.o
 LIB_OBJS += ll-merge.o
 LIB_OBJS += lockfile.o
 LIB_OBJS += log-tree.o
diff --git a/list-objects-filter-map.c b/list-objects-filter-map.c
new file mode 100644
index 0000000..7e496b3
--- /dev/null
+++ b/list-objects-filter-map.c
@@ -0,0 +1,63 @@
+#include "cache.h"
+#include "list-objects-filter-map.h"
+
+int list_objects_filter_map_insert(struct oidmap *map,
+				   const struct object_id *oid,
+				   const char *pathname, enum object_type type)
+{
+	size_t len, size;
+	struct list_objects_filter_map_entry *e;
+
+	if (oidmap_get(map, oid))
+		return 1;
+
+	len = ((pathname && *pathname) ? strlen(pathname) : 0);
+	size = (offsetof(struct list_objects_filter_map_entry, pathname) + len + 1);
+	e = xcalloc(1, size);
+
+	oidcpy(&e->entry.oid, oid);
+	e->type = type;
+	if (pathname && *pathname)
+		strcpy(e->pathname, pathname);
+
+	oidmap_put(map, e);
+	return 0;
+}
+
+static int my_cmp(const void *a, const void *b)
+{
+	const struct oidmap_entry *ea, *eb;
+
+	ea = *(const struct oidmap_entry **)a;
+	eb = *(const struct oidmap_entry **)b;
+
+	return oidcmp(&ea->oid, &eb->oid);
+}
+
+void list_objects_filter_map_foreach(struct oidmap *map,
+				     list_objects_filter_map_foreach_cb cb,
+				     void *cb_data)
+{
+	struct hashmap_iter iter;
+	struct list_objects_filter_map_entry **array;
+	struct list_objects_filter_map_entry *e;
+	int k, nr;
+
+	nr = hashmap_get_size(&map->map);
+	if (!nr)
+		return;
+
+	array = xcalloc(nr, sizeof(*e));
+
+	k = 0;
+	hashmap_iter_init(&map->map, &iter);
+	while ((e = hashmap_iter_next(&iter)))
+		array[k++] = e;
+
+	QSORT(array, nr, my_cmp);
+
+	for (k = 0; k < nr; k++)
+		cb(k, nr, array[k], cb_data);
+
+	free(array);
+}
diff --git a/list-objects-filter-map.h b/list-objects-filter-map.h
new file mode 100644
index 0000000..794fc81
--- /dev/null
+++ b/list-objects-filter-map.h
@@ -0,0 +1,26 @@
+#ifndef LIST_OBJECTS_FILTER_MAP_H
+#define LIST_OBJECTS_FILTER_MAP_H
+
+#include "oidmap.h"
+
+struct list_objects_filter_map_entry {
+	struct oidmap_entry entry; /* must be first */
+	enum object_type type;
+	char pathname[FLEX_ARRAY];
+};
+
+extern int list_objects_filter_map_insert(
+	struct oidmap *map,
+	const struct object_id *oid,
+	const char *pathname, enum object_type type);
+
+typedef void (*list_objects_filter_map_foreach_cb)(
+	int i, int i_limit,
+	struct list_objects_filter_map_entry *e, void *cb_data);
+
+extern void list_objects_filter_map_foreach(
+	struct oidmap *map,
+	list_objects_filter_map_foreach_cb cb,
+	void *cb_data);
+
+#endif /* LIST_OBJECTS_FILTER_MAP_H */
-- 
2.9.3

