Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFED4C4332F
	for <git@archiver.kernel.org>; Thu, 22 Dec 2022 07:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235020AbiLVHwm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Dec 2022 02:52:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235039AbiLVHwk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Dec 2022 02:52:40 -0500
Received: from bsmtp2.bon.at (bsmtp2.bon.at [213.33.87.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 191962228A
        for <git@vger.kernel.org>; Wed, 21 Dec 2022 23:52:34 -0800 (PST)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 4Nd2bK6PgVz5tlH;
        Thu, 22 Dec 2022 08:52:29 +0100 (CET)
Message-ID: <559648b5-5acc-ef8f-3c72-69163ffd7b52@kdbg.org>
Date:   Thu, 22 Dec 2022 08:52:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v7 1/2] win32: close handles of threads that have been
 joined
To:     Seija Kijin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Rose <83477269+AtariDreams@users.noreply.github.com>,
        Seija Kijin <doremylover123@gmail.com>, git@vger.kernel.org
References: <pull.1406.v6.git.git.1671597317.gitgitgadget@gmail.com>
 <pull.1406.v7.git.git.1671598008.gitgitgadget@gmail.com>
 <b40287508dfa9dc3013828f011c8729d8f8eb972.1671598008.git.gitgitgadget@gmail.com>
Content-Language: en-US
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <b40287508dfa9dc3013828f011c8729d8f8eb972.1671598008.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 21.12.22 um 05:46 schrieb Seija Kijin via GitGitGadget:
> From: Seija Kijin <doremylover123@gmail.com>
> 
> After the thread terminates, the handle to the
> original thread should be closed.
> 
> This change makes win32_pthread_join POSIX compliant.
> 
> Signed-off-by: Seija Kijin <doremylover123@gmail.com>
> ---
>  compat/win32/pthread.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/compat/win32/pthread.c b/compat/win32/pthread.c
> index 2e7eead42cb..21c705778b6 100644
> --- a/compat/win32/pthread.c
> +++ b/compat/win32/pthread.c
> @@ -42,10 +42,13 @@ int win32_pthread_join(pthread_t *thread, void **value_ptr)
>  		case WAIT_OBJECT_0:
>  			if (value_ptr)
>  				*value_ptr = thread->arg;
> +			CloseHandle(thread->handle);
>  			return 0;
>  		case WAIT_ABANDONED:
> +			CloseHandle(thread->handle);
>  			return EINVAL;
>  		default:
> +			/* the function failed, so do not detach */
>  			return err_win_to_posix(GetLastError());
>  	}
>  }

This patch looks good. It passes the test suite on Windows. Hence:

Acked-by: Johannes Sixt <j6t@kdbg.org>

The follow-up patch in this thread, though, has an incomplete subject
line and no motivation. It is not ready to be picked up.

-- Hannes

