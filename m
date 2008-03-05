From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Add compat/vsnprintf.c for systems that returns -1 on
 maxsize reached
Date: Wed, 05 Mar 2008 15:28:48 +0100
Message-ID: <47CEAE20.1030707@viscovery.net>
References: <200803041459.29000.michal.rokos@nextsoft.cz> <200803050937.40345.michal.rokos@nextsoft.cz> <47CE6552.60308@viscovery.net> <200803051455.57148.michal.rokos@nextsoft.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: GIT <git@vger.kernel.org>
To: Michal Rokos <michal.rokos@nextsoft.cz>
X-From: git-owner@vger.kernel.org Wed Mar 05 15:29:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWuce-0005EX-QA
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 15:29:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752498AbYCEO2y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 09:28:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752377AbYCEO2x
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 09:28:53 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:2867 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752138AbYCEO2w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 09:28:52 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JWubK-0007FQ-4z; Wed, 05 Mar 2008 15:28:10 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 161F66EF; Wed,  5 Mar 2008 15:28:49 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <200803051455.57148.michal.rokos@nextsoft.cz>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76220>

Michal Rokos schrieb:
> On Wednesday 05 March 2008 10:18:10 Johannes Sixt wrote:
>> It's not the same on Windows, which returns:
>> case1: -1
>> case2: 5
>> case3: 5
>> case4: 5
>>
>> BTW, this is not only an issue of vsnprintf, but also of snprintf!
> 
> Hmm, HPUX has the same issue for snprint() as is for vsnprintf().
> 
> Do you think that following patch suffices your needs. Please note that it 
> actually copies data to str.

... in the case where the buffer is too small? This won't be a problem for
our users.

> +# Define SNPRINTF_RETURNS_BOGUS if your are on a system which snprintf()
> +# returns -1 instead of number of characters which would have been written
> +# to the final string if enough space had been available.
> +#
> +# Define VSNPRINTF_RETURNS_BOGUS if your are on a system which vsnprintf()
> +# returns -1 instead of number of characters which would have been written
> +# to the final string if enough space had been available.

We don't need two configuration variables. I think we can assume that if
vsnprintf is broken, then snprintf will be broken, too:

# Define SNPRINTF_RETURNS_BOGUS if your are on a system which snprintf()
# and vsnprintf() return -1 instead of number of characters that would
# have been written to the final string if enough space had been
# available.

> +AC_CACHE_CHECK([whether snprintf() returns bogus],
> + [ac_cv_snprintf_returns_bogus],
> +[
> +AC_RUN_IFELSE(
> +	[AC_LANG_PROGRAM([AC_INCLUDES_DEFAULT],
> +		[[char buf[1];
> +		  if (snprintf(bug, 1, "%s", "12345") != 5) return 1]])],
                               ^^^
buf?

Are you trying to test for the second bogus behavior on Windows? Don't do
it! I've thought about it for 5 minutes, but I can't come up with a simple
test that would detect its odd behavior.

> diff --git a/dev/null b/compat/snprintf.c
> new file mode 100644
> index 0000000..bc0d37c
> --- /dev/null
> +++ b/compat/snprintf.c
> @@ -0,0 +1,37 @@
> +#include "../git-compat-util.h"
> +
> +#undef vsnprintf
> +int git_vsnprintf(char *str, size_t maxsize, const char *format, va_list ap)
> +{
> +   char *s;
> +   int size;
> +
> +   int ret = vsnprintf(str, maxsize, format, ap);
> +   if (ret != -1 ) return ret;

'return' goes on its own line. Indentation is one tabstop, not two spaces.
Thank you.

> +
> +   s = NULL;

You could reuse str here.

> +   size = maxsize;

We are trying to find a suitably long buffer in a loop. We should spend as
few cycles as possible. Therefore, my implementation used a minimum of
250*4 for the first try just in case the caller had a long string to
construct. (And it protects against maxsize == 0.)

> +   while ( ret == -1 )
> +   {
> +      size *= 4;
> +      s = realloc(s, size);
> +      if (! s) return -1;

Could you avoid the memory leak on this error path?

> +      ret = vsnprintf(s, size, format, ap);
> +   }
> +   if (str && maxsize > 0) memcpy(str, s, maxsize);

Why this?

> +   free(s);
> +   return ret;
> +}

-- Hannes

