From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RLIMIT_NOFILE fallback
Date: Wed, 18 Dec 2013 12:18:21 -0800
Message-ID: <xmqqlhzhhq0i.fsf@gitster.dls.corp.google.com>
References: <20131218171446.GA19657@kitenet.net>
	<xmqqy53ihwe4.fsf@gitster.dls.corp.google.com>
	<20131218191702.GA9083@sigill.intra.peff.net>
	<xmqq61qmhrb3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joey Hess <joey@kitenet.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 18 21:18:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtNZl-0002Pk-4V
	for gcvg-git-2@plane.gmane.org; Wed, 18 Dec 2013 21:18:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751463Ab3LRUSd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Dec 2013 15:18:33 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62847 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751223Ab3LRUSc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Dec 2013 15:18:32 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E79E55AB65;
	Wed, 18 Dec 2013 15:18:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cBBsneDEbN8GEjRH3lAewcSgJWo=; b=mwGB78
	c2N51ZIw9+xqHHBWspCWb5rsMTYCx10D9NcCjUaLMR6mu8xPRT4aOlcHAbv1ERHU
	rYBKUB+zG41m5HYAzg0qThyevjMKPQ0lIdKOOu3E0fzAV+aGmXD0eTIqgwbWfe/r
	OLFI26gdniB8VI8Dzl1xXXtsJpqbsCbyhoBdo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uy+G5lWKexa5uq2Ik2L5ASmq7PdG1vod
	EVSjyGY/HWIEAF2lfKgvF90RxmLw4jcWZNN9ntutGrnN+pHth5Pm6+xupuypKPaj
	HV6Sfx40kGwkpSkTvU0PaPX1nuca0Dduh0HNa/+epffwAurjTKeE8GPHYBySk31F
	wqJ/DMO3XEQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B452B5AB64;
	Wed, 18 Dec 2013 15:18:31 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 810215AB61;
	Wed, 18 Dec 2013 15:18:30 -0500 (EST)
In-Reply-To: <xmqq61qmhrb3.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 18 Dec 2013 11:50:24 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8FB3B818-6821-11E3-BDC6-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239481>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> That is, does sysconf actually work on such a system (or does it need a
>> similar run-time fallback)? And either way, we should try falling back
>> to OPEN_MAX rather than 1 if we have it.
>
> Interesting.
>
>> As far as the warning, I am not sure I see a point. The user does not
>> have any useful recourse, and git should continue to operate as normal.
>> Having every single git invocation print "by the way, RLIMIT_NOFILE does
>> not work on your system" seems like it would get annoying.
>
> Very true.  That makes the resulting function look like this:
>
>
> -------------------------------- 8< ------------------------------
>
> static unsigned int get_max_fd_limit(void)
> {
> #ifdef RLIMIT_NOFILE
> 	struct rlimit lim;
>
> 	if (!getrlimit(RLIMIT_NOFILE, &lim))
> 		return lim.rlim_cur;
> #endif
>
> #if defined(_SC_OPEN_MAX)
> 	{
> 		long sc_open_max = sysconf(_SC_OPEN_MAX);
> 		if (0 < sc_open_max)
> 			return sc_open_max;
> 	}

err, here we need

#endif /* defined(_SC_OPEN_MAX) */

to truly implement the structure "try all the available functions,
and then fall back to OPEN_MAX".



>
> #if defined(OPEN_MAX)
> 	return OPEN_MAX;
> #else
> 	return 1; /* see the caller ;-) */
> #endif
> }
>
> -------------------------------- >8 ------------------------------
>
>
> But the sysconf part makes me wonder; here is what we see in
> http://pubs.opengroup.org/onlinepubs/9699919799/functions/sysconf.html
>
>     If name is an invalid value, sysconf() shall return -1 and set errno
>     to indicate the error. If the variable corresponding to name is
>     described in <limits.h> as a maximum or minimum value and the
>     variable has no limit, sysconf() shall return -1 without changing
>     the value of errno. Note that indefinite limits do not imply
>     infinite limits; see <limits.h>.
>
> For a broken system (like RLIMIT_NOFILE defined for the compiler,
> but the actual call returns a bogus error), the compiler may see the
> _SC_OPEN_MAX defined, while sysconf() may say "I've never heard of
> such a name" and return -1, or the system, whether broken or not,
> may want to say "Unlimited" and return -1.  The caller takes
> anything unreasonable as a positive value capped to 25 or something,
> so there isn't a real harm if we returned a bogus value from here,
> but I am not sure what the safe default behaviour of this function
> should be to help such a broken system while not harming systems
> that are functioning correctly.
