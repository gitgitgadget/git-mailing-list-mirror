From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Keeping unreachable objects in a separate pack instead of loose?
Date: Tue, 12 Jun 2012 13:57:53 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1206121356480.23555@xanadu.home>
References: <20120611183414.GD20134@sigill.intra.peff.net>
 <20120611211401.GA21775@thunk.org>
 <20120611213948.GB32061@sigill.intra.peff.net>
 <20120611221439.GE21775@thunk.org>
 <20120611222308.GA10476@sigill.intra.peff.net>
 <alpine.LFD.2.02.1206112024110.23555@xanadu.home>
 <20120612171048.GB12706@sigill.intra.peff.net>
 <alpine.LFD.2.02.1206121326490.23555@xanadu.home>
 <20120612173214.GA16014@sigill.intra.peff.net>
 <CAJo=hJvMtfVhadYowvVE0zUhDpbViXqGsvkmHpJpuynySLwb3A@mail.gmail.com>
 <20120612175046.GA16522@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Shawn Pearce <spearce@spearce.org>, Ted Ts'o <tytso@mit.edu>,
	Thomas Rast <trast@student.ethz.ch>,
	Hallvard B Furuseth <h.b.furuseth@usit.uio.no>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 12 19:58:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeVLr-0006i9-Fr
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 19:57:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753979Ab2FLR5y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jun 2012 13:57:54 -0400
Received: from relais.videotron.ca ([24.201.245.36]:12226 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753946Ab2FLR5x (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2012 13:57:53 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-VM-MR004.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0M5I00AGMN8HSA60@VL-VM-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 12 Jun 2012 13:57:53 -0400 (EDT)
In-reply-to: <20120612175046.GA16522@sigill.intra.peff.net>
User-Agent: Alpine 2.02 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199823>

On Tue, 12 Jun 2012, Jeff King wrote:

> On Tue, Jun 12, 2012 at 10:45:22AM -0700, Shawn O. Pearce wrote:
> 
> > > Then those objects will remain in the cruft pack. Which is why, as I
> > > said, it is not generally safe to just delete a cruft pack. However,
> > > when you do a full repack, those objects will be copied into the new
> > > pack (because they are referenced). Which is why I am claiming that it
> > > is safe to remove cruft packs at that point.
> > 
> > But there is a race condition with a concurrent fetch and a concurrent
> > repack. If that fetch needs those cruft objects, and sees them in the
> > cruft pack, and the repack sees the references before the fetch, the
> > repacker might delete things the fetch is about to reference and that
> > will leave you with a corrupt repository.
> > 
> > I think we already have this race condition with loose unreachable
> > objects whose mtimes are older than 2 weeks; they are removed by prune
> > but may have just become reachable by a concurrent fetch that doesn't
> > overwrite them because they already exist, and doesn't update the
> > mtime because they aren't writable.
> 
> Correct. There is a race condition, but it is there already. I have
> discussed this with other GitHub folks, because we prune fairly
> aggressively (in our case it would be a push, not a fetch, of course).
> So far we have not had any record of it actually happening in practice.
> 
> We could close it in both cases by tweaking the mtime of the file
> containing the object when we decide not to write because the object
> already exists.

Yes, that is a worthwhile thing to do.


Nicolas
