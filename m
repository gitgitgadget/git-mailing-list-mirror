Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF98C433EF
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 18:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 577FB60E8B
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 18:00:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbhINSCQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 14:02:16 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61263 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbhINSCP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 14:02:15 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BB12DDDA7D;
        Tue, 14 Sep 2021 14:00:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=t4t/fH56ekfhq8EdPVm2KkSZ61U2iwgYbSbEgA
        b5eDo=; b=OyP+99Jx5w5R6NmLeXNDMeaVFjIJtPlb/CimBOdaXaJxBhBojZ4LOC
        HF1/P1WssENPWRUkUgyAoDgyAqVwse3knQa4wSFQmEYvhHEWMRkCaJmjvT4HUC8D
        SaHuCqq0aI3Ivls8dYIHdbVA87J/2w7FhjeqEk7Mng9nADjFbfGaE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B29C9DDA7C;
        Tue, 14 Sep 2021 14:00:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DA4A7DDA7B;
        Tue, 14 Sep 2021 14:00:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 0/9] reducing memory allocations for v2 servers
References: <YUC/6n1hhUbMJiLw@coredump.intra.peff.net>
Date:   Tue, 14 Sep 2021 11:00:56 -0700
In-Reply-To: <YUC/6n1hhUbMJiLw@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 14 Sep 2021 11:29:46 -0400")
Message-ID: <xmqqy27z11gn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B5F33CB4-1585-11EC-8408-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> While looking at [1], I noticed that v2 servers will read a few bits of
> client input into strvecs. Even though we expect these to be small-ish,
> there's nothing preventing a client from sending us a bunch of junk and
> wasting memory.

The title of the topic says "reducing", but it smells more to me
like this is about "limiting" allocations to protect ourselves.  Am
I reading the series correctly?

> This series changes that, putting a cap on how much data we'll receive.
> The two spots are the "capabilities" list we receive (before we even
> dispatch to a particular command like ls-refs or fetch), and the
> ref-prefix list we receive for ls-refs.
>
> To deal with the capabilities issue, we'll just handle each capability
> line as it comes in, rather than storing a list. This requires a bit of
> cleanup, which is why it takes up the first 6 patches. It also needs a
> few other cleanups from ab/serve-cleanup (and so this series is based on
> that). The dependencies there are both textual (e.g., using designated
> initializers in the capabilities table) and functional (dropping the
> "keys" parameter from v2 command() functions).
>
> Patch 7 fixes the ls-refs issue by degrading when we see too many
> prefixes (which works because the capability is optional in the first
> place).
>
> The final two patches aren't strictly necessary. They're a tightening of
> the protocol against some bogus input that I noticed while doing the
> earlier cleanups. That bogus input isn't really hurting anything, but I
> think it makes sense to reject nonsense from the client rather than
> ignoring it. The obvious risk is that some client for some reason would
> send us nonsense, but I don't think Git ever has.

Your cover letters (as proposed log messages for individual commits)
are always to the point and very pleasant to read.  Very much
appreciated.

Thanks.
