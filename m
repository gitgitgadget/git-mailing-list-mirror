From: Junio C Hamano <junkio@cox.net>
Subject: Re: [Census] So who uses git?
Date: Sun, 29 Jan 2006 12:15:08 -0800
Message-ID: <7vslr6kcz7.fsf@assigned-by-dhcp.cox.net>
References: <46a038f90601251810m1086d353ne8c7147edee4962a@mail.gmail.com>
	<Pine.LNX.4.64.0601272345540.2909@evo.osdl.org>
	<46a038f90601272133o53438987ka6b97c21d0cdf921@mail.gmail.com>
	<1138446030.9919.112.camel@evo.keithp.com>
	<7vzmlgt5zt.fsf@assigned-by-dhcp.cox.net>
	<118833cc0601281814i503bf934ge32b12e7b090c44@mail.gmail.com>
	<7v7j8jpu48.fsf@assigned-by-dhcp.cox.net>
	<118833cc0601290619k1e9c6bb8gc63937f1a2d2b31e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 29 21:15:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3IxA-0000Mc-2z
	for gcvg-git@gmane.org; Sun, 29 Jan 2006 21:15:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbWA2UPM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jan 2006 15:15:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbWA2UPM
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jan 2006 15:15:12 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:46764 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751150AbWA2UPK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jan 2006 15:15:10 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060129201208.KCMW20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 29 Jan 2006 15:12:08 -0500
To: Morten Welinder <mwelinder@gmail.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15236>

Morten Welinder <mwelinder@gmail.com> writes:

> If I understand this right, that means that for a log file (in this
> case a ChangeLog file) that is appended to linearly as a
> function of revision number, we have...
>
> cvs: O(n) archive size
> git: O(n*n) archive size
>
> At least that is what we get if revision N is always deltad over
> revision N-1.  A good deal could be saved if instead of dumping
> a full copy every 10 revisions, that revision would instead be
> deltad off an earlier revision, but I think it'll still be O(n*n).

I have not counted O()rders, but it is not as simple as that,
because we do not really compare "versions".  If version N
reverts a change version N-1 introduced since version N-2, we
would not even store a copy for version N and version N-2
separately.  We just store a single copy, which may be delta
information against version N-1 (or the other way around and N-1
might be delta against N).

For the sake of math, let's say this project keeps only one
file, append only ChangeLog, with a straight line of development
without branches ("single strand of pearls"), and has revisions
1..N.

In RCS, you would have a full copy of the revision N, and
revision J is recorded as delta from revision J+1 for 1 <= J < N.
This delta is similar to "ed" script, and going backwards in the
history for the ChangeLog example means only line deletion is
involved, so what was removed is not recorded.  It records how
many lines are removed from where.  This is _very_ efficient and
compact.

In git, we would have a full copy of version N (because we favor
keeping larger blob associated with newer commits as a full
copy), and essentially the same thing as RCS happens.  The only
difference is that our "delta" is binary delta, but in this
case, it just records "copy N bytes from here to here" which
results in about the same amount of information to represent
each delta.  As you say, if (10 < N), we would have a full copy
every once in a while.  You could use depth other than the
default to make this chaining longer and if you did so, your
repository would be *very* compactly compressed.

However, retrieving cost of version 1 is quite different.  RCS
format is O(n) -- you start from the tip, extract and interpret
(N-1) deltas and apply them in turn to get to what you want.

The cost of extracting an arbitrary version is bounded in git
packfile, because you need to do such an "extract, interpret and
apply" at most $depth cycles.  This is primarily because we do
not store "versions" but individual objects, and do not apply
"newer revisions are far more likely to be accessed often"
heuristics, which RCS format is designed for.
