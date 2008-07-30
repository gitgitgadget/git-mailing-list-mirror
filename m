From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bizarre missing changes (git bug?)
Date: Wed, 30 Jul 2008 16:56:32 -0700
Message-ID: <7vej5b3ozz.fsf@gitster.siamese.dyndns.org>
References: <8502DF7C-5303-49E8-8C67-F837343E2F0C@gmail.com>
 <200807260512.40088.zippel@linux-m68k.org>
 <alpine.LFD.1.10.0807261249430.4188@nehalem.linux-foundation.org>
 <Pine.LNX.4.64.0807270049290.6791@localhost.localdomain>
 <alpine.LFD.1.10.0807271144520.3486@nehalem.linux-foundation.org>
 <Pine.LNX.4.64.0807272101470.6791@localhost.localdomain>
 <alpine.LFD.1.10.0807271613440.3486@nehalem.linux-foundation.org>
 <Pine.LNX.4.64.0807280141140.6791@localhost.localdomain>
 <alpine.LFD.1.10.0807272148030.3486@nehalem.linux-foundation.org>
 <Pine.LNX.4.64.0807281241180.6791@localhost.localdomain>
 <46a038f90807282015m7ce3da10h71dfee221c960332@mail.gmail.com>
 <Pine.LNX.4.64.0807291433430.6791@localhost.localdomain>
 <alpine.LFD.1.10.0807291716060.3334@nehalem.linux-foundation.org>
 <alpine.LFD.1.10.0807291738280.3334@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Roman Zippel <zippel@linux-m68k.org>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Tim Harper <timcharper@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jul 31 01:57:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOLYH-0002dd-Sm
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 01:57:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753478AbYG3X4v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 19:56:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752296AbYG3X4v
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 19:56:51 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:36175 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752001AbYG3X4u (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 19:56:50 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 6630A43720;
	Wed, 30 Jul 2008 19:56:47 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id F391F4371F; Wed, 30 Jul 2008 19:56:39 -0400 (EDT)
In-Reply-To: <alpine.LFD.1.10.0807291738280.3334@nehalem.linux-foundation.org> (Linus
 Torvalds's message of "Tue, 29 Jul 2008 17:48:11 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2B8143F8-5E93-11DD-BC76-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90879>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> But the reverse isn't true: the current primary formats cannot be 
> generated from your preferred format without losing something important 
> (performance).
>
> But I'll make you a deal: if you actually write the filter in C form, I 
> can pretty much guarantee that we can easily add it as a new flag. It 
> really should be pretty easy to integrate it into the revision parsing 
> machinery alongside --topo-order, since it's really the same kind of 
> operation.

I am not Roman, but so I do not know if I did what Roman wanted to, but
here is a quick hack.  "gitk --post-simplify -- kernel/printk.c" is
slightly more readable than --full-history with this patch.

-- >8 --
Subject: [PATCH] revision traversal: teach --post-simplify

The --full-history traversal keeps all merges and non-merge commits that
touch paths in the given pathspec.  This is useful to view both sides of a
merge in a topology like this:

        A---M---o
       /   /
   ---O---B

when A and B makes identical change to the given paths.  The revision
traversal without --full-history aims to come up with a simplest history
to explain the final state of the tree, and one of the side branches can
be pruned away.

The behaviour to keep all merges however is inconvenient if neither A nor
B touches the paths we are interested in.  --full-history reduces the
topology to:

   ---O---M---o

in such a case, without removing M.

This adds a post processing phase on top of --full-history traversal to
remove needless merges from the resulting history.

The idea is to compute, for each commit in the "full history" result set,
the commit that should replace it in the simplified history.  This
replacement commit is defined as follows:

 * In any case, we first figure out the replacement commits of parents of
   the commit we are looking at.  The commit we are looking at is
   rewritten as if its parents are replacement commits of its original
   parents.

 * If the commit is marked as TREESAME (i.e. it modifies the paths we are
   interested in), then the replacement commit is itself.  IOW, the commit
   is not dropped from the final result.

 * Otherwise, we examine the parents of the commit.

   - If they replace to the same commit, because the commit we are looking
     at itself does not touch the interesting paths, we replace the commit
     we are looking at with the replacement commit of its parents.

   - If some of the parents replace to one commit, and some other parents
     replace to another different commit, the commit we are looking at
     needs to stay as a merge in the final result.

The algorithm outlined above alone does not quite work; the reason is
because "all parents are replaced by the same commit" rule is too strict.
It needs to be relaxed to remove parents that are ancestor of some other
parents, and that is why post_simplify_one() calls a rather expensive
reduce_heads().

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 revision.c |  125 ++++++++++++++++++++++++++++++++++++++++++++++++++----------
 revision.h |    1 +
 2 files changed, 106 insertions(+), 20 deletions(-)

diff --git a/revision.c b/revision.c
index 3897fec..a843c42 100644
--- a/revision.c
+++ b/revision.c
@@ -1045,6 +1045,10 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else if (!strcmp(arg, "--topo-order")) {
 		revs->lifo = 1;
 		revs->topo_order = 1;
+	} else if (!strcmp(arg, "--post-simplify")) {
+		revs->post_simplify = 1;
+		revs->topo_order = 1;
+		revs->simplify_history = 0;
 	} else if (!strcmp(arg, "--date-order")) {
 		revs->lifo = 0;
 		revs->topo_order = 1;
@@ -1378,6 +1382,105 @@ static void add_child(struct rev_info *revs, struct commit *parent, struct commi
 	l->next = add_decoration(&revs->children, &parent->object, l);
 }
 
+static int remove_duplicate_parents(struct commit *commit)
+{
+	struct commit_list **pp, *p;
+	int surviving_parents;
+
+	/* Examine existing parents while marking ones we have seen... */
+	pp = &commit->parents;
+	while ((p = *pp) != NULL) {
+		struct commit *parent = p->item;
+		if (parent->object.flags & TMP_MARK) {
+			*pp = p->next;
+			continue;
+		}
+		parent->object.flags |= TMP_MARK;
+		pp = &p->next;
+	}
+	/* count them while clearing the temporary mark */
+	surviving_parents = 0;
+	for (p = commit->parents; p; p = p->next) {
+		p->item->object.flags &= ~TMP_MARK;
+		surviving_parents++;
+	}
+	return surviving_parents;
+}
+
+static int post_simplify_one(struct commit *commit)
+{
+	struct commit_list *p;
+	int num_parents;
+
+	for (p = commit->parents; p; p = p->next)
+		if (!p->item->util)
+			return 0;
+
+	/* All of our parents know what they should be rewritten to */
+	for (p = commit->parents; p; p = p->next)
+		p->item = p->item->util;
+	num_parents = remove_duplicate_parents(commit);
+
+	if (1 < num_parents) {
+		struct commit_list *h = reduce_heads(commit->parents);
+		num_parents = commit_list_count(h);
+		free_commit_list(commit->parents);
+		commit->parents = h;
+	}
+
+	/*
+	 * We stand for ourselves if we are root, if we change the tree,
+	 * or if we are a merge and our parents simplify to different
+	 * commits.  Otherwise we can be replaced by the commit our
+	 * sole parent is replaced by.
+	 */
+	if (!num_parents ||
+	    !(commit->object.flags & TREESAME) ||
+	    (1 < num_parents))
+		commit->util = commit;
+	else
+		commit->util = commit->parents->item->util;
+
+	return 1;
+}
+
+static void post_simplify(struct rev_info *revs)
+{
+	struct commit_list *list;
+	struct commit_list *yet_to_do, **tail;
+
+	/* feed the list reversed */
+	yet_to_do = NULL;
+	for (list = revs->commits; list; list = list->next)
+		commit_list_insert(list->item, &yet_to_do);
+	while (yet_to_do) {
+		list = yet_to_do;
+		yet_to_do = NULL;
+		tail = &yet_to_do;
+		while (list) {
+			struct commit *commit = list->item;
+			struct commit_list *next = list->next;
+			free(list);
+			list = next;
+			if (!post_simplify_one(commit))
+				tail = &commit_list_insert(commit, tail)->next;
+		}
+	}
+
+	/* clean up the result, removing the simplified ones */
+	list = revs->commits;
+	revs->commits = NULL;
+	tail = &revs->commits;
+	while (list) {
+		struct commit *commit = list->item;
+		struct commit_list *next = list->next;
+		free(list);
+		list = next;
+		if (commit->util == commit)
+			tail = &commit_list_insert(commit, tail)->next;
+	}
+}
+
 static void set_children(struct rev_info *revs)
 {
 	struct commit_list *l;
@@ -1418,6 +1521,8 @@ int prepare_revision_walk(struct rev_info *revs)
 			return -1;
 	if (revs->topo_order)
 		sort_in_topological_order(&revs->commits, revs->lifo);
+	if (revs->post_simplify)
+		post_simplify(revs);
 	if (revs->children.name)
 		set_children(revs);
 	return 0;
@@ -1450,26 +1555,6 @@ static enum rewrite_result rewrite_one(struct rev_info *revs, struct commit **pp
 	}
 }
 
-static void remove_duplicate_parents(struct commit *commit)
-{
-	struct commit_list **pp, *p;
-
-	/* Examine existing parents while marking ones we have seen... */
-	pp = &commit->parents;
-	while ((p = *pp) != NULL) {
-		struct commit *parent = p->item;
-		if (parent->object.flags & TMP_MARK) {
-			*pp = p->next;
-			continue;
-		}
-		parent->object.flags |= TMP_MARK;
-		pp = &p->next;
-	}
-	/* ... and clear the temporary mark */
-	for (p = commit->parents; p; p = p->next)
-		p->item->object.flags &= ~TMP_MARK;
-}
-
 static int rewrite_parents(struct rev_info *revs, struct commit *commit)
 {
 	struct commit_list **pp = &commit->parents;
diff --git a/revision.h b/revision.h
index f64e8ce..953e69b 100644
--- a/revision.h
+++ b/revision.h
@@ -41,6 +41,7 @@ struct rev_info {
 			simplify_history:1,
 			lifo:1,
 			topo_order:1,
+			post_simplify:1,
 			tag_objects:1,
 			tree_objects:1,
 			blob_objects:1,
-- 
1.6.0.rc1.29.gc4aca
