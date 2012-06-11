From: Jeff King <peff@peff.net>
Subject: Re: Keeping unreachable objects in a separate pack instead of loose?
Date: Mon, 11 Jun 2012 14:43:49 -0400
Message-ID: <20120611184349.GE20134@sigill.intra.peff.net>
References: <E1SdhJ9-0006B1-6p@tytso-glaptop.cam.corp.google.com>
 <bb7062f387c9348f702acb53803589f1.squirrel@webmail.uio.no>
 <87vcixaoxe.fsf@thomas.inf.ethz.ch>
 <20120611153103.GA16086@thunk.org>
 <20120611160824.GB12773@sigill.intra.peff.net>
 <alpine.LFD.2.02.1206111249270.23555@xanadu.home>
 <20120611174507.GC16086@thunk.org>
 <20120611175419.GB20134@sigill.intra.peff.net>
 <20120611182012.GD16086@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Thomas Rast <trast@student.ethz.ch>,
	Hallvard B Furuseth <h.b.furuseth@usit.uio.no>,
	git@vger.kernel.org
To: Ted Ts'o <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Mon Jun 11 20:44:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Se9am-0005Dz-N9
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 20:43:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752931Ab2FKSnx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jun 2012 14:43:53 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:50239
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752070Ab2FKSnw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 14:43:52 -0400
Received: (qmail 7178 invoked by uid 107); 11 Jun 2012 18:43:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 11 Jun 2012 14:43:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Jun 2012 14:43:49 -0400
Content-Disposition: inline
In-Reply-To: <20120611182012.GD16086@thunk.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199693>

On Mon, Jun 11, 2012 at 02:20:12PM -0400, Ted Ts'o wrote:

> On Mon, Jun 11, 2012 at 01:54:19PM -0400, Jeff King wrote:
> > 
> > You're doing it wrong (but you can hardly be blamed, because there isn't
> > good tool support for doing it right). You should never prune or repack
> > in the base repo without taking into account all of the refs of its
> > children.
> 
> Well, I don't do a simple gc.  See the complicated set of steps I use
> to make sure I don't lose loose commits at the end of my last e-mail
> message on this thread.  It gets worse when I have multiple devel
> repos, but I simplified things for the purposes of discussion.

Ah, right. I was thinking that your first step, which is "git repack
-Adfl", would throw out old objects rather than unpack them in recent
versions of git.  But due to the way I implemented it (namely that you
must pass --unpack-unreachable yourself, so this feature only kicks in
automatically for "git gc"), that is not the case.

I don't recall if that was an accident, or if I was very clever in
maintaining backwards compatibility for your case. Let's just assume the
latter. :)

> > We have a similar setup at github (every time you "fork" a repo, it is
> > creating a new repo that links back to a project-wide "network" repo for
> > its object store). We maintain a refs/remotes/XXX directory for each
> > child repo, which stores the complete refs/ hierarchy of that child.
> 
> So you basically are copying the refs around and making sure the
> parent repo has an uptodate pointer of all of the child repos, such
> that when you do the repack, *all* of the commits end up in the parent
> commit, correct?

Yes. The child repositories generally have no objects in them at all
(they occasionally do for a period between runs of the migration
script).

> The system that I'm using means that objects which are local to a
> child repo stays in the child repo, and if an object is about to be
> dropped from the parent repo as a result of a gc, the child repo has
> an opportunity claim a copy of that object for itself in its object
> database.

That implies the concept of "local to a child repo", which implies that
you have some set of "common" refs. I suspect in your case your base
repo represents the master branch, or something similar. We actually
treat our network repo as a pure parent; every repo, including the
original one that everybody forks from, is a child. That makes it easier
to treat the original repo as just another repo (e.g., the original
owner is free to delete it, and the forks won't care).

> You can do things either way.  I like knowing that objects only used
> by a child repo are in the child repo's .git directory, but that's
> arguably more of a question of taste than anything else.

Yeah, I don't think there is any real benefit to it.

-Peff
