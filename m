From: Junio C Hamano <junkio@cox.net>
Subject: Re: Moving a file back to an earlier revision.
Date: Fri, 31 Mar 2006 13:49:44 -0800
Message-ID: <7vacb6thc7.fsf@assigned-by-dhcp.cox.net>
References: <4dd15d180603311313t7781f2ebk616276e9134f6472@mail.gmail.com>
	<4dd15d180603311332p60fa1867nc303bd92d515b4e0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 31 23:50:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FPRVF-0002Bk-7p
	for gcvg-git@gmane.org; Fri, 31 Mar 2006 23:49:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbWCaVtr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Mar 2006 16:49:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750884AbWCaVtr
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Mar 2006 16:49:47 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:4294 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1750808AbWCaVtq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Mar 2006 16:49:46 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060331214946.MESH15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 31 Mar 2006 16:49:46 -0500
To: "David Ho" <davidkwho@gmail.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18236>

"David Ho" <davidkwho@gmail.com> writes:

>> I am working on a board port on a separate branch.  The branch has
>> accumulated several revision of changes to a driver I worked on.  Now,
>> someone has come along with a better fix so I want to help test his
>> patch.  To do that I have to revert my changes to that driver (several
>> revisions back) before I can apply his patch.
>>
>> What would be a convenient way to do that with git?
>
> Sorry I might already have found it.
>
> File revisions
>
> +----+----+
> 1    2    3
>
> git diff commit(3)..commit(1) filename | git-apply

[please do not top-post].

That lets you go back to the state before 1, so what you are
doing is to start from here:

	---0---1---2---3

and

	---0---1---2---3---*

where * has the same tree as 0, and then on top of that you
apply his patch:

	---0---1---2---3---X

But what if you find a room for further improvements in his
patch?  You could commit X (which is revert of 321 *and* his
patch) and then build on top of it, like this:

	---0---1---2---3---X---Y

and feed him "diff X..Y" back.

However.

What Linus said is more natural in git.  Starting from the same
picture, you do this:

             X (side branch to test his patch on)
            /
	---0---1---2---3 (your original branch)

You apply his patch to a new branch.  You could even make
further improvements like this:

             X---Y
            /
	---0---1---2---3

And if you decide Y is better than your version 3 after all, you
can switch to his branch and then pick up anything important
from your development track between 0..3 on top of Y by
cherry-picking, and you can even later discard your original
development track.  On the other hand, if you end up deciding 3
is better than Y after all, you can just discard the whole side
branch.

Remember, a branch in git is very cheap, and is a powerful way
to keep track of things while you decide which alternate
universe to take.  And even after you decide, you could always
look at and even build on the other universe.
