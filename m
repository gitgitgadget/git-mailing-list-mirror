From: Jeff King <peff@peff.net>
Subject: Re: git describe weird behaviour
Date: Tue, 9 Nov 2010 23:14:28 -0500
Message-ID: <20101110041428.GA8955@sigill.intra.peff.net>
References: <20101110010016.GC22105@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Wed Nov 10 05:14:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PG251-0001EY-Eq
	for gcvg-git-2@lo.gmane.org; Wed, 10 Nov 2010 05:14:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753569Ab0KJEOd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Nov 2010 23:14:33 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:41742 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751733Ab0KJEOd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Nov 2010 23:14:33 -0500
Received: (qmail 13100 invoked by uid 111); 10 Nov 2010 04:14:30 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 10 Nov 2010 04:14:30 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Nov 2010 23:14:28 -0500
Content-Disposition: inline
In-Reply-To: <20101110010016.GC22105@genesis.frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161129>

[cc'ing Shawn, who probably doesn't remember at all how git-describe
 works these days, but it's worth a shot]

On Wed, Nov 10, 2010 at 02:00:16AM +0100, Miklos Vajna wrote:

> The frugalware project (git repo:
> http://frugalware.org/git/pub/frugalware/frugalware-current ) has the
> two latest tags 1.3 and 1.4pre1, somehow git describe HEAD now mentions
> 1.3 and not 1.4pre1 in the output.
> 
> To be more exact:
> 
> $ git rev-parse --short HEAD
> f25435f
> 
> $ git rev-list 1.4pre1..|wc -l
> 871
> 
> So I would exepct 1.4pre1-871-gf25435f. In fact, the output is:
> 
> $ git describe
> 1.3-3028-gf25435f
> 
> Or in case I force the usage of the latest tag:
> 
> $ git describe --candidate 1
> 1.4pre1-64725-gf25435f
> 
> Does anyone have an idea what's going wrong here?

The describe code is pretty inscrutable. But what it should be doing is
roughly:

  1. Describe all interesting refs (annotated tags by default) by
     marking the commit object's util field.

  2. Walk backwards in the commit tree. As we walk backwards, keep track
     of how far (in commits) we have gone. When we see a tag, mark it
     with how far we've gone.

The trick is in keeping track of how far we've gone. It looks like we
keep the number of seen_commits, increment each time we traverse a
commit, and then assign that to the "depth" field. But I don't see how
that can be right. We are traversing in a breadth-first manner, so we
may look at 1000 commits down one ancestry chain of a merge before
following the first parent on another. But when we finally follow the
second parent, our seen_commits is much higher than the actual distance
we had to travel to get here. Looking at the frugalware history in gitk,
you might be triggering this; you have a history with just a few merges,
but extremely long chains of commits on each branch. Repos like linux or
git.git are a bit bushier in the shape of the graph.

But there's more going on there that I don't quite understand. There is
some kind of magic "within" flag being kept for each tag we find. It's a
little too late at night for me to wrap my head around it tonight. But I
don't think it changes the fundamental issue that our depth value is
just an estimate; its accuracy works under the assumption that all sides
of a branch are about equal.

It seems to me the "right" way to do it would be to track the depth to
get to each commit. We can do this efficiently by just keeping a depth
marker for each commit we push onto the commit_list queue. When we visit
each commit, we know its depth, and when we push on its parents, they
get its depth+1.

The patch below implements that in a very rough-and-dirty way. It does
find the 1.4 tag in your repository that you expect. However:

  1. This still isn't quite accurate. We might visit a commit by two
     different paths. When we reach it by a shorter path, we need some
     way of saying "oops, the depth on any tags we found following this
     path are going to be too long. We need to go back and shorten
     them".

  2. I am getting nonsensical results when trying it in git.git. It
     really wants to point me to gitgui tags, which makes no sense. So
     clearly there is a bug, or my idea is flawed somehow. But it's too
     late to think about anymore tonight. :)

-Peff

PS This would be a much simpler algorithm to write in a depth-first way.
   But that would also involve traversing the entire graph down to the
   roots, which we try to avoid.  Which reminds me of my "tag
   --contains" depth first algorithm, and gives me some ideas on how to
   make it work in a breadth-first way. So even if my idea here is
   flawed, this thinking hasn't been completely fruitless. :)

-- >8 --
diff --git a/builtin/describe.c b/builtin/describe.c
index 43caff2..31cf855 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -164,39 +164,6 @@ static int compare_pt(const void *a_, const void *b_)
 	return 0;
 }
 
-static unsigned long finish_depth_computation(
-	struct commit_list **list,
-	struct possible_tag *best)
-{
-	unsigned long seen_commits = 0;
-	while (*list) {
-		struct commit *c = pop_commit(list);
-		struct commit_list *parents = c->parents;
-		seen_commits++;
-		if (c->object.flags & best->flag_within) {
-			struct commit_list *a = *list;
-			while (a) {
-				struct commit *i = a->item;
-				if (!(i->object.flags & best->flag_within))
-					break;
-				a = a->next;
-			}
-			if (!a)
-				break;
-		} else
-			best->depth++;
-		while (parents) {
-			struct commit *p = parents->item;
-			parse_commit(p);
-			if (!(p->object.flags & SEEN))
-				insert_by_date(p, list);
-			p->object.flags |= c->object.flags;
-			parents = parents->next;
-		}
-	}
-	return seen_commits;
-}
-
 static void display_name(struct commit_name *n)
 {
 	if (n->prio == 2 && !n->tag) {
@@ -231,7 +198,6 @@ static void describe(const char *arg, int last_one)
 	struct commit_name *n;
 	struct possible_tag all_matches[MAX_TAGS];
 	unsigned int match_cnt = 0, annotated_cnt = 0, cur_match;
-	unsigned long seen_commits = 0;
 	unsigned int unannotated_cnt = 0;
 
 	if (get_sha1(arg, sha1))
@@ -262,10 +228,11 @@ static void describe(const char *arg, int last_one)
 	list = NULL;
 	cmit->object.flags = SEEN;
 	commit_list_insert(cmit, &list);
+	list->depth = 0;
 	while (list) {
+		unsigned long depth = list->depth;
 		struct commit *c = pop_commit(&list);
 		struct commit_list *parents = c->parents;
-		seen_commits++;
 		n = c->util;
 		if (n) {
 			if (!tags && !all && n->prio < 2) {
@@ -273,7 +240,7 @@ static void describe(const char *arg, int last_one)
 			} else if (match_cnt < max_candidates) {
 				struct possible_tag *t = &all_matches[match_cnt++];
 				t->name = n;
-				t->depth = seen_commits - 1;
+				t->depth = depth;
 				t->flag_within = 1u << match_cnt;
 				t->found_order = match_cnt;
 				c->object.flags |= t->flag_within;
@@ -285,11 +252,6 @@ static void describe(const char *arg, int last_one)
 				break;
 			}
 		}
-		for (cur_match = 0; cur_match < match_cnt; cur_match++) {
-			struct possible_tag *t = &all_matches[cur_match];
-			if (!(c->object.flags & t->flag_within))
-				t->depth++;
-		}
 		if (annotated_cnt && !list) {
 			if (debug)
 				fprintf(stderr, "finished search at %s\n",
@@ -299,8 +261,10 @@ static void describe(const char *arg, int last_one)
 		while (parents) {
 			struct commit *p = parents->item;
 			parse_commit(p);
-			if (!(p->object.flags & SEEN))
-				insert_by_date(p, &list);
+			if (!(p->object.flags & SEEN)) {
+				struct commit_list *cl = insert_by_date(p, &list);
+				cl->depth = depth + 1;
+			}
 			p->object.flags |= c->object.flags;
 			parents = parents->next;
 		}
@@ -329,9 +293,7 @@ static void describe(const char *arg, int last_one)
 
 	if (gave_up_on) {
 		insert_by_date(gave_up_on, &list);
-		seen_commits--;
 	}
-	seen_commits += finish_depth_computation(&list, &all_matches[0]);
 	free_commit_list(list);
 
 	if (debug) {
@@ -341,7 +303,6 @@ static void describe(const char *arg, int last_one)
 				prio_names[t->name->prio],
 				t->depth, t->name->path);
 		}
-		fprintf(stderr, "traversed %lu commits\n", seen_commits);
 		if (gave_up_on) {
 			fprintf(stderr,
 				"more than %i tags found; listed %i most recent\n"
diff --git a/commit.h b/commit.h
index a3618f8..6493606 100644
--- a/commit.h
+++ b/commit.h
@@ -8,6 +8,7 @@
 
 struct commit_list {
 	struct commit *item;
+	unsigned long depth;
 	struct commit_list *next;
 };
 
