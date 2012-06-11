From: Ted Ts'o <tytso@mit.edu>
Subject: Re: Keeping unreachable objects in a separate pack instead of
 loose?
Date: Mon, 11 Jun 2012 14:20:12 -0400
Message-ID: <20120611182012.GD16086@thunk.org>
References: <E1SdhJ9-0006B1-6p@tytso-glaptop.cam.corp.google.com>
 <bb7062f387c9348f702acb53803589f1.squirrel@webmail.uio.no>
 <87vcixaoxe.fsf@thomas.inf.ethz.ch>
 <20120611153103.GA16086@thunk.org>
 <20120611160824.GB12773@sigill.intra.peff.net>
 <alpine.LFD.2.02.1206111249270.23555@xanadu.home>
 <20120611174507.GC16086@thunk.org>
 <20120611175419.GB20134@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Thomas Rast <trast@student.ethz.ch>,
	Hallvard B Furuseth <h.b.furuseth@usit.uio.no>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 11 20:20:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Se9EB-0004z8-CL
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 20:20:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752053Ab2FKSUb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jun 2012 14:20:31 -0400
Received: from li9-11.members.linode.com ([67.18.176.11]:49119 "EHLO
	imap.thunk.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751954Ab2FKSUa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 14:20:30 -0400
Received: from root (helo=tytso-glaptop.cam.corp.google.com)
	by imap.thunk.org with local-esmtp (Exim 4.72)
	(envelope-from <tytso@thunk.org>)
	id 1Se9Dz-0003dy-8g; Mon, 11 Jun 2012 18:20:23 +0000
Received: from tytso by tytso-glaptop.cam.corp.google.com with local (Exim 4.71)
	(envelope-from <tytso@thunk.org>)
	id 1Se9Do-00059Y-3A; Mon, 11 Jun 2012 14:20:12 -0400
Content-Disposition: inline
In-Reply-To: <20120611175419.GB20134@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199689>

On Mon, Jun 11, 2012 at 01:54:19PM -0400, Jeff King wrote:
> 
> You're doing it wrong (but you can hardly be blamed, because there isn't
> good tool support for doing it right). You should never prune or repack
> in the base repo without taking into account all of the refs of its
> children.

Well, I don't do a simple gc.  See the complicated set of steps I use
to make sure I don't lose loose commits at the end of my last e-mail
message on this thread.  It gets worse when I have multiple devel
repos, but I simplified things for the purposes of discussion.

> We have a similar setup at github (every time you "fork" a repo, it is
> creating a new repo that links back to a project-wide "network" repo for
> its object store). We maintain a refs/remotes/XXX directory for each
> child repo, which stores the complete refs/ hierarchy of that child.

So you basically are copying the refs around and making sure the
parent repo has an uptodate pointer of all of the child repos, such
that when you do the repack, *all* of the commits end up in the parent
commit, correct?

The system that I'm using means that objects which are local to a
child repo stays in the child repo, and if an object is about to be
dropped from the parent repo as a result of a gc, the child repo has
an opportunity claim a copy of that object for itself in its object
database.

You can do things either way.  I like knowing that objects only used
by a child repo are in the child repo's .git directory, but that's
arguably more of a question of taste than anything else.

	      	   	       	     - Ted
