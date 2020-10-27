Return-Path: <SRS0=IAqa=EC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9239C388F9
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 18:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E83D20829
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 18:56:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jAsk9U/p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S371289AbgJ0S4x (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Oct 2020 14:56:53 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63726 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S371274AbgJ0S4x (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Oct 2020 14:56:53 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 44364E6BBB;
        Tue, 27 Oct 2020 14:56:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sGUXGFmUWEjforWiYDMmvaJtpwQ=; b=jAsk9U
        /pCqYMgo/bHYXaOCEcfLsd7FmF8YRcpf36B4tXINM3kLCVYxbbX4ylNwBnbYF1Hp
        QexgXHfNcds1wGZGYrVL9ppnTzs4DtYAWXYtmMccM41gLpukekwn9MV4TvYQ166K
        5d7tJ7QAgdgcwbmvhwlIuTrenpDS2tpzggqHw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qfkAM+ydgOokb1ycoM0X5jRHh6Ys3gao
        qlD20i8pTh3VKL2OHCAsVTi59xqIB1/Q2Vdt6v5M3MCFdisOn6jx05Onb+XJ8Y++
        LFKSPnSRU+xldtNThP9l7danInX5QQwJuWSaxVcgqg4bdA2ycZKPSO+2GJLI+SP1
        +ydMwklp8Q0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3C7E0E6BBA;
        Tue, 27 Oct 2020 14:56:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6FDBEE6BB9;
        Tue, 27 Oct 2020 14:56:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] sideband: diagnose more incoming packet anomalies
References: <pull.753.v2.git.1603136142.gitgitgadget@gmail.com>
        <pull.753.v3.git.1603728555.gitgitgadget@gmail.com>
        <20201027065250.GB3005508@coredump.intra.peff.net>
        <20201027071222.GC3005508@coredump.intra.peff.net>
Date:   Tue, 27 Oct 2020 11:56:46 -0700
In-Reply-To: <20201027071222.GC3005508@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 27 Oct 2020 03:12:22 -0400")
Message-ID: <xmqqblgncxap.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2A9FE6BE-1886-11EB-B543-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Oct 27, 2020 at 02:52:50AM -0400, Jeff King wrote:
>
>>   - we'll report an eof with a more detailed "protocol error: eof while
>>     reading sideband packet", rather than the generic "the remote end
>>     hung up unexpectedly"
>
> I wasn't sure if "eof" was too jargon-y. This is probably a message
> normal users are likely to see if the network drops out on them.

We were expecting to see something, and instead of seeing that
specific thing we were waiting, we saw the end-of-file?

That sounds like "the other side hung up unexpectedly" to me.  Does
it bother you for being "too generic" because it does not say what
we were expecting to see?  "unexpected disconnect while waiting for
a sideband packet"?
