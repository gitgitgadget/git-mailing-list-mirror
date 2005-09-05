From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 0/2] Reorganize read-tree
Date: Sun, 4 Sep 2005 22:55:43 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0509042238420.23242@iabervon.org>
References: <Pine.LNX.4.63.0508302317380.23242@iabervon.org>
 <7virxg6zj3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Mon Sep 05 04:52:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EC75l-0006I0-LR
	for gcvg-git@gmane.org; Mon, 05 Sep 2005 04:52:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018AbVIECvv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Sep 2005 22:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932138AbVIECvv
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Sep 2005 22:51:51 -0400
Received: from iabervon.org ([66.92.72.58]:28179 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1751018AbVIECvv (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Sep 2005 22:51:51 -0400
Received: (qmail 21997 invoked by uid 1000); 4 Sep 2005 22:55:43 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 4 Sep 2005 22:55:43 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7virxg6zj3.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8078>

On Sun, 4 Sep 2005, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > I got mostly done with this before Linus mentioned the possibility of
> > having multiple index entries in the same stage for a single path. I
> > finished it anyway, but I'm not sure that we won't want to know which of
> > the common ancestors contributed which, and, if some of them don't have a
> > path, we wouldn't be able to tell. The other advantages I see to this
> > approach are:
> 
> I've finished reading your patch, after beating it reasonably
> heavily by feeding combinations of nonsense trees to make sure
> it produces the same result as the original implementation.  I
> have not found any regression from the read-tree in "master"
> branch, after you fixed the path ordering issues.

Good.

> > There are various potential refinements, plus removing a bunch of memory
> > leaks, still to do, but I think this is sufficiently close to review.
> 
> I am not so worried about the leaks right now; they are
> something that could be fixed before it hits the "master"
> branch.

Right.

> I like your approach of reading the input trees, along with the
> existing index contents, and re-populating the index one path at
> a time.  It probably is more readable.
> 
> I further think that you can get the best of both worlds, by
> inventing a convention that mode=0 entry means 'this path does
> not exist in this tree'. This would allow you to have multiple
> entries at the same stage and still tell which one came from
> which tree.  Instead of calling fn in unpack_trees(), you could
> make it only unpack the tree into the index, and then after
> unpacking is done, call fn() repeatedly to resolve the resulting
> index. 

I think that almost all of the benefit actually comes from calling fn() in 
unpack_trees() and not putting anything in the index before merging. 
Without that, you need the complex index management and the complicated 
search for DF conflicts. The main point of not reading everything into the 
index before calling fn() on stuff is that the index is actually really 
difficult to deal with in this situation (because you are simultaneously 
moving through it, removing and modifying entries, and searching it for 
conflicts). The improvement in readability comes from not doing this.

	-Daniel
*This .sig left intentionally blank*
