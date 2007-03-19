From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git push to a non-bare repository
Date: Sun, 18 Mar 2007 22:56:03 -0400
Message-ID: <20070319025603.GG20658@spearce.org>
References: <vpq648ye9w6.fsf@olympe.imag.fr> <20070319020053.GA11371@thunk.org> <7vr6rmm1y9.fsf@assigned-by-dhcp.cox.net> <20070319022143.GF20658@spearce.org> <20070319024744.GD11371@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git <git@vger.kernel.org>
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Mon Mar 19 03:56:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HT82e-0006zS-9b
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 03:56:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933755AbXCSC4L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 22:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933776AbXCSC4K
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 22:56:10 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:48639 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933755AbXCSC4J (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 22:56:09 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HT82M-0005zK-H6; Sun, 18 Mar 2007 22:55:54 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5249520FBAE; Sun, 18 Mar 2007 22:56:04 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070319024744.GD11371@thunk.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42566>

Theodore Tso <tytso@mit.edu> wrote:
> On Sun, Mar 18, 2007 at 10:21:43PM -0400, Shawn O. Pearce wrote:
> > Junio C Hamano <junkio@cox.net> wrote:
> > > Theodore Tso <tytso@mit.edu> writes:
> > > 
> > > > Is it at all possible to figure out <commit-id-before-the-push>?  It
> > > > seems the answer is no, and I suspect that's a bug.
> > > 
> > > Doesn't update hook get pre- and post- commit object name?
> > 
> > Yes, and the same is true in the new post-receive hook.
> 
> In my comments, I was observing that *after* the push had succeeded,
> there was no way to find the commit-id-before-the-push, since neither
> the reflog nor ORIG_HEAD is getting updated.  Is there a good reason
> why not?  Would you accept a patch which caused the reflog and
> possibly ORIG_HEAD to be updated on the remote side of the push?

The reflog does update if the log file exists during a push (err,
actually during receive-pack).  Or if core.logAllRefUpdates is set
to true.  Now this isn't the default in a bare repository, but it
should be the default in a repository with a working directory.
So the case we are talking about should be seeing the reflog update.
 
> When I was talking about a hook to enforce the BitKeeper semantics,
> the question is whether we have enough to enforce the following:
> 
> 	* Only accept the push if it will result in a fast-forward
> 		merge (and if not, tell the user to do a git pull, merge
> 		locally, and then redo the git push)

Yes, the update hook can detect this.  Actually receive-pack by
default rejects *all* non-fast-forward pushes, even if the client
side uses --force.

> 	* Only accept the push if there are no locally modified files
> 		that would be affected when the working directory is
> 		updated to reflect the new HEAD

The update hook could also perform this check; test if the ref
being updated is the current branch, and if so, verify the index and
working directory is clean.  That's a simple run of git-symbolic-ref
(to get the current branch) and git-runstatus (to check the index
and working directory), is it not?

If git-runstatus exits to indicate the tree is clean (nothing to
commit) then a simple `read-tree -m -u HEAD $new` should update
the working directory and index, right?

-- 
Shawn.
