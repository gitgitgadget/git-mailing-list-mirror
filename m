From: Jeff King <peff@peff.net>
Subject: Re: "git merge" merges too much!
Date: Sun, 29 Nov 2009 00:14:27 -0500
Message-ID: <20091129051427.GA6104@coredump.intra.peff.net>
References: <m1NEaLp-000kn1C@most.weird.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: The Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Nov 29 06:14:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NEc7D-0000UC-Nc
	for gcvg-git-2@lo.gmane.org; Sun, 29 Nov 2009 06:14:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbZK2FOU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Nov 2009 00:14:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751083AbZK2FOU
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Nov 2009 00:14:20 -0500
Received: from peff.net ([208.65.91.99]:41180 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751082AbZK2FOU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Nov 2009 00:14:20 -0500
Received: (qmail 4147 invoked by uid 107); 29 Nov 2009 05:18:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 29 Nov 2009 00:18:52 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 29 Nov 2009 00:14:28 -0500
Content-Disposition: inline
In-Reply-To: <m1NEaLp-000kn1C@most.weird.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133993>

On Sat, Nov 28, 2009 at 10:21:25PM -0500, Greg A. Woods wrote:

> Hope I've found the right list on which to ask potentially naive
> questions!  I've been doing _lots_ of reading about Git, but I can't
> seem to find anything about the problems I relate below.

Yep, you're in the right place.

> master branch to represent release points -- is there any way to get
> "git log" to show which tags are associated with a given commit and/or

Try "git log --decorate".

>                                          BL1.2 - A - B - C  <- BL1.2 HEAD
>                                         /
> master 1 - 2 - TR1.1 - 3 - 4 - 5 - TR1.2  <- master HEAD
>
> [...]
> 
> 	git checkout -b BL1.1 TR1.1
> 	git merge BL1.2
> 
> However this seems to merge all of 3, 4, and 5, as well as A, B, and C.
> 
> I think I can (barely) understand why it's doing what it's doing, but
> that's not what I want it to do.  However it looks like Git doesn't have
> the same idea of a branch "base" point as I think I do.

Yes. Git doesn't really view history as branches in the way you are
thinking. History is simply a directed graph, and when you merge two
nodes in the graph, it takes into account _everything_ that happened
to reach those two points since the last time they diverged (which in
your case is simply TR1.1, as BL1.2 is a strict superset).

There is no way in the history graph to represent "we have these
commits, but not this subsequence". You have to create new commits A',
B', and C' which introduce more or less the same changes as their
counterparts (and they may even be _exactly_ the same except for the
parentage, but then again, they may not if the changes they make do not
apply in the same way on top of TR1.1).

> Running "git log TR1.2..BL1.2" does show me exactly the changes I wish
> to propagate, but "git merge TR1.2..BL1.2" says "not something we can
> merge".  Sigh.
> 
> How can I get it to merge just the changes from the "base" of the BL1.2
> branch to its head?
> 
> Is using either git-cherry-pick or "git log -p | git-am", the only way
> to do this?  Which way best preserves Git's ability to realize if a
> change has already been included on the target branch, if any?

Yes, you must cherry-pick or use rebase (which is a more featureful
version of the pipeline you mentioned). Either way will produce an
equivalent set of commits (cherry-pick is useful when you are picking a
couple of commits; rebase is useful for rewriting a whole stretch of
history. It sounds like you want to do the latter).

The resulting commits will have different commit ids, but git generally
does a good job at merging such things, because it looks only at the
result state and not the intermediate commits.  If both sides have made
an equivalent change, then there is no conflict.

> Is there any way to get "git log --graph" (and/or gitk) to show me all
> the branch heads, not just the current/specified one?

Try "--all" with either gitk or "git log". Or if you want a subset of
heads, just name them.

Hope that helps,
-Peff
