Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01FF020A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 21:58:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728313AbeLJV6e (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 16:58:34 -0500
Received: from bsmtp7.bon.at ([213.33.87.19]:13006 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbeLJV6d (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 16:58:33 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 43DH5L0RXrz5tlC;
        Mon, 10 Dec 2018 22:58:29 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 1B80420B4;
        Mon, 10 Dec 2018 22:58:29 +0100 (CET)
Subject: Re: [PATCH 2/2] mingw: allow absolute paths without drive prefix
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.96.git.gitgitgadget@gmail.com>
 <50ac31ef7f4380f37a0e2d3b75e82b324afee9e3.1544467631.git.gitgitgadget@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <11b17e5d-e843-463b-77da-263e8e3b7598@kdbg.org>
Date:   Mon, 10 Dec 2018 22:58:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <50ac31ef7f4380f37a0e2d3b75e82b324afee9e3.1544467631.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 10.12.18 um 19:47 schrieb Johannes Schindelin via GitGitGadget:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> When specifying an absolute path without a drive prefix, we convert that
> path internally. Let's make sure that we handle that case properly, too
> ;-)
> 
> This fixes the command
> 
> 	git clone https://github.com/git-for-windows/git \G4W
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>   compat/mingw.c            | 10 +++++++++-
>   t/t5580-clone-push-unc.sh |  2 +-
>   2 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/compat/mingw.c b/compat/mingw.c
> index 34b3880b29..4d009901d8 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -928,11 +928,19 @@ unsigned int sleep (unsigned int seconds)
>   char *mingw_mktemp(char *template)
>   {
>   	wchar_t wtemplate[MAX_PATH];
> +	int offset = 0;
> +
>   	if (xutftowcs_path(wtemplate, template) < 0)
>   		return NULL;
> +
> +	if (is_dir_sep(template[0]) && !is_dir_sep(template[1]) &&
> +	    iswalpha(wtemplate[0]) && wtemplate[1] == L':') {
> +		/* We have an absolute path missing the drive prefix */

This comment is true for the source part, template, but I can't find 
where the destination, wtemplate, suddenly gets the drive prefix. As far 
as I can see, xutftowcs_path() just does a plain textual conversion 
without any interpretation of the text as path. Can you explain it?

BTW, iswalpha() is not restricted to ASCII letters, I would rewrite it 
as (wtemplate[0] <= 127 && isalpha(wtemplate[0]).

> +		offset = 2;
> +	}
>   	if (!_wmktemp(wtemplate))
>   		return NULL;
> -	if (xwcstoutf(template, wtemplate, strlen(template) + 1) < 0)
> +	if (xwcstoutf(template, wtemplate + offset, strlen(template) + 1) < 0)
>   		return NULL;
>   	return template;
>   }
> diff --git a/t/t5580-clone-push-unc.sh b/t/t5580-clone-push-unc.sh
> index c2b0082296..17c38c33a5 100755
> --- a/t/t5580-clone-push-unc.sh
> +++ b/t/t5580-clone-push-unc.sh
> @@ -29,7 +29,7 @@ case "$UNCPATH" in
>   	;;
>   esac
>   
> -test_expect_failure 'clone into absolute path lacking a drive prefix' '
> +test_expect_success 'clone into absolute path lacking a drive prefix' '
>   	USINGBACKSLASHES="$(echo "$WITHOUTDRIVE"/without-drive-prefix |
>   		tr / \\\\)" &&
>   	git clone . "$USINGBACKSLASHES" &&
> 

-- Hannes
