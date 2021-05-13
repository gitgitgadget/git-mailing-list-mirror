Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8581CC433B4
	for <git@archiver.kernel.org>; Thu, 13 May 2021 05:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51E316140C
	for <git@archiver.kernel.org>; Thu, 13 May 2021 05:20:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbhEMFUw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 01:20:52 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63584 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbhEMFUu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 01:20:50 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D6681CF8E1;
        Thu, 13 May 2021 01:19:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=AkfUdD7czNj6TUk3Ik0cfPXs5Bx+tDSw6qxOnrLhmAo=; b=Rxq5
        Di6/ahnMNFgujgUOAwali2sChFC/jF22DcihLCh80z0eeBIeMAAaMkMkGvCyoVv7
        O6P3Tm4NLwY4D/o7U1GUxjQlgUS7xRwq4UKE+9haROabGn7Z3Iba8tx9PAutTJYR
        FGj0dvidZIwcH2JigI+iJd+vT4hlpou5d/6QH7o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CD2DACF8E0;
        Thu, 13 May 2021 01:19:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 57FA8CF8DF;
        Thu, 13 May 2021 01:19:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 4/8] doc: simplify the handling of interruptions
References: <20210512222803.508446-1-felipe.contreras@gmail.com>
        <20210512222803.508446-5-felipe.contreras@gmail.com>
Date:   Thu, 13 May 2021 14:19:38 +0900
Message-ID: <xmqqmtszb47p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D0CBAB30-B3AA-11EB-9758-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> +"${args[@]}" -o "$out" "$1" ||
> +{ rm -f "$out"; false; }

It would be so nice if this worked, but here is what I saw in a
quick-and-dirty experiment:

    $ f () { echo foo >"$1" && sleep 20 && echo bar >>"$1"; }
    $ f hoi ;# wait sufficiently long
    $ cat hoi
    foo
    bar
    $ f hoi ;# wait a bit and hit ^C
    ^C
    $ cat hoi
    foo
    $ rm hoi
    $ f hoi || rm hoi ;# wait a bit and hit ^C
    ^C
    $ cat hoi
    foo

So, I suspect it unfortunately may not work well.

We need to get 2/8 redone without bash-ism, but it would not affect
the correctness of this step, I would think, whether this is done in
bash or implemented in a plain vanilla POSIX shell.

Thanks.
