From: John Wiegley <johnw@boostpro.com>
Subject: Re: Using Origin hashes to improve rebase behavior
Date: Thu, 10 Feb 2011 22:14:15 -0500
Message-ID: <m2oc6jtg8o.fsf@hermes.luannocracy.com>
References: <m21v3fvbix.fsf@hermes.luannocracy.com>
	<20110210225428.GA21335@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 11 04:14:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PnjSn-0000X6-4W
	for gcvg-git-2@lo.gmane.org; Fri, 11 Feb 2011 04:14:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750837Ab1BKDOV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Feb 2011 22:14:21 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:52237 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750699Ab1BKDOU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Feb 2011 22:14:20 -0500
Received: by qyk12 with SMTP id 12so1737320qyk.19
        for <git@vger.kernel.org>; Thu, 10 Feb 2011 19:14:19 -0800 (PST)
Received: by 10.229.217.11 with SMTP id hk11mr99109qcb.248.1297394059310;
        Thu, 10 Feb 2011 19:14:19 -0800 (PST)
Received: from localhost (207-172-223-249.c3-0.smr-ubr3.sbo-smr.ma.static.cable.rcn.com [207.172.223.249])
        by mx.google.com with ESMTPS id g32sm240728qck.46.2011.02.10.19.14.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 Feb 2011 19:14:18 -0800 (PST)
In-Reply-To: <20110210225428.GA21335@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 10 Feb 2011 17:54:28 -0500")
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.2 (darwin)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166536>

Jeff King <peff@peff.net> writes:

> Now, in step 2 we could record "X" as an origin ID of X'' and during the
> rebase in step 3, calculate the intersection of the origins of X'' and X',
> and see that they are both just X. And I think maybe you already realize
> that, since you talk about Origin-IDs as sets.

Right.

> And there are lots of other cases. What about "git cherry-pick -n"? What
> about rebasing? If there are no conflicts, is it OK to copy the origin
> field? How about if there are conflicts? How about in a "git rebase -i",
> where we may stop and the user can arbitrarily split, amend, or add new
> commits. How do the old commits map to the new ones with respect to
> origin fields?

During rebasing, any commits which can be rebased without conflict have their
origin transferred (and each time it would cause the origin id list to grow by
one), but any commits which are squashed or edited would not transfer.

For cherry-pick -n, if the index is empty at the time the cherry-pick is done
(is this required?), then a file is created under .git/ with the SHA of the
changes placed in the index, so that when git-commit is later run and the
index has not been changed, then the Origin-Id for that originating commit
gets placed at the bottom of the commit message.

> So there are lots of corner cases where it won't work, because git is
> more than happy to give you lots of ways to tweak tree state and
> history, and it fundamentally doesn't care as much about process as it
> does about the end states that you reach. That's part of what makes git
> so flexible, but it also makes niceties like "did I already apply this
> commit on this branch" much harder to make sense of.

I think we'd want to restrict this system to those commits which were
automatically rewritten without conflicts.  Any user intervention in the
process would invalidate the meaning of the Origin-Id.

> It probably shouldn't be a new header field, but rather a text-style
> pseudo-header at the end of the commit.

I understand.

> But consider for a moment whether you actually want this field in the
> resulting commit at all, or whether it should be an external annotation.
> For example, let's say I cherry-pick from a private branch that is going
> to end up rebased anyway. Now the history for all time will have a
> commit that refers to some totally useless sha1 that nobody even knows
> about.

The problem with an external annotation is that if developers are sharing
feature branches, as a branch maintainer I want to know whether commits coming
from those feature branches are already in the branch I'm maintaining.

> There may be reasons why that isn't a good idea, and I haven't thought it
> through. But I think you should consider it as an alternate implementation
> and tell me why I'm dumb in that case. ;)

I'll give it a bit more thought as I consider the implementation of this.

> Whew, that turned out long. I hope it's helpful. I think the problem
> you're trying to solve is a real one, and I think your approach is the
> right direction. I just think we can leverage existing git features to
> do most of it, and because it is sort of a heuristic, we should be
> conservative in how it's introduced.

That's all extremely helpful, thank you!  You've brought up several use cases
I hadn't thought of, and perhaps this feature will indeed never cover
everything, but if it can reliably ease maintenance 80% of the time, I think
it's a relatively simple addition.

John
