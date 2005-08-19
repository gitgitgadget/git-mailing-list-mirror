From: Junio C Hamano <junkio@cox.net>
Subject: Multi-head fetches, pulls, and a King Ghidorah
Date: Fri, 19 Aug 2005 00:45:07 -0700
Message-ID: <7vy86y1ibg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Aug 19 09:46:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E61Z0-0006CF-Mm
	for gcvg-git@gmane.org; Fri, 19 Aug 2005 09:45:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964895AbVHSHpP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Aug 2005 03:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964899AbVHSHpO
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Aug 2005 03:45:14 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:27321 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S964895AbVHSHpN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Aug 2005 03:45:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050819074507.IKUO1860.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 19 Aug 2005 03:45:07 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The current "pu" branch has most of the necessary plumbing for
multi-head fetching, pulling and creating Octopus merges based
on multiple heads.  I have made "git pull" multi-head aware but
did not make it multi-head capable.

I have been trying out Tony Luck's excellent topic-branch
workflow (see Documentation/using-topic-branches.txt), and the
head of the "pu" branch is an Octopus on top of the "master" and
my two private topic branches [*1*] made with "git octopus".

I have been thinking about how the multi-head fetch and merge
should interact with each other.  It appears to me that coming
up with a reasonably semantics for "git pull" that would fit
everybody is very difficult, because there are at least two
different valid workflows that involve multi-head pulling, and
they need to do different things.  I'll talk about "git pull"
that can deal with more than one remote heads, which does not
exist yet, in the next couple of paragraphs.

Suppose I were the Emperor Penguin [*2*], and Jeff asks "Please
pull from my netdev-2.6.git repository, sis190 and e100
branches."  It is very reasonable to expect the following to
fetch heads of those two branches and attempt to make an Octopus
[*3*] on top of a copy of the Penguin head:

    $ cat .git/branches/jgarzik
    kernel.org:/pub/linux/kernel/git/jgarzik/
    $ git checkout -b try-jeffs-update master
    $ git pull jgarzik/netdev-2.6.git/ sis190 e100
    $ git diff -p master..HEAD | git apply --stat --summary

The arguments to pull, especially the refspec parameters
("sis190" and "e100" in the above example) are given to the
underlying "git fetch", and because neither of them have a
colon, they are not stored in corresponding places under the
local refs/heads/.  Instead, fetched heads would be fed directly
to "git octopus" inside "git pull" (just like the current "git
pull" invokes "git resolve" internally after fetching just one
head).

However, suppose then I were Joe Random, an individual netdev
contributor who is interested in these two netdev branches.
Upon seeing the pull request, I might decide it is a good time
to get changes from there, my upstream.

    $ git pull jgarzik/netdev-2.6.git/ sis190:sis190 e100:e100

Because I am keeping track of copies of these two branches, I
use "sis190:sis190 e100:e100" to update my local heads.

I might have some local changes in these two branches.  The old
"git fetch" unconditionally overwrote local heads when told to,
but lately it acquired the "reverse push" semantics Johannes
Schindelin proposed to make it safer.  The fetch process only
overwrites local heads when the upstream change results in a
fast-forward merge; practically, that happens only when I have
not worked on that branch since I pulled from the upstream the
last time.  So my refs/heads/sis190 and refs/heads/e100 may be
copies of Jeff's heads, or they may be the same heads as I had
before starting the fetch.

At this point, it might be reasonable to expect that the above
"git pull" command would behave as if I pulled (i.e. fetched and
merged) these heads separately, using traditional single-head
pull:

    $ git checkout sis190
    $ git pull jgarzik/netdev-2.6.git/ sis190:sis190
    $ git checkout e100
    $ git pull jgarzik/netdev-2.6.git/ e100:e100

That is, fetch and resolve them independently and individually.

Back in the Emperor Penguin example, he _could_ also have been
interested in keeping copies of Jeff's branch heads, so he could
have written refspecs on the command line the same way as Joe
Random did.  I.e. instead of:

    $ git pull jgarzik/netdev-2.6.git/ sis190 e100

he could have said:

    $ git pull jgarzik/netdev-2.6.git/ sis190:sis190 e100:e100

Both "Octopus" and "Multiple independent pull" semantics are
valid to support different workflows, and there is no way to
differenciate the two from the command line, without giving an
extra flag and making the implementation more complicated.

Currently, I am inclined to leave the current "not more than one
remote head" implementation, and possibly extend it to support
the "Octopus" semantics later, for three very simple reasons.

 (1) What the latter "git pull" is buying us compared to two
     traditional single-head pulls is very little; that the
     underlying "git fetch" _could_ obtain packs more
     efficiently than two independent fetches.

 (2) The netdev example happened to involve multiple heads from
     a single repository, but the pull request could as well
     have been "jgarzik/netdev-2.6.git#sis190 and
     jgarzik/libata-dev.git#sil24", in which case I wouldn't
     have to be worrying about multi-head pull at all; the user
     would just have used two independent traditional "git
     pull" --- there is no other option.

 (3) Or course, because I am lazy ;-).  Seriously, multiple
     independent merges is a nightmere when you start thinking
     about what to do when you get a conflict and need to have
     the user hand merge in the middle of the first one.

Since "git pull" tentatively would not do multi-head natively,
the Emperor Penguin example needs to be done this way:

    $ git checkout -b try-jeffs-update master
    $ git fetch jgarzik/netdev-2.6.git/ sis190 e100
    $ git octopus
    $ git diff -p master..HEAD | git apply --stat --summary

I think this should already work with the current "pu" branch
head.


[Footnotes]

*1* I should probably write a bit about how I do things in a
separate message as a how-to.

*2* I am not a penguin.  Figuring out what kind of animal I am
is left as an easter-egg hunt.  I have had the answer somewhere
in the current git.git archive for some time ;-).

*3* This one has only three heads, so that would be a Tripus,
but what X-pus counts is not heads but legs, so we should really
be calling this a King Ghidorah who has three heads.

*4* What's currently in "pu" branch dies when a head cannot be
fast forwarded, but I think that is simply a thinko.  It should
just refuse to fast-forward and warn, leave the obtained remote
head somewhere other tools can find later, just as the original
"reverse push" script by Johannes did.
