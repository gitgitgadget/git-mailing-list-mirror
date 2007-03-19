From: Theodore Tso <tytso@mit.edu>
Subject: Re: git push to a non-bare repository
Date: Sun, 18 Mar 2007 22:47:44 -0400
Message-ID: <20070319024744.GD11371@thunk.org>
References: <vpq648ye9w6.fsf@olympe.imag.fr> <20070319020053.GA11371@thunk.org> <7vr6rmm1y9.fsf@assigned-by-dhcp.cox.net> <20070319022143.GF20658@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Mar 19 03:48:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HT7uo-00039s-Gx
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 03:48:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933740AbXCSCru (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 22:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933741AbXCSCru
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 22:47:50 -0400
Received: from THUNK.ORG ([69.25.196.29]:52805 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933740AbXCSCrt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 22:47:49 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HT80J-0001Rb-TB; Sun, 18 Mar 2007 22:53:48 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HT7uS-0000jb-TO; Sun, 18 Mar 2007 22:47:44 -0400
Content-Disposition: inline
In-Reply-To: <20070319022143.GF20658@spearce.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42565>

On Sun, Mar 18, 2007 at 10:21:43PM -0400, Shawn O. Pearce wrote:
> Junio C Hamano <junkio@cox.net> wrote:
> > Theodore Tso <tytso@mit.edu> writes:
> > 
> > > Is it at all possible to figure out <commit-id-before-the-push>?  It
> > > seems the answer is no, and I suspect that's a bug.
> > 
> > Doesn't update hook get pre- and post- commit object name?
> 
> Yes, and the same is true in the new post-receive hook.

In my comments, I was observing that *after* the push had succeeded,
there was no way to find the commit-id-before-the-push, since neither
the reflog nor ORIG_HEAD is getting updated.  Is there a good reason
why not?  Would you accept a patch which caused the reflog and
possibly ORIG_HEAD to be updated on the remote side of the push?


When I was talking about a hook to enforce the BitKeeper semantics,
the question is whether we have enough to enforce the following:

	* Only accept the push if it will result in a fast-forward
		merge (and if not, tell the user to do a git pull, merge
		locally, and then redo the git push)
	* Only accept the push if there are no locally modified files
		that would be affected when the working directory is
		updated to reflect the new HEAD

I don't think there's any easy way to determine if these two criteria
would be met besides trying to actually do the merge, and if it fails
atomically back out to the original starting point, right?  Or am I
missing something painfully obvious?

Since one of the applications where I might want to do something like
this is a push a web site being maintained by git (where I don't want
any the result of the interim attempted to merge to accidentally get
seen by the web server), probably in order to do this right I'd have
to have the hook script do a cp -rl of the repository+working tree to
some scratch space, try to do the merge and update of the working
tree, and if it succeeds, allow it to happen for real in the "live"
tree, and if not, fail the merge.  This seems awfully kludgy; is there
some other way?

						- Ted
