Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A91ABC4332F
	for <git@archiver.kernel.org>; Sat, 24 Dec 2022 08:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiLXIBR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Dec 2022 03:01:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiLXIBQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Dec 2022 03:01:16 -0500
Received: from bsmtp2.bon.at (bsmtp2.bon.at [213.33.87.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C431BBC15
        for <git@vger.kernel.org>; Sat, 24 Dec 2022 00:01:14 -0800 (PST)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 4NfGhR43MBz5tlG;
        Sat, 24 Dec 2022 09:01:11 +0100 (CET)
Message-ID: <0b039029-97ce-bbc3-d9af-7f1eb1fd8b64@kdbg.org>
Date:   Sat, 24 Dec 2022 09:01:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] win32: use _endthreadex to terminate threads, not
 ExitThread
To:     Rose via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Seija Kijin <doremylover123@gmail.com>, git@vger.kernel.org
References: <pull.1414.git.git.1671742750504.gitgitgadget@gmail.com>
Content-Language: en-US
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <pull.1414.git.git.1671742750504.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 22.12.22 um 21:59 schrieb Rose via GitGitGadget:
> From: Seija Kijin <doremylover123@gmail.com>
> 
> This is a pretty serious bug actually:
> Because we use the C runtime and
> use _beginthreadex to create pthreads,
> pthread_exit MUST use _endthreadex.
> 
> Otherwise, according to Microsoft:
> "Failure to do so results in small
> memory leaks when the thread
> calls ExitThread."
> 
> Simply put, this is not the same as ExitThread.
> 
> Signed-off-by: Seija Kijin <doremylover123@gmail.com>
> ---

>  compat/win32/pthread.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/compat/win32/pthread.h b/compat/win32/pthread.h
> index 737983d00ba..cc3221cb2c8 100644
> --- a/compat/win32/pthread.h
> +++ b/compat/win32/pthread.h
> @@ -66,7 +66,7 @@ pthread_t pthread_self(void);
>  
>  static inline void NORETURN pthread_exit(void *ret)
>  {
> -	ExitThread((DWORD)(intptr_t)ret);
> +	_endthreadex((unsigned)(uintptr_t)ret);
>  }
>  
>  typedef DWORD pthread_key_t;

Nice find! FWIW, this passes the test suite on Windows.

The patch text is:

Acked-by: Johannes Sixt <j6t@kdbg.org>

The commit message is highly exaggerated, though. The bug is by no means
serious. After all, we've been living with it for a decade. Notice that
pthread_exit() is only called when a thread runs into die(). Even though
we have a small memory leak, it does not occur in a loop because, after
one thread dies, we do not tend to keep starting many, many more that
all die.

-- Hannes

