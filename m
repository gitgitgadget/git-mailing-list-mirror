From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: performance on repack
Date: Tue, 14 Aug 2007 01:13:21 -0400
Message-ID: <20070814051321.GG27913@spearce.org>
References: <9e4733910708111412t48c1beaahfbaa2c68a02f64f1@mail.gmail.com> <20070812103338.GA7763@auto.tuwien.ac.at> <9e4733910708120649g5a5e0f48pa71bd983f2bc2945@mail.gmail.com> <20070814031236.GC27913@spearce.org> <9e4733910708132110u6cdf5e6bg10417317c70b82f1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Martin Koegler <mkoegler@auto.tuwien.ac.at>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 14 07:14:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKojB-0005LF-QJ
	for gcvg-git@gmane.org; Tue, 14 Aug 2007 07:14:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936385AbXHNFNb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Aug 2007 01:13:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933192AbXHNFN3
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Aug 2007 01:13:29 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:55815 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936771AbXHNFN1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2007 01:13:27 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IKoiY-0003cz-Pr; Tue, 14 Aug 2007 01:13:23 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 4B50D20FBAE; Tue, 14 Aug 2007 01:13:21 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <9e4733910708132110u6cdf5e6bg10417317c70b82f1@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55807>

Jon Smirl <jonsmirl@gmail.com> wrote:
> On 8/13/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> > > On 32b there's windowing code for accessing the packfile since we can
> > > run out of address space, does this code get turned off for 64b?
> >
> > The windowing code you are talking about defaults as follows:
> >
> >   Parameter                  32b      64b
> >   -----------------------------------------
> >   core.packedGitWindowSize    32M     1G
> >   core.packedGitLimit        256M     8G
> >
> > So I doubt you are having issues with the windowing code on a 64b
> > system, unless your repository is just *huge*.  I did not think that
> > anyone had a Git repository that exceeded 8G, though the window
> > size of 1G might be a tad too small if there are many packfiles
> > and they are each larger than 1G.
> 
> Why use windows on 64b? Default core.packedGitWindowSize equal to
> core.packedGitLimit

That's *not* a good idea when you have more than one packfile.

The limit is for the sum of all packfiles.  The settings above allow
up to 8 packfiles to be opened and mapped at once on 64b systems,
with each packfile being up to 1G in size before we start shifting
the window(s) around.  Doing as you suggest would reduce the number
of open packfiles to 1, which would severely hurt performance
when there is more than one packfile and Git keeps bouncing around
between them to satisfy the current process' demands.

One could probably argue that the defaults for 64b are too small;
perhaps they should be closer to 4G/24G seeing as how the 64b address
space is so huge that we're unlikely to run into issues with being
able to use >24G of virtual address at once.

> I haven't measured it but I suspect the OS calls for moving the
> windows are are quite slow on a relative basis since they have to
> rewrite a bunch of page tables.

Maybe.  Add a call to pack_report() at the end of the program you
are interested in and run it.  We keep track of how often we move
windows around; you may find that we don't move them often enough
(or at all) to cause problems here.  Or just run it under strace
and watch mmap() activity, filtering out the uninteresting bits.

> Why is the window so small on 32b? I
> thought we were up to about a 1GB packfile before running out of
> address space with Mozilla. Shouldn't the window simply be set as
> large as possible on 32b, this size being a function of the available
> address space, not the amount of physical memory?

Because programs need to malloc() stuff to work.  And we need
stack space.  And we need to let the runtime linker mmap() in the
shared libraries we are linked to.  All in all we do get tight in
some 32b cases.  The above defaults for 32b were chosen based on
the Linux kernel repository (its under 256M) and based on some
(crude) performance testing on Linux (which seemed to say the
32M packedGitWindowSize wasn't really hurting us).  They were
basically set to give us maximum address space for working heap
and yet not have a negative impact on one of our (at the time)
largest user groups.

In particular repack (aka git-pack-objects) is a real memory pig,
especially now with its various caches.  The more address space we
can let it use in a 32b case the better off we probably are.

If someone can show that increasing these 32b defaults is the
right thing to do even in very large repositories, *especially*
with something really brutal like `git-blame` on a very busy file or
`git repack -f -a` then please submit a patch to boost them.  ;-)

-- 
Shawn.
