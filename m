From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Support for setitimer() on platforms lacking it
Date: Tue, 28 Aug 2012 13:15:33 -0700
Message-ID: <7vr4qqzsbe.fsf@alter.siamese.dyndns.org>
References: <003301cd81e4$cd68daa0$683a8fe0$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: "Joachim Schmitz" <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Tue Aug 28 22:16:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6SCw-0000Xu-FV
	for gcvg-git-2@plane.gmane.org; Tue, 28 Aug 2012 22:16:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753273Ab2H1UQL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Aug 2012 16:16:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40940 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753231Ab2H1UPh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Aug 2012 16:15:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 31D099D3B;
	Tue, 28 Aug 2012 16:15:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=v6Osy8IUpAZNCWg+2ig898Ygeus=; b=gOzqBW
	sx/lyhhWrT6O10+Op/T2YhzBMHPeTwUfzjzcsTBh8yfCcXmEyLFcT9nBdor5LmRh
	Hnp/9CBpoZ1DRij8s9ejqeqcgZp+1/JKj7OgvHV1x5RluOs5VOMvhReoHLwsK0WC
	z1VdU4MhcEtZeTesR/Dkq7AE+Q1HjI/L4J1Fo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RoI2bSYONcGPkvfmEiGPVcjxPrJWI/NT
	SUgvqFwAjcEsR8VJ7jpMNrGQ7Nj4wS7lOMXQ76aNs0nwA4rRMhruVka5x6gkDBrm
	5bXZ2FixOFJOb8JWpXF7Lh5GnoV08g5vzyHMATuGu/k5CQ1cENZk4O6PllbE3cCf
	u9a7y1cuIfc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E8D709D3A;
	Tue, 28 Aug 2012 16:15:35 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0C8C29D39; Tue, 28 Aug 2012
 16:15:34 -0400 (EDT)
In-Reply-To: <003301cd81e4$cd68daa0$683a8fe0$@schmitz-digital.de> (Joachim
 Schmitz's message of "Fri, 24 Aug 2012 12:39:54 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 201112CC-F14D-11E1-9706-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204450>

"Joachim Schmitz" <jojo@schmitz-digital.de> writes:

> Implementation includes getitimer(), but for now it is static.
> Supports ITIMER_REAL only.
>
> Signed-off-by: Joachim Schmitz <jojo@schmitz-digital.de>
> ---
> May need a header file for ITIMER_*, struct itimerval and the prototypes,
> But for now, and the HP NonStop platform this isn't needed, here
> <sys/time> has ITIMER_* and struct timeval, and the prototypes can 
> vo into git-compat-util.h for now (Patch 2/2) 
>
>  compat/itimer.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 compat/itimer.c
>
> diff --git a/compat/itimer.c b/compat/itimer.c
> new file mode 100644
> index 0000000..713f1ff
> --- /dev/null
> +++ b/compat/itimer.c
> @@ -0,0 +1,50 @@
> +#include "../git-compat-util.h"
> +
> +static int git_getitimer(int which, struct itimerval *value)
> +{
> +	int ret = 0;
> +
> +	switch (which) {
> +		case ITIMER_REAL:
> +			value->it_value.tv_usec = 0;
> +			value->it_value.tv_sec = alarm(0);
> +			ret = 0; /* if alarm() fails, we get a SIGLIMIT */
> +			break;
> +		case ITIMER_VIRTUAL: /* FALLTHRU */
> +		case ITIMER_PROF: errno = ENOTSUP; ret = -1; break;
> +		default: errno = EINVAL; ret = -1;
> +	}

Just a style thing, but we align case arms and switch statements,
like this:

	switch (which) {
        case ...:
        	stmt;
                break;
	default:
        	stmt;
                break;
	}
	
Because alarm() runs in integral seconds granularity, this could
return 0.0 sec (i.e. "do not re-trigger this alarm any more") in
ovalue after setting alarm(1) (via git_setitimer()) and calling this
function (via git_setitimer() again) before the timer expires, no?
Is it a desired behaviour?

What I am most worried about is that callers _might_ take this
emulation too seriously, grab the remainder from getitimer(), and
drives a future call to getitimer() with the returned value, and
accidentally cause the "recurring" nature of the request to be
disabled.

I see no existing code calls setitimer() with non-NULL ovalue, and I
do not think we would add a new caller that would do so in any time
soon, so it may not be a bad idea to drop support of returning the
remaining timer altogether from this emulation layer (just like
giving anything other than ITIMER_REAL gives us ENOTSUP).  That
would sidestep the whole "we cannot answer how many milliseconds are
still remaining on the timer when using emulation based on alarm()".

> +int git_setitimer(int which, const struct itimerval *value,
> +				struct itimerval *ovalue)
> +{
> +	int ret = 0;
> +
> +	if (!value
> +		|| value->it_value.tv_usec < 0
> +		|| value->it_value.tv_usec > 1000000
> +		|| value->it_value.tv_sec < 0) {
> +		errno = EINVAL;
> +		return -1;
> +	}
> +
> +	else if (ovalue)
> +		if (!git_getitimer(which, ovalue))
> +			return -1; /* errno set in git_getitimer() */
> +
> +	else
> +	switch (which) {
> +		case ITIMER_REAL:
> +			alarm(value->it_value.tv_sec +
> +				(value->it_value.tv_usec > 0) ? 1 : 0);

Why is this capped to 1 second?  Is this because no existing code
uses the timer for anything other than 1 second or shorter?  If that
is the case, that needs at least some documenting (or a possibly
support for longer expiration, if it is not too cumbersome to add).

> +			ret = 0; /* if alarm() fails, we get a SIGLIMIT */
> +			break;
> +		case ITIMER_VIRTUAL: /* FALLTHRU */
> +		case ITIMER_PROF: errno = ENOTSUP; ret = -1; break;

Please don't add a misleading "fallthru" label here.  We do not say
"fallthru" when "two case arms do _exactly_ the same thing".  Only
when the one arm does some pre-action before the common action, i.e.

	switch (which) {
        case one:
        	do some thing specific to one;
                /* fallthru */
	case two:
		do some thing common between one and two;
		break;
	}                
        
we label it "fallthru" to make it clear to the readers that it is
not "missing a break" but is deliberate.

> +		default: errno = EINVAL; ret = -1;
> +	}
> +
> +	return ret;
> +}

Thanks.
