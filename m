Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D4AC04A95
	for <git@archiver.kernel.org>; Sun, 23 Oct 2022 00:14:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbiJWAOn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Oct 2022 20:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiJWAOk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Oct 2022 20:14:40 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DB71A23B
        for <git@vger.kernel.org>; Sat, 22 Oct 2022 17:14:36 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 47A701415E2;
        Sat, 22 Oct 2022 20:14:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=im6ZZGjfBDfyTUrKDTn+xyS+VH37TVQorDopix
        89TQ4=; b=biZpEgzaUpWP3Aw/wDVOXW31UZ4hnIGWWUqhAd4wilfzt1ewDMmXlh
        ApE2EQYNOxRg7Hdx0W4qxcnyU1TEf7X1eEhEMXR3k384cAuDMBEJ/c900sgfjOc3
        me9gProoEE8z47htNovt6QNjihnACL/beum3+JaBHvg4pZa5bXOq4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3F1D01415E1;
        Sat, 22 Oct 2022 20:14:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A635F1415E0;
        Sat, 22 Oct 2022 20:14:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Jan =?utf-8?Q?Pokorn=C3=BD?= <poki@fnusa.cz>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 4/5] repack: use tempfiles for signal cleanup
References: <Y1M3fVnixJHvKiSg@coredump.intra.peff.net>
        <Y1M3oie5dPrRaOni@coredump.intra.peff.net>
        <Y1RUI8ny2mexxwKm@coredump.intra.peff.net>
Date:   Sat, 22 Oct 2022 17:14:33 -0700
In-Reply-To: <Y1RUI8ny2mexxwKm@coredump.intra.peff.net> (Jeff King's message
        of "Sat, 22 Oct 2022 16:35:47 -0400")
Message-ID: <xmqqtu3vflau.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AC77AD08-5267-11ED-B943-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Ugh, I think this test is racy. I saw a failure via SIGPIPE on OS X in
> CI, and running it locally with --stress confirmed. I think the problem
> is in our method to trigger pack-objects to fail for the cruft pack. We
> pass a bogus command line argument, so pack-objects exits more or less
> immediately. But the parent git-repack process is trying to write to its
> stdin (to name packs to keep/exclude). So that write may succeed or fail
> based on how quickly the child dies.

Yeah, I saw flaky failures myself during my integration tests.

> Some options:
>
>   - find a different way to convince repack to die. The most likely is
>     probably corrupting the cruft objects in some way such that
>     pack-objects dies, but not until it starts doing real work.
>
>   - mark the test_must_fail with ok=sigpipe. In most case this is a
>     band-aid, but here we still test what we want. The .tmp cleanup
>     should kick in from a die() or from a signal death, so either is
>     sufficient for our purposes.
>
>   - teach git-repack to ignore sigpipe. We don't actually check the
>     writes to pack-objects (since they're done by fprintf), but we'd
>     notice its failing exit code. And arguably this is improving the
>     user experience. Saying "pack-objects died with an error" is more
>     useful than a sigpipe.
>
> Thoughts?

I agree that for this particular one the second one is a reasonable
thing to do in the context of the test.  The third one may actually
be a better fix, exactly for the reason you state here.

Thanks.
