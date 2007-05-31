From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] always start looking up objects in the last used pack first
Date: Thu, 31 May 2007 11:39:29 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0705311015410.11491@xanadu.home>
References: <alpine.LFD.0.99.0705302152180.11491@xanadu.home>
 <20070531050211.GV7044@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu May 31 17:39:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Htmkg-0002Ca-6a
	for gcvg-git@gmane.org; Thu, 31 May 2007 17:39:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752931AbXEaPjm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 31 May 2007 11:39:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753924AbXEaPjm
	(ORCPT <rfc822;git-outgoing>); Thu, 31 May 2007 11:39:42 -0400
Received: from relais.videotron.ca ([24.201.245.36]:16520 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752931AbXEaPjl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2007 11:39:41 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JIW00HEXWTTLA10@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 31 May 2007 11:39:30 -0400 (EDT)
In-reply-to: <20070531050211.GV7044@spearce.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48812>

On Thu, 31 May 2007, Shawn O. Pearce wrote:

> Nicolas Pitre <nico@cam.org> wrote:
> > 	Pack Sort			w/o this patch	w/ this patch
> > 	-------------------------------------------------------------
> > 	recent objects last		26.4s		20.9s
> > 	recent objects first		24.9s		18.4s
> 
> Looks pretty good.
>  
> > +		next:
> > +		if (p == last_found)
> > +			p = packed_git;
> > +		else
> > +			p = p->next;
> > +		if (p == last_found)
> > +			p = p->next;
> > +	} while (p);
> 
> So if we didn't find the object in the pack that we found the
> last object in, we restart our search with the most recent pack?

Right.

> Why not just go to p->next and loop around?  If we missed in this
> pack and the packs are sorted by recency, wouldn't we want to just
> search the next pack?

Testing shows that with such a strategy the same operation went from 
18.4s to 19.8s.  But this is with split packs resulting from a 
git-repack -a -d --max-pack-size=...

If you search for an object and don't find it in the last used pack, 
that doesn't mean that the object is necessarily in the pack next to the 
last one.  

The object recency order doesn't actually mean object age.  Consider for 
example 3 commits: the first with everything initially created, the 
second commit modifying only half the files, and the third modifying 
only a quarter of the files.  

Object recency order means that the latest commit will see (almost) all 
its objects early and contiguously in the pack stream. The latest commit 
will still reference between 1/4 to 1/2 of the objects that were created 
from the first commit though.

Objects for the middle commit will appear after that, but only those 
that were not referenced by the latest commit.  This means that in this 
example 3/4 of the needed objects for the middle commit will still be 
found early in the pack stream.

And the first commit will see its objects at the end of the pack stream, 
but again only those objects that weren't referenced by younger commits 
already.  Up to 1/2 of those objects needed for the first commit might 
be found in the early portion of the pack stream, or at worst 1/4 in the 
early portion and 1/4 in the mid portion of the pack stream.

If a repack creates split packs more or less according to the commit 
separation above then failure to find an object in the last used pack 
should really continue to scan available packs from the beginning of the 
list.  Merely going on with the next available pack is a bad move in 
this case.

HOWEVER...

If the accumulation of packs is due to multiple fetches/pushes without a 
repack then the situation is somewhat reversed and much less clear.  
Considering the scenario above but with a fetch between commits you'd 
end up with this:

1- a large pack with all objects for the first commit.

2- a pack with only half the objects for the second commit (the other 
   half is still available in pack #1).

3- a pack with only 1/4 of the objects for the latest commit (the rest 
   is shared between pack #1 and pack #2).

Here it is not clear what to do.  Given that the last-used-pack 
heuristic makes such a big difference in the split pack it will 
certainly help a lot in this case too.  But where to go when that 
heuristic fails is unclear.  If you want to favorize speed for latest 
commits then I'd argue that going back to the beginning of the list is 
still the right thing to do.  If you want to have a more balanced 
behavior for all commits (think git-blame) then probably going to the 
pack next to the last used would be the best thing to do in this case as 
younger packs will never contain objects that older commits are 
interested in.

...

Which makes me wonder about a possible incremental improvement to my 
patch: on failure to find an object in the last used pack, the search 
should then start again from the pack containing the commit from which 
this object search is related to.  In the split pack case all commit 
objects will be located in the first pack so nothing will change there.  
In the multiple-fetch case then the search will always reset to packs 
not younger than the commit triggering those object lookups.  Question 
is how to implement that nicely...


Nicolas
