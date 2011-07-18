From: "George Spelvin" <linux@horizon.com>
Subject: Re: Git commit generation numbers
Date: 18 Jul 2011 01:13:47 -0400
Message-ID: <20110718051347.28952.qmail@science.horizon.com>
References: <CA+55aFwt+RDRK_r=9CXbdzsLuGDqswvGTtJDKi9Q3DQwB_Ha5Q@mail.gmail.com>
Cc: git@vger.kernel.org
To: linux@horizon.com, torvalds@linux-foundation.org
X-From: git-owner@vger.kernel.org Mon Jul 18 07:13:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qig9X-0003pt-2x
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jul 2011 07:13:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751046Ab1GRFNu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jul 2011 01:13:50 -0400
Received: from science.horizon.com ([71.41.210.146]:53231 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751023Ab1GRFNt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2011 01:13:49 -0400
Received: (qmail 28953 invoked by uid 1000); 18 Jul 2011 01:13:47 -0400
In-Reply-To: <CA+55aFwt+RDRK_r=9CXbdzsLuGDqswvGTtJDKi9Q3DQwB_Ha5Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177337>

> Nobody has *ever* given a reason why the cache would be better than
> just making it explicit.

I thought I listed a few.  Let me be clearer.

1) It involves changing the commit format.  Since the change is
   backward-compatible, it's not too bad, but this is still fundamentally
   A Bad Thing, to be avoided if possible.

2) It can't be retrofitted to help historical browsing.

3) You have to support commits without generation numbers forever.
   This is a support burden.  If you can generate generation numbers for
   an entire repository, including pre-existing commits, you can *throw
   out* the commit date heuristic code entirely.

4) It can't be made to work with grafts or replace objects.

5) It includes information which is redundant, but hard to verify,
   in git objects.  Leading to potentially bizarre and version-dependent
   behaviour if it's wrong.  (Checking that the numbers are consistent
   is the same work as regenerating a cache.)

6) It makes git commits slightly larger.  (Okay, that's reaching.)

> Why is that so hard for people to understand? The cache is just EXTRA WORK.

That's why it *might* have been a good idea to include the number in
the original design.  But now that the design is widely deployed, it's
better to avoid changing the design if not necessary.

With a bit of extra work, it's not necessary.

> To take your TLB example: it's like having a TLB for a page table that
> would be as easy to just create in a way that it's *faster* to look up
> in the actual data structure than it would be to look up in the cache.

You've subtly jumped points.  The original point was that it's worth
precomputing and storing the generation numbers.  I was trying to
say that this is fundamentally a caching operation.

Now we're talking about *where* to store the cached generation numbers.

Your point, which is a very valid one, is that they are to be stored
on disk, exactly one per commit, can be computed when the commit is
generated, and are accessed at the same time as the commit, so it makes
all kinds of sense to store them *with* the commits.  As part of them,
even.

This has the huge benefit that it does away with the need for a *separate*
data structure.  (Kinda sorts like the way AMD stores instruction
boundaries in the L1 I-cache, avoiding the need for a separate data
structure.)

I'm arguing that, despite this annoying overhead, there are valid reasons
to want to store it separately.  There are some practical ones, but the
basic one is an esthetic/maintainability judgement of "less cruft in
the commit objects is worth more cruft in the code".

Git has done very well partly *because* of the minimality of its basic
persistent object database format.  I think we should be very reluctant
to add to that without a demonstrated need that *cannot* be met in
another way.


In this particular case, a TLB is not a transport format.  It's okay
to add redundant cruft to make it faster, because it only lasts until
the next reboot.  (A more apropos, software-oriented analogy might be
"struct page".)

A git commit object *is* a transport format, one specifically designed
for transporting data a very long way forward in time, so it should be
designed with considerable care, and cruft ruthlessly eradicated.

Whatever you add to it has to be supported by every git implementation,
forever.  As does every implementation bug ever produced.

A cache, on the other hand, is purely a local implementation detail.
It can be changed between versions with much less effort.

I agree it's more implementation work.  But the upside is a cleaner
struct commit.  Which is a very good thing.
