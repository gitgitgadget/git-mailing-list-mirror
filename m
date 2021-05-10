Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB9F2C43460
	for <git@archiver.kernel.org>; Mon, 10 May 2021 07:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 966B5610A5
	for <git@archiver.kernel.org>; Mon, 10 May 2021 07:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbhEJHWp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 03:22:45 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60185 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbhEJHWn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 03:22:43 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4E730C7154;
        Mon, 10 May 2021 03:21:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jszqNdlmNqIglqgTkoQFFsigjhxoit5dpnWSQx
        l008k=; b=EkfTgdrkbDrBJpJH6IWBeeJWIcc+oa93M7kFtAV03LcUMmyrtPJaPL
        u5XwBBkxirbARnUipSmwtwg8NOSvDDREpZ914wDhhwdV63yAp5H3h51iHjFGIjgv
        QrxHvDyN3r3u5B2sSoxw5QeHCOR1/dMQCtHD0yL8WkFzpwrylVZX4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 44E34C7153;
        Mon, 10 May 2021 03:21:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C1DE9C7152;
        Mon, 10 May 2021 03:21:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v3] [GSOC] ref-filter: fix read invalid union member bug
References: <pull.949.v2.git.1620318676776.gitgitgadget@gmail.com>
        <pull.949.v3.git.1620487572222.gitgitgadget@gmail.com>
Date:   Mon, 10 May 2021 16:21:18 +0900
In-Reply-To: <pull.949.v3.git.1620487572222.gitgitgadget@gmail.com> (ZheNing
        Hu via GitGitGadget's message of "Sat, 08 May 2021 15:26:11 +0000")
Message-ID: <xmqqh7jbqck1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 505CC7F0-B160-11EB-91E0-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: ZheNing Hu <adlternative@gmail.com>
>
> used_atom.u is an union, and it has different members depending on
> what atom the auxiliary data the union part of the "struct
> used_atom" wants to record. At most only one of the members can be
> valid at any one time. Since the code checks u.remote_ref without
> even making sure if the atom is "push" or "push:" (which are only
> two cases that u.remote_ref.push becomes valid), but u.remote_ref
> shares the same storage for other members of the union, the check
> was reading from an invalid member, which was the bug.
>
> Modify the condition here to check whether the atom name
> equals to "push" or starts with "push:", to avoid reading the
> value of invalid member of the union.
>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> ---
>     [GSOC] ref-filter: fix read invalid union member bug
>     
>     Change from last version:
>     Modify the processing method of the condition: check whether the name of
>     the atom equals to "push" or starts with "pushs", which can enhanced
>     security, although it may bring string match overhead.

I do not think this would have much security implication either
way.  What it buys us is the future-proofing.

I think it is OK to make this change without the enum thing to have
it graduate early as a fix to the existing code.  The enum thing can
come on top.

Will queue.  Thanks.
