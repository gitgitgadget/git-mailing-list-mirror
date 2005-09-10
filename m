From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-bisect failure
Date: Fri, 09 Sep 2005 19:39:21 -0700
Message-ID: <7virx9ir3a.fsf@assigned-by-dhcp.cox.net>
References: <20050909011034.12f2bf64.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 10 04:39:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EDvH4-00009s-QW
	for gcvg-git@gmane.org; Sat, 10 Sep 2005 04:39:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030469AbVIJCjY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Sep 2005 22:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030477AbVIJCjX
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Sep 2005 22:39:23 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:20709 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1030469AbVIJCjX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Sep 2005 22:39:23 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050910023923.HBAJ11315.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 9 Sep 2005 22:39:23 -0400
To: Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050909011034.12f2bf64.akpm@osdl.org> (Andrew Morton's message
	of "Fri, 9 Sep 2005 01:10:34 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8252>

bix:/usr/src/git26> git bisect bad
Bisecting:      55 revisions left to test after this

At this point, you marked 4c139862b8831261d57de02716b92f82e5fb463b
"[PATCH] xtensa: delete accidental file" is already bad.  And the last
known good commit is b749bfcd1be72f8cb8310e1cac12825bda029432 "[PATCH]
ppc64: update xmon helptext".  The commit between these is just a
straight sequence (no branches), so running "git bisect visualize"
gives me a nice single strand of pearls.

bix:/usr/src/git26> git bisect bad
Bisecting:      28 revisions left to test after this

With this, you marked "[PATCH] i386 boottime for_each_cpu broken" is
bad.  "Reread references" in the running gitk shows me that the range
between bad and good halved.

bix:/usr/src/git26> git bisect good
Bisecting:      14 revisions left to test after this

Marked "[PATCH] mips: remove timex.h for vr41xx" good.

bix:/usr/src/git26> git bisect good
Bisecting:       7 revisions left to test after this

Marked "[PATCH] i386: cleanup serialize msr" good.

bix:/usr/src/git26> git bisect good
Bisecting:       3 revisions left to test after this

Marked "[PATCH] x86: privilege cleanup" good.

bix:/usr/src/git26> git bisect bad 
Bisecting:       2 revisions left to test after this

Marked "[PATCH] x86: introduce a write acessor for updating the
current LDT" bad.

Just after you marked "[PATCH] x86: privilege cleanup" as good, the
list of suspects looked like this (time flows bottom to top):

bad  [PATCH] i386 boottime for_each_cpu broken
     [PATCH] i386: encapsulate copying of pgd entries
     [PATCH] x86 NMI: better support for debuggers
???  [PATCH] x86: introduce a write acessor for updating the current LDT
     [PATCH] x86: remove redundant TSS clearing
     [PATCH] x86: make IOPL explicit
good [PATCH] x86: privilege cleanup

and you said the middle one is already bad here.  We are tracking
regression, so "privilege cleanup" was good and in the course of
somewhere from there to "i386 boottime for_each_cpu broken" which is
bad, a breakage happened.  You marked the "updating the current LDT"
one as bad, which to me looks like it was already broken at that point.

After that, you say:
bix:/usr/src/git26> git bisect good

to mark "[PATCH] x86: remove redundant TSS clearing" as good,
which means "redundant TSS" was good and "current LDT" was bad,
and they are back to back, so it looks like the bug was
introduced by the "LDT", which is what you got.  So it _might_
be possible that you said "current LDT" was bad when it was
actually good.  That is one possible explanation.

Another possibility is that the symptom you were tracking was
not a single regression that was introduced with a single patch.
Could it be possible that "the current LDT" did not pass your
test but from different bug, which was fixed by either "x86 NMI"
or "encapsulate copying pgd"?  Sorry I am not a kernel developer
so I cannot judge if the above is plausible or not.

In any case, there is one caveat about bisection bug search.  It
assumes that you are tracking a single regression that was
introduced, and there is no funny interaction of bugs hiding
each other -- this may not hold true in the real life.  IOW,
something like this could be possible:

BAD  [PATCH] i386 boottime for_each_cpu broken
good [PATCH] i386: encapsulate copying of pgd entries
bad  [PATCH] x86 NMI: better support for debuggers
BAD  [PATCH] x86: introduce a write acessor for updating the current LDT
good [PATCH] x86: remove redundant TSS clearing
good [PATCH] x86: make IOPL explicit
GOOD [PATCH] x86: privilege cleanup

I marked the ones bisect told you to test in Capital letters, and a
good/bad which was never tested in lowercase.  If the bug pattern is
not "up to here everything is good but after that things start to
break", then bisect, by its nature of skipping the check to narrow the
range down fast, would miss the real transition from good to bad.
