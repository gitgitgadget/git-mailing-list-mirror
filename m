Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAADFC433EF
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 21:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FEB760FC0
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 21:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbhJ2V6x (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 17:58:53 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56736 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbhJ2V6t (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 17:58:49 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4324816B812;
        Fri, 29 Oct 2021 17:56:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=HACOyeIZAuEo
        iFqcFzC9Xl0BuRTzu//e7eyYt7xKEtY=; b=n/xPakr36lkWBH5B5Olzo3y6jIkr
        YnKx7c4QZ1ep7Ajfny0DXlwdhmZ1tPBpHWdPw5y5unJGgHU72qq3w90XjHAvHfQe
        8g7OTWe3ujh8JJ11tjbjlNivAAtjMUL5x6FVPiibq43hCGhLxuTogyekSsNCcAhE
        QCIL7LxM83AfiGM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1EF1016B811;
        Fri, 29 Oct 2021 17:56:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CDF1416B810;
        Fri, 29 Oct 2021 17:56:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     rsbecker@nexbridge.com, Jeff King <peff@peff.net>,
        git@vger.kernel.org, avarab@gmail.com
Subject: Re: [PATCH] wrapper: remove xunsetenv()
References: <20211029212705.31721-1-carenas@gmail.com>
        <YXxpjLhiguq4HY6g@coredump.intra.peff.net>
        <014901d7cd0e$042a3470$0c7e9d50$@nexbridge.com>
        <CAPUEsphuqsxUmaH6wRWi_+HT+ukyRxfuPe6hKoJt9kc-GRxBjA@mail.gmail.com>
Date:   Fri, 29 Oct 2021 14:56:15 -0700
In-Reply-To: <CAPUEsphuqsxUmaH6wRWi_+HT+ukyRxfuPe6hKoJt9kc-GRxBjA@mail.gmail.com>
        (Carlo Arenas's message of "Fri, 29 Oct 2021 14:50:39 -0700")
Message-ID: <xmqqk0hvijgg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0AAF7F88-3903-11EC-8138-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Arenas <carenas@gmail.com> writes:

> On Fri, Oct 29, 2021 at 2:43 PM <rsbecker@nexbridge.com> wrote:
>>
>> On October 29, 2021 5:37 PM, Jeff King wrote:
>> > On Fri, Oct 29, 2021 at 02:27:05PM -0700, Carlo Marcelo Arenas Bel=C3=
=B3n wrote:
>> >
>> > > Remove the unused wrapper function.
>> >
>> > I don't mind removing this if nobody is using it, but doesn't your f=
irst paragraph
>> > argue that our definition of gitunsetenv() is just wrong?
>> > I.e., it should return an int, even if it is always "0"?
>
> I couldn't figure the intent Jason had when this code was added in
> 2006, but considering how Junio suggested using void for the wrapper,
> my guess is that we really wanted to make sure nobody will consider
> errors for that function as actionable.
>
>> > Or is it a portability question? I.e., are there platforms where
>> > unsetenv() also returns void, in which case we must make sure nobody=
 ever
>> > looks at its return value (and xunsetenv() is therefore a wrong dire=
ction)?
>>
>> At least on NonStop x86, it is
>>
>>        int unsetenv(const char *name);
>
> I don't think there is any platform that had anything but int, and so
> I agree with you that it would be much better if the compatibility
> layer returns 0, but as you pointed out, this was the safest approach
> considering we are 1 day after rc0 ;)

I do not plan to have *ANYTHING* I first see today in -rc0.  Not
even near 'next'.  No way.

Thanks.
