From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH v7 5/5] Implement line-history search (git log -L)
Date: Thu, 7 Jun 2012 19:52:10 +0200
Message-ID: <87sje757sl.fsf@thomas.inf.ethz.ch>
References: <cover.1339063659.git.trast@student.ethz.ch>
	<61a797a048c43d64352ef86a1b224f017e7161ae.1339063659.git.trast@student.ethz.ch>
	<7vhaunhvc8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <git@vger.kernel.org>, Bo Yang <struggleyb.nku@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 07 19:52:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Scgsb-0004xK-Qc
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jun 2012 19:52:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932590Ab2FGRwN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jun 2012 13:52:13 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:10606 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759633Ab2FGRwN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2012 13:52:13 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 7 Jun
 2012 19:52:10 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (46.126.8.85) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 7 Jun
 2012 19:52:11 +0200
In-Reply-To: <7vhaunhvc8.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 7 Jun 2012 10:42:47 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199427>

Junio C Hamano <gitster@pobox.com> writes:

> Thomas Rast <trast@student.ethz.ch> writes:
>
>> This is a rewrite of much of Bo's work, mainly in an effort to split
>> it into smaller, easier to understand routines.
>
> You mentioned "splitting" in the cover letter, but it does seem to
> need a bit more work.

Yes, I think I also mentioned that it's not ready for inclusion ;-)

Most of your points are spot on, however:

>> +static void diff_ranges_release (struct diff_ranges *diff)
>> +{
>> +	range_set_release(&diff->parent);
>> +	range_set_release(&diff->target);
>> +}
>
> Unused.

That should end up being used a few times...

>> +static void diff_ranges_filter_touched (struct diff_ranges *out,
>> +					struct diff_ranges *diff,
>> +					struct range_set *rs)
...
>> +		if (ranges_overlap(&diff->target.ranges[i], &rs->ranges[j])) {
>> +			range_set_append(&out->parent,
>> +					 diff->parent.ranges[i].start,
>> +					 diff->parent.ranges[i].end);
>> +			range_set_append(&out->target,
>> +					 diff->target.ranges[i].start,
>> +					 diff->target.ranges[i].end);
>
> Shouldn't the ranges be merged, not just appended?

If the code ever passed anything but an empty struct diff_ranges as the
'out' argument, yes.  But it doesn't.  In general I'm usually doing the
'out' dance to save one heap allocation.  Perhaps it would be cleaner to
allocate all of them on the heap instead, and return as pointers, dunno.

>> +	/* line level range that we are chasing */
>> +	struct decoration line_log_data;
>
> Good use of decoration.

That was actually Bo's idea.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
