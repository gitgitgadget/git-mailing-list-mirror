Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4461EC433EF
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 19:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1523260F48
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 19:10:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237157AbhIVTMR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 15:12:17 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58760 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236431AbhIVTMQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 15:12:16 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5D7B4FE36B;
        Wed, 22 Sep 2021 15:10:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1j41EmgDsMX2oApInTdZQevKAtRawfLMKTbTOe
        3jEUw=; b=QAdXNnbAXyCu2hVxIobNhgNDEgS6b4k+QUYO+OqzKZS9KHG6W4niYm
        bg9S4+mJv6G0vdNmxj/3kzJ09S9hz93dKwwPHLpajgZn3g2Bc4kfDFLa4RWVEpyo
        cS7wLT0wvr+cuiZXEhqq9a55omx+cAUdMuuOqtNvfhg5vKjo9od8A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 548BEFE36A;
        Wed, 22 Sep 2021 15:10:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B3DF5FE369;
        Wed, 22 Sep 2021 15:10:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Daniel Stenberg <daniel@haxx.se>
Subject: Re: [PATCH] http: match headers case-insensitively when redacting
References: <YUonS1uoZlZEt+Yd@coredump.intra.peff.net>
        <CAPig+cS6DZ5DtSpvdrjjQVs5f=pCKkNwaGxU558Qvt50mi9z-A@mail.gmail.com>
        <YUovLNjkFilkcTAU@coredump.intra.peff.net>
Date:   Wed, 22 Sep 2021 12:10:44 -0700
In-Reply-To: <YUovLNjkFilkcTAU@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 21 Sep 2021 15:14:52 -0400")
Message-ID: <xmqqczp077ez.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CA006A66-1BD8-11EC-AFDF-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Sep 21, 2021 at 03:06:20PM -0400, Eric Sunshine wrote:
>
>> On Tue, Sep 21, 2021 at 2:41 PM Jeff King <peff@peff.net> wrote:
>> > When HTTP/2 is in use, we fail to correctly redact "Authorization" (and
>> > other) headers in our GIT_TRACE_CURL output.
>> >
>> > We get the headers in our CURLOPT_DEBUGFUNCTION callback, curl_trace().
>> > It passes them along to curl_dump_header(), which in turn checks
>> > redact_sensitive_header(). We see the headers as a text buffer like:
>> >
>> >   Host: ...
>> >   Authorization: Basic ...
>> >
>> > After breaking it into lines, we match each header using skip_prefix().
>> > This is case-insensitive, even though HTTP headers are case-insensitive.
>> > This has worked reliably in the past because these headers are generated
>> > by curl itself, which is predictable in what it sends.
>> 
>> Did you mean "This is case-sensitive..."?
>
> Whoops, yes. It probably makes a lot more sense with that fix. :)

Yeah, I was wondering about the same thing when I read it the first
time.
