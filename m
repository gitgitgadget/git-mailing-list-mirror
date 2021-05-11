Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B135C433ED
	for <git@archiver.kernel.org>; Tue, 11 May 2021 06:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F24626134F
	for <git@archiver.kernel.org>; Tue, 11 May 2021 06:12:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbhEKGNP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 02:13:15 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58051 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbhEKGNO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 02:13:14 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3C205C0500;
        Tue, 11 May 2021 02:12:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xo+2TgkBWF2QnHfMmt3+DAAKGF3iZkpotR7QgB
        qaR4I=; b=HkZRRFcUqM6ItlZ5+51KzbH3Uw6rlOts0i/bR9AIvOOXHNKSif/WJC
        iAMzlR64u+rjAAFKAJlDK4wsZPK6ipOnOaoKMBxixYUCQ7pQluOjGzN0SDd5oKgt
        MsBe7733LaMZMzarowY1KzFY1sJFzzr37wiI39CcAn7rWVTyyDJLc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 339A1C04FF;
        Tue, 11 May 2021 02:12:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A3588C04FE;
        Tue, 11 May 2021 02:12:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Hariom Verma <hariom18599@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v2 2/2] [GSOC] ref-filter: introduce enum atom_type
References: <pull.951.git.1620487353.gitgitgadget@gmail.com>
        <pull.951.v2.git.1620659000.gitgitgadget@gmail.com>
        <a1f70b39b7efbadff9e2202968dd1ca65ea3c1b4.1620659000.git.gitgitgadget@gmail.com>
        <xmqqh7jaow31.fsf@gitster.g>
        <CAP8UFD3m0TA3nPDaPhaU3=FVF_r5cPM8xksVL6MpCOhNC4dT3g@mail.gmail.com>
Date:   Tue, 11 May 2021 15:12:07 +0900
In-Reply-To: <CAP8UFD3m0TA3nPDaPhaU3=FVF_r5cPM8xksVL6MpCOhNC4dT3g@mail.gmail.com>
        (Christian Couder's message of "Tue, 11 May 2021 07:51:44 +0200")
Message-ID: <xmqq7dk5ol3c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D0826CAE-B21F-11EB-85A4-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

>> I find it far more intuitive to say
>>
>>         for (i = 0; i < ATOM_INVALID; i++)
>>
>> than having to say UNKNOWN+1.
>
> Yeah, that's more intuitive. But in my opinion, using `ATOM_UNKNOWN +
> 1` instead of `0` at least shouldn't often result in more lines of
> code, and should be a bit easier to get right, compared to having to
> initialize the field with ATOM_UNKNOWN.

Number of lines is not all that important.

But the developers must remember that UNKNOWN is at the bottom end
and INVALID is at the top end, which is very taxing.  Tying UNKNOWN
to the top end and INVALID to the bottom end would equally be
plausible and there is no memory aid to help us remember which one
is which.  Compare it to "array indices begin at 0, and the upper
end is MAX".  Your scheme is much easier for developers to screw up.

