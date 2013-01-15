From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 06/14] imap-send.c: remove some unused fields from
 struct store
Date: Tue, 15 Jan 2013 14:30:59 -0800
Message-ID: <7vtxqi13ks.fsf@alter.siamese.dyndns.org>
References: <1358237193-8887-1-git-send-email-mhagger@alum.mit.edu>
 <1358237193-8887-7-git-send-email-mhagger@alum.mit.edu>
 <20130115203204.GA12524@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 23:31:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvF2W-0000CH-QM
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 23:31:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758347Ab3AOWbF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 17:31:05 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37547 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757556Ab3AOWbC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 17:31:02 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BB526A187;
	Tue, 15 Jan 2013 17:31:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AkNjoWlI56GVIQOiu1rCCyccMsQ=; b=e91aRX
	WPudqCFui/B9y1sts3ChuK8w3Vh0MGiClRAGzad6PHJ0gSp753js7eOs3JiHO2mb
	PvP0sSoBgFH9hG7/D37jNcaYOzCAFwENLh1PCDmEQzn/QtKh0JG7dSjLQsIdXZCe
	6Zg6GLHp1OLtVBlZzBF5mufIdvXKakUTnmwAE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=S36RZ7bdJdpezjW5Lgn4FcZHFeo0J93s
	X4x/yeswENoVAvVWvyKWS0lc1KF8zL1VqmTiN6iS7yaC4svwArH5Q7eJ+nRiYPvS
	l6ws8AhlRxpT0K+xbfhPWZMDNqN6Co2b65GGenoYLc3g+gu4pVyq1GItrH2QGq/J
	/+mEwHg7xaY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B0671A185;
	Tue, 15 Jan 2013 17:31:01 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0632EA180; Tue, 15 Jan 2013
 17:31:00 -0500 (EST)
In-Reply-To: <20130115203204.GA12524@google.com> (Jonathan Nieder's message
 of "Tue, 15 Jan 2013 12:32:04 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3D5B4C42-5F63-11E2-BCE7-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213681>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Michael Haggerty wrote:
>
>> -			else if ((arg1 = next_arg(&cmd))) {
>> -				if (!strcmp("EXISTS", arg1))
>> -					ctx->gen.count = atoi(arg);
>> -				else if (!strcmp("RECENT", arg1))
>> -					ctx->gen.recent = atoi(arg);
>> +			} else if ((arg1 = next_arg(&cmd))) {
>> +				/* unused */
>
> The above is just the right thing to do to ensure no behavior change.
> Let's take a look at the resulting code, though:
>
> 			if (... various reasonable things ...) {
> 				...
> 			} else if ((arg1 = next_arg(&cmd))) {
> 				/* unused */
> 			} else {
> 				fprintf(stderr, "IMAP error: unable to parse untagged response\n");
> 				return RESP_BAD;
>
> Anyone forced by some bug to examine this "/* unused */" case is going
> to have no clue what's going on.  In that respect, the old code was
> much better, since it at least made it clear that one case where this
> code gets hit is handling "<num> EXISTS" and "<num> RECENT" untagged
> responses.
>
> I suspect that original code did not have an implicit and intended
> missing
>
> 				else
> 					; /* negligible response; ignore it */
>
> but the intent was rather 
>
> 				else {
> 					fprintf(stderr, "IMAP error: I can't parse this\n");
> 					return RESP_BAD;
> 				}
>
> Since actually fixing that is probably too aggressive for this patch,
> how about a FIXME comment like the following?
>
> 		/*
> 		 * Unhandled response-data with at least two words.
> 		 * Ignore it.
> 		 *
> 		 * NEEDSWORK: Previously this case handled '<num> EXISTS'
> 		 * and '<num> RECENT' but as a probably-unintended side
> 		 * effect it ignores other unrecognized two-word
> 		 * responses.  imap-send doesn't ever try to read
> 		 * messages or mailboxes these days, so consider
> 		 * eliminating this case.
> 		 */

Hmph; it seems that it is not worth rerolling the whole thing only
for this, so let me squash this in, replacing the /* unused */ with
the large comment, and then merge the result to 'next'.
