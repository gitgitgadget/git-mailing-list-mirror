Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A577AC433EF
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 20:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357331AbiALUGh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 15:06:37 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56549 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357550AbiALUGE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 15:06:04 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B231EFE501;
        Wed, 12 Jan 2022 15:06:03 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tzJ4P/GGu8qVT89yf/vCd5Z90798DHeTVA+Dr1
        m6WpM=; b=vGa9pX2PlEeWFdq8+Ev7sXsBSa9lDjzp4YMZIqTytWXaNytdulcshR
        g1sPjHsT+AUsx3o6/wqpUdX6nmvEp9yqoRn6sF/UUSrZ2lWunDIArPnxxA0XcVUK
        MQCFULiqvvMVILYXq/JLTbSSbTVbWOmqnwsi50l2EP7dQa+GEQN0o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 843E3FE500;
        Wed, 12 Jan 2022 15:06:03 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CF321FE4FF;
        Wed, 12 Jan 2022 15:06:02 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Marc Strapetz <marc.strapetz@syntevo.com>, git@vger.kernel.org
Subject: Re: [PATCH] packfile: avoid overflowing shift during decode
References: <20211110234033.3144165-1-jonathantanmy@google.com>
        <xmqqpmr7v4gf.fsf@gitster.g>
        <5ab9257c-9eba-a171-86d6-3fe7d3a4faec@syntevo.com>
Date:   Wed, 12 Jan 2022 12:06:01 -0800
In-Reply-To: <5ab9257c-9eba-a171-86d6-3fe7d3a4faec@syntevo.com> (Marc
        Strapetz's message of "Tue, 11 Jan 2022 00:22:04 +0100")
Message-ID: <xmqq8rvku3bq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 116B0EC6-73E3-11EC-BF4E-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Marc Strapetz <marc.strapetz@syntevo.com> writes:

> On 11/11/2021 02:58, Junio C Hamano wrote:
>> Jonathan Tan <jonathantanmy@google.com> writes:
>> 
>>> diff --git a/packfile.c b/packfile.c
>>> index 89402cfc69..972c327e29 100644
>>> --- a/packfile.c
>>> +++ b/packfile.c
>>> @@ -1068,7 +1068,7 @@ unsigned long unpack_object_header_buffer(const unsigned char *buf,
>>>   	size = c & 15;
>>>   	shift = 4;
>>>   	while (c & 0x80) {
>>> -		if (len <= used || bitsizeof(long) <= shift) {
>>> +		if (len <= used || (bitsizeof(long) - 7) <= shift) {
>
> This seems to cause troubles now for 32-bit systems (in my case Git
> for Windows 32-Bit): `shift` will go through 4, 11, 18 and for 25 it
> finally errors out. This means that objects >= 32MB can't be processed
> anymore. The condition should probably be changed to:
>
> +		if (len <= used || (bitsizeof(long) - 7) < shift) {
>
> This still ensures that the shift can never overflow and on 32-bit
> systems restores the maximum size of 4G with a final shift of 127<<25 
> (the old condition `bitsizeof(long) <= shift` was perfectly valid for
> 32-bit systems).

Jonathan?
