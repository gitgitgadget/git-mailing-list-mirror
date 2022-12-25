Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14255C4332F
	for <git@archiver.kernel.org>; Sun, 25 Dec 2022 08:54:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbiLYIya (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Dec 2022 03:54:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiLYIy3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Dec 2022 03:54:29 -0500
Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B4B62C1
        for <git@vger.kernel.org>; Sun, 25 Dec 2022 00:54:26 -0800 (PST)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 4NfvqL55nMz5tlB;
        Sun, 25 Dec 2022 09:54:22 +0100 (CET)
Message-ID: <983ce25f-82e1-e20d-ffb5-fd04fa9a9231@kdbg.org>
Date:   Sun, 25 Dec 2022 09:54:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2] win32: use _endthreadex to terminate threads, not
 ExitThread
To:     Rose via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Seija Kijin <doremylover123@gmail.com>, git@vger.kernel.org
References: <pull.1414.git.git.1671742750504.gitgitgadget@gmail.com>
 <pull.1414.v2.git.git.1671932510529.gitgitgadget@gmail.com>
Content-Language: en-US
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <pull.1414.v2.git.git.1671932510529.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 25.12.22 um 02:41 schrieb Rose via GitGitGadget:
> From: Seija Kijin <doremylover123@gmail.com>
> 
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
>     win32: use _endthreadex to terminate threads, not ExitThread
>     
>     Because we use the C runtime and use _beginthread to create pthreads,
>     pthread_exit MUST use _endthread.
>     
>     Otherwise, according to Microsoft: "Failure to do so results in small
>     memory leaks when the thread calls ExitThread."
>     
>     Simply put, this is not the same as ExitThread.
>     
>     Signed-off-by: Seija Kijin doremylover123@gmail.com
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1414%2FAtariDreams%2Fsevere-bug-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1414/AtariDreams/severe-bug-v2
> Pull-Request: https://github.com/git/git/pull/1414
> 
> Range-diff vs v1:
> 
>  1:  78f9d54c304 ! 1:  3e8212fb9a7 win32: use _endthreadex to terminate threads, not ExitThread
>      @@ Metadata
>        ## Commit message ##
>           win32: use _endthreadex to terminate threads, not ExitThread
>       
>      -    This is a pretty serious bug actually:
>           Because we use the C runtime and
>           use _beginthreadex to create pthreads,
>           pthread_exit MUST use _endthreadex.
> 
> 
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
> 
> base-commit: 7c2ef319c52c4997256f5807564523dfd4acdfc7

Thank you! This patch is now

Acked-by: Johannes Sixt <j6t@kdbg.org>

-- Hannes

