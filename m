Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C50FC433EF
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 06:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F5986103D
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 06:33:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239362AbhIWGef (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Sep 2021 02:34:35 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:55081 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239365AbhIWGee (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Sep 2021 02:34:34 -0400
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 4HFQMd6xGwz5tlN;
        Thu, 23 Sep 2021 08:33:00 +0200 (CEST)
Subject: Re: [PATCH] lazyload.h: use an even more generic function pointer
 than FARPROC
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <4381472f-a9db-b8a7-a395-81c3935309ae@kdbg.org>
 <20210923060306.21073-1-carenas@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <88717872-d31f-c1b8-0d0b-364b154f7734@kdbg.org>
Date:   Thu, 23 Sep 2021 08:33:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210923060306.21073-1-carenas@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 23.09.21 um 08:03 schrieb Carlo Marcelo Arenas Belón:
> gcc will helpfully raise a -Wcast-function-type warning when casting
> between functions that might have incompatible return types
> (ex: GetUserNameExW returns bool which is only half the size of the
> return type from FARPROC which is long long), so create a new type that
> could be used as a completely generic function pointer and cast through
> it instead.

IIUC, this patch goes on top of mine in origin/js/win-lazyload-buildfix,
right?

> 
> Additionaly remove the -Wno-incompatible-pointer-types temporary
> flag added in 27e0c3c (win32: allow building with pedantic mode
> enabled, 2021-09-03), as it will be no longer needed.
> 
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
>  compat/win32/lazyload.h | 9 ++++++---
>  config.mak.dev          | 1 -
>  2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/compat/win32/lazyload.h b/compat/win32/lazyload.h
> index dc35cf080b..26c80f7833 100644
> --- a/compat/win32/lazyload.h
> +++ b/compat/win32/lazyload.h
> @@ -15,10 +15,12 @@
>   *                        source, target);
>   */
>  
> +typedef void (*FARVOIDPROC)(void);
> +
>  struct proc_addr {
>  	const char *const dll;
>  	const char *const function;
> -	FARPROC pfunction;
> +	FARVOIDPROC pfunction;
>  	unsigned initialized : 1;
>  };
>  
> @@ -38,7 +40,7 @@ struct proc_addr {
>  #define INIT_PROC_ADDR(function) \
>  	(function = (proc_type_##function)get_proc_addr(&proc_addr_##function))
>  
> -static inline FARPROC get_proc_addr(struct proc_addr *proc)
> +static inline FARVOIDPROC get_proc_addr(struct proc_addr *proc)
>  {
>  	/* only do this once */
>  	if (!proc->initialized) {
> @@ -47,7 +49,8 @@ static inline FARPROC get_proc_addr(struct proc_addr *proc)
>  		hnd = LoadLibraryExA(proc->dll, NULL,
>  				     LOAD_LIBRARY_SEARCH_SYSTEM32);
>  		if (hnd)
> -			proc->pfunction = GetProcAddress(hnd, proc->function);
> +			proc->pfunction = (FARVOIDPROD)GetProcAddress(hnd,
> +							proc->function);
>  	}
>  	/* set ENOSYS if DLL or function was not found */
>  	if (!proc->pfunction)
> diff --git a/config.mak.dev b/config.mak.dev
> index c080ac0231..cdf043c52b 100644
> --- a/config.mak.dev
> +++ b/config.mak.dev
> @@ -12,7 +12,6 @@ DEVELOPER_CFLAGS += -pedantic
>  DEVELOPER_CFLAGS += -Wpedantic
>  ifneq ($(filter gcc5,$(COMPILER_FEATURES)),)
>  DEVELOPER_CFLAGS += -Wno-pedantic-ms-format
> -DEVELOPER_CFLAGS += -Wno-incompatible-pointer-types
>  endif
>  endif
>  DEVELOPER_CFLAGS += -Wdeclaration-after-statement
> 

