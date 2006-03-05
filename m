From: Junio C Hamano <junkio@cox.net>
Subject: Managing topic branches
Date: Sat, 04 Mar 2006 17:56:31 -0800
Message-ID: <7vzmk5lkmo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Mar 05 02:56:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FFiUI-0006A6-4t
	for gcvg-git@gmane.org; Sun, 05 Mar 2006 02:56:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751840AbWCEB4d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Mar 2006 20:56:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751846AbWCEB4d
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Mar 2006 20:56:33 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:13515 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751840AbWCEB4d (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Mar 2006 20:56:33 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060305015347.GOBJ17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 4 Mar 2006 20:53:47 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17200>

I adopted Tony's excellent "topic branches" workflow to manage
the topics cooking in separate branches.  The flow goes like
this:

 - The change to the topic are made as new commits on top of
   the topic branch.  My naming convention for topic branches
   are two letters directory under .git/refs/heads/ and short
   word.  E.g. np/delta for Nico's finer-grained delta work,
   ml/cvsserver for Martin's git-cvsserver.

 - To test topics myself and publish the bleeding edge to
   others, updated topic branches are merged into "next".  If I
   have some changes to "master", the tip of it is also
   merged into "next", so that people following "next" will not
   miss out trivial fixes directly made to "master".

 - Once a topic is fully cooked, it is merged into "master".  I
   delete the topic branch in my private repository (its tip is
   already merged into "master" and also it was merged into
   "next" long time ago).

This worked reasonably well, and I can see what are still not in
"master" but brewing in "next" with two ways:

 - "git log master..next".  This is the orthodox way to view
   list of commits that are in next but still not in next.
   Giving --no-merges option would help cutting down the
   cluttering.

 - "git show-branch --topics master 'heads/??/*'". (note: ??/*
   is literally given to show-branch to let it glob).

However, the former started to break down recently, due to two
reasons.

1. np/delta turned out to be unsatisfactory, and I had reverts
   and re-reverts in the topic branch.  Eventually Nico and I
   decided to throw away the last three commits after merging
   the earlier bits into "master".

        (other topic brances merged into next)
           \   \       \    \      \   \
        o---o---o---o---o---o---o---o---o next
       /           /           /
      o---o---x---x---x---x---x np/delta
     /     \ <-- earlier parts merged
    o---o---o---o---o master

Some commits on "np/delta" merged into "next" are reverts and
the tip of "next" now do not have unwanted bits from the
finer-grained delta experiments.  I have dropped np/delta topic
branch, so "show-branch --topics" does not bother me with these
commits marked with 'x' anymore, but "git log master..next" will
keep showing them


2. "ml/cvsserver" was initially based on then-current "next"
   tip, because it depended on something else that was only
   present in "next", but by the time I pulled it from Martin,
   the pieces it depended on have already graduated to "master".

Since I wanted to have cvsserver in the "master" sooner than
everything else that were in "next" when Martin prepared these
commits, I ended up doing this:

Here is what the ancestry graph looked like when I received
cvsserver stuff:

                        a---b---c ml/cvsserver
                       /
          o---o---o---o next
         /   /   /             A: another topic ml/cvsserver
        /   A   B*                depended on
       /     \                 B*: many other "unready" topics
      o---o---o---o master

So I cherry-picked them on to "master", and merged both
"ml/cvsserver" and "master" into "next":

                        a---b---c ml/cvsserver
                       /         \ <-- questionable octopus leg
          o---o---o---o-----------* next
         /   /   /               /  
        /   o   o               /  
       /     \                 /
      o---o---o---o---a'--b'--c' master

I could have done without the "questionable octopus leg", but I
did so that when Martin pulled my "next" into his cvsserver
branch, he does not have to do the real merges [*1*].  But now
commits a---b---c comes back to haunt me whenever I do "git log
master..next".

The moral of the story is not to try to be nice to others
without thinking about its concequences ;-).  I should have just
done without the "questionable octopus leg", and asked Martin to
discard and rebase his tip of the development to my "next" after
this merge.


Anyhow, what I ended up doing to make "log master..next" usable
again was to cauterize the tips of unwanted topic branches
merged into next by merging them into "master" branch using
"ours" strategy:

	$ git checkout master
	$ git merge -s ours "excuse for this" HEAD ml/cvsserver np/delta

Luckily, I have merged up all the B*'s from "next" to "master",
so this was possible, but otherwise until I either merge them to
"master" or decide to drop forever I needed to keep a---b---c
around in "log master..next" output for a loooong time X-<.


[Footnote]

*1* I briefly thought about doing this instead, but this is a
wrong thing to do:

                        a---b---c ml/cvsserver
                       /         \       
          o---o---o---o-------------------* next
         /   /   /                 \     /
        /   A   B*                  \   / 
       /     \                       \ /
      o---o---o---o-------------------* master
                   \                 /
                    a'------b'------c'
                     (cherry picked)

At this point, master would claim to have merged B* but actually
it has not.
