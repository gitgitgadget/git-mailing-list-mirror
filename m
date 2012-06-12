From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Keeping unreachable objects in a separate pack instead of loose?
Date: Tue, 12 Jun 2012 14:25:47 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1206121359260.23555@xanadu.home>
References: <20120611183414.GD20134@sigill.intra.peff.net>
 <20120611211401.GA21775@thunk.org>
 <20120611213948.GB32061@sigill.intra.peff.net>
 <20120611221439.GE21775@thunk.org>
 <20120611222308.GA10476@sigill.intra.peff.net>
 <alpine.LFD.2.02.1206112024110.23555@xanadu.home>
 <20120612171048.GB12706@sigill.intra.peff.net>
 <alpine.LFD.2.02.1206121326490.23555@xanadu.home>
 <20120612173214.GA16014@sigill.intra.peff.net>
 <alpine.LFD.2.02.1206121345500.23555@xanadu.home>
 <20120612175438.GB16522@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Ted Ts'o <tytso@mit.edu>, Thomas Rast <trast@student.ethz.ch>,
	Hallvard B Furuseth <h.b.furuseth@usit.uio.no>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 12 20:25:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeVmq-00055c-QC
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 20:25:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753594Ab2FLSZt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jun 2012 14:25:49 -0400
Received: from relais.videotron.ca ([24.201.245.36]:24563 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753221Ab2FLSZs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2012 14:25:48 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-VM-MR003.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0M5I000XPOIZV6A0@VL-VM-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 12 Jun 2012 14:25:47 -0400 (EDT)
In-reply-to: <20120612175438.GB16522@sigill.intra.peff.net>
User-Agent: Alpine 2.02 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199828>

On Tue, 12 Jun 2012, Jeff King wrote:

> On Tue, Jun 12, 2012 at 01:49:26PM -0400, Nicolas Pitre wrote:
> 
> > > Then those objects will remain in the cruft pack. Which is why, as I
> > > said, it is not generally safe to just delete a cruft pack.
> > 
> > ... and my reply was about the needed changes to still make cruft packs 
> > always crufty even if some of its content suddenly becomes useful again.
> 
> I think we are somehow missing each other's point, then. My point is
> that you do not _need_ to make the cruft packs 100% cruft. You can
> tolerate the duplicated objects until they are pruned.

Absolutely.  Duplicated objectes are fine, and I was in fact suggesting 
to actively duplicate any needed object when it is to be found in a 
cruft pack only.

> Earlier in the thread, I outlined another scheme by which you could
> repack and avoid the duplicates. It does not require changes to git's
> object lookup process, because it would involve manually feeding the
> list of cruft objects to pack-objects (which will pack what you ask it,
> regardless of whether the objects are in other packs).

That might be hard to achieve good delta compression though, as the main 
key to sort those objects is their path name, and with unreferenced 
objects you might not necessarily have that information.  The ability to 
reuse pack data might mitigate this though.

> > > However, when you do a full repack, those objects will be copied into 
> > > the new pack (because they are referenced). Which is why I am claiming 
> > > that it is safe to remove cruft packs at that point.
> > 
> > Yes, but then there is no point marking such packs as cruft if at any 
> > moment they can become useful again.
> 
> How do you know to keep the packs around and expire them after 2 weeks
> if they are not marked in some way? Otherwise you would delete them as
> part of a "git gc", pushing the reachable objects into the new pack and
> the unreachable objects into a new cruft pack. IOW, you need some way of
> keeping the expiration date on the unreachable objects, or they will
> keep getting "refreshed" by each gc.

My feeling is that we should make a step backward and consider if this 
is actually the right problem to solve.  I don't remember why I might 
have been opposed to a reflog for deleted branches as you say I did, but 
that is certainly a feature that could prove to be useful.

Then having a repository that can be used as an alternate for other 
repositories without knowing about it is also a problem that needs 
fixing and not only because of this object expiry issue.  This is not 
easy to fix though.

Then, the creation of unreferenced objects from successive 'git add' 
shouldn't create that many objects in the first place.  They currently 
never get the chance to be packed to start with.

So the problem is really about 'git gc' creating more data on disk which 
is counter productive for a garbage collecting task.  Maybe the trick is 
simply not to delete any of the old pack which content was repacked into 
a single new pack and let them age before deleting them, rather than 
exploding a bunch of loose objects.  But then we're back to the same 
issue I wanted to get away from i.e. identifying real cruft packs and 
making them safely deletable.

Oh well...


Nicolas
