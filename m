From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Make fetch-pack play nicer with servers which do not speak multi_ack
Date: Tue, 25 Oct 2005 01:30:38 -0700
Message-ID: <7vy84igfrl.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0510250854240.22398@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 25 10:32:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUKCh-0006qF-J3
	for gcvg-git@gmane.org; Tue, 25 Oct 2005 10:30:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090AbVJYIal (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Oct 2005 04:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932091AbVJYIak
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Oct 2005 04:30:40 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:8876 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932090AbVJYIak (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Oct 2005 04:30:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051025083006.OZJQ776.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 25 Oct 2005 04:30:06 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0510250854240.22398@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Tue, 25 Oct 2005 08:59:08 +0200
	(CEST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10573>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> +		if (insert)
> +			insert_by_date(commit, &rev_list);
> +		else
>  			commit_list_insert(commit, &rev_list);

Hmph.  I do not think insert_by_date and commit_list_insert on
the same commit_list would play well together, since the former
assumes that the list is already sorted by age (i.e. younger ones
near the head, older ones close to the tail).

But you are right.  If you made 20 commits on top of my "master"
branch head, we should send those 20 (and the commit you based
on your changes, which the other end has), way before sending
the ancient v0.99 tag.  Probably, we should never be sending
v0.99 tag as "have" if we are going to send your "master" branch
head, since the commit that tag refers to is reachable by your
"master" branch head but there are a lot more commit between
them, some of which will give us better "common" selected, and
that v0.99 tag is what the other end said they have so is known
to be ACKed if sent.

Although we are doing a traversal on the fetch side to figure
out the commit ancestry chain, I think we are not fully
utilizing the information we receive from the other end.
Typically we pull specific heads only, so get_remote_heads()
culls the information about remote refs and you would not have a
chance to know that v0.99 tag you have in your .git/refs/tags is
something the remote also has, unless you asked for that
particular tag.  I wonder if we can take advantage of that
information without discarding it.  For example,
get_remote_heads() itself knows the object name of v0.99.8 tag
and the object name of the commit the tag refers to, and you
have those objects locally already.  If you have many local
branches, and v0.99.8 commit is reachable from the heads of all
of your local branches, then you should be able to tell that you
do not have to (and you do not want to) send "have" for v0.99.7
and older tags even though they are also in your .git/refs/,
since you know they are all reachable from v0.99.8 commit and
likely to be worse common than v0.99.8.  The best common is
somewhere between v0.99.8 and the tips of your local branches.

This is a minor nit but I think you no longer need to have the
rev_list_end in this version.  It is only used to maintain
itself and not for any other purpose as far as I can see.
