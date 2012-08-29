From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] commit: use a priority queue in merge base functions
Date: Wed, 29 Aug 2012 07:11:47 -0400
Message-ID: <20120829111147.GB14734@sigill.intra.peff.net>
References: <20120829110812.GA14069@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 29 13:12:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6gBi-0002Md-I3
	for gcvg-git-2@plane.gmane.org; Wed, 29 Aug 2012 13:11:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752923Ab2H2LLx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Aug 2012 07:11:53 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:46976 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752541Ab2H2LLw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2012 07:11:52 -0400
Received: (qmail 31728 invoked by uid 107); 29 Aug 2012 11:12:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 29 Aug 2012 07:12:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 29 Aug 2012 07:11:47 -0400
Content-Disposition: inline
In-Reply-To: <20120829110812.GA14069@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204476>

The merge-base functions internally keep a commit lists and
insert by date, which causes a linear search of the commit
list for each insertion. Let's use a priority queue instead.

Unfortunately, from my experiments, this didn't actually
cause any speedup.

Signed-off-by: Jeff King <peff@peff.net>
---
I'd probably split this into a few commits if we were really going to
apply it, but since it doesn't actually make anything faster, I doubt
the code churn is worth it.

 commit.c | 78 ++++++++++++++++++++++++++++++++++++++--------------------------
 1 file changed, 47 insertions(+), 31 deletions(-)

diff --git a/commit.c b/commit.c
index 380f4ec..c64ef94 100644
--- a/commit.c
+++ b/commit.c
@@ -7,6 +7,7 @@
 #include "revision.h"
 #include "notes.h"
 #include "gpg-interface.h"
+#include "queue.h"
 
 int save_commit_buffer = 1;
 
@@ -360,6 +361,15 @@ struct commit_list *commit_list_insert(struct commit *item, struct commit_list *
 	return new_list;
 }
 
+static void commit_list_append(struct commit *item, struct commit_list ***tail)
+{
+	struct commit_list *new_list = xmalloc(sizeof(*new_list));
+	new_list->item = item;
+	new_list->next = NULL;
+	**tail = new_list;
+	*tail = &new_list->next;
+}
+
 unsigned commit_list_count(const struct commit_list *l)
 {
 	unsigned c = 0;
@@ -422,6 +432,16 @@ struct commit *pop_most_recent_commit(struct commit_list **list,
 	return ret;
 }
 
+static int commit_datecmp(const void *va, const void *vb)
+{
+	const struct commit *a = va, *b = vb;
+	if (a->date < b->date)
+		return -1;
+	else if (a->date > b->date)
+		return 1;
+	return 0;
+}
+
 void clear_commit_marks(struct commit *commit, unsigned int mark)
 {
 	while (commit) {
@@ -569,22 +589,23 @@ static struct commit_list *merge_bases_many(struct commit *one, int n, struct co
 
 static const unsigned all_flags = (PARENT1 | PARENT2 | STALE | RESULT);
 
-static struct commit *interesting(struct commit_list *list)
+static int interesting(struct queue *q)
 {
-	while (list) {
-		struct commit *commit = list->item;
-		list = list->next;
+	int i;
+	for (i = 0; i < q->nr; i++) {
+		struct commit *commit = q->items[i];
 		if (commit->object.flags & STALE)
 			continue;
-		return commit;
+		return 1;
 	}
-	return NULL;
+	return 0;
 }
 
 static struct commit_list *merge_bases_many(struct commit *one, int n, struct commit **twos)
 {
-	struct commit_list *list = NULL;
-	struct commit_list *result = NULL;
+	struct queue result = { commit_datecmp };
+	struct queue list = { commit_datecmp };
+	struct commit_list *ret = NULL, **tail = &ret;
 	int i;
 
 	for (i = 0; i < n; i++) {
@@ -593,7 +614,7 @@ static struct commit_list *merge_bases_many(struct commit *one, int n, struct co
 			 * We do not mark this even with RESULT so we do not
 			 * have to clean it up.
 			 */
-			return commit_list_insert(one, &result);
+			return commit_list_insert(one, &ret);
 	}
 
 	if (parse_commit(one))
@@ -604,28 +625,24 @@ static struct commit_list *merge_bases_many(struct commit *one, int n, struct co
 	}
 
 	one->object.flags |= PARENT1;
-	commit_list_insert_by_date(one, &list);
+	queue_insert(&list, one);
 	for (i = 0; i < n; i++) {
 		twos[i]->object.flags |= PARENT2;
-		commit_list_insert_by_date(twos[i], &list);
+		queue_insert(&list, twos[i]);
 	}
 
-	while (interesting(list)) {
+	while (interesting(&list)) {
 		struct commit *commit;
 		struct commit_list *parents;
-		struct commit_list *next;
 		int flags;
 
-		commit = list->item;
-		next = list->next;
-		free(list);
-		list = next;
+		commit = queue_pop(&list);
 
 		flags = commit->object.flags & (PARENT1 | PARENT2 | STALE);
 		if (flags == (PARENT1 | PARENT2)) {
 			if (!(commit->object.flags & RESULT)) {
 				commit->object.flags |= RESULT;
-				commit_list_insert_by_date(commit, &result);
+				queue_insert(&result, commit);
 			}
 			/* Mark parents of a found merge stale */
 			flags |= STALE;
@@ -639,21 +656,16 @@ static struct commit_list *merge_bases_many(struct commit *one, int n, struct co
 			if (parse_commit(p))
 				return NULL;
 			p->object.flags |= flags;
-			commit_list_insert_by_date(p, &list);
+			queue_insert(&list, p);
 		}
 	}
 
 	/* Clean up the result to remove stale ones */
-	free_commit_list(list);
-	list = result; result = NULL;
-	while (list) {
-		struct commit_list *next = list->next;
-		if (!(list->item->object.flags & STALE))
-			commit_list_insert_by_date(list->item, &result);
-		free(list);
-		list = next;
-	}
-	return result;
+	while (result.nr)
+		commit_list_append(queue_pop(&result), &tail);
+	queue_clear(&result);
+	queue_clear(&list);
+	return ret;
 }
 
 struct commit_list *get_octopus_merge_bases(struct commit_list *in)
@@ -690,7 +702,8 @@ struct commit_list *get_merge_bases_many(struct commit *one,
 {
 	struct commit_list *list;
 	struct commit **rslt, **others;
-	struct commit_list *result;
+	struct commit_list *result, **tail = &result;
+	struct queue commit_queue = { commit_datecmp };
 	int cnt, i, j;
 
 	result = merge_bases_many(one, n, twos);
@@ -744,11 +757,14 @@ struct commit_list *get_merge_bases_many(struct commit *one,
 			list = list->next;
 		}
 		if (!list)
-			commit_list_insert_by_date(rslt[i], &result);
+			queue_insert(&commit_queue, rslt[i]);
 		free_commit_list(list);
 	}
 	free(rslt);
 	free(others);
+	while (commit_queue.nr)
+		commit_list_append(queue_pop(&commit_queue), &tail);
+	queue_clear(&commit_queue);
 	return result;
 }
 
-- 
1.7.12.35.g38689e3
