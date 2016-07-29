Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1BA81F858
	for <e@80x24.org>; Fri, 29 Jul 2016 04:07:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbcG2EHF (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 00:07:05 -0400
Received: from cloud.peff.net ([50.56.180.127]:50803 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751123AbcG2EHD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2016 00:07:03 -0400
Received: (qmail 24095 invoked by uid 102); 29 Jul 2016 04:07:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 29 Jul 2016 00:07:03 -0400
Received: (qmail 31349 invoked by uid 107); 29 Jul 2016 04:07:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 29 Jul 2016 00:07:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Jul 2016 00:06:59 -0400
Date:	Fri, 29 Jul 2016 00:06:59 -0400
From:	Jeff King <peff@peff.net>
To:	git@vger.kernel.org
Cc:	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/7] add generic most-recently-used list
Message-ID: <20160729040659.GC22408@sigill.intra.peff.net>
References: <20160729040422.GA19678@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160729040422.GA19678@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

There are a few places in Git that would benefit from a fast
most-recently-used cache (e.g., the list of packs, which we
search linearly but would like to order based on locality).
This patch introduces a generic list that can be used to
store arbitrary pointers in most-recently-used order.

The implementation is just a doubly-linked list, where
"marking" an item as used moves it to the front of the list.
Insertion and marking are O(1), and iteration is O(n).

There's no lookup support provided; if you need fast
lookups, you are better off with a different data structure
in the first place.

There is also no deletion support. This would not be hard to
do, but it's not necessary for handling pack structs, which
are created and never removed.

Signed-off-by: Jeff King <peff@peff.net>
---
 Makefile |  1 +
 mru.c    | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 mru.h    | 45 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 96 insertions(+)
 create mode 100644 mru.c
 create mode 100644 mru.h

diff --git a/Makefile b/Makefile
index 6a13386..ad3624d 100644
--- a/Makefile
+++ b/Makefile
@@ -755,6 +755,7 @@ LIB_OBJS += merge.o
 LIB_OBJS += merge-blobs.o
 LIB_OBJS += merge-recursive.o
 LIB_OBJS += mergesort.o
+LIB_OBJS += mru.o
 LIB_OBJS += name-hash.o
 LIB_OBJS += notes.o
 LIB_OBJS += notes-cache.o
diff --git a/mru.c b/mru.c
new file mode 100644
index 0000000..9dedae0
--- /dev/null
+++ b/mru.c
@@ -0,0 +1,50 @@
+#include "cache.h"
+#include "mru.h"
+
+void mru_append(struct mru *mru, void *item)
+{
+	struct mru_entry *cur = xmalloc(sizeof(*cur));
+	cur->item = item;
+	cur->prev = mru->tail;
+	cur->next = NULL;
+
+	if (mru->tail)
+		mru->tail->next = cur;
+	else
+		mru->head = cur;
+	mru->tail = cur;
+}
+
+void mru_mark(struct mru *mru, struct mru_entry *entry)
+{
+	/* If we're already at the front of the list, nothing to do */
+	if (mru->head == entry)
+		return;
+
+	/* Otherwise, remove us from our current slot... */
+	if (entry->prev)
+		entry->prev->next = entry->next;
+	if (entry->next)
+		entry->next->prev = entry->prev;
+	else
+		mru->tail = entry->prev;
+
+	/* And insert us at the beginning. */
+	entry->prev = NULL;
+	entry->next = mru->head;
+	if (mru->head)
+		mru->head->prev = entry;
+	mru->head = entry;
+}
+
+void mru_clear(struct mru *mru)
+{
+	struct mru_entry *p = mru->head;
+
+	while (p) {
+		struct mru_entry *to_free = p;
+		p = p->next;
+		free(to_free);
+	}
+	mru->head = mru->tail = NULL;
+}
diff --git a/mru.h b/mru.h
new file mode 100644
index 0000000..42e4aea
--- /dev/null
+++ b/mru.h
@@ -0,0 +1,45 @@
+#ifndef MRU_H
+#define MRU_H
+
+/**
+ * A simple most-recently-used cache, backed by a doubly-linked list.
+ *
+ * Usage is roughly:
+ *
+ *   // Create a list.  Zero-initialization is required.
+ *   static struct mru cache;
+ *   mru_append(&cache, item);
+ *   ...
+ *
+ *   // Iterate in MRU order.
+ *   struct mru_entry *p;
+ *   for (p = cache.head; p; p = p->next) {
+ *	if (matches(p->item))
+ *		break;
+ *   }
+ *
+ *   // Mark an item as used, moving it to the front of the list.
+ *   mru_mark(&cache, p);
+ *
+ *   // Reset the list to empty, cleaning up all resources.
+ *   mru_clear(&cache);
+ *
+ * Note that you SHOULD NOT call mru_mark() and then continue traversing the
+ * list; it reorders the marked item to the front of the list, and therefore
+ * you will begin traversing the whole list again.
+ */
+
+struct mru_entry {
+	void *item;
+	struct mru_entry *prev, *next;
+};
+
+struct mru {
+	struct mru_entry *head, *tail;
+};
+
+void mru_append(struct mru *mru, void *item);
+void mru_mark(struct mru *mru, struct mru_entry *entry);
+void mru_clear(struct mru *mru);
+
+#endif /* MRU_H */
-- 
2.9.2.607.g98dce7b

