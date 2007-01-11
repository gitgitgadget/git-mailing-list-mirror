From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's cooking in git.git (topics)
Date: Thu, 11 Jan 2007 01:38:50 -0800
Message-ID: <7v1wm16gyd.fsf@assigned-by-dhcp.cox.net>
References: <7vr6u3cmsi.fsf@assigned-by-dhcp.cox.net>
	<7v3b6i75i5.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0701102241230.4964@xanadu.home>
	<20070111080035.GA28222@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 11 10:39:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4wOt-00086e-Fq
	for gcvg-git@gmane.org; Thu, 11 Jan 2007 10:39:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965353AbXAKJjI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 04:39:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965336AbXAKJjI
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 04:39:08 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:42976 "EHLO
	fed1rmmtao06.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965356AbXAKJjH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 04:39:07 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070111093906.SVG2628.fed1rmmtao06.cox.net@fed1rmimpo01.cox.net>;
          Thu, 11 Jan 2007 04:39:06 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 9leE1W00M1kojtg0000000; Thu, 11 Jan 2007 04:38:15 -0500
To: "Shawn O. Pearce" <spearce@spearce.org>
In-Reply-To: <20070111080035.GA28222@spearce.org> (Shawn O. Pearce's message
	of "Thu, 11 Jan 2007 03:00:36 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36564>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> There is almost no additional penalty for a simple strand of pearls
> with the tag placed along that strand; only one possible tag will be
> found.  But my code does an unnecessary revision list in this case.
>
> Where we really get hit is the large number of possible tags.  The
> master branch is turning up 14 tags, some dating back to v1.4.1-rc1.
> I do try to abort the revision list as soon as one of those tags
> cannot give me a better selection than the one I have currently,
> but I still had to generate a revision list to reach that point.

I looked at the algorithm, and after scratching my head for a
while, I finally found it sane (modulo leaks, which I think I
fixed with the attached patch).

One minor problem that you inherited from the original algorithm
is the name priority.  If you have an annotated tag A and a
lightweight tag b, and ask "git describe --tags" in this graph:

    ---o---o---o---o---x
           A   b

you would still want to describe 'x' with A, not b.
Unfortunately you don't (and the original doesn't either).

I think this is probably easy to solve in the loop that finds
"all_matches"; once you hit an annotated tag, your traversal
should stop in any case.  But if you were asked for --tags, and
if your "initialized" piece did find both lightweight and
annotated tags, you do not stop when you saw a lightweight one,
but keep looking for an annotated one, ignoring any further
lightweight ones.

Another thought.  I often do "git describe maint master next
pu", and I see an opportunity for optimizing for such a
multi-ref query.  Once you traversed the commits in
"all_matches" loop, you know which strands of pearls are
reachable to what tags, so you could hang that information
somewhere (perhaps ->utils) in each commit.  But I think
optimizing for a multi-ref query is probably not worth it.


-- >8 --
[PATCH] plug a few leaks in revision walking used in describe.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 builtin-describe.c |    1 +
 revision.c         |    8 +++++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/builtin-describe.c b/builtin-describe.c
index d65c7d2..a8c98ce 100644
--- a/builtin-describe.c
+++ b/builtin-describe.c
@@ -183,6 +183,7 @@ static void describe(const char *arg, int last_one)
 			cur_match->depth++;
 		if (!min_match || cur_match->depth < min_match->depth)
 			min_match = cur_match;
+		free_commit_list(revs.commits);
 	}
 	printf("%s-g%s\n", min_match->name->path,
 		   find_unique_abbrev(cmit->object.sha1, abbrev));
diff --git a/revision.c b/revision.c
index 1e3b29a..f2ddd95 100644
--- a/revision.c
+++ b/revision.c
@@ -1121,21 +1121,23 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 void prepare_revision_walk(struct rev_info *revs)
 {
 	int nr = revs->pending.nr;
-	struct object_array_entry *list = revs->pending.objects;
+	struct object_array_entry *e, *list;
 
+	e = list = revs->pending.objects;
 	revs->pending.nr = 0;
 	revs->pending.alloc = 0;
 	revs->pending.objects = NULL;
 	while (--nr >= 0) {
-		struct commit *commit = handle_commit(revs, list->item, list->name);
+		struct commit *commit = handle_commit(revs, e->item, e->name);
 		if (commit) {
 			if (!(commit->object.flags & SEEN)) {
 				commit->object.flags |= SEEN;
 				insert_by_date(commit, &revs->commits);
 			}
 		}
-		list++;
+		e++;
 	}
+	free(list);
 
 	if (revs->no_walk)
 		return;
