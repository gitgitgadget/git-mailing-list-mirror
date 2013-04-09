From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/3] Using a bit more decoration
Date: Tue, 9 Apr 2013 02:52:56 -0400
Message-ID: <20130409065256.GA20115@sigill.intra.peff.net>
References: <20130408210903.GC9649@sigill.intra.peff.net>
 <1365462114-8630-1-git-send-email-gitster@pobox.com>
 <20130409035126.GA17319@sigill.intra.peff.net>
 <7vsj30tk0p.fsf@alter.siamese.dyndns.org>
 <20130409043938.GA31447@sigill.intra.peff.net>
 <7vk3octiat.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <junio@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 09 08:53:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPSQX-0004hz-OF
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 08:53:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935735Ab3DIGxD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Apr 2013 02:53:03 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:34807 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934554Ab3DIGxB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Apr 2013 02:53:01 -0400
Received: (qmail 20324 invoked by uid 107); 9 Apr 2013 06:54:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 09 Apr 2013 02:54:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Apr 2013 02:52:56 -0400
Content-Disposition: inline
In-Reply-To: <7vk3octiat.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220553>

On Mon, Apr 08, 2013 at 09:54:50PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > The tricky part is how to store the index for each commit (or object). I
> > don't see a way around adding a new field to "struct commit" to do so.
> 
> We could reuse the space "indegree" used to live at; that is a
> one-word space already, and I really do not need "encoding".  It was
> no more than "while we are at it, we could add different things
> here" demonstration.

Here is what my proposal would look like, replacing indegree with the
"index" field. In my timings of "git rev-list --topo-order --all", I
couldn't measure any difference.

Now the next tricky step will actually be writing a paint_down_to_common
that uses it. :)  The auto-growing slab implementation below assumes a
fixed width of one int per commit. I think we'd want something similar
that stores a set of N bits per commit, where N is fixed at the start of
the algorithm.

---
 commit.c | 59 +++++++++++++++++++++++++++++------
 commit.h |  2 +-
 2 files changed, 51 insertions(+), 10 deletions(-)

diff --git a/commit.c b/commit.c
index 516a4ff..95f041a 100644
--- a/commit.c
+++ b/commit.c
@@ -14,6 +14,7 @@ const char *commit_type = "commit";
 int save_commit_buffer = 1;
 
 const char *commit_type = "commit";
+static int commit_count;
 
 static struct commit *check_commit(struct object *obj,
 				   const unsigned char *sha1,
@@ -58,8 +59,11 @@ struct commit *lookup_commit(const unsigned char *sha1)
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
@@ -506,6 +510,36 @@ struct commit *pop_commit(struct commit_list **stack)
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
@@ -514,15 +548,18 @@ void sort_in_topological_order(struct commit_list ** list, int lifo)
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
@@ -530,9 +567,10 @@ void sort_in_topological_order(struct commit_list ** list, int lifo)
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
@@ -549,7 +587,7 @@ void sort_in_topological_order(struct commit_list ** list, int lifo)
 	for (next = orig; next; next = next->next) {
 		struct commit *commit = next->item;
 
-		if (commit->indegree == 1)
+		if (*slab_at(&indegree, commit) == 1)
 			insert = &commit_list_insert(commit, insert)->next;
 	}
 
@@ -570,8 +608,9 @@ void sort_in_topological_order(struct commit_list ** list, int lifo)
 		commit = work_item->item;
 		for (parents = commit->parents; parents ; parents = parents->next) {
 			struct commit *parent = parents->item;
+			int *pi = slab_at(&indegree, parent);
 
-			if (!parent->indegree)
+			if (!*pi)
 				continue;
 
 			/*
@@ -579,7 +618,7 @@ void sort_in_topological_order(struct commit_list ** list, int lifo)
 			 * when all their children have been emitted thereby
 			 * guaranteeing topological order.
 			 */
-			if (--parent->indegree == 1) {
+			if (--(*pi) == 1) {
 				if (!lifo)
 					commit_list_insert_by_date(parent, &work);
 				else
@@ -590,10 +629,12 @@ void sort_in_topological_order(struct commit_list ** list, int lifo)
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
index 87b4b6c..8b1099f 100644
--- a/commit.h
+++ b/commit.h
@@ -15,7 +15,7 @@ struct commit {
 struct commit {
 	struct object object;
 	void *util;
-	unsigned int indegree;
+	unsigned int index;
 	unsigned long date;
 	struct commit_list *parents;
 	struct tree *tree;
