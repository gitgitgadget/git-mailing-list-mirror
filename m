From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [RFD PATCH] git-fetch--tool and "insanely" long actions
Date: Thu, 19 Apr 2007 21:53:15 -0400
Message-ID: <46281D0B.7080802@gmail.com>
References: <462811F6.9060503@gmail.com> <20070420013411.26401.77137.julian@quantumfyre.co.uk>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Fri Apr 20 03:53:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeiJd-0000YT-2q
	for gcvg-git@gmane.org; Fri, 20 Apr 2007 03:53:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751693AbXDTBxS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Apr 2007 21:53:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753012AbXDTBxS
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Apr 2007 21:53:18 -0400
Received: from wx-out-0506.google.com ([66.249.82.224]:21541 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751693AbXDTBxR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2007 21:53:17 -0400
Received: by wx-out-0506.google.com with SMTP id h31so819507wxd
        for <git@vger.kernel.org>; Thu, 19 Apr 2007 18:53:17 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=BVIIcW3EoPw3cxtH6xyXu45/Z15tRPku+7J8VbpJRCLOnkpDMdg3aYvdxqyqUoK28ZZ8i5iWUtQh7A3S9bsZ5W099rdVMZEYdF4wytvyvULT1o8900/Gl9JJ8lHwBXGYtlN6KR0UvdelqbmCcYEUgI1o1eZptxOYqe2ZQvNBy0U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=jqeVCbWcxYP01tQf7gmOPZj6WmGyV2+g+eOwU0rvhOsyHaNP7zwFLLAADnbyVGuw1mptZrXcJJbGRgtQ60u4EvlqUEZdoQH8SbRFSSAwnJIS8ia1M2kpmlVCSErSRlZtppNjLkGWQjkzFhCrd6fk6+0PViGK2Kx6/NIxJWcb+/Y=
Received: by 10.70.75.14 with SMTP id x14mr2505193wxa.1177033997011;
        Thu, 19 Apr 2007 18:53:17 -0700 (PDT)
Received: from ?10.0.0.6? ( [66.177.19.99])
        by mx.google.com with ESMTP id i6sm4673319wxd.2007.04.19.18.53.16;
        Thu, 19 Apr 2007 18:53:16 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <20070420013411.26401.77137.julian@quantumfyre.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45055>

Julian Phillips wrote:
> On Thu, 19 Apr 2007, A Large Angry SCM wrote:
> 
>> This fixes a problem my repository mirroring script has been having since
>> the git-fetch--tool was added to master in the middle of March. However,
>> it is not a proper fix since it causes actual errors from snprintf() to be
>> ignored. A proper fix is complicated by the lack of a consistent indicator
>> that the buffer is too small across snprintf() implementations.
> .
> .
> .
>>       if (sizeof(msg) <= len)
>> -             die("insanely long action");
>> +             msg[sizeof(msg)-1] = '\0';
> 
> Or you could just let the whole thing through?
> 
> diff --git a/builtin-fetch--tool.c b/builtin-fetch--tool.c
> index e9d6764..9b5ae9f 100644
> --- a/builtin-fetch--tool.c
> +++ b/builtin-fetch--tool.c
> @@ -36,21 +36,26 @@ static int update_ref(const char *action,
>  		      unsigned char *oldval)
>  {
>  	int len;
> -	char msg[1024];
> +	char buffer[1024];
> +	int ret = 0;
> +	char *msg = buffer;
>  	char *rla = getenv("GIT_REFLOG_ACTION");
>  	static struct ref_lock *lock;
>  
>  	if (!rla)
>  		rla = "(reflog update)";
> -	len = snprintf(msg, sizeof(msg), "%s: %s", rla, action);
> -	if (sizeof(msg) <= len)
> -		die("insanely long action");
> +	len = strlen(rla) + strlen(action) + 3;
> +	if (len > sizeof(buffer))
> +		msg = xmalloc(len);
> +	snprintf(msg, len, "%s: %s", rla, action);
>  	lock = lock_any_ref_for_update(refname, oldval);
>  	if (!lock)
> -		return 1;
> +		ret = 1;
>  	if (write_ref_sha1(lock, sha1, msg) < 0)
> -		return 1;
> -	return 0;
> +		ret = 1;
> +	if (msg != buffer)
> +		free(msg);
> +	return ret;
>  }
>  
>  static int update_local_ref(const char *name,


See the last sentence in my original message. Yours also ignores errors 
from snprintf().
