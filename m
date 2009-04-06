From: Nicolas Pitre <nico@cam.org>
Subject: Re: Performance issue: initial git clone causes massive repack
Date: Mon, 06 Apr 2009 00:06:00 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904052336260.6741@xanadu.home>
References: <20090404220743.GA869@curie-int>
 <20090405195714.GA4716@coredump.intra.peff.net>
 <20090405T230552Z@curie.orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
To: "Robin H. Johnson" <robbat2@gentoo.org>
X-From: git-owner@vger.kernel.org Mon Apr 06 06:09:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lqg9Z-0000To-ES
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 06:09:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750787AbZDFEGL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 00:06:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750733AbZDFEGL
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 00:06:11 -0400
Received: from relais.videotron.ca ([24.201.245.36]:28257 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750709AbZDFEGK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 00:06:10 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KHN00BR1VE0LVE0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 06 Apr 2009 00:06:01 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20090405T230552Z@curie.orbis-terrarum.net>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115760>

On Sun, 5 Apr 2009, Robin H. Johnson wrote:

> On Sun, Apr 05, 2009 at 03:57:14PM -0400, Jeff King wrote:
> > > During an initial clone, I see that git-upload-pack invokes
> > > pack-objects, despite the ENTIRE repository already being packed - no
> > > loose objects whatsoever. git-upload-pack then seems to buffer in
> > > memory.
> > We need to run pack-objects even if the repo is fully packed because we
> > don't know what's _in_ the existing pack (or packs). In particular we
> > want to:
> >   - combine multiple packs into a single pack; this is more efficient on
> >     the network, because you can find more deltas, and I believe is
> >     required because the protocol sends only a single pack.
> > 
> >   - cull any objects which are not actually part of the reachability
> >     chain from the refs we are sending
> > 
> > If no work needs to be done for either case, then pack-objects should
> > basically just figure that out and then send the existing pack (the
> > expensive bit is doing deltas, and we don't consider objects in the same
> > pack for deltas, as we know we have already considered that during the
> > last repack). It does mmap the whole pack, so you will see your virtual
> > memory jump, but nothing should require the whole pack being in memory
> > at once.

Actually the pack is mapped with a (configurable) window.  See the
core.packedGitWindowSize and core.packedGitLimit config options for 
details.

> While my current pack setup has multiple packs of not more than 100MiB
> each, that was simply for ease of resume with rsync+http tests. Even
> when I already had a single pack, with every object reachable,
> pack-objects was redoing the packing.

In that case it shouldn't have.

> > pack-objects streams the output to upload-pack, which should only ever
> > have an 8K buffer of it in memory at any given time.
> > 
> > At least that is how it is all supposed to work, according to my
> > understanding. So if you are seeing very high memory usage, I wonder if
> > there is a bug in pack-objects or upload-pack that can be fixed.
> > 
> > Maybe somebody more knowledgeable than me about packing can comment.
> Looking at the source, I agree that it should be buffering, however top and ps
> seem to disagree. 3GiB VSZ and 2.5GiB RSS here now.
> 
> %CPU %MEM     VSZ     RSS STAT START   TIME COMMAND
>  0.0  0.0  140932    1040 Ss   16:09   0:00 \_ git-upload-pack /code/gentoo/gentoo-git/gentoo-x86.git 
> 32.2  0.0       0       0 Z    16:09   1:50     \_ [git-upload-pack] <defunct>
> 80.8 44.2 3018484 2545700 Sl   16:09   4:36     \_ git pack-objects --stdout --progress --delta-base-offset 
> 
> Also, I did another trace, using some other hardware, in a LAN setting, and
> noticed that git-upload-pack/pack-objects only seems to start output to the
> network after it reaches 100% in 'remote: Compressing objects:'.

That's to be expected.  Delta compression matches objects which are not 
in the stream order at all.  Therefore it is not possible to start 
outputting pack data until this pass is done.  Still, this pass should 
not be invoked if your repository is already fully packed into one pack.  
Can you confirm this is actually the case?

> Relatedly, throwing more RAM (6GiB total, vs. the previous 2GiB) at 
> the server in this case cut the 200 wallclock minutes before any 
> sending too place down to 5 minutes.

Well... here's a wild guess.  In the source repository serving clone 
requests, please do:

	git config pack.deltaCacheSize 1
	git config pack.deltaCacheLimit 0

and try cloning again with a fully packed repository.

> > > For the initial clone, can the git-upload-pack algorithm please send
> > > existing packs, and only generate a pack containing the non-packed
> > > items?
> > 
> > I believe that would require a change to the protocol to allow multiple
> > packs. However, it may be possible to munge the pack header in such a
> > way that you basically concatenate multiple packs. You would still want
> > to peek in the big pack to try deltas from the non-packed items, though.

As explained already, even if the protocol requires a single pack to be 
created, it is still made up of unmodified data segments from existing 
packs as much as possible.  So you should see it more or less as the 
concatenation of those packs already, plus some munging over the edges.

> > I think all of this falls into the realm of the GSOC pack caching project.
> > There have been other discussions on the list, so you might want to look
> > through those for something useful.
> Yes, both changing the protocol, and recognizing that existing packs may be
> suitable to send could be considered as part of the caching project, as they
> fall under the aegis of making good use of what's stored in the cache already
> to send.

The caching pack project is to address a different issue: mainly to 
bypass the object enumeration cost.  In other words, it could allow for 
skipping the "Counting objects" pass, and a tiny bit more.  At least in 
theory that's about the main difference.  This has many drawbacks as 
well though.


Nicolas
