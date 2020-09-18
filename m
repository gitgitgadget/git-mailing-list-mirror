Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65818C43463
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 17:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B0E121534
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 17:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ATRr5P7b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgIRRB2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Sep 2020 13:01:28 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51490 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbgIRRB0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Sep 2020 13:01:26 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C230E71A9B;
        Fri, 18 Sep 2020 13:01:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MF3MhLiKKBW0DepxdQD1nI5i24Q=; b=ATRr5P
        7bpbmF7d5edyIdyt7zbgGx4shSYdvWq09IU3bmQbwhcNVexJX3nD0YaaHC7ZduvG
        X403gPTcIfMmIw2wzmzgBz0L7CwxL64zP0i90Qvgu79sxacyJx3xW/GZxwV/V/zK
        pdXMZETD6ItdPDfktVHOCB5AhDtVzVJJWpA3o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=oRmGRPe5kK1sWEiNHuActDmlYHKgrAgh
        uxwCwR26q8s2glnQ1vlbGo9ITfFv1P2NPNhk6Gpxe61YavSRbEIRxkF9u7ovX2yg
        wT1ScqSpVAdnQXVxQSq9fRwR2pH7k2OrjEHpheRZE7UJ9wSK9Kjm0mrBHrsJSZCA
        iQOQ9cudZGo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B76FF71A9A;
        Fri, 18 Sep 2020 13:01:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.190.152.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4239D71A99;
        Fri, 18 Sep 2020 13:01:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Aaron Lipman <alipman88@gmail.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] ref-filter: refactor do_merge_filter()
References: <20200916020840.84892-1-alipman88@gmail.com>
        <20200918004909.32474-1-alipman88@gmail.com>
        <20200918004909.32474-2-alipman88@gmail.com>
        <CAPig+cRXJ5hCEM0dFsSSnGWaYu76gPhpM3fV4FaV+Db4r6dX4g@mail.gmail.com>
Date:   Fri, 18 Sep 2020 10:01:22 -0700
In-Reply-To: <CAPig+cRXJ5hCEM0dFsSSnGWaYu76gPhpM3fV4FaV+Db4r6dX4g@mail.gmail.com>
        (Eric Sunshine's message of "Fri, 18 Sep 2020 01:03:00 -0400")
Message-ID: <xmqqtuvvm331.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 95604090-F9D0-11EA-84F4-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> One thing that this commit message lacks is a high-level explanation
> of why these changes are being made. One possible rewrite would be:
>
>     ref-filter: make internal reachable-filter API more precise
>
>     The internal reachable-filter API is a bit loose and imprecise; it
>     also bleeds unnecessarily into the public header. Tighten the API
>     by:
>
>     * renaming do_merge_filter() to reach_filter()
>
>     * separating parameters to explicitly identify what data is used
>       by the function instead of passing an entire ref_filter_cbdata
>       struct
>
>     * renaming and moving internal constants from header to source
>       file

Sounds good.  Aaron?

>> +static void reach_filter(struct ref_array *array,
>> +                        struct commit_list *check_reachable,
>> +                        int include_reached)
>>  {
>>         [...]
>> +       if (!check_reachable)
>>                 return;
>
> I would probably drop this conditional return altogether ...

As you said downthread, this part is fine as-is.
