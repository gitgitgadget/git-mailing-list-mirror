Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02D001FAF4
	for <e@80x24.org>; Wed,  8 Feb 2017 21:01:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751523AbdBHVBY (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 16:01:24 -0500
Received: from cloud.peff.net ([104.130.231.41]:51788 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751040AbdBHVBX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 16:01:23 -0500
Received: (qmail 28448 invoked by uid 109); 8 Feb 2017 20:53:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 08 Feb 2017 20:53:09 +0000
Received: (qmail 6576 invoked by uid 111); 8 Feb 2017 20:53:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 08 Feb 2017 15:53:14 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Feb 2017 15:53:07 -0500
Date:   Wed, 8 Feb 2017 15:53:07 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 07/11] add oidset API
Message-ID: <20170208205307.uvgj3saf3cyrvtan@sigill.intra.peff.net>
References: <20170208205219.twgm5rggovqbepte@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170208205219.twgm5rggovqbepte@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is similar to many of our uses of sha1-array, but it
overcomes one limitation of a sha1-array: when you are
de-duplicating a large input with relatively few unique
entries, sha1-array uses 20 bytes per non-unique entry.
Whereas this set will use memory linear in the number of
unique entries (albeit a few more than 20 bytes due to
hashmap overhead).

Signed-off-by: Jeff King <peff@peff.net>
---
 Makefile |  1 +
 oidset.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 oidset.h | 45 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 95 insertions(+)
 create mode 100644 oidset.c
 create mode 100644 oidset.h

diff --git a/Makefile b/Makefile
index 8e4081e06..a5433978e 100644
--- a/Makefile
+++ b/Makefile
@@ -781,6 +781,7 @@ LIB_OBJS += notes-cache.o
 LIB_OBJS += notes-merge.o
 LIB_OBJS += notes-utils.o
 LIB_OBJS += object.o
+LIB_OBJS += oidset.o
 LIB_OBJS += pack-bitmap.o
 LIB_OBJS += pack-bitmap-write.o
 LIB_OBJS += pack-check.o
diff --git a/oidset.c b/oidset.c
new file mode 100644
index 000000000..ac169f05d
--- /dev/null
+++ b/oidset.c
@@ -0,0 +1,49 @@
+#include "cache.h"
+#include "oidset.h"
+
+struct oidset_entry {
+	struct hashmap_entry hash;
+	struct object_id oid;
+};
+
+static int oidset_hashcmp(const void *va, const void *vb,
+			  const void *vkey)
+{
+	const struct oidset_entry *a = va, *b = vb;
+	const struct object_id *key = vkey;
+	return oidcmp(&a->oid, key ? key : &b->oid);
+}
+
+int oidset_contains(const struct oidset *set, const struct object_id *oid)
+{
+	struct hashmap_entry key;
+
+	if (!set->map.cmpfn)
+		return 0;
+
+	hashmap_entry_init(&key, sha1hash(oid->hash));
+	return !!hashmap_get(&set->map, &key, oid);
+}
+
+int oidset_insert(struct oidset *set, const struct object_id *oid)
+{
+	struct oidset_entry *entry;
+
+	if (!set->map.cmpfn)
+		hashmap_init(&set->map, oidset_hashcmp, 0);
+
+	if (oidset_contains(set, oid))
+		return 1;
+
+	entry = xmalloc(sizeof(*entry));
+	hashmap_entry_init(&entry->hash, sha1hash(oid->hash));
+	oidcpy(&entry->oid, oid);
+
+	hashmap_add(&set->map, entry);
+	return 0;
+}
+
+void oidset_clear(struct oidset *set)
+{
+	hashmap_free(&set->map, 1);
+}
diff --git a/oidset.h b/oidset.h
new file mode 100644
index 000000000..b7eaab5b8
--- /dev/null
+++ b/oidset.h
@@ -0,0 +1,45 @@
+#ifndef OIDSET_H
+#define OIDSET_H
+
+/**
+ * This API is similar to sha1-array, in that it maintains a set of object ids
+ * in a memory-efficient way. The major differences are:
+ *
+ *   1. It uses a hash, so we can do online duplicate removal, rather than
+ *      sort-and-uniq at the end. This can reduce memory footprint if you have
+ *      a large list of oids with many duplicates.
+ *
+ *   2. The per-unique-oid memory footprint is slightly higher due to hash
+ *      table overhead.
+ */
+
+/**
+ * A single oidset; should be zero-initialized (or use OIDSET_INIT).
+ */
+struct oidset {
+	struct hashmap map;
+};
+
+#define OIDSET_INIT { { NULL } }
+
+/**
+ * Returns true iff `set` contains `oid`.
+ */
+int oidset_contains(const struct oidset *set, const struct object_id *oid);
+
+/**
+ * Insert the oid into the set; a copy is made, so "oid" does not need
+ * to persist after this function is called.
+ *
+ * Returns 1 if the oid was already in the set, 0 otherwise. This can be used
+ * to perform an efficient check-and-add.
+ */
+int oidset_insert(struct oidset *set, const struct object_id *oid);
+
+/**
+ * Remove all entries from the oidset, freeing any resources associated with
+ * it.
+ */
+void oidset_clear(struct oidset *set);
+
+#endif /* OIDSET_H */
-- 
2.12.0.rc0.371.ga6cf8653b

