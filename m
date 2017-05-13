Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E29DC20188
	for <e@80x24.org>; Sat, 13 May 2017 13:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752943AbdEMNcq (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 09:32:46 -0400
Received: from avasout08.plus.net ([212.159.14.20]:37366 "EHLO
        avasout08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750935AbdEMNcp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 09:32:45 -0400
Received: from [10.0.2.15] ([143.159.212.80])
        by avasout08 with smtp
        id KpYi1v0031keHif01pYjlq; Sat, 13 May 2017 14:32:44 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=JPdLi4Cb c=1 sm=1 tr=0
 a=n+zECcf3rkBNBoU0FNF4VQ==:117 a=n+zECcf3rkBNBoU0FNF4VQ==:17
 a=IkcTkHD0fZMA:10 a=PKzvZo6CAAAA:8 a=RqK9Ag7hJBwwZxdiC9oA:9 a=QEXdDO2ut3YA:10
 a=q92HNjYiIAC_jH7JDaYf:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH] usage.c: drop set_error_handle()
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
References: <20170513034818.h3aaihqmf4q43vef@sigill.intra.peff.net>
Cc:     Brandon Williams <bmwill@google.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <ca13408b-0aaf-f330-5a6b-12aa8ff8e313@ramsayjones.plus.com>
Date:   Sat, 13 May 2017 14:32:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170513034818.h3aaihqmf4q43vef@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 13/05/17 04:48, Jeff King wrote:
> The set_error_handle() function was introduced by 3b331e926
> (vreportf: report to arbitrary filehandles, 2015-08-11) so
> that run-command could send post-fork, pre-exec errors to
> the parent's original stderr.
> 
> That use went away in 79319b194 (run-command: eliminate
> calls to error handling functions in child, 2017-04-19),
> which pushes all of the error reporting to the parent.
> This leaves no callers of set_error_handle(). As we're not
> likely to add any new ones, let's drop it.
> 
> Signed-off-by: Jeff King <peff@peff.net>

I have an identical patch, which I had intended to send at
the 'start of the next cycle'. :D (Well, you actually had
a commit message ...).

So, FWIW: ACK

ATB,
Ramsay Jones

> ---
> This goes on top of bw/forking-and-threading.
> 
>  git-compat-util.h |  1 -
>  usage.c           | 10 +---------
>  2 files changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 8a4a3f85e..f1f2a2d73 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -445,7 +445,6 @@ extern void (*get_error_routine(void))(const char *err, va_list params);
>  extern void set_warn_routine(void (*routine)(const char *warn, va_list params));
>  extern void (*get_warn_routine(void))(const char *warn, va_list params);
>  extern void set_die_is_recursing_routine(int (*routine)(void));
> -extern void set_error_handle(FILE *);
>  
>  extern int starts_with(const char *str, const char *prefix);
>  
> diff --git a/usage.c b/usage.c
> index ad6d2910f..2623c078e 100644
> --- a/usage.c
> +++ b/usage.c
> @@ -6,12 +6,9 @@
>  #include "git-compat-util.h"
>  #include "cache.h"
>  
> -static FILE *error_handle;
> -
>  void vreportf(const char *prefix, const char *err, va_list params)
>  {
>  	char msg[4096];
> -	FILE *fh = error_handle ? error_handle : stderr;
>  	char *p;
>  
>  	vsnprintf(msg, sizeof(msg), err, params);
> @@ -19,7 +16,7 @@ void vreportf(const char *prefix, const char *err, va_list params)
>  		if (iscntrl(*p) && *p != '\t' && *p != '\n')
>  			*p = '?';
>  	}
> -	fprintf(fh, "%s%s\n", prefix, msg);
> +	fprintf(stderr, "%s%s\n", prefix, msg);
>  }
>  
>  static NORETURN void usage_builtin(const char *err, va_list params)
> @@ -88,11 +85,6 @@ void set_die_is_recursing_routine(int (*routine)(void))
>  	die_is_recursing = routine;
>  }
>  
> -void set_error_handle(FILE *fh)
> -{
> -	error_handle = fh;
> -}
> -
>  void NORETURN usagef(const char *err, ...)
>  {
>  	va_list params;
> 
