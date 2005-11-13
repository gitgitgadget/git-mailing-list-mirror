From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] GIT commit statistics.
Date: Sun, 13 Nov 2005 02:59:43 -0800
Message-ID: <7vy83s95k0.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0511070837530.3193@g5.osdl.org>
	<20051107225807.GA10937@c165.ib.student.liu.se>
	<7vll00ov2l.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511071629270.3247@g5.osdl.org>
	<7v4q6ilt3m.fsf@assigned-by-dhcp.cox.net>
	<43758D21.3060107@michonline.com>
	<7v7jbeia3v.fsf_-_@assigned-by-dhcp.cox.net>
	<46a038f90511120419v70166c60t93d58b7544e03e3b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 13 12:00:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbFaR-0002bz-Ih
	for gcvg-git@gmane.org; Sun, 13 Nov 2005 11:59:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932417AbVKMK7r (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 Nov 2005 05:59:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932428AbVKMK7r
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Nov 2005 05:59:47 -0500
Received: from eastrmmtao02.cox.net ([68.230.240.37]:19681 "EHLO
	eastrmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932417AbVKMK7q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Nov 2005 05:59:46 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by eastrmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051113105852.NRR8508.eastrmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 13 Nov 2005 05:58:52 -0500
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90511120419v70166c60t93d58b7544e03e3b@mail.gmail.com>
	(Martin Langhoff's message of "Sun, 13 Nov 2005 01:19:45 +1300")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11732>

Martin Langhoff <martin.langhoff@gmail.com> writes:

> Similarly, when dealing with an upstream, my tree gets slowly out of
> sync and slightly messy. Eventually I get a new checkout, and rebase
> any pending patches with git-format-patch and git-am.

The key is not to let your tree go "slowly" out of sync, from my
experience.  When Linus was the maintainer, I used to do the
equivalent of the following all the time to keep up with his
tree while keeping my history clean [*1*].

Frequently [*2*], I tried to see if Linus made something new and
interesting.  My "origin" branch was always copy of Linus head.

	$ git fetch origin

The command would say "Fast forward".  So what did he do?

	$ git show-branch master origin
        ! [origin] Separate LDFLAGS and CFLAGS.
         * [master] Rename lost+found to lost-found.
        --
         + [master] Rename lost+found to lost-found.
         + [master^] Fix compilation warnings in pack-redundant.c
         + [master~2] Debian: build-depend on libexpat-dev.
        +  [origin] Separate LDFLAGS and CFLAGS.
        ++ [master~3] Split gitk into seperate RPM package

Ah, the commit master~3 was what he had the last time I pulled
from him, and since then he made a commit while I did three.  I
could do "git pull . origin" at this point, but that would
result in a useless mini-merge.  My tree is not public so I can
freely rebase to clean things up.

	$ git rebase origin
	$ git show-branch
        ! [origin] Separate LDFLAGS and CFLAGS.
         * [master] Rename lost+found to lost-found.
        --
         + [master] Rename lost+found to lost-found.
         + [master^] Fix compilation warnings in pack-redundant.c
         + [master~2] Debian: build-depend on libexpat-dev.
        ++ [origin] Separate LDFLAGS and CFLAGS.

Now I am fast-forward, so I could ask him to pull from me [*3*].

I think each of your developers can do the same, treating the
"project shared repository" as "Linus repository" and pull that
into the "origin" branch, and when the "master" is ready, push
it back into the shared repository (which is equivalent of Linus
pulling everything from me while doing nothing else in his
repository).

For a sizable change that deserves a topic branch with a long
sequence of commits, rebasing is not always the optimum
solution; and you may want to keep the full merge history of
such a branch pushed into the public repository as is.  But for
simpler cases that 'git rebase' can handle easily without
conflicts, the above procedure would help you keeping the
history of your shared repository less cluttered.

[Footnotes]

*1* Back then we did not have multi-head fetch, show-branch nor
rebase, so I did these using a homebrew Porcelain.

*2* Unlike CVS which always mucks with the working tree, 'git
fetch' into a branch that is not current one is an operation and
can be done even when I am in the middle of a heavy hackery.
Being able to peek into what others are up even when your tree
is in a messy state (the fetch is often followed by log and
diff) helps you to avoid doing duplicated work or going in a
wrong direction, which was great.

*3* Even back then almost all changes were fed via e-mail to
the maintainer.
