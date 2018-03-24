Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB00C1F42D
	for <e@80x24.org>; Sat, 24 Mar 2018 11:12:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751883AbeCXLMB (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 07:12:01 -0400
Received: from siwi.pair.com ([209.68.5.199]:54396 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751843AbeCXLMA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 07:12:00 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 2BFEA3F400A;
        Sat, 24 Mar 2018 07:12:00 -0400 (EDT)
Received: from [192.168.1.71] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 03D743F4002;
        Sat, 24 Mar 2018 07:11:59 -0400 (EDT)
Subject: Re: [RFC PATCH 1/1] json-writer: incorrect format specifier
To:     Wink Saville <wink@saville.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, jeffhost@microsoft.com
References: <cover.1521868951.git.wink@saville.com>
 <140b7646e7efa4175f9d82e6eb2909f2f94771fe.1521868951.git.wink@saville.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <d6af477d-6865-9580-0389-182a5c19d935@jeffhostetler.com>
Date:   Sat, 24 Mar 2018 07:11:59 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:59.0) Gecko/20100101
 Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <140b7646e7efa4175f9d82e6eb2909f2f94771fe.1521868951.git.wink@saville.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/24/2018 1:37 AM, Wink Saville wrote:
> In routines jw_object_uint64 and jw_object_double strbuf_addf is
> invoked with strbuf_addf(&jw->json, ":%"PRIuMAX, value) where value
> is a uint64_t. This causes a compile error on OSX.
> 
> The correct format specifier is PRIu64 instead of PRIuMax.
> 
> Signed-off-by: Wink Saville <wink@saville.com>

That's odd.

A grep on the Git source tree did not find a "PRIu64" symbol.
Searching public-inbox only found one message [1] talking about it
(other than the ones associated with your messages here).

I have to wonder if that is defined in a OSX header file and
you're getting it from there [2].  (I don't have a MAC in front of
me, so I can't verify what's in that header.)  But [2] defines
PRIuMAX as PRIu64, so we shouldn't need to make that change in
json-writer -- unless something is getting lost in the #ifdefs.

Could you double check this in the header files on your system?
Any chance you are doing a 32-bit build?

Thanks
Jeff

[1] 
https://public-inbox.org/git/MWHPR21MB0478181AE0B64901DA2C07CDF4600@MWHPR21MB0478.namprd21.prod.outlook.com/raw

[2] https://opensource.apple.com/source/gcc/gcc-926/inttypes.h.auto.html


> ---
>   json-writer.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/json-writer.c b/json-writer.c
> index 89a6abb57..04045448a 100644
> --- a/json-writer.c
> +++ b/json-writer.c
> @@ -120,7 +120,7 @@ void jw_object_uint64(struct json_writer *jw, const char *key, uint64_t value)
>   	maybe_add_comma(jw);
>   
>   	append_quoted_string(&jw->json, key);
> -	strbuf_addf(&jw->json, ":%"PRIuMAX, value);
> +	strbuf_addf(&jw->json, ":%"PRIu64, value);
>   }
>   
>   void jw_object_double(struct json_writer *jw, const char *fmt,
> @@ -225,7 +225,7 @@ void jw_array_uint64(struct json_writer *jw, uint64_t value)
>   	assert_in_array(jw);
>   	maybe_add_comma(jw);
>   
> -	strbuf_addf(&jw->json, "%"PRIuMAX, value);
> +	strbuf_addf(&jw->json, "%"PRIu64, value);
>   }
>   
>   void jw_array_double(struct json_writer *jw, const char *fmt, double value)
> 
