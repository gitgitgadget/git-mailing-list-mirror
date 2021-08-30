Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B172C432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 00:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB34060F4C
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 00:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235991AbhH3ALV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Aug 2021 20:11:21 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58442 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbhH3ALV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Aug 2021 20:11:21 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E6130DF878;
        Sun, 29 Aug 2021 20:10:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TlQbfZYZTvv0/jZegYNs0ouYC/v70R1cVnqQx/
        VlJpA=; b=QqtH9YLnBIi7lNKGg8m1JCWJ1sDHN20al3/PhhtENNzLXyY3x2qK/C
        KmF/glsJYGkSJVz8jrwm2hyhJxLf0XaMpTcSRJfAvYyWtE/UpEHkNE1Fg0Lt0PtP
        PNzxfvVPjpIdgVOgVGzifRPo71rYJPy/c53VtTnHQ5u0ku4F5ifbU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DE33EDF877;
        Sun, 29 Aug 2021 20:10:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 604E2DF876;
        Sun, 29 Aug 2021 20:10:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] merge-recursive: use fspathcmp() in path_hashmap_cmp()
References: <512abaef-d71c-9308-6a62-f37b4de69e60@web.de>
        <YSvsQcGNpCMZwS8o@nand.local>
        <YSv1XZJvYdYj1JtP@coredump.intra.peff.net>
Date:   Sun, 29 Aug 2021 17:10:25 -0700
In-Reply-To: <YSv1XZJvYdYj1JtP@coredump.intra.peff.net> (Jeff King's message
        of "Sun, 29 Aug 2021 17:00:13 -0400")
Message-ID: <xmqqo89f7pxq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AD6516C8-0926-11EC-8C39-ECFD1DBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> -       if (ignore_case)
>> -               return strcasecmp(e1->key, key ? key : e2->key);
>> -       else
>> -               return strcmp(e1->key, key ? key : e2->key);
>> +       return fspathcmp(e1->key, key ? key : e2->key);
>>  }
>> 
>>  static struct test_entry *alloc_test_entry(unsigned int hash,
>
> Maybe also:
>
> diff --git a/dir.c b/dir.c
> index 03c4d21267..ee46290cbb 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -669,9 +669,7 @@ int pl_hashmap_cmp(const void *unused_cmp_data,
>  			 ? ee1->patternlen
>  			 : ee2->patternlen;
>  
> -	if (ignore_case)
> -		return strncasecmp(ee1->pattern, ee2->pattern, min_len);
> -	return strncmp(ee1->pattern, ee2->pattern, min_len);
> +	return fspathncmp(ee1->pattern, ee2->pattern, min_len);
>  }
>  
>  static char *dup_and_filter_pattern(const char *pattern)
>
> This is fun. :)

Yes.

So we found three of them in the existing code.  A Coccinelle rule
may be an overkill, I guess.
