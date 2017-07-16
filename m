Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E20F2082F
	for <e@80x24.org>; Sun, 16 Jul 2017 00:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751214AbdGPAbJ (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Jul 2017 20:31:09 -0400
Received: from avasout06.plus.net ([212.159.14.18]:52594 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751207AbdGPAbJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Jul 2017 20:31:09 -0400
Received: from [10.0.2.15] ([143.159.212.52])
        by avasout06 with smtp
        id lCX61v00918PUFB01CX7gT; Sun, 16 Jul 2017 01:31:08 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=GetnpUfL c=1 sm=1 tr=0
 a=CKmocqUIrzA4K3l9YJ19NQ==:117 a=CKmocqUIrzA4K3l9YJ19NQ==:17
 a=IkcTkHD0fZMA:10 a=8RfyjxSGyL6rWo5ZcYwA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 3/2] apply: use COPY_ARRAY and MOVE_ARRAY in
 update_image()
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <ec78a849-36e4-4b1d-1ad6-46dcc39a1396@web.de>
 <2b2c8a6b-b493-84b1-1e47-5ea4585610da@web.de>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <636e2b70-2687-a925-e52d-32aa966ae9a9@ramsayjones.plus.com>
Date:   Sun, 16 Jul 2017 01:31:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <2b2c8a6b-b493-84b1-1e47-5ea4585610da@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 15/07/17 21:20, René Scharfe wrote:
> Simplify the code by using the helper macros COPY_ARRAY and MOVE_ARRAY,
> which also makes them more robust in the case we copy or move no lines,
> as they allow using NULL points in that case, while memcpy(3) and
> memmove(3) don't.
> 
> Found with Clang's UBSan.
> 
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
> I don't know why the rules in contrib/coccinelle/array.cocci didn't
> match. :-?
> 
>  apply.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/apply.c b/apply.c
> index f2d599141d..40707ca50c 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -2809,13 +2809,10 @@ static void update_image(struct apply_state *state,
>  		img->line_allocated = img->line;
>  	}
>  	if (preimage_limit != postimage->nr)
> -		memmove(img->line + applied_pos + postimage->nr,
> -			img->line + applied_pos + preimage_limit,
> -			(img->nr - (applied_pos + preimage_limit)) *
> -			sizeof(*img->line));
> -	memcpy(img->line + applied_pos,
> -	       postimage->line,
> -	       postimage->nr * sizeof(*img->line));
> +		MOVE_ARRAY(img->line + applied_pos + postimage->nr,
> +			   img->line + applied_pos + preimage_limit,
> +			   img->nr - (applied_pos + preimage_limit));
> +	COPY_ARRAY(img->line + applied_pos, postimage->line, postimage->nr);

My patch looks like:

-       memcpy(img->line + applied_pos,
-              postimage->line,
-              postimage->nr * sizeof(*img->line));
+       if (postimage->line && postimage->nr)
+               memcpy(img->line + applied_pos,
+                      postimage->line,
+                      postimage->nr * sizeof(*img->line));

... which I think I prefer (slightly).


ATB,
Ramsay Jones

>  	if (!state->allow_overlap)
>  		for (i = 0; i < postimage->nr; i++)
>  			img->line[applied_pos + i].flag |= LINE_PATCHED;
> 
