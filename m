From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC/PATCH] git-fetch: Use already fetched branch with the --local flag.
Date: Tue, 17 Oct 2006 00:14:30 -0700
Message-ID: <7vbqobo1m1.fsf@assigned-by-dhcp.cox.net>
References: <87ac3w8jl1.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 17 09:15:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZjAY-0007kb-QM
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 09:15:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932184AbWJQHO4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 17 Oct 2006 03:14:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932191AbWJQHO4
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 03:14:56 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:22416 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932184AbWJQHOz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Oct 2006 03:14:55 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061017071431.EBVV16798.fed1rmmtao09.cox.net@fed1rmimpo01.cox.net>;
          Tue, 17 Oct 2006 03:14:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id bKEJ1V00e1kojtg0000000
	Tue, 17 Oct 2006 03:14:19 -0400
To: Santi =?iso-8859-1?Q?B=E9jar?= <sbejar@gmail.com>
In-Reply-To: <87ac3w8jl1.fsf@gmail.com> (Santi =?iso-8859-1?Q?B=E9jar's?=
 message of "Mon, 16
	Oct 2006 15:40:42 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29027>

Santi B=E9jar <sbejar@gmail.com> writes:

> It allows to separate when you fetch from when you merge. So, a "git =
pull"
> can be:
>
> $ git fetch
> $ git pull --local

There was something that has been disturbing me in your patches
(this one, and the previous "remote=3D." one) and I could not tell
what it was.  I think I know what it is now.

Let me outline my understanding of the workflow these two
changes would help.

You have an upstream repository that has more than one branches
you are interested in, say "master" and "next".  And you work on
top of both of them, so you have two branches of your own that
correspond to them.

So you organize your remote section perhaps like this:

	[remote."origin"]
        	url =3D git://git.k.o/.../git.git/
                fetch =3D refs/heads/master:refs/remotes/origin/master
                fetch =3D refs/heads/next:refs/remotes/origin/next
                fetch =3D +refs/heads/pu:refs/remotes/origin/pu

	[branch."master"]
        	remote =3D origin
                merge =3D refs/heads/master

	[branch."next"]
        	remote =3D origin
                merge =3D refs/heads/next

That is, your refs/heads/master corresponds to upstream's master
branch and your next corresponds to upstream's next branch.
When you are on your "master" you would merge changes made to
upstream's master into it with "git pull".

        By the way, could you add descriptions on remote.* to
        Documentation/config.txt?

After doing a "git pull" while on your "master" and finishing
working on your "master", you might switch to your "next".  At
that point, if you want to merge upstream changes without
re-fetching, you can do either of the following:

	git pull . remotes/origin/next
        git pull --local

(the former can be "git pull" if "branch.next.remote=3D.").

I think this is the point of your two patches, and in that
sense, the --local one makes "branch.remote=3D." patch
unnecessary.

While these save typing on "git pull", two things bother me.

 * the tool is not helping you decide if you can get away
   without re-fetching.  you need to remember that (1) you
   fetched from the upstream to update "master" recently _and_
   (2) because of your [remote."origin"] configuration your
   remotes/origin/next was updated while you pulled into your
   "master".

 * while the workflow assumes that one local branch is tied
   closely to one remote branch (in this example, tracked under
   remotes/origin), the rest of the tools do not take advantage
   of that assumption to help you decide what to do next.

=46or example, if each of your local branch is tied closely to one
remote branch, you should be able to "git fetch" to update the
tracking branches and then ask:

 - what changes are in remote that I haven't merged?

 - what happens when I pull --local right now?

 - what changes if any are in mine alone missing from remote?

 - can I push to remote right now (i.e. would it fast-forward)?

 - how fresh is the tracking branch that corresponds to my
   current branch?

Right now, these require you to spell out the name of the
tracking branch.  Assuming you are on your "next" branch:

	git log ..remotes/origin/next
        git log remotes/origin/next..
        git log remotes/origin/next...next		[*1*]
	git show-branch remotes/origin/next next
	tail -n 1 .git/logs/remotes/origin/next

would be the ways to ask the above questions (and the last one
is unreadable unless you can do strptime in your head).

Maybe we can introduce a new extended SHA-1 notation to mean
"the tracking branch this branch usually merges from".  Then we
can say:

	git log ..^
        git log ^..
        git log ^...
        git show-branch ^ next

I am not sure '^' is syntactically viable, but hopefully you get
the idea.


[*1*] While three-dots symmetric difference is a nice addition
made recently, I often find it irritating that the output does
not tell which branch each of the commit is reachable from, and
end up running show-branch, which does.  Would anybody have a
clever idea to fix this cleanly?
