Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A793AC433EF
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 20:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233451AbiBXUFY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 15:05:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbiBXUFW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 15:05:22 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEAE325D6CF
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 12:04:52 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D305B12785E;
        Thu, 24 Feb 2022 15:04:51 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wATY4MmMNa/UxR13S1K+rMVyJ4rlKFVUcKEe95
        7dX4Y=; b=cCdHu0bOsRsOHY4+8bdslTB8T6aS7NVNHiP3pFXMqzCzT6vU84skr6
        0atcUNemMx/7ELDa9hnA1hLHYhNJnxPjEU+8czRr0d1+/MNfTaN90GzgXrdidOam
        VlYLW8Db6DI6trfedlzO0o5LeuvRTzTSqNxqpMSJ/HEIz7Bc/Eo5M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C882812785D;
        Thu, 24 Feb 2022 15:04:51 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 390B912785C;
        Thu, 24 Feb 2022 15:04:51 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 04/15] merge-tree: implement real merges
References: <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com>
        <pull.1122.v3.git.1643787281.gitgitgadget@gmail.com>
        <02c29f920d0d5fde6d85f7b86a69be92e3f0f34d.1643787281.git.gitgitgadget@gmail.com>
        <xmqqy22tx8t1.fsf@gitster.g>
        <CABPp-BGpD6g5QH3=4X_dCuSX0Bs0utHn5hyuU4_UiwNhU0h8sg@mail.gmail.com>
        <xmqqh79hvsgn.fsf@gitster.g>
        <CABPp-BEaemkGGm0cSofP0gau7YN-y6HFoi0yJbHA8+iGjxsYSA@mail.gmail.com>
        <xmqqee3wt5g3.fsf@gitster.g>
        <CABPp-BE+DaBkis0r7pqs-kaChCvFhCEsyDg=gs3=QjWOPERaXQ@mail.gmail.com>
        <xmqqczjduz2h.fsf@gitster.g>
        <CABPp-BEsYTz35XpXy_j09J9-ke4UoCTED4z3L1sq0vYHuvuKPQ@mail.gmail.com>
Date:   Thu, 24 Feb 2022 12:04:50 -0800
In-Reply-To: <CABPp-BEsYTz35XpXy_j09J9-ke4UoCTED4z3L1sq0vYHuvuKPQ@mail.gmail.com>
        (Elijah Newren's message of "Wed, 23 Feb 2022 18:22:00 -0800")
Message-ID: <xmqqee3skp3x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 067FC628-95AD-11EC-8EBF-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> So, am I correct to understand that what bugs you is actually
> merge-recursive's and merge-ort's API?  That you don't want these two
> types of merges to have different entry points, and that there should
> in fact only be one?

It is more like

    It is more than OK that there are two, but the basic primitive
    is the "we have this and that tree objects to merge, and use
    this tree object as the ancestor" non-recursive thing, with the
    recursive one being just a thin wrapper around it to compute
    common ancestors, using the three-way primitive to reduce them
    into a single virtual ancestor, and finally using the three-way
    primitive to come up with the final result.

And making the composite "recursive" feature available long before
the underlying "non-recursive" primitive becomes easily accessible
to the scripters and system builders simply felt backwards.
