From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 3/4] sort-in-topological-order: use prio-queue
Date: Tue, 11 Jun 2013 15:19:08 -0700
Message-ID: <1370989149-28538-4-git-send-email-gitster@pobox.com>
References: <20130611063648.GB23650@sigill.intra.peff.net>
 <1370989149-28538-1-git-send-email-gitster@pobox.com>
Cc: Elliott Cable <me@ell.io>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 12 00:19:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmWuf-0007YZ-OA
	for gcvg-git-2@plane.gmane.org; Wed, 12 Jun 2013 00:19:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757262Ab3FKWTc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 18:19:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49054 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757002Ab3FKWTS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 18:19:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C27892794F;
	Tue, 11 Jun 2013 22:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=F6ys
	2s5b6vAaX3j3uMphOyXg6GI=; b=FNDOk/EsaEo+dK5za4pnwJP5hb4EscgTBboS
	bmNaB0LnNndqBvmFXDAzfrpICGWesHCwdBphZrggsIHV7ltWv85f2E7VcaEuffmk
	uSNPfTbDfZNzOT7CKQ1mJ8pAZf+atpYm4AFTN86dK7oThfpkaz2v+Y0I1TtiBLn7
	EtiUgCs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	isgcIo94yiiIwaX9IjqatnQPWh/Ng8/zudpEAeRvPk/w0WXBTRfqpRk0dmdW1TB9
	PNX4JUeLyXcA2sIq+9gP5BoLKzq/rG12z4zkvIw3cXODmgs3lKFVTSeJhDH8yB7L
	9Ez8qYxZgiU7UNHzed3Q+LVQSi1aKusMSfPd5RYLaMQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B73DE2794E;
	Tue, 11 Jun 2013 22:19:17 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DE00B2794D;
	Tue, 11 Jun 2013 22:19:16 +0000 (UTC)
X-Mailer: git-send-email 1.8.3.1-494-g51b8af5
In-Reply-To: <1370989149-28538-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: F46517CA-D2E4-11E2-8626-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227548>

Use the prio-queue data structure to implement a priority queue of
commits sorted by committer date, when handling --date-order.  The
structure can also be used as a simple LIFO stack, which is a good
match for --topo-order processing.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 commit.c     | 75 +++++++++++++++++++++++++++++++++++-------------------------
 prio-queue.c | 13 +++++++++++
 prio-queue.h |  3 +++
 3 files changed, 60 insertions(+), 31 deletions(-)

diff --git a/commit.c b/commit.c
index 11b9635..8b84ebf 100644
--- a/commit.c
+++ b/commit.c
@@ -9,6 +9,7 @@
 #include "gpg-interface.h"
 #include "mergesort.h"
 #include "commit-slab.h"
+#include "prio-queue.h"
 
 static struct commit_extra_header *read_commit_extra_header_lines(const char *buf, size_t len, const char **);
 
@@ -509,21 +510,42 @@ struct commit *pop_commit(struct commit_list **stack)
 /* count number of children that have not been emitted */
 define_commit_slab(indegree_slab, int);
 
+static int compare_commits_by_commit_date(const void *a_, const void *b_, void *unused)
+{
+	const struct commit *a = a_, *b = b_;
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
+	struct prio_queue queue;
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
@@ -533,7 +555,7 @@ void sort_in_topological_order(struct commit_list ** list, enum rev_sort_order s
 
 	/* update the indegree */
 	for (next = orig; next; next = next->next) {
-		struct commit_list * parents = next->item->parents;
+		struct commit_list *parents = next->item->parents;
 		while (parents) {
 			struct commit *parent = parents->item;
 			int *pi = indegree_slab_at(&indegree, parent);
@@ -551,30 +573,28 @@ void sort_in_topological_order(struct commit_list ** list, enum rev_sort_order s
 	 *
 	 * the tips serve as a starting set for the work queue.
 	 */
-	work = NULL;
-	insert = &work;
 	for (next = orig; next; next = next->next) {
 		struct commit *commit = next->item;
 
 		if (*(indegree_slab_at(&indegree, commit)) == 1)
-			insert = &commit_list_insert(commit, insert)->next;
+			prio_queue_put(&queue, commit);
 	}
 
-	/* process the list in topological order */
-	if (sort_order != REV_SORT_IN_GRAPH_ORDER)
-		commit_list_sort_by_date(&work);
+	/*
+	 * This is unfortunate; the initial tips need to be shown
+	 * in the order given from the revision traversal machinery.
+	 */
+	if (sort_order == REV_SORT_IN_GRAPH_ORDER)
+		prio_queue_reverse(&queue);
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
+	while ((commit = prio_queue_get(&queue)) != NULL) {
+		struct commit_list *parents;
 
-		commit = work_item->item;
 		for (parents = commit->parents; parents ; parents = parents->next) {
 			struct commit *parent = parents->item;
 			int *pi = indegree_slab_at(&indegree, parent);
@@ -587,27 +607,20 @@ void sort_in_topological_order(struct commit_list ** list, enum rev_sort_order s
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
+				prio_queue_put(&queue, parent);
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
+	clear_prio_queue(&queue);
 }
 
 /* merge-base stuff */
diff --git a/prio-queue.c b/prio-queue.c
index f2a4973..c9f8c6d 100644
--- a/prio-queue.c
+++ b/prio-queue.c
@@ -2,6 +2,19 @@
 #include "commit.h"
 #include "prio-queue.h"
 
+void prio_queue_reverse(struct prio_queue *queue)
+{
+	int i, j;
+
+	if (queue->compare != NULL)
+		die("BUG: prio_queue_reverse() on non-LIFO queue");
+	for (i = 0; i <= (j = (queue->nr - 1) - i); i++) {
+		struct commit *swap = queue->array[i];
+		queue->array[i] = queue->array[j];
+		queue->array[j] = swap;
+	}
+}
+
 void clear_prio_queue(struct prio_queue *queue)
 {
 	free(queue->array);
diff --git a/prio-queue.h b/prio-queue.h
index ed354a5..e8b81e2 100644
--- a/prio-queue.h
+++ b/prio-queue.h
@@ -42,4 +42,7 @@ extern void *prio_queue_get(struct prio_queue *);
 
 extern void clear_prio_queue(struct prio_queue *);
 
+/* Reverse the LIFO elements */
+extern void prio_queue_reverse(struct prio_queue *);
+
 #endif /* PRIO_QUEUE_H */
-- 
1.8.3.1-494-g51b8af5
