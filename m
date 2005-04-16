From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Re: Re: write-tree is pasky-0.4
Date: Fri, 15 Apr 2005 23:56:42 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504152318230.30848-100000@iabervon.org>
References: <Pine.LNX.4.58.0504152000570.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@ucw.cz>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 05:53:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMeMf-0002ly-TH
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 05:53:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262617AbVDPD4f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Apr 2005 23:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262625AbVDPD4f
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Apr 2005 23:56:35 -0400
Received: from iabervon.org ([66.92.72.58]:38917 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262617AbVDPD42 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Apr 2005 23:56:28 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DMeQE-0006o5-00; Fri, 15 Apr 2005 23:56:42 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504152000570.7211@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 15 Apr 2005, Linus Torvalds wrote:

> On Fri, 15 Apr 2005, Daniel Barkalow wrote:
> > 
> > So you want to merge someone else's tree into your committed state, and
> > then merge the result with your working directory to get the working
> > directory you continue with, provided that the second merge is trivial?
> 
> No, you don't even "merge" the working directory.
> 
> The low-level tools should entirely ignore the working directory. To a
> low-level merge, the working directory doesn't even exist. It just gets
> three commits (or trees) and merges two of them with the third as a
> parent, and does all of it in it's own temporary "merge working
> directory".

It seems like users won't expect there to be a new working directory for
the merge in which they are supposed to resolve te conflicts, but where
they don't see their uncommited changes. In any case, the low-level tools
have to care about *some* working directory, even if it isn't the parent
of .git, and the parent of .git seems like where other similar things
happen. If we're being conservative about merging, we're likely to report
a lot of conflicts, at least until we work out better techniques than a
simple 3-way merge.

> > For the latter, there are sometimes multiple ancestors which fit this
> > criterion
> 
> Yes. Let's just pick one at random (or more likely, the latest one by 
> date - let's not actually be _random_ random) at first. 

Okay; I've currently got the one where the number of generations it is
away from the further head is the smallest, and of equal ones, an
arbitrary choice. If people are generally similar in the amount they
diverge before commiting, this should be the most similar ancestor.

> There are other heuristics we can try, ie if it turns out that it's common
> to have a couple of alternatives (but no more than some small number, say
> five or so), we can literally just -try- to do a tree-only merge, and see
> how many lines out common output you get from "diff-tree".
> 
> Because that "how mnay files do we need to merge" is the number you want
> to minimize, and doing a couple of extra "diff-tree" + "join"  operations
> should be so fast that nobody will notice that we actually tried five
> different merges to see which one looked the best.
> 
> But hey, especially if the merge fails with real clashes (ie there are
> changes in common and running "merge" leaves conflicts), and there were
> other alternate parents to choose, there's nothing wrong with just
> printing them out and saying "you might try to specify one of these
> manually".

I think we should be able to get good results out of doing the 5 merges
and reporting a conflict only if there's a conflict in all of them; it
shouldn't be possible for two to succeed but give different results (if it
did, clearly our current algorithm is unsafe, since it would give some
undesired output if it happened to use the wrong ancestor).

I'm thinking of not actually calling "merge(1)" for this at all; it just
calls diff3, and diff3 is only 1745 lines including option parsing. We can
probably arrange to look around for better ancestors in case of conflicts
we'd otherwise have to report, and get this all tidy and more efficient
than having diff3 re-read files. And if we only go to other ancestors in
case of conflicts, we're going to be a lot faster total than getting a
reaction from the user, almost no matter what we do.

> I really don't think we should worry too much about this until we've 
> actually used the system for a while and seen what it does. So just start 
> with "nearest common parent with most recent date". Which I think you 
> already implemented, no?

I've got something like that (see above); did you want it in some form
other than the patch I sent you?

	-Daniel
*This .sig left intentionally blank*

