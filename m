From: Theodore Tso <tytso@mit.edu>
Subject: Re: [RFC PATCH] repack: make repack -a equivalent to repack -A and
	drop previous -a behavior
Date: Thu, 13 Nov 2008 21:22:31 -0500
Message-ID: <20081114022231.GB25117@mit.edu>
References: <7xh1_tFsJkHTjg4Hjm-R4mGSRfYyGFmLI62OMmaNg32f86EbVIYvYrGiYpEGkvooY4pUM1e7CHk@cipher.nrlssc.navy.mil> <20081114000219.GB5285@atjola.homenet> <jKWdt94ZxgNW0UAgUUW-qjTtpWohpQXMfvw-AUmOXND8SD5yFw0N8w@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Nov 14 03:23:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0oLg-00044S-JP
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 03:23:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751016AbYKNCWh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2008 21:22:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750986AbYKNCWg
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 21:22:36 -0500
Received: from www.church-of-our-saviour.org ([69.25.196.31]:54576 "EHLO
	thunker.thunk.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750948AbYKNCWg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2008 21:22:36 -0500
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1L0oKO-0007z4-OO; Thu, 13 Nov 2008 21:22:32 -0500
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@mit.edu>)
	id 1L0oKN-0003hl-Dr; Thu, 13 Nov 2008 21:22:31 -0500
Content-Disposition: inline
In-Reply-To: <jKWdt94ZxgNW0UAgUUW-qjTtpWohpQXMfvw-AUmOXND8SD5yFw0N8w@cipher.nrlssc.navy.mil>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@mit.edu
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100947>

On Thu, Nov 13, 2008 at 06:53:29PM -0600, Brandon Casey wrote:
> > -Ad is nice regarding it's safety-net value, but eg. after a large
> > filter-branch run, when refs/original and the reflogs have been cleaned,
> > you just want to get rid of all those old unreachable objects,
> > immediately. For example after importing and massaging some large
> > history from SVN, the -Ad behaviour is definitely _not_ what I want
> > there. Writing a few thousand loose objects just to prune them is just a
> > waste of time.
> 
> hmm. That's a good point. Even though I think it is likely that the thousand
> loose objects that are written will be small commit objects and not blobs,
> this use case may be enough to trump the safety benefit provided by the
> proposed change.

The problem is even small commit objects take a full 4k (or whatever
your filesystem block size is) when they are ejected as loose objects.
As a result, the current "git gc" defaults can end up requiring far
*more* disk space than before, certainly while it is running, and
sometimes even after the "git gc" completes.  (I then end up running
"git prune" to complete deletion of the ejected objects.)

Sometimes this gets so annoying that I'll run the individual commands
run by git-gc by hand, except I use git repack -ad instead of git
repack -A.  If we are going to get rid of the distinction between git
repack -a and git repack -A, perhaps there can be a config option to
force the immediate ejection of the unreachable objects, instead of
creating loose objects?  

If the goal is safety, it would be nice if git repack could create a
separate pack that only contained unreachable objects, and then have
git prune be able to remove a pack if it only contains unreachable
objects.

						- Ted
