Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DAC21F453
	for <e@80x24.org>; Tue,  6 Nov 2018 21:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbeKGG74 (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Nov 2018 01:59:56 -0500
Received: from bsmtp7.bon.at ([213.33.87.19]:13988 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725951AbeKGG7z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Nov 2018 01:59:55 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 42qN7C59xtz5tn2;
        Tue,  6 Nov 2018 22:32:39 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 1315E1B09;
        Tue,  6 Nov 2018 22:32:39 +0100 (CET)
Subject: Re: [PATCH 1/1] mingw: handle absolute paths in expand_user_path()
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <pull.66.git.gitgitgadget@gmail.com>
 <2287dd96cf0b9e9e250fdf92a32dcf666510e67d.1541515994.git.gitgitgadget@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <a374e4bb-1970-9ec7-fe94-a273f1206d6b@kdbg.org>
Date:   Tue, 6 Nov 2018 22:32:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <2287dd96cf0b9e9e250fdf92a32dcf666510e67d.1541515994.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 06.11.18 um 15:53 schrieb Johannes Schindelin via GitGitGadget:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> On Windows, an absolute POSIX path needs to be turned into a Windows
> one.

If I were picky, I would say that in a pure Windows application there 
cannot be POSIX paths to begin with.

Even if a path looks like a POSIX paths, i.e. it starts with a directory 
separator, but not with drive-letter-colon, it still has a particular 
meaning, namely (as far as I know) that the path is anchored at the root 
of the drive of the current working directory.

If a user specifies such a path on Windows, and it must undergo 
expand_user_path(), then that is a user error, or the user knows what 
they are doing.

I think it is wrong to interpret such a path as relative to some random 
other directory, like this patch seems to do.

> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>   path.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/path.c b/path.c
> index 34f0f98349..a72abf0e1f 100644
> --- a/path.c
> +++ b/path.c
> @@ -11,6 +11,7 @@
>   #include "path.h"
>   #include "packfile.h"
>   #include "object-store.h"
> +#include "exec-cmd.h"
>   
>   static int get_st_mode_bits(const char *path, int *mode)
>   {
> @@ -709,6 +710,10 @@ char *expand_user_path(const char *path, int real_home)
>   
>   	if (path == NULL)
>   		goto return_null;
> +#ifdef __MINGW32__
> +	if (path[0] == '/')
> +		return system_path(path + 1);
> +#endif
>   	if (path[0] == '~') {
>   		const char *first_slash = strchrnul(path, '/');
>   		const char *username = path + 1;
> 

