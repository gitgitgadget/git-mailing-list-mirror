Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EEBDC28D13
	for <git@archiver.kernel.org>; Mon, 22 Aug 2022 16:19:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236401AbiHVQTe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Aug 2022 12:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236748AbiHVQTX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2022 12:19:23 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B723F1CF
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 09:19:20 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3F989146AB4;
        Mon, 22 Aug 2022 12:19:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JRQniRQSMoMC6QEZtTjI9gmpxa5GLqbZ/QTnqv
        oPzJc=; b=WkcexWNIOCZ14KG7FL4YxEhaDVvuO7ZJyrOhTBfwqKBBQZb/5vH68k
        +h5mcusgKFiVMLJsoCVToVlfJJx6wwCOnVYDTv7gi5kIHefOzWKa3Urya5k47IIk
        hxjyWG6WBXyzKyx0yQyO+H+k7bnxnsqq21xv35JojbHNS8YBfbPLg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 355A2146AB3;
        Mon, 22 Aug 2022 12:19:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 83D80146AB2;
        Mon, 22 Aug 2022 12:19:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] merge: avoid searching for strategies with fewer
 than 0 conflicts
References: <pull.1331.git.1661056709.gitgitgadget@gmail.com>
        <5657a05e7635ecadbb8d2e41ad97fe19f3633fdd.1661056709.git.gitgitgadget@gmail.com>
        <xmqqwnb1fp5n.fsf@gitster.g>
        <CABPp-BHy-Xs0S1-9kL7X4mi6JNfd420-vpVsswXNuXsc5C7AtA@mail.gmail.com>
Date:   Mon, 22 Aug 2022 09:19:15 -0700
In-Reply-To: <CABPp-BHy-Xs0S1-9kL7X4mi6JNfd420-vpVsswXNuXsc5C7AtA@mail.gmail.com>
        (Elijah Newren's message of "Mon, 22 Aug 2022 08:00:00 -0700")
Message-ID: <xmqqr118dzek.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2B21E7FC-2236-11ED-9153-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> No, the original code would not have taken 'ort'.  You have overlooked
> the part of the code immediately above these two lines:
>
>     if (ret < 2) {
>         if (!ret) {
>             if (option_commit) {
>                 /* Automerge succeeded. */
>                 automerge_was_ok = 1;
>                 break;
>             }
>         merge_was_ok = 1;
>         }
>
> In particular, the "break" is key.

I noticed that much but then would "git merge --no-commit -s A -s B"
have the issue?

> ...  In contrast, if the user did specify
> --no-commit and the previous strategy succeeded, then we will continue
> the loop.  That seems rather inconsistent, since --no-commit should
> not affect the choice of strategy.

Yeah, exactly.

> However, I missed two things in my reading.  You are correct that I
> missed the "<=" as opposed to "<" when I wrote my commit message,
> though that turns out to not matter much due to the second thing.  The
> second thing I missed was part of the code at the beginning of the
> loop:
>
>     for (i = 0; !merge_was_ok && i < use_strategies_nr; i++) {

Ahhhh, that explains it.  We leave as soon as we find merge_was_ok
so this patch is not necessary.  There is nothing to fix.  The
original was fine as-is.

Thanks.


