Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F10EEC433EF
	for <git@archiver.kernel.org>; Fri, 15 Jul 2022 06:01:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbiGOGBN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jul 2022 02:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbiGOGBI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jul 2022 02:01:08 -0400
Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD367A502
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 23:01:06 -0700 (PDT)
Received: from bsmtp2.bon.at (unknown [192.168.181.106])
        by bsmtp5.bon.at (Postfix) with ESMTPS id 4Lkghc4fKtz5vHQ
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 08:01:04 +0200 (CEST)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 4LkghW1CXyz5tlB;
        Fri, 15 Jul 2022 08:00:59 +0200 (CEST)
Message-ID: <b7fffe99-63fb-3899-6a6d-882b72b9512f@kdbg.org>
Date:   Fri, 15 Jul 2022 08:00:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC][PATCH] mingw: avoid mktemp() in mkstemp() implementation
Content-Language: en-US
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <7265e37f-fd29-3579-b840-19a1df52a59f@web.de>
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <7265e37f-fd29-3579-b840-19a1df52a59f@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 15.07.22 um 05:58 schrieb René Scharfe:
> The implementation of mkstemp() for MinGW uses mktemp() and open()
> without the flag O_EXCL, which is racy.  It's not a security problem
> for now because all of its callers only create files within the
> repository (incl. worktrees).  Replace it with a call to our more
> secure internal function, git_mkstemp_mode(), to prevent possible
> future issues.
> 
> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
>  compat/mingw.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/compat/mingw.c b/compat/mingw.c
> index 2607de93af..b5502997e2 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -1059,10 +1059,7 @@ char *mingw_mktemp(char *template)
> 
>  int mkstemp(char *template)
>  {
> -	char *filename = mktemp(template);
> -	if (!filename)
> -		return -1;
> -	return open(filename, O_RDWR | O_CREAT, 0600);
> +	return git_mkstemp_mode(template, 0600);
>  }
> 
>  int gettimeofday(struct timeval *tv, void *tz)

I hate such an obvious layering violation. But we have already a ton of
them elsewhere (calling xmalloc from compat/, for example), so this is
just a rant, not an objection.

-- Hannes
