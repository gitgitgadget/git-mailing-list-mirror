From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: git pack/unpack over bittorrent - works!
Date: Fri, 03 Sep 2010 15:41:26 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1009031522590.19366@xanadu.home>
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
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_xN5Zgfp/icNFGxXavCP0+w)"
Cc: Junio C Hamano <gitster@pobox.com>,
	Luke Kenneth Casson Leighton <luke.leighton@gmail.com>,
	git <git@vger.kernel.org>
To: Ted Ts'o <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Fri Sep 03 21:41:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Orc8l-0001qc-2j
	for gcvg-git-2@lo.gmane.org; Fri, 03 Sep 2010 21:41:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757276Ab0ICTl3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Sep 2010 15:41:29 -0400
Received: from relais.videotron.ca ([24.201.245.36]:14462 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757107Ab0ICTl1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Sep 2010 15:41:27 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MRZ20.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0L8600I6OS0ZEFU0@VL-MR-MRZ20.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 03 Sep 2010 15:41:24 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20100903183120.GA4887@thunk.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155269>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_xN5Zgfp/icNFGxXavCP0+w)
Content-type: TEXT/PLAIN; charset=ISO-8859-15
Content-transfer-encoding: 8BIT

On Fri, 3 Sep 2010, Ted Ts'o wrote:

> On Fri, Sep 03, 2010 at 10:12:29AM -0700, Junio C Hamano wrote:
> > Theodore Tso <tytso@MIT.EDU> writes:
> > 
> > > ...  So people who are willing
> > > to participate as part of the peer2peer network can download the
> > > instructions for how to make the canonical pack once a month, and use it
> > > to create the canonical pack.  If the "Gittorrent master" has spent a
> > > lot of time to carefully compute the most efficient set of delta
> > > pairings, they will get the slight benefit of a more efficient pack
> > > which they could use instead of th eir local one without having to use
> > > large values of --window and --depth to "git repack".
> > 
> > Hmm, is the idea essentially to tell people "Here is a snapshot of Linus
> > repository as of a few weeks ago, carefully repacked.  Instead of running
> > "git clone" yourself, please bootstrap your repository by copying it over
> > bittorrent and then "git pull" to update it"?
> 
> Essentially, yes.  I just don't think bittorrent makes sense for
> anything else, because the git protocol is so much more efficient for
> tiny incremental updates...
> 
> So the only other part of my idea is that we could construct a special
> set of instructions that would allow them to recreate the carefully
> repacked snapshot of Linus's repository without having to download it
> from a central seed site.  Instead, they could download a small set of
> instructions, and use that in combination with the objects already in
> their repository, to create a bit-identical version of the carefully
> repacked Linus repository.  It's basically rip-off of jigdo, but
> applied to git repositories instead of Debian .iso files.

Small?  Well...

Let's see what such instructions for how to make the canonical pack 
might look like:

First you need the full ordered list of objects.  That's a 20-byte SHA1
per object.  The current Linux repo has 1704556 objects, therefore this
list is 33MB already.

Then you need to identify which of those objects are deltas, and against
which object.  Assuming we can index in the list of objects, that means,
say, one bit to identify a delta, and 31 bits for indexing the base. In
my case this is currently 1393087 deltas, meaning 5.3 MB of additional
information.

But then, the deltas themselves can have variations in their encoding.
And we did change the heuristics for the actual delta encoding in the
past too (while remaining backward compatible), but for a canonical pack
creation we'd need to describe that in order to make things totally
reproducible.

So there are 2 choices here: Either we specify the Git version to make 
sure identical delta code is used, but that will put big pressure on 
that code to remain stable and not improve anymore as any behavior 
change will create a compatibility issue forcing people to upgrade their 
Git version all at the same time.  That's not something I want to see 
the world rely upon.

The other choice is to actually provide the delta output as part of the 
instruction for the canonical pack creation.

In my case, the delta output represents:

$ git verifi-pack -v .git/objects/pack/*.pack | \
  awk --posix  '/^[0-9a-f]{40}/ && $6 { tot += 1; size += $4 } \
                END { print tot, size }'
1393087 155022247

We therefore have 148 MB of purely delta data here.

So that makes for a grand total of 33 MB + 148 MB = 181 MB of data just
to be able to unambiguously reproduce a pack with a full guarantee of
perfect reproducibility.

But even with the presumption of stable delta code, the recipee would 
still take 38 MB that everyone would have to download every month which 
is far more than what a monthly incremental update of a kernel repo 
requires.  Of course you could create a delta between consecutive 
recipees, but that is becoming rather awkward.

I still think that if someone really want to apply the P2P principle à 
la BitTorrent to Git, then it should be based on the distributed 
exchange of _objects_ as I outlined in a previous email, and not file 
chunks like BitTorrent does.  The canonical Git _objects_ are fully 
defined, while their actual encoding may change.


Nicolas

--Boundary_(ID_xN5Zgfp/icNFGxXavCP0+w)--
