From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: detecting cycles in Git's commit graph
Date: Sun, 3 May 2009 13:36:18 +0200
Message-ID: <20090503113618.GA27798@cuci.nl>
References: <20090430191857.GA55192@ginosko.grantstreet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Hendricks <michael@ndrix.org>
X-From: git-owner@vger.kernel.org Sun May 03 13:46:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0a9B-00034h-CM
	for gcvg-git-2@gmane.org; Sun, 03 May 2009 13:46:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754887AbZECLqI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 May 2009 07:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754600AbZECLqG
	(ORCPT <rfc822;git-outgoing>); Sun, 3 May 2009 07:46:06 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:57514 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754421AbZECLqF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 May 2009 07:46:05 -0400
X-Greylist: delayed 577 seconds by postgrey-1.27 at vger.kernel.org; Sun, 03 May 2009 07:46:05 EDT
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 45FD55421; Sun,  3 May 2009 13:36:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090430191857.GA55192@ginosko.grantstreet.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118173>

Michael Hendricks wrote:
>Are there any tools for detecting cycles in the commit graph which
>have been caused by grafts?  I thought 'git fsck' might do it, but it
>doesn't seem to.

I submitted this patch some time ago, it didn't make it in.  It doesn't really
cost any performance (the extra overhead is lost in the cache-misses from
main memory).  I use it myself to quickly check for cyclic references.
It doesn't tell you where you went wrong, it just checks the specified
parts of the repository for circular references.

commit 0ab90c05f2255a66c1f71f35e2532dca6947fa7e
Author: Stephen R. van den Berg <srb@cuci.nl>
Date:   Thu Apr 3 06:48:38 2008 +0200

    Check for circular references causing 'lost' nodes
    
    The most likely cause for circular references are bad entries in the
    grafts file; since basically noone tells you where you went wrong, it
    can be a bit puzzling to find out that part of your tree goes dark
    sometimes, depending on which tool/options you pick to walk the
    commit-tree (most notably, things go wrong when using --topo-order even
    though things *seem* allright without that option).
    
    Signed-off-by: Stephen R. van den Berg <srb@cuci.nl>

diff --git a/commit.c b/commit.c
index aa3b35b..523bb01 100644
--- a/commit.c
+++ b/commit.c
@@ -428,6 +428,7 @@ void sort_in_topological_order(struct commit_list ** list, int lifo)
 	struct commit_list *next, *orig = *list;
 	struct commit_list *work, **insert;
 	struct commit_list **pptr;
+	int nelements = 0;
 
 	if (!orig)
 		return;
@@ -437,6 +438,7 @@ void sort_in_topological_order(struct commit_list ** list, int lifo)
 	for (next = orig; next; next = next->next) {
 		struct commit *commit = next->item;
 		commit->indegree = 1;
+		nelements++;
 	}
 
 	/* update the indegree */
@@ -507,7 +509,12 @@ void sort_in_topological_order(struct commit_list ** list, int lifo)
 		commit->indegree = 0;
 		*pptr = work_item;
 		pptr = &work_item->next;
+		nelements--;
 	}
+	if (nelements)
+		fprintf(stderr,
+		 "Circular references resulting in %d suppressed nodes\n",
+		 nelements);
 }
 
 /* merge-base stuff */
-- 
Sincerely,
           Stephen R. van den Berg.
"Hence we are back to stenography..."
"Is that shorthand for steganography?"
