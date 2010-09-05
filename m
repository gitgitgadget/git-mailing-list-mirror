From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: git pack/unpack over bittorrent - works!
Date: Sat, 04 Sep 2010 21:18:16 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1009041107180.19366@xanadu.home>
References: <AANLkTik-w6jWgrt_kwAk2uNGhF_=3tMEpTZs3nyF_zGA@mail.gmail.com>
 <AANLkTinu=RoGfq93d+yjHiQwCt0HXx4YtqfvhXyZdO=F@mail.gmail.com>
 <AANLkTimpE6rf0azHtrz6BFK5d7YojF+G1YuSA1gusSC=@mail.gmail.com>
 <4C7FC3DC.3060907@gmail.com>
 <AANLkTikBnKQJmgOms2wK1+6fCLtHWiWkhuCVMN7kKLXP@mail.gmail.com>
 <alpine.LFD.2.00.1009021249510.19366@xanadu.home>
 <AANLkTinFPxsY6frVnga8u15aovQarfWreBYJfri6ywoK@mail.gmail.com>
 <alpine.LFD.2.00.1009021624170.19366@xanadu.home>
 <B757A854-C7BF-4CBF-9132-91D205344606@mit.edu>
 <7voccezr7m.fsf@alter.siamese.dyndns.org> <20100903183120.GA4887@thunk.org>
 <alpine.LFD.2.00.1009031522590.19366@xanadu.home>
 <04755B03-EE1D-48FA-8894-33AA8E2661C0@mit.edu>
 <alpine.LFD.2.00.1009040040030.19366@xanadu.home>
 <5B5470E5-57E6-48D2-981B-CE77FA43546F@mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Luke Kenneth Casson Leighton <luke.leighton@gmail.com>,
	git <git@vger.kernel.org>
To: Theodore Tso <tytso@MIT.EDU>
X-From: git-owner@vger.kernel.org Sun Sep 05 03:18:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Os3sT-0001bG-9H
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 03:18:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754646Ab0IEBSS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Sep 2010 21:18:18 -0400
Received: from relais.videotron.ca ([24.201.245.36]:15509 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754637Ab0IEBSR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Sep 2010 21:18:17 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MRZ20.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0L8900MT62ACHVJ0@VL-MR-MRZ20.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 04 Sep 2010 21:18:13 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <5B5470E5-57E6-48D2-981B-CE77FA43546F@mit.edu>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155405>

On Sat, 4 Sep 2010, Theodore Tso wrote:

> 
> On Sep 4, 2010, at 1:40 AM, Nicolas Pitre wrote:
> >> What about the order of the objects in the pack?  Well, ordering 
> >> doesn't matter, right?  So let's assume the pack is sorted by hash id.  
> >> Is there any downside to that?  I can't think of any, but you're the 
> >> pack expert...
> > 
> > Ordering does matter a big deal.  Since object IDs are the SHA1 of their 
> > content, those IDs are totally random.  So if you store objects 
> > according to their sorted IDs, then the placement of objects belonging 
> > to, say, the top commit will be totally random.  And since you are the 
> > filesystem expert, I don't have to tell you what performance impacts 
> > this random access of small segments of data scattered throughout a 
> > 400MB file will have on a checkout operation.
> 
> Does git repack optimize the order so that certain things (like 
> checkouts for example) are really fast?  I admit I hadn't noticed.  

It does indeed.  The object ordering in the pack is so that checking out 
the most recent commit will perform an almost perfect linear read from 
the beginning of the pack file.  Then the further back you go in the 
commit history the more random the access in the pack will be.  But 
that's OK as the most accessed commits are the recent ones, so we 
optimize object placement for that case.

> Usually until the core packs are in my page cache, it has always 
> seemed to me that things are pretty slow.

Cold cache numbers could be much much worse.  In theory, checking out 
the latest commit after a repack should be similar to extracting the 
equivalent source tree from a tarball.

> And of course, the way objects and grouped together and ordered for 
> "gitk" or "git log" to be fast won't be the safe as a checkout 
> operation...

Indeed. But that case is optimized too, as all the commit objects are 
put together at the front of the pack so the walking of the commit 
history has good access locality too.

> > Sure.  But I don't think it is worth making Git less flexible just for 
> > the purpose of ensuring that people could independently create identical 
> > packs.  I'd advocate for "no code to write at all" instead, and simply 
> > have one person create and seed the reference pack.
> 
> I don't think it's a matter of making Git "less flexible", it's just 
> simply a code maintenance headache of needing to be able to support 
> encoding both a canonical format as well as the latest bleeding-edge, 
> most efficient encoding format.

Indeed.  But what I'm saying is that one would have to put some efforts 
into that canonical format by removing the current flexibility that Git 
has in producing a pack.  For example, right now Git is relying on that 
flexibility when using threads. The algorithm for load balancing ends up 
making slight differences between different repack invocations even when 
they're started with the same input.  With multiple threads, the output 
from pack-objects is therefore not deterministic.

> And how often are you changing/improving the encoding process, anyway?  
> It didn't seem to me like that part of the code was constantly being 
> tweaked/improved.

It used to change quite often. It is true that these days things have 
slowed down in that area, but I prefer to keep options open unless there 
is a really convincing reason not to.

> Still, you're right, it might not be worth it.  To be honest, I was 
> more interested about the fact that this might also be used to give 
> people hints about how to better repack their local repositories so 
> that they didn't have to run git repack with large --window and 
> --depth arguments.  But that would only provide very small 
> improvements in storage space in most cases, so it's probably not even 
> worth it for that.
> 
> Quite frankly, I'm a little dubious about how critical peer2peer 
> really is, for pretty much any use case.

I agree.  So far it has been an interesting topic for discussion, but in 
practice I doubt the actual benefits will justify the required efforts 
and/or constraints on the protocol. Otherwise we would have a working 
implementation in use already.  People tried in the past, and so far 
none of those attempts passed the reality test nor kept people motivated 
enough to work on them further.

> Most of the time, I can grab 
> the base "reference" tree and drop it on my laptop before I go off the 
> grid and have to rely on EDGE or some other slow networking 
> technology.  And if the use case is some small, but 
> illegal-in-some-jurisdiction code, such as ebook DRM liberation 
> scripts (the kind which today are typically distributed via pastebin's 
> :-), my guess is that zipping up a git repository and dropping it on a 
> standard bittorrent server run by the Swedish Pirate party is going to 
> be much more effective.  :-)

Who cares about the development history for such scripts anyway?


Nicolas
