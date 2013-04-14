From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/3] commit: allow associating auxiliary info on-demand
Date: Sat, 13 Apr 2013 23:04:47 -0700
Message-ID: <1365919489-17553-2-git-send-email-gitster@pobox.com>
References: <1365919489-17553-1-git-send-email-gitster@pobox.com>
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 14 08:05:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URG3m-00016K-Pq
	for gcvg-git-2@plane.gmane.org; Sun, 14 Apr 2013 08:05:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804Ab3DNGE4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 02:04:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51483 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750766Ab3DNGEy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Apr 2013 02:04:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1B265E3CD;
	Sun, 14 Apr 2013 06:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=d21B
	l+ZIGWUKoZ5hZQ/pvrBnrmg=; b=Il37iigX/xFixdUSiK+q/4FcPrreW8WThkY2
	OKxdd0EaLuLNWZk8aopBvrDO9Z08TTkPGMJyMDLwqajFvMMWEkfGFH9sHN1Ov8yn
	5AaoVkkZdRzRziBlan6FJw323kl/+UXGhiYHqz/l5rfmtyP3YegAJ8wGGv6J0r9+
	R10DMvs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	duPSL1/wgq5l1D1COzxE25qvrak1qL3EMVBCKOLSiS1pUJb+kz4bYCecFKK8m/YD
	AGVg4nEBDuhOTpcypIdHTV6x5LogCPU4xaCNGduiLNfkWvvKfbipa9p+BvqyjV41
	DjKONJFH4CGGJEmaEUQ98ZCHPX1UHnXkQghfHlIsWMg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 11E36E3CC;
	Sun, 14 Apr 2013 06:04:54 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2819BE3CB; Sun, 14 Apr 2013
 06:04:53 +0000 (UTC)
X-Mailer: git-send-email 1.8.2.1-514-gf369d36
In-Reply-To: <1365919489-17553-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 3953E7E8-A4C9-11E2-97FC-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221079>

From: Jeff King <peff@peff.net>

The "indegree" field in the commit object is only used while sorting
a list of commits in topological order, and wasting memory otherwise.

We would prefer to shrink the size of individual commit objects,
which we may have to hold thousands of in-core. We could eject
"indegree" field out from the commit object and represent it as a
dynamic table based on the decoration infrastructure, but the
decoration is meant for sparse annotation and is not a good match.

Instead, let's try a different approach.

 - Assign an integer (commit->index) to each commit we keep in-core
   (reuse the space of "indegree" field for it);

 - When running the topological sort, allocate an array of integers
   in bulk (called "slab"), use the commit->index as an index into
   this array, and store the "indegree" information there.

This does _not_ reduce the memory footprint of a commit object, but
the commit->index can be used as the index to dynamically associate
commits with other kinds of information as needed.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 commit.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++++++---------
 commit.h |  2 +-
 2 files changed, 51 insertions(+), 10 deletions(-)

diff --git a/commit.c b/commit.c
index 1a41757..9365e3b 100644
--- a/commit.c
+++ b/commit.c
@@ -14,6 +14,7 @@ static struct commit_extra_header *read_commit_extra_header_lines(const char *bu
 int save_commit_buffer = 1;
 
 const char *commit_type = "commit";
+static int commit_count;
 
 static struct commit *check_commit(struct object *obj,
 				   const unsigned char *sha1,
@@ -58,8 +59,11 @@ struct commit *lookup_commit_or_die(const unsigned char *sha1, const char *ref_n
 struct commit *lookup_commit(const unsigned char *sha1)
 {
 	struct object *obj = lookup_object(sha1);
-	if (!obj)
-		return create_object(sha1, OBJ_COMMIT, alloc_commit_node());
+	if (!obj) {
+		struct commit *c = alloc_commit_node();
+		c->index = commit_count++;
+		return create_object(sha1, OBJ_COMMIT, c);
+	}
 	if (!obj->type)
 		obj->type = OBJ_COMMIT;
 	return check_commit(obj, sha1, 0);
@@ -497,6 +501,36 @@ struct commit *pop_commit(struct commit_list **stack)
 	return item;
 }
 
+struct commit_slab {
+	int *buf;
+	int alloc;
+};
+
+static void slab_init(struct commit_slab *s)
+{
+	memset(s, 0, sizeof(*s));
+}
+
+static void slab_clear(struct commit_slab *s)
+{
+	free(s->buf);
+	slab_init(s);
+}
+
+static inline int *slab_at(struct commit_slab *s, const struct commit *c)
+{
+	if (s->alloc <= c->index) {
+		int new_alloc = alloc_nr(s->alloc);
+		if (new_alloc <= c->index)
+			new_alloc = c->index + 1;
+
+		s->buf = xrealloc(s->buf, new_alloc * sizeof(*s->buf));
+		memset(s->buf + s->alloc, 0, new_alloc - s->alloc);
+		s->alloc = new_alloc;
+	}
+	return s->buf + c->index;
+}
+
 /*
  * Performs an in-place topological sort on the list supplied.
  */
@@ -505,15 +539,18 @@ void sort_in_topological_order(struct commit_list ** list, int lifo)
 	struct commit_list *next, *orig = *list;
 	struct commit_list *work, **insert;
 	struct commit_list **pptr;
+	struct commit_slab indegree;
 
 	if (!orig)
 		return;
 	*list = NULL;
 
+	slab_init(&indegree);
+
 	/* Mark them and clear the indegree */
 	for (next = orig; next; next = next->next) {
 		struct commit *commit = next->item;
-		commit->indegree = 1;
+		*slab_at(&indegree, commit) = 1;
 	}
 
 	/* update the indegree */
@@ -521,9 +558,10 @@ void sort_in_topological_order(struct commit_list ** list, int lifo)
 		struct commit_list * parents = next->item->parents;
 		while (parents) {
 			struct commit *parent = parents->item;
+			int *pi = slab_at(&indegree, parent);
 
-			if (parent->indegree)
-				parent->indegree++;
+			if (*pi)
+				(*pi)++;
 			parents = parents->next;
 		}
 	}
@@ -540,7 +578,7 @@ void sort_in_topological_order(struct commit_list ** list, int lifo)
 	for (next = orig; next; next = next->next) {
 		struct commit *commit = next->item;
 
-		if (commit->indegree == 1)
+		if (*slab_at(&indegree, commit) == 1)
 			insert = &commit_list_insert(commit, insert)->next;
 	}
 
@@ -561,8 +599,9 @@ void sort_in_topological_order(struct commit_list ** list, int lifo)
 		commit = work_item->item;
 		for (parents = commit->parents; parents ; parents = parents->next) {
 			struct commit *parent = parents->item;
+			int *pi = slab_at(&indegree, parent);
 
-			if (!parent->indegree)
+			if (!*pi)
 				continue;
 
 			/*
@@ -570,7 +609,7 @@ void sort_in_topological_order(struct commit_list ** list, int lifo)
 			 * when all their children have been emitted thereby
 			 * guaranteeing topological order.
 			 */
-			if (--parent->indegree == 1) {
+			if (--(*pi) == 1) {
 				if (!lifo)
 					commit_list_insert_by_date(parent, &work);
 				else
@@ -581,10 +620,12 @@ void sort_in_topological_order(struct commit_list ** list, int lifo)
 		 * work_item is a commit all of whose children
 		 * have already been emitted. we can emit it now.
 		 */
-		commit->indegree = 0;
+		*slab_at(&indegree, commit) = 0;
 		*pptr = work_item;
 		pptr = &work_item->next;
 	}
+
+	slab_clear(&indegree);
 }
 
 /* merge-base stuff */
diff --git a/commit.h b/commit.h
index 252c7f8..70e749d 100644
--- a/commit.h
+++ b/commit.h
@@ -14,7 +14,7 @@ struct commit_list {
 struct commit {
 	struct object object;
 	void *util;
-	unsigned int indegree;
+	unsigned int index;
 	unsigned long date;
 	struct commit_list *parents;
 	struct tree *tree;
-- 
1.8.2.1-514-gf369d36
