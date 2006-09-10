From: Junio C Hamano <junkio@cox.net>
Subject: Re: Change set based shallow clone
Date: Sat, 09 Sep 2006 21:54:24 -0700
Message-ID: <7virjwuxrz.fsf@assigned-by-dhcp.cox.net>
References: <9e4733910609071923tf1c49f6o70419e961e9eb66f@mail.gmail.com>
	<Pine.LNX.4.64.0609081944060.27779@g5.osdl.org>
	<17666.13716.401727.601933@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0609082054560.27779@g5.osdl.org>
	<e5bfff550609090147q37d61f37j9c3e8ae6d3a0cf35@mail.gmail.com>
	<Pine.LNX.4.64.0609091022360.27779@g5.osdl.org>
	<e5bfff550609091104s3709b82fld3057a07a84ae857@mail.gmail.com>
	<Pine.LNX.4.64.0609091256110.27779@g5.osdl.org>
	<e5bfff550609092049t5e016cacr2502ce81bbb6489e@mail.gmail.com>
	<7vpse4uzos.fsf@assigned-by-dhcp.cox.net>
	<e5bfff550609092123t1d8b6c70s5750fbb787534812@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Linus Torvalds" <torvalds@osdl.org>,
	"Paul Mackerras" <paulus@samba.org>,
	"Jon Smirl" <jonsmirl@gmail.com>,
	"linux@horizon.com" <linux@horizon.com>,
	"Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 10 06:54:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMHKT-0002Wr-VT
	for gcvg-git@gmane.org; Sun, 10 Sep 2006 06:54:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932295AbWIJExt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Sep 2006 00:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932296AbWIJExt
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Sep 2006 00:53:49 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:49918 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S932295AbWIJExs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Sep 2006 00:53:48 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060910045347.RUCP6235.fed1rmmtao06.cox.net@fed1rmimpo02.cox.net>;
          Sun, 10 Sep 2006 00:53:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id LUtn1V00v1kojtg0000000
	Sun, 10 Sep 2006 00:53:48 -0400
To: "Marco Costalba" <mcostalba@gmail.com>
In-Reply-To: <e5bfff550609092123t1d8b6c70s5750fbb787534812@mail.gmail.com>
	(Marco Costalba's message of "Sun, 10 Sep 2006 06:23:11 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26783>

"Marco Costalba" <mcostalba@gmail.com> writes:

> >>
> >>                     A           <--- tip of branch
> >>                    / \
> >>                   B   E
> >>                   |   |
> >>                   |   F
> >>                   | /
> >>                   C
> >>                   |
> >>                   D
> >>                 ...
> >>
>
> Ok. What about something like this?
> A, B, C, D, E, (-3, 1)F
>
> where -3 is the correct position in sequence and 1 is the number of
> revisions before F to whom apply the -3 rule.

That means F knows who its descendants are, and commit objects
do not have that information, so while traversing you need to
keep track of all the descendants yourself, doesn't it?

And how does that fix-up information help the user of the stream
anyway?  If I understand your model correctly, the model does
not synchronously draw nodes as they are received, so it keeps
track of what it has seen so far.  When it sees F it can notice
that its parent, C, is something it has seen, so it can tell F
is wrong.  It also knows that it has seen E and E's parent is F
(which turned out to be at a wrong spot), so it can suspect E is
also in the wrong spot (now, it is fuzzy to me how that chain
of suspicion ends at E and does not propagate up to A, but let's
think about that later).

There is one thing that the user knows a lot better than the
generic rev-list output part.  It is the size of the output
window (how tall the window is).  I wonder if there is a way to
exploit it, either in the user, or telling the size of the
window (and perhaps where the display region at the top begins
at) to rev-list...

If we are dealing in a 3-item-tall window, we will traverse A B
C D, notice they form a single strand of pearls, and can make a
mental note that we do not have to worry about ancestors of D
for now, because D's ancestors will be drawn below C, which is
already the putative bottom edge of the window (when oddballs
like E and F comes later, they can only push things down at the
bottom edge of the window).  Then rev-list can postpone
traversing D and go on to traverse other nodes that are in the
"active" list (in this case, E).

I am starting to suspect that introducing "generation" header to
the commit objects might actually be a very good thing.  For
one thing, rev-list will automatically get the topology always
right if we did so.

We obviously need to update 'convert-objects' and tell everybody
that they need to rewrite their history if we take this route.
That kind of flag-day conversion used to be an Ok thing to do,
but it is getting harder and harder these days for obvious
reasons, though.
