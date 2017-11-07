Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7759B202A0
	for <e@80x24.org>; Tue,  7 Nov 2017 19:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752100AbdKGTgD (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Nov 2017 14:36:03 -0500
Received: from siwi.pair.com ([209.68.5.199]:40493 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751649AbdKGTgA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Nov 2017 14:36:00 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 10AAD8453C;
        Tue,  7 Nov 2017 14:36:00 -0500 (EST)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 78FA684537;
        Tue,  7 Nov 2017 14:35:59 -0500 (EST)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v3 3/6] oidset: add iterator methods to oidset
Date:   Tue,  7 Nov 2017 19:35:43 +0000
Message-Id: <20171107193546.10017-4-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20171107193546.10017-1-git@jeffhostetler.com>
References: <20171107193546.10017-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Add the usual iterator methods to oidset.
Add oidset_remove().

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 oidset.c | 10 ++++++++++
 oidset.h | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/oidset.c b/oidset.c
index f1f874a..454c54f 100644
--- a/oidset.c
+++ b/oidset.c
@@ -24,6 +24,16 @@ int oidset_insert(struct oidset *set, const struct object_id *oid)
 	return 0;
 }
 
+int oidset_remove(struct oidset *set, const struct object_id *oid)
+{
+	struct oidmap_entry *entry;
+
+	entry = oidmap_remove(&set->map, oid);
+	free(entry);
+
+	return (entry != NULL);
+}
+
 void oidset_clear(struct oidset *set)
 {
 	oidmap_free(&set->map, 1);
diff --git a/oidset.h b/oidset.h
index f4c9e0f..783abce 100644
--- a/oidset.h
+++ b/oidset.h
@@ -24,6 +24,12 @@ struct oidset {
 
 #define OIDSET_INIT { OIDMAP_INIT }
 
+
+static inline void oidset_init(struct oidset *set, size_t initial_size)
+{
+	return oidmap_init(&set->map, initial_size);
+}
+
 /**
  * Returns true iff `set` contains `oid`.
  */
@@ -39,9 +45,39 @@ int oidset_contains(const struct oidset *set, const struct object_id *oid);
 int oidset_insert(struct oidset *set, const struct object_id *oid);
 
 /**
+ * Remove the oid from the set.
+ *
+ * Returns 1 if the oid was present in the set, 0 otherwise.
+ */
+int oidset_remove(struct oidset *set, const struct object_id *oid);
+
+/**
  * Remove all entries from the oidset, freeing any resources associated with
  * it.
  */
 void oidset_clear(struct oidset *set);
 
+struct oidset_iter {
+	struct oidmap_iter m_iter;
+};
+
+static inline void oidset_iter_init(struct oidset *set,
+				    struct oidset_iter *iter)
+{
+	oidmap_iter_init(&set->map, &iter->m_iter);
+}
+
+static inline struct object_id *oidset_iter_next(struct oidset_iter *iter)
+{
+	struct oidmap_entry *e = oidmap_iter_next(&iter->m_iter);
+	return e ? &e->oid : NULL;
+}
+
+static inline struct object_id *oidset_iter_first(struct oidset *set,
+						  struct oidset_iter *iter)
+{
+	oidset_iter_init(set, iter);
+	return oidset_iter_next(iter);
+}
+
 #endif /* OIDSET_H */
-- 
2.9.3

