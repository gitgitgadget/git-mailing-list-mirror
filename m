From: Junio C Hamano <junkio@cox.net>
Subject: Re: New way of tracking remote branches -- question
Date: Fri, 05 Jan 2007 17:11:04 -0800
Message-ID: <7v8xghariv.fsf@assigned-by-dhcp.cox.net>
References: <776323.21089.qm@web31808.mail.mud.yahoo.com>
	<7vejq9c9tf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 06 02:11:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H305Z-0007kl-Oj
	for gcvg-git@gmane.org; Sat, 06 Jan 2007 02:11:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751053AbXAFBLI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Jan 2007 20:11:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751050AbXAFBLI
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jan 2007 20:11:08 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:34439 "EHLO
	fed1rmmtao01.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751053AbXAFBLG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jan 2007 20:11:06 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070106011105.XMNB9173.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>;
          Fri, 5 Jan 2007 20:11:05 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 7dAG1W00Y1kojtg0000000; Fri, 05 Jan 2007 20:10:17 -0500
To: Luben Tuikov <ltuikov@yahoo.com>
In-Reply-To: <7vejq9c9tf.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 05 Jan 2007 15:50:36 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36062>

Junio C Hamano <junkio@cox.net> writes:

> Luben Tuikov <ltuikov@yahoo.com> writes:
>
>> I can see that the remote heads are where they are supposed to be
>> but no local tracking heads are created (by default).  I had
>> to do this manually.
>
> Ah, after firing off a few messages, I think I now guessed
> what you are talking about correctly.
>
> You are talking about the separate remote layout "git clone"
> creates, and talking about the fact that there is nothing in
> refs/heads/ except master while refs/remotes/origin/ mirrors
> what the remote side has faithfully, aren't you?
>
> If that is the case, I can explain.  It is a good topic to talk
> about.

Disclaimer.  I am not very good at defending what I do not fully
agree with, and the separate remote is one of them, but because
it has become the default layout, let me try.

When cloning from a repository with a single branch (like
Linus's linux-2.6), the traditional layout created
heads/{origin,master}.  Origin is a tracking branch that you
were not supposed to build on top of (or reset to move around,
for that matter), and master is where you do your work (or you
do your work elsewhere and use master to integrate them).

The separate remote layout creates remotes/origin/{HEAD,master}
that you can still refer to with "origin" (because sha1_name
knows about "refs/remotes/%s/HEAD") and is a tracking branch.
It also creates heads/master which is where you do your work (or
integration).

So from the high level view, the usage has not changed for the
simplest case with the new layout.

When the other side have more than one branch (say, 'master' and
'next'), the story is different.  The traditional layout created
heads/next in addition.  This _is_ a tracking branch that you
were not supposed to build on top of or reset.

The problem is that "git branch" listing does not tell you the
differences between 'master' and 'next' with the traditional
layout.  They happen to be the same name as what the remote side
has, but they are VASTLY different.  'master' is *your* local
branch you can freely use to do whatever you want, and does not
have to have ANYTHING to do with the remote 'master' ('origin'
is the mirror of remote 'master', not 'master').  While 'next'
is the mirror of remote 'next' and you are not even supposed to
touch it.

The separate remote layout instead adds remotes/origin/next.  It
does not fork heads/next from it when a clone is made.  I guess
we could do that, and I do not have a strong preference myself.
I think other poeple on the list (especially the ones who wanted
separate remote layout) prefer not to have the automatic fork of
all remote branches.

I think the current way reflects the distributed nature of git
better.

 * You may not necessarily care what happens on the non-primary
   branch at the remote side.  You are not forced to have the
   same branch structure as the remote has.  People who happily
   track 'master' can even forget about other branches tracked
   in remotes/origin/ and have heads/master and nothing else in
   the local branch namespace.

 * Your heads/ namespace is of your own.  The repository clone
   sets up arranges the master branch to start from the same
   commit as where you cloned from, and sets up so that changes
   made on the master at the remote is merged into your master,
   but that is merely a convention that was deemed as the most
   common and the most convenient.

One inconvenience for disciplined people is that traditional
layout allowed "git checkout next" to compile and install what
the remote side placed on a non-primary branch 'next'.

If you wanted to do _ANY_ development on top of it (even if that
was just to set '#define DEBUG 1'), however, you would need to
branch off of it, say "git checkout -b my-next next", so the
above inconvenience is arguably very minor.  On the other hand,
the downside are the pollution of your own heads/ namespace
(having your forked branch and remote tracking branch means
heads/ would have next and pu from me and my-next and my-pu you
work on), and some people are not as careful and disciplined as
you are and have made mistakes of committing their own changes
while on such remote tracking branches (you can call the latter
part "newbie protection").  The next 'git fetch', especially
when it was forced _and_ was done while on 'next', was rather
unpleasant.  Of course, discipined people like you and me would
never do that, but we are not the only two people in the
universe ;-).

The issue of "checking the tracking branch out to look-and-see"
is going to be addressed by the upcoming detached HEAD support,
so personally I do not think it will be a huge problem.  You
would have to say "git checkout origin/next" for it with the new
layout.

Another thing the separate remote gives us is to make it easier
to interact with more than one remote, by having a new directory
next to remotes/origin/ directory.  If you used the traditional
layout, your heads/ namespace would explode because you would
have to have something like:

	heads/origin		-- from linux-2.6's master
        heads/origin-libata	-- from jgarzik libata ALL
	heads/origin-sii-lbt	-- from jgarzik libata sii-lbt
        ...

in a flat namespace intermixed with your own development
branches, instead of:

	remotes/origin/master	-- from linux-2.6's master
        remotes/libata/ALL
        remotes/libata/sii-lbt
	...

grouped together by where they come from (and they cannot
possibly be mucked around directly thanks to being in remotes/
hierarchy), separated from any of your own development branches
that are in heads/.

Also, this is only about the default layout clone makes, and the
refs are not packed, so you can easily move remotes/origin/*
(except 'HEAD') to heads/ immediately after making a clone and
set up remotes.*.fetch configuration to match the traditional
layout if that is what you find more convenient.  The operation
in a repository layed out in the traditional way is still fully
supported (and will continue to be -- that's what old timers
use), and there is not even a reason to change your work habit
by converting an existing repository.
