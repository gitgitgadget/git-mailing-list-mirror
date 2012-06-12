From: Ted Ts'o <tytso@mit.edu>
Subject: Re: Keeping unreachable objects in a separate pack instead of
 loose?
Date: Tue, 12 Jun 2012 14:37:02 -0400
Message-ID: <20120612183702.GD1803@thunk.org>
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
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Thomas Rast <trast@student.ethz.ch>,
	Hallvard B Furuseth <h.b.furuseth@usit.uio.no>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Tue Jun 12 20:37:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeVxu-00027g-Ii
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 20:37:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753531Ab2FLShM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jun 2012 14:37:12 -0400
Received: from li9-11.members.linode.com ([67.18.176.11]:49389 "EHLO
	imap.thunk.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752525Ab2FLShL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2012 14:37:11 -0400
Received: from root (helo=tytso-glaptop.cam.corp.google.com)
	by imap.thunk.org with local-esmtp (Exim 4.72)
	(envelope-from <tytso@thunk.org>)
	id 1SeVxe-0007IS-Bs; Tue, 12 Jun 2012 18:37:02 +0000
Received: from tytso by tytso-glaptop.cam.corp.google.com with local (Exim 4.71)
	(envelope-from <tytso@thunk.org>)
	id 1SeVxe-0000Yr-A3; Tue, 12 Jun 2012 14:37:02 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.02.1206121359260.23555@xanadu.home>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199829>

On Tue, Jun 12, 2012 at 02:25:47PM -0400, Nicolas Pitre wrote:
> > Earlier in the thread, I outlined another scheme by which you could
> > repack and avoid the duplicates. It does not require changes to git's
> > object lookup process, because it would involve manually feeding the
> > list of cruft objects to pack-objects (which will pack what you ask it,
> > regardless of whether the objects are in other packs).
> 
> That might be hard to achieve good delta compression though, as the main 
> key to sort those objects is their path name, and with unreferenced 
> objects you might not necessarily have that information.  The ability to 
> reuse pack data might mitigate this though.

Compared to loose objects, even not-so-great delta compression is
manna from heaven.  Remember what originally got me to start this
flag.  There was 4.5 megabytes worth of loose objects, that when I
created the object id list and fed the result to git pack-object, the
resulting pack was 244k.

OK, maybe the delta compression wasn't optimal.  Compared to the 4.5
megabytes of loose objects --- I'll happily settle for that!  :-)

> So the problem is really about 'git gc' creating more data on disk which 
> is counter productive for a garbage collecting task.  Maybe the trick is 
> simply not to delete any of the old pack which content was repacked into 
> a single new pack and let them age before deleting them, rather than 
> exploding a bunch of loose objects.  But then we're back to the same 
> issue I wanted to get away from i.e. identifying real cruft packs and 
> making them safely deletable.

But the old packs are huge; in my case, a full set of packs was around
16 megabytes.  Right now, git gc *increased* my disk usage by 4.5
megabytes.  If we don't delete the old backs, then git gc would
increase disk usage by 16 megabytes --- which is far, far worse.

Writing a 244k cruft pack is a soooooo much preferable.

	      	       	  	    - Ted
