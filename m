From: Shawn Pearce <spearce@spearce.org>
Subject: Re: GPF in index-pack
Date: Sun, 6 Aug 2006 00:08:48 -0400
Message-ID: <20060806040848.GF20565@spearce.org>
References: <9e4733910608051805j1192d910hf55393f1dbe1e472@mail.gmail.com> <9e4733910608051944v5af7e552wd6909b9773dd516e@mail.gmail.com> <20060806024858.GC20565@spearce.org> <9e4733910608051958h6144add7td46de70dd8b45a5e@mail.gmail.com> <20060806033222.GD20565@spearce.org> <9e4733910608052100t463e6fb8gba54e4afde1ab19a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Aug 06 06:09:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9Zwi-0002j1-Az
	for gcvg-git@gmane.org; Sun, 06 Aug 2006 06:09:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751519AbWHFEIx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 Aug 2006 00:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751520AbWHFEIx
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Aug 2006 00:08:53 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:23694 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751517AbWHFEIw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Aug 2006 00:08:52 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1G9ZwM-0002DL-On; Sun, 06 Aug 2006 00:08:39 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5549520FB77; Sun,  6 Aug 2006 00:08:49 -0400 (EDT)
To: Jon Smirl <jonsmirl@gmail.com>
Content-Disposition: inline
In-Reply-To: <9e4733910608052100t463e6fb8gba54e4afde1ab19a@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24960>

Jon Smirl <jonsmirl@gmail.com> wrote:
> On 8/5/06, Shawn Pearce <spearce@spearce.org> wrote:
> >Jon Smirl <jonsmirl@gmail.com> wrote:
> >> On 8/5/06, Shawn Pearce <spearce@spearce.org> wrote:
> >> >Jon Smirl <jonsmirl@gmail.com> wrote:
> >> >> Process size is 2.6GB when the seg fault happen. That's a lot of
> >> >> memory to build a pack index over 1M objects.
> >> >>
> >> >> I'm running a 3:1 process address space split. I wonder why it didn't
> >> >> grow all the way to 3GB. I still have RAM and swap available.
> >> >
> >> >Was the pack you are trying to index built with that fast-import.c
> >> >I sent last night?  Its possible its doing something weird that
> >> >pack-index can't handle, such as insert a duplicate object into
> >> >the same pack...
> >>
> >> built with fast-import.
> >>
> >> >How big is the pack file?  I'd expect pack-index to be using
> >> >something around 24 MB of memory (24 bytes/entry) but maybe its
> >> >hanging onto a lot of data (memory leak?) as it decompresses the
> >> >entries to compute the checksums.
> >>
> >> It is 934MB in size with 985,000 entries.
> >>
> >> Why does resolve_delta in index-pack.c need to be recursive? Is there
> >> a better way to code that routine? If it mmaps the file that uses 1GB
> >> address space, why does it need another 1.5GB to build an index?
> >
> >Probably the easiest way to code the routine.  Delta depth is
> >bounded; in the fast-import.c that I sent out last night I hardcoded
> >it to 10, which is (I believe) the default for GIT.  So long as that
> >routine is recursive only along a single delta chain the recursion
> >depth won't be very high and shouldn't be the problem.
> 
> When I put index-pack in gdb at the seg fault, resolve_delta had
> recursed more than 20,000 times. I stopped looking after that.

Ouch.  I'm not familiar with this code, but looking at right now its
also not entirely obviously what its recursing for.  Plus dinner
is trying to be burned on the grill, so my attention is on that
more than on GIT.  :-)
 
> >> I had a prior 400MB pack file built with fast-import that I was able
> >> to index ok.
> >
> >Dumb luck?  Maybe that had no duplicates while this one does?
> 
> Is there a git command to list the sha1's in a pack that doesn't have
> an index? I could sort it, sort it unqiue, and then diff the outputs.

Not that I know of.  Packs themselves don't have the SHA1 values and
getting them from a pack without an index is a painful exercise as
you don't know where the base of an object resides within the pack
when you need it to generate the object's raw content to determine
its ID.

Yea, I'm sure the pack format has some great properties, but storing
the base as a 20 byte object ID rather the offset of the base within
the pack has its limitations...

-- 
Shawn.
