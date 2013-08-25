From: Pete Wyckoff <pw@padd.com>
Subject: Re: git-p4 out of memory for very large repository
Date: Sun, 25 Aug 2013 11:50:01 -0400
Message-ID: <20130825155001.GA875@padd.com>
References: <20130823011245.GA7693@jerec>
 <52170C6A.4080708@diamand.org>
 <20130823114856.GA8182@jerec>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Luke Diamand <luke@diamand.org>, git@vger.kernel.org
To: Corey Thompson <cmtptr@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 25 17:50:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDcZy-0006Ye-J4
	for gcvg-git-2@plane.gmane.org; Sun, 25 Aug 2013 17:50:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756514Ab3HYPuH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Aug 2013 11:50:07 -0400
Received: from honk.padd.com ([74.3.171.149]:41505 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756495Ab3HYPuG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Aug 2013 11:50:06 -0400
Received: from arf.padd.com (unknown [50.105.10.190])
	by honk.padd.com (Postfix) with ESMTPSA id 2D79E6FAE;
	Sun, 25 Aug 2013 08:50:04 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 4988C22935; Sun, 25 Aug 2013 11:50:01 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20130823114856.GA8182@jerec>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232960>

cmtptr@gmail.com wrote on Fri, 23 Aug 2013 07:48 -0400:
> On Fri, Aug 23, 2013 at 08:16:58AM +0100, Luke Diamand wrote:
> > On 23/08/13 02:12, Corey Thompson wrote:
> > >Hello,
> > >
> > >Has anyone actually gotten git-p4 to clone a large Perforce repository?
> > 
> > Yes. I've cloned repos with a couple of Gig of files.
> > 
> > >I have one codebase in particular that gets to about 67%, then
> > >consistently gets get-fast-import (and often times a few other
> > >processes) killed by the OOM killer.
[..]
> Sorry, I guess I could have included more details in my original post.
> Since then, I have also made an attempt to clone another (slightly more
> recent) branch, and at last had success.  So I see this does indeed
> work, it just seems to be very unhappy with one particular branch.
> 
> So, here are a few statistics I collected on the two branches.
> 
> branch-that-fails:
> total workspace disk usage (current head): 12GB
> 68 files over 20MB
> largest three being about 118MB
> 
> branch-that-clones:
> total workspace disk usage (current head): 11GB
> 22 files over 20MB
> largest three being about 80MB
> 
> I suspect that part of the problem here might be that my company likes
> to submit very large binaries into our repo (.tar.gzs, pre-compiled
> third party binaries, etc.).
> 
> Is there any way I can clone this in pieces?  The best I've come up with
> is to clone only up to a change number just before it tends to fail, and
> then rebase to the latest.  My clone succeeded, but the rebase still
> runs out of memory.  It would be great if I could specify a change
> number to rebase up to, so that I can just take this thing a few hundred
> changes at a time.

Modern git, including your version, do "streaming" reads from p4,
so the git-p4 python process never even holds a whole file's
worth of data.  You're seeing git-fast-import die, it seems.  It
will hold onto the entire file contents.  But just one, not the
entire repo.  How big is the single largest file?

You can import in pieces.  See the change numbers like this:

    p4 changes -m 1000 //depot/big/...
    p4 changes -m 1000 //depot/big/...@<some-old-change>

Import something far enough back in history so that it seems
to work:

    git p4 clone --destination=big //depot/big@60602
    cd big

Sync up a bit at a time:

    git p4 sync @60700
    git p4 sync @60800
    ...

I don't expect this to get around the problem you describe,
however.  Sounds like there is one gigantic file that is causing
git-fast-import to fill all of memory.  You will at least isolate
the change.

There are options to git-fast-import to limit max pack size
and to cause it to skip importing files that are too big, if
that would help.

You can also use a client spec to hide the offending files
from git.

Can you watch with "top"?  Hit "M" to sort by memory usage, and
see how big the processes get before falling over.

		-- Pete
