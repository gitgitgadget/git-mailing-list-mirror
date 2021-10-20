Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02556C433EF
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 19:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEB0D611CB
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 19:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbhJTTVk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Oct 2021 15:21:40 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58941 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbhJTTVi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Oct 2021 15:21:38 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A264D15F2D5;
        Wed, 20 Oct 2021 15:19:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tSla/EGSbWzWBlAMpFWZjNGLa+Us6lfYFqFjkL
        MlK/E=; b=Nrb6LE/E/TBBp0UMhHCKy2o9QoaBFuGt5+2KNeGjUqB1aUZvimGNXq
        KqvReNWChWrUS46ryOcFF+q5VcfnThAaKkbJRoPFWRbmSIpMtFZmzjI3CpEuHiz2
        IwHb1g4BIfchgCoxVG7vG5HR2F6YG5aHoct9VrrWvfM7Zz76LRUmw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9A37215F2D3;
        Wed, 20 Oct 2021 15:19:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 077DF15F2D1;
        Wed, 20 Oct 2021 15:19:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Kenneth Arnold <ka37@calvin.edu>,
        Alex Henrie <alexhenrie24@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: "Not possible to fast-forward" when pull.ff=only and new
 commits on remote
References: <CH2PR06MB650424B4205102AC6A48F489B1BD9@CH2PR06MB6504.namprd06.prod.outlook.com>
        <YW83JG9t2JaX92xV@coredump.intra.peff.net>
        <xmqqzgr3pso7.fsf@gitster.g>
        <YXBNY7/mWyxvAo/r@coredump.intra.peff.net>
Date:   Wed, 20 Oct 2021 12:19:19 -0700
In-Reply-To: <YXBNY7/mWyxvAo/r@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 20 Oct 2021 13:09:55 -0400")
Message-ID: <xmqqa6j3pkqw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A0B4C5CC-31DA-11EC-8021-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> +	ours = lookup_commit_reference(the_repository, orig_head);
>
> I think orig_head can be the null oid if we're on an unborn HEAD. I
> guess you'd want to return "1" in that case (but I could be wrong; it
> looks like get_can_ff() assumes it's valid, so perhaps that case is
> handled earlier).

It is a good point; the main codeflow already special cases the
unborn HEAD to delegate to pull_into_void() before it gets to the
point to call get_can_ff().

> I'd expect that merge_heads can never be empty here, or we'd bail
> earlier in the command

Yes, that happens even before that "are we unborn" check.

> Running a sequence of traversals like this can be slow, because we may
> walk over the same history again and again. But I think in the usual
> non-octopus cases we'd only have one entry, so we'd only be adding a
> single extra merge-base traversal in most cases.
>
> It does feel like this could be combined with get_can_ff() somehow so
> that we're not adding even that single traversal. But I expect that may
> be hard to do because of the multiple heads (e.g., we cannot use the
> usual ahead/behind code).

I'd leave such an optimization as a separate topic.  This was meant
to be a regression fix.

