From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFH] revision limiting sometimes ignored
Date: Tue, 05 Feb 2008 17:51:32 -0800
Message-ID: <7v7ihi7syj.fsf@gitster.siamese.dyndns.org>
References: <20080202122135.GA5783@code-monkey.de>
	<20080203030054.GA18654@coredump.intra.peff.net>
	<20080203043310.GA5984@coredump.intra.peff.net>
	<alpine.LFD.1.00.0802040922480.3034@hp.linux-foundation.org>
	<7vr6fsk08w.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.1.00.0802041146060.3034@hp.linux-foundation.org>
	<alpine.LFD.1.00.0802041223080.3034@hp.linux-foundation.org>
	<7vir13g9hx.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.1.00.0802051300050.3110@woody.linux-foundation.org>
	<alpine.LSU.1.00.0802052228280.8543@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 06 02:52:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMZT2-0003dl-9I
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 02:52:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759701AbYBFBwA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 20:52:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759431AbYBFBv7
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 20:51:59 -0500
Received: from rune.pobox.com ([208.210.124.79]:44827 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759645AbYBFBv6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 20:51:58 -0500
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id C5F82193F81;
	Tue,  5 Feb 2008 20:52:18 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 5F633193FD2;
	Tue,  5 Feb 2008 20:52:11 -0500 (EST)
In-Reply-To: <alpine.LSU.1.00.0802052228280.8543@racer.site> (Johannes
	Schindelin's message of "Tue, 5 Feb 2008 22:34:42 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72745>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> In our case, this would mean that the revision walker should realise that 
> a child whose date is not older than its parent commit must be wrong.  And 
> just take the parent's date instead (but maybe only for the purpose of 
> limiting).

No.

	1---2---3---4

Timestamps are 2 < 3 < 4 < 1 and you ask:

	$ git rev-list 1 ^4

We push 1 and ^4 in "list".  We pick 1 and push it out to
"newlist" (possible results, but the hope is they may later be
marked as UNINTERESTING as we traverse the remaining one still
on "list").  We pick ^4, mark 3 as UNINTERESTING and push ^3
into "list", and realize there is nobody that is still positive
(i.e. without UNINTERESTING bit).  We have "clever" optimization
that stops in such a case.

Nowhere in this sequence we can notice that "A child whose date
is not older than its parent".  We do not even get to commit 2
during the traversal.

In order to notice the problem, you need to make sure we will
see the link between 1 and 2 (i.e. the fact that 1 has a child
that is older than itself).  That would take traversing "all the
way down".

The "all the way down" is not quite correct, though.  If we have
other commits, like this:

              B---C
             /
     ---0---A---1---2---3---4

where timestamps are 0 < A < B < C < 2 < 3 < 4 < 1, and if you
ask:

	$ git rev-list 1 ^4 ^A
	$ git rev-list 1 ^4 ^B
	$ git rev-list 1 ^4 ^C

we will have a similar issue.  We do not have to go down the
potentially long history beyond A.  But we at least need to
traverse down to the merge base of negatives in "list" and
positives in "newlist" when "list" becomes all UNINTERESTING (in
this case, traverse all paths as if we are trying to find out
the merge-base between 1 and 3.  That traversal will see 2 and
we will see your clock skew).

But the point is that the condition you mentioned cannot be
found out unless you traverse to 2, and at that point you have
traversed enough already.

As Linus earlier said, the question really is: for positive
commits in "newlist", have we not missed any its UNINTERESTING
descendants?

For a toy-scale graph, a parallel merge-base traversal like what
show-branch does may work, but for a real workload, newlist
would contain literally hundreds of commits, so using unaltered
"merge-base" algorithm is probably not an option either.
