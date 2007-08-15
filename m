From: Nicolas Pitre <nico@cam.org>
Subject: Re: performance on repack
Date: Tue, 14 Aug 2007 21:59:36 -0400 (EDT)
Message-ID: <alpine.LFD.0.999.0708142127350.5415@xanadu.home>
References: <9e4733910708111412t48c1beaahfbaa2c68a02f64f1@mail.gmail.com>
 <20070812103338.GA7763@auto.tuwien.ac.at>
 <9e4733910708120649g5a5e0f48pa71bd983f2bc2945@mail.gmail.com>
 <20070814031236.GC27913@spearce.org>
 <alpine.LFD.0.999.0708141634160.5415@xanadu.home>
 <9e4733910708141820n9a09f08h6e104b7469f63375@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Martin Koegler <mkoegler@auto.tuwien.ac.at>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 15 03:59:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IL8Aj-0008Ve-Bh
	for gcvg-git@gmane.org; Wed, 15 Aug 2007 03:59:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757709AbXHOB7l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Aug 2007 21:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751790AbXHOB7l
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Aug 2007 21:59:41 -0400
Received: from relais.videotron.ca ([24.201.245.36]:39601 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756530AbXHOB7k (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2007 21:59:40 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JMS00LOULJELH40@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 14 Aug 2007 21:59:39 -0400 (EDT)
In-reply-to: <9e4733910708141820n9a09f08h6e104b7469f63375@mail.gmail.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55874>

On Tue, 14 Aug 2007, Jon Smirl wrote:

> On 8/14/07, Nicolas Pitre <nico@cam.org> wrote:
> > On Mon, 13 Aug 2007, Shawn O. Pearce wrote:
> >
> > > I'm not sure its that complex to run all try_delta calls of the
> > > current window in parallel.  Might be a simple enough change that
> > > its actually worth the extra complexity, especially with these
> > > multi-core systems being so readily available.  Repacking is the
> > > most CPU intensive operation Git performs, and the one that is also
> > > the easiest to make parallel.
> > >
> > > Maybe someone else will beat me to it, but if not I might give such
> > > a patch a shot in a few weeks.
> >
> > Well, here's my quick attempt at it.  Unfortunately, performance isn't
> > as good as I'd expected, especially with relatively small blobs like
> > those found in the linux kernel repo.  It looks like the overhead of
> > thread creation/joining might be significant compared to the actual
> > delta computation.  I have a P4 with HT which might behave differently
> > from a real SMP machine, or whatever, but the CPU usage never exceeded
> > 110% according to top (sometimes it even dropped below 95%). Actually, a
> > git-repack gets much slower due to 2m27s of system time compared to
> > 0m03s without threads.  And this is with NPTL.
> 
> Thread creation/destruction overhead is way too high to make these
> threads for every delta.
> 
> Another strategy is to create four worker threads once when the
> process is loaded. Then use synchronization primitives to feed the
> threads lumps of work. The threads persist for the life of the
> process.

Still, those synchronization primitives would have to be activated for 
every delta which might also add some overhead.

But there is another issue to consider: delta searching is limited by 
previous results for the same delta.  If first attempt for a delta 
produces a 10x reduction, then the next delta computation has to produce 
less than 1/10 the original object size or it is aborted early. And so 
on for subsequent attempts.  When performing delta computations in 
parallel for the same target then early delta computation abort cannot 
occur since no result is initially available to further limit delta 
processing.

Segmenting the list of objects to deltify into sub-lists for individual 
threads solves both issues.


Nicolas
