From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-reset and clones
Date: Thu, 16 Mar 2006 18:10:23 -0800
Message-ID: <7v4q1x95yo.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0603161424310.5276@sheen.jakma.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 17 03:11:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FK4QZ-0006xQ-GP
	for gcvg-git@gmane.org; Fri, 17 Mar 2006 03:10:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752501AbWCQCKd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Mar 2006 21:10:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752487AbWCQCKd
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Mar 2006 21:10:33 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:50367 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1752501AbWCQCKc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Mar 2006 21:10:32 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060317020633.NCWD17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 16 Mar 2006 21:06:33 -0500
To: paul@hibernia.jakma.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17650>

Paul Jakma <paul@clubi.ie> writes:

> If a git repository has a reset HEAD~X done, then any later pulls in
> clone repositories get /really/ upset, with:
>
> $ git pull
> * refs/heads/origin: does not fast forward to branch 'master' of
> /home/paul/foo-git/;
>
> Type of thing. This seems to be a similar issue to:
>
> 	http://www.gelato.unsw.edu.au/archives/git/0510/10767.html
>
> The question is has this improved at all since last year? Is there
> anything the origin repository maintainer (the one who did reset) can
> do to recover from this?

You used to have something like this:


                 o---o---o---A
                /            ^ your HEAD used to point at here
    ---o---o---o

and you forgot other people already have the commit chain up to
commit A.   But you rewound and did cleanups:

                 o---o---o---A
                /
    ---o---o---o---o---o---B
                           ^ your HEAD now points at here

People who track your HEAD have A and your updated head B does
not fast forward.  Oops.

The recovery consists of two steps.  The first step is more
important.  To find what commits you lost that others already
may have.  You may be lucky and remember A's commit object name,
but when I did that I had to ask around on the list X-<.

The second step is a single command:

	$ git merge -s ours 'Graft the lost side branch back in' \
		HEAD A

where A is the object name of that commit.  On your current
branch, this creates a merge commit between A and B (your
current HEAD), taking the tree object from B.

                 o---o---o---A
                /             \
    ---o---o---o---o---o---B---M

You want to keep the contents of the cleaned-up HEAD, so that is
why you are taking the tree from B.  With this commit M, you are
telling the outside world that it is OK if they start from a
commit on the now-recovered side branch.

If the tree of A and B exactly match, further merges with people
starting from A branch would not have conflicts.  If the
difference between A and B are mostly clean-ups, automerge would
lose dirtiness you cleaned-up when they update to your new HEAD
(because the transition from A to M reverts the dirtiness, which
is what your clean-up was about), which is what you want.
