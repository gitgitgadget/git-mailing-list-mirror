Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65AEB1FCC7
	for <e@80x24.org>; Thu, 22 Dec 2016 23:04:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941782AbcLVXEX (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Dec 2016 18:04:23 -0500
Received: from mx1.2b3w.ch ([92.42.186.250]:52454 "EHLO mx1.2b3w.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933423AbcLVXEW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Dec 2016 18:04:22 -0500
Received: from mx1.2b3w.ch (localhost [127.0.0.1])
        by mx1.2b3w.ch (Postfix) with ESMTP id 8271CC3506;
        Fri, 23 Dec 2016 00:04:19 +0100 (CET)
Received: from mcmini.bolli (21-244-153-5.dyn.cable.fcom.ch [5.153.244.21])
        by mx1.2b3w.ch (Postfix) with ESMTPSA id 4EFF6C34FB;
        Fri, 23 Dec 2016 00:04:19 +0100 (CET)
Subject: Re: [PATCH v2 1/3] mingw: adjust is_console() to work with stdin
To:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
References: <cover.1482342791.git.johannes.schindelin@gmx.de>
 <cover.1482426497.git.johannes.schindelin@gmx.de>
 <ca4c61c603247c8ad0b876b068f6cd41fbe01667.1482426497.git.johannes.schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
From:   Beat Bolli <dev+git@drbeat.li>
Message-ID: <fc3e0d9c-86ea-4a62-6b70-b9cdd67f581a@drbeat.li>
Date:   Fri, 23 Dec 2016 00:04:18 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:45.0)
 Gecko/20100101 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <ca4c61c603247c8ad0b876b068f6cd41fbe01667.1482426497.git.johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22.12.16 18:08, Johannes Schindelin wrote:
> When determining whether a handle corresponds to a *real* Win32 Console
> (as opposed to, say, a character device such as /dev/null), we use the
> GetConsoleOutputBufferInfo() function as a tell-tale.
> 
> However, that does not work for *input* handles associated with a
> console. Let's just use the GetConsoleMode() function for input handles,
> and since it does not work on output handles fall back to the previous
> method for those.
> 
> This patch prepares for using is_console() instead of my previous
> misguided attempt in cbb3f3c9b1 (mingw: intercept isatty() to handle
> /dev/null as Git expects it, 2016-12-11) that broke everything on
> Windows.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  compat/winansi.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/compat/winansi.c b/compat/winansi.c
> index cb725fb02f..590d61cb1b 100644
> --- a/compat/winansi.c
> +++ b/compat/winansi.c
> @@ -84,6 +84,7 @@ static void warn_if_raster_font(void)
>  static int is_console(int fd)
>  {
>  	CONSOLE_SCREEN_BUFFER_INFO sbi;
> +	DWORD mode;

Nit: can we move this definition into the block below where it's used?

>  	HANDLE hcon;
>  
>  	static int initialized = 0;
> @@ -98,7 +99,10 @@ static int is_console(int fd)
>  		return 0;
>  
>  	/* check if its a handle to a console output screen buffer */
> -	if (!GetConsoleScreenBufferInfo(hcon, &sbi))
> +	if (!fd) {

Right here:
+               DWORD mode;

> +		if (!GetConsoleMode(hcon, &mode))
> +			return 0;
> +	} else if (!GetConsoleScreenBufferInfo(hcon, &sbi))
>  		return 0;
>  
>  	/* initialize attributes */
> 
