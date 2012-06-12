From: Jeff King <peff@peff.net>
Subject: Re: Keeping unreachable objects in a separate pack instead of loose?
Date: Tue, 12 Jun 2012 15:15:28 -0400
Message-ID: <20120612191528.GB16911@sigill.intra.peff.net>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ted Ts'o <tytso@mit.edu>, Thomas Rast <trast@student.ethz.ch>,
	Hallvard B Furuseth <h.b.furuseth@usit.uio.no>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Tue Jun 12 21:15:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeWZ3-0000EA-3P
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 21:15:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754151Ab2FLTPc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jun 2012 15:15:32 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:51285
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753885Ab2FLTPb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2012 15:15:31 -0400
Received: (qmail 24462 invoked by uid 107); 12 Jun 2012 19:15:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 12 Jun 2012 15:15:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Jun 2012 15:15:28 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.02.1206121359260.23555@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199835>

On Tue, Jun 12, 2012 at 02:25:47PM -0400, Nicolas Pitre wrote:

> My feeling is that we should make a step backward and consider if this 
> is actually the right problem to solve.  I don't remember why I might 
> have been opposed to a reflog for deleted branches as you say I did, but 
> that is certainly a feature that could prove to be useful.

I think your argument was along the lines of "this information can be
reconstructed from the HEAD reflog, anyway, so it is not worth the
effort". My counter to that is that the HEAD reflog is useless on bare
repositories (I have considered adding each pushed ref to a HEAD-like
reflog with everything in it, but doing it without lock contention
between pushes to different refs is tricky).

But keep in mind that a deletion reflog does not make this problem go
away. It might make it less likely, but there are still cases where the
gc can create a much larger object db.

> Then having a repository that can be used as an alternate for other 
> repositories without knowing about it is also a problem that needs 
> fixing and not only because of this object expiry issue.  This is not 
> easy to fix though.

Yeah, I think that is an open problem, because you do not necessarily
have any write access at all to the alternates repository (however, that
does not need to stop us from making it safer in the case that you _do_
have write access to the alternates repository).

> Then, the creation of unreferenced objects from successive 'git add' 
> shouldn't create that many objects in the first place.  They currently 
> never get the chance to be packed to start with.

I don't think these objects are necessarily from successive "git add"s.
That is one source, but they may also come from reflogs expiring. I
guess in that case that they would typically be in an older pack,
though.

> So the problem is really about 'git gc' creating more data on disk which 
> is counter productive for a garbage collecting task.  Maybe the trick is 
> simply not to delete any of the old pack which content was repacked into 
> a single new pack and let them age before deleting them, rather than 
> exploding a bunch of loose objects.  But then we're back to the same 
> issue I wanted to get away from i.e. identifying real cruft packs and 
> making them safely deletable.

That is satisfyingly simple, but the storage requirement is quite bad.
The unreachable objects are very much in the minority, and an occasional
duplication there is not a big deal; duplicating all of the reachable
objects would double the object directory's size.

-Peff
