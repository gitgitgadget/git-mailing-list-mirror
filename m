From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: Breakage (?) in configure and git_vsnprintf()
Date: Mon, 12 Dec 2011 17:25:11 -0600
Message-ID: <KDO2EaM6TnHQ6KGYqmkErS6Nq_qZc7b4J1aClSFkQwb60rk3bMZqU3iiY0O2LRaJukqzzBU6djUrNHGC505_oYXFc1BUezUo8EtdKcjEOSE@cipher.nrlssc.navy.mil>
References: <4EE4F97B.9000202@alum.mit.edu> <20111212064305.GA16511@sigill.intra.peff.net> <m262hmgmrw.fsf@igel.home> <20111212142550.GA23875@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	git discussion list <git@vger.kernel.org>,
	Michal Rokos <michal.rokos@nextsoft.cz>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 13 00:33:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaFNN-0000RV-GQ
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 00:33:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753391Ab1LLXdh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 18:33:37 -0500
Received: from mail3.nrlssc.navy.mil ([128.160.11.249]:40357 "EHLO
	mail3.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752300Ab1LLXdg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 18:33:36 -0500
X-Greylist: delayed 480 seconds by postgrey-1.27 at vger.kernel.org; Mon, 12 Dec 2011 18:33:36 EST
Received: by mail3.nrlssc.navy.mil id pBCNPCxr028464; Mon, 12 Dec 2011 17:25:12 -0600
In-Reply-To: <20111212142550.GA23875@sigill.intra.peff.net>
X-OriginalArrivalTime: 12 Dec 2011 23:25:11.0139 (UTC) FILETIME=[4B135B30:01CCB925]
X-Virus-Scanned: clamav-milter 0.97.2 at mail3
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186973>


FYI: all tests passed on IRIX (not that I suspected otherwise).

-Brandon

On 12/12/2011 08:25 AM, Jeff King wrote:
> On Mon, Dec 12, 2011 at 10:30:27AM +0100, Andreas Schwab wrote:
> 
>> Jeff King <peff@peff.net> writes:
>>
>>>  	if (maxsize > 0) {
>>> -		ret = vsnprintf(str, maxsize-SNPRINTF_SIZE_CORR, format, ap);
>>> +		va_copy(cp, ap);
>>> +		ret = vsnprintf(str, maxsize-SNPRINTF_SIZE_CORR, format, cp);
>>
>> You also need to call va_end on the copy.
> 
> Silly me. Thanks for catching.
> 
> Junio, here's a corrected version.
> 
> -- >8 --
> Subject: [PATCH] compat/snprintf: don't look at va_list twice
> 
> If you define SNPRINTF_RETURNS_BOGUS, we use a special
> git_vsnprintf wrapper assumes that vsnprintf returns "-1"
> instead of the number of characters that you would need to
> store the result.
> 
> To do this, it invokes vsnprintf multiple times, growing a
> heap buffer until we have enough space to hold the result.
> However, this means we evaluate the va_list parameter
> multiple times, which is generally a bad thing (it may be
> modified by calls to vsnprintf, yielding undefined
> behavior).
> 
> Instead, we must va_copy it and hand the copy to vsnprintf,
> so we always have a pristine va_list.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  compat/snprintf.c |    9 +++++++--
>  1 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/compat/snprintf.c b/compat/snprintf.c
> index e1e0e75..42ea1ac 100644
> --- a/compat/snprintf.c
> +++ b/compat/snprintf.c
> @@ -19,11 +19,14 @@
>  #undef vsnprintf
>  int git_vsnprintf(char *str, size_t maxsize, const char *format, va_list ap)
>  {
> +	va_list cp;
>  	char *s;
>  	int ret = -1;
>  
>  	if (maxsize > 0) {
> -		ret = vsnprintf(str, maxsize-SNPRINTF_SIZE_CORR, format, ap);
> +		va_copy(cp, ap);
> +		ret = vsnprintf(str, maxsize-SNPRINTF_SIZE_CORR, format, cp);
> +		va_end(cp);
>  		if (ret == maxsize-1)
>  			ret = -1;
>  		/* Windows does not NUL-terminate if result fills buffer */
> @@ -42,7 +45,9 @@ int git_vsnprintf(char *str, size_t maxsize, const char *format, va_list ap)
>  		if (! str)
>  			break;
>  		s = str;
> -		ret = vsnprintf(str, maxsize-SNPRINTF_SIZE_CORR, format, ap);
> +		va_copy(cp, ap);
> +		ret = vsnprintf(str, maxsize-SNPRINTF_SIZE_CORR, format, cp);
> +		va_end(cp);
>  		if (ret == maxsize-1)
>  			ret = -1;
>  	}
