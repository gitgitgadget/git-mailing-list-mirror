Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88EEF1F406
	for <e@80x24.org>; Wed, 17 Jan 2018 20:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753295AbeAQUh7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Jan 2018 15:37:59 -0500
Received: from siwi.pair.com ([209.68.5.199]:16194 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753075AbeAQUh6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jan 2018 15:37:58 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 968848453B;
        Wed, 17 Jan 2018 15:37:56 -0500 (EST)
Received: from [192.168.1.71] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 49E168452A;
        Wed, 17 Jan 2018 15:37:56 -0500 (EST)
Subject: Re: [PATCH v2 2/2] sha1_file: improve sha1_file_name() perfs
To:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>, Kevin Daudt <me@ikke.info>,
        Christian Couder <chriscool@tuxfamily.org>
References: <20180117175455.9316-1-chriscool@tuxfamily.org>
 <20180117175455.9316-2-chriscool@tuxfamily.org>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <3cbace45-61df-3074-a48c-66c68c96d542@jeffhostetler.com>
Date:   Wed, 17 Jan 2018 15:37:55 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180117175455.9316-2-chriscool@tuxfamily.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 1/17/2018 12:54 PM, Christian Couder wrote:
> As sha1_file_name() could be performance sensitive, let's
> try to make it faster by seeding the initial buffer size
> to avoid any need to realloc and by using strbuf_addstr()
> and strbuf_addc() instead of strbuf_addf().
> 
> Helped-by: Derrick Stolee <stolee@gmail.com>
> Helped-by: Jeff Hostetler <git@jeffhostetler.com>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>   sha1_file.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/sha1_file.c b/sha1_file.c
> index f66c21b2da..1a94716962 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -323,8 +323,14 @@ static void fill_sha1_path(struct strbuf *buf, const unsigned char *sha1)
>   
>   void sha1_file_name(struct strbuf *buf, const unsigned char *sha1)
>   {
> -	strbuf_addf(buf, "%s/", get_object_directory());
> +	const char *obj_dir = get_object_directory();
> +	size_t extra = strlen(obj_dir) + 1 + GIT_MAX_HEXSZ;

Very minor nit.  Should this be "+3" rather than "+1"?
One for the slash after obj_dir, one for the slash between
"xx/y[38]", and one for the trailing NUL.

>   
> +	if (extra > strbuf_avail(buf))
> +		strbuf_grow(buf, extra);
> +
> +	strbuf_addstr(buf, obj_dir);
> +	strbuf_addch(buf, '/');
>   	fill_sha1_path(buf, sha1);
>   }
>   
> 
