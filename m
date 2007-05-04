From: Nicolas Pitre <nico@cam.org>
Subject: Re: [RFC] Optimize diff-delta.c
Date: Fri, 04 May 2007 09:35:47 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0705040905040.24220@xanadu.home>
References: <20070504064024.GA11788@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Fri May 04 15:36:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hjxx3-0006as-T6
	for gcvg-git@gmane.org; Fri, 04 May 2007 15:36:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755250AbXEDNf6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 May 2007 09:35:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755251AbXEDNf6
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 09:35:58 -0400
Received: from relais.videotron.ca ([24.201.245.36]:36274 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755250AbXEDNf4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2007 09:35:56 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JHI0074OR3PGX00@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 04 May 2007 09:35:50 -0400 (EDT)
In-reply-to: <20070504064024.GA11788@auto.tuwien.ac.at>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46179>

On Fri, 4 May 2007, Martin Koegler wrote:

> On 2007-05-01 16:05:24, Nicolas Pitre wrote:
> > > On Tue, 1 May 2007, Martin Koegler wrote:
> > Right.  I think it would be a good idea to extend the delta format as 
> > well to allow for larger offsets in pack v4.
> 
> Is git://repo.or.cz/git/fastimport.git#sp/pack4 the current version of
> pack v4 efforts?

Yes.  It is lagging behind current git though, and not usable yet.

> > > The delta index has approximately the same size in memory as the
> > > uncompressed blob ((blob size)/16*(sizeof(index_entry)).
> > 
> > One thing that could be done with really large blobs is to create a 
> > sparser index, i.e. have a larger step than 16.  Because the delta match 
> > loop scans backward after a match the sparse index shouldn't affect 
> > compression that much on large blobs and the index could be 
> > significantly smaller.
> 
> In the long term, I think, that the delta generation code needs to get
> tunable.

No.  It should be self-tunable certainly, but there are way too many 
config options already, and another one for the inner working of the 
delta algorithm would be a bit too esoteric for most users and they 
won't get advantage of it.  This thing really has to self tune itself.

> > > I tried to speed up the delta generation by searching for a common 
> > > prefix, as my blobs are mostly append only. I tested it with about 
> > > less than 1000 big blobs. The time for finding the deltas decreased 
> > > from 17 to 14 minutes cpu time.
> > 
> > I'm surprised that your patch makes so much of a difference.  Normally 
> > the first window should always match in the case you're trying to 
> > optimize and the current code should already perform more or less the 
> > same as your common prefix match does.
> 
> A block is limited to 64k. If the file has some hundred MBs, it has to
> match many blocks.

Only if the first match is smaller than 64K.  If the first match is 64K 
in size then the rest of the file is not considered at all.

> My patch can process everything except the few last thousand lines by
> doing a memcmp.
> 
> Additionally, nearly every line starts with the same, longer than 16
> byte prefix. So its likely, that many blocks map to the same hash
> value.

The hash index only remembers the lowest of consecutive identical blocks 
so repeated blocks are indexed only with the first one.  If however you 
happen to have many identical blocks interlaced between other blocks 
then there is not much that can be done.  What the code does in that 
case is to trim those hash buckets that gets too large by keeping only a 
few entries across the reference buffer to avoid a O(n^2) behavior. But 
that happens only when your line beginnings are located on the same 
block boundary (but with a block size of 16 this is rather likely in the 
presence of lots of lines I suppose).

I'll be very interested in the results you get with my suggested patch.


Nicolas
