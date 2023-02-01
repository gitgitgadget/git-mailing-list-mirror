Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F0D6C05027
	for <git@archiver.kernel.org>; Wed,  1 Feb 2023 21:51:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjBAVv5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Feb 2023 16:51:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjBAVv4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2023 16:51:56 -0500
Received: from bsmtp2.bon.at (bsmtp2.bon.at [213.33.87.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9B1CA34
        for <git@vger.kernel.org>; Wed,  1 Feb 2023 13:51:54 -0800 (PST)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 4P6bGv1sMNz5tlC;
        Wed,  1 Feb 2023 22:51:51 +0100 (CET)
Message-ID: <f3de2ca3-167e-365c-8124-d6ba9bba920d@kdbg.org>
Date:   Wed, 1 Feb 2023 22:51:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3] win32: check for NULL after creating thread
To:     Rose via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Seija Kijin <doremylover123@gmail.com>, git@vger.kernel.org
References: <pull.1445.v2.git.git.1675176818033.gitgitgadget@gmail.com>
 <pull.1445.v3.git.git.1675262454817.gitgitgadget@gmail.com>
Content-Language: en-US
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <pull.1445.v3.git.git.1675262454817.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 01.02.23 um 15:40 schrieb Rose via GitGitGadget:
> From: Seija Kijin <doremylover123@gmail.com>
> 
> Check for NULL handles, not "INVALID_HANDLE,"
> as CreateThread guarantees a valid handle in most cases.
> 
> The return value for failed thread creation is NULL,
> not INVALID_HANDLE_VALUE, unlike other Windows API functions.

Nice catch!

The subject line sounds as if an error check was missing, but that is
not true. I'd phrase it

	compat/winansi: check for errors of CreateThread() correctly

Then drop the first sentence of the message body as it is very handwavy:
talking about "most cases" is not helpful if the few other cases are not
enumerated. And the subsequent sentence is to the point and very helpful
(substitute "CreateThread" for "thread creation").

>  compat/winansi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/compat/winansi.c b/compat/winansi.c
> index 3abe8dd5a27..f83610f684d 100644
> --- a/compat/winansi.c
> +++ b/compat/winansi.c
> @@ -644,7 +644,7 @@ void winansi_init(void)
>  
>  	/* start console spool thread on the pipe's read end */
>  	hthread = CreateThread(NULL, 0, console_thread, NULL, 0, NULL);
> -	if (hthread == INVALID_HANDLE_VALUE)
> +	if (!hthread)
>  		die_lasterr("CreateThread(console_thread) failed");
>  
>  	/* schedule cleanup routine */
> 
> base-commit: 2fc9e9ca3c7505bc60069f11e7ef09b1aeeee473

Acked-by: Johannes Sixt <j6t@kdbg.org>

-- Hannes

