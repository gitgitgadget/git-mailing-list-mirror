From: Jeff King <peff@peff.net>
Subject: Re: Keeping unreachable objects in a separate pack instead of loose?
Date: Mon, 11 Jun 2012 13:54:19 -0400
Message-ID: <20120611175419.GB20134@sigill.intra.peff.net>
References: <E1SdhJ9-0006B1-6p@tytso-glaptop.cam.corp.google.com>
 <bb7062f387c9348f702acb53803589f1.squirrel@webmail.uio.no>
 <87vcixaoxe.fsf@thomas.inf.ethz.ch>
 <20120611153103.GA16086@thunk.org>
 <20120611160824.GB12773@sigill.intra.peff.net>
 <alpine.LFD.2.02.1206111249270.23555@xanadu.home>
 <20120611174507.GC16086@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Thomas Rast <trast@student.ethz.ch>,
	Hallvard B Furuseth <h.b.furuseth@usit.uio.no>,
	git@vger.kernel.org
To: Ted Ts'o <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Mon Jun 11 19:54:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Se8ot-0006wG-7L
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 19:54:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751922Ab2FKRyX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jun 2012 13:54:23 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:50188
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751007Ab2FKRyW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 13:54:22 -0400
Received: (qmail 6228 invoked by uid 107); 11 Jun 2012 17:54:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 11 Jun 2012 13:54:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Jun 2012 13:54:19 -0400
Content-Disposition: inline
In-Reply-To: <20120611174507.GC16086@thunk.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199685>

On Mon, Jun 11, 2012 at 01:45:07PM -0400, Ted Ts'o wrote:

> There's another useful part of the two week window, and it's as a
> partial workaround using .git/objects/info/alternates with one or more
> rewinding branches.
> 
> My /usr/projects/e2fsprogs/base repo is a bare repo that contains all
> of my public branches, including a rewinding "pu" branch.
> 
> My /usr/projects/e2fsprogs/e2fsprogs uses an alternates file to
> minimize disk usage, and it points at the base repo.
> 
> The problem comes when I need to gc the base repo, every 3 months or
> so.  When I do that, objects that belonged to older incarnations of
> the rewinding pu branch disappear.  The two week window gives you a
> partial saving throw until development repo breaks due to objects that
> it depends upon disappearing.

You're doing it wrong (but you can hardly be blamed, because there isn't
good tool support for doing it right). You should never prune or repack
in the base repo without taking into account all of the refs of its
children.

We have a similar setup at github (every time you "fork" a repo, it is
creating a new repo that links back to a project-wide "network" repo for
its object store). We maintain a refs/remotes/XXX directory for each
child repo, which stores the complete refs/ hierarchy of that child.

It's all done by a tangled mass of shell scripts. I've considered trying
to clean up and open source them, but I really doubt it would help
people generally. There's so much stuff specific to our setup.

-Peff
