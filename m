From: Jeff King <peff@peff.net>
Subject: Re: Keeping unreachable objects in a separate pack instead of loose?
Date: Tue, 12 Jun 2012 15:07:17 -0400
Message-ID: <20120612190717.GA16911@sigill.intra.peff.net>
References: <20120611213948.GB32061@sigill.intra.peff.net>
 <20120611221439.GE21775@thunk.org>
 <20120611222308.GA10476@sigill.intra.peff.net>
 <alpine.LFD.2.02.1206112024110.23555@xanadu.home>
 <20120612171048.GB12706@sigill.intra.peff.net>
 <alpine.LFD.2.02.1206121326490.23555@xanadu.home>
 <20120612173214.GA16014@sigill.intra.peff.net>
 <CAJo=hJvMtfVhadYowvVE0zUhDpbViXqGsvkmHpJpuynySLwb3A@mail.gmail.com>
 <20120612175046.GA16522@sigill.intra.peff.net>
 <m2fwa0fk0y.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Shawn Pearce <spearce@spearce.org>,
	Nicolas Pitre <nico@fluxnic.net>, Ted Ts'o <tytso@mit.edu>,
	Thomas Rast <trast@student.ethz.ch>,
	Hallvard B Furuseth <h.b.furuseth@usit.uio.no>,
	git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Tue Jun 12 21:07:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeWR8-00049K-GK
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 21:07:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754049Ab2FLTHW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jun 2012 15:07:22 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:51272
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752052Ab2FLTHU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2012 15:07:20 -0400
Received: (qmail 24296 invoked by uid 107); 12 Jun 2012 19:07:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 12 Jun 2012 15:07:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Jun 2012 15:07:17 -0400
Content-Disposition: inline
In-Reply-To: <m2fwa0fk0y.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199833>

On Tue, Jun 12, 2012 at 08:43:41PM +0200, Andreas Schwab wrote:

> Jeff King <peff@peff.net> writes:
> 
> > We could close it in both cases by tweaking the mtime of the file
> > containing the object when we decide not to write because the object
> > already exists.
> 
> Though there is always the window between the existence check and the
> mtime update where pruning can hit you.

For the loose object case, you could do them both atomically by calling
utime() on the object, and considering the object to exist only if it
succeeds.

Doing it safely for packs would be harder, though; I think you'd
have to bump the mtime forward, do the search, and then bump it back.
You might err by causing a pack not to be pruned, but that is better
than the opposite.

Unfortunately it gets trickier with network transfers. If somebody is
pushing to your repository, you might tell them you have some set of
objects, then they prepare a pack based on that assumption (which might
take minutes or hours to transfer), and then finally at the end you find
that you actually need the objects in question. Of course, that race is
even harder to trigger, because we do not advertise unreachable objects.
So you would have to have a sequence where the objects are reachable,
the client connects and receives your ref advertisement, then the
objects become unreachable (e.g., due to a simultaneous non-ff push or
deletion), and you do a prune in that interval which removes the
objects.  Unlikely, but still possible.

-Peff
