From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] revision traversal: show full history with merge
 simplification
Date: Thu, 31 Jul 2008 01:17:41 -0700
Message-ID: <7vhca6zcuy.fsf@gitster.siamese.dyndns.org>
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
 <7vej5b3ozz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Roman Zippel <zippel@linux-m68k.org>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Tim Harper <timcharper@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jul 31 10:19:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOTND-0002Ox-Ip
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 10:19:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751496AbYGaIR5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 04:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751455AbYGaIRz
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 04:17:55 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60262 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751144AbYGaIRw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 04:17:52 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3C62F40A94;
	Thu, 31 Jul 2008 04:17:50 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id A9A4440A92; Thu, 31 Jul 2008 04:17:43 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2A583388-5ED9-11DD-A6E9-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90909>

The --full-history traversal keeps all merges in addition to non-merge
commits that touch paths in the given pathspec.  This is useful to view
both sides of a merge in a topology like this:

        A---M---o
       /   /
   ---O---B

even when A and B makes identical change to the given paths.  The revision
traversal without --full-history aims to come up with the simplest history
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
the commit that should replace it in the simplified history.  The commit
to replace it in the final history is determined as follows:

 * In any case, we first figure out the replacement commits of parents of
   the commit we are looking at.  The commit we are looking at is
   rewritten as if the replacement commits of its original parents are its
   parents.  While doing so, we reduce the redundant parents from the
   rewritten parent list by not just removing the identical ones, but also
   removing a parent that is an ancestor of another parent.

 * After the above parent simplification, if the commit is a root commit,
   an UNINTERESTING commit, a merge commit, or modifies the paths we are
   interested in, then the replacement commit of the commit is itself.  In
   other words, such a commit is not dropped from the final result.

The first point above essentially means that the history is rewritten in
the bottom up direction.  We can rewrite the parent list of a commit only
after we know how all of its parents are rewritten.  This means that the
processing needs to happen on the full history (i.e. after limit_list()).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Changes from the "quick hack" are:

   - When the history is bounded at the bottom, the v1 patch did not
     terminate, because it wanted to know the replacement for
     UNINTERESTING parents of commits on revs->commit list, but these
     parents were never processed.  Oops.

   - The option implies rewrite_parents.  I was tempted to make it imply
     "--parents" (which would make it always emit parent information as
     well), but didn't.

   - Toposort is still implied but it is done at the end.

   - The code is more heavily commented.

   - I do not think "--post-simplify" is particulary a good name, but I
     couldn't come up with a good one.  To mark it clearly not ready for
     'master', I changed the name to a meaningless word for now ;-)

 * Timings (best of 5 runs)

   $ git rev-list --parents --full-history --topo-order HEAD -- kernel/printk.c
   3.75user 0.47system 0:04.22elapsed 100%CPU (0avgtext+0avgdata 0maxresident)k

   $ git rev-list --parents --oyoyo HEAD -- kernel/printk.c
   4.31user 0.06system 0:04.37elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k

   $ git rev-list --parents --full-history HEAD -- kernel/printk.c | head -n 200
   0.16user 0.02system 0:00.18elapsed 103%CPU (0avgtext+0avgdata 0maxresident)k

 revision.c |  171 +++++++++++++++++++++++++++++++++++++++++++++++++++++-------
 revision.h |    1 +
 2 files changed, 152 insertions(+), 20 deletions(-)

diff --git a/revision.c b/revision.c
index 3897fec..3b59e02 100644
--- a/revision.c
+++ b/revision.c
@@ -1045,6 +1045,11 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else if (!strcmp(arg, "--topo-order")) {
 		revs->lifo = 1;
 		revs->topo_order = 1;
+	} else if (!strcmp(arg, "--oyoyo")) {
+		revs->post_simplify = 1;
+		revs->rewrite_parents = 1;
+		revs->simplify_history = 0;
+		revs->limited = 1;
 	} else if (!strcmp(arg, "--date-order")) {
 		revs->lifo = 0;
 		revs->topo_order = 1;
@@ -1378,6 +1383,150 @@ static void add_child(struct rev_info *revs, struct commit *parent, struct commi
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
+static struct commit_list **post_simplify_one(struct commit *commit, struct commit_list **tail)
+{
+	struct commit_list *p;
+	int cnt;
+
+	/*
+	 * We store which commit each one simplifies to in its util field.
+	 * Have we handled this one?
+	 */
+	if (commit->util)
+		return tail;
+
+	/*
+	 * An UNINTERESTING commit simplifies to itself, so does a
+	 * root commit.  We do not rewrite parents of such commit
+	 * anyway.
+	 */
+	if ((commit->object.flags & UNINTERESTING) || !commit->parents) {
+		commit->util = commit;
+		return tail;
+	}
+
+	/*
+	 * Do we know what commit all of our parents should be rewritten to?
+	 * Otherwise we are not ready to rewrite this one yet.
+	 */
+	for (cnt = 0, p = commit->parents; p; p = p->next) {
+		if (!p->item->util) {
+			tail = &commit_list_insert(p->item, tail)->next;
+			cnt++;
+		}
+	}
+	if (cnt)
+		return tail;
+
+	/*
+	 * Rewrite our list of parents.
+	 */
+	for (p = commit->parents; p; p = p->next)
+		p->item = p->item->util;
+	cnt = remove_duplicate_parents(commit);
+
+	/*
+	 * It is possible that we are a merge and one side branch
+	 * does not have any commit that touches the given paths;
+	 * in such a case, the immediate parents will be rewritten
+	 * to different commits.
+	 *
+	 *      o----X		X: the commit we are looking at;
+	 *     /    /		o: a commit that touches the paths;
+	 * ---o----'
+	 *
+	 * Further reduce the parents by removing redundant parents.
+	 */
+	if (1 < cnt) {
+		struct commit_list *h = reduce_heads(commit->parents);
+		cnt = commit_list_count(h);
+		free_commit_list(commit->parents);
+		commit->parents = h;
+	}
+
+	/*
+	 * A commit simplifies to itself if it is a root, if it is
+	 * UNINTERESTING, if it touches the given paths, or if it is a
+	 * merge and its parents simplifies to more than one commits
+	 * (the first two cases are already handled at the beginning of
+	 * this function).
+	 *
+	 * Otherwise, it simplifies to what its sole parent simplifies to.
+	 */
+	if (!cnt ||
+	    (commit->object.flags & UNINTERESTING) ||
+	    !(commit->object.flags & TREESAME) ||
+	    (1 < cnt))
+		commit->util = commit;
+	else
+		commit->util = commit->parents->item->util;
+	return tail;
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
+			tail = post_simplify_one(commit, tail);
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
+
+	/* sort topologically at the end */
+	sort_in_topological_order(&revs->commits, revs->lifo);
+}
+
 static void set_children(struct rev_info *revs)
 {
 	struct commit_list *l;
@@ -1418,6 +1567,8 @@ int prepare_revision_walk(struct rev_info *revs)
 			return -1;
 	if (revs->topo_order)
 		sort_in_topological_order(&revs->commits, revs->lifo);
+	if (revs->post_simplify)
+		post_simplify(revs);
 	if (revs->children.name)
 		set_children(revs);
 	return 0;
@@ -1450,26 +1601,6 @@ static enum rewrite_result rewrite_one(struct rev_info *revs, struct commit **pp
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
1.6.0.rc1.31.gf448e
