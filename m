From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-format-patch-script bug?
Date: Sun, 07 Aug 2005 10:21:45 -0700
Message-ID: <7vhde1y85y.fsf@assigned-by-dhcp.cox.net>
References: <m1d5oqxkqm.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 07 19:23:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E1oqW-00031m-0t
	for gcvg-git@gmane.org; Sun, 07 Aug 2005 19:22:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752346AbVHGRVr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Aug 2005 13:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752376AbVHGRVr
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Aug 2005 13:21:47 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:60889 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1752346AbVHGRVr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Aug 2005 13:21:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050807172146.PGGK17043.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 7 Aug 2005 13:21:46 -0400
To: ebiederm@xmission.com (Eric W. Biederman)
In-Reply-To: <m1d5oqxkqm.fsf@ebiederm.dsl.xmission.com> (Eric W. Biederman's
	message of "Sun, 07 Aug 2005 01:35:29 -0600")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) writes:

> I was trying to help someone track down a bug that
> occurred between linux-2.6.12 and linux-2.6.13-rc1.
> Since it was very much an unknown where the problem
> was introduced I decided to run git format-patch
> so I could see what all of the differences were.
> Then to be certain the patch series worked I started
> applying them in order.  

Sorry, I offhand do not have a good re-design of what
format-patch should do for this purpose; the current design does
not try to deal with anything but a linear sequence of commits,
primarily because the command was done for preparing individual
developer's patch submission.

I find your trying to find where the problem was introduced by
reading every single change very laudable.  However, for the
purpose of "this one was good but somewhere before this one the
things got broken, where is it?", I suspect that bisect would be
a better fit.

The way to use bisect is very simple.  First you make sure you
do not have unrecorded changes in your working tree, because
bisect procedure would check out sequences of commits for you to
test there.  Then, you give it two "known to be good" and "known
to be bad" commits.  The order you give them does not matter,
but "good" one _must_ be ancestor of "bad" one (the code
currently does not check this):

    $ git bisect start
    $ git bisect good v2.6.12
    $ git bisect bad  v2.6.13-rc1
    Bisecting: 1035 revisions left to test after this

As soon as ou give these two pair, bisect starts thinking, and
checks out one revision that is roughly in the halfway between
these two good and bad commits.  You can, if you feel like, see
which one is the first one it wants you to test, like this:

    $ git log --max-count=1 --pretty=short bisect
    commit 15d20bfd606c4b4454aeaa05fc86f77994e48c92
    Author: Domen Puncer <domen@coderock.org>

        [PATCH] ptrace_h8300: condition bugfix

At this point, your working tree has this commit checked out.
Compile and test to see if this one is good or bad.  If it is
good, then you say "good":

    $ git bisect good
    Bisecting: 517 revisions left to test after this

Bisect eliminated about half commits from the original 1000+
suspects to be innocent, and checked out which one it wants you
to check next.  Compile and test to see if this one is good or
bad.  If it turns out to be bad, then you say "bad":

    $ git bisect bad
    Bisecting: 266 revisions left to test after this

You go on eliminating about half every time you run one test,
and eventually it would find one commit that you may want to
examine more deeply by code inspection.
