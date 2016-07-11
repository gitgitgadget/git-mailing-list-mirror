Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,URIBL_RED
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 913301F744
	for <e@80x24.org>; Mon, 11 Jul 2016 21:02:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753471AbcGKVCv (ORCPT <rfc822;e@80x24.org>);
	Mon, 11 Jul 2016 17:02:51 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:34618 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753293AbcGKVCt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2016 17:02:49 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id C46F51F744;
	Mon, 11 Jul 2016 21:02:43 +0000 (UTC)
Date:	Mon, 11 Jul 2016 21:02:43 +0000
From:	Eric Wong <e@80x24.org>
To:	git@vger.kernel.org
Subject: [REJECT 4/3] http-walker: use hashmap to reduce list scan
Message-ID: <20160711210243.GA1604@whir>
References: <20160711205131.1291-1-e@80x24.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160711205131.1291-1-e@80x24.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

For the sake of documentation, I worked on this patch but I
don't there was a measurable improvement (hard to tell with
variable network conditions) and it increased memory usage to
around 380M.

I wanted to reduce the list scanning in fill_active_slot() by
deleting during iteration, but I'm not sure it helps since the
loop in that is nowhere near as bad as the prefetch() insertion
loop fixed in 3/3.

list_for_each in fetch_object() also tends hit the first object
in the list when iterating, so there's no improvement I see
with this patch.

-----8<------
Subject: [PATCH] http-walker: use hashmap to reduce list scan

We can reduce list walking in fill_active_slot by deleting items
as we walk through the object request queue of pending objects.

However, we still need to maintain a mapping of live objects
for fetch_object, so introduce the use of a hashmap to keep
track of all live object requests in O(1) average time.

Signed-off-by: Eric Wong <e@80x24.org>
---
 http-walker.c | 35 +++++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/http-walker.c b/http-walker.c
index 0b24255..8d27707 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -3,6 +3,7 @@
 #include "walker.h"
 #include "http.h"
 #include "list.h"
+#include "hashmap.h"
 
 struct alt_base {
 	char *base;
@@ -19,6 +20,7 @@ enum object_request_state {
 };
 
 struct object_request {
+	struct hashmap_entry ent;
 	struct walker *walker;
 	unsigned char sha1[20];
 	struct alt_base *repo;
@@ -43,6 +45,7 @@ struct walker_data {
 };
 
 static LIST_HEAD(object_queue_head);
+static struct hashmap *object_requests;
 
 static void fetch_alternates(struct walker *walker, const char *base);
 
@@ -114,7 +117,11 @@ static void release_object_request(struct object_request *obj_req)
 	if (obj_req->req !=NULL && obj_req->req->localfile != -1)
 		error("fd leakage in release: %d", obj_req->req->localfile);
 
-	list_del(&obj_req->node);
+	/* XXX seems unnecessary with list_del in fill_active_slot */
+	if (!list_empty(&obj_req->node))
+		list_del(&obj_req->node);
+
+	hashmap_remove(object_requests, obj_req, obj_req->sha1);
 	free(obj_req);
 }
 
@@ -127,6 +134,8 @@ static int fill_active_slot(struct walker *walker)
 	list_for_each_safe(pos, tmp, head) {
 		obj_req = list_entry(pos, struct object_request, node);
 		if (obj_req->state == WAITING) {
+			/* _init so future list_del is idempotent */
+			list_del_init(pos);
 			if (has_sha1_file(obj_req->sha1))
 				obj_req->state = COMPLETE;
 			else {
@@ -145,6 +154,8 @@ static void prefetch(struct walker *walker, unsigned char *sha1)
 	struct walker_data *data = walker->data;
 
 	newreq = xmalloc(sizeof(*newreq));
+	hashmap_entry_init(&newreq->ent, sha1hash(sha1));
+	hashmap_add(object_requests, &newreq->ent);
 	newreq->walker = walker;
 	hashcpy(newreq->sha1, sha1);
 	newreq->repo = data->alt;
@@ -435,15 +446,12 @@ static int fetch_object(struct walker *walker, unsigned char *sha1)
 {
 	char *hex = sha1_to_hex(sha1);
 	int ret = 0;
-	struct object_request *obj_req = NULL;
+	struct object_request *obj_req;
+	struct hashmap_entry key;
 	struct http_object_request *req;
-	struct list_head *pos, *head = &object_queue_head;
 
-	list_for_each(pos, head) {
-		obj_req = list_entry(pos, struct object_request, node);
-		if (!hashcmp(obj_req->sha1, sha1))
-			break;
-	}
+	hashmap_entry_init(&key, sha1hash(sha1));
+	obj_req = hashmap_get(object_requests, &key, sha1);
 	if (obj_req == NULL)
 		return error("Couldn't find request for %s in the queue", hex);
 
@@ -553,6 +561,12 @@ static void cleanup(struct walker *walker)
 	}
 }
 
+static int obj_req_cmp(const struct object_request *e1,
+		const struct object_request *e2, const unsigned char *sha1)
+{
+	return hashcmp(e1->sha1, sha1 ? sha1 : e2->sha1);
+}
+
 struct walker *get_http_walker(const char *url)
 {
 	char *s;
@@ -580,5 +594,10 @@ struct walker *get_http_walker(const char *url)
 	add_fill_function(walker, (int (*)(void *)) fill_active_slot);
 #endif
 
+	if (!object_requests) {
+		object_requests = xmalloc(sizeof(*object_requests));
+		hashmap_init(object_requests, (hashmap_cmp_fn)obj_req_cmp, 0);
+	}
+
 	return walker;
 }
-- 
EW
