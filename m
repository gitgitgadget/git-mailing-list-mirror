From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: git pack/unpack over bittorrent - works!
Date: Sat, 04 Sep 2010 01:40:35 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1009040040030.19366@xanadu.home>
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
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Luke Kenneth Casson Leighton <luke.leighton@gmail.com>,
	git <git@vger.kernel.org>
To: Theodore Tso <tytso@MIT.EDU>
X-From: git-owner@vger.kernel.org Sat Sep 04 07:40:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrlUk-0004qi-TC
	for gcvg-git-2@lo.gmane.org; Sat, 04 Sep 2010 07:40:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752279Ab0IDFkh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Sep 2010 01:40:37 -0400
Received: from relais.videotron.ca ([24.201.245.36]:49942 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751340Ab0IDFkh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Sep 2010 01:40:37 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR006.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0L8700BWGJRN0BZ3@VL-MO-MR006.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 04 Sep 2010 01:40:36 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <04755B03-EE1D-48FA-8894-33AA8E2661C0@mit.edu>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155305>

On Fri, 3 Sep 2010, Theodore Tso wrote:

> 
> On Sep 3, 2010, at 3:41 PM, Nicolas Pitre wrote:
> 
> > 
> > Let's see what such instructions for how to make the canonical pack 
> > might look like:
> 
> But we don't need to replicate any particular pack.  We just need to 
> provide instructions that can be replicated everywhere to provide *a* 
> canonical pack.

But that canonical pack could be any particular pack.

> > First you need the full ordered list of objects.  That's a 20-byte SHA1
> > per object.  The current Linux repo has 1704556 objects, therefore this
> > list is 33MB already.
> 
> Assume the people creating this "gitdo" pack (i.e., much like jigdo) 
> have a superset of Linus's objects.  So if we have all of the branches 
> in Linus's repository, we can construct all of the necessary objects 
> going back in time to constitute his repository.  If Linus has only 
> one branch in his repo, we only need a single 20-byte SHA1 branch 
> identifier.  For git, presumbly we would need three (one for next, 
> maint, and master).

Sure, but that's not sufficient.  All this 20-byte SHA1 gives you is a 
set of objects.  That says nothing about their encoding.

> What about the order of the objects in the pack?  Well, ordering 
> doesn't matter, right?  So let's assume the pack is sorted by hash id.  
> Is there any downside to that?  I can't think of any, but you're the 
> pack expert...

Ordering does matter a big deal.  Since object IDs are the SHA1 of their 
content, those IDs are totally random.  So if you store objects 
according to their sorted IDs, then the placement of objects belonging 
to, say, the top commit will be totally random.  And since you are the 
filesystem expert, I don't have to tell you what performance impacts 
this random access of small segments of data scattered throughout a 
400MB file will have on a checkout operation.

> If we do that, we would thus only need to send 20 bytes instead of 33MB.  
> 
> > Then you need to identify which of those objects are deltas, and against
> > which object.  Assuming we can index in the list of objects, that means,
> > say, one bit to identify a delta, and 31 bits for indexing the base. In
> > my case this is currently 1393087 deltas, meaning 5.3 MB of additional
> > information.
> 
> OK, this we'll need which means 5.3MB.
> 
> > 
> > But then, the deltas themselves can have variations in their encoding.
> > And we did change the heuristics for the actual delta encoding in the
> > past too (while remaining backward compatible), but for a canonical pack
> > creation we'd need to describe that in order to make things totally
> > reproducible.
> > 
> > So there are 2 choices here: Either we specify the Git version to make 
> > sure identical delta code is used, but that will put big pressure on 
> > that code to remain stable and not improve anymore as any behavior 
> > change will create a compatibility issue forcing people to upgrade their 
> > Git version all at the same time.  That's not something I want to see 
> > the world rely upon.
> 
> I don't think the choice is that stark.  It does mean that in addition 
> to whatever pack encoding format is used by git natively, the code 
> would also need to preserve one version of the delta hueristics for 
> "Canonical pack version 1". After this version is declared, it's true 
> that you might come up with a stunning new innovation that saves some 
> disk space.  How much is that likely to be?  3%?  5%?  Worst case, it 
> means that (1) the bittorent-distributed packs might not be as 
> efficient, and (2) the code would be made more complex because we 
> would either need to (a) keep multiple versions of the code, or (b) 
> the code might need to have some conditionals:
> 
> 	if (canonical pack v1)
> 		do_this_code;
> 	else
> 		do_this_more_clever_code;
> 
> Is that really that horrible?  And certainly we should be able to set things up so that it won't be a brake on innovation...

Well, this would still be a non negligible maintenance cost.  And for 
what purpose already? What is the real advantage?

> The advantages of sending a canonical pack is that it's relatively 
> less code to write, since we can reuse the standard BitTorrent clients 
> and servers to transmit the git repository.  The downsides are that 
> it's mainly useful for downloading the entire repository, but I think 
> that's the most useful place for peer2peer anyway.

Sure.  But I don't think it is worth making Git less flexible just for 
the purpose of ensuring that people could independently create identical 
packs.  I'd advocate for "no code to write at all" instead, and simply 
have one person create and seed the reference pack.

And if you are willing to participate in the seeding of such a torrent, 
then you better not be bandwidth limited, meaning that you certainly can 
afford to download that reference pack in the first place.

And that reference pack doesn't have to change that often either.  If 
you update it only on every major kernel releases, then you'll need to 
fetch it about once every 3 months.  Incremental updates from those 
points should be relatively small.

Yet... it should be possible in practice to produce identical packs, 
given that the Git version is specified, the zlib version is specified, 
the number of threads for the repack is equal to 1, the -f flag is used 
meaning a full repack is performed, the delta depth and window size is 
specified, and the head branches are specified.  Given that torrents are 
also identified by a hash of their content, it should be pretty easy to 
see if the attempt to reproduce the reference pack worked, and start 
seeding right away if it did.

But again, I don't think it is worth freezing the pack format into a 
canonical encoding for this purpose.


Nicolas
