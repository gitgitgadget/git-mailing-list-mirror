Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0DC4C433DB
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 03:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DAD9235F7
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 03:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbhAWDAR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jan 2021 22:00:17 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53927 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbhAWDAQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jan 2021 22:00:16 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 897E51122DA;
        Fri, 22 Jan 2021 21:59:34 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9D/BF1UT+/hO5ol9fBzm9zDnKd4=; b=C1eK4Y
        f5ds5tkbr2MA0LhlUWqwEuLx+c6uaqicULRT//BWYkJMC9MgQaShtrF5dQ8hnn9z
        H3LFM4FC2Nec9NQkdY7PO2i7mXahwuZsMxxgnUFbPIJJWHx0xupda9LwrOCMJE2l
        UaGv3GDtAQhwmAot7DoFtkkAxSqXcw9FYYk7Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZABvfeT38GTFWHj5XGrcysyxg7BD4NVh
        76/QMKmh/JjV9KL3uhFQusLUSx98UjF8Mj3Wce4FQfakrFbLV+3TsiGPsgi02wZP
        0EYSRuP8t5QQZnRwlibOTJUF2q20P5eZf8UbVoFJUmNMbZc4XFHE2TFrNku+VxEA
        7VOHa6znCsI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 80D0C1122D8;
        Fri, 22 Jan 2021 21:59:34 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CE46A1122D7;
        Fri, 22 Jan 2021 21:59:31 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, jacob@gitlab.com, peff@peff.net
Subject: Re: [PATCH v2 1/3] refs: expose 'for_each_fullref_in_prefixes'
References: <cover.1611080326.git.me@ttaylorr.com>
        <cover.1611158549.git.me@ttaylorr.com>
        <bda314fe7ae1629ba068a0c4ada9b6adc20576eb.1611158549.git.me@ttaylorr.com>
Date:   Fri, 22 Jan 2021 18:59:30 -0800
In-Reply-To: <bda314fe7ae1629ba068a0c4ada9b6adc20576eb.1611158549.git.me@ttaylorr.com>
        (Taylor Blau's message of "Wed, 20 Jan 2021 11:04:21 -0500")
Message-ID: <xmqqczxw5pf1.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 04162874-5D27-11EB-BB1F-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> This function was used in the ref-filter.c code to find the longest
> common prefix of among a set of refspecs, and then to iterate all of the
> references that descend from that prefix.
>
> A future patch will want to use that same code from ls-refs.c, so
> prepare by exposing and moving it to refs.c. Since there is nothing
> specific to the ref-filter code here (other than that it was previously
> the only caller of this function), this really belongs in the more
> generic refs.h header.
>
> The code moved in this patch is identical before and after, with the one
> exception of renaming some arguments to be consistent with other
> functions exposed in refs.h.
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  ref-filter.c | 74 ++------------------------------------------
>  refs.c       | 87 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  refs.h       |  9 ++++++
>  3 files changed, 98 insertions(+), 72 deletions(-)

It is amusing that even to a change that is supposedly "expose
existing functionality by moving code around" and nothing else,
we can introduce new glitches.

> diff --git a/refs.c b/refs.c
> index 13dc2c3291..0b5a68588f 100644
> --- a/refs.c
> +++ b/refs.c
> ...
> +	for_each_string_list_item(prefix, &prefixes) {
> +		strbuf_addf(&buf, "%s", prefix->string);

		strbuf_addstr(&buf, prefix->string);

Caught by

https://github.com/git/git/runs/1752536671?check_suite_focus=true#step:4:63

I'll apply the fix suggested by Coccinelle on my end, so there is no
need to send an updated version just for this one.

Thanks.
