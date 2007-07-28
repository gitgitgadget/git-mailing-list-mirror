From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Newbie problem
Date: Sat, 28 Jul 2007 01:01:49 -0700
Message-ID: <7vmyxht0r6.fsf@assigned-by-dhcp.cox.net>
References: <87vec5vvt5.fsf@osquare.oqube.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Insitu <abailly@oqube.com>
X-From: git-owner@vger.kernel.org Sat Jul 28 10:01:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEhFL-0000FL-6K
	for gcvg-git@gmane.org; Sat, 28 Jul 2007 10:01:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764994AbXG1IBv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Jul 2007 04:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764967AbXG1IBv
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jul 2007 04:01:51 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:53424 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764859AbXG1IBu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2007 04:01:50 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070728080151.PHQS7349.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Sat, 28 Jul 2007 04:01:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Uw1p1X00A1kojtg0000000; Sat, 28 Jul 2007 04:01:49 -0400
In-Reply-To: <87vec5vvt5.fsf@osquare.oqube.com> (abailly@oqube.com's message
	of "Sat, 28 Jul 2007 09:20:22 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54005>

Insitu <abailly@oqube.com> writes:

> Now, I want to be able to do:
> lap> git push
> or
> lap> git pull
>
> instead of 
> lap> git push ssh://pc/~/.git
>
> I think I need to reconfigure my remote branches/origin on laptop but
> don't want ot break everything.

The necessary syntax and configuration files are all documented
fairly detailed in the manual pages, but it is a tad hard to
know where to look:

    http://www.kernel.org/pub/software/scm/git/docs/git-fetch.html
    http://www.kernel.org/pub/software/scm/git/docs/git-push.html
    http://www.kernel.org/pub/software/scm/git/docs/git-config.html

If you use recent enough git (post 1.5.0), the recommended way
to keep two boxes in sync is:

On mothership box, in .git/config:

 [remote "origin"]
     url = satellite:.git/
     fetch = +refs/heads/*:refs/remotes/origin/*
     push = refs/heads/*:refs/remotes/origin/*
 [branch "master"]
     remote = origin
     merge = refs/heads/master

On satellite laptop, in .git/config:

 [remote "origin"]
     url = mothership:.git/
     fetch = +refs/heads/*:refs/remotes/origin/*
     push = refs/heads/*:refs/remotes/origin/*
 [branch "master"]
     remote = origin
     merge = refs/heads/master

Then, whenever you start working on the satellite:

	$ git pull

which, while you are on "master" branch, would use 'origin' as
the default remote (thanks to branch.master.remote configuration),
store the copy of mothership's branches in refs/remotes/origin/,
and merges the "master" branch obtained from the mothership to
your "master" branch on the satellite [*1*].  

When you are done working on the satellite:

	$ git push

will push to "origin" by default, which would push all your
branches (thanks to remote.origin.push configuration) to
mothership's refs/remotes/origin/.

When you go back to the mothership, your work done on the
satellite are already pushed into the refs/remote/origin/
tracking branches, so you can merge them in (you can do this
after shutting down your satellite laptop, which is the beauty
of this setup):

	$ git merge origin/master

to merge in the changes you did on the satellite.


[Footnote]

*1* If you prefer to keep a straight history, you may want to
    fetch+rebase instead of pull which is a fetch+merge, in
    which case this step will be:

	$ git fetch
        $ git rebase origin/master
