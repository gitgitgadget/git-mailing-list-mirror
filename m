From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 2/2] Flag and skip over packfiles known to be invalid.
Date: Fri, 2 Feb 2007 03:51:08 -0500
Message-ID: <20070202085108.GC20832@spearce.org>
References: <dda240a4adf0511b3e1ab1eb74abdd28821358b0.1170403175.git.spearce@spearce.org> <20070202080010.GB21094@spearce.org> <7virelhsae.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Feb 02 09:51:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCu8e-0001CR-0S
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 09:51:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932564AbXBBIvQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Feb 2007 03:51:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932801AbXBBIvQ
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 03:51:16 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:43194 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932564AbXBBIvQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Feb 2007 03:51:16 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HCu8W-0001xJ-Eq; Fri, 02 Feb 2007 03:51:12 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 17DAF20FBAE; Fri,  2 Feb 2007 03:51:09 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7virelhsae.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38477>

Junio C Hamano <junkio@cox.net> wrote:
> I haven't looked your patch very closely, but two successive
> "git-repack -a -d" would produce the packfile under the same
> name, but with different parameters (--window or --depth), the
> old .idx and new .pack may not match.
> 
> Can this be possible (time flows from top to bottom):
> 
> 	git-repack -a -d		somebody else
> 
> 	produces a new .pack/.idx
> 
>         mv new .pack to objects/pack
> 
> 					mmap .idx (old)
> 					finds .pack does not match
> 
> 	mv new .idx to objects/pack

Gah.  That's sick.  And *so* totally possible.
 	
> Is this something we care about?
 
Yes and no.

I've pushed the idea that `git repack -a -d` is totally safe to
run in a live repository.  Its clearly not.  *Especially* if you
repack with the same set of objects (as you do above) or if you
repack in rapid succession faster than readers can make progress.
I think both of these are just outside of the realm of "good ideas
to do to live things".

Its like taking your cat to the zoo play with a lion.  Maybe not
the best thing for the cat...


In this particular case that you highlight above this patch would
mark the pack as invalid and never permit it to be accessed again
by the 'somebody else'.

But Git has always been broken for this case.  prepare_packed_git_one
would refuse to open the new index, as it already has a packed_git.
Prior to this patch we'd try to access the packfile and die(),
as it did not match the index that we have.  Now we'd at least
try to locate some other source, or die() over a missing object,
but only after listing the idx/pack mismatch error too.

The only fix for the case above is to unlink the invalid packed_git
from packed_git, so that if we fail to find the object and wind up
calling reprepare_packed_git() we can reload the new index.  I did
consider doing that over the invalid flag, but flipped a coin and
added invalid.  FWIW, maybe invalid is the wrong way to go.


We still have a problem though, as the above case could still
happen to us during the fallback search in read_sha1_file().
In other words two searches ain't enough.  As Dscho pointed out in
the original thread, we probably need to loop until no new packs
are identified before giving up.

I almost submitted a patch to do that tonight, but I couldn't decide
on behavior: should we scan known packs, then try for loose, then
scan packs again until no object or no new pack is found?  Probably.

-- 
Shawn.
