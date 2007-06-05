From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add git-filter-branch
Date: Tue, 5 Jun 2007 16:58:13 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706051537360.4046@racer.site>
References: <Pine.LNX.4.64.0706030129110.4046@racer.site> <4663BCDA.F1BADDD8@eudaptics.com>
  <Pine.LNX.4.64.0706041711500.4046@racer.site> <46643F2D.7C896CBC@eudaptics.com>
 <Pine.LNX.4.64.0706041850350.4046@racer.site> <46650A58.4934C07C@eudaptics.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Johannes Sixt <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Tue Jun 05 18:00:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvbSV-0000QP-D4
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 18:00:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756168AbXFEQAW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jun 2007 12:00:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750837AbXFEQAW
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jun 2007 12:00:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:53980 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756168AbXFEQAV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2007 12:00:21 -0400
Received: (qmail invoked by alias); 05 Jun 2007 16:00:19 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp058) with SMTP; 05 Jun 2007 18:00:19 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/gvKpYzqvgLJhdDzTGD4a3SjUhymX8R0EICRKClK
	6UGZkxPbMnf6Y2
X-X-Sender: gene099@racer.site
In-Reply-To: <46650A58.4934C07C@eudaptics.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49201>

Hi,

On Tue, 5 Jun 2007, Johannes Sixt wrote:

> Johannes Schindelin wrote:
> > On Mon, 4 Jun 2007, Johannes Sixt wrote:
> > > But this makes only sense if you have a linear history. Consider this
> > > history, where you want to rewrite the commits that are only on branch
> > > 'next':
> > >
> > > --A--B--C--D--E--F--G--H       <- master
> > >    \  \  \  \  \  \  \  \
> > >     X--o--o--o--o--o--o--o--o  <- next
> > >
> > > How would you go about with the current calling convention?
> > 
> > Are you actually sure that this scenario makes sense? When is the last
> > time you wanted to filter a branch?
> 
> Oh, this makes a lot of sense. For example after I've imported a CVS
> repository I had installed grafts for a number of merges that were made
> in CVS (but we all know that CVS doesn't record them, so I did that
> manually this way). That would be the merge commits in 'next' of the
> example above. Now a simple
> 
>    git filter-branch -k master new-next
> 
> could "implant" the grafts into the commits. In this scenario I don't
> need to rewrite 'master' because I know in advance that nothing would
> actually be rewritten.
> 
> (Since 'master' was about 8000 commits I really didn't want to wait
> until the no-ops would be completed, so I did it by actually fixing
> cg-admin-rewritehist to not complain about the unmapped parents.)

Okay, then. Are you okay with keeping the same options? (See proposed 
patch below.)

Just out of curiousity, do you have any timing data?

Ciao,
Dscho

-- snipsnap --
[PATCH] filter-branch: fix behaviour of '-k'

The option '-k' says that the given commit and _all_ of its ancestors
are kept as-is.

However, if a to-be-rewritten commit branched from an ancestor of an
ancestor of a commit given with '-k', filter-branch would fail.

Example:

	A - B
	  \
	    C

If filter-branch was called with '-k B -s C', it would actually keep
B (and A as its parent), but would rewrite C, and its parent.

Noticed by Johannes Sixt.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-filter-branch.sh     |   29 +++++++++++++++++------------
 t/t7003-filter-branch.sh |    9 +++++++++
 2 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 0c8a7df..6807782 100644
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -327,11 +327,6 @@ ret=0
 
 mkdir ../map # map old->new commit ids for rewriting parents
 
-# seed with identity mappings for the parents where we start off
-for commit in $unchanged; do
-	echo $commit > ../map/$commit
-done
-
 git-rev-list --reverse --topo-order $srcbranch --not $unchanged >../revs
 commits=$(cat ../revs | wc -l | tr -d " ")
 
@@ -372,7 +367,8 @@ while read commit; do
 				parentstr="$parentstr -p $reparent"
 			done
 		else
-			die "assertion failed: parent $parent for commit $commit not found in rewritten ones"
+			# if it was not rewritten, take the original
+			parentstr="$parentstr -p $parent"
 		fi
 	done
 	if [ "$filter_parent" ]; then
@@ -385,12 +381,21 @@ while read commit; do
 		tee ../map/$commit
 done <../revs
 
-git-update-ref refs/heads/"$dstbranch" $(head -n 1 ../map/$(tail -n 1 ../revs))
-if [ "$(cat ../map/$(tail -n 1 ../revs) | wc -l)" -gt 1 ]; then
-	echo "WARNING: Your commit filter caused the head commit to expand to several rewritten commits. Only the first such commit was recorded as the current $dstbranch head but you will need to resolve the situation now (probably by manually merging the other commits). These are all the commits:" >&2
-	sed 's/^/	/' ../map/$(tail -n 1 ../revs) >&2
-	ret=1
-fi
+src_head=$(tail -n 1 ../revs)
+target_head=$(head -n 1 ../map/$src_head)
+case "$target_head" in
+'')
+	echo Nothing rewritten
+	;;
+*)
+	git-update-ref refs/heads/"$dstbranch" $target_head
+	if [ $(cat ../map/$src_head | wc -l) -gt 1 ]; then
+		echo "WARNING: Your commit filter caused the head commit to expand to several rewritten commits. Only the first such commit was recorded as the current $dstbranch head but you will need to resolve the situation now (probably by manually merging the other commits). These are all the commits:" >&2
+		sed 's/^/	/' ../map/$src_head >&2
+		ret=1
+	fi
+	;;
+esac
 
 if [ "$filter_tag_name" ]; then
 	git-for-each-ref --format='%(objectname) %(objecttype) %(refname)' refs/tags |
diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index 9a4dae4..520963a 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -44,4 +44,13 @@ test_expect_success 'test that the file was renamed' '
 	test d = $(git show H3:doh)
 '
 
+git tag oldD H3~4
+test_expect_success 'rewrite one branch, keeping a side branch' '
+	git-filter-branch --tree-filter "mv b boh || :" -k D -s oldD modD
+'
+
+test_expect_success 'common ancestor is still common (unchanged)' '
+	test "$(git-merge-base modD D)" = "$(git-rev-parse B)"
+'
+
 test_done
-- 
1.5.2.1.2627.g8eec-dirty
