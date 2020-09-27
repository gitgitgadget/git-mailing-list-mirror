Return-Path: <SRS0=TjTC=DE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD23FC4346E
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 20:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B68223977
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 20:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="H+++7BlN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgI0UX2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Sep 2020 16:23:28 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59454 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbgI0UX2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Sep 2020 16:23:28 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 172398400C;
        Sun, 27 Sep 2020 16:23:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Gp3d4I/lL0Si/yr3UGpeNI1U70Q=; b=H+++7B
        lNDGRVPcqmnfML99aaZNl+/p2rIER115wTkshnpmohR5A/65Xfm6jhpcW/sOpklv
        gHOO0s/YoUnSCgTQgX7pD1eWUuUa8a3aEpzpxX6Lg8B9EVzjqhSHNSXfnFvGraWK
        jmT+Gj3DAAw93wB/gCEn6+D+t4Ntn5MA0WT9g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cSV5iPDsfRnuGOaYA6Od4qWQr+LZ/lI/
        Yn6bEXhQdp9EtjY2o0fVnoT2suArKiCSSLQ1ER5p0L/bpEs1WuW4fYJ8QRHHtZbJ
        klh4ybZNPXFJPU0O4N6Ixwri0L0IYD5zu2j5ENQ5lZkNxk5j7zf/dU/3/5Knx68J
        PDecmztk9Fg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0D5718400B;
        Sun, 27 Sep 2020 16:23:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 95FF58400A;
        Sun, 27 Sep 2020 16:23:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH v2 5/8] shortlog: de-duplicate trailer values
References: <20200927083933.GA2222823@coredump.intra.peff.net>
        <20200927084007.GE2465761@coredump.intra.peff.net>
Date:   Sun, 27 Sep 2020 13:23:25 -0700
In-Reply-To: <20200927084007.GE2465761@coredump.intra.peff.net> (Jeff King's
        message of "Sun, 27 Sep 2020 04:40:07 -0400")
Message-ID: <xmqqh7rjnf42.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4BFA74EE-00FF-11EB-8DE4-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The current documentation is vague about what happens with
> --group=trailer:signed-off-by when we see a commit with:
>
>   Signed-off-by: One
>   Signed-off-by: Two
>   Signed-off-by: One
>
> We clearly should credit both "One" and "Two", but should "One" get
> credited twice? The current code does so, but mostly because that was
> the easiest thing to do.

I thought that "the current documentation" as of step 4/8 were quite
clear about double counting ;-).

> It's probably more useful to count each commit
> at most once. This will become especially important when we allow
> values from multiple sources in a future patch.

Yup.  Makes readers want to read further ;-)

