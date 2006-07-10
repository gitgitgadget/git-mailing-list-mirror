From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-log to go forward instead of reverse?
Date: Mon, 10 Jul 2006 13:26:11 -0700
Message-ID: <7vpsgdb40s.fsf@assigned-by-dhcp.cox.net>
References: <86bqrxpai1.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0607101151470.5623@g5.osdl.org>
	<863bd9p9en.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0607101212410.5623@g5.osdl.org>
	<86mzbhntxu.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 10 22:26:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G02Ke-0002r9-E4
	for gcvg-git@gmane.org; Mon, 10 Jul 2006 22:26:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422806AbWGJU0O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Jul 2006 16:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422807AbWGJU0O
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Jul 2006 16:26:14 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:42949 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1422806AbWGJU0N (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jul 2006 16:26:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060710202612.MNEJ554.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 10 Jul 2006 16:26:12 -0400
To: merlyn@stonehenge.com (Randal L. Schwartz)
In-Reply-To: <86mzbhntxu.fsf@blue.stonehenge.com> (Randal L. Schwartz's
	message of "10 Jul 2006 12:25:33 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23649>

merlyn@stonehenge.com (Randal L. Schwartz) writes:

> Well, this is for a "I'm connected to the net right now: please
> refresh all of my git mirrors" script:
>
>         ## (code here to cd to the right dir omitted)
>                 git-fetch
>                 if git-status | grep -v 'nothing to commit'

git-status exits non-zero for "nothing to commit" case, so do
not grep its output, but check the status of the command, to see
if your tree is in a good shape to do a pull.

>                 then echo UPDATE SKIPPED
>                 else
>                     if git-pull . origin | egrep -v 'up-to-date'
>                     then git-log --pretty=short ORIG_HEAD..HEAD | cat
>                     fi
>                 fi
>
> The log is just so I can quickly eyeball the interesting changes.

Do we not leave ORIG_HEAD when we are already up-to-date?  If so
that would be confusing...  No, we do leave ORIG_HEAD no matter
what, so you do not have to have this inner if to grep
up-to-date (on the other hand, you might want to do intelligent
things when git-pull fails).  So just drop the if and say
something like:

	else
        	PAGER= ; export PAGER
                git pull . origin &&
                git log --pretty ORIG_HEAD..HEAD |
                git shortlog
	fi

> The "cat"
> is to keep git-log from starting a pager.  (If there's a switch that does
> *that* that I've overlooked, that'd be good too.)

BTW,

        PAGER=cat
        export PAGER

This should work as more efficiently -- see pager.c ;-)
