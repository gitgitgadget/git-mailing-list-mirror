From: Junio C Hamano <junkio@cox.net>
Subject: Re: GIT vs Other: Need argument
Date: Thu, 19 Apr 2007 16:30:12 -0700
Message-ID: <7vd52054e3.fsf@assigned-by-dhcp.cox.net>
References: <aa69c80b0704170202r3f35acc7ydb81708e747c69ff@mail.gmail.com>
	<200704171818.28256.andyparkins@gmail.com>
	<8b65902a0704180540l721b9b1dj6f6e068f0d7e5119@mail.gmail.com>
	<200704181426.29969.andyparkins@gmail.com>
	<462650A7.5030404@midwinter.com> <f06d4m$3rs$1@sea.gmane.org>
	<4626C4B9.1040707@midwinter.com>
	<7vy7kpaz9s.fsf@assigned-by-dhcp.cox.net>
	<7vejmg9a1z.fsf@assigned-by-dhcp.cox.net>
	<4627B292.6080202@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Fri Apr 20 01:30:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Heg4y-0005wZ-2K
	for gcvg-git@gmane.org; Fri, 20 Apr 2007 01:30:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754261AbXDSXaP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Apr 2007 19:30:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754294AbXDSXaP
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Apr 2007 19:30:15 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:41747 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754261AbXDSXaN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2007 19:30:13 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070419233012.NXOO1271.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Thu, 19 Apr 2007 19:30:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id pBWC1W00E1kojtg0000000; Thu, 19 Apr 2007 19:30:12 -0400
In-Reply-To: <4627B292.6080202@midwinter.com> (Steven Grimm's message of "Thu,
	19 Apr 2007 11:18:58 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45047>

Steven Grimm <koreth@midwinter.com> writes:

> I wonder if it makes sense to automate that even more and make git
> pull behave a bit statefully like rebase does:

Making things stateful may help, but when done without thinking
the consequence through, it would make things more confusing.

By the way, I never liked the way 'git rebase --continue' works.

Don't get me wrong.  I think it *was* a vast improvement.
Before 'git rebase --continue' was introduced, you needed to
know the implementation detail of 'git rebase' well enough to
know that you have to say 'git am --resolved' after resolving
the conflicts.  Compared to that, being able to tell rebase to
"continue" is much nicer.

But in practice, after 'git rebase' stops on a conflicting
merge, I spend many braincycles to come up with a sensible merge
and then many CPU cycles to run test, and by the time I do the
final "git diff" to make sure everything look right and
"update-index" them, I often end up getting confused and find me
asking this question: what was I doing?  Was I resolving the
merge because I merged, or was I in the middle of a rebase, or
was I applying from a mailbox?

I do not know what would happen if I say "git commit" at that
point, but I suspect it would be unpleasant, so I have never
tried it myself.  But it takes nontrivial amount of effort to
convince myself that 'git rebase --continue' is what I want to
do next, not 'git commit' nor 'git am --resolved'.

And I suspect the reason this is confusing to me is not that
rebase keeps state but that the state is not made more obvious
to prevent mistakes from happening.  Earlier I mentioned perhaps
we would want "git, whatnow?" command to remind people what they
were in the middle of and suggest what the next step would be.
Or perhaps "git, continue" command that makes the obvious next
step to happen would be helpful.

I am very much afraid that introducing more hidden state without
such "what now?"  framework in place would make things more
confusing and harder to use, not easier.

> When git pull --continue does the commit, it *might* be nice for it to
> do a variant of commit -a: if the user has modified all the
> conflicting files, *and* not done an update-index on any of them
> manually, then do the update-index implicitly. (That "and" part would
> be to prevent it from tripping up experienced git users who want to
> manually mark the conflicting files as resolved by running
> update-index.) I'm not sure that's actually a good idea, though it'd
> save some commands most of the time; the danger, of course, is that
> you could end up committing a half-resolved file by accident. But then
> I guess there's nothing preventing you from doing that with
> update-index today.

Running update-index by hand is a conscious act on the part of
the user.  You cannot compare it with silently doing the
equivanent without telling the user and screwing up.
