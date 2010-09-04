From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: git pack/unpack over bittorrent - works!
Date: Sat, 04 Sep 2010 02:13:23 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1009040153280.19366@xanadu.home>
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
 <AANLkTi=sC3NMNzPRQM5RKwnZQyRq-gq6+7wdiT5LGDrc@mail.gmail.com>
 <AANLkTinoyehduhdHSEm5yGTLvU6C-ViE885yLd63iQU0@mail.gmail.com>
 <4C81A67B.2060400@gmail.com> <alpine.LFD.2.00.1009032304560.19366@xanadu.home>
 <4C81DC34.2090800@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Luke Kenneth Casson Leighton <luke.leighton@gmail.com>,
	Ted Ts'o <tytso@mit.edu>, Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>
To: Artur Skawina <art.08.09@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 04 08:13:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Orm0I-0006nv-V2
	for gcvg-git-2@lo.gmane.org; Sat, 04 Sep 2010 08:13:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752616Ab0IDGNZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Sep 2010 02:13:25 -0400
Received: from relais.videotron.ca ([24.201.245.36]:25492 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750940Ab0IDGNY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Sep 2010 02:13:24 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0L87002A4LABA740@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 04 Sep 2010 02:13:24 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <4C81DC34.2090800@gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155307>

On Sat, 4 Sep 2010, Artur Skawina wrote:

> >> 2) Git doesn't use chained deltas. IOW given commits "A --d1-> B --d2-> C",
> >>    "C" can be represented as a delta against "A" or "B", but _not_ against "d1". 
> >>    (Think of the case where "C" reverts /part of/ "B")
> > 
> > Git does use chained deltas indeed.  But deltas are used only at the 
> > object level within a pack file.  Any blob object can be represented as 
> > a delta against any other blob in the pack, regardless of the commit(s) 
> > those blob objects belong to.  Same thing for tree objects.  So you can 
> > have deltas going in total random directions if you look them from a 
> > commit perspective.  So "C" can have some of its objects being deltas 
> > against objects from "B", or "A", or any other commit for that matter, 
> > or even objects belonging to the same commit "C". And some other objects 
> > from "B" can delta against objects from "C" too. There is simply no 
> > restrictions at all on the actual delta direction.  The only rule is 
> > that an object may only delta against another object of the same type.
> > 
> > Of course we don't try to delta each object against all the other 
> > available objects as that would be a O(n^2) operation (imagine with n = 
> > 1.7 million objects).  So we use many heuristics to make this delta 
> > packing efficient without taking an infinite amount of time.
> > 
> > For example, if we have objects X and Y that need to be packed together 
> > and sent to a client over the net, and we find that Y is already a delta 
> > against X in one pack that exists locally, then we simply and literally 
> > copy the delta representation of Y from that local pack file and send it 
> > out without recomputing that delta.
> 
> What i meant by 'chained deltas' is a representation that takes delta#1 and
> applies delta#2 to the first delta, and applies the result to the source of
> delta#1. Which could be a more compact representation of eg. a partial revert.

You can have deltas on top of deltas.  And they can be in any direction 
i.e. object #1 can be a delta that only takes half of a bigger object 
#2, or object #2 can be a delta copying a smaller object #1 and adding 
more data to it.  In the end both representation will take more or less 
the same amount of space.

> IOW, if I have commits A..Y, ask (via git pull) for commits X and Z, then I'm
> guaranteed to receive them either raw, or as a delta vs commits A..X, right?

In such case you will receive only those new objects that commits X and 
Z introduced, and those new objects may indeed be encoded either as 
whole objects, or as deltas against either objects that you already 
have, or even as deltas against objects that are part of the transfer.

> What I'm really asking is, if a (modified) git-upload-pack skips transferring
> commit X, and just sends me commit Z (possibly as delta vs 'X'), _and_ I 
> obtain commit 'X" in some other way, I will be able to reconstruct 'Z', correct?

Yes.  Although it is 'git pack-objects' that decides what objects to 
send, not 'git-upload-pack'.


Nicolas
