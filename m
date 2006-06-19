From: Junio C Hamano <junkio@cox.net>
Subject: Re: git 1.4.0 usability problem
Date: Sun, 18 Jun 2006 20:11:34 -0700
Message-ID: <7v4pyhdel5.fsf@assigned-by-dhcp.cox.net>
References: <449557B6.1080907@garzik.org>
	<7vbqsqdru0.fsf@assigned-by-dhcp.cox.net> <4495DB3B.10403@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 19 05:11:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FsAB4-0000Fq-Hj
	for gcvg-git@gmane.org; Mon, 19 Jun 2006 05:11:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbWFSDLg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Jun 2006 23:11:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751160AbWFSDLg
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jun 2006 23:11:36 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:48044 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751151AbWFSDLf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jun 2006 23:11:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060619031135.YAYK11027.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 18 Jun 2006 23:11:35 -0400
To: Jeff Garzik <jeff@garzik.org>
In-Reply-To: <4495DB3B.10403@garzik.org> (Jeff Garzik's message of "Sun, 18
	Jun 2006 19:01:15 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22114>

Jeff Garzik <jeff@garzik.org> writes:

> But if what Ryan says is true, about simply needing to ditch
> the "-f" argument I habitually pass to 'git checkout', would that
> alleviate the need for a patch?

To a certain degree, yes.

But I suspect (I am not a kernel person so I can only speculate)
in the kernel workflow you would often pick up a patch from the
list, apply it to your working tree (without applying it to your
index, IOW with "patch -p1" or "git apply", not with "git apply
--index"), and then decide to pull from somewhere else while
your working tree is dirty (but index is not).  The patch might
have created a new file or two, and the pull may also contain a
commit that applied the same patch in question.  The no-clobber
check would trigger in such a case preventing you from pulling,
and neither "checkout" nor "checkout -f" would clean these new
files that you have not told git about.

> FWIW, my workflow is
>
> 	cd /repos
> 	cd linux-2.6
> 	git pull
> 	cd ../libata-dev
> 	git checkout -f master	# guarantee any WIP goes away

We kept saying "with checkout -f any dirty state goes away from
your working tree".  It is true only with respect to the files
git knows about.  The trouble you experienced was about
untracked files -- files git does not know about, and they will
be left behind.

So if path F is in test branch head and linus branch head, but
not in your master branch head, and you have checked out test in
your working tree, even if path F in the working tree is clean:

	git checkout -f master

will leave F behind.  If you pull from linus at this point, the
check would trigger.  Running "git checkout master" without -f
would however remove it and you would not have the problem.
That is what Ryan's suggestion is about.

However, if you have a patch you got from somebody on the net
that creates F (maybe it is the same patch linus accepted
recently) while on your master branch, and you tried to examine
it by applying it to your working tree with "patch -p1" or "git
apply", your working tree will have F that is not in index (and
in your branch head).  In that state if you pull from linus, the
no-clobber check triggers.  In this case, neither "git checkout
master", "git checkout -f master", nor "git reset --hard master"
would remove F, because git does not even know about it, so
pulling from linus would fail.  "git clean" would removes F, so
it may not be a big deal, but it is rather a heavy-handed
operation that removes all crufts, so you may find it a
not-so-useful workaround (I certainly would, and that is the
primary reason I rarely use "git clean" myself).

It's a bit sad situation.  One of the useful feature of git is
that you can continue working in a dirty working tree as long as
your index is clean and your local changes do not interfere with
a merge, patch application, or branch switching.  Strictly
speaking, this no-clobber check _is_ about a local change that
does interfere with the operation, so from theoretical point of
view it is a good safety measure, but at the same time we did
not consider untracked files as precious until recently, and I
suspect that "the same patch applied elsewhere to create the
same file" pattern is reasonably common that this safety valve
may interfere the work more often than it may help avoiding
mistakes.
