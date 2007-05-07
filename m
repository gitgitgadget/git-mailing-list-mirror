From: Junio C Hamano <junkio@cox.net>
Subject: Re: 'upstream' branches.
Date: Sun, 06 May 2007 18:20:29 -0700
Message-ID: <7vabwh8m5e.fsf@assigned-by-dhcp.cox.net>
References: <1178368166.11851.60.camel@pmac.infradead.org>
	<20070505174416.GA2898@steel.home>
	<1178387429.17680.35.camel@shinybook.infradead.org>
	<20070505225249.GE2898@steel.home>
	<7v3b2ah30f.fsf@assigned-by-dhcp.cox.net>
	<1178436926.17680.74.camel@shinybook.infradead.org>
	<7vy7k2e606.fsf@assigned-by-dhcp.cox.net>
	<1178440759.17680.112.camel@shinybook.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>
X-From: git-owner@vger.kernel.org Mon May 07 03:20:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hkru1-00086O-61
	for gcvg-git@gmane.org; Mon, 07 May 2007 03:20:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753188AbXEGBUb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 May 2007 21:20:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbXEGBUb
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 21:20:31 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:39333 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753188AbXEGBUa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2007 21:20:30 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070507012031.KQJN1318.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Sun, 6 May 2007 21:20:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id w1LV1W00k1kojtg0000000; Sun, 06 May 2007 21:20:30 -0400
In-Reply-To: <1178440759.17680.112.camel@shinybook.infradead.org> (David
	Woodhouse's message of "Sun, 06 May 2007 09:39:19 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46404>

David Woodhouse <dwmw2@infradead.org> writes:

> You're speaking from the point of view of the git implementation.
> From the point of view of the _user_, I would violently disagree :)

I would not view this as an implementation issue.  If you or
anybody disagrees, I think that is a disagreement at more
conceptual level.

> Having pulled that into my local repository, how do I then set it up to
> push the latest commit of refs/remotes/*/linus into the 'linus' branch
> of the origin, when I push back to my public tree on the server? Or do
> you expect _everyone_ who pulls from that public tree to also do stuff
> like:
>> 	git log master --not remotes/a/linus remotes/b/linus remotes/c/linus

Of course not.  Why are you even _PUBLISHING_ what your
upstreams' origins are to begin with?  I think you are simply
being silly.

So let's step back a bit, so I can clarify why I said "silly" --
I am not Linus and usually try not to say things like that ;-).

First, I think everybody by now understands why rewinding a
branch in a published repository is a bad idea, and agrees that
(at least) Linus's tip never rewinds but always goes forward.
I see you also subscribe to the school of thought:

> Can't I instruct it to _merge_ the 'linus' branch of each remote into my
> own 'linus' branch? Of course that merge would only ever be a
> fast-forward or a no-op, in practice.

By this, you are effectively getting the origin as seen by other
people, and taking the most advanced one as the union of the
origins.

But step back and think about the reason why you would even want
to know about the origin of each of your buddies (I earlier said
"upstream" in this message, but because there is no inherent
up/down in the distributed development model, I think it is more
correct to call them your mtd buddies).

Earlier I said that it would make sense for you to keep track of
the tip and "the tip of Linus as seen by the buddy" for _each_
of your mtd buddies, by doing:

	[remote "A"]
        	fetch = refs/heads/master:refs/remotes/A/master
                fetch = refs/heads/linus:refs/remotes/A/linus

for 'A', 'B', and 'C', your mtd buddies.  It would make sense
because the log between A/linus and A/master represents what A
did, and what have not been incorporated in the Linus tree yet
from A's point of view.  You can do

	$ git log remotes/A/linus..remotes/A/master

for that (same for B and C).  Also, diff between these would
represent the change A made as a whole:

	$ git diff remotes/A/linus..remotes/A/master

But your arrangement is a bit different.  You allow the same
branch refs/heads/linus to be updated/overwritten by A, B and C.
We could teach special semantics of "fast forward or nothing",
perhaps using '*' like this:

	[remote "A"]
        	fetch = refs/heads/master:refs/heads/A
                fetch = *refs/heads/linus:refs/heads/linus
	[remote "B"]
        	fetch = refs/heads/master:refs/heads/B
                fetch = *refs/heads/linus:refs/heads/linus

as you suggest, but I do not think it buys you much.  The tip of
Linus's repository B or C has may much more advanced than what A
based his work on, so your 'linus' may be soemthing A has not
seen yet.  However, even then:

	$ git log linus..A

would continue to work.  On the other hand, the earlier "diff"
now needs to be written like this:

	$ git diff $(git merge-base linus A)..A

Because this is the right thing to do in regular cases anyway,
we even have a short-hand for that in the "three dot" form:

	$ git diff linus...A

I think you already know these two things: "git-log linus..A is
the right way to ask what A did relative to Linus, even when
'linus' is ahead of what A based his work on" and "the three-dot
notation linus...A is the right thing to use when 'linus' could
be ahead of what A is based on".  Otherwise you would not be
asking for the "fast forward or nothing" fetch, as its result
would be hard to use without these characteristics.

But if you know them, and if you do not care exactly which
commit from Linus what each of your buddies thought was at
Linus's tip (and you obviously don't, as "fast forward or
nothing" would lose information for two people and keep only the
most advanced one), then you would also know that there is not
much point fetching the origin from your buddies.  You can fetch
and keep track of where Linus's tip is directly from Linus
yourself, and the above "git log linus..A" and "git diff
linus...A" would work.  Then there is no risk of confusion.  If
one of A, B, or C had a wrong commit that claims to from Linus,
having separate tracking branch on your end is necessary to
figure out which one has screwed up -- "fast forward or nothing"
would not help.

Having said that, I think "fast-forward or nothing" might make
sense in one special case.  If the kernel project _were_ more
regidly structured such that you were a third-stratum developer
who can only interact with second-stratum people and not allowed
to fetch directly from first-stratum repository (i.e. Linus's).
Then, the best guess you could make where the tip of Linus's
repository is by learning second-hand from the repositories of
second-stratum you fetch, and keeping track of their origins,
and picking the most advanced one among them.

But the kernel project is not structured that way.

You also _could_ argue that your fetching directly from Linus is
one extra fetch, and you do not _care_ where the real Linus's
tip is.  Both of these are correct, if the only thing you care
about in this application is to inspect the progress your mtd
buddies A, B and C are making.  Even when all of them are way
behind from Linus's tree, "log linus..A"/"diff linus...A" would
work just fine.  I do not think it is unreasonable to want to
maintain a single 'linus' branch by picking the most advanced
among the different 'linus' branches you get from different
repositories.

But at that point, I think it is such a specialized application
that you should be scripting that outside of git-core.

Oh, and to cut-down the message roundtrip (although I do not
think you would make such a silly argument, I do very much
anticipate somebody else would).  I would not buy "SCM tool
should do that work for me, not me doing that work for SCM"
argument on that last point.  It is like saying "why doesn't
your editor fill a completed program when I open a new file
whose name is 'hello.c', and instead have me type it all?  It
should be clear that I want to write a "hello world" program,
and the tool should be helping me".
