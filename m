From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Keeping unreachable objects in a separate pack instead of loose?
Date: Tue, 12 Jun 2012 15:15:46 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1206121509340.23555@xanadu.home>
References: <20120611213948.GB32061@sigill.intra.peff.net>
 <20120611221439.GE21775@thunk.org>
 <20120611222308.GA10476@sigill.intra.peff.net>
 <alpine.LFD.2.02.1206112024110.23555@xanadu.home>
 <20120612171048.GB12706@sigill.intra.peff.net>
 <alpine.LFD.2.02.1206121326490.23555@xanadu.home>
 <20120612173214.GA16014@sigill.intra.peff.net>
 <alpine.LFD.2.02.1206121345500.23555@xanadu.home>
 <20120612175438.GB16522@sigill.intra.peff.net>
 <alpine.LFD.2.02.1206121359260.23555@xanadu.home>
 <20120612183702.GD1803@thunk.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jeff King <peff@peff.net>, Thomas Rast <trast@student.ethz.ch>,
	Hallvard B Furuseth <h.b.furuseth@usit.uio.no>,
	git@vger.kernel.org
To: Ted Ts'o <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Tue Jun 12 21:16:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeWZH-0000mi-7z
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 21:15:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754172Ab2FLTPr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jun 2012 15:15:47 -0400
Received: from relais.videotron.ca ([24.201.245.36]:37087 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754168Ab2FLTPq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2012 15:15:46 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-VM-MR002.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0M5I00MA0QUAE710@VL-VM-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 12 Jun 2012 15:15:46 -0400 (EDT)
In-reply-to: <20120612183702.GD1803@thunk.org>
User-Agent: Alpine 2.02 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199836>

On Tue, 12 Jun 2012, Ted Ts'o wrote:

> On Tue, Jun 12, 2012 at 02:25:47PM -0400, Nicolas Pitre wrote:
> > > Earlier in the thread, I outlined another scheme by which you could
> > > repack and avoid the duplicates. It does not require changes to git's
> > > object lookup process, because it would involve manually feeding the
> > > list of cruft objects to pack-objects (which will pack what you ask it,
> > > regardless of whether the objects are in other packs).
> > 
> > That might be hard to achieve good delta compression though, as the main 
> > key to sort those objects is their path name, and with unreferenced 
> > objects you might not necessarily have that information.  The ability to 
> > reuse pack data might mitigate this though.
> 
> Compared to loose objects, even not-so-great delta compression is
> manna from heaven.  Remember what originally got me to start this
> flag.  There was 4.5 megabytes worth of loose objects, that when I
> created the object id list and fed the result to git pack-object, the
> resulting pack was 244k.
> 
> OK, maybe the delta compression wasn't optimal.  Compared to the 4.5
> megabytes of loose objects --- I'll happily settle for that!  :-)

Sure.  However I would be even happier if we could delete those unneeded 
objects outright.  The official reason why they're there for two weeks 
should be to avoid some race conditions, and in this case two weeks is 
way over the top as in "normal" conditions the actual window for a race 
is in the order of a few seconds..  Any other use case should be 
considered abusive.

> > So the problem is really about 'git gc' creating more data on disk which 
> > is counter productive for a garbage collecting task.  Maybe the trick is 
> > simply not to delete any of the old pack which content was repacked into 
> > a single new pack and let them age before deleting them, rather than 
> > exploding a bunch of loose objects.  But then we're back to the same 
> > issue I wanted to get away from i.e. identifying real cruft packs and 
> > making them safely deletable.
> 
> But the old packs are huge; in my case, a full set of packs was around
> 16 megabytes.  Right now, git gc *increased* my disk usage by 4.5
> megabytes.  If we don't delete the old backs, then git gc would
> increase disk usage by 16 megabytes --- which is far, far worse.
> 
> Writing a 244k cruft pack is a soooooo much preferable.

But as you might have noticed, there are a bunch of semantic problems 
with that as well.


Nicolas
