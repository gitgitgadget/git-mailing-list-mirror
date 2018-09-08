Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 772BA1F404
	for <e@80x24.org>; Sat,  8 Sep 2018 09:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbeIHOMG (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Sep 2018 10:12:06 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:11477 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbeIHOMG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Sep 2018 10:12:06 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 426pq73dgQz5tlN;
        Sat,  8 Sep 2018 11:26:59 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id D2CF71DB0;
        Sat,  8 Sep 2018 11:26:58 +0200 (CEST)
Subject: Re: [PATCH 2/2] mingw: fix mingw_open_append to work with named pipes
To:     jeffhost@microsoft.com
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <pull.35.git.gitgitgadget@gmail.com>
 <f433937d55974b75750cfc7d579a6a56109259a4.1536344387.git.gitgitgadget@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <1c524f56-2021-a961-168f-e5c6d7914ec2@kdbg.org>
Date:   Sat, 8 Sep 2018 11:26:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <f433937d55974b75750cfc7d579a6a56109259a4.1536344387.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 07.09.2018 um 20:19 schrieb Jeff Hostetler via GitGitGadget:
> From: Jeff Hostetler <jeffhost@microsoft.com>
> 
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---
>   compat/mingw.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/compat/mingw.c b/compat/mingw.c
> index 858ca14a57..ef03bbe5d2 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -355,7 +355,7 @@ static int mingw_open_append(wchar_t const *wfilename, int oflags, ...)
>   	 * FILE_SHARE_WRITE is required to permit child processes
>   	 * to append to the file.
>   	 */
> -	handle = CreateFileW(wfilename, FILE_APPEND_DATA,
> +	handle = CreateFileW(wfilename, FILE_WRITE_DATA | FILE_APPEND_DATA,
>   			FILE_SHARE_WRITE | FILE_SHARE_READ,
>   			NULL, create, FILE_ATTRIBUTE_NORMAL, NULL);
>   	if (handle == INVALID_HANDLE_VALUE)
> 

I did not go with this version because the documentation 
https://docs.microsoft.com/en-us/windows/desktop/fileio/file-access-rights-constants 
says:

FILE_APPEND_DATA: For a file object, the right to append data to the 
file. (For local files, write operations will not overwrite existing 
data if this flag is specified without FILE_WRITE_DATA.) [...]

which could be interpreted as: Only if FILE_WRITE_DATA is not set, we 
have the guarantee that existing data in local files is not overwritten, 
i.e., new data is appended atomically.

Is this interpretation too narrow and we do get atomicity even when 
FILE_WRITE_DATA is set?

-- Hannes
