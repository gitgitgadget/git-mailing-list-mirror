From: Jeff King <peff@peff.net>
Subject: Re: Keeping unreachable objects in a separate pack instead of loose?
Date: Tue, 12 Jun 2012 15:23:18 -0400
Message-ID: <20120612192318.GC16911@sigill.intra.peff.net>
References: <20120611221439.GE21775@thunk.org>
 <20120611222308.GA10476@sigill.intra.peff.net>
 <alpine.LFD.2.02.1206112024110.23555@xanadu.home>
 <20120612171048.GB12706@sigill.intra.peff.net>
 <alpine.LFD.2.02.1206121326490.23555@xanadu.home>
 <20120612173214.GA16014@sigill.intra.peff.net>
 <CAJo=hJvMtfVhadYowvVE0zUhDpbViXqGsvkmHpJpuynySLwb3A@mail.gmail.com>
 <20120612175046.GA16522@sigill.intra.peff.net>
 <m2fwa0fk0y.fsf@igel.home>
 <alpine.LFD.2.02.1206121507120.23555@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Shawn Pearce <spearce@spearce.org>, Ted Ts'o <tytso@mit.edu>,
	Thomas Rast <trast@student.ethz.ch>,
	Hallvard B Furuseth <h.b.furuseth@usit.uio.no>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Tue Jun 12 21:23:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeWgW-0002ok-OK
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 21:23:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752773Ab2FLTXV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jun 2012 15:23:21 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:51297
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752061Ab2FLTXU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2012 15:23:20 -0400
Received: (qmail 24648 invoked by uid 107); 12 Jun 2012 19:23:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 12 Jun 2012 15:23:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Jun 2012 15:23:18 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.02.1206121507120.23555@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199838>

On Tue, Jun 12, 2012 at 03:09:25PM -0400, Nicolas Pitre wrote:

> > Jeff King <peff@peff.net> writes:
> > 
> > > We could close it in both cases by tweaking the mtime of the file
> > > containing the object when we decide not to write because the object
> > > already exists.
> > 
> > Though there is always the window between the existence check and the
> > mtime update where pruning can hit you.
> 
> This is a tiny window compared to 2 weeks.

I don't think the race window is actually 2 weeks long. If you have this
sequence:

  1. object X becomes unreferenced

  2. 1 week later, you create a new ref that mentions X

  3. >2 weeks later, you run "git prune --expire=2.weeks.ago"

we will not consider the object for pruning in step 3, because it is
reachable. The race is more like:

  1. object X becomes unreferenced

  2. >2 weeks later, you run "git prune --expire=2.weeks.ago"

  3. git-prune reads the list of refs

  4. simultaneous to the git-prune, you reference X

  5. git-prune removes X

  6. your reference is now broken

So the race window depends on the time it takes "git prune" to run.

I wonder if git-prune could do a double-check of the refs. Something
like:

  1. calculate reachability on all refs

  2. read list of objects to prune, and make a list of unreachable ones

  3. calculate reachability again (which should be very cheap, because
     you can stop when you get to an object you have already seen)

  4. Drop any objects found in (3) from the list in (2), and delete
     items from your list

But I think that still has a race where objects are created before
step 2, but are not actually referenced until after step 3. I think
doing it safely may actually require a repo-wide prune lock.

-Peff
