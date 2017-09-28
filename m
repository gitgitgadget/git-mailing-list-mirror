Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB4BC20281
	for <e@80x24.org>; Thu, 28 Sep 2017 08:38:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752498AbdI1Iim (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Sep 2017 04:38:42 -0400
Received: from a7-12.smtp-out.eu-west-1.amazonses.com ([54.240.7.12]:56786
        "EHLO a7-12.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752459AbdI1Iik (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 28 Sep 2017 04:38:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1506587919;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=OgCvOfvsMTM7ktv3bLv5foIQo/0zFofqc1nS7W6Ixuw=;
        b=YOiYqCojqHaLpNVTt4BHXgPQOGFlfyUhXsNIe+ZCwXFErskQTzHf6mX53W5QqJ4Q
        nLyAawnaJqBwrOIR9lEjLsdWmSP77CYzD2REESjf6tLs0BmGRser7x0fprN52xiDpqQ
        q0kJ7pbIrbXSoaPaSYWRwjc/ctwoe+tTfEGgh5F8=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102015ec7a3424b-529be659-bdb6-42c4-a48f-db264f33d53a-000000@eu-west-1.amazonses.com>
In-Reply-To: <CAP8UFD24A8rxMfLMFmSStWnBMMeB58SqUdNoo3niQuc7LqRMMg@mail.gmail.com>
References: <CAP8UFD24A8rxMfLMFmSStWnBMMeB58SqUdNoo3niQuc7LqRMMg@mail.gmail.com>
Subject: [PATCH Outreachy] mru: use double-linked list from list.h
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Thu, 28 Sep 2017 08:38:39 +0000
X-SES-Outgoing: 2017.09.28-54.240.7.12
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Simplify mru.c, mru.h and related code by reusing the double-linked list implementation from list.h instead of a custom one.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored by: Jeff King <peff@peff.net>
---
 builtin/pack-objects.c |  5 +++--
 mru.c                  | 51 +++++++++++++++-----------------------------------
 mru.h                  | 31 +++++++++++++-----------------
 packfile.c             |  6 ++++--
 4 files changed, 35 insertions(+), 58 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index f721137eaf881..ba812349e0aab 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -995,8 +995,8 @@ static int want_object_in_pack(const unsigned char *sha1,
 			       struct packed_git **found_pack,
 			       off_t *found_offset)
 {
-	struct mru_entry *entry;
 	int want;
+	struct list_head *pos;
 
 	if (!exclude && local && has_loose_object_nonlocal(sha1))
 		return 0;
@@ -1012,7 +1012,8 @@ static int want_object_in_pack(const unsigned char *sha1,
 			return want;
 	}
 
-	for (entry = packed_git_mru.head; entry; entry = entry->next) {
+	list_for_each(pos, &packed_git_mru.list) {
+		struct mru *entry = list_entry(pos, struct mru, list);
 		struct packed_git *p = entry->item;
 		off_t offset;
 
diff --git a/mru.c b/mru.c
index 9dedae0287ed2..8b6ba3d9b7fad 100644
--- a/mru.c
+++ b/mru.c
@@ -1,50 +1,29 @@
 #include "cache.h"
 #include "mru.h"
 
-void mru_append(struct mru *mru, void *item)
+void mru_append(struct mru *head, void *item)
 {
-	struct mru_entry *cur = xmalloc(sizeof(*cur));
+	struct mru *cur = xmalloc(sizeof(*cur));
 	cur->item = item;
-	cur->prev = mru->tail;
-	cur->next = NULL;
-
-	if (mru->tail)
-		mru->tail->next = cur;
-	else
-		mru->head = cur;
-	mru->tail = cur;
+	list_add_tail(&cur->list, &head->list);
 }
 
-void mru_mark(struct mru *mru, struct mru_entry *entry)
+void mru_mark(struct mru *head, struct mru *entry)
 {
-	/* If we're already at the front of the list, nothing to do */
-	if (mru->head == entry)
-		return;
-
-	/* Otherwise, remove us from our current slot... */
-	if (entry->prev)
-		entry->prev->next = entry->next;
-	if (entry->next)
-		entry->next->prev = entry->prev;
-	else
-		mru->tail = entry->prev;
-
-	/* And insert us at the beginning. */
-	entry->prev = NULL;
-	entry->next = mru->head;
-	if (mru->head)
-		mru->head->prev = entry;
-	mru->head = entry;
+	/* To mark means to put at the front of the list. */
+	list_del(&entry->list);
+	list_add(&entry->list, &head->list);
 }
 
-void mru_clear(struct mru *mru)
+void mru_clear(struct mru *head)
 {
-	struct mru_entry *p = mru->head;
-
-	while (p) {
-		struct mru_entry *to_free = p;
-		p = p->next;
+	struct list_head *p1;
+	struct list_head *p2;
+	struct mru *to_free;
+	
+	list_for_each_safe(p1, p2, &head->list) {
+		to_free = list_entry(p1, struct mru, list);
 		free(to_free);
 	}
-	mru->head = mru->tail = NULL;
+	INIT_LIST_HEAD(&head->list);
 }
diff --git a/mru.h b/mru.h
index 42e4aeaa1098a..36a332af0bf88 100644
--- a/mru.h
+++ b/mru.h
@@ -1,6 +1,8 @@
 #ifndef MRU_H
 #define MRU_H
 
+#include "list.h"
+
 /**
  * A simple most-recently-used cache, backed by a doubly-linked list.
  *
@@ -8,18 +10,15 @@
  *
  *   // Create a list.  Zero-initialization is required.
  *   static struct mru cache;
- *   mru_append(&cache, item);
- *   ...
+ *   INIT_LIST_HEAD(&cache.list);
  *
- *   // Iterate in MRU order.
- *   struct mru_entry *p;
- *   for (p = cache.head; p; p = p->next) {
- *	if (matches(p->item))
- *		break;
- *   }
+ *   // Add new item to the end of the list.
+ *   void *item;
+ *   ...
+ *   mru_append(&cache, item);
  *
  *   // Mark an item as used, moving it to the front of the list.
- *   mru_mark(&cache, p);
+ *   mru_mark(&cache, item);
  *
  *   // Reset the list to empty, cleaning up all resources.
  *   mru_clear(&cache);
@@ -29,17 +28,13 @@
  * you will begin traversing the whole list again.
  */
 
-struct mru_entry {
-	void *item;
-	struct mru_entry *prev, *next;
-};
-
 struct mru {
-	struct mru_entry *head, *tail;
+	struct list_head list;
+        void *item;
 };
 
-void mru_append(struct mru *mru, void *item);
-void mru_mark(struct mru *mru, struct mru_entry *entry);
-void mru_clear(struct mru *mru);
+void mru_append(struct mru *head, void *item);
+void mru_mark(struct mru *head, struct mru *entry);
+void mru_clear(struct mru *head);
 
 #endif /* MRU_H */
diff --git a/packfile.c b/packfile.c
index f69a5c8d607af..ae3b0b2e9c09a 100644
--- a/packfile.c
+++ b/packfile.c
@@ -876,6 +876,7 @@ void prepare_packed_git(void)
 	for (alt = alt_odb_list; alt; alt = alt->next)
 		prepare_packed_git_one(alt->path, 0);
 	rearrange_packed_git();
+	INIT_LIST_HEAD(&packed_git_mru.list);
 	prepare_packed_git_mru();
 	prepare_packed_git_run_once = 1;
 }
@@ -1824,13 +1825,14 @@ static int fill_pack_entry(const unsigned char *sha1,
  */
 int find_pack_entry(const unsigned char *sha1, struct pack_entry *e)
 {
-	struct mru_entry *p;
+	struct list_head *pos;
 
 	prepare_packed_git();
 	if (!packed_git)
 		return 0;
 
-	for (p = packed_git_mru.head; p; p = p->next) {
+	list_for_each(pos, &packed_git_mru.list) {
+		struct mru *p = list_entry(pos, struct mru, list);
 		if (fill_pack_entry(sha1, e, p->item)) {
 			mru_mark(&packed_git_mru, p);
 			return 1;

--
https://github.com/git/git/pull/409
