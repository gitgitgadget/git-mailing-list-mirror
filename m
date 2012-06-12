From: Jeff King <peff@peff.net>
Subject: Re: Keeping unreachable objects in a separate pack instead of loose?
Date: Tue, 12 Jun 2012 15:41:26 -0400
Message-ID: <20120612194126.GA17519@sigill.intra.peff.net>
References: <alpine.LFD.2.02.1206112024110.23555@xanadu.home>
 <20120612171048.GB12706@sigill.intra.peff.net>
 <alpine.LFD.2.02.1206121326490.23555@xanadu.home>
 <20120612173214.GA16014@sigill.intra.peff.net>
 <CAJo=hJvMtfVhadYowvVE0zUhDpbViXqGsvkmHpJpuynySLwb3A@mail.gmail.com>
 <20120612175046.GA16522@sigill.intra.peff.net>
 <m2fwa0fk0y.fsf@igel.home>
 <alpine.LFD.2.02.1206121507120.23555@xanadu.home>
 <20120612192318.GC16911@sigill.intra.peff.net>
 <alpine.LFD.2.02.1206121536570.23555@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Shawn Pearce <spearce@spearce.org>, Ted Ts'o <tytso@mit.edu>,
	Thomas Rast <trast@student.ethz.ch>,
	Hallvard B Furuseth <h.b.furuseth@usit.uio.no>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Tue Jun 12 21:41:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeWy5-0007zb-Oh
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 21:41:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752061Ab2FLTla (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jun 2012 15:41:30 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:51317
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751234Ab2FLTl2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2012 15:41:28 -0400
Received: (qmail 25190 invoked by uid 107); 12 Jun 2012 19:41:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 12 Jun 2012 15:41:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Jun 2012 15:41:26 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.02.1206121536570.23555@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199842>

On Tue, Jun 12, 2012 at 03:39:05PM -0400, Nicolas Pitre wrote:

> > So the race window depends on the time it takes "git prune" to run.
> > 
> > I wonder if git-prune could do a double-check of the refs. Something
> > like:
> > 
> >   1. calculate reachability on all refs
> > 
> >   2. read list of objects to prune, and make a list of unreachable ones
> > 
> >   3. calculate reachability again (which should be very cheap, because
> >      you can stop when you get to an object you have already seen)
> > 
> >   4. Drop any objects found in (3) from the list in (2), and delete
> >      items from your list
> > 
> > But I think that still has a race where objects are created before
> > step 2, but are not actually referenced until after step 3. I think
> > doing it safely may actually require a repo-wide prune lock.
> 
> Yeah... that's what I was thinking too.  Maybe we're making our life 
> overly miserable by trying to avoid any locking here.

I think I would be OK with "prune" locking, as long as everything else
was able to happen simultaneously. Especially if we can keep prune's
lock as short as possible through double-reads or similar tricks (like
we do for ref updates).

-Peff
