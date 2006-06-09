From: Nicolas Pitre <nico@cam.org>
Subject: Re: Figured out how to get Mozilla into git
Date: Fri, 09 Jun 2006 13:38:13 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0606091326550.2703@localhost.localdomain>
References: <9e4733910606081917l11354e49q25f0c4aea40618ea@mail.gmail.com>
 <46a038f90606082006t5c6a5623q4b9cf7b036dad1e5@mail.gmail.com>
 <9e4733910606082028k37f6d915m26009e0d5011808b@mail.gmail.com>
 <e6b798$td3$1@sea.gmane.org> <Pine.LNX.4.64.0606090745390.5498@g5.osdl.org>
 <Pine.LNX.4.64.0606091127540.19403@localhost.localdomain>
 <Pine.LNX.4.64.0606090926550.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 09 19:38:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fokw6-0002CO-HV
	for gcvg-git@gmane.org; Fri, 09 Jun 2006 19:38:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751456AbWFIRiP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Jun 2006 13:38:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751466AbWFIRiP
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jun 2006 13:38:15 -0400
Received: from relais.videotron.ca ([24.201.245.36]:61171 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751456AbWFIRiO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jun 2006 13:38:14 -0400
Received: from xanadu.home ([74.56.108.184]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J0L000JASZP9TX0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 09 Jun 2006 13:38:13 -0400 (EDT)
In-reply-to: <Pine.LNX.4.64.0606090926550.5498@g5.osdl.org>
X-X-Sender: nico@localhost.localdomain
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21534>

On Fri, 9 Jun 2006, Linus Torvalds wrote:

> 
> 
> On Fri, 9 Jun 2006, Nicolas Pitre wrote:
> > 
> > > So a single 2GB pack is already very much pushing it. It's really really 
> > > hard to map in a 2GB file on a 32-bit platform: your VM is usually 
> > > fragmented enough that it simply isn't practical. In fact, I think the 
> > > limit for _practical_ usage of single packs is probably somewhere in the 
> > > half-gig region, unless you just have 64-bit machines.
> > 
> > Sure, but have we already reached that size?
> 
> Not for the Linux repos.
> 
> But apparently the mozilla repo ends up being 2GB in git. From Martin:
> 
>   >> oh, I went back to a cvsimport that I started a couple days ago.
>   >> Completed with no problems...
>   >> 
>   >> Last commit:
>   >> commit 5ecb56b9c4566618fad602a8da656477e4c6447a
>   >> Author: wtchang%redhat.com <wtchang%redhat.com>
>   >> Date:   Fri Jun 2 17:20:37 2006 +0000
>   >> 
>   >>    Import NSPR 4.6.2 and NSS 3.11.1
>   >> 
>   >> mozilla.git$ du -sh .git/
>   >> 2.0G    .git/

He also sais:

| git-repack -a -d but it OOMs on my 2GB+2GBswap machine :(

> now that was done with _incremental_ repacking (ie his .git directory
> won't be just one large pack),

So given the nature of packs, incrementally packing an imported 
repository _might_ cause worse problems since each pack must be self 
referenced by definition.  That means you may end up with multiple 
revisions of the same file distributed amongst as many packs hence none 
of those revisions are ever deltified, and to repack that you currently 
have to mmap all those packs at once.

> but I bet that if you were to clone it
> (without using the "-l" flag or rsync/http), you'd end up with serious
> trouble because of the single-pack limit.

Maybe that single pack would instead be under the 512MB limit?  I'd be 
curious to know.

> So we're starting to see archives where single packs are problematic for
> a 32-bit architecture. 

Depending on the operation, the single pack might actually be better, 
especially for a full clone where everything gets mapped.  Multiple 
packs will always take more space, which is fine if you don't need 
access to all objects at once since individual packs are small, but the 
whole of them (when repacking or cloning) isn't.


Nicolas
