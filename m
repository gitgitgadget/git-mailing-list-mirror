From: Junio C Hamano <junkio@cox.net>
Subject: Re: git rebase behaviour changed?
Date: Mon, 16 Jan 2006 21:50:23 -0800
Message-ID: <7vslrnh080.fsf@assigned-by-dhcp.cox.net>
References: <43CC695E.2020506@codeweavers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 17 06:50:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eyjjg-0004WV-LB
	for gcvg-git@gmane.org; Tue, 17 Jan 2006 06:50:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090AbWAQFu0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jan 2006 00:50:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751122AbWAQFu0
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jan 2006 00:50:26 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:713 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751090AbWAQFuZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jan 2006 00:50:25 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060117054933.SHVP3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 17 Jan 2006 00:49:33 -0500
To: Mike McCormack <mike@codeweavers.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14777>

Mike McCormack <mike@codeweavers.com> writes:

> git-rebase origin
> -> Current branch refs/heads/master is up to date.
>
> However, I can do the "rebase" manually with:
>
> git branch master-20060117
> git reset --hard origin
> git-format-patch -k --stdout --full-index origin master-20060117 | \
> 	git am --binary -3 -k
>
> Is this broken, or am I meant to be doing something different now?

What does "git-merge-base master-20060117 origin" give you?  If
it is the same as "origin", then the master-20060117 has been
merged with origin, and rebase does not run in this case.

Here is the simplest example:

                  1---2---3---4 master
                 /
        origin  0

Of course, you _could_ extract patches #1, #2, #3, and #4
between origin and master, and apply them on top of #0 to
reconstruct "master" as you found out, but there is not much
point doing so.

Rebase changes the "master" branch when the development track
between you (master) and upstream (origin) have forked:

                  1---2---3---4 master
                 /
        origin' 0---5---6 origin

In this case, things are rearranged by rebase:

                        1'--2'--3'--4' master
                       /
        origin' 0--5--6 origin


End of on-topic answers.


BTW, what this means is that it would not rearrange something
like this:

                    2---3
                   /     \
                  1---4---5---6 master
                 / 
        origin  0

But a structure like this could be rebased:

                    2---3
                   /     \
                  1---4---5---6 master
                 / 
        origin' 0---7---8 origin

to produce something like this:

                          1'--2'--3'--4'--6' master
                         / 
        origin' 0---7---8 origin

The ordering of patches may turn out to be wrong; #4 might
conflict with already applied #2 and #3.  In general, rebasing
such a merged structure is highly discouraged.  I think there
was a discussion on this topic on the list recently, and a short
summary was: "if you do a merge, do not rebase; if you are going
to rebase, do not merge".  The thread is this one:

	http://thread.gmane.org/gmane.comp.version-control.git/14308

Especially please look at a couple of message from Linus:

	http://article.gmane.org/gmane.linux.kernel/365410
        http://article.gmane.org/gmane.linux.kernel/365409
        http://article.gmane.org/gmane.linux.kernel/365501

I guess we could decompose the commit ancestry chain in such a
case, and reproduce something like this:

                            2'--3'
                           /     \
                          1'--4'--5'--6' master
                         / 
        origin' 0---7---8 origin

Rebase has never done this, though.  It is left as an exercise
for the reader ;-).
