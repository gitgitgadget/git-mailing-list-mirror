Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31909C433E0
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 20:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F02DC23A34
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 20:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbhANUyJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 15:54:09 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58639 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbhANUyH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 15:54:07 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5185B10FC60;
        Thu, 14 Jan 2021 15:53:25 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WACGWP+t4MeO2IYsOu0siLUAmQQ=; b=f6RRMC
        fq9vXQT2cCoQCQG2YPa+vCt4Qq6MzMhrpt8ypKzePZT1HJs30WeQAyVJGhJI2sAG
        QFNiA3VxAlWjpzDuTpZL+HZczy+NxKAEhTo9hO+H6rY5XkqnaxbwHf/E95NXJQ23
        TdAcRnF7hSW2CUWwajW0PomspEidImFnDqtos=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CrKyCG5uSYY1oZa4YP2MOXDsAE65u0US
        PDChMrun/CSYEbbN6rkjSxEWC10ktEnHo0WN++tv8nx+WslzKikZzSR0aLp+0V5E
        ZRlPEq03DVDegFhXqrg7uvkesYQTRZpSMA90O3QPUe82oGGBX2im/oqXUUiNuB8w
        KuCA+RlvoZc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4973A10FC5F;
        Thu, 14 Jan 2021 15:53:25 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3F0C410FC5E;
        Thu, 14 Jan 2021 15:53:21 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com, jrnieder@gmail.com
Subject: Re: [PATCH v2 00/20] pack-revindex: prepare for on-disk reverse index
References: <cover.1610129796.git.me@ttaylorr.com>
        <cover.1610576604.git.me@ttaylorr.com>
        <YACgyn029KBps/yx@coredump.intra.peff.net>
Date:   Thu, 14 Jan 2021 12:53:19 -0800
In-Reply-To: <YACgyn029KBps/yx@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 14 Jan 2021 14:51:38 -0500")
Message-ID: <xmqqr1mnw88w.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 894AACD2-56AA-11EB-9ED5-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Jan 13, 2021 at 05:23:25PM -0500, Taylor Blau wrote:
>
>> In this revision, I addressed feedback from Junio, Peff, and Stolee. A
>> range-diff is included below, but the main changes are:
>> 
>>   - Error messages are improved to include the pack and offset when applicable.
>>   - Variable names were made clearer (e.g., n -> index_pos).
>>   - Comments were added in pack-revindex.h to introduce relevant terminology,
>>     and which methods convert between what orderings.
>>   - int-sized lower- and upper-bounds were converted to be unsigned.
>
> Thanks, this addresses all of my nits. I responded to a few of Junio's
> reviews with some further comments/suggestions; the most interesting one
> is using "index_pos" to indicate the ordering more clearly in patch 15.
> I'm happy with or without including that.

I think it is better to leave it for future "clean-up" outside the
series, to be done after the series hits a released version.

