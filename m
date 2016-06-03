From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH 01/10] builtin/commit.c: convert trivial snprintf calls to
 xsnprintf
Date: Fri, 3 Jun 2016 16:25:28 +0100
Message-ID: <5751A168.7020408@ramsayjones.plus.com>
References: <20160603074724.12173-1-gitter.spiros@gmail.com>
 <20160603084917.GA28401@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>, Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 17:25:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8qyg-0001Tn-3O
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 17:25:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753028AbcFCPZe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 11:25:34 -0400
Received: from avasout01.plus.net ([84.93.230.227]:49367 "EHLO
	avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751147AbcFCPZd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2016 11:25:33 -0400
Received: from [10.0.2.15] ([84.92.139.254])
	by avasout01 with smtp
	id 2FRV1t0025VX2mk01FRWZg; Fri, 03 Jun 2016 16:25:30 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=bsGxfxui c=1 sm=1 tr=0
 a=RCQFcU9wfaUQolwYLdiqXg==:117 a=RCQFcU9wfaUQolwYLdiqXg==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10
 a=gl6NWmOIULTmcyt9l8kA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
In-Reply-To: <20160603084917.GA28401@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296335>



On 03/06/16 09:49, Jeff King wrote:
> On Fri, Jun 03, 2016 at 07:47:15AM +0000, Elia Pinto wrote:
> 
[snip]

> For this particular change:
> 
>> diff --git a/builtin/commit.c b/builtin/commit.c
>> index 443ff91..c65abaa 100644
>> --- a/builtin/commit.c
>> +++ b/builtin/commit.c
>> @@ -1552,7 +1552,7 @@ static int run_rewrite_hook(const unsigned char *oldsha1,
>>  	code = start_command(&proc);
>>  	if (code)
>>  		return code;
>> -	n = snprintf(buf, sizeof(buf), "%s %s\n",
>> +	n = xsnprintf(buf, sizeof(buf), "%s %s\n",
>>  		     sha1_to_hex(oldsha1), sha1_to_hex(newsha1));
> 
> I think it's the first type, as earlier we have:
> 
> 	/* oldsha1 SP newsha1 LF NUL */
> 	static char buf[2*40 + 3];
> 
> So unless that calculation is wrong, this would never truncate. The move
> to xsnprintf is an improvement, 

I was going to suggest, if we stay with the static buffer, that the size
expression be changed to '2 * GIT_SHA1_HEXSZ + 3'. However, ...

>                                  but I wonder if we would be happier
> still with:
> 
>   buf = xstrfmt("%s %s\n", sha1_to_hex(oldsha1), sha1_to_hex(newsha1));
> 
> Then we do not even have to wonder about the size computation. True, it
> uses a heap buffer when we do not need to, but I find it hard to care
> about grabbing 80 bytes of heap when we are in the midst of exec-ing an
> entirely new process.

... I agree with this also.

> 
> By the way, there are some other uses of snprintf in the same file, that
> I think would fall into the type 2 I mentioned above (they use PATH_MAX,
> which I think is shorter than necessary on some systems).
> 
> Those ones would also benefit from using higher-level constructs. Like:
> 
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 443ff91..9336724 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1563,24 +1563,23 @@ static int run_rewrite_hook(const unsigned char *oldsha1,
>  
>  int run_commit_hook(int editor_is_used, const char *index_file, const char *name, ...)
>  {
> -	const char *hook_env[3] =  { NULL };
> -	char index[PATH_MAX];
> +	struct argv_array hook_env = ARGV_ARRAY_INIT;
>  	va_list args;
>  	int ret;
>  
> -	snprintf(index, sizeof(index), "GIT_INDEX_FILE=%s", index_file);
> -	hook_env[0] = index;
> +	argv_array_pushf(&hook_env, "GIT_INDEX_FILE=%s", index_file);
>  
>  	/*
>  	 * Let the hook know that no editor will be launched.
>  	 */
>  	if (!editor_is_used)
> -		hook_env[1] = "GIT_EDITOR=:";
> +		argv_array_push(&hook_env, "GIT_EDITOR=:");
>  
>  	va_start(args, name);
>  	ret = run_hook_ve(hook_env, name, args);
>  	va_end(args);
>  
> +	argv_array_clear(&hook_env);
>  	return ret;
>  }

Indeed.

ATB,
Ramsay Jones
