From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/2] Optimize the two-way merge of git-read-tree too
Date: Sat, 11 Aug 2007 02:17:07 -0700
Message-ID: <7vtzr6mnvw.fsf@assigned-by-dhcp.cox.net>
References: <alpine.LFD.0.999.0708101213560.30176@woody.linux-foundation.or g>
	<alpine.LFD.0.999.0708101216000.30176@woody.linux-foundation.org>
	<alpine.LFD.0.999.0708101224110.30176@woody.linux-foundation.org>
	<alpine.LFD.0.999.0708101240200.30176@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Aug 11 11:17:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJn6M-0004Wb-3q
	for gcvg-git@gmane.org; Sat, 11 Aug 2007 11:17:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759532AbXHKJRQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Aug 2007 05:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753683AbXHKJRP
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Aug 2007 05:17:15 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:58432 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759511AbXHKJRI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Aug 2007 05:17:08 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070811091708.JIVV2095.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Sat, 11 Aug 2007 05:17:08 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id aZH71X00F1kojtg0000000; Sat, 11 Aug 2007 05:17:07 -0400
In-Reply-To: <alpine.LFD.0.999.0708101240200.30176@woody.linux-foundation.org>
	(Linus Torvalds's message of "Fri, 10 Aug 2007 12:53:51 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55595>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> And as mentioned, the three-way case *should* be as trivial as the 
> following. It passes all the tests, and I verified that a conflicting 
> merge in the 100,000 file horror-case merged correctly (with the conflict 
> markers) in 0.687 seconds with this, so it works, but I'm lazy and 
> somebody else should double-check it.
>
> (Again - *without* this patch, the merge took 8.355 seconds, so this patch 
> really does make a huge difference for merge performance with lots and 
> lots of files, and we're not talking percentages, we're talking 
> orders-of-magnitude differences!)

Hmph, this might make what I was hoping to find time to do more
or less unnecessary.

But here it is anyway.

I wanted to speed up the three-way merges.  The assumption is
that when you do a merge, you are not in the middle of your own
messy work.  It is either while you are in a merge binge,
pulling from one subsystem lieutenant after another, or perhaps
applying patchbombs from people.  In either case, you would
start your merge with a clean index that >99% matches the HEAD,
after writing your index out as a tree.

Then, the new 3-way read-tree (or unpack_trees) would go like
this.

First, we scan the index and find locally modified paths;
invalidate cache-tree by calling cache_tree_invalidate_path()
for such paths.  The expectation is that you will still have
largely usable cache-tree after this step.

The main part of the merge will be done by using tree_desc based
traversal that walks over three (ancestor, mine and theirs)
trees, instead of the current unpack_trees() that iterates
mainly over the index entries.

(A) The three trees all may have a subtree at the same path, or
    the one that does not have a tree where others have does not
    have a blob at the path either (i.e. the subtree is missing
    from the tree without a D/F conflict).  If the usual 3-way
    tree level merge rule (one side changes while the other side
    does not do anything, or both sides change to the same) can
    be applied, and if the cache tree entry for that subtree is
    valid and matches our tree, then...

    - we know the working tree for that entire subdirectory is
      also clean because of the earlier invalidation;

    - we can simply follow the tree level merge without ever
      looking at individual paths contained in the subtree.

(B) If the precondition of (A) does not hold, we recurse into
    the subtree, and perform per-path 3-way merge, like the
    current unpack_trees() does.

If your merge does not involve anything in large subdirectories,
e.g., include/, arch/, or drivers/, this would allow you to skip
quite a lot of per-path merge computation by doing comparison of
four (tree entries and cache-tree) tree object names (the three
subdirectories have about 6k paths each, so this could be a huge
win).

Another optimization I was hoping to do was "git diff --cached",
which is unrelated to the recent change to use read_tree().
Instead of reading the tree into the stage #1 of the same index,
we could walk the tree and skip the subtree whose cache-tree
matches the entry from the tree.  This would have the same scale
of performance improvement opportunity.
