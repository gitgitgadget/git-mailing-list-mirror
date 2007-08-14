From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: performance on repack
Date: Mon, 13 Aug 2007 23:12:36 -0400
Message-ID: <20070814031236.GC27913@spearce.org>
References: <9e4733910708111412t48c1beaahfbaa2c68a02f64f1@mail.gmail.com> <20070812103338.GA7763@auto.tuwien.ac.at> <9e4733910708120649g5a5e0f48pa71bd983f2bc2945@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Martin Koegler <mkoegler@auto.tuwien.ac.at>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 14 05:12:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKmps-0007sn-6g
	for gcvg-git@gmane.org; Tue, 14 Aug 2007 05:12:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756341AbXHNDMn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Aug 2007 23:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754478AbXHNDMn
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Aug 2007 23:12:43 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:52612 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757065AbXHNDMl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2007 23:12:41 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IKmpW-0007K2-OY; Mon, 13 Aug 2007 23:12:26 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id CE84420FBAE; Mon, 13 Aug 2007 23:12:36 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <9e4733910708120649g5a5e0f48pa71bd983f2bc2945@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55800>

Jon Smirl <jonsmirl@gmail.com> wrote:
> On 8/12/07, Martin Koegler <mkoegler@auto.tuwien.ac.at> wrote:
> > Have you considered the impact on memory usage, if there are large
> > blobs in the repository?
> 
> The process size maxed at 650MB. I'm in 64b mode so there is no
> virtual memory limit.
> 
> On 32b there's windowing code for accessing the packfile since we can
> run out of address space, does this code get turned off for 64b?

The windowing code you are talking about defaults as follows:

  Parameter                  32b      64b
  -----------------------------------------
  core.packedGitWindowSize    32M     1G
  core.packedGitLimit        256M     8G

So I doubt you are having issues with the windowing code on a 64b
system, unless your repository is just *huge*.  I did not think that
anyone had a Git repository that exceeded 8G, though the window
size of 1G might be a tad too small if there are many packfiles
and they are each larger than 1G.
 
> > * On the other hand, we could run all try_delta operations for one object
> >   parallel. This way, we would need not very much more memory, but
> >   require more synchronization (and more complex code).
> 
> This solution was my first thought too. Use the main thread to get
> everything needed for the object into RAM, then multi-thread the
> compute bound, in-memory delta search operation. Shared CPU caches
> might make this very fast.

I have been thinking about doing this, especially now that the
default window size is much larger.  I think the default is up as
high as 50, which means we'd keep that shiny new UltraSPARC T2 busy.
Not that I have one...  so anyone from Sun is welcome to send me
one if they want.  ;-)

I'm not sure its that complex to run all try_delta calls of the
current window in parallel.  Might be a simple enough change that
its actually worth the extra complexity, especially with these
multi-core systems being so readily available.  Repacking is the
most CPU intensive operation Git performs, and the one that is also
the easiest to make parallel.

Maybe someone else will beat me to it, but if not I might give such
a patch a shot in a few weeks.

-- 
Shawn.
