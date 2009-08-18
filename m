From: Nicolas Pitre <nico@cam.org>
Subject: Re: Continue git clone after interruption
Date: Tue, 18 Aug 2009 16:01:52 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0908181537360.6044@xanadu.home>
References: <1250509342.2885.13.camel@cf-48>
 <alpine.DEB.1.00.0908171430010.4991@intel-tinevez-2-302>
 <vpqskfphe2k.fsf@bauges.imag.fr> <1250578735.2885.40.camel@cf-48>
 <alpine.LFD.2.00.0908181246470.6044@xanadu.home>
 <m3fxbpneqe.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Tomasz Kontusz <roverorna@gmail.com>, git <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 18 22:02:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdUsg-0000hg-9r
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 22:02:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbZHRUB5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 16:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751132AbZHRUB5
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 16:01:57 -0400
Received: from relais.videotron.ca ([24.201.245.36]:8534 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888AbZHRUB5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 16:01:57 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KOL005MA8GHBI30@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 18 Aug 2009 15:50:41 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <m3fxbpneqe.fsf@localhost.localdomain>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126446>

On Tue, 18 Aug 2009, Jakub Narebski wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > On Tue, 18 Aug 2009, Tomasz Kontusz wrote:
> > 
> > > Ok, so it looks like it's not implementable without some kind of cache
> > > server-side, so the server would know what the pack it was sending
> > > looked like.
> > > But here's my idea: make server send objects in different order (the
> > > newest commit + whatever it points to first, then next one,then
> > > another...). Then it would be possible to look at what we got, tell
> > > server we have nothing, and want [the newest commit that was not
> > > complete]. I know the reason why it is sorted the way it is, but I think
> > > that the way data is stored after clone is clients problem, so the
> > > client should reorganize packs the way it wants.
> > 
> > That won't buy you much.  You should realize that a pack is made of:
> > 
> > 1) Commit objects.  Yes they're all put together at the front of the pack,
> >    but they roughly are the equivalent of:
> > 
> > 	git log --pretty=raw | gzip | wc -c
> > 
> >    For the Linux repo as of now that is around 32 MB.
> 
> For my clone of Git repository this gives 3.8 MB
>  
> > 2) Tree and blob objects.  Those are the bulk of the content for the top 
> >    commit.  The top commit is usually not delta compressed because we 
> >    want fast access to the top commit, and that is used as the base for 
> >    further delta compression for older commits.  So the very first 
> >    commit is whole at the front of the pack right after the commit 
> >    objects.  you can estimate the size of this data with:
> > 
> > 	git archive --format=tar HEAD | gzip | wc -c
> > 
> >    On the same Linux repo this is currently 75 MB.
> 
> On the same Git repository this gives 2.5 MB

Interesting to see that the commit history is larger than the latest 
source tree.  Probably that would be the same with the Linux kernel as 
well if all versions since the beginning with adequate commit logs were 
included in the repo.

> > 3) Delta objects.  Those are making the rest of the pack, plus a couple 
> >    tree/blob objects that were not found in the top commit and are 
> >    different enough from any object in that top commit not to be 
> >    represented as deltas.  Still, the majority of objects for all the 
> >    remaining commits are delta objects.
> 
> You forgot that delta chains are bound by pack.depth limit, which
> defaults to 50.  You would have then additional full objects.

Sure, but that's probably not significant.  the delta chain depth is 
limited, but not the width.  A given base object can have unlimited 
delta "children", and so on at each depth level.

> The single packfile for this (just gc'ed) Git repository is 37 MB.
> Much more than 3.8 MB + 2.5 MB = 6.3 MB.

What I'm saying is that most of that 37 MB - 6.3 MB = 31 MB is likely to 
be occupied by deltas.

> [cut]
> 
> There is another way which we can go to implement resumable clone.
> Let's git first try to clone whole repository (single pack; BTW what
> happens if this pack is larger than file size limit for given
> filesystem?).

We currently fail.  Seems that no one ever had a problem with that so 
far. We'd have to split the pack stream into multiple packs on the 
receiving end.  But frankly, if you have a repository large enough to 
bust your filesystem's file size limit then maybe you should seriously 
reconsider your choice of development environment.

> If it fails, client ask first for first half of of
> repository (half as in bisect, but it is server that has to calculate
> it).  If it downloads, it will ask server for the rest of repository.
> If it fails, it would reduce size in half again, and ask about 1/4 of
> repository in packfile first.

Problem people with slow links have won't be helped at all with this.  
What if the network connection gets broken only after 49% of the 
transfer and that took 3 hours to download?  You'll attempt a 25% size 
transfer which would take 1.5 hour despite the fact that you already 
spent that much time downloading that first 1/4 of the repository 
already.  And yet what if you're unlucky and now the network craps on 
you after 23% of that second attempt?

I think it is better to "prime" the repository with the content of the 
top commit in the most straight forward manner using git-archive which 
has the potential to be fully restartable at any point with little 
complexity on the server side.


Nicolas
