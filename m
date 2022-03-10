Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44357C433F5
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 23:35:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235842AbiCJXgF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 18:36:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236034AbiCJXgE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 18:36:04 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D901194169
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 15:35:02 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 86315184521;
        Thu, 10 Mar 2022 18:35:01 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9X1mkfRfj48UNgVSn9QfFkOkesRtxDQFVQ4zz5
        olvcY=; b=nemm58Ld1zX0hDhum6EzDQ9JF1Zf6pjy3kOgzQfgJuCe937U8eg9cR
        xhYyl/ay/uVEemkKKJePx/0EU3VzqeBZ5F0m7sJPzwESV2oy7TqYiAQ7mVSKmGXc
        3LkMaWUD2GtTxLjTpGrX+PlRJ5yPGXAXJV/8YTCvsSEreQaZQDxAk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7C18618451F;
        Thu, 10 Mar 2022 18:35:01 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.247.14.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id F2DF518451B;
        Thu, 10 Mar 2022 18:34:58 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Neeraj K. Singh via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, rsbecker@nexbridge.com, bagasdotme@gmail.com,
        newren@gmail.com, avarab@gmail.com, nksingh85@gmail.com, ps@pks.im,
        sandals@crustytoothpaste.net,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH v6 0/6] A design for future-proofing fsync() configuration
References: <pull.1093.v5.git.1646866998.gitgitgadget@gmail.com>
        <pull.1093.v6.git.1646952204.gitgitgadget@gmail.com>
Date:   Thu, 10 Mar 2022 15:34:57 -0800
In-Reply-To: <pull.1093.v6.git.1646952204.gitgitgadget@gmail.com> (Neeraj
        K. Singh via GitGitGadget's message of "Thu, 10 Mar 2022 22:43:18
        +0000")
Message-ID: <xmqqmthxbcv2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B316BA2C-A0CA-11EC-973E-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Neeraj K. Singh via GitGitGadget" <gitgitgadget@gmail.com> writes:

> After this change, new persistent data files added to the repo will need to
> be added to the fsync_component enum and documented in the
> Documentation/config/core.txt text.
>
> V6 changes:
>
>  * Move only the windows csprng includes into wrapper.c rather than all of
>    them. This fixes the specific build issue due to broken Windows headers.
>    [6]
>  * Split the configuration parsing of core.fsync from the mechanism to focus
>    the review.
>  * Incorporate Patrick's patch at [7] into the core.fsync mechanism patch.
>  * Pick the stricter one of core.fsyncObjectFiles and (fsync_components &
>    FSYNC_COMPONENT_LOOSE_OBJECTS), to respect the older setting.
>  * Issue a deprecation warning but keep parsing and honoring
>    core.fsyncObjectFiles.
>  * Change configuration parsing of core.fsync to always start with the
>    platform default. none resets to the empty set. The comma separated list
>    implies a set without regards to ordering now. This follows Junio's
>    suggestion in [8].
>  * Change the documentation of the core.fsync option to reflect the way the
>    new parsing code works.

Hmph, this seems to make one test fail.

t5801-remote-helpers.sh (Wstat: 256 Tests: 31 Failed: 4)
  Failed tests:  14-16, 31
    Non-zero exit status: 1
Files=1, Tests=31,  2 wallclock secs ( 0.04 usr  0.00 sys + 1.40 cusr  1.62 csys =  3.06 CPU)
Result: FAIL
