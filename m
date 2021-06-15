Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129CBC48BDF
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 06:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE36361059
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 06:13:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbhFOGP5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 02:15:57 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58618 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbhFOGP4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 02:15:56 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A9EB912654F;
        Tue, 15 Jun 2021 02:13:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iUv5jrIRA8OcIPFRevQs9sWEZgQoJVIQJciEEV
        Vfs1g=; b=YRg6NOzFaRH/eVF2zd9pqb/AujVYEyhDVfDeECJQkES1THLQ+JvOX/
        KNfuJrBXaFvMUp88kYD/W9DQNVWMOzEPbrQ2mqDjk97m/dEB5mhi7VfskXrgdv/I
        ecEHdk2xhDoSz1/YZoC8Nv0/hUvwqim6RSO+47maXRtkn9x+Tn6Ps=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9473A12654E;
        Tue, 15 Jun 2021 02:13:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 71B2F12654B;
        Tue, 15 Jun 2021 02:13:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/2] xdiff: implement a zealous diff3, or "zdiff3"
References: <pull.1036.git.git.1623734171.gitgitgadget@gmail.com>
        <b7561a67c192d4bdede47fee5b7b1cb30c44b785.1623734171.git.gitgitgadget@gmail.com>
Date:   Tue, 15 Jun 2021 15:13:46 +0900
In-Reply-To: <b7561a67c192d4bdede47fee5b7b1cb30c44b785.1623734171.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Tue, 15 Jun 2021
        05:16:09 +0000")
Message-ID: <xmqqv96fven9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D90BAD08-CDA0-11EB-9EBD-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

[An example to reduce
    1234<ABCDE|56=AXCYE>789
to
    1234A<BCD|56=XCY>E789
elided]

> Note that the common lines, 'A', and 'E' were moved outside the
> conflict.  Unlike with the two-way conflicts from the 'merge'
> conflictStyle, the zdiff3 conflict is NOT split into multiple conflict
> regions to allow the common 'C' lines to be shown outside a conflict,
> because zdiff3 shows the base version too and the base version cannot be
> reasonably split.

Another thing that was brought up during the original discussion is
that zdiff3 uses different meaning of "base version" from diff3.  In
diff3 output, if you remove everything enclosed in <<< and |||, and
everything enclosed in === and >>>, i.e. 123456789 in the original
example above, you will get "the common ancestor" version, which is
what is shown as the "base".  After zdiff3 munges the lines, that is
not the case, 1234A56E789 never appeared in anybody's version.  It
is a "starting from the common ancestor version, both sides agreed
to make the same uncontroversial changes, which is already included
in this base version" and zdiff3 inserts the conflict markers and
material unique to each side into it.  Being able to recover the
common ancestor version is not always necessary and that is what
makes zdiff3 a plausible solution, but to some workflows and tools
it may matter, so it would be helpful to mention it in the
documentation.

Thanks.
