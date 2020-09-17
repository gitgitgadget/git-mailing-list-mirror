Return-Path: <SRS0=cV3L=C2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E5C5C43461
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 18:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2A5D221EE
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 18:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Xf6bVVrB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbgIQS1S (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 14:27:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53492 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726584AbgIQS0j (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 14:26:39 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AA8B98FD06;
        Thu, 17 Sep 2020 14:26:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AF4QH/Cq74tEQtQYAIyqGljAXp8=; b=Xf6bVV
        rBpLJmsXC9aZdW007XmaEeRn+bqq+Y2hX3jBjM9clnME8ZXDYLlzePv7f34uW9xN
        VVeNzNWjNuIz9EpbnsDFf0miqNYX6MhQPBfkyIQQL+HSJEI/Luy9Kdp+8qZy/fTL
        0zU3PitA2eU8veRKoWjHKgeO9KZztmSHIzStM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dLU3Q7mum//6EpB+I5XmAe/LaUCkqrW4
        vhEqStCD6GipxdYHHcVY6IvW8yCr/CRaAhb5M3EAi0+auGAOS++jRBwnxPwTniSP
        xp3+uSMg3uxIXfQeY8ICDGngJvPqzby30Ag4ps4TKAPsdg6Y2rlCe2tlgOilOldk
        QQo24/JGO3Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A224A8FD05;
        Thu, 17 Sep 2020 14:26:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2BD5E8FD04;
        Thu, 17 Sep 2020 14:26:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Rasmus Villemoes <rv@rasmusvillemoes.dk>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <stefanbeller@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH] packfile: actually set approximate_object_count_valid
References: <4a018cb9-da40-a98f-a1b9-73be30ae79ec@rasmusvillemoes.dk>
        <20200917125333.GA3024501@coredump.intra.peff.net>
        <20200917164743.GA3731633@coredump.intra.peff.net>
Date:   Thu, 17 Sep 2020 11:26:21 -0700
In-Reply-To: <20200917164743.GA3731633@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 17 Sep 2020 12:47:43 -0400")
Message-ID: <xmqqy2l8qmya.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 498DE9B4-F913-11EA-82E6-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Subject: [PATCH] packfile: actually set approximate_object_count_valid
>
> The approximate_object_count() function tries to compute the count only
> once per process. But ever since it was introduced in 8e3f52d778
> (find_unique_abbrev: move logic out of get_short_sha1(), 2016-10-03), we
> failed to actually set the "valid" flag, meaning we'd compute it fresh
> on every call.
> ...
>   Test                            origin              HEAD
>   ----------------------------------------------------------------------------
>   5303.3: rev-list (1)            28.91(28.46+0.44)   29.03(28.65+0.38) +0.4%
>   5303.4: abbrev-commit (1)       1.18(1.06+0.11)     1.17(1.02+0.14) -0.8%
>   5303.7: rev-list (50)           28.95(28.56+0.38)   29.50(29.17+0.32) +1.9%
>   5303.8: abbrev-commit (50)      3.67(3.56+0.10)     3.57(3.42+0.15) -2.7%
>   5303.11: rev-list (1000)        30.34(29.89+0.43)   30.82(30.35+0.46) +1.6%
>   5303.12: abbrev-commit (1000)   86.82(86.52+0.29)   77.82(77.59+0.22) -10.4%

Yuk, this is quite extreme.

>   5303.15: load 10,000 packs      0.08(0.02+0.05)     0.08(0.02+0.06) +0.0%
>
> It doesn't help at all when we have 1 pack (5303.4), but we get a 10%
> speedup when there are 1000 packs (5303.12). That's a modest speedup for
> a case that's already slow and we'd hope to avoid in general (note how
> slow it is even after, because we have to look in each of those packs
> for abbreviations). But it's a one-line change that clearly matches the
> original intent, so it seems worth doing.
>
> The included perf test may also be useful for keeping an eye on any
> regressions in the overall abbreviation code.
>
> Reported-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  packfile.c                 | 1 +
>  t/perf/p5303-many-packs.sh | 4 ++++
>  2 files changed, 5 insertions(+)

Thanks for finding and fixing.  I agree that this is worth doing.
