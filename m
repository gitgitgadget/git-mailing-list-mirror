From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] revision walker: Fix --boundary when limited
Date: Mon, 05 Mar 2007 13:10:06 -0800
Message-ID: <7vejo3xuq9.fsf@assigned-by-dhcp.cox.net>
References: <8aa486160703050202y5ee159d2i42a2859a00b41679@mail.gmail.com>
	<7vlkicynwm.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0703051951340.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0703051130090.3998@woody.linux-foundation.org>
	<Pine.LNX.4.64.0703051145210.3998@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Santi =?utf-8?Q?B?= =?utf-8?Q?=C3=A9jar?= <sbejar@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Mar 05 22:10:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOKRq-0002XX-2w
	for gcvg-git@gmane.org; Mon, 05 Mar 2007 22:10:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933196AbXCEVKM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Mar 2007 16:10:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752899AbXCEVKM
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 16:10:12 -0500
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:59611 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752895AbXCEVKJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 16:10:09 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070305211007.XQEO3546.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Mon, 5 Mar 2007 16:10:07 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id X9A71W0051kojtg0000000; Mon, 05 Mar 2007 16:10:07 -0500
In-Reply-To: <Pine.LNX.4.64.0703051145210.3998@woody.linux-foundation.org>
	(Linus Torvalds's message of "Mon, 5 Mar 2007 11:57:42 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41486>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Mon, 5 Mar 2007, Linus Torvalds wrote:
>> 
>> NOTE! Our patches aren't really mutually incompatible, and they attack the 
>> problem from two different directions. You do the separate phase (which is 
>> also correct), and my patch instead tries to clean up the commit walking 
>> so that the commit number limiter works more like the date limiter (which 
>> fundamentally has all the same issues! Including the problem with some 
>> commits possibly being marked as boundary commits when they aren't really, 
>> because the path-limiting or revision-limiting ended up cutting things off 
>> *differently* than the date-limiting).

I was working on a different approach, which is:

 - rip out the boundary logic from the commit walker. Placing
   "negative" commits in the revs->commits list was Ok if all we
   cared about "boundary" was the UNINTERESTING limiting case,
   but conceptually it was wrong.

 - make get_revision_1() function to walk the commits and return
   the results as if there is no funny postprocessing flags such
   as --reverse, --skip nor --max-count.

 - make get_revision() function the postprocessing phase:

   If reverse is given, wait for get_revision_1() to give
   everything that it would normally give, and then reverse it
   before consuming.

   If skip is given, skip that many before going further.

   If max is given, stop when we gave out that many.

   Now that we are about to return one positive commit, mark
   the parents of that commit to be potential boundaries
   before returning, iff we are doing the boundary processing.

   Return the commit.

 - After get_revision() finishes giving out all the positive
   commits, if we are doing the boundary processing, we look at
   the parents that we marked as potential boundaries earlier,
   see if they are really boundaries, and give them out.

It loses more code than it adds, even when the new gc_boundary()
function, which is purely for early optimization, is counted.

Note that this patch is purely for eyeballing and discussion
only.  It breaks git-bundle's verify logic because the logic
does not use BOUNDARY_SHOW flag for its internal computation
anymore.  After we correct it not to attempt to affect the
boundary processing by setting the BOUNDARY_SHOW flag, we can
remove BOUNDARY_SHOW from revision.h and use that bit assignment
for the new CHILD_SHOWN flag.

---
 revision.c |  208 +++++++++++++++++++++++++++---------------------------------
 revision.h |    8 ++-
 2 files changed, 100 insertions(+), 116 deletions(-)

diff --git a/revision.c b/revision.c
index f5b8ae4..5d137ea 100644
--- a/revision.c
+++ b/revision.c
@@ -437,36 +437,6 @@ static void limit_list(struct rev_info *revs)
 			continue;
 		p = &commit_list_insert(commit, p)->next;
 	}
-	if (revs->boundary) {
-		/* mark the ones that are on the result list first */
-		for (list = newlist; list; list = list->next) {
-			struct commit *commit = list->item;
-			commit->object.flags |= TMP_MARK;
-		}
-		for (list = newlist; list; list = list->next) {
-			struct commit *commit = list->item;
-			struct object *obj = &commit->object;
-			struct commit_list *parent;
-			if (obj->flags & UNINTERESTING)
-				continue;
-			for (parent = commit->parents;
-			     parent;
-			     parent = parent->next) {
-				struct commit *pcommit = parent->item;
-				if (!(pcommit->object.flags & UNINTERESTING))
-					continue;
-				pcommit->object.flags |= BOUNDARY;
-				if (pcommit->object.flags & TMP_MARK)
-					continue;
-				pcommit->object.flags |= TMP_MARK;
-				p = &commit_list_insert(pcommit, p)->next;
-			}
-		}
-		for (list = newlist; list; list = list->next) {
-			struct commit *commit = list->item;
-			commit->object.flags &= ~TMP_MARK;
-		}
-	}
 	revs->commits = newlist;
 }
 
@@ -1193,17 +1163,6 @@ static void rewrite_parents(struct rev_info *revs, struct commit *commit)
 	}
 }
 
-static void mark_boundary_to_show(struct commit *commit)
-{
-	struct commit_list *p = commit->parents;
-	while (p) {
-		commit = p->item;
-		p = p->next;
-		if (commit->object.flags & BOUNDARY)
-			commit->object.flags |= BOUNDARY_SHOW;
-	}
-}
-
 static int commit_match(struct commit *commit, struct rev_info *opt)
 {
 	if (!opt->grep_filter)
@@ -1235,15 +1194,9 @@ static struct commit *get_revision_1(struct rev_info *revs)
 		 */
 		if (!revs->limited) {
 			if (revs->max_age != -1 &&
-			    (commit->date < revs->max_age)) {
-				if (revs->boundary)
-					commit->object.flags |=
-						BOUNDARY_SHOW | BOUNDARY;
-				else
-					continue;
-			} else
-				add_parents_to_list(revs, commit,
-						&revs->commits);
+			    (commit->date < revs->max_age))
+				continue;
+			add_parents_to_list(revs, commit, &revs->commits);
 		}
 		if (commit->object.flags & SHOWN)
 			continue;
@@ -1252,18 +1205,6 @@ static struct commit *get_revision_1(struct rev_info *revs)
 						    revs->ignore_packed))
 		    continue;
 
-		/* We want to show boundary commits only when their
-		 * children are shown.  When path-limiter is in effect,
-		 * rewrite_parents() drops some commits from getting shown,
-		 * and there is no point showing boundary parents that
-		 * are not shown.  After rewrite_parents() rewrites the
-		 * parents of a commit that is shown, we mark the boundary
-		 * parents with BOUNDARY_SHOW.
-		 */
-		if (commit->object.flags & BOUNDARY_SHOW) {
-			commit->object.flags |= SHOWN;
-			return commit;
-		}
 		if (commit->object.flags & UNINTERESTING)
 			continue;
 		if (revs->min_age != -1 && (commit->date > revs->min_age))
@@ -1286,80 +1227,119 @@ static struct commit *get_revision_1(struct rev_info *revs)
 			if (revs->parents)
 				rewrite_parents(revs, commit);
 		}
-		if (revs->boundary)
-			mark_boundary_to_show(commit);
 		commit->object.flags |= SHOWN;
 		return commit;
 	} while (revs->commits);
 	return NULL;
 }
 
+static void gc_boundary(struct object_array *array)
+{
+	unsigned nr = array->nr;
+	unsigned alloc = array->alloc;
+	struct object_array_entry *objects = array->objects;
+
+	if (alloc <= nr) {
+		unsigned i, j;
+		for (i = j = 0; i < nr; i++) {
+			if (objects[i].item->flags & SHOWN)
+				continue;
+			if (i != j)
+				objects[j] = objects[i];
+			j++;
+		}
+		for (i = j; j < nr; j++)
+			objects[i].item = NULL;
+		array->nr = j;
+	}
+}
+
 struct commit *get_revision(struct rev_info *revs)
 {
 	struct commit *c = NULL;
-
-	if (revs->reverse) {
-		struct commit_list *list;
-
-		/*
-		 * rev_info.reverse is used to note the fact that we
-		 * want to output the list of revisions in reverse
-		 * order.  To accomplish this goal, reverse can have
-		 * different values:
-		 *
-		 *  0  do nothing
-		 *  1  reverse the list
-		 *  2  internal use:  we have already obtained and
-		 *     reversed the list, now we only need to yield
-		 *     its items.
-		 */
-
-		if (revs->reverse == 1) {
-			revs->reverse = 0;
-			list = NULL;
-			while ((c = get_revision(revs)))
-				commit_list_insert(c, &list);
-			revs->commits = list;
-			revs->reverse = 2;
+	struct commit_list *l;
+
+	if (revs->boundary == 2) {
+		unsigned i;
+		struct object_array *array = &revs->boundary_commits;
+		struct object_array_entry *objects = array->objects;
+		for (i = 0; i < array->nr; i++) {
+			c = (struct commit *)(objects[i].item);
+			if (!c)
+				continue;
+			if (!(c->object.flags & CHILD_SHOWN))
+				continue;
+			if (!(c->object.flags & SHOWN))
+				break;
 		}
-
-		if (!revs->commits)
+		if (array->nr <= i)
 			return NULL;
-		c = revs->commits->item;
-		list = revs->commits->next;
-		free(revs->commits);
-		revs->commits = list;
+
+		c->object.flags |= SHOWN | BOUNDARY;
 		return c;
 	}
 
-	if (0 < revs->skip_count) {
-		while ((c = get_revision_1(revs)) != NULL) {
-			if (revs->skip_count-- <= 0)
-				break;
-		}
+	if (revs->reverse) {
+		l = NULL;
+		while ((c = get_revision_1(revs)))
+			commit_list_insert(c, &l);
+		revs->commits = l;
+		revs->reverse = 0;
 	}
 
-	/* Check the max_count ... */
+	/*
+	 * Now pick up what they want to give us
+	 */
+	c = get_revision_1(revs);
+	while (0 < revs->skip_count) {
+		revs->skip_count--;
+		c = get_revision_1(revs);
+		if (!c)
+			break;
+	}
+
+	/*
+	 * Check the max_count.
+	 */
 	switch (revs->max_count) {
 	case -1:
 		break;
 	case 0:
-		if (revs->boundary) {
-			struct commit_list *list = revs->commits;
-			while (list) {
-				list->item->object.flags |=
-					BOUNDARY_SHOW | BOUNDARY;
-				list = list->next;
-			}
-			/* all remaining commits are boundary commits */
-			revs->max_count = -1;
-			revs->limited = 1;
-		} else
-			return NULL;
+		c = NULL;
+		break;
 	default:
 		revs->max_count--;
 	}
-	if (c)
+
+	if (!revs->boundary)
 		return c;
-	return get_revision_1(revs);
+
+	if (!c) {
+		/*
+		 * get_revision_1() runs out the commits, and
+		 * we are done computing the boundaries.
+		 * switch to boundary commits output mode.
+		 */
+		revs->boundary = 2;
+		return get_revision(revs);
+	}
+
+	/*
+	 * boundary commits are the commits that are parents of the
+	 * ones we got from get_revision_1() but they themselves are
+	 * not returned from get_revision_1().  Before returning
+	 * 'c', we need to mark its parents that they could be boundaries.
+	 */
+
+	for (l = c->parents; l; l = l->next) {
+		struct object *p;
+		p = &(l->item->object);
+		if (p->flags & CHILD_SHOWN)
+			continue;
+		p->flags |= CHILD_SHOWN;
+		gc_boundary(&revs->boundary_commits);
+		add_object_array(p, NULL, &revs->boundary_commits);
+	}
+
+	return c;
 }
diff --git a/revision.h b/revision.h
index 5fec184..6579a44 100644
--- a/revision.h
+++ b/revision.h
@@ -10,6 +10,7 @@
 #define BOUNDARY_SHOW	(1u<<6)
 #define ADDED		(1u<<7)	/* Parents already parsed and added? */
 #define SYMMETRIC_LEFT	(1u<<8)
+#define CHILD_SHOWN	(1u<<9)
 
 struct rev_info;
 struct log_info;
@@ -21,6 +22,9 @@ struct rev_info {
 	struct commit_list *commits;
 	struct object_array pending;
 
+	/* Parents of shown commits */
+	struct object_array boundary_commits;
+
 	/* Basic information */
 	const char *prefix;
 	void *prune_data;
@@ -40,10 +44,10 @@ struct rev_info {
 			edge_hint:1,
 			limited:1,
 			unpacked:1, /* see also ignore_packed below */
-			boundary:1,
+			boundary:2,
 			left_right:1,
 			parents:1,
-			reverse:2;
+			reverse:1;
 
 	/* Diff flags */
 	unsigned int	diff:1,
