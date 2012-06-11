From: Ted Ts'o <tytso@mit.edu>
Subject: Re: Keeping unreachable objects in a separate pack instead of
 loose?
Date: Mon, 11 Jun 2012 13:45:07 -0400
Message-ID: <20120611174507.GC16086@thunk.org>
References: <E1SdhJ9-0006B1-6p@tytso-glaptop.cam.corp.google.com>
 <bb7062f387c9348f702acb53803589f1.squirrel@webmail.uio.no>
 <87vcixaoxe.fsf@thomas.inf.ethz.ch>
 <20120611153103.GA16086@thunk.org>
 <20120611160824.GB12773@sigill.intra.peff.net>
 <alpine.LFD.2.02.1206111249270.23555@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Thomas Rast <trast@student.ethz.ch>,
	Hallvard B Furuseth <h.b.furuseth@usit.uio.no>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Mon Jun 11 19:45:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Se8gG-0004PC-Ak
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 19:45:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751360Ab2FKRp1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jun 2012 13:45:27 -0400
Received: from li9-11.members.linode.com ([67.18.176.11]:49109 "EHLO
	imap.thunk.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750738Ab2FKRp0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 13:45:26 -0400
Received: from root (helo=tytso-glaptop.cam.corp.google.com)
	by imap.thunk.org with local-esmtp (Exim 4.72)
	(envelope-from <tytso@thunk.org>)
	id 1Se8g2-0003WC-DP; Mon, 11 Jun 2012 17:45:18 +0000
Received: from tytso by tytso-glaptop.cam.corp.google.com with local (Exim 4.71)
	(envelope-from <tytso@thunk.org>)
	id 1Se8fr-00056z-8D; Mon, 11 Jun 2012 13:45:07 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.02.1206111249270.23555@xanadu.home>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199682>

On Mon, Jun 11, 2012 at 01:04:07PM -0400, Nicolas Pitre wrote:
> 
> IIRC, the 2 weeks number was instored when there wasn't any reflog on 
> HEAD and the only way to salvage lost commits was to use 'git fsck 
> --lost-found'.  These days, this is used only as a safety measure 
> because there is always a tiny window during which objects are dangling 
> before they're finally all referenced as you say.  But someone would 
> have to work hard to hit that race even if the delay was only 30 
> seconds.  So realistically this could even be set to 1 hour.

There's another useful part of the two week window, and it's as a
partial workaround using .git/objects/info/alternates with one or more
rewinding branches.

My /usr/projects/e2fsprogs/base repo is a bare repo that contains all
of my public branches, including a rewinding "pu" branch.

My /usr/projects/e2fsprogs/e2fsprogs uses an alternates file to
minimize disk usage, and it points at the base repo.

The problem comes when I need to gc the base repo, every 3 months or
so.  When I do that, objects that belonged to older incarnations of
the rewinding pu branch disappear.  The two week window gives you a
partial saving throw until development repo breaks due to objects that
it depends upon disappearing.

It would be nice if a gc of the devel repo knew that some of the
objects it was depending on were "expired cruft", and copy them to the
its local objects directory.  But of course things don't work that
way.

Here's what I do today (please don't barf; I know it's ugly):

1)  cd to the base repository; run "git repack -Adfl --window=300 --depth=100"

2)  cd to the objects directory, and create my base "cruft" pack:
	find . --name [0-9a-f][0-9a-f] | tr -d / | git pack-objects pack-

3)  hard link it into my devel repo's pack directory:
	ln pack-* /usr/projects/e2fsprogs/e2fsprogs/.git/objects/pack

4) to save space in my base repo, move it to the pack directory and
   run git prune-packed:
	mv pack-* pack
	git prune-packed

4)  run "git repack -Adfl --window=300 --depth=100" in my devel repo

5)  create a cruft pack in my devel repo (to save disk space):
	cd /usr/projects/e2fsprogs/e2fsprogs/.git/objects
	find . --name [0-9a-f][0-9a-f] | tr -d / | git pack-objects pack-
	mv pack-* pack
	git prune-packed

This probably falls in the "don't use --shared unless you know what it
does admonition in the git-clone man page.  :-)

Don't worry, I don't recommend that anyone *else* do this.  But it
works for me (although it would be nice if I made this workflow be a
bit more optimized; at the very least I should make a shell script
that does all this for me automatically, instead of typing all of the
shell commands by hand.)

   	      	     	   - Ted
