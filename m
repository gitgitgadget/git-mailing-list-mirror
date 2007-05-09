From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] Second parent for reverts
Date: Wed, 09 May 2007 14:54:18 -0700
Message-ID: <7v7irhslx1.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0705091406350.18541@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed May 09 23:54:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hlu7B-0004jk-0m
	for gcvg-git@gmane.org; Wed, 09 May 2007 23:54:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754757AbXEIVyW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 17:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759000AbXEIVyW
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 17:54:22 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:48551 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758506AbXEIVyT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 17:54:19 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070509215420.WILN22040.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Wed, 9 May 2007 17:54:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id x9uJ1W00Z1kojtg0000000; Wed, 09 May 2007 17:54:19 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46796>

Daniel Barkalow <barkalow@iabervon.org> writes:

> The discussion about having a header to specify, for a revert commit, what 
> it reverts made me realize that this header *would* be useful, but that we 
> don't need a *new* header for it. I think that the right method is to add 
> the parent of the reverted commit as a second parent for the revert.
>
> If you have:
>
> a -> b -> c -> d
>
> And you want to revert b, the most exact flow would be:
>
> a -> b -> c -> d -> e
>        \         /
>         -> a' ---
>
> I.e., you exactly remove the effects of b to generate a commit that has 
> the same tree as a, and then you merge.
>
> But a' doesn't actually take anything from b, since it's reverting all of 
> b (unless it's only reverting part of b), and, if b isn't there, it 
> doesn't need a commit message, either, so it's not different from a. So 
> the flow should be:
>
> a -> b -> c -> d -> e
>   \              /
>    --------------
>
> And this means blame work correctly: lines that b changed will be blamed 
> on a (or an ancestor), because e will match a there and be different from 
> d. So I think git-revert should simply add in the reverted patch's parent. 
> Does this analysis make sense to other people?

The revert operation at the tree level (not commit level) treats
AS IF b is a common ancestor between a and d and computes a
merge between a and d using that fake common ancestor to reach
at e.  So it is understandable that you are confused that the
result somehow has something to do with a merge between a and d.

But other than that, the "analysis" does not make any sense to
me.

When you have a merge commit somebody else made, you should be
able to reproduce it yourself, with the help from the intent of
the merge explained in the commit log of the merge commit
(usually it says "I am merging this development line with that
one").  With a->b->c->d history, what is the sane merge result
between a and d?  It won't be e.  The only clue that you did a
revert of b is contained in the message "Revert b", because b is
not a common ancestor between a and d.

An interesting tangent is that you can revert both b and c with
a single tree-level operation by pretending as if c is a common
ancestor between a and d and run tree-level 3-way merge to apply
difference between c and d on top of a to come up with e.  It
would not make sense to record neither one of a b c as the fake
second parent.

I would suggest to leave a revert as a revert.  It is not a
merge.

In general, you should think of an act of making a commit (not
limited to a merge but a single parent) to mean that you are
making this statement:

	I have considered the development history that leads to
	the parent commits this commit records, and the tree
	recorded with this commit suits the purpose of my branch
	better than all of them.

Obviously, if you considered the history that leads to 'd', you
have considered the hsitory that leads to 'a' as well, so
recording both 'a' and 'd' as parents does not make much sense.
You could have recorded 'e' as an Octopus of 'a', 'b', ... 'd',
and the statement does not change.
