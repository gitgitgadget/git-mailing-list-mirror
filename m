Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15946C4332F
	for <git@archiver.kernel.org>; Tue, 20 Dec 2022 07:54:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbiLTHyA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Dec 2022 02:54:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiLTHx7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2022 02:53:59 -0500
Received: from bsmtp3.bon.at (bsmtp3.bon.at [213.33.87.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8F82651
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 23:53:57 -0800 (PST)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp3.bon.at (Postfix) with ESMTPSA id 4Nbpjt3XcPz5tlB;
        Tue, 20 Dec 2022 08:53:54 +0100 (CET)
Message-ID: <a1d947ba-50ba-331b-daf6-30773d388be4@kdbg.org>
Date:   Tue, 20 Dec 2022 08:53:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] win32: close handles of threads that have been joined
Content-Language: en-US
To:     Rose via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Rose <83477269+AtariDreams@users.noreply.github.com>,
        git@vger.kernel.org, Seija Kijin <doremylover123@gmail.com>
References: <pull.1406.git.git.1671474876207.gitgitgadget@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <pull.1406.git.git.1671474876207.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 19.12.22 um 19:34 schrieb Rose via GitGitGadget:
> From: Seija Kijin <doremylover123@gmail.com>
> 
> After joining threads, the handle to the original thread
> should be closed as it no longer needs to be open.
> 
> Signed-off-by: Seija Kijin <doremylover123@gmail.com>
> ---

>  compat/win32/pthread.c | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/compat/win32/pthread.c b/compat/win32/pthread.c
> index 2e7eead42cb..de89667ef70 100644
> --- a/compat/win32/pthread.c
> +++ b/compat/win32/pthread.c
> @@ -39,14 +39,20 @@ int win32_pthread_join(pthread_t *thread, void **value_ptr)
>  {
>  	DWORD result = WaitForSingleObject(thread->handle, INFINITE);
>  	switch (result) {
> -		case WAIT_OBJECT_0:
> -			if (value_ptr)
> -				*value_ptr = thread->arg;
> -			return 0;
> -		case WAIT_ABANDONED:
> -			return EINVAL;
> -		default:
> -			return err_win_to_posix(GetLastError());
> +	case WAIT_OBJECT_0:
> +		if (value_ptr)
> +			*value_ptr = thread->arg;
> +		/* detach the thread once the join succeeds */
> +		CloseHandle(thread->handle);
> +		return 0;

This is a good change. It is a severe omission that the handle was not
closed. (But I still have to test the patch.)

> +	case WAIT_ABANDONED:
> +		/* either thread is not joinable or another thread is waiting on
> +		 * this, so we do not detatch */
> +		return EINVAL;

I don't know which cases this mental note wants to help. Assuming that
the [win232_]pthread_ API is used correctly, this error cannot happen
(WAIT_ABANDONED can only happen when WaitForSingleObject is called on a
mutex object).

> +	default:
> +	case WAIT_FAILED:
> +		/* the function failed so we do not detach */
> +		return err_win_to_posix(GetLastError());
>  	}

Good.

-- Hannes

