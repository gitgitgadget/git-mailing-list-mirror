Return-Path: <SRS0=xf+W=CL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E42C7C433E2
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 19:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0D95207EA
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 19:19:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="sl/pygoh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbgIBTTn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Sep 2020 15:19:43 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62132 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgIBTTm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Sep 2020 15:19:42 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 12A036A880;
        Wed,  2 Sep 2020 15:19:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PFA5ku+6vE8hpmYuMhM6KL70FUw=; b=sl/pyg
        oh4GZkxuihTq43rLSVzWZe4xppL11xsZfM40H8aqXo6XwExjY64eS7fW7f4pZoLd
        yfMEUzbGfNM5Hga/B3AJoeTuxzgZJX/W4hhlFWVQZqeoaWFnmDIwl1f95M40GViE
        LcWhM/UpuRatvMwvKLpkEIkEpaMstPs9mpSTA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PSHabV/z4OOV5E22eFGB1bf1NLKLmQW9
        /JMGoY9ZY52Ulv0jcTnzyZXA78vFYk3+2ZvYv9Kb8HJDeUfF3ySVW2tgOr/MQit5
        kM8m31GwHD1SkkPaWBBGV2YPmGsX3eADvYXonvW85Z4psMTuIjRCvLJC27i6BoYX
        yBIe/r1Ls5Y=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 094C06A87F;
        Wed,  2 Sep 2020 15:19:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 88A516A87E;
        Wed,  2 Sep 2020 15:19:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] xrealloc: do not reuse pointer freed by zero-length realloc()
References: <20200901111800.GA3115584@coredump.intra.peff.net>
        <c81b7225-a663-1598-62b3-bd80457d5648@gmail.com>
        <20200901135105.GA3284077@coredump.intra.peff.net>
        <xmqq3641ebep.fsf@gitster.c.googlers.com>
        <20200902075439.GA855335@coredump.intra.peff.net>
Date:   Wed, 02 Sep 2020 12:19:38 -0700
In-Reply-To: <20200902075439.GA855335@coredump.intra.peff.net> (Jeff King's
        message of "Wed, 2 Sep 2020 03:54:39 -0400")
Message-ID: <xmqqo8moasvp.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3F2505FC-ED51-11EA-9C21-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> There are other variants, too:
>
>   - we could use malloc(1) versus xmalloc(0). Maybe more
>     readable/obvious? But also potentially allocates an extra byte when
>     the platform malloc(0) would not need to.
>
>   - we could return a non-NULL "ptr" without shrinking it at all (nor
>     allocating anything new). This is perfectly legal, and the
>     underlying realloc() would still know the original size if anybody
>     ever asked to grow it back again.
>
> I have to admit I don't overly care between them.

I don't either.  I admit that the latter I didn't think of---it
feels tricky and harder to reason about than any other variants.

> I suspect one of the
> reasons we never ran into this 15-year-old bug is that it's quite hard
> to convince Git to call realloc(0) in the first place. I only saw it
> when investigating a bug in another series, and there the problem turned
> out to be reading garbage bytes off the end of a buffer (which we
> interpreted as a serialized ewah bitmap which happened to have a zero in
> its length byte).

Thanks.

