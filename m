From: Junio C Hamano <junkio@cox.net>
Subject: Re: Subversion-style incrementing revision numbers
Date: Wed, 20 Sep 2006 00:46:11 -0700
Message-ID: <7virjjkmkc.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.62.0609191309140.9752@joeldicepc.ecovate.com>
	<Pine.LNX.4.64.0609191416500.4388@g5.osdl.org>
	<20060919220604.GE8259@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joel Dice <dicej@mailsnare.net>, git@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Wed Sep 20 09:47:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPwnT-0001Ha-O0
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 09:47:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280AbWITHqV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 03:46:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751272AbWITHqV
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 03:46:21 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:31637 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751280AbWITHqM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Sep 2006 03:46:12 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060920074611.RNIT12581.fed1rmmtao02.cox.net@fed1rmimpo02.cox.net>;
          Wed, 20 Sep 2006 03:46:11 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id QXmD1V00U1kojtg0000000
	Wed, 20 Sep 2006 03:46:14 -0400
To: Petr Baudis <pasky@suse.cz>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27332>

Petr Baudis <pasky@suse.cz> writes, responding to Linus:

>> You're going to hit a few confusing issues if you really want to call 
>> things "r1.x.y.z"
>
> Noone does, that indeed would be horrible. But having the commits
> numbered inside a repository would indeed make for simple usage if you
> need to type in commit ids frequently, and could make Git a bit
> friendlier to newcomers.

SVN increments the number every time anything changes in the
whole-tree.  Typically (1) when you make a commit, anywhere, in
the tree or (2) when you tag or branch.  An interesting property
of SVN version number is that you can say "at revision 1423,
frotz and nitfol branches existed (filfre branch did not exist
back then) and their states were such and such".

So if Pasky wants to help Joel to emulate it in git, it is not
sufficient to number commits because there are fast-forwards and
it happens rather often in reality.  A closer emulation at the
conceptual level is to run pack-refs every time you change any
ref in your repository and version control the resulting
packed-ref file with serial number.

Then when people talk about git.git repository at kernel.org
people can say "the repository at revision 144 had master at
019ba86 and next at 832e76a; tag v1.4.3 did not exist back
then."

Is it useful?  In general I think it is useful only as a local
matter, just like ref-log is useful locally.  In fact, I think
it is a natural extension of the ref-log (and it can even
capture where the tags were, which I sometimes find sorely
lacking in the current ref-log scheme -- anybody want to update
git-tag.sh to have it use ref-log?  hint hint...).

But I am not sure how you would propagate it sanely in the
distributed environment.

I do not often pull from others, but I occasionally pull from
Paul's gitk tree.  When I see gitk's tip advance and I pull from
him, I may end up getting a string of two commits.  In other
words, in Joel's serial numbered revision scheme (emulated by
packed-ref snapshots versioned serially), there are two gitk
commits between my rN and r(N+1).

Somebody who hasn't thought about merges might be tempted to say
that we should use 2 revision numbers when a pull ends up
integrating 2 commits from outside, but that is not really
feasible.  When you make a merge, it is not like you are
cherry-picking individual commits from somebody else one by one.
In state rN, I did not have either of these two commits, and in
state r(N+1) I now have both, and that is the only definition of
rN that makes any sense.

    Side note: SVN does not have this "one state change but with
    multiple revisions" uneasiness problem, because it does not
    have a merge in distributed SCM's sense.  What it has is a
    convenient way to side-port changes that happened elsewhere
    to your state and create a new commit (so it is not that
    different from "cvs update -j").  After a "merge" happens
    you are just one commit ahead from previous state, just like
    a normal commit.

    The difference from that and us is that "log ORIG_HEAD.."
    will say we got new two commits integrated with the merge
    which makes us wonder why there are multiple events between
    two states, while SVN does not record what got cherry-picked
    from the side so you cannot even worry about it if you
    wanted to ;-).

But that definition stops making sense immediately when you look
at things from Paul's point of view.  He had these two commits
done separately, and in his repository they are recorded as two
separate events, even under Joel's serial numbered revision
scheme.  So for this serially numbered revisioning scheme to
make any sense to you, you have to refuse the everybody-is-equal
distributed model of git, and instead treat one repository
(mine) as more important than all others.  If that central
repository says these two commits did not exist in rN and they
appeared in r(N+1), that's the reality as far as you are
concerned, and what Paul says does not count to you at all.
That makes Paul unhappy.

In the same sense, you have to realize that the number "144"
above that came from kernel.org would mean absolutely nothing to
me.  I work on one commit at a time unless applying sequence of
patches, and typically ref-log knows that the last time _my_ tip
of "master" and "next" advanced were more than 30 minutes apart.
But I push four branches (maint/master/next/pu) out at the same
time to kernel.org, so between revision 143 and revision 144
four refs would have changed at kernel.org.  But in the
repository I do the real work with ref-log knows that that is
not the way how these branches advanced at all.  So it is not a
convenient number to work with from my point of view either.
