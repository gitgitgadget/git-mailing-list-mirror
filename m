From: Ted Ts'o <tytso@mit.edu>
Subject: Re: Keeping unreachable objects in a separate pack instead of
 loose?
Date: Mon, 11 Jun 2012 18:14:39 -0400
Message-ID: <20120611221439.GE21775@thunk.org>
References: <E1SdhJ9-0006B1-6p@tytso-glaptop.cam.corp.google.com>
 <bb7062f387c9348f702acb53803589f1.squirrel@webmail.uio.no>
 <87vcixaoxe.fsf@thomas.inf.ethz.ch>
 <20120611153103.GA16086@thunk.org>
 <20120611160824.GB12773@sigill.intra.peff.net>
 <20120611172732.GB16086@thunk.org>
 <20120611183414.GD20134@sigill.intra.peff.net>
 <20120611211401.GA21775@thunk.org>
 <20120611213948.GB32061@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>,
	Hallvard B Furuseth <h.b.furuseth@usit.uio.no>,
	git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 12 00:14:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeCsu-0003js-UV
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 00:14:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752550Ab2FKWOt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jun 2012 18:14:49 -0400
Received: from li9-11.members.linode.com ([67.18.176.11]:49190 "EHLO
	imap.thunk.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751019Ab2FKWOs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 18:14:48 -0400
Received: from root (helo=tytso-glaptop.cam.corp.google.com)
	by imap.thunk.org with local-esmtp (Exim 4.72)
	(envelope-from <tytso@thunk.org>)
	id 1SeCsh-0004T8-LJ; Mon, 11 Jun 2012 22:14:39 +0000
Received: from tytso by tytso-glaptop.cam.corp.google.com with local (Exim 4.71)
	(envelope-from <tytso@thunk.org>)
	id 1SeCsh-0006BH-3D; Mon, 11 Jun 2012 18:14:39 -0400
Content-Disposition: inline
In-Reply-To: <20120611213948.GB32061@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199745>

On Mon, Jun 11, 2012 at 05:39:48PM -0400, Jeff King wrote:
> 
> Yeah. It doesn't eliminate duplicates, but that may not be worth caring
> about. I find the "cruft" marking a little hacky, because it is only
> "objects in here _may_ be cruft", but as long as that is understood, it
> is OK (and it is understood in the sequence above; "repack -Ad" is safe
> because it knows that it would have repacked any non-cruft).

Well, all the objects in the file *were* cruft at the time that it was
created.  And the reason why we are keeping them around is in case we
were wrong about their being cruft, so I guess I don't have that much
trouble with the name.  Something like "KillShelter" (as in the
opposite of No-Kill Animal Shelters) would be more discriptive, but I
think it's a bit lacking in taste....

> > It does imply that we may accumulate a new cruft-<SHA1> pack each time
> > we run git gc, but users shouldn't be running git gc all that often
> > anyway.  And even if they do run it all the time, it will still be
> > more efficient than keeping the unreachable objects as loose objects.
> 
> Yeah, it would be nice to keep it all in a single pack, but that means
> doing the I/O on rewriting the cruft packs each time. And figuring out
> some way of handling the mtime in such a way that we don't keep
> refreshing the age during each gc.

Well, I'd like to avoid doing the I/O because I want to minimize wear
on SSD drives; and given that it's unlikely that the cruft packs will
be referenced, the fact that we have a bunch of cruft packs shouldn't
be a big deal, especially if we teach git to search the cruft packs
last.

> Speaking of which, what is the mtime of the newly created cruft pack? Is
> it the current mtime? Then those unreachable objects will stick for
> another 2 weeks, instead of being back-dated to their pack's date. You
> could back-date to the mtime of the most recent deleted pack, but that
> would still prolong the life of objects from the older packs. It may be
> acceptable to just ignore the issue, though; they will expire
> eventually.

Well, we have that problem today when "git pack-objects
--unpack-unreachable" explodes unreferenced objects --- they are
written with the current mtime.  I assume you're worried about
pre-existing loose objects that get collected up into a new cruft
pack, since they would get the extra two weeks of life.  Given how
much more efficient storing the cruft objects in a pack, I think
ignoring the issue is what makes the most amount of sense, since it's
a one-time extension, and the extra objects really won't do any harm.

One last thought: if a sysadmin is really hard up for space, (and if
the cruft objects include some really big sound or video files) one
advantage of labelling the cruft packs explicitly is that someone who
really needs the space could potentially find the oldest cruft files
and delete them, since they would be tagged for easy findability.

    	   	       	    	     	    - Ted
