Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C26C00140
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 17:54:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232579AbiHJRy1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 13:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232419AbiHJRyZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 13:54:25 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE0F24F36
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 10:54:24 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 27E6B14AD15;
        Wed, 10 Aug 2022 13:54:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=d8tfGeGE1ez98sYde67dwk5+Amj5xNnzW2SSSC
        H1vpQ=; b=bmUL+t98lEOyuKNZVruMlHiQCWBw+b28tRvpGv7QhLDMQqD3IElCI0
        7IsbVH8zXNYGFcO4jG4MDpefocz1EdoL2xphlQDB+oQ05qW/BaPu5mPGpqKoz4Op
        94yhrbyW2mCG55nQlGSTwOYRH4nXqYhB2Y0OG5oXz5Y4STld02h18=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1FE4B14AD14;
        Wed, 10 Aug 2022 13:54:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4BA9414AD13;
        Wed, 10 Aug 2022 13:54:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 4/5] add -p: avoid ambiguous signed/unsigned comparison
References: <pull.1320.git.1660143750.gitgitgadget@gmail.com>
        <4d24a4345ba66031d2ccf7ce472ed93ace82e9d6.1660143750.git.gitgitgadget@gmail.com>
Date:   Wed, 10 Aug 2022 10:54:22 -0700
In-Reply-To: <4d24a4345ba66031d2ccf7ce472ed93ace82e9d6.1660143750.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Wed, 10 Aug 2022
        15:02:29 +0000")
Message-ID: <xmqq7d3gm1bl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 77AD2056-18D5-11ED-B38E-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> In the interactive `add` operation, users can choose to jump to specific
> hunks, and Git will present the hunk list in that case. To avoid showing
> too many lines at once, only a maximum of 21 hunks are shown, skipping
> the "mode change" pseudo hunk.
>
> The comparison performed to skip the "mode change" pseudo hunk (if any)
> compares a signed integer `i` to the unsigned value `mode_change` (which
> can be 0 or 1 because it is a 1-bit type).
>
> According to section 6.3.1.8 of the C99 standard (see e.g.
> https://www.open-std.org/jtc1/sc22/WG14/www/docs/n1256.pdf), what should
> happen is an automatic conversion of the "lesser" type to the "greater"
> type, but since the types differ in signedness, it is ill-defined what
> is the correct "usual arithmetic conversion".
>
> Which means that Visual C's behavior can (and does) differ from GCC's:
> When compiling Git using the latter, `add -p`'s `goto` command shows no
> hunks by default because it casts a negative start offset to a pretty
> large unsigned value, breaking the "goto hunk" test case in
> `t3701-add-interactive.sh`.
>
> Let's avoid that by converting the unsigned bit explicitly to a signed
> integer.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

This looks more like a fix to a general problem, not limited to
windows or cmake, that we had since 9254bdfb (built-in add -p:
implement the 'g' ("goto") command, 2019-12-13).

Please pull this out of the series and let's have it reviewed
separately.

Thanks.

>  add-patch.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/add-patch.c b/add-patch.c
> index 509ca04456b..3524555e2b0 100644
> --- a/add-patch.c
> +++ b/add-patch.c
> @@ -1547,7 +1547,7 @@ soft_increment:
>  			strbuf_remove(&s->answer, 0, 1);
>  			strbuf_trim(&s->answer);
>  			i = hunk_index - DISPLAY_HUNKS_LINES / 2;
> -			if (i < file_diff->mode_change)
> +			if (i < (int)file_diff->mode_change)
>  				i = file_diff->mode_change;
>  			while (s->answer.len == 0) {
>  				i = display_hunks(s, file_diff, i);
