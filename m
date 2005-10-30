From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-pull (or cg-fetch?) with exit status
Date: Sun, 30 Oct 2005 09:19:54 -0800
Message-ID: <7v3bmiudl1.fsf@assigned-by-dhcp.cox.net>
References: <86fyqjt9w9.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 30 18:20:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWGqj-0005g4-9b
	for gcvg-git@gmane.org; Sun, 30 Oct 2005 18:20:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751010AbVJ3RT5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Oct 2005 12:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751082AbVJ3RT5
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Oct 2005 12:19:57 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:27384 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751010AbVJ3RT4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Oct 2005 12:19:56 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051030171912.HCHR11356.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 30 Oct 2005 12:19:12 -0500
To: merlyn@stonehenge.com (Randal L. Schwartz)
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10823>

merlyn@stonehenge.com (Randal L. Schwartz) writes:

> Other than grep the output of the "pull" commands, I'd like to have a
> flag added that will also set an exit status to "successful" if new
> things were pulled.  That way, I can automate a "make install"
> resulting from a successful new pull, ala:
>
>         git-pull --silent && make install

How about this instead of your one-liner?

	old_head=$(git-rev-parse --verify HEAD) &&
        git-pull -n >/dev/null 2>&1 || exit
        new_head=$(git-rev-parse --verify HEAD)
	test "$old_head" = "$new_head" || make test install

git-pull has at least 4 different possible outcomes, and its
exit code talks about its success/failure right now.

 1. fetch did not succeed, so pull should result in failure. In
    this case there is no change in your repository, and no
    point rebuilding.

 2. fetch contacted the other end and concluded conversation
    correctly.

    2-a. There was no change upstream (or you were up-to-date --
         the other side was behind you).  This is a successful
         pull, but you probably do not want to rebuild.

    2-b. There were changes upstream and we tried to merge.
         Merge was successful.  This case you would want to
         rebuild.

    2-c. There were changes upstream and automerge failed.  You
         cannot rebuild in this case.

With your proposal we should need to exit non-zero in case 2-a
when we are running with --silent.  This feels somewhat
counter-intuitive if not wrong, even if it is only done under a
particular flag.
