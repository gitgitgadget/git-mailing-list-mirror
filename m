From: Ted Ts'o <tytso@mit.edu>
Subject: Re: Keeping unreachable objects in a separate pack instead of
 loose?
Date: Mon, 11 Jun 2012 18:28:43 -0400
Message-ID: <20120611222843.GF21775@thunk.org>
References: <bb7062f387c9348f702acb53803589f1.squirrel@webmail.uio.no>
 <87vcixaoxe.fsf@thomas.inf.ethz.ch>
 <20120611153103.GA16086@thunk.org>
 <20120611160824.GB12773@sigill.intra.peff.net>
 <20120611172732.GB16086@thunk.org>
 <20120611183414.GD20134@sigill.intra.peff.net>
 <20120611211401.GA21775@thunk.org>
 <20120611213948.GB32061@sigill.intra.peff.net>
 <20120611221439.GE21775@thunk.org>
 <20120611222308.GA10476@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>,
	Hallvard B Furuseth <h.b.furuseth@usit.uio.no>,
	git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 12 00:29:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeD6W-0004Hk-MC
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 00:28:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752570Ab2FKW2w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jun 2012 18:28:52 -0400
Received: from li9-11.members.linode.com ([67.18.176.11]:49200 "EHLO
	imap.thunk.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751321Ab2FKW2v (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 18:28:51 -0400
Received: from root (helo=tytso-glaptop.cam.corp.google.com)
	by imap.thunk.org with local-esmtp (Exim 4.72)
	(envelope-from <tytso@thunk.org>)
	id 1SeD6K-0004WJ-7T; Mon, 11 Jun 2012 22:28:44 +0000
Received: from tytso by tytso-glaptop.cam.corp.google.com with local (Exim 4.71)
	(envelope-from <tytso@thunk.org>)
	id 1SeD6J-0006OP-MP; Mon, 11 Jun 2012 18:28:43 -0400
Content-Disposition: inline
In-Reply-To: <20120611222308.GA10476@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199747>

On Mon, Jun 11, 2012 at 06:23:08PM -0400, Jeff King wrote:
> 
> I'm more specifically worried about large objects which are no better in
> packs than they are in loose form (e.g., video files). This strategy is
> a regression, since we are not saving space by putting them in a pack,
> but we are keeping them around much longer. It also makes it harder to
> just run "git prune" to get rid of large objects (since prune will never
> kill off a pack), or to manually delete files from the object database.
> You have to run "git gc --prune=now" instead, so it can make a new pack
> and throw away the old bits (or run "git repack -ad").

If we're really worried about this, we could set a threshold and only
pack small objects in the cruft packs.

> > One last thought: if a sysadmin is really hard up for space, (and if
> > the cruft objects include some really big sound or video files) one
> > advantage of labelling the cruft packs explicitly is that someone who
> > really needs the space could potentially find the oldest cruft files
> > and delete them, since they would be tagged for easy findability.
> 
> No! That's exactly what I was worried about with the name. It is _not_
> safe to do so. It's only safe after you have done a full repack to
> rescue any non-cruft objects.

Well, yes.  I was thinking it would be safe thing to do after a "git
gc" didn't result in enough space savings.  This would require that a
git repack always rescue objects from cruft packs even if the -a/-A
options are not specified, but since we're doing a full reachability
scan, that should slow down git gc much, right?

    					- Ted
