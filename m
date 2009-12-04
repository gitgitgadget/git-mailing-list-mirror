From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Wrong damage counting in diffcore_count_changes?
Date: Fri, 04 Dec 2009 12:47:16 -0800
Message-ID: <7vljhio4a3.fsf@alter.siamese.dyndns.org>
References: <alpine.LFD.2.00.0912041200120.24579@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Dec 04 21:47:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGf3s-0007CK-Sl
	for gcvg-git-2@lo.gmane.org; Fri, 04 Dec 2009 21:47:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757245AbZLDUrV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2009 15:47:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757228AbZLDUrU
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Dec 2009 15:47:20 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49148 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757170AbZLDUrU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2009 15:47:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8388E85FF6;
	Fri,  4 Dec 2009 15:47:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=x91MFGBKSd3dZjM0Huap1NGWGA4=; b=jzUkaX
	7oqmRubjA4fUBtBAaicrcDQbHaVdOSYv2IQGOEJfXTbxn83F65UL7SWmxhibsr7K
	hPXeKZqmVu2ebEdLXAG42uVidinUz5sENt2AEJBklq3g8lWBg3RK4s/mjKfH3rXb
	R13Oy3TB6J8m0hlvI5ev4JwN4uTdCfpRd8VLc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uzbl0MIEBjqYCLMruO6fFefoV+uR1k2+
	p7OqPfoD5pe6Sav1B61RGLeq/jscFCLRmJcEZdAz0/RqdZxeh9Um/llKUkXf/fHC
	12gjNZQwpBYiPMxsWPMoRCOQzbLj7mlUGrpG0PgkH+9rOaYQuM3dSPHeTuSp5ppJ
	dU7uZC9rn58=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 60B7585FF5;
	Fri,  4 Dec 2009 15:47:22 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 316F285FF4; Fri,  4 Dec
 2009 15:47:18 -0500 (EST)
In-Reply-To: <alpine.LFD.2.00.0912041200120.24579@localhost.localdomain>
 (Linus Torvalds's message of "Fri\, 4 Dec 2009 12\:07\:47 -0800 \(PST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 38A5D40C-E116-11DE-907D-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134573>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> This changes it so that
>
>  - whenever it bypasses a destination hash (because it doesn't match a 
>    source), it counts the bytes associated with that as "literal added"
>
>  - at the end (once we have used up all the source hashes), we do the same 
>    thing with the remaining destination hashes.
>
>  - when hashes do match, and we use the difference in counts as a value, 
>    we also use up that destination hash entry (the 'd++'
>
> This _seems_ to make --dirstat output more sensible, and I'd hope that 
> that in turn should mean that file rename detection should also be more 
> sensible. But I haven't actually verified it in any way. Maybe I just 
> screwed up file rename detection entirely.
>
> Did I miss something?

Well, the current loop structure largely comes from your eb4d0e3 (optimize
diffcore-delta by sorting hash entries., 2007-10-02) so you would be the
best judge of the change ;-), even though it seems that the current code
inherited the "skipping of dst when src does not exist" bug from c06c796
(diffcore-rename: somewhat optimized., 2006-03-12).

Earlier code, e.g. as of ba23bbc (diffcore-delta: make change counter to
byte oriented again., 2006-03-04), used to be very simple minded and
inefficient and iterated over src_count[] and dst_count[] arrays for the
entire hash value namespace and there was no such "missing, skipped,
happened to have the next value" issue.

I think you understand the original intention of the function correctly
and from a cursory look of the patch I think it fixes the bug in the
current code, and any changes to renames/breaks should be improvements.

But my lunchbreak is over, and my evening is booked, so I unfortunately
cannot spend more time thinking about any possible fallouts from this
change until tomorrow.

Sorry, and thanks.

> 		Linus
> ---
>  diffcore-delta.c |   11 ++++++++++-
>  1 files changed, 10 insertions(+), 1 deletions(-)
>
> diff --git a/diffcore-delta.c b/diffcore-delta.c
> index e670f85..7cf431d 100644
> --- a/diffcore-delta.c
> +++ b/diffcore-delta.c
> @@ -201,10 +201,15 @@ int diffcore_count_changes(struct diff_filespec *src,
>  		while (d->cnt) {
>  			if (d->hashval >= s->hashval)
>  				break;
> +			la += d->cnt;
>  			d++;
>  		}
>  		src_cnt = s->cnt;
> -		dst_cnt = d->hashval == s->hashval ? d->cnt : 0;
> +		dst_cnt = 0;
> +		if (d->cnt && d->hashval == s->hashval) {
> +			dst_cnt = d->cnt;
> +			d++;
> +		}
>  		if (src_cnt < dst_cnt) {
>  			la += dst_cnt - src_cnt;
>  			sc += src_cnt;
> @@ -213,6 +218,10 @@ int diffcore_count_changes(struct diff_filespec *src,
>  			sc += dst_cnt;
>  		s++;
>  	}
> +	while (d->cnt) {
> +		la += d->cnt;
> +		d++;
> +	}
>  
>  	if (!src_count_p)
>  		free(src_count);
