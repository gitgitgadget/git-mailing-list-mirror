Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F69EC433EF
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 23:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31D6C61A7D
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 23:27:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233171AbhKRXae (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 18:30:34 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:25484 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230436AbhKRXad (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 18:30:33 -0500
Received: from host-84-13-154-214.opaltelecom.net ([84.13.154.214] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1mnqoV-000CJk-56; Thu, 18 Nov 2021 23:27:31 +0000
Message-ID: <7fbd4cf4-5f66-a4cd-0c41-e5b12d14d761@iee.email>
Date:   Thu, 18 Nov 2021 23:27:31 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH] mergesort: avoid left shift overflow
Content-Language: en-GB
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <5eabbe1c-4c0f-559a-da21-423afec89e7e@web.de>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <5eabbe1c-4c0f-559a-da21-423afec89e7e@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 15/11/2021 23:19, René Scharfe wrote:
> Use size_t to match n when building the bitmask for checking whether a
> rank is occupied, instead of the default signed int.
>
> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
> Ugh, sorry. :(
>
>  mergesort.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mergesort.c b/mergesort.c
> index 6216835566..bd9c6ef8ee 100644
> --- a/mergesort.c
> +++ b/mergesort.c
> @@ -63,7 +63,7 @@ void *llist_mergesort(void *list,
>  		void *next = get_next_fn(list);
>  		if (next)
>  			set_next_fn(list, NULL);
> -		for (i = 0; n & (1 << i); i++)
> +		for (i = 0; n & ((size_t)1 << i); i++)
>  			list = llist_merge(ranks[i], list, get_next_fn,
>  					   set_next_fn, compare_fn);
>  		n++;
> --
> 2.33.1
Looks good to me.

I already had this locally as part of an MSVC (Visual Studio) fix for
the various C4334 warnings.

The other cases are in object-file.c, diffcore-delta.c (2 occurrences) ,
and repack.c.

My patches are in https://github.com/PhilipOakley/git/tree/oneU_t

Philip
