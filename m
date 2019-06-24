Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76C1C1F461
	for <e@80x24.org>; Mon, 24 Jun 2019 20:06:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731449AbfFXUG0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jun 2019 16:06:26 -0400
Received: from siwi.pair.com ([209.68.5.199]:60637 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726909AbfFXUG0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jun 2019 16:06:26 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 482FA3F4051;
        Mon, 24 Jun 2019 16:06:25 -0400 (EDT)
Received: from [192.168.1.6] (14.sub-174-226-196.myvzw.com [174.226.196.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id C8A5C3F40AC;
        Mon, 24 Jun 2019 16:06:24 -0400 (EDT)
Subject: Re: [PATCH v2 05/10] split-index.c: dump "link" extension as json
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFy?= =?UTF-8?Q?mason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20190624130226.17293-1-pclouds@gmail.com>
 <20190624130226.17293-6-pclouds@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <55f81571-ba45-edcf-49bd-05418cc309c5@jeffhostetler.com>
Date:   Mon, 24 Jun 2019 16:06:24 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20190624130226.17293-6-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 6/24/2019 9:02 AM, Nguyễn Thái Ngọc Duy wrote:
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>   json-writer.c             | 14 ++++++++++++++
>   json-writer.h             |  3 +++
>   split-index.c             |  9 ++++++++-
>   t/t3011-ls-files-json.sh  | 14 ++++++++++++++
>   t/t3011/split-index (new) | 39 +++++++++++++++++++++++++++++++++++++++
>   5 files changed, 78 insertions(+), 1 deletion(-)
> 
> diff --git a/json-writer.c b/json-writer.c
> index 0608726512..c0bd302e4e 100644
> --- a/json-writer.c
> +++ b/json-writer.c
> @@ -1,4 +1,5 @@
>   #include "cache.h"
> +#include "ewah/ewok.h"
>   #include "json-writer.h"
>   
>   void jw_init(struct json_writer *jw)
> @@ -224,6 +225,19 @@ void jw_object_stat_data(struct json_writer *jw, const char *name,
>   	jw_end(jw);
>   }
>   
> +static void dump_ewah_one(size_t pos, void *jw)
> +{
> +	jw_array_intmax(jw, pos);
> +}
> +
> +void jw_object_ewah(struct json_writer *jw, const char *key,
> +		    struct ewah_bitmap *ewah)
> +{
> +	jw_object_inline_begin_array(jw, key);
> +	ewah_each_bit(ewah, dump_ewah_one, jw);
> +	jw_end(jw);
> +}
> +

As I said in an earlier commit in this series, I'd prefer
that we keep such data-structure-specific helper functions
in the source file that defines the data structure rather
than adding them to json-writer.[ch]

I'm curious how big these EWAHs will be in practice and
how useful an array of integers will be (especially as the
pretty format will be one integer per line).  Perhaps it
would helpful to have an extended example in one of the
tests.

Would it be better to have the caller of ewah_each_bit()
build a hex or bit string in a strbuf and then write it
as a single string?

Jeff
