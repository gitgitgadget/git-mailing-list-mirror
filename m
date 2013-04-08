From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/3] commit: shrink "indegree" field
Date: Mon,  8 Apr 2013 16:01:52 -0700
Message-ID: <1365462114-8630-2-git-send-email-gitster@pobox.com>
References: <20130408210903.GC9649@sigill.intra.peff.net>
 <1365462114-8630-1-git-send-email-gitster@pobox.com>
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 09 01:02:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPL4k-0001C6-Ve
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 01:02:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936219Ab3DHXCA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 19:02:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58503 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935717Ab3DHXB7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 19:01:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F168014910;
	Mon,  8 Apr 2013 23:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=m5tO
	YB1zsYNCqVeTYyNLuJrSgDk=; b=LQxT+b16vcDVE6rEHcyjoyZfz0LOcny1WYWM
	dPVwlfn53tTlW0rrWpDj6LCGskBC4RgUIW+CwKjOvVPxhBYZNwF5X8TUrao9yD4p
	N1PGZCDxReLra/KZra2mQHykt7tClRcnAtkANA0SrD1g6yKzUZpuXQa0f5jlqx2P
	IMKWqI0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	pegqiqx2Drb5Qq56RGhy4hUspjm12+gNsPyTDpY1tP6pbPPdHxgZ6SdMDMFc9IDP
	vRBlFEXbVdNWR8S2/xjk/QLAm2XgtXHxxg2lU7Vxb7e4TV+Zq/My2pPe9au1i5R5
	EnCpDS6WShTJ0pq+OJvGS73xDLGcvPmcKlzCnWh00Yg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E5F731490F;
	Mon,  8 Apr 2013 23:01:58 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2C68A1490B; Mon,  8 Apr
 2013 23:01:58 +0000 (UTC)
X-Mailer: git-send-email 1.8.2.1-450-gd047976
In-Reply-To: <1365462114-8630-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 50985E70-A0A0-11E2-8C44-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220538>

The "indegree" field in the commit object is used only while a
commit list is sorted using the topo_order sorting.  The idea is to
initially store the number of direct parents and the commit itself
there, and start emitting the commits with indegree 1 (i.e. leaves
that do not have any commit as the parent), and every time a commit
is emitted, decrement its own count (to drop it to 0 to clear the
field) and the count in its parents (so eventually a commit whose
children are all emitted will see its count dropped to 1, becoming
eligible to be emitted) by one.

We used to allocate a full integer for this, but in real life, a
commit with thousands of direct children are rare. Shrink it to an
unsigned char to represent a commit with 254 children or less
without any extra overhead, and spilling the overflow to a separate
decoration hash.

This does not save any bytes from the commit object structure due to
alignment, but would give us 3 or 7 bytes to store other information.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 commit.c | 46 +++++++++++++++++++++++++++++++++++++++-------
 commit.h |  2 +-
 2 files changed, 40 insertions(+), 8 deletions(-)

diff --git a/commit.c b/commit.c
index 516a4ff..9d7e81b 100644
--- a/commit.c
+++ b/commit.c
@@ -506,6 +506,30 @@ struct commit *pop_commit(struct commit_list **stack)
 	return item;
 }
 
+#define QUICK_INDEGREE_LIMIT 255
+
+static inline void set_indegree(struct decoration *indegree,
+				struct commit *commit, intptr_t value)
+{
+	if (QUICK_INDEGREE_LIMIT <= value) {
+		commit->indegree = QUICK_INDEGREE_LIMIT;
+		add_decoration(indegree, &commit->object, (void *)value);
+	} else {
+		commit->indegree = value;
+	}
+}
+
+static inline intptr_t get_indegree(struct decoration *indegree,
+				    struct commit *commit)
+{
+	if (commit->indegree < QUICK_INDEGREE_LIMIT)
+		return commit->indegree;
+	else {
+		void *count = lookup_decoration(indegree, &commit->object);
+		return (int) count;
+	}
+}
+
 /*
  * Performs an in-place topological sort on the list supplied.
  */
@@ -514,15 +538,18 @@ void sort_in_topological_order(struct commit_list ** list, int lifo)
 	struct commit_list *next, *orig = *list;
 	struct commit_list *work, **insert;
 	struct commit_list **pptr;
+	struct decoration id_overflow;
+	intptr_t count;
 
 	if (!orig)
 		return;
 	*list = NULL;
 
 	/* Mark them and clear the indegree */
+	memset(&id_overflow, 0, sizeof(id_overflow));
 	for (next = orig; next; next = next->next) {
 		struct commit *commit = next->item;
-		commit->indegree = 1;
+		set_indegree(&id_overflow, commit, 1);
 	}
 
 	/* update the indegree */
@@ -531,8 +558,9 @@ void sort_in_topological_order(struct commit_list ** list, int lifo)
 		while (parents) {
 			struct commit *parent = parents->item;
 
-			if (parent->indegree)
-				parent->indegree++;
+			count = get_indegree(&id_overflow, parent);
+			if (count)
+				set_indegree(&id_overflow, parent, count + 1);
 			parents = parents->next;
 		}
 	}
@@ -549,7 +577,7 @@ void sort_in_topological_order(struct commit_list ** list, int lifo)
 	for (next = orig; next; next = next->next) {
 		struct commit *commit = next->item;
 
-		if (commit->indegree == 1)
+		if (get_indegree(&id_overflow, commit) == 1)
 			insert = &commit_list_insert(commit, insert)->next;
 	}
 
@@ -571,7 +599,8 @@ void sort_in_topological_order(struct commit_list ** list, int lifo)
 		for (parents = commit->parents; parents ; parents = parents->next) {
 			struct commit *parent = parents->item;
 
-			if (!parent->indegree)
+			count = get_indegree(&id_overflow, parent);
+			if (!count)
 				continue;
 
 			/*
@@ -579,7 +608,9 @@ void sort_in_topological_order(struct commit_list ** list, int lifo)
 			 * when all their children have been emitted thereby
 			 * guaranteeing topological order.
 			 */
-			if (--parent->indegree == 1) {
+			count--;
+			set_indegree(&id_overflow, parent, count);
+			if (count == 1) {
 				if (!lifo)
 					commit_list_insert_by_date(parent, &work);
 				else
@@ -590,10 +621,11 @@ void sort_in_topological_order(struct commit_list ** list, int lifo)
 		 * work_item is a commit all of whose children
 		 * have already been emitted. we can emit it now.
 		 */
-		commit->indegree = 0;
+		set_indegree(&id_overflow, commit, 0);
 		*pptr = work_item;
 		pptr = &work_item->next;
 	}
+	clear_decoration(&id_overflow, NULL);
 }
 
 /* merge-base stuff */
diff --git a/commit.h b/commit.h
index 87b4b6c..771eeae 100644
--- a/commit.h
+++ b/commit.h
@@ -15,7 +15,7 @@ struct commit_list {
 struct commit {
 	struct object object;
 	void *util;
-	unsigned int indegree;
+	unsigned int indegree:8; /* see QUICK_INDEGREE_LIMIT in commit.c */
 	unsigned long date;
 	struct commit_list *parents;
 	struct tree *tree;
-- 
1.8.2.1-450-gd047976
