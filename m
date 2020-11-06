Return-Path: <SRS0=eTRQ=EM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7728AC2D0A3
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 19:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EBEB20715
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 19:30:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kvITyhIZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbgKFTaW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Nov 2020 14:30:22 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56661 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbgKFTaV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Nov 2020 14:30:21 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1ADBA101E2B;
        Fri,  6 Nov 2020 14:30:20 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hMAUDHpzwbDiIec5u29HkVDGBpo=; b=kvITyh
        IZhulgdOOMzSKA+psgPfULfVw8N/uHUbEhBF23P3q6UUf2aARK98bBW+2+Lesk7L
        Q7GyvOok15ufg4sbKguzSFG9oAcxjXYBieQbBXRF9/7AtbU6N8LYzkk8wb273X6W
        UynCQ4q2W1Q6Yg0b+ljJk9IJsX6rFdeObOisw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VvC9EafYarnFNQuVFOjIyW9qhbXMxSvB
        jIznPMnxcFhZFSdoY4dnXqtiEcoDVG97rjwGJzqhj0K3ssu3dqralwmquAS8P8IX
        4EG0z4uvZdSGhdUlkMIblqoK27zrvVlUBNGHn5xCu8+s2dP9fBQCr2ShMdDQBl/S
        y3AiEuR4+AY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 13D8D101E2A;
        Fri,  6 Nov 2020 14:30:20 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 55D5B101E28;
        Fri,  6 Nov 2020 14:30:17 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] update-ref: Allow creation of multiple transactions
References: <cover.1604501265.git.ps@pks.im>
        <eec7c2e8ec3e49b34066190d59fc45276bed637f.1604501265.git.ps@pks.im>
        <20201105192901.GA121650@coredump.intra.peff.net>
        <xmqqa6vvij37.fsf@gitster.c.googlers.com>
        <20201106175241.GA182486@coredump.intra.peff.net>
Date:   Fri, 06 Nov 2020 11:30:14 -0800
In-Reply-To: <20201106175241.GA182486@coredump.intra.peff.net> (Jeff King's
        message of "Fri, 6 Nov 2020 12:52:41 -0500")
Message-ID: <xmqqeel6ffll.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 802653E2-2066-11EB-A365-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Nov 05, 2020 at 01:34:20PM -0800, Junio C Hamano wrote:
>
>> > The tests all look quite reasonable to me. Touching .git/refs like this
>> > is a bit gross (and something we may have to deal with if we introduce
>> > reftables, etc). But it's pretty pervasive in this file, so matching
>> > the existing style is the best option for now.
>>  ...
> Yeah, I agree completely that we could be using rev-parse in this
> instance. But it's definitely not alone there:
> ...

Yup, this morning I was reviewing what we said in the previous day's
exchanges and noticed that you weren't advocating but merely saying
it is not making things worse, and I agree with the assessment.

Perhaps two #leftoverbits are to 

 (1) clean up this test to create refs using "update-ref", and
     verify refs using "show-ref --verify".

 (2) If (1) had to leave some direct filesystem access due to the
     built-in safety that cannot be circumvented, decide which is
     more appropirate between a test-update-ref test helper only to
     be used in tests, or a "--force" option usable to corrupt
     repositories with "update-ref", implement it, and use it to
     finish cleaning up tests.

Thanks.





