From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Why is "git tag --contains" so slow?
Date: Thu, 08 Jul 2010 16:13:21 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1007081559300.6020@xanadu.home>
References: <20100701121711.GF1333@thunk.org>
 <20100701150331.GA12851@sigill.intra.peff.net>
 <20100701153842.GA15466@sigill.intra.peff.net>
 <20100702192612.GM1333@thunk.org>
 <20100703080618.GA10483@sigill.intra.peff.net>
 <20100704005543.GB6384@thunk.org>
 <20100705122723.GB21146@sigill.intra.peff.net>
 <20100705141012.GA25518@thunk.org>
 <20100706115826.GA15413@sigill.intra.peff.net>
 <1278430303.32094.15.camel@wpalmer.simply-domain>
 <20100707174546.GA4979@coredump.intra.peff.net>
 <11D5771D-EB47-42E9-BCC3-69C8FE1999EC@MIT.EDU>
 <m37hl6mdnb.fsf@localhost.localdomain>
 <alpine.LFD.2.00.1007081515030.6020@xanadu.home>
 <AANLkTikVNkObOxGQhDJ5Qau-vYn2YcomHQW2p2zsMof9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_JyCGz1L32UaGhmxeIVGtLA)"
Cc: Jakub Narebski <jnareb@gmail.com>, Theodore Tso <tytso@mit.edu>,
	Jeff King <peff@peff.net>, Will Palmer <wmpalmer@gmail.com>,
	git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 08 22:13:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWxTN-0005nS-9d
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 22:13:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756625Ab0GHUNX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jul 2010 16:13:23 -0400
Received: from relais.videotron.ca ([24.201.245.36]:55295 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756187Ab0GHUNW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jul 2010 16:13:22 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0L5900J899I9U230@VL-MR-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 08 Jul 2010 16:13:21 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <AANLkTikVNkObOxGQhDJ5Qau-vYn2YcomHQW2p2zsMof9@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150610>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_JyCGz1L32UaGhmxeIVGtLA)
Content-type: TEXT/PLAIN; charset=ISO-8859-1
Content-transfer-encoding: 8BIT

On Thu, 8 Jul 2010, Avery Pennarun wrote:

> On Thu, Jul 8, 2010 at 3:29 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> > I might be looking at this from my own perspective as one of the few
> > people who hacked extensively on the Git pack format from the very
> > beginning.  But I do see a way for the pack format to encode commit and
> > tree objects so that walking them would be a simple lookup in the pack
> > index file where both the SHA1 and offset in the pack for each parent
> > can be immediately retrieved.  Same for tree references.  No deflating
> > required, no binary search, just simple dereferences.  And the pack size
> > would even shrink as a side effect.
> 
> One trick that bup uses is an additional file that sits alongside the
> pack and acts as an index.  In bup's case, this is to work around
> deficiencies in the .idx file format when using ridiculously huge
> numbers of objects (hundreds of millions) across a large number of
> packfiles.  But the same concept could apply here: instead of doing
> something like rev-cache, you could just construct the "efficient"
> part of the packv4 format (which I gather is entirely related to
> commit messages), and store it alongside each pack.

No.  I want the essential information in an efficient encoding _inside_ 
the pack, actually replacing the existing encoding.  One of the goal is 
also to reduce repository size, not to grow it.

> This would allow people to incrementally modify git to use the new,
> efficient commit object storage, without breaking backward
> compatibility with earlier versions of git.  (Just as bup can index
> huge numbers of packed objects but still stores them in the plain git
> pack format.)

Initially, what I'm aiming for is for pack-objects to produce the new 
format, for index-pack to grok it, and for sha1_file:unpack_entry() to 
simply regenerate the canonical object format whenever a pack v4 object 
is encountered.  Also pack-objects would be able to revert the object 
encoding to the current format on the fly when it is serving a fetch 
request to a client which is not pack v4 aware, just like we do now with 
the ofs-delta capability.

Once that stage is reached, I'll submit the lot and hope that other 
people will help incrementally converting part of Git to benefit from 
native access to the pack v4 data.  The tree object walk code would be 
the first obvious candidate.  And so on.


Nicolas

--Boundary_(ID_JyCGz1L32UaGhmxeIVGtLA)--
