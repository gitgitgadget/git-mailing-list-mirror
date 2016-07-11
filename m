Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,URIBL_RED
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A1E91F744
	for <e@80x24.org>; Mon, 11 Jul 2016 20:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932350AbcGKUvp (ORCPT <rfc822;e@80x24.org>);
	Mon, 11 Jul 2016 16:51:45 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:33738 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932221AbcGKUvo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2016 16:51:44 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id E418120193;
	Mon, 11 Jul 2016 20:51:35 +0000 (UTC)
From:	Eric Wong <e@80x24.org>
To:	git@vger.kernel.org
Cc:	Eric Wong <e@80x24.org>
Subject: [PATCH 3/3] http-walker: reduce O(n) ops with doubly-linked list
Date:	Mon, 11 Jul 2016 20:51:31 +0000
Message-Id: <20160711205131.1291-4-e@80x24.org>
In-Reply-To: <20160711205131.1291-1-e@80x24.org>
References: <20160711205131.1291-1-e@80x24.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Using the a Linux-kernel-derived doubly-linked list
implementation from the Userspace RCU library allows us to
enqueue and delete items from the object request queue in
constant time.

This change reduces enqueue times in the prefetch() function
where object request queue could grow to several thousand
objects.

I left out the list_for_each_entry* family macros from list.h
which relied on the __typeof__ operator as we support platforms
without it.  Thus, list_entry (aka "container_of") needs to be
called explicitly inside macro-wrapped for loops.

The downside is this costs us an additional pointer per object
request, but this is offset by reduced overhead on queue
operations leading to improved performance and shorter queue
depths.

Signed-off-by: Eric Wong <e@80x24.org>
---
 http-walker.c |  42 ++++++---------
 list.h        | 164 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 179 insertions(+), 27 deletions(-)
 create mode 100644 list.h

diff --git a/http-walker.c b/http-walker.c
index 48f2df4..0b24255 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -2,6 +2,7 @@
 #include "commit.h"
 #include "walker.h"
 #include "http.h"
+#include "list.h"
 
 struct alt_base {
 	char *base;
@@ -23,7 +24,7 @@ struct object_request {
 	struct alt_base *repo;
 	enum object_request_state state;
 	struct http_object_request *req;
-	struct object_request *next;
+	struct list_head node;
 };
 
 struct alternates_request {
@@ -41,7 +42,7 @@ struct walker_data {
 	struct alt_base *alt;
 };
 
-static struct object_request *object_queue_head;
+static LIST_HEAD(object_queue_head);
 
 static void fetch_alternates(struct walker *walker, const char *base);
 
@@ -110,19 +111,10 @@ static void process_object_response(void *callback_data)
 
 static void release_object_request(struct object_request *obj_req)
 {
-	struct object_request *entry = object_queue_head;
-
 	if (obj_req->req !=NULL && obj_req->req->localfile != -1)
 		error("fd leakage in release: %d", obj_req->req->localfile);
-	if (obj_req == object_queue_head) {
-		object_queue_head = obj_req->next;
-	} else {
-		while (entry->next != NULL && entry->next != obj_req)
-			entry = entry->next;
-		if (entry->next == obj_req)
-			entry->next = entry->next->next;
-	}
 
+	list_del(&obj_req->node);
 	free(obj_req);
 }
 
@@ -130,8 +122,10 @@ static void release_object_request(struct object_request *obj_req)
 static int fill_active_slot(struct walker *walker)
 {
 	struct object_request *obj_req;
+	struct list_head *pos, *tmp, *head = &object_queue_head;
 
-	for (obj_req = object_queue_head; obj_req; obj_req = obj_req->next) {
+	list_for_each_safe(pos, tmp, head) {
+		obj_req = list_entry(pos, struct object_request, node);
 		if (obj_req->state == WAITING) {
 			if (has_sha1_file(obj_req->sha1))
 				obj_req->state = COMPLETE;
@@ -148,7 +142,6 @@ static int fill_active_slot(struct walker *walker)
 static void prefetch(struct walker *walker, unsigned char *sha1)
 {
 	struct object_request *newreq;
-	struct object_request *tail;
 	struct walker_data *data = walker->data;
 
 	newreq = xmalloc(sizeof(*newreq));
@@ -157,18 +150,9 @@ static void prefetch(struct walker *walker, unsigned char *sha1)
 	newreq->repo = data->alt;
 	newreq->state = WAITING;
 	newreq->req = NULL;
-	newreq->next = NULL;
 
 	http_is_verbose = walker->get_verbosely;
-
-	if (object_queue_head == NULL) {
-		object_queue_head = newreq;
-	} else {
-		tail = object_queue_head;
-		while (tail->next != NULL)
-			tail = tail->next;
-		tail->next = newreq;
-	}
+	list_add_tail(&newreq->node, &object_queue_head);
 
 #ifdef USE_CURL_MULTI
 	fill_active_slots();
@@ -451,11 +435,15 @@ static int fetch_object(struct walker *walker, unsigned char *sha1)
 {
 	char *hex = sha1_to_hex(sha1);
 	int ret = 0;
-	struct object_request *obj_req = object_queue_head;
+	struct object_request *obj_req = NULL;
 	struct http_object_request *req;
+	struct list_head *pos, *head = &object_queue_head;
 
-	while (obj_req != NULL && hashcmp(obj_req->sha1, sha1))
-		obj_req = obj_req->next;
+	list_for_each(pos, head) {
+		obj_req = list_entry(pos, struct object_request, node);
+		if (!hashcmp(obj_req->sha1, sha1))
+			break;
+	}
 	if (obj_req == NULL)
 		return error("Couldn't find request for %s in the queue", hex);
 
diff --git a/list.h b/list.h
new file mode 100644
index 0000000..f65edce
--- /dev/null
+++ b/list.h
@@ -0,0 +1,164 @@
+/*
+ * Copyright (C) 2002 Free Software Foundation, Inc.
+ * (originally part of the GNU C Library and Userspace RCU)
+ * Contributed by Ulrich Drepper <drepper@redhat.com>, 2002.
+ *
+ * Copyright (C) 2009 Pierre-Marc Fournier
+ * Conversion to RCU list.
+ * Copyright (C) 2010 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see
+ * <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef LIST_H
+#define LIST_H	1
+
+/*
+ * The definitions of this file are adopted from those which can be
+ * found in the Linux kernel headers to enable people familiar with the
+ * latter find their way in these sources as well.
+ */
+
+/* Basic type for the double-link list. */
+struct list_head {
+	struct list_head *next, *prev;
+};
+
+/* Define a variable with the head and tail of the list. */
+#define LIST_HEAD(name) \
+	struct list_head name = { &(name), &(name) }
+
+/* Initialize a new list head. */
+#define INIT_LIST_HEAD(ptr) \
+	(ptr)->next = (ptr)->prev = (ptr)
+
+#define LIST_HEAD_INIT(name) { &(name), &(name) }
+
+/* Add new element at the head of the list. */
+static inline void list_add(struct list_head *newp, struct list_head *head)
+{
+	head->next->prev = newp;
+	newp->next = head->next;
+	newp->prev = head;
+	head->next = newp;
+}
+
+/* Add new element at the tail of the list. */
+static inline void list_add_tail(struct list_head *newp, struct list_head *head)
+{
+	head->prev->next = newp;
+	newp->next = head;
+	newp->prev = head->prev;
+	head->prev = newp;
+}
+
+/* Remove element from list. */
+static inline void __list_del(struct list_head *prev, struct list_head *next)
+{
+	next->prev = prev;
+	prev->next = next;
+}
+
+/* Remove element from list. */
+static inline void list_del(struct list_head *elem)
+{
+	__list_del(elem->prev, elem->next);
+}
+
+/* Remove element from list, initializing the element's list pointers. */
+static inline void list_del_init(struct list_head *elem)
+{
+	list_del(elem);
+	INIT_LIST_HEAD(elem);
+}
+
+/* Delete from list, add to another list as head. */
+static inline void list_move(struct list_head *elem, struct list_head *head)
+{
+	__list_del(elem->prev, elem->next);
+	list_add(elem, head);
+}
+
+/* Replace an old entry. */
+static inline void list_replace(struct list_head *old, struct list_head *newp)
+{
+	newp->next = old->next;
+	newp->prev = old->prev;
+	newp->prev->next = newp;
+	newp->next->prev = newp;
+}
+
+/* Join two lists. */
+static inline void list_splice(struct list_head *add, struct list_head *head)
+{
+	/* Do nothing if the list which gets added is empty. */
+	if (add != add->next) {
+		add->next->prev = head;
+		add->prev->next = head->next;
+		head->next->prev = add->prev;
+		head->next = add->next;
+	}
+}
+
+/* Get typed element from list at a given position. */
+#define list_entry(ptr, type, member) \
+	((type *) ((char *) (ptr) - offsetof(type, member)))
+
+/* Get first entry from a list. */
+#define list_first_entry(ptr, type, member) \
+	list_entry((ptr)->next, type, member)
+
+/* Iterate forward over the elements of the list. */
+#define list_for_each(pos, head) \
+	for (pos = (head)->next; pos != (head); pos = pos->next)
+
+/*
+ * Iterate forward over the elements list. The list elements can be
+ * removed from the list while doing this.
+ */
+#define list_for_each_safe(pos, p, head) \
+	for (pos = (head)->next, p = pos->next; \
+		pos != (head); \
+		pos = p, p = pos->next)
+
+/* Iterate backward over the elements of the list. */
+#define list_for_each_prev(pos, head) \
+	for (pos = (head)->prev; pos != (head); pos = pos->prev)
+
+/*
+ * Iterate backwards over the elements list. The list elements can be
+ * removed from the list while doing this.
+ */
+#define list_for_each_prev_safe(pos, p, head) \
+	for (pos = (head)->prev, p = pos->prev; \
+		pos != (head); \
+		pos = p, p = pos->prev)
+
+static inline int list_empty(struct list_head *head)
+{
+	return head == head->next;
+}
+
+static inline void list_replace_init(struct list_head *old,
+				     struct list_head *newp)
+{
+	struct list_head *head = old->next;
+
+	list_del(old);
+	list_add_tail(newp, head);
+	INIT_LIST_HEAD(old);
+}
+
+#endif /* LIST_H */
-- 
EW

