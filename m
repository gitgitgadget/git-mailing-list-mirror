Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE707C4332F
	for <git@archiver.kernel.org>; Tue, 20 Dec 2022 22:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234062AbiLTWGI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Dec 2022 17:06:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiLTWGG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2022 17:06:06 -0500
Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0A6B1E
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 14:06:04 -0800 (PST)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 4Nc9d531s3z5tl9;
        Tue, 20 Dec 2022 23:06:01 +0100 (CET)
Message-ID: <4c4f7723-b1fa-846b-75ee-c37c61048ed8@kdbg.org>
Date:   Tue, 20 Dec 2022 23:06:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v5] win32: close handles of threads that have been joined
Content-Language: en-US
To:     Rose via GitGitGadget <gitgitgadget@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Rose <83477269+AtariDreams@users.noreply.github.com>,
        Seija Kijin <doremylover123@gmail.com>, git@vger.kernel.org
References: <pull.1406.v4.git.git.1671566641.gitgitgadget@gmail.com>
 <pull.1406.v5.git.git.1671571084753.gitgitgadget@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <pull.1406.v5.git.git.1671571084753.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 20.12.22 um 22:18 schrieb Rose via GitGitGadget:
> From: Seija Kijin <doremylover123@gmail.com>
> 
> After joining threads, the handle to the original thread
> should be closed as it no longer needs to be open.
> 
> Because this only needs to happen if the
> WaitForSingleObject fails, the function was
> rewritten to accommodate this change.

This sentence says that the handle must be closed only when
WaitForSingleObject fails. But my understanding is that we must close it
when the call is successful. In fact, that is what you implemented.

> The function is still POSIX compliant.
> 
> Signed-off-by: Seija Kijin <doremylover123@gmail.com>
> ---

> 
>  compat/win32/pthread.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/compat/win32/pthread.c b/compat/win32/pthread.c
> index 2e7eead42cb..7f8503b4b50 100644
> --- a/compat/win32/pthread.c
> +++ b/compat/win32/pthread.c
> @@ -37,17 +37,15 @@ int pthread_create(pthread_t *thread, const void *unused,
>  
>  int win32_pthread_join(pthread_t *thread, void **value_ptr)
>  {
> -	DWORD result = WaitForSingleObject(thread->handle, INFINITE);
> -	switch (result) {
> -		case WAIT_OBJECT_0:
> -			if (value_ptr)
> -				*value_ptr = thread->arg;
> -			return 0;
> -		case WAIT_ABANDONED:
> -			return EINVAL;
> -		default:
> -			return err_win_to_posix(GetLastError());
> +	if (WaitForSingleObject(thread->handle, INFINITE) == WAIT_FAILED)
> +		return err_win_to_posix(GetLastError());
> +
> +	if (value_ptr) {
> +		*value_ptr = thread->arg;
>  	}
> +
> +	CloseHandle(thread->handle);
> +	return 0;

Generally, such rewrites are not welcome if there is no obvious value in
the new code structure. To my eyes, the original switch statement is
much clearer than the new structure. In particular, the good case is
when the result is WAIT_OBJECT_0. The switch statement clearly handles
the case. The new code, however, loses the handling of a buggy caller,
WAIT_ABANONED, and handles it like a success case.

What is wrong with just inserting a CloseHandle() call at the right spot
in the original code and no other change?

>  }
>  
>  pthread_t pthread_self(void)


-- Hannes

