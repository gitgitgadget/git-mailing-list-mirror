Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C5CC433E0
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 18:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D89D64EA0
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 18:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbhBAS05 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 13:26:57 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55200 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232838AbhBAS0s (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 13:26:48 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4668891BCB;
        Mon,  1 Feb 2021 13:26:05 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FT2CeYMWrMJPat3r2YXQncCPmTE=; b=rq1rEV
        esuAAWl3fr7PqTELm7LAD2QGALe8BOCch+2DphhDpGvfq+NqAdvoqj2s/+LMB2Tx
        jOiTfez1gkHS1VWY/WKSfpXN7mYvUfFb9/gXxHAUnZdvFkpxR0/5kWcCTFn8/4VV
        ANGGzrH53v2Mt6g+xGtkZaq5/q8wgUZ6F66/o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sTaqp0VDLL9cYtLQyY+2u4HTQlHoMS9f
        kiZ97sQPZOuKdph7kBbNo4gRlZ9sdanDw1KED3dKb1HfZLabF0bVIrNq+x/hjLsc
        1G+PYuikEFz6V4WAFdNMvG9p06d5Me3SahvsVvxYfHbBiG/33Z8HsEpgHEBLEUua
        +ogwLGaPbFg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3437A91BCA;
        Mon,  1 Feb 2021 13:26:05 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 787F691BC9;
        Mon,  1 Feb 2021 13:26:04 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Abhishek Kumar via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v7 00/11] [GSoC] Implement Corrected Commit Date
References: <pull.676.v6.git.1610820679.gitgitgadget@gmail.com>
        <pull.676.v7.git.1612162726.gitgitgadget@gmail.com>
        <3c48f860-e743-afbe-63e8-99804036a965@gmail.com>
Date:   Mon, 01 Feb 2021 10:26:03 -0800
In-Reply-To: <3c48f860-e743-afbe-63e8-99804036a965@gmail.com> (Derrick
        Stolee's message of "Mon, 1 Feb 2021 08:14:34 -0500")
Message-ID: <xmqq7dnrmypw.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F19F2CB8-64BA-11EB-84E0-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

>>      +    When adding new layer to the split commit-graph file, and when merging
>>      +    some or all layers (replacing them in the latter case), the new layer
>>      +    will have GDAT chunk if and only if in the final result there would be
>>      +    no layer without GDAT chunk just below it.
>
> While that is a quality message, v6 has landed in 'next' and I've begun
> working off of that version. As Taylor attempted to say [1], this topic
> should be considered final and updates should be follow-ups on top.
>
> [1] https://lore.kernel.org/git/YBYLwpKdUfxCNwaz@nand.local/

Sounds sensible, modulo s/final/solid enough/ ;-)

I would imagine that the "quality message" has something of value to
keep to help future developers, and if that is the case, a follow-up
patch to add to the Documentation/technical/ would be appropriate.

Thanks all, for a quality series.
