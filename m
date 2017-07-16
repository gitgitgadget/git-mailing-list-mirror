Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DB012082F
	for <e@80x24.org>; Sun, 16 Jul 2017 00:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751229AbdGPAYB (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Jul 2017 20:24:01 -0400
Received: from avasout06.plus.net ([212.159.14.18]:51891 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751198AbdGPAYB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Jul 2017 20:24:01 -0400
Received: from [10.0.2.15] ([143.159.212.52])
        by avasout06 with smtp
        id lCPy1v00118PUFB01CPzYj; Sun, 16 Jul 2017 01:23:59 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=GetnpUfL c=1 sm=1 tr=0
 a=CKmocqUIrzA4K3l9YJ19NQ==:117 a=CKmocqUIrzA4K3l9YJ19NQ==:17
 a=IkcTkHD0fZMA:10 a=AYosFbw9tWClMgODen0A:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH] bswap: convert to unsigned before shifting in get_be32
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <56f1263c-a0b4-260b-7e23-881e21119041@web.de>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <5fd84b40-9dde-0fd2-694c-49a073e87495@ramsayjones.plus.com>
Date:   Sun, 16 Jul 2017 01:23:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <56f1263c-a0b4-260b-7e23-881e21119041@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 15/07/17 20:11, René Scharfe wrote:
> The pointer p is dereferenced and we get an unsigned char.  Before
> shifting it's automatically promoted to int.  Left-shifting a signed
> 32-bit value bigger than 127 by 24 places is undefined.  Explicitly
> convert to a 32-bit unsigned type to avoid undefined behaviour if
> the highest bit is set.
> 
> Found with Clang's UBSan.
> 
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
>  compat/bswap.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/compat/bswap.h b/compat/bswap.h
> index d47c003544..4582c1107a 100644
> --- a/compat/bswap.h
> +++ b/compat/bswap.h
> @@ -166,10 +166,10 @@ static inline uint64_t git_bswap64(uint64_t x)
>  	(*((unsigned char *)(p) + 0) << 8) | \
>  	(*((unsigned char *)(p) + 1) << 0) )
>  #define get_be32(p)	( \
> -	(*((unsigned char *)(p) + 0) << 24) | \
> -	(*((unsigned char *)(p) + 1) << 16) | \
> -	(*((unsigned char *)(p) + 2) <<  8) | \
> -	(*((unsigned char *)(p) + 3) <<  0) )
> +	((uint32_t)*((unsigned char *)(p) + 0) << 24) | \
> +	((uint32_t)*((unsigned char *)(p) + 1) << 16) | \
> +	((uint32_t)*((unsigned char *)(p) + 2) <<  8) | \
> +	((uint32_t)*((unsigned char *)(p) + 3) <<  0) )
>  #define put_be32(p, v)	do { \
>  	unsigned int __v = (v); \
>  	*((unsigned char *)(p) + 0) = __v >> 24; \
> 

Heh, I have a patch that is pretty much identical. I suspect
you can guess why. ;-)

ATB,
Ramsay Jones

