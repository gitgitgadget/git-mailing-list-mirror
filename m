Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED2BC4743D
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 02:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CA826105A
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 02:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233637AbhFICYK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 22:24:10 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54439 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234327AbhFICYI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 22:24:08 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 797FD131D3C;
        Tue,  8 Jun 2021 22:22:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lrd3XlekQ0ha0DGnLGZz4x4mq7Ilvj9DJIY3se
        oZ9+w=; b=t5e9T6+Zf+t8gie4tt0QOwtQcCaoPA7R4kZHUT8erdErW8MVo37YhG
        I3gNOBmYXxviXZSjmvDYGNONMcLjD6PT19MJHX3VaON+P8cNvHZnvBe68qTgeniL
        gSn+UEtT5hU+RppePucNh/HM7u38+B16KgRl9aYlCoiFhvLABeLtU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 71D9A131D3B;
        Tue,  8 Jun 2021 22:22:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B7478131D37;
        Tue,  8 Jun 2021 22:22:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Andrei Rybak <rybak.a.v@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] mailinfo: use starts_with() when checking scissors
References: <20190401215334.18678-1-rybak.a.v@gmail.com>
        <20210608204841.2793591-1-rybak.a.v@gmail.com>
        <YL/n1b641m+wuVHG@coredump.intra.peff.net>
Date:   Wed, 09 Jun 2021 11:22:10 +0900
In-Reply-To: <YL/n1b641m+wuVHG@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 8 Jun 2021 17:57:41 -0400")
Message-ID: <xmqq35trn5f1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7F7AA25C-C8C9-11EB-8E68-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I think this is an improvement in safety and readability, and worth
> applying. I'd also be fine going further and using skip_prefix(), which
> would let us drop the magic-number "2", though:
>
>   - as Junio said in that earlier thread, we hope people aren't
>     encouraged to add more versions of scissors here anyway).
>
>   - I am not 100% sure that the increment of "c" in the conditional
>     is not also relying on that "2", as well (i.e., it is incrementing
>     one, and then the for-loop increments one). There's a non-trivial
>     risk of introducing off-by-one errors or even more subtlety here. :)
>
> So I'm OK leaving that. Thanks for resurrecting this cleanup.

You are correct to point out that the increment of "c" relies on 2.
We increment by one here, and let the loop control to increment
another, to skip over these two bytes.

The posted patch _might_ make it easier to read, but I do not think
it improves safety at all.  At the point of doing memcmp(), we know
that *c is not NUL and because we are dealing with NUL-terminated
string, we know we can check c[1] (otherwise we wouldn't even be
able to see if c is pointing at the end of string), so we check c[0]
and c[1] against four variants of two-byte scissors patterns.  The
current code uses memcmp() of 2 bytes, which is perfectly safe under
the condition, and starts_with() would also be equally safe.

If we were to teach new scissors sequence that is longer than two
bytes, then starts_with() would start becoming safer, but that will
not happen, so...


