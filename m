From: Drew Northup <n1xim.email@gmail.com>
Subject: Re: [PATCH] TIG: Fix to reinstate proper operation with no arguments
Date: Thu, 18 Jul 2013 09:30:11 -0400
Message-ID: <51E7EDE3.4080205@gmail.com>
References: <1374123113-3889-1-git-send-email-n1xim.email@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jonas Fonseca <fonseca@diku.dk>
To: Drew Northup <n1xim.email@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 18 15:30:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzoHm-0004R8-KK
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jul 2013 15:30:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754189Ab3GRNaQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jul 2013 09:30:16 -0400
Received: from mail-ye0-f174.google.com ([209.85.213.174]:52309 "EHLO
	mail-ye0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753943Ab3GRNaP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jul 2013 09:30:15 -0400
Received: by mail-ye0-f174.google.com with SMTP id m9so928022yen.33
        for <git@vger.kernel.org>; Thu, 18 Jul 2013 06:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=JgVRXflMgXvl1FWMajby+r9U66o49l1d/2+e2eNxiuY=;
        b=f7HmS4DwV+ZonZfKfVaXsrmE0iOWpb9DggY52XtUnj/wLeWVYgBlzH93hjb+HombLr
         vyb+S4ZFGRWNo0ArO9GQ9v+S0X8sxhXwJ2Apup1FReArCfO5gSRJPMBOYBBpLvfRlnkN
         phWYT5zsl3u4ZI63zW5Jagp1HdJuTXLOnk7yuCy35XpSD9YPl4Ri2aPUn+WZJxyPGVfD
         SsnoztJFfXG/zXWUd8pybt8eYj3nE0k+I2mlEs+NWl/sxLX+VFHjW6lnlZxnVk2GrWRm
         wcpDmLEq+iUPP0uUspMQKLgA1i0i1SCHsRUGuV2ojhsmdNR3r4FpEXHthmunrdIIl/8y
         FV9g==
X-Received: by 10.236.70.9 with SMTP id o9mr5659648yhd.35.1374154213979;
        Thu, 18 Jul 2013 06:30:13 -0700 (PDT)
Received: from [192.168.0.37] (pool-70-16-105-6.port.east.myfairpoint.net. [70.16.105.6])
        by mx.google.com with ESMTPSA id s80sm14657136yhe.27.2013.07.18.06.30.12
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 18 Jul 2013 06:30:13 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.28) Gecko/20120314 Thunderbird/3.1.20
In-Reply-To: <1374123113-3889-1-git-send-email-n1xim.email@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230691>

Somehow this patch breaks the main view to not open the correct commit 
in diff view when <enter> is pressed. Back to the debugger...

On 07/18/2013 12:51 AM, Drew Northup wrote:
> Since c7d67ab running "tig" with no options has failed with the
> error "tig: No revisions match the given arguments." This was due
> to a change in how the arguments for the back-end git call was
> being constructed. This change caused the blank field left in
> place of "(encoding_arg)" when it is empty to not overwrite
> "buf" which then caused the value in "buf" to be copied into
> dst_argv twice. The resulting git command failed if there was no
> available revision named "log" as shown in the trace.
>
>  From the TIG_TRACE log:
> git log log --no-color --pretty=raw --parents --parents --
> fatal: bad revision 'log'
>
> This fix works by teaching tig that when it is supplied with a
> blank field in the source argument buffer that it should skip
> over that field and continue instead of copying the previous
> field value into the destination buffer a second time.
>
> github issue # 167
>
> Signed-off-by: Drew Northup<n1xim.email@gmail.com>
> ---
>
> This should apply cleanly to the tig public master whether the
> mkstemps() patch I wrote has been applied or not.
>
>   tig.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/tig.c b/tig.c
> index ba9ba98..1016cfe 100644
> --- a/tig.c
> +++ b/tig.c
> @@ -3105,10 +3105,11 @@ static bool
>   format_append_arg(struct format_context *format, const char ***dst_argv, const char *arg)
>   {
>   	format->bufpos = 0;
> +	int len = 0;
>
>   	while (arg) {
>   		char *next = strstr(arg, "%(");
> -		int len = next ? next - arg : strlen(arg);
> +		len = next ? next - arg : strlen(arg);
>
>   		if (len&&  !string_format_from(format->buf,&format->bufpos, "%.*s", len, arg))
>   			return FALSE;
> @@ -3119,7 +3120,11 @@ format_append_arg(struct format_context *format, const char ***dst_argv, const c
>   		arg = next ? strchr(next, ')') + 1 : NULL;
>   	}
>
> -	return argv_append(dst_argv, format->buf);
> +	if(len){
> +		return argv_append(dst_argv, format->buf);
> +	} else {
> +		return TRUE;
> +	}
>   }
>
>   static bool


-- 
--
-Drew Northup
--------------------------------------------------------------
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
