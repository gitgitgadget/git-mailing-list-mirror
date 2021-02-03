Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01455C433E6
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 18:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B686A64DE1
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 18:47:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbhBCSrV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 13:47:21 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51682 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbhBCSrT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 13:47:19 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E8CD310BB54;
        Wed,  3 Feb 2021 13:46:36 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=umhl3uyX4kCObpahBgw+D8IbqIo=; b=yY6bkl
        h3LroOb2ViU4k3Xo26EUsvt041FgDp+IHDrKj1pMqXxNdnNv+UKppccUlJNAnCmR
        VdlKfzLOsf/gJIiIkO8Y2E8Tv6xYK2WNv41mVau5WWZAVlljQj5slBxU70gMv4yF
        9Jaqxt+EGsf2bv8eHG/Af6kDKio83oe7QqN1g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ngnAWxW+Z6F/aVvYxCBd0G70bVS8tCGW
        XqWHS3OOFbKqlRtyli48Gb5LjtTGHsTbwwPvgR06diSrLomlFNds/4f7GI0/cai4
        IM31hG90S7IeFaThQ1jjxJNYydxDSGEgaj1gMAyZIxnOXzjoxW+w1s6oTMUuUzeh
        Uzm9P8l9UcA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E08A410BB53;
        Wed,  3 Feb 2021 13:46:36 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 363BD10BB50;
        Wed,  3 Feb 2021 13:46:34 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Karsten Blees <blees@dcon.de>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/2] diffcore-rename: no point trying to find a match
 better than exact
References: <pull.842.git.1612331345.gitgitgadget@gmail.com>
        <3e69857f37e12540f7986245b99916b68702217a.1612331345.git.gitgitgadget@gmail.com>
        <515f55bd-90e2-9a7f-0973-501c9351969e@gmail.com>
Date:   Wed, 03 Feb 2021 10:46:32 -0800
In-Reply-To: <515f55bd-90e2-9a7f-0973-501c9351969e@gmail.com> (Derrick
        Stolee's message of "Wed, 3 Feb 2021 06:44:50 -0500")
Message-ID: <xmqqft2dc7lj.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 23687060-6650-11EB-8606-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

>>  	/* All done? */
>> -	if (!num_destinations)
>> +	if (!num_destinations || !num_sources)
>>  		goto cleanup;
>
> And add an extra quit condition which is very possible to hit.
> Is it only hit when every "delete" is actually a rename?

When every delete is actually an unmodified exact rename, I think.
If this simple change gives us good performance gain, that is
superb.

Nicely done.
