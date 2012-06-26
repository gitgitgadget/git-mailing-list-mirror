From: Chris Webb <chris@arachsys.com>
Subject: Re: [PATCH 1/2] rebase -i: support --root without --onto
Date: Tue, 26 Jun 2012 20:38:18 +0100
Message-ID: <20120626193817.GD30779@arachsys.com>
References: <20120626133339.GT9682@arachsys.com>
 <bdb45972685db8899a46ebc62213e56c9a3d0c94.1340717793.git.chris@arachsys.com>
 <7vtxxxc22x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 26 21:38:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sjbap-0001T5-1C
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jun 2012 21:38:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753476Ab2FZTiY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jun 2012 15:38:24 -0400
Received: from alpha.arachsys.com ([91.203.57.7]:37996 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753237Ab2FZTiX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2012 15:38:23 -0400
Received: from [81.2.114.212] (helo=arachsys.com)
	by alpha.arachsys.com with esmtpa (Exim 4.72)
	(envelope-from <chris@arachsys.com>)
	id 1Sjbaf-0007ZV-Mm; Tue, 26 Jun 2012 20:38:22 +0100
Content-Disposition: inline
In-Reply-To: <7vtxxxc22x.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200674>

Junio C Hamano <gitster@pobox.com> writes:

> I am not quite sure what is going on in this "then" clause.
> 
> Chris Webb <chris@arachsys.com> writes:
>
> > +		git commit --allow-empty --allow-empty-message --amend \
> > +			   --no-post-rewrite -n -q -C $1 &&
> 
> At this point, nobody touched the empty sentinel root yet; you
> rewrite its log message and authorship using the picked commit.
> 
> > +			pick_one -n $1 &&
> 
> And then you create a new commit that records the update "$1" does
> relative to its parent (this hopefully only contains additions -- is
> it sensible to die-with-patch if it doesn't?), making sure that it
> does not fast-forward.  Does this always make the result a root commit?
> If "$1" has parents, wouldn't it become a child of the commits its
> parents were rewritten to (if any) in pick_one_preserving_merges()
> that is called from pick_one?
> 
> > +			git commit --allow-empty --allow-empty-message \
> > +				   --amend --no-post-rewrite -n -q -C $1 ||
> 
> And then you rewrite the log and authorship of that one.
> 
> In short, my questions are:
> 
>  (1) what is the purpose of the first "commit --amend" to update the
>      sentinel root commit?

This first commit --amend isn't supposed to change the empty tree in the
commit: the tree and index should be unchanged at this point. I'm only
running it to set the commit message and author.

The idea here is that I want the author and commit message already in place
if cherry-pick (and hence pick_one -n) fails so that we drop out for the
user to resolve conflicts.

This seems to be the way git cherry-pick or git merge behave when they need
conflicts resolving, and I wanted the behaviour to be consistent to avoid
surprises.

Is there a way of explicitly writing my commit --amend to make this
intention clearer? Would a -o without paths spell this out, or would it just
make thing more confusing?

>  (2) Is the purpose of "pick_one -n" done here to create a root
>      commit?  Does it always do so correctly?

pick_one -n cherry-picks the changes without actually making a commit. It's
already used in the squash case, so should be well-tested.

Following this, the second commit --amend actually commits those changes,
amending the sentinel. I don't change the message at all at this stage
because it's already correct.

Similar question to before: is there a clearer way to ask commit --amend to
leave the author and commit message unchanged rather than supply them
explicitly all over again, or shall I just comment to explain the intention?
EDITOR=: perhaps?

> This makes "git rebase --root" without $onto imply "-i", which makes
> sense, but it was a bit unexpected (it wasn't in the proposed log
> message).

Yes, sorry, you're quite right. It's only mentioned in the tests patch.

Would you prefer me to make this change in a separate patch, and generate an
error for this case in the initial commit, or just explain it properly in
the log message to go with the original combined patch?

Best wishes,

Chris.
