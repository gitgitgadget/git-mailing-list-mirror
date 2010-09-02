From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: git pack/unpack over bittorrent - works!
Date: Thu, 02 Sep 2010 19:09:45 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1009021624170.19366@xanadu.home>
References: <AANLkTik-w6jWgrt_kwAk2uNGhF_=3tMEpTZs3nyF_zGA@mail.gmail.com>
 <AANLkTinu=RoGfq93d+yjHiQwCt0HXx4YtqfvhXyZdO=F@mail.gmail.com>
 <AANLkTimpE6rf0azHtrz6BFK5d7YojF+G1YuSA1gusSC=@mail.gmail.com>
 <4C7FC3DC.3060907@gmail.com>
 <AANLkTikBnKQJmgOms2wK1+6fCLtHWiWkhuCVMN7kKLXP@mail.gmail.com>
 <alpine.LFD.2.00.1009021249510.19366@xanadu.home>
 <AANLkTinFPxsY6frVnga8u15aovQarfWreBYJfri6ywoK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git <git@vger.kernel.org>
To: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 03 01:10:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrIv5-000524-AS
	for gcvg-git-2@lo.gmane.org; Fri, 03 Sep 2010 01:10:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753713Ab0IBXKE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Sep 2010 19:10:04 -0400
Received: from relais.videotron.ca ([24.201.245.36]:33390 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751891Ab0IBXKD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Sep 2010 19:10:03 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR006.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0L85007M97093W52@VL-MO-MR006.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 02 Sep 2010 19:09:45 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <AANLkTinFPxsY6frVnga8u15aovQarfWreBYJfri6ywoK@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155222>

On Thu, 2 Sep 2010, Luke Kenneth Casson Leighton wrote:

> nicolas, thanks for responding: you'll see this some time in the
> future when you catch up, it's not a high priority, nothing new, just
> thinking out loud, for benefit of archives.

Well, I might as well pay more attention to *you* now.  :-)

> >> * is it possible to _make_ the repository guaranteed to produce
> >> identical pack objects?
> >
> > Sure, but performance will suck.
> 
>  that's fiiine :)  as i've learned on the pyjamas project, it's rare
> that you have speed and interoperability at the same time...

Well, did you hear about this thing called Git?  It appears that those 
Git developers are performance freaks.  :-)  Yet, Git is interoperable 
across almost all versions ever released because we made sure that only 
fundamental things are defined and relied upon.  And that excludes 
actual delta pairing and pack object ordering.  That's why a pack file 
may have many different byte sequences and yet still represent the same 
canonical data.

>  if the pack-objects are going to vary, then the VFS layer idea is
> blown completely out the water, except for the absolute basic
> meta-info such as "refs/heads/*".  so i might as well just use
> "actual" bittorrent to transfer packs via
> {ref}-{commitref}-{SHA-1}.torrent.

For the archive benefit, here's what I think on the whole idea.

The BitTorrent model is simply unappropriate for Git.  It doesn't fit to 
the Git model at all as BitTorrent works on stable and static data, and 
requires a lot of people wanting that same data.

When you perform a fetch, Git does actually negociate with the server to 
figure out what's missing locally, and the server does produce a custom 
pack for you that is optimized so that only what's needed for you to be 
up to date is transferred.

Even if you try to cache a set of packs to suit the BitTorrent static 
data model, you'll need so many packs to cover all the possible gaps 
between a server and a random number of clients each with a random 
repository state.  Of course it is possible to have bigger packs 
covering larger gaps, but then you lose the biggest advantage that the 
smart Git protocol has.  And with smaller, more fine grained packs, 
you'll end up with so many of them that finding a live torrent for the 
actual one you need is going to be difficult.

> ho hum, drawing board we come...

Yep.  Instead of transferring packs, a BitTorrent-alike transfer should 
be based on the transfer of _objects_.  Therefore you can make the 
correspondance between file chunks in BitTorrent with objects in a Git 
aware system.  So, when contacting a peer, you could negociate what is 
the set of objects that the peer has that you don't, and vice versa.  
Objects in Git are stable and immutable, and they all have a unique SHA1 
signature.  And to optimize the negociation, the pack index content can 
be used, first by exchanging the content of the first level 
fan-out table and ignoring those entries that are equal.  This for each 
peer.

Then, each peer make requests to connected peers for objects that those 
peers have but that isn't available locally, just like chunks in 
BitTorrent.

But here's the twist to make this scale well.  Since the object sender 
knows what objects the receiver already has, it therefore can choose the 
object encoding.  Meaning that the sender can simply *reuse* a delta 
encoding for an object it is requested to send if the requestor already 
has the base object for this delta.

So in most cases, the object to send will be small, especially if it is 
a delta object.  That should fit the 
chunk model.  But if an object is bigger than a certain treshold, then 
its transfer could be chunked across multiple peers just like classic 
BitTorrent.  In this case, the chunking would need to be done on 
the non delta uncompressed object data as this is the only thing that is 
universally stable (doesn't mean that the _transfer_ of those chunks 
can't be compressed).

Now this design has many open questions, such as finding out what is the 
latest set of refs amongst all the peers, whether or not what we have 
locally are ancestors of the remote refs, etc.

And of course, while this will make for a speedy object transfer, the 
resulting mess on the receiver's end will have to be validated 
and repacked in the end.  So overall this might not end up being faster 
overall for the fetcher.


Nicolas
