From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-bisect problem
Date: Mon, 13 Feb 2006 17:52:31 -0800
Message-ID: <7v8xseyae8.fsf@assigned-by-dhcp.cox.net>
References: <20060213002502.5c23122c.akpm@osdl.org>
	<7virrj1v44.fsf@assigned-by-dhcp.cox.net>
	<20060213013205.4ba47836.akpm@osdl.org>
	<7vbqxb1sho.fsf@assigned-by-dhcp.cox.net>
	<20060213021917.742b2b10.akpm@osdl.org>
	<7v8xsezsni.fsf@assigned-by-dhcp.cox.net>
	<20060213165620.11ec6051.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 14 02:52:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8pMq-00007Z-2L
	for gcvg-git@gmane.org; Tue, 14 Feb 2006 02:52:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750875AbWBNBwd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Feb 2006 20:52:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750868AbWBNBwd
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Feb 2006 20:52:33 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:44767 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1750837AbWBNBwd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2006 20:52:33 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060214015007.RSHA17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 13 Feb 2006 20:50:07 -0500
To: Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060213165620.11ec6051.akpm@osdl.org> (Andrew Morton's message
	of "Mon, 13 Feb 2006 16:56:20 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16099>

Andrew Morton <akpm@osdl.org> writes:

> The bug is in Jeff's tree only
> (git+ssh://master.kernel.org/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git#ALL)
> so I wanted to perform the bisection on the git-netdev-all branch.
>
> So I did a `git log git-netdev-all' and looked at where the ipw2200 changes
> were and then decided that the 2.6.16-rc1 and 2.6.16-rc2 commits straddled
> those changes nicely, so I chose those as the bisection starting points.

Ah.  Jeff merges from Linus and that causes things on Linus tree
to appear in his tree.  So you saw -rc1 and -rc2 in the output,
but neither of them may contain the problematic change, and are
not good/bad pair at all.  They are probably both good ones.

git log output is chronological and there is no guarantee that
the ordering has much to do with the actual ordering of commits,
especially when merges are involved.  In fact, "Jeff's tree
only" suggests to me that 2.6.16-rc2 has not merged those
changes, but you thought (arguably rightly so) rc1 and rc2
straddled them.


              -rc1                     -rc2
    ---o---o---o---o---o---o---o---o---o---o---o---o--- Linus
                                            \ 
                                             \ 
       ---o---o---o---*---o---o---o---*---o---o---o---o--- Jeff
                       <- ipw2200 ->

So you would want to perhaps pick two commits like the above *
and bisect.  If the one marked as bad on the Linus tree
initially (-rc2) is not bad and does not reach the allegedly bad
commit on Jeff's line, there is no way for bisect to find it.

If you are suspecting ipw2200, 2f633db and 747af1e might be a
pair of good anchor points to start bisecting.

The way I came up with these two; I should be using gitk for
this kind of thing, but I do not work in X during daytime, so I
am guessing these from:
 
        $ git rev-list --pretty=oneline linus..garzik/netdev |
          grep -C4 -i ipw2200 | less

This gets the list of commits that are on Jeff's tree but not in
Linus' in reverse chrono order, and grabs ones with ipw2200 in
their titles.  It shows that 2f633db is (close to) the latest
that touches ipw2200, and 747af1e is (close to) the reasonably
old that touches ipw2200.  As a review of these two points, I
did this:

	$ git log 747af1e..2f633db

Hope it helps this time...
