From: Kevin Bracey <kevin@bracey.fi>
Subject: Re: [RFC/PATCH] Make --full-history consider more merges
Date: Tue, 23 Apr 2013 19:35:32 +0300
Message-ID: <5176B854.2000707@bracey.fi>
References: <7v4nfcj2kq.fsf@alter.siamese.dyndns.org> <1366658602-12254-1-git-send-email-kevin@bracey.fi> <7vzjwqny64.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 23 18:35:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUgC2-0002E0-9n
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 18:35:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757498Ab3DWQfl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Apr 2013 12:35:41 -0400
Received: from 16.mo3.mail-out.ovh.net ([188.165.56.217]:41631 "EHLO
	mo3.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757291Ab3DWQfi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Apr 2013 12:35:38 -0400
X-Greylist: delayed 75788 seconds by postgrey-1.27 at vger.kernel.org; Tue, 23 Apr 2013 12:35:38 EDT
Received: from mail402.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo3.mail-out.ovh.net (Postfix) with SMTP id E2C36FF9269
	for <git@vger.kernel.org>; Tue, 23 Apr 2013 18:35:35 +0200 (CEST)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 23 Apr 2013 18:36:28 +0200
Received: from 85-23-153-122.bb.dnainternet.fi (HELO ?192.168.1.10?) (kevin@bracey.fi@85.23.153.122)
  by ns0.ovh.net with SMTP; 23 Apr 2013 18:36:26 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.0; WOW64; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
X-Ovh-Mailout: 178.32.228.3 (mo3.mail-out.ovh.net)
In-Reply-To: <7vzjwqny64.fsf@alter.siamese.dyndns.org>
X-Ovh-Tracer-Id: 13297440850227007704
X-Ovh-Remote: 85.23.153.122 (85-23-153-122.bb.dnainternet.fi)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: 0
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrfeekucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecu
X-Spam-Check: DONE|U 0.5/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrfeekucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222189>

On 22/04/2013 22:49, Junio C Hamano wrote:
>
> So in addition to "have some change and there is no same parent"
> case, under _some_ condition we avoid marking a merge not worth
> showing (i.e. TREESAME) if there is any change.
>
> And the condition is !simplify_history and !simplify_merges, which
> would cover --full-history, but I am not sure if requiring
> !simplify_merges is correct.

You're right, it isn't correct. Logically, the test should be for
simplify_history. The original patch was overly cautious about
limiting it to --full-history. And it avoided breaking a test -
specifically t6016.7. simplify_merges() should just be post-
processing "full history with parents" as you say, not changing its
behaviour.

I've dug into this more, and am now fairly confident about my analysis.
I believe the problem arises because TREESAME's definition was
conflated with the default simplification behaviour, unnecessarily.
Merges were defined as TREESAME if they matched ANY parent.

That's fine if simplify_history is set, but then in that case a merge
which is TREESAME to any parent is turned into a normal commit based
on that parent anyway, and that simplified commit is inherently
TREESAME, regardless of how we define TREESAME for merges.

If simplify_history isn't set, and we don't want ancestry, then that
TREESAME definition is problematic. It avoids showing merges that
don't have anything actually new, but does lead to this issue that
"git log -Sxxx --full-history" can't locate a dropped change.

If simplify_history is set, and we do want ancestry, then it doesn't
matter about the TREESAME definition because it shows all merges,
regardless of the TREESAME flag. Thus adding "--parents" to the above
command means it can find it, but only because it drags _every_ merge
into consideration. Should that be necessary?

Futher, if we add simplify_merges, then TREESAME becomes a problem.
After merge simplification, we can be left with a single-parent
commit that doesn't match its parent but is skipped due to its
TREESAME flag being set: it was TREESAME to a parent that got dropped.

I think the correction is that TREESAME for a commit needs to be
redefined to be "this commit matches all its (remaining) parents",
rather than "this commit matches at least 1 of its (remaining)
parents". And when we eliminate parents, we have to check for the
flag changing, but we should have been doing that anyway.

Now, what effect does post-processing have on TREESAME? Parent
rewriting due to elimination of duplicates, and making dense has no
effect, as there we're always replacing a commit with something it
was TREESAME to, so that doesn't affect TREESAMEness of its children.

But reduce_heads() in simplify_merges() can have an effect. In the
example shown in the comment, X may or may not be TREESAME to its
remaining single parent. And test 6016.7 covers one instance of
that - reduce_heads() eliminates branches B and C, because they
didn't touch bar.txt, and the rewritten parents were then ancestors
of the A path. But that that "drop ancestor paths" logic totally
ignores TREESAMEness, and we don't know whether the merge kept
the bar.txt from A, or eliminated it by an "-s ours" take of B.

In the 6016.7 case, the merge was originally marked TREESAME, as it
matched A. When B and C were eliminated, it remained TREESAME, and
this wasn't recalculated. And that happened to be correct in this
case, because the merge was "normal".

If on the other hand, the merge had taken the "old" version B with
"-s ours", or if there had been some other semantic change arising
in the merge, then simplify_merges would still have eliminated
B and C, and left a normal commit differing from parent A, but still
marked TREESAME from having matched B. So that would have wrongly
hidden the merge. Recalculation is already necessary to spot the
"odd" case.

If we redefine TREESAME, then recalculation becomes necessary to
handle the "normal" case - the merge will not initially be TREESAME,
as it differs from B and C. But once B and C are eliminated, we
should then determine that the commit is TREESAME from matching
its remaining parent A. Simplification should only ever "increase"
the sameness, so we can avoid recalculation if TREESAME is already
set. Without this recalculation, 6016.7 fails.

So I believe that if reduce_heads() does eliminate any parents, and
TREESAME wasn't set, then we have to recalculate TREESAME, by
running over the remaining parents. A call to
try_to_simplify_commit() does the job, but it feels hacky, and
obviously it's slow. It would be nice if we could remember
"per-parent TREESAME" flags, and shuffle them when we change
parents, but that could be fiddly.

Also if limit_to_ancestry() did eliminate parents from outside the
ancestry, as per the NEEDSWORK comment, then that would also want
to do the TREESAME recalculation. (And it could conceivably be very
useful, helping pick up only the merges that went against your base
commit).

So, given all that, revised patch below:

---
 revision.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/revision.c b/revision.c
index eb98128..15d2f3b 100644
--- a/revision.c
+++ b/revision.c
@@ -432,7 +432,7 @@ static int rev_same_tree_as_empty(struct rev_info *revs, struct commit *commit)
 static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 {
     struct commit_list **pp, *parent;
-    int tree_changed = 0, tree_same = 0, nth_parent = 0;
+    int tree_changed = 0, nth_parent = 0;

     /*
      * If we don't do pruning, everything is interesting
@@ -474,7 +474,6 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
                 sha1_to_hex(p->object.sha1));
         switch (rev_compare_tree(revs, p, commit)) {
         case REV_TREE_SAME:
-            tree_same = 1;
             if (!revs->simplify_history || (p->object.flags & UNINTERESTING)) {
                 /* Even if a merge with an uninteresting
                  * side branch brought the entire change
@@ -516,7 +515,7 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
         }
         die("bad tree compare for commit %s", sha1_to_hex(commit->object.sha1));
     }
-    if (tree_changed && !tree_same)
+    if (tree_changed)
         return;
     commit->object.flags |= TREESAME;
 }
@@ -2042,9 +2041,19 @@ static struct commit_list **simplify_one(struct rev_info *revs, struct commit *c
      */
     if (1 < cnt) {
         struct commit_list *h = reduce_heads(commit->parents);
+        int orig_cnt = commit_list_count(commit->parents);
         cnt = commit_list_count(h);
         free_commit_list(commit->parents);
         commit->parents = h;
+        if (cnt < orig_cnt && !(commit->object.flags & TREESAME)) {
+            /* Rewrite will likely change the TREESAME state. Eg in
+             * example above, X could be TREESAME or not to its
+             * remaining single parent, depending on how the merge
+             * was resolved - most likely it is now TREESAME, but
+             * it may not be.
+             */
+            try_to_simplify_commit(revs, commit);
+        }
     }

     /*
-- 
1.8.2.255.g39c5835
