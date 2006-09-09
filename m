From: Junio C Hamano <junkio@cox.net>
Subject: Re: Change set based shallow clone
Date: Sat, 09 Sep 2006 14:11:51 -0700
Message-ID: <7v4pvgwxrc.fsf@assigned-by-dhcp.cox.net>
References: <9e4733910609081413p32456768g280bdc9b232d7902@mail.gmail.com>
	<Pine.LNX.4.64.0609081600530.27779@g5.osdl.org>
	<17666.4936.894588.825011@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0609081944060.27779@g5.osdl.org>
	<17666.13716.401727.601933@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0609082054560.27779@g5.osdl.org>
	<e5bfff550609090147q37d61f37j9c3e8ae6d3a0cf35@mail.gmail.com>
	<Pine.LNX.4.64.0609091022360.27779@g5.osdl.org>
	<e5bfff550609091104s3709b82fld3057a07a84ae857@mail.gmail.com>
	<Pine.LNX.4.64.0609091256110.27779@g5.osdl.org>
	<20060909204307.GB16906@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 09 23:11:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMA74-0001EW-IB
	for gcvg-git@gmane.org; Sat, 09 Sep 2006 23:11:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964865AbWIIVLY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Sep 2006 17:11:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964866AbWIIVLY
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Sep 2006 17:11:24 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:62708 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S964865AbWIIVLX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Sep 2006 17:11:23 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060909211123.ILOF6235.fed1rmmtao06.cox.net@fed1rmimpo01.cox.net>;
          Sat, 9 Sep 2006 17:11:23 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id LMBD1V00B1kojtg0000000
	Sat, 09 Sep 2006 17:11:14 -0400
To: Jeff King <peff@peff.net>
In-Reply-To: <20060909204307.GB16906@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 9 Sep 2006 16:43:07 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26766>

Jeff King <peff@peff.net> writes:

> I'm just coming into this discussion in the middle and know very little
> about the rev-list code, so please humor me and tell me why my
> suggestion is completely irrelevant.

Not irrelevant.

> The problem you describe seems to come from doing a depth-first display
> of each branch. Why not look at the tip of each "active" branch
> simultaneously and pick the one with the most recent date? Something
> like:

That's what we have been doing from day one.

The trouble Linus illustrated is that in a global project you
cannot rely on timestamps always being correct.  You can use
them as HINT, but you need to be prepared to do sensible things
when some people screw up the time.

> On Sat, Sep 09, 2006 at 01:05:42PM -0700, Linus Torvalds wrote:
>
>> The example is
>> 
>> 		    A		<--- tip of branch
>> 		   / \
>> 		  B   E
>>                |   |
>> 		  |   F
>> 		  | /
>> 		  C 
>> 		  |
>> 		  D
>> 		...
>> 
>> where the lettering is in "date order" (ie "A" is more recent than "B" 
>> etc). In this situation, we'd start following the branch A->B->C->D->.. 
>> before we even start looking at E and F, because they all _look_ more 
>> recent.

The ancestry graph, topologically, flows from bottom to top but
the timestamps are in F E D C B A order (A is closer to current,
F is in the most distant past).  Somebody forked from C on a
machine with slow clock, made two commits with wrong (from the
point of view of the person who made commit C anyway) timestamps,
and that side branch ended up merged with B into A.

You start following A, read A and find B and E (now B and E are
"active" in your lingo), pop B because it is the most recent.
We look at B, find C is the parent, push C into the active list
(which is always sorted by timestamp order).  Now "active" are C
and E, and C is most recent so we pop C.

In the past people suggested workarounds such as making commit-tree 
to ensure that a child commit has timestamp no older than any of
its parents by either refusing to make such or automatically
adjusting.  That would surely work around the problem, but if
somebody made a commit with a wrong timestamp far into the
future, every commit that is made after that will have
"adjusted" timestamp that pretty much is meaningless, so that
would not work well in practice.

If we had a commit generation number field in the commit object,
we could have used something like that.  Each commit gets
generation number that is maximum of its parents' generation
number plus one, and we prime the recursive definition by giving
root commits generation number of 0, and rev-list would have
used the generation number not timestamp to do the above
"date-order" sort and we will always get topology right.  Of
course fsck-objects needs to be taught to check and complain if
the generation numbers between parent and child are inverted.

But it's too late in the game now -- maybe in git version 47.
