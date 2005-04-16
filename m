From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Re: Re: write-tree is pasky-0.4
Date: Fri, 15 Apr 2005 21:13:05 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504152029410.30848-100000@iabervon.org>
References: <Pine.LNX.4.58.0504151709180.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@ucw.cz>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 03:09:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMboW-0007a5-2T
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 03:09:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262510AbVDPBNK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Apr 2005 21:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262504AbVDPBNK
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Apr 2005 21:13:10 -0400
Received: from iabervon.org ([66.92.72.58]:20996 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262510AbVDPBNC (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Apr 2005 21:13:02 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DMbrt-0000rJ-00; Fri, 15 Apr 2005 21:13:05 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504151709180.7211@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 15 Apr 2005, Linus Torvalds wrote:

> I think I've explained my name tracking worries.  When it comes to "how to 
> merge", there's three issues:
> 
>  - we do commonly have merge clashes where both trees have applied the 
>    exact same patch. That should merge perfectly well using the 3-way
>    merge from a common parent that Junio has, but not your current "bring
>    patches forward" kind of strategy.

I think 3-way merge is probably the best starting point, but I think that
there might be value in being able to identify the commits of each side
involved in a conflict. I think this would help with cases where both
sides pick up an identical patch, and then each side makes a further
change to a different part of the changed region (you find out that the
other guy's change was supposed to follow the patch, and don't conflict
with it).

>  - I _do_ actually sometimes merge with dirty state in my working 
>    directory, which is why I want the merge to take place in a separate 
>    (and temporary) directory, which allows for a failed merge without 
>    having any major cleanup. If the merge fails, it's not a big deal, and 
>    I can just blow the merge directory away without losing the work I had 
>    in my "real" working directory.

Is there some reason you don't commit before merging? All of the current
merge theory seems to want to merge two commits, using the information git
keeps about them. It should be cheap to get a new clean working directory
to merge in, too, particularly if we add a cache of hardlinkable expanded
blobs.

>  - reliability. I care much less for "clever" than I care for "guaranteed 
>    to never do the wrong thing". If I have to fix up some stuff by hand, 
>    I'll happily do so. But if I can't trust the merge and have to _check_ 
>    things by hand afterwards, that will make me leery of the merges, and
>    _that_ is bad.
> 
> The third point is why I'm going to the ultra-conservative "three-way 
> merge from the common parent". It's not fancy, but it's something I feel 
> comfortable with as a merge strategy. For example, arch (and in particular 
> darcs) seems to want to try to be "clever" about the merges, and I'd 
> always live in fear. 

How much do you care about the situation where there is no best common
ancestor (which can happen if you're merging two main lines, each of which
has merged with both of a pair of minor trees)? I think that arch is even
more conservative, in that it doesn't look for a common ancestor, and
reports conflicts whenever changes overlap at all. Of course, reliability
by virtue of never working without help is not a big win over living in
fear; you always have to check over it, not because you're afraid, but
because it needs you to.

> And, finally, there's obviously performance. I _think_ a normal merge with
> nary a conflict and just a few tens of files changed should be possible in
> a second. I realize that sounds crazy to some people, but I think it's
> entirely doable. Half of that is writing the new tree out (that is a
> relative costly op due to the compression). The other half is the "work".

I think that the time spent on I/O will be overwhelmed by the time spent
issuing the command at that rate. It might matter if you start getting
into merging lots of things at once, but that's more like a minute for a
merge group with 600 changes rather than a second per merge; we could
potentially save a lot of time based of having a bunch of information left
over from the previous merge when starting merge number 2. So 15 seconds
plus half a second per merge might be better than a second per merge in
the case that matters.

	-Daniel
*This .sig left intentionally blank*

