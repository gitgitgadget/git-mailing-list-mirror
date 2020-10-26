Return-Path: <SRS0=PD7l=EB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD875C4363A
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 18:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A9852087C
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 18:13:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cdEUedYj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1789280AbgJZSNl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 14:13:41 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55715 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1789277AbgJZSNl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Oct 2020 14:13:41 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5F78910C6EB;
        Mon, 26 Oct 2020 14:13:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=//sHC4i89jswermBb0aj2XUYlJc=; b=cdEUed
        YjScOHGmIu8ymJujs0Xo4bFIVtuzzXmFYkA6wjyA7XpduNdxqpvFgHVZsmVBIIua
        E++5TWQhEUMwHnbKPh5+QecOiPMaPBpQr68hNwUv4UIGmv/NWR4xaVeDfTk9wwXQ
        EqXu1iMaSX9E+ymojPoO0b6vmVzg7KoG7OQvI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EhRrbICA/gnB7rQM9AX6vO2Kzn9QD1Xs
        IVDXwmzXVthE+CSmP/pnqucGj8E7rApBLaNdHwLyj7N0rqL+jNzmTbvWJ4cPZcZJ
        fQaslnNjWBli26GexuqERJ//BTluNxOGGBZgEOtPYL/0pF6leWgkzyATx8yCwDVI
        hATG0x8rEbM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5951D10C6EA;
        Mon, 26 Oct 2020 14:13:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7183A10C6E9;
        Mon, 26 Oct 2020 14:13:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Manuel =?utf-8?Q?B?= =?utf-8?Q?=C3=A4renz?= 
        <manuel@enigmage.de>, git <git@vger.kernel.org>
Subject: Re: Feature request: Exponential search in git bisect
References: <945ab20e-dcde-540e-83a5-83992c2187b1@enigmage.de>
        <CAP8UFD2dWrUXJUuiFtgCu6krbnbGGqJZ7K+6KqstGTcNmSc_xQ@mail.gmail.com>
        <b1adedaa-5809-9ea1-f664-3a7cabaf0d14@iee.email>
Date:   Mon, 26 Oct 2020 11:13:34 -0700
In-Reply-To: <b1adedaa-5809-9ea1-f664-3a7cabaf0d14@iee.email> (Philip Oakley's
        message of "Sun, 25 Oct 2020 17:15:20 +0000")
Message-ID: <xmqqpn54etyp.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F7435848-17B6-11EB-A145-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> writes:

>> Ok, but the conclusion of the above discussion is that the problem
>> with this idea is being able to distinguish between a commit that is
>> bad and a commit where the feature that you want to test cannot be
>> tested for example because it hasn't been implemented yet.
>
> Does any of the proposed improvement in the "bisect: loosen halfway()
> check for a large number of commits"
> https://lore.kernel.org/git/20201022103806.26680-1-szeder.dev@gmail.com/
> assist in this.

I doubt it.  

If you cannot say if a rev is testable or not, it would not help you
much if Git asked "is this good, bad or untestable?" question 5
times faster, I suspect.


