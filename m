From: Jeff King <peff@peff.net>
Subject: [PATCH 1/3] prio-queue: factor out compare and swap operations
Date: Mon, 14 Jul 2014 01:42:50 -0400
Message-ID: <20140714054250.GA4838@sigill.intra.peff.net>
References: <20140714054021.GA4422@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 14 07:42:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6Z2O-000721-WF
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jul 2014 07:42:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752877AbaGNFmy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2014 01:42:54 -0400
Received: from cloud.peff.net ([50.56.180.127]:33414 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752616AbaGNFmw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2014 01:42:52 -0400
Received: (qmail 31821 invoked by uid 102); 14 Jul 2014 05:42:52 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 14 Jul 2014 00:42:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Jul 2014 01:42:50 -0400
Content-Disposition: inline
In-Reply-To: <20140714054021.GA4422@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253471>

When manipulating the priority queue's heap, we frequently
have to compare and swap heap entries. As we are storing
only void pointers right now, this is quite easy to do
inline in a few lines. However, when we start using a more
complicated heap entry in a future patch, that will get
longer. Factoring out these operations lets us make future
changes in one place. It also makes the code a little
shorter and more readable.

Note that we actually accept indices into the queue array
instead of pointers. This is slightly less flexible than
passing pointers-to-pointers (we could not swap items from
unrelated arrays, but we would not want to), but will make
further refactoring simpler (and lets us avoid repeating
"queue->array" at each callsite, which led to some long
lines).

And finally, note that we are cleaning up an accidental use
of a "struct commit" pointer to hold a temporary entry
during swap. Even though we currently only use this code for
commits, it is supposed to be type-agnostic. In practice
this didn't matter anyway because we never dereferenced the
commit pointer (and on most systems, the pointer values
themselves are interchangeable between types).

Signed-off-by: Jeff King <peff@peff.net>
---
 prio-queue.c | 49 +++++++++++++++++++++++++------------------------
 1 file changed, 25 insertions(+), 24 deletions(-)

diff --git a/prio-queue.c b/prio-queue.c
index c9f8c6d..0f4fcf2 100644
--- a/prio-queue.c
+++ b/prio-queue.c
@@ -1,18 +1,28 @@
 #include "cache.h"
-#include "commit.h"
 #include "prio-queue.h"
 
+static inline int compare(struct prio_queue *queue, int i, int j)
+{
+	int cmp = queue->compare(queue->array[i], queue->array[j],
+				 queue->cb_data);
+	return cmp;
+}
+
+static inline void swap(struct prio_queue *queue, int i, int j)
+{
+	void *tmp = queue->array[i];
+	queue->array[i] = queue->array[j];
+	queue->array[j] = tmp;
+}
+
 void prio_queue_reverse(struct prio_queue *queue)
 {
 	int i, j;
 
 	if (queue->compare != NULL)
 		die("BUG: prio_queue_reverse() on non-LIFO queue");
-	for (i = 0; i <= (j = (queue->nr - 1) - i); i++) {
-		struct commit *swap = queue->array[i];
-		queue->array[i] = queue->array[j];
-		queue->array[j] = swap;
-	}
+	for (i = 0; i <= (j = (queue->nr - 1) - i); i++)
+		swap(queue, i, j);
 }
 
 void clear_prio_queue(struct prio_queue *queue)
@@ -25,37 +35,32 @@ void clear_prio_queue(struct prio_queue *queue)
 
 void prio_queue_put(struct prio_queue *queue, void *thing)
 {
-	prio_queue_compare_fn compare = queue->compare;
 	int ix, parent;
 
 	/* Append at the end */
 	ALLOC_GROW(queue->array, queue->nr + 1, queue->alloc);
 	queue->array[queue->nr++] = thing;
-	if (!compare)
+	if (!queue->compare)
 		return; /* LIFO */
 
 	/* Bubble up the new one */
 	for (ix = queue->nr - 1; ix; ix = parent) {
 		parent = (ix - 1) / 2;
-		if (compare(queue->array[parent], queue->array[ix],
-			    queue->cb_data) <= 0)
+		if (compare(queue, parent, ix) <= 0)
 			break;
 
-		thing = queue->array[parent];
-		queue->array[parent] = queue->array[ix];
-		queue->array[ix] = thing;
+		swap(queue, parent, ix);
 	}
 }
 
 void *prio_queue_get(struct prio_queue *queue)
 {
-	void *result, *swap;
+	void *result;
 	int ix, child;
-	prio_queue_compare_fn compare = queue->compare;
 
 	if (!queue->nr)
 		return NULL;
-	if (!compare)
+	if (!queue->compare)
 		return queue->array[--queue->nr]; /* LIFO */
 
 	result = queue->array[0];
@@ -67,18 +72,14 @@ void *prio_queue_get(struct prio_queue *queue)
 	/* Push down the one at the root */
 	for (ix = 0; ix * 2 + 1 < queue->nr; ix = child) {
 		child = ix * 2 + 1; /* left */
-		if ((child + 1 < queue->nr) &&
-		    (compare(queue->array[child], queue->array[child + 1],
-			     queue->cb_data) >= 0))
+		if (child + 1 < queue->nr &&
+		    compare(queue, child, child + 1) >= 0)
 			child++; /* use right child */
 
-		if (compare(queue->array[ix], queue->array[child],
-			    queue->cb_data) <= 0)
+		if (compare(queue, ix, child) <= 0)
 			break;
 
-		swap = queue->array[child];
-		queue->array[child] = queue->array[ix];
-		queue->array[ix] = swap;
+		swap(queue, child, ix);
 	}
 	return result;
 }
-- 
2.0.0.566.gfe3e6b2
