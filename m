From: Junio C Hamano <junkio@cox.net>
Subject: Re: Best way to generate a git tree containing only a subset of commits from another tree?
Date: Wed, 22 Mar 2006 17:38:25 -0800
Message-ID: <7vu09q54a6.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0603221920260.22475@hermes-2.csi.cam.ac.uk>
	<4421EF5F.3000601@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Anton Altaparmakov <aia21@cam.ac.uk>
X-From: git-owner@vger.kernel.org Thu Mar 23 02:39:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMEnA-0004p0-GE
	for gcvg-git@gmane.org; Thu, 23 Mar 2006 02:39:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932502AbWCWBif (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Mar 2006 20:38:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932478AbWCWBif
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Mar 2006 20:38:35 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:15023 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S932502AbWCWBid (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Mar 2006 20:38:33 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060323013826.BRYI17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 22 Mar 2006 20:38:26 -0500
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <4421EF5F.3000601@op5.se> (Andreas Ericsson's message of "Thu, 23
	Mar 2006 01:44:15 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17843>

Andreas Ericsson <ae@op5.se> writes:

> You would then do
>
>    $ git checkout -b for-linus linus
>
> followed by either multiple
>
>    $ git cherry-pick <commit-ish>
>
> or, if the commits are all in series, an iteration of the following
>
>    $ git format-patch --stdout <start-commit>..<end-commit> | git am -k

With core git tools these two would be the idiom to use.  It
might be more pleasant to use a specialized tool (such as StGIT)
designed to manage the changes meant for upstream.

> If you have several topic branches, one for each series of commits,
> you should be able to do an octopus, like so:
>
>    $ git pull . <topic-branches-to-publish>

Octopus is orthogonal to the issue at hand.  Further, I suspect
that the original repository by Anton is not that cleanly
organized to have such topic branches -- otherwise the question
would not have come up to begin with.

> If you *don't* have several topic branches, or if some commits aren't
> in topic-branches, you could try something like this (untested,
> although it shouldn't break anything except the for-linus branch which
> you can re-create fairly simply)
>
>   $ for b in <topic-branches-for-linus>; do
>       git checkout $b
>       git rebase for-linus || (git reset --hard; echo $b >> to-merge)
>     done

>   # now merge what couldn't be rebased
>   $ git checkout for-linus
>   $ git pull . $(cat to-merge)

Now you lost me here.  When rebase refuses because of
conflicting changes, you are doing "reset --hard" but I suspect
you meant "reset --hard ORIG_HEAD" to recover the original head.
Further, I would have expected you to be rebasing on top of
linus, not for-linus, in case you may already have pulled other
topic branches into it.

Your merging those branches that have conflicting changes on top
of for-linus (that starts out at Linus's tip) is sensible, but
one word of caution is the history contained within the topic
branch should be sane.  What are you going to do with branches
that cleanly rebase on top of for-linus?

> ... If your vanilla tree is up-to-date and he pulls
> from you before pulling from someone else or adding other commits this
> isn't necessary, although you'll have to do
>
>    $ git checkout linus; git pull . for-linus
>
> to get the vanilla branch up to speed with Linus' HEAD.

I am not sure I follow you here.

If Linus hasn't pulled from you, you can either just keep asking
(you do not have to update for-linus), or rebuild it based on
more recent Linus's tip.

	$ git fetch linus ;# to update to Linus's tip
	$ git checkout for-linus
        $ git reset --hard linus

If Linus has pulled from you, there is nothing more than the
above for you to do.  If you want to rebuild for-linus branch,
(maybe because you fixed things in some of your topic branches),
after the above, you could:

        $ git pull . this-topic
        $ git pull . that-topic
        ...

This is nicer to Linus _if_ your topics overlap with recent
changes to the Linus's tree.  Otherwise you do not necessarily
have to rebuild for-linus branch.
