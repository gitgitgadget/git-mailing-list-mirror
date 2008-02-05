From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFH] revision limiting sometimes ignored
Date: Tue, 05 Feb 2008 15:44:29 -0800
Message-ID: <7vprvb6k9u.fsf@gitster.siamese.dyndns.org>
References: <20080202122135.GA5783@code-monkey.de>
	<20080203030054.GA18654@coredump.intra.peff.net>
	<20080203043310.GA5984@coredump.intra.peff.net>
	<alpine.LFD.1.00.0802040922480.3034@hp.linux-foundation.org>
	<7vr6fsk08w.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.1.00.0802041146060.3034@hp.linux-foundation.org>
	<alpine.LFD.1.00.0802041223080.3034@hp.linux-foundation.org>
	<7vir13g9hx.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.1.00.0802051300050.3110@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Feb 06 01:35:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMYGH-0001Ml-Hz
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 01:35:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761003AbYBFAei (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 19:34:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761077AbYBFAeg
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 19:34:36 -0500
Received: from lollipop.listbox.com ([208.210.124.78]:59250 "EHLO
	lollipop.listbox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761000AbYBFAed (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 19:34:33 -0500
Received: from rune.pobox.com (rune.pobox.com [208.210.124.79])
	by lollipop.listbox.com (Postfix) with ESMTP id CBCF850A16D
	for <git@vger.kernel.org>; Tue,  5 Feb 2008 18:48:16 -0500 (EST)
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 367CC193CBD;
	Tue,  5 Feb 2008 18:46:15 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 131C1193CEC;
	Tue,  5 Feb 2008 18:44:52 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72732>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> I really wonder if the right thing is not simply to admit that we consider 
> the commit time meaningful (within some fudge factor!), and then do:
>
>  - make commit warn if any parent commit date is in the future from the 
>    current commit date (allow a *small* fudge factor here, say 5 minutes).

Hmmm.  In other words, you are punished for trying to build on
top of somebody else who screwed up.  That sucks.

>  - teach fsck to complain about parent commits being in the future from 
>    their children (allow the same small fudge factor).

And this is even worse.

But I think these are sane thing to do regardless.  To prevent
problematic commits from contaminating other people, we could
add default post-receive hook and perhaps a new pre-merge hook
to inspect the newly obtained history to warn and reject a merge
(including fast-forward) if it contains commits far into the
future.  We would also need a mechanism to force a merge with
such a clock-skewed history if we did so.

>  - make the revision walking code realize that if times are too close to 
>    each other, it should walk a bit further back...
>
> because quite frankly, this bug only shows up when your time goes 
> backwards (or stays the same, but the fudge-factor should take care of 
> that too).

> @@ -579,6 +581,15 @@ static int limit_list(struct rev_info *revs)
>  			return -1;
>  		if (obj->flags & UNINTERESTING) {
>  			mark_parents_uninteresting(commit);
> +
> +			/*
> +			 * If we have commits on the newlist, we don't
> +			 * want to do the "everybody_uninteresting()"
> +			 * test until we've hit a negative commit that
> +			 * is solidly in the past
> +			 */
> +			if (newlist && newlist->item->date < commit->date + FUDGE)
> +				continue;
>  			if (everybody_uninteresting(list))
>  				break;
>  			continue;

We picked up commit which we know is the youngest in the "list".
Because we push into newlist as we traverse, newlist is sorted
by date, and the element pointed by it is the youngest in there.
That is something we have processed earlier, so it ought to be
younger than this commit.  Otherwise we have found a problematic
clock skew.  Ok, I think it should work.

The clock skew t6009 artificially introduces needs to be
shortened for this, though.
