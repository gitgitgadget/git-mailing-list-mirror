Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6173CC4338F
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 17:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D22C6115C
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 17:43:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234121AbhHTRnx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 13:43:53 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51061 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbhHTRnw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Aug 2021 13:43:52 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D4823E7045;
        Fri, 20 Aug 2021 13:43:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mr+OUL1r9hS6UFlX/zi0E3MuLKIagk3UZD757u
        dEAMQ=; b=VNtOyxhRd6vJwwPGbHHQ3Cf+B/orI8fHhQr3xyvV+eXNnapm724fz3
        KYxYFBoMwpHlhNeAiKv5/o/8eEETvi0nbErxT1kISRlR05phaeQj1kz+ADdbghmi
        J1O2SoTejiA8Xv04wL06z5e4SFutsSxrwGpduB5y8BT1PdV/pcBtw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CCAD2E7044;
        Fri, 20 Aug 2021 13:43:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5FF69E7043;
        Fri, 20 Aug 2021 13:43:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 3/6] connected: refactor iterator to return next object
 ID directly
References: <cover.1629452412.git.ps@pks.im>
        <3bdad7bc8b0debd44138a4d3df5744d5a245475d.1629452412.git.ps@pks.im>
        <ffb5da19-937e-fba6-10f8-3993ca5ff0ef@gmail.com>
Date:   Fri, 20 Aug 2021 10:43:12 -0700
In-Reply-To: <ffb5da19-937e-fba6-10f8-3993ca5ff0ef@gmail.com> (Derrick
        Stolee's message of "Fri, 20 Aug 2021 10:32:32 -0400")
Message-ID: <xmqqmtpcui4v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 17BA3788-01DE-11EC-8F7F-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 8/20/2021 6:08 AM, Patrick Steinhardt wrote:
>> The object ID iterator used by the connectivity checks returns the next
>> object ID via an out-parameter and then uses a return code to indicate
>> whether an item was found. This is a bit roundabout: instead of a
>> separate error code, we can just retrun the next object ID directly and
>> use `NULL` pointers as indicator that the iterator got no items left.
>> Furthermore, this avoids a copy of the object ID.
>> 
>> Refactor the iterator and all its implementations to return object IDs
>> directly. While I was honestly hoping for a small speedup given that we
>> can now avoid a copy, both versions perform the same. Still, the end
>> result is easier to understand and thus it makes sense to keep this
>> refactoring regardless.
>
> It's too bad about the lack of measurable performance gains, but the
> new code _is_ doing less, it's just not enough.
>
> I agree that the new code organization is better.

The only potential downside I can think of is the loss of ability to
convey the reason why it failed to return one by adding new return
codes from the function, which I do not immediately see all that
useful future extension anyway, so I agree that "we find what we
found, or NULL if we don't find" is much straight-forward and easier
to understand.

Nicely done.

Thanks.
