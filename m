Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 819071F461
	for <e@80x24.org>; Mon, 13 May 2019 05:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbfEMF5u (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 01:57:50 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52597 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbfEMF5u (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 May 2019 01:57:50 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EB14515676C;
        Mon, 13 May 2019 01:57:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Y52SNBQv3H7gnHEksoAqoyWLZoY=; b=Wf8ZnK
        ZplzsniJOR7juryzlCrH/+IGlUDkivpnjNectmzxPZgBI72sGWecdxyDjxOmTzxX
        PQAWzQsuYUaKyP/GtTlCAIb88yrrHgc8MBFVkyw18etJ63RSqD/lvAph06SCae3g
        S9jU8na5Bj1kZkJkwfRrMVlkE28AZ7LVckSLs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=W9lLkDqQnsQkXElwdAlTD1Rr9TaKZ56A
        OrllTR6AdtMGNR9D9e5Sy1Wi9PpqHYSpd42GtUAnpnAHtZd6vllH4b/7mm+dZDB8
        lgFIUsVzsNt+fc7LnnbrIQAd77YHwK1cNi6OhyuTUDITahtnOWLtq2VlNejCxz2A
        VKmHCxNapSY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D1E6715676B;
        Mon, 13 May 2019 01:57:47 -0400 (EDT)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 293F115676A;
        Mon, 13 May 2019 01:57:47 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
        Git List <git@vger.kernel.org>, nickh@reactrix.com
Subject: Re: [PATCH] http-push: workaround for format overflow warning in gcc >= 9
References: <20190510065848.27606-1-carenas@gmail.com>
        <CAPig+cSY4SKXcppM6UYpeJ3z+PrUwiJ=whCmHQv4e_3CUZSwoQ@mail.gmail.com>
Date:   Mon, 13 May 2019 14:57:46 +0900
In-Reply-To: <CAPig+cSY4SKXcppM6UYpeJ3z+PrUwiJ=whCmHQv4e_3CUZSwoQ@mail.gmail.com>
        (Eric Sunshine's message of "Fri, 10 May 2019 03:50:32 -0400")
Message-ID: <xmqqa7fqdhgl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 087810C0-7544-11E9-AE6E-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

>>                 if (request->curl_result != CURLE_OK) {
>>                         fprintf(stderr, "Unable to get pack file %s\n%s",
>> -                               request->url, curl_errorstr);
>> +                               request->url ? request->url : "",
>> +                               curl_errorstr);
>>                 } else {
>
> If I'm reading the code correctly, the conditional and "true" branch
> of the ternary expression are dead code since 'request->url' will
> unconditionally be NULL due to the:
>
>     /* URL is reused for MOVE after PUT */
>     if (request->state != RUN_PUT) {
>         FREE_AND_NULL(request->url);
>     }
>
> earlier in the function. If you want to present a meaningful error
> message here, I could imagine squirreling-away the URL so it can be
> used in the error message, or re-working the code so that
> FREE_AND_NULL(request->url) is only done when and if needed.

That matches my understanding.
