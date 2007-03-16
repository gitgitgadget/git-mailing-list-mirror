From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: tree sorting..
Date: Fri, 16 Mar 2007 19:13:29 -0400
Message-ID: <20070316231329.GA4508@spearce.org>
References: <Pine.LNX.4.64.0703160941290.3816@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Mar 17 00:13:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSLcJ-00024I-53
	for gcvg-git@gmane.org; Sat, 17 Mar 2007 00:13:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992454AbXCPXNf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Mar 2007 19:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992453AbXCPXNf
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 19:13:35 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:41644 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992454AbXCPXNe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2007 19:13:34 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HSLbu-0000Fq-44; Fri, 16 Mar 2007 19:13:22 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 35CF520FBAE; Fri, 16 Mar 2007 19:13:30 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0703160941290.3816@woody.linux-foundation.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42405>

[adding in the list]
Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On irc:
> 
>   spearce: personally the utf-8 commit encoding mess is less of a mess 
> 	then the "lets sort trees with / after their name, but not store 
> 	them that way!".
> 
> umm, we *do* store them that way, so I'm a bit confused?

Sorry, hasty IRC messages don't always read very well.  What I was
trying to say was that the decision to sort entries in the tree
the way that they are sorted is an annoying problem.

Entries in a tree must be unique by their name; that is I cannot have
"foo" as both a file and as a subtree.  An excellent constraint
to have.  But the position of the entry "foo" is different for a
file than for a subtree, as the subtree "foo" is sorted as though
it were "foo/" while the file "foo" is sorted by just "foo".

So there's additional complexity imposed.  I cannot just binary
search a tree and locate "foo", as "foo" could appear at one of two
different positions in that tree.  Sure I might know that the user
is asking for "foo/" (as the input was "foo/bar"); but what if I
search for "foo/" and in this particular tree there is a "foo",
but its a file?  I cannot conclude that foo doesn't exist here
without searching *again* for "foo" on its own.  Likewise if the
user asks for "foo" (no trailing slash).


The entire reason this happened is hysterical raisins.  Your first
draft of Git had trees as one flat structure, sorting complete
paths by their memcmp result.  Which is dead simple and worked.

But folks pointed out it would be more scalable to store each
directory on its own, as not every directory changes on each commit.
So you split the trees up in the object database, but you left the
index as-is.

This meant that as you were walking the index you found the subtree
"foo" where "foo/" appears, not where "foo" appears.  In my opinion
it is a *BUG* that you did not correct the sorting to remove the
trailing slash when you split the index down into individual tree
objects.

Now we are stuck with it.

And that flat index?  It worked well to get us started, sure, but
the whole cache_tree thing that Junio wedged in was specifically to
address the scability of the index on larger repositories.  We don't
need to recreate (or examine) trees for parts that didn't change.

Wasn't that the original scability argument as to *why* you broke
out the tree objects in the ODB apart?  How was the index exempt
from that?

Basically you cut a corner way back by not also splitting the
index up by subtree when you split the ODB "tree" up by subtree,
and we've been paying for it ever since.


I'm personally annoyed about it because I've fought this problem
several times.  In jgit (my Java Git implementation) I can't do a
simple binary search on a tree's contents, because of the issues
stated above.  In git-fast-import I can't do a simple binary search,
because of the issues stated above.  There I also have to resort a
tree *twice* to generate the delta, because a path name might have
changed type and thus changed positions within the tree.

Last night we found a bug where you can't do a two-head merge with
`read-tree -m` when "A" is a subdirectory in this branch but is a
file in the branch you are switching to.  This is difficult to fix
because within the index we cannot simply do a type comparsion of
"A" and "A" to see if they are the same...  Junio is trying to
patch around it, but it ain't pretty.

With the new pack v4 concept of a 6 byte fixed-width tree record,
we could actually do binary search within a tree, rather than
linear search.  But again, its uh, more difficult than it probably
should be.


We all do things that in hindsight could have been done differently.
I *definately* would rather have the Git we have today, than to
not have one at all.  I'm extremely grateful that you and several
others took time away from Linux kernel hacking to get this project
started, and kept a practical focus throughout, ensuring we would
have a useful tool.

I just get frustrated with it sometimes.  ;-)

-- 
Shawn.
