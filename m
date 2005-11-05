From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Added a few examples to git-pull man page.
Date: Sat, 05 Nov 2005 01:27:07 -0800
Message-ID: <7vk6fno36c.fsf@assigned-by-dhcp.cox.net>
References: <E1EYDua-00017o-9d@jdl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 05 10:27:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EYKKV-0000gG-FF
	for gcvg-git@gmane.org; Sat, 05 Nov 2005 10:27:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324AbVKEJ1M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 Nov 2005 04:27:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751326AbVKEJ1M
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Nov 2005 04:27:12 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:46583 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751324AbVKEJ1L (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Nov 2005 04:27:11 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051105092650.INY16347.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 5 Nov 2005 04:26:50 -0500
To: Jon Loeliger <jdl@freescale.com>
In-Reply-To: <E1EYDua-00017o-9d@jdl.com> (Jon Loeliger's message of "Fri, 04
	Nov 2005 20:36:08 -0600")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11176>

Thanks for the documentation updates.  I have one
trouble about this part:

    You never do your own development on branches that appear
    on the right hand side of a <refspec> colon on `Pull:` lines;
    they are to be updated by `git-fetch`.  The corollary is that
    a local branch should be introduced and named on a <refspec>
    right-hand-side if you intend to do development derived from
    that branch.
    This leads to the common `Pull: master:origin` mapping of a
    remote `master` branch to a local `origin` branch, which
    is then merged to a local development branch, again typically
    named `master`.

I am a bit confused by the "corollary".  What happens if you
have the following:

	Pull: master:origin
        Pull: +pu:pu
        Pull: maint:maint

and you say:

	git-pull remote

when you are on your master branch is:

1. master, pu and maint from remote are copied to origin, pu,
   and maint in the local repository (you already know this);

2. the updated origin is merged into the local master (you
   alerady know this too).

If somebody intends to do development derived from say 'maint',
one way to do so would be something like this:

	git checkout -b my-maint maint
	.. work work work, commit commit commit
        .. "git-format-patch maint..my-maint" to send patches
	.. off, or send a pull request to upstream.
        git fetch remote ;# to update origin, pu, and maint.
        git pull . maint ;# merge maint changes into my-maint.

That is, my-maint branch is used for your own development, and
from time to time you fetch remote heads (using remotes/remote
shorthands, the fetch would update origin, pu and maint) to keep
track of the progress of the upstream.  And you merge upstream
'maint' into your development line 'my-maint', when you find
that the upstream have something new in 'maint'.

And because of the rule "you never do your own development on RHS
branch":

	git checkout maint
        .. work work work, commit commit commit
        git pull remote ;# oops

this is discouraged.  'git pull remote' would try to overwrite
the local 'maint' with the remote 'maint', and it would find
that the head would not fast-forward (obviously, since we did
our own work that the remote side does not know about).  But
when I read the "corollary" the first time, it appeared to me
that we are suggesting the above.

Maybe something like this (I know my wording is quite bad and I
would appreciate rephrasing it better very much) would be more
explicit and appropriate?

    If you intend to do development derived from a remote
    branch B, have a `Pull:` line to track it, like this:

        Pull: B:remote-B

    and have a separate branch my-B to do your development
    on top of it.  The latter is created by 'git branch my-B
    remote-B' (or its equivalent, 'git checkout -b my-B
    remote-B'), and that is the branch you make your own
    commits.  Run 'git fetch' to keep track of the progress
    of the remote side, and when you see the tracked remote
    branch has something new, merge it into your development
    branch with 'git pull . remote-B', while you are on my-B
    branch.
