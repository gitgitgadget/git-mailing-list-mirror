Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74F072013E
	for <e@80x24.org>; Sun,  5 Mar 2017 12:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752380AbdCEMUW (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Mar 2017 07:20:22 -0500
Received: from aserp1040.oracle.com ([141.146.126.69]:42477 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752251AbdCEMUV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Mar 2017 07:20:21 -0500
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id v25CK6W4001278
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Sun, 5 Mar 2017 12:20:06 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.13.8/8.14.4) with ESMTP id v25CK5R9016324
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Sun, 5 Mar 2017 12:20:06 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id v25CK4YC032609;
        Sun, 5 Mar 2017 12:20:04 GMT
Received: from [10.175.194.206] (/10.175.194.206)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 05 Mar 2017 04:20:03 -0800
Subject: Re: [PATCH] line-log: use COPY_ARRAY to fix mis-sized memcpy
To:     Jeff King <peff@peff.net>
References: <xmqqinnrd098.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1703030315580.3767@virtualbox>
 <xmqqh93a9p5r.fsf@gitster.mtv.corp.google.com>
 <xmqq8tol7vs1.fsf@gitster.mtv.corp.google.com>
 <CAPc5daW=gtN18JZTQMqUje5fxL4oNdTucB0dXFbybPRJggPBUw@mail.gmail.com>
 <2205F1A7-A694-4F40-B994-D68C3947F2BB@gmail.com>
 <f5f5886a-aaec-7426-ea33-f5d65516348b@oracle.com>
 <af31ef46-bd0c-c3f2-5a1e-7d97da6ec9a0@oracle.com>
 <282895e1-d9eb-2368-a8e7-8085ad9b17ed@oracle.com>
 <20170305113618.ko2jymle4n5f2b5l@sigill.intra.peff.net>
 <20170305114446.wqm33o52yizlffju@sigill.intra.peff.net>
Cc:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        allan.x.xavier@oracle.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>
From:   Vegard Nossum <vegard.nossum@oracle.com>
Message-ID: <8bd81e58-6d9d-b7f3-b1b0-bb2a352c92c9@oracle.com>
Date:   Sun, 5 Mar 2017 13:20:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20170305114446.wqm33o52yizlffju@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Source-IP: aserv0021.oracle.com [141.146.126.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/03/2017 12:44, Jeff King wrote:
> On Sun, Mar 05, 2017 at 06:36:19AM -0500, Jeff King wrote:
>
>>>  	range_set_init(dst, src->nr);
>>> -	memcpy(dst->ranges, src->ranges, src->nr*sizeof(struct range_set));
>>> +	memcpy(dst->ranges, src->ranges, src->nr*sizeof(struct range));
>>
>> I think "sizeof(*dst->ranges)" is probably an even better fix, as it
>> infers the type of "dst". But these days we have COPY_ARRAY() to make it
>> even harder to get this kind of thing wrong.
>
> So here's your fix wrapped up with a commit message, mostly for Junio's
> convenience. I listed you as the author, since you did the hard part. If
> you're OK with it, please indicate that it's OK to add your
> signed-off-by. If you prefer to do it differently, feel free to post
> your own patch.

Thanks.

>
> -- >8 --
> From: Vegard Nossum <vegard.nossum@oracle.com>
> Subject: [PATCH] line-log: use COPY_ARRAY to fix mis-sized memcpy
>
> This memcpy meant to get the sizeof a "struct range", not a
> "range_set", as the former is what our array holds. Rather
> than swap out the types, let's convert this site to
> COPY_ARRAY, which avoids the problem entirely (and confirms
> that the src and dst types match).
>
> Note for curiosity's sake that this bug doesn't trigger on
> I32LP64 systems, but does on ILP32 systems. The mistaken
> "struct range_set" has two ints and a pointer. That's 16
> bytes on LP64, or 12 on ILP32. The correct "struct range"
> type has two longs, which is also 16 on LP64, but only 8 on
> ILP32.
>
> Likewise an IL32P64 system would experience the bug.
>
> Signed-off-by: Jeff King <peff@peff.net>

Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>

> ---
>  line-log.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/line-log.c b/line-log.c
> index 65f3558b3..a2477f601 100644
> --- a/line-log.c
> +++ b/line-log.c
> @@ -43,9 +43,10 @@ void range_set_release(struct range_set *rs)
>  static void range_set_copy(struct range_set *dst, struct range_set *src)
>  {
>  	range_set_init(dst, src->nr);
> -	memcpy(dst->ranges, src->ranges, src->nr*sizeof(struct range_set));
> +	COPY_ARRAY(dst->ranges, src->ranges, src->nr);
>  	dst->nr = src->nr;
>  }
> +
>  static void range_set_move(struct range_set *dst, struct range_set *src)
>  {
>  	range_set_release(dst);
>


Vegard
