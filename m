From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] Support for setitimer() on platforms lacking it
Date: Fri, 07 Sep 2012 09:40:32 -0700
Message-ID: <7va9x1zszj.fsf@alter.siamese.dyndns.org>
References: <002201cd8cde$ea7cacc0$bf760640$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: "Joachim Schmitz" <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Fri Sep 07 18:40:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TA1bo-0007hQ-GO
	for gcvg-git-2@plane.gmane.org; Fri, 07 Sep 2012 18:40:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751607Ab2IGQkh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Sep 2012 12:40:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52309 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751155Ab2IGQkf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2012 12:40:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BA23770EB;
	Fri,  7 Sep 2012 12:40:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9kSt5pvipIO/PxPHbQxAzLZcuX0=; b=f/xdtO
	WWor8uvqNeNwS2NcnbtNbhOTHy8oNExjRFcYi5dIatzST6KrjZCjhLf2irEu5m0t
	0RT1xrlrAxvZ7JIq/iFrSChDaUh3/zMFe54cgpTK0GouKYXeu33j2HQuBQbTqpb7
	vJkaGZ7x59n1ImTrPFTjc0ks3UvITH2EK5JrI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HNXK4OlgG1LNlP+mjFlJIgC8RIz3zDYc
	LIRVy6Y7qMLg0WiviLytXXt8Lv0AqmG1Et9Otl0E4+Zhyhz/TE7nDNvJoNfk+sTD
	N8s9x9TZM0IO8ut8SM1yi+n6pwrLO6k7wle6koVczIxDNKFcaIy2XsjBZtA4oI5r
	jxmM4z26AeM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A718B70EA;
	Fri,  7 Sep 2012 12:40:34 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BE4A870E8; Fri,  7 Sep 2012
 12:40:33 -0400 (EDT)
In-Reply-To: <002201cd8cde$ea7cacc0$bf760640$@schmitz-digital.de> (Joachim
 Schmitz's message of "Fri, 7 Sep 2012 11:55:29 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BE70E23E-F90A-11E1-9095-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204974>

"Joachim Schmitz" <jojo@schmitz-digital.de> writes:

> HP NonStop (currently) doesn't have setitimer(). The previous attempt of an
> emulation (reverted by this commit) was not a real substitute for a recurring
> itimer (as here we also don't have SA_RESTART, so can't re-arm the timer).
> As setitimer() is only used in cases of perceived latency and it doesn't affect
> correctness, it now gets disabled entirely, if NO_SETITIMER is set.
> HP NonStop does provide struct itimerval, but other platforms may not, so this
> is taken care of in this commit too, by setting NO_STRUCT_ITIMERVAL.
>
> Signed-off-by: Joachim Schmitz <jojo@schmitz-digital.de>

The end-result looks simple and nice (thanks for NO_STRUCT_ITIMERVAL).

As we are not going to include the earlier failed attempt in our
longer-term history (i.e. 'master', that never rewinds), however,
I would prefer to see a replacement patch (as opposed to this one
that incrementally updates the previous failed attempt).  I could
squash this into the previous one myself though ;-)

Thanks.

> ---
>  Makefile          |  5 +++++
>  compat/itimer.c   | 50 --------------------------------------------------
>  git-compat-util.h | 11 +++++++++--
>  3 files changed, 14 insertions(+), 52 deletions(-)
>  delete mode 100644 compat/itimer.c
>
> diff --git a/Makefile b/Makefile
> index ac49320..7be555b 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -157,6 +157,11 @@ all::
>  # Define NO_PREAD if you have a problem with pread() system call (e.g.
>  # cygwin1.dll before v1.5.22).
>  #
> +# Define NO_SETITIMER if you don't have setitimer()
> +#
> +# Define NO_STRUCT_ITIMERVAL if you don't have struct itimerval
> +# This also implies NO_SETITIMER
> +#
>  # Define NO_THREAD_SAFE_PREAD if your pread() implementation is not
>  # thread-safe. (e.g. compat/pread.c or cygwin)
>  #
> diff --git a/compat/itimer.c b/compat/itimer.c
> deleted file mode 100644
> index 713f1ff..0000000
> --- a/compat/itimer.c
> +++ /dev/null
> @@ -1,50 +0,0 @@
> -#include "../git-compat-util.h"
> -
> -static int git_getitimer(int which, struct itimerval *value)
> -{
> -	int ret = 0;
> -
> -	switch (which) {
> -		case ITIMER_REAL:
> -			value->it_value.tv_usec = 0;
> -			value->it_value.tv_sec = alarm(0);
> -			ret = 0; /* if alarm() fails, we get a SIGLIMIT */
> -			break;
> -		case ITIMER_VIRTUAL: /* FALLTHRU */
> -		case ITIMER_PROF: errno = ENOTSUP; ret = -1; break;
> -		default: errno = EINVAL; ret = -1;
> -	}
> -	return ret;
> -}
> -
> -int git_setitimer(int which, const struct itimerval *value,
> -				struct itimerval *ovalue)
> -{
> -	int ret = 0;
> -
> -	if (!value
> -		|| value->it_value.tv_usec < 0
> -		|| value->it_value.tv_usec > 1000000
> -		|| value->it_value.tv_sec < 0) {
> -		errno = EINVAL;
> -		return -1;
> -	}
> -
> -	else if (ovalue)
> -		if (!git_getitimer(which, ovalue))
> -			return -1; /* errno set in git_getitimer() */
> -
> -	else
> -	switch (which) {
> -		case ITIMER_REAL:
> -			alarm(value->it_value.tv_sec +
> -				(value->it_value.tv_usec > 0) ? 1 : 0);
> -			ret = 0; /* if alarm() fails, we get a SIGLIMIT */
> -			break;
> -		case ITIMER_VIRTUAL: /* FALLTHRU */
> -		case ITIMER_PROF: errno = ENOTSUP; ret = -1; break;
> -		default: errno = EINVAL; ret = -1;
> -	}
> -
> -	return ret;
> -}
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 18089f0..4628d7a 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -162,9 +162,16 @@
>  #define probe_utf8_pathname_composition(a,b)
>  #endif
>  
> +#ifdef NO_STRUCT_ITIMERVAL
> +struct itimerval {
> +	struct timeval it_interval;
> +	struct timeval it_value;
> +}
> +#define NO_SETITIMER
> +#endif
> +
>  #ifdef NO_SETITIMER
> -#define setitimer(a,b,c) git_setitimer((a),(b),(c))
> -extern int git_setitimer(int, const struct itimerval *, struct itimerval *);
> +#define setitimer(which,value,ovalue)
>  #endif
>  
>  #ifdef MKDIR_WO_TRAILING_SLASH
