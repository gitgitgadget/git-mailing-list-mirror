From: Ted Ts'o <tytso@mit.edu>
Subject: Re: Keeping unreachable objects in a separate pack instead of
 loose?
Date: Mon, 11 Jun 2012 17:14:01 -0400
Message-ID: <20120611211401.GA21775@thunk.org>
References: <E1SdhJ9-0006B1-6p@tytso-glaptop.cam.corp.google.com>
 <bb7062f387c9348f702acb53803589f1.squirrel@webmail.uio.no>
 <87vcixaoxe.fsf@thomas.inf.ethz.ch>
 <20120611153103.GA16086@thunk.org>
 <20120611160824.GB12773@sigill.intra.peff.net>
 <20120611172732.GB16086@thunk.org>
 <20120611183414.GD20134@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>,
	Hallvard B Furuseth <h.b.furuseth@usit.uio.no>,
	git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 11 23:14:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeBwF-0003U2-NZ
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 23:14:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751801Ab2FKVOL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jun 2012 17:14:11 -0400
Received: from li9-11.members.linode.com ([67.18.176.11]:49171 "EHLO
	imap.thunk.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751120Ab2FKVOK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 17:14:10 -0400
Received: from root (helo=tytso-glaptop.cam.corp.google.com)
	by imap.thunk.org with local-esmtp (Exim 4.72)
	(envelope-from <tytso@thunk.org>)
	id 1SeBw2-0004GH-Lw; Mon, 11 Jun 2012 21:14:02 +0000
Received: from tytso by tytso-glaptop.cam.corp.google.com with local (Exim 4.71)
	(envelope-from <tytso@thunk.org>)
	id 1SeBw1-0005hW-JV; Mon, 11 Jun 2012 17:14:01 -0400
Content-Disposition: inline
In-Reply-To: <20120611183414.GD20134@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199732>

On Mon, Jun 11, 2012 at 02:34:14PM -0400, Jeff King wrote:
> You _could_ make a separate cruft pack for each pack that you repack. So
> if I have A.pack and B.pack, I'd pack all of the reachable objects into
> C.pack, and then make D.pack containing the unreachable objects from
> A.pack, and E.pack with the unreachable objects from B.pack. And then
> set the mtime of the cruft packs to that of their parent packs.
> 
> And then the next time you pack, repacking D and E would probably be a
> no-op that preserves mtime, but might create a new pack that ejects some
> now-reachable object.
> 
> To implement that, I think your --list-unreachable would just have to
> print a list of "<pack-mtime> <sha1>" pairs, and then you would pack
> each set with an identical mtime (or even a "close enough" mtime within
> some slop)....

How about this instead?  We distinguish between cruft packs and "real"
packs by the filename.  So we have "cruft-<SHA1>.{idx,pack}" and
"pack-<SHA1>.{idx.pack}".

Normally, git will look at any pack in the pack directory that has an
.idx and .pack extension, but during repack operation, it will by only
look in the pack-* packs first.  If it can't find an object there, it
will then fall back to trying to fetch the object from the cruft-*
packs, and if it finds the object, it copies it into the new pack
which is creating, thus "rescueing" an object which reappears during
the expiry window.  This should be a relatively rare event, and if it
happens, the object will be in two packs, a pack-* pack and a cruft-*
pack, but that's OK.

So since git pack-objects isn't even looking in the cruft-* packs
except when it needs to rescue an object, the objects in the cruft-*
packs won't get copied, and we won't need to have per-object mtimes.
It also means it will go faster since it's not copying the cruft-*
packs at all, and possibly not even looking at them.

Now all we need to do is delete any cruft-* packs which are older than
the expiry window.  We don't even need to look at their contents.

It does imply that we may accumulate a new cruft-<SHA1> pack each time
we run git gc, but users shouldn't be running git gc all that often
anyway.  And even if they do run it all the time, it will still be
more efficient than keeping the unreachable objects as loose objects.

     	       	    	    		    	    - Ted
