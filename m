Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12BF6C433F5
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 17:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5E1861101
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 17:40:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241332AbhIIRlz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 13:41:55 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63710 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237243AbhIIRlz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 13:41:55 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3BC5FEEDF8;
        Thu,  9 Sep 2021 13:40:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=P5M890eq8CvkokpUEJwxIXHRBM2RTooDFx++J3
        xEXIQ=; b=r4G2x1MlqPeBqY+ajDrtFPwkpg1FLKTVo19jUfn3i0+8CD0VPGfiYa
        7w2kZ5zFKnD9BIcfWw1AweokGA7Gsiyldo9oBo24OEqKZIqbYnfqzyFGUIB4qAJB
        TRM8yJzbVMX86b3+A5ohvLnElP+4YDCqzvyuogXAKRaVd6Ed+tECg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 31BFDEEDF7;
        Thu,  9 Sep 2021 13:40:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A82C2EEDF6;
        Thu,  9 Sep 2021 13:40:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH 4/5] http: centralize the accounting of libcurl
 dependencies
References: <cover-v4-0.5-00000000000-20210730T175650Z-avarab@gmail.com>
        <cover-0.5-00000000000-20210908T152807Z-avarab@gmail.com>
        <patch-4.5-47b513a261b-20210908T152807Z-avarab@gmail.com>
        <YTkPfyAYTU4ZgRgb@coredump.intra.peff.net>
Date:   Thu, 09 Sep 2021 10:40:44 -0700
In-Reply-To: <YTkPfyAYTU4ZgRgb@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 8 Sep 2021 15:31:11 -0400")
Message-ID: <xmqq5yv91wbn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0F5B0074-1195-11EC-A65A-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> +/**
>> + * CURLOPT_TCP_KEEPALIVE was added in 7.25.0, released in March 2012.
>> + */
>> +#ifdef CURLOPT_TCP_KEEPALIVE
>> +#define GITCURL_HAVE_CURLOPT_TCP_KEEPALIVE 1
>> +#endif
>>
>> [...]
>>
>> -#if LIBCURL_VERSION_NUM >= 0x071900
>> +#ifdef GITCURL_HAVE_CURLOPT_TCP_KEEPALIVE
>>  static void set_curl_keepalive(CURL *c)
>>  {
>>  	curl_easy_setopt(c, CURLOPT_TCP_KEEPALIVE, 1);
>
> Part of me is a little sad at the duplication this creates. We could
> just be checking
>
>   #ifdef CURLOPT_TCP_KEEPALIVE
>
> in the second hunk, without the first one at all.

I recall having exactly the same reaction when the above pattern
first was floated.  

I still do not see how the GITCURL_* duplication is worth it.  What
do we want to gain from having a "central registry"?

If it is to see which ones we care about, would it be sufficient to
use the hits from "git grep -e CURL" with postprocessing?

Thanks.
