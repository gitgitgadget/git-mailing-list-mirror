From: Junio C Hamano <junkio@cox.net>
Subject: Re: GIT 0.99.7d, and end of week status.
Date: Sun, 25 Sep 2005 11:47:33 -0700
Message-ID: <7vaci1nfwa.fsf@assigned-by-dhcp.cox.net>
References: <7vll1lr1bq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Sep 25 20:48:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJbXJ-0006wm-QQ
	for gcvg-git@gmane.org; Sun, 25 Sep 2005 20:47:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932263AbVIYSri (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Sep 2005 14:47:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932266AbVIYSri
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Sep 2005 14:47:38 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:41666 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932263AbVIYSrh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Sep 2005 14:47:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050925184734.BFT4527.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 25 Sep 2005 14:47:34 -0400
To: git@vger.kernel.org
In-Reply-To: <7vll1lr1bq.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 25 Sep 2005 01:36:25 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9273>

I said:

> * The fourth minor fix release, GIT 0.99.7d, is available at the
>   usual places.
>
>   With git:
>
>   $ git fetch http://kernel.org/pub/scm/git/git.git tag v0.99.7d
>   $ git checkout -b <new-branch> v0.99.7d

If you pick a suitable name as <new-branch> that the repository
in which you keep track git.git does not yet have, "maint997" for
example, and if your working tree is identical to whatever your
HEAD happens to be, then the above instruction should be read as:

    $ git fetch http://kernel.org/pub/scm/git/git.git tag v0.99.7d
    $ git checkout -b maint997 v0.99.7d

and that would give you the exact contents of v0.99.7d in your
working tree.

But this was really a stupid way to give instructions, and would
probably have caused confusion.  Sorry about that, if you were
one of the people who were bitten.

I deliberately did not say:

    $ git pull http://kernel.org/pub/scm/git/git.git tag v0.99.7d

because the result would be affected by whatever the random
state the repository was in.

Folks using CVS seem to announce "A new release is available and
tagged as r0.99.7d", people seem to know what they need to do
when seeing that announcement ("cvs update -r r0.99.7d"), and
this command line, as long as the working tree tracks that
remote project CVS repository, would give more-or-less the same
result for everyone no matter what the original state of the
working tree was.  GIT is a bit different in that branch names
are local and you do not really "check out a tag".

One straightforward way which would work for everybody would be
(provided you do not have git-src in the current directory):

   $ git clone http://kernel.org/pub/scm/git/git.git git-src
   $ cd git-src
   $ git reset --hard v0.99.7d

This will give all the public branches and tags (renaming of
public "master" to "origin" is done by "git clone"), and match
your "master" to "v0.99.7d".

When you already have a repository to track git.git, I would
recommend to have something like this in .git/remote/origin:

    URL: http://kernel.org/pub/scm/git/git.git
    Pull: master:origin maint:maint +pu:pu

Then you can say:

    $ git fetch origin tag v0.99.7d

This only updates your .git/refs/tags/v0.99.7d and downloads
necessary objects.  To see them in your working tree (e.g. for
compilation), you would need to check it out.

Now, how would you check out the v0.99.7d tag?  There are two
ways to think about it.

If the reason you want v0.99.7d, not "master" nor "pu", is you
would want to stay with the 0.99.7 but get all the latest safer
fixes, then you can just checkout "maint" branch instead, like
this:

    $ git checkout -f maint

This will get you everything in the maintenance branch and may
contain fixes that happened after v0.99.7d -- you are taking my
0.99.7d announce as just a hint to say: "Junio has accumulated
enough maintenance fixes in the maint branch and tagged its tip".

And the announcement is just that.  I try to make sure that what
are in the maint branch are just "safer fixes that do not break
existing setup", but I do not do any more special testing than
what I already do to make commits into the maint branch when I
tag the tip of it.  In other words, the one that happens to be
tagged as 0.99.7d is not any safer than the next commit that
comes on the maint branch (there is none at this moment).  The
later tip of the maint branch had better be more correct than
v0.99.7d -- that is what "fix" usually means ;-).

On the other hand, if the reason you want v0.99.7d is to point
out things broke at that exact commit, you would need to check
out that exact version, not just a random commit that happens to
be at the tip of maint.  And you need a branch to check it out
onto in that case.  Assuming that you do not have a branch
called "throwaway":

    $ git checkout -f -b throwaway v0.99.7d

would give you the working tree that matches what is in v0.99.7d
and a new branch "throwaway" whose tip is the commit tagged as
v0.99.7d.  The usual caveat applies: if your working tree and
index had changes since the HEAD commit you had before you did
the above checkout, that change may be lost with '-f' flag.  But
the point of this checkout is to get what is in the named tag
exactly, you would want to lose them -- otherwise make a commit
to your branch, or stash away 'git diff HEAD' output, before
doing the checkout.

After that, if you want to see what v0.99.7c used to do, you
could (still remaining on the "throwaway" branch):

    $ git reset --hard v0.99.7c

[jc: maybe somebody can send a patch to add the later part of
this message as Documentation/howto/checking-out-a-tag.txt ].
