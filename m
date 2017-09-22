Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 428DD202A5
	for <e@80x24.org>; Fri, 22 Sep 2017 20:27:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752107AbdIVU1E (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Sep 2017 16:27:04 -0400
Received: from siwi.pair.com ([209.68.5.199]:27076 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752055AbdIVU1C (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2017 16:27:02 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 1D52584709;
        Fri, 22 Sep 2017 16:27:02 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 97EBA84706;
        Fri, 22 Sep 2017 16:27:01 -0400 (EDT)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com,
        jeffhost@microsoft.com
Subject: [PATCH 02/13] oidset2: create oidset subclass with object length and pathname
Date:   Fri, 22 Sep 2017 20:26:21 +0000
Message-Id: <20170922202632.53714-3-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170922202632.53714-1-git@jeffhostetler.com>
References: <20170922202632.53714-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Create subclass of oidset where each entry has a
field to store the length of the object's content
and an optional pathname.

This will be used in a future commit to build a
manifest of omitted objects in a partial/narrow
clone/fetch.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Makefile  |   1 +
 oidset2.c | 104 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 oidset2.h |  58 +++++++++++++++++++++++++++++++++++
 3 files changed, 163 insertions(+)
 create mode 100644 oidset2.c
 create mode 100644 oidset2.h

diff --git a/Makefile b/Makefile
index 461c845..4e0cc39 100644
--- a/Makefile
+++ b/Makefile
@@ -816,6 +816,7 @@ LIB_OBJS += notes-merge.o
 LIB_OBJS += notes-utils.o
 LIB_OBJS += object.o
 LIB_OBJS += oidset.o
+LIB_OBJS += oidset2.o
 LIB_OBJS += pack-bitmap.o
 LIB_OBJS += pack-bitmap-write.o
 LIB_OBJS += pack-check.o
diff --git a/oidset2.c b/oidset2.c
new file mode 100644
index 0000000..43bc9ee
--- /dev/null
+++ b/oidset2.c
@@ -0,0 +1,104 @@
+#include "cache.h"
+#include "oidset2.h"
+
+static int oidset2_hashcmp(const void *unused_cmp_data,
+			   const void *va, const void *vb,
+			   const void *vkey)
+{
+	const struct oidset2_entry *a = va, *b = vb;
+	const struct object_id *key = vkey;
+	return oidcmp(&a->oid, key ? key : &b->oid);
+}
+
+struct oidset2_entry *oidset2_get(const struct oidset2 *set, const struct object_id *oid)
+{
+	struct hashmap_entry key;
+	struct oidset2_entry *value;
+
+	if (!set->map.cmpfn)
+		return NULL;
+
+	hashmap_entry_init(&key, sha1hash(oid->hash));
+	value = hashmap_get(&set->map, &key, oid);
+
+	return value;
+}
+
+int oidset2_contains(const struct oidset2 *set, const struct object_id *oid)
+{
+	return !!oidset2_get(set, oid);
+}
+
+int oidset2_insert(struct oidset2 *set, const struct object_id *oid,
+		   enum object_type type, int64_t object_length,
+		   const char *pathname)
+{
+	struct oidset2_entry *entry;
+
+	if (!set->map.cmpfn)
+		hashmap_init(&set->map, oidset2_hashcmp, NULL, 0);
+
+	if (oidset2_contains(set, oid))
+		return 1;
+
+	entry = xcalloc(1, sizeof(*entry));
+	hashmap_entry_init(&entry->hash, sha1hash(oid->hash));
+	oidcpy(&entry->oid, oid);
+
+	entry->type = type;
+	entry->object_length = object_length;
+	if (pathname)
+	    entry->pathname = strdup(pathname);
+
+	hashmap_add(&set->map, entry);
+	return 0;
+}
+
+void oidset2_remove(struct oidset2 *set, const struct object_id *oid)
+{
+	struct hashmap_entry key;
+	struct oidset2_entry *e;
+
+	hashmap_entry_init(&key, sha1hash(oid->hash));
+	e = hashmap_remove(&set->map, &key, oid);
+
+	free(e->pathname);
+	free(e);
+}
+
+void oidset2_clear(struct oidset2 *set)
+{
+	hashmap_free(&set->map, 1);
+}
+
+static int oidset2_cmp(const void *a, const void *b)
+{
+	const struct oidset2_entry *ae = *((const struct oidset2_entry **)a);
+	const struct oidset2_entry *be = *((const struct oidset2_entry **)b);
+
+	return oidcmp(&ae->oid, &be->oid);
+}
+
+void oidset2_foreach(struct oidset2 *set, oidset2_foreach_cb cb, void *cb_data)
+{
+	struct hashmap_iter iter;
+	struct oidset2_entry **array;
+	struct oidset2_entry *e;
+	int j, k;
+
+	array = xcalloc(set->map.size, sizeof(*e));
+
+	hashmap_iter_init(&set->map, &iter);
+	k = 0;
+	while ((e = hashmap_iter_next(&iter)))
+		array[k++] = e;
+
+	QSORT(array, k, oidset2_cmp);
+
+	for (j = 0; j < k; j++) {
+		e = array[j];
+		cb(j, k, e, cb_data);
+	}
+
+	free(array);
+}
diff --git a/oidset2.h b/oidset2.h
new file mode 100644
index 0000000..67d8a5a
--- /dev/null
+++ b/oidset2.h
@@ -0,0 +1,58 @@
+#ifndef OIDSET2_H
+#define OIDSET2_H
+
+/**
+ * oidset2 is a variant of oidset, but allows additional fields for each object.
+ */
+
+/**
+ * A single oidset2; should be zero-initialized (or use OIDSET2_INIT).
+ */
+struct oidset2 {
+	struct hashmap map;
+};
+
+#define OIDSET2_INIT { { NULL } }
+
+struct oidset2_entry {
+	struct hashmap_entry hash;
+	struct object_id oid;
+
+	enum object_type type;
+	int64_t object_length;	/* This is SIGNED. Use -1 when unknown. */
+	char *pathname;
+};
+
+struct oidset2_entry *oidset2_get(const struct oidset2 *set, const struct object_id *oid);
+
+/**
+ * Returns true iff `set` contains `oid`.
+ */
+int oidset2_contains(const struct oidset2 *set, const struct object_id *oid);
+
+/**
+ * Insert the oid into the set; a copy is made, so "oid" does not need
+ * to persist after this function is called.
+ *
+ * Returns 1 if the oid was already in the set, 0 otherwise. This can be used
+ * to perform an efficient check-and-add.
+ */
+int oidset2_insert(struct oidset2 *set, const struct object_id *oid,
+		   enum object_type type, int64_t object_length,
+		   const char *pathname);
+
+void oidset2_remove(struct oidset2 *set, const struct object_id *oid);
+
+typedef void (*oidset2_foreach_cb)(
+	int i, int i_limit,
+	struct oidset2_entry *e, void *cb_data);
+
+void oidset2_foreach(struct oidset2 *set, oidset2_foreach_cb cb, void *cb_data);
+
+/**
+ * Remove all entries from the oidset2, freeing any resources associated with
+ * it.
+ */
+void oidset2_clear(struct oidset2 *set);
+
+#endif /* OIDSET2_H */
-- 
2.9.3

