From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/4] sort-in-topological-order: use commit-queue
Date: Sun,  9 Jun 2013 16:24:36 -0700
Message-ID: <1370820277-30158-4-git-send-email-gitster@pobox.com>
References: <1370581872-31580-1-git-send-email-gitster@pobox.com>
 <1370820277-30158-1-git-send-email-gitster@pobox.com>
Cc: Elliott Cable <me@ell.io>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 10 01:24:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uloyn-0004dh-Ou
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 01:24:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752585Ab3FIXYs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 19:24:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53050 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752095Ab3FIXYq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 19:24:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8ACDD26E62;
	Sun,  9 Jun 2013 23:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=0z6n
	ltRH6XGqwxh06Ex3bg+twRI=; b=afE3tXDqEW+lTC339tG37UENIcZusRWjxWjz
	it4SVSLuuSq3wA0j63iyKFaFWUsvuvItnhSAoYffWtuUeE+mgss/gYDwlFE0TY5u
	poZ0r1qb66Mb8aDU7jlfKWGAuCaGR0LKWWbdC2pvVPM4qrbEZrlSl3cfoKPdy9vU
	XuCbpS0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	Q88yq7Y09QD3P1h3OMHJO3Z/CYsTN7uolo5c0Mp2OJh5WLhYiUAit5S4skPCI3Ca
	sYCQAYkgLsW+8dy6Qquok/JMTijdeCFZ+LEOJzlZ7IjSMEJiAUpO/ufk2vN25PlM
	GRIMYp11uyt4mPg144VwSspfnnLiniHXo03+rTD1wkw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 81C7E26E61;
	Sun,  9 Jun 2013 23:24:45 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A1D2F26E5D;
	Sun,  9 Jun 2013 23:24:44 +0000 (UTC)
X-Mailer: git-send-email 1.8.3-477-gc2fede3
In-Reply-To: <1370820277-30158-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: C4B12562-D15B-11E2-8554-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227211>

Use the commit-queue data structure to implement a priority queue
of commits sorted by committer date, when handling --date-order.
The commit-queue structure can also be used as a simple LIFO stack,
which is a good match for --topo-order processing.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 commit-queue.c | 13 +++++++++++
 commit-queue.h |  3 +++
 commit.c       | 74 ++++++++++++++++++++++++++++++++++------------------------
 3 files changed, 59 insertions(+), 31 deletions(-)

diff --git a/commit-queue.c b/commit-queue.c
index 77d4b02..ffffc4e 100644
--- a/commit-queue.c
+++ b/commit-queue.c
@@ -2,6 +2,19 @@
 #include "commit.h"
 #include "commit-queue.h"
 
+void commit_queue_reverse(struct commit_queue *queue)
+{
+	int i, j;
+
+	if (queue->compare != NULL)
+		die("BUG: commit_queue_reverse() on non-LIFO queue");
+	for (i = 0; i <= (j = (queue->nr - 1) - i); i++) {
+		struct commit *swap = queue->array[i];
+		queue->array[i] = queue->array[j];
+		queue->array[j] = swap;
+	}
+}
+
 void clear_commit_queue(struct commit_queue *queue)
 {
 	free(queue->array);
diff --git a/commit-queue.h b/commit-queue.h
index 7c5dc4c..d3c92e5 100644
--- a/commit-queue.h
+++ b/commit-queue.h
@@ -28,4 +28,7 @@ extern struct commit *commit_queue_get(struct commit_queue *);
 
 extern void clear_commit_queue(struct commit_queue *);
 
+/* Reverse the LIFO elements */
+extern void commit_queue_reverse(struct commit_queue *);
+
 #endif /* COMMIT_QUEUE_H */
diff --git a/commit.c b/commit.c
index 11b9635..cc6d385 100644
--- a/commit.c
+++ b/commit.c
@@ -9,6 +9,7 @@
 #include "gpg-interface.h"
 #include "mergesort.h"
 #include "commit-slab.h"
+#include "commit-queue.h"
 
 static struct commit_extra_header *read_commit_extra_header_lines(const char *buf, size_t len, const char **);
 
@@ -509,21 +510,41 @@ struct commit *pop_commit(struct commit_list **stack)
 /* count number of children that have not been emitted */
 define_commit_slab(indegree_slab, int);
 
+static int compare_commits_by_commit_date(struct commit *a, struct commit *b, void *unused)
+{
+	/* newer commits with larger date first */
+	if (a->date < b->date)
+		return 1;
+	else if (a->date > b->date)
+		return -1;
+	return 0;
+}
+
 /*
  * Performs an in-place topological sort on the list supplied.
  */
-void sort_in_topological_order(struct commit_list ** list, enum rev_sort_order sort_order)
+void sort_in_topological_order(struct commit_list **list, enum rev_sort_order sort_order)
 {
 	struct commit_list *next, *orig = *list;
-	struct commit_list *work, **insert;
 	struct commit_list **pptr;
 	struct indegree_slab indegree;
+	struct commit_queue queue;
+	struct commit *commit;
 
 	if (!orig)
 		return;
 	*list = NULL;
 
 	init_indegree_slab(&indegree);
+	memset(&queue, '\0', sizeof(queue));
+	switch (sort_order) {
+	default: /* REV_SORT_IN_GRAPH_ORDER */
+		queue.compare = NULL;
+		break;
+	case REV_SORT_BY_COMMIT_DATE:
+		queue.compare = compare_commits_by_commit_date;
+		break;
+	}
 
 	/* Mark them and clear the indegree */
 	for (next = orig; next; next = next->next) {
@@ -533,7 +554,7 @@ void sort_in_topological_order(struct commit_list ** list, enum rev_sort_order s
 
 	/* update the indegree */
 	for (next = orig; next; next = next->next) {
-		struct commit_list * parents = next->item->parents;
+		struct commit_list *parents = next->item->parents;
 		while (parents) {
 			struct commit *parent = parents->item;
 			int *pi = indegree_slab_at(&indegree, parent);
@@ -551,30 +572,28 @@ void sort_in_topological_order(struct commit_list ** list, enum rev_sort_order s
 	 *
 	 * the tips serve as a starting set for the work queue.
 	 */
-	work = NULL;
-	insert = &work;
 	for (next = orig; next; next = next->next) {
 		struct commit *commit = next->item;
 
 		if (*(indegree_slab_at(&indegree, commit)) == 1)
-			insert = &commit_list_insert(commit, insert)->next;
+			commit_queue_put(&queue, commit);
 	}
 
-	/* process the list in topological order */
-	if (sort_order != REV_SORT_IN_GRAPH_ORDER)
-		commit_list_sort_by_date(&work);
+	/*
+	 * This is unfortunate; the initial tips need to be shown
+	 * in the order given from the revision traversal machinery.
+	 */
+	if (sort_order == REV_SORT_IN_GRAPH_ORDER)
+		commit_queue_reverse(&queue);
+
+	/* We no longer need the commit list */
+	free_commit_list(orig);
 
 	pptr = list;
 	*list = NULL;
-	while (work) {
-		struct commit *commit;
-		struct commit_list *parents, *work_item;
-
-		work_item = work;
-		work = work_item->next;
-		work_item->next = NULL;
+	while ((commit = commit_queue_get(&queue)) != NULL) {
+		struct commit_list *parents;
 
-		commit = work_item->item;
 		for (parents = commit->parents; parents ; parents = parents->next) {
 			struct commit *parent = parents->item;
 			int *pi = indegree_slab_at(&indegree, parent);
@@ -587,27 +606,20 @@ void sort_in_topological_order(struct commit_list ** list, enum rev_sort_order s
 			 * when all their children have been emitted thereby
 			 * guaranteeing topological order.
 			 */
-			if (--(*pi) == 1) {
-				switch (sort_order) {
-				case REV_SORT_BY_COMMIT_DATE:
-					commit_list_insert_by_date(parent, &work);
-					break;
-				default: /* REV_SORT_IN_GRAPH_ORDER */
-					commit_list_insert(parent, &work);
-					break;
-				}
-			}
+			if (--(*pi) == 1)
+				commit_queue_put(&queue, parent);
 		}
 		/*
-		 * work_item is a commit all of whose children
-		 * have already been emitted. we can emit it now.
+		 * all children of commit have already been
+		 * emitted. we can emit it now.
 		 */
 		*(indegree_slab_at(&indegree, commit)) = 0;
-		*pptr = work_item;
-		pptr = &work_item->next;
+
+		pptr = &commit_list_insert(commit, pptr)->next;
 	}
 
 	clear_indegree_slab(&indegree);
+	clear_commit_queue(&queue);
 }
 
 /* merge-base stuff */
-- 
1.8.3-451-gb703ddf
