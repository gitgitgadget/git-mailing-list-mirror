From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: path limiting broken
Date: Sun, 16 Apr 2006 09:06:28 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604160850230.3701@g5.osdl.org>
References: <Pine.LNX.4.63.0604161411120.15345@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 16 18:06:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FV9m0-0003rI-36
	for gcvg-git@gmane.org; Sun, 16 Apr 2006 18:06:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbWDPQGd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 16 Apr 2006 12:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750745AbWDPQGd
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Apr 2006 12:06:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25311 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750739AbWDPQGd (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Apr 2006 12:06:33 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3GG6StH003790
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 16 Apr 2006 09:06:29 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3GG6SZB008836;
	Sun, 16 Apr 2006 09:06:28 -0700
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0604161411120.15345@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18790>



On Sun, 16 Apr 2006, Johannes Schindelin wrote:
> 
> I am not intelligent enough to find out why there are three revisions 
> which get culled.
> 
> Ideas?

Path limiting by default looks at all parents of a merge, and if any of 
them is identical to the child (within the path limiter), it will pick 
_that_ parent, and that parent only, and drop all other parents.

(If there are multiple identical parents, it will pick the first one).

For example, if you do

		 HEAD
		   |
		   a
		  / \
		 b   c
		 |  /|
		 | / d
		 |/  |
		 e   f
		 |  /
		 g /
		 |/
		 h

and the file was modified in commit "b" and nowhere else, then think about 
what the final history should look like.. Since it was modified in "b", 
it's going to be the same in "a" and "b", so the path limiting will 
totally drop the whole "c" subtree, and will only ever look at the tree 
a->b->e->g->h.

After that, it will simplify the history by dropping commits that don't 
change the path, and the whole history will end up being just "b".

Which is exactly what you want.

Now, realize that if the exact _same_ change is done in "f", the same 
thing will happen. "f" will never be shown, because "f" simply isn't 
interesting. We picked up the same change in "b", and while the merge "a" 
had _both_ parents identical in the file, it would pick only the first 
one. So we'll never even _look_ at "f".

Now, this is _important_. Pruning merges is really fundamental to giving a 
reasonable file history, and not just a performance optimization. If the 
same change came from two branches, we really don't care who did it: we'll 
hit _one_ of the changes even after pruning. But yes, it could miss the 
other one.

Here's a patch to show what an unpruned history ends up looking like.

With this patch applied, try the following:

	gitk -- ls-tree.c &
	gitk --no-prune-merges -- ls-tree.c &

and compare the two. You'll see _immediately_ why I think merge pruning is 
not just a good idea, it's something we _have_ to do.

		Linus
----
diff --git a/revision.c b/revision.c
index 0505f3f..25338b6 100644
--- a/revision.c
+++ b/revision.c
@@ -291,7 +291,7 @@ static void try_to_simplify_commit(struc
 		parse_commit(p);
 		switch (rev_compare_tree(revs, p->tree, commit->tree)) {
 		case REV_TREE_SAME:
-			if (p->object.flags & UNINTERESTING) {
+			if (revs->no_merge_pruning || (p->object.flags & UNINTERESTING)) {
 				/* Even if a merge with an uninteresting
 				 * side branch brought the entire change
 				 * we are interested in, we do not want
@@ -640,6 +640,10 @@ int setup_revisions(int argc, const char
 				revs->unpacked = 1;
 				continue;
 			}
+			if (!strcmp(arg, "--no-prune-merges")) {
+				revs->no_merge_pruning = 1;
+				continue;
+			}
 			*unrecognized++ = arg;
 			left++;
 			continue;
diff --git a/revision.h b/revision.h
index 8970b57..a116305 100644
--- a/revision.h
+++ b/revision.h
@@ -26,6 +26,7 @@ struct rev_info {
 	/* Traversal flags */
 	unsigned int	dense:1,
 			no_merges:1,
+			no_merge_pruning:1,
 			remove_empty_trees:1,
 			lifo:1,
 			topo_order:1,
