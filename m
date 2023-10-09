Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB12CD6130
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 19:52:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378457AbjJITwS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 15:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376628AbjJITwR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 15:52:17 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC1693
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 12:52:16 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 57BE51A1017;
        Mon,  9 Oct 2023 15:52:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=9g2SLIs+Nx2TrBfuVcTB5bahUxOO3wLY49Oh2Q
        LyU8k=; b=Kh2/80Zkwi8ZAXa0PrJ5T9ZOBTmXY9lMo+Ff3+2WqhF6dS9gUpDZ6C
        q/B9f5HvOhE8TktwLab2rNnQF0iQ0QXcG3grRZ1DIlssnXODMMhjzG1IcPZeC6+/
        K/d5oJFz5Ts0XPwMRTRrqBHpKHBUcmw0E1pVoVqXrMqVhX5dOhv9o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4FCB51A1016;
        Mon,  9 Oct 2023 15:52:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B77DE1A1015;
        Mon,  9 Oct 2023 15:52:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 07/15] commit-graph: new filter ver. that fixes murmur3
In-Reply-To: <ZSRVJ3iASRaDGc80@nand.local> (Taylor Blau's message of "Mon, 9
        Oct 2023 15:31:51 -0400")
References: <20230830200218.GA5147@szeder.dev>
        <20230901205616.3572722-1-jonathantanmy@google.com>
        <ZRIRtlbsYadg7EUx@nand.local> <20231008143523.GA18858@szeder.dev>
        <ZSRD0tK3bk67aDw4@nand.local> <ZSRVJ3iASRaDGc80@nand.local>
Date:   Mon, 09 Oct 2023 12:52:13 -0700
Message-ID: <xmqqr0m3y3o2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5825CBA0-66DD-11EE-B1CE-25B3960A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> However, I am not entirely sure I agree with you that this is a "new"
> issue. At least in the sense that Git (on 'master') does not currently
> know how to deal with Bloom filters that have different settings across
> commit-graph layers.
>
> IOW, you could produce this problem today using the test you wrote in
> <20201015132147.GB24954@szeder.dev> using different values of the
> GIT_BLOOM_SETTINGS environment variables as a proxy for different values
> of the commitGraph.changedPathsVersion configuration variable introduced
> in this series.
>
> So I think that this series makes it easier to fall into that trap, but
> the trap itself is not new. I think a reasonable stopgap (which IIUC you
> have suggested earlier) is to prevent writing a new commit-graph layer
> with a different hash version than the previous layer.

What we probably want more urgently than that stopgap is to perhaps
teach the code pretend as if commit-graph did not exist when we
detect multiple layers use different hash versions (or perhaps only
use the base layer and ignore the rest as an anti-pessimization), to
protect correctness first, no?


