Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6D3C211B3
	for <e@80x24.org>; Thu,  6 Dec 2018 01:09:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbeLFBJB (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Dec 2018 20:09:01 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61760 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727620AbeLFBJB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Dec 2018 20:09:01 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 29F61120D7D;
        Wed,  5 Dec 2018 20:08:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3UWUJ2ESAycXG086ZVy2H63wzrU=; b=iNruz+
        5gq61dcqAExiCkaBp5sPMQRUjPwmmBeB6eZDcTHrkHBMM0HLyXxO6YsYxxq680uv
        im15tMiJc9X5h2v967a9LKpjVJmsk9DACvaBzvIvVTzjg8T+UL4Ly1QlJGtrqIQX
        yul4k54bz26YjxPbl648+BrH5cg6g40DOeRb0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eFXTypReCzi8Y7Idthr7NqVSi5e+D+6q
        rpm013c+BTOic0aZduHxjf204W9A6wLmhSAeopKHHbSjQalWH51vMol5ULZ3zun2
        XphdtJXrIde84zt2QMPu9Cc7ydibNeJlPTPFHrbGNcr1cTFy9livEcsEMt0M4MkL
        aT/PFLEVZPY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 21EDC120D7C;
        Wed,  5 Dec 2018 20:08:59 -0500 (EST)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9AC9B120D7B;
        Wed,  5 Dec 2018 20:08:58 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "Coiner\, John" <John.Coiner@amd.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git, monorepos, and access control
References: <939efd87-b2af-29d7-efdd-9cf8f6de9d10@amd.com>
        <20181205210104.GC19936@sigill.intra.peff.net>
Date:   Thu, 06 Dec 2018 10:08:57 +0900
In-Reply-To: <20181205210104.GC19936@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 5 Dec 2018 16:01:05 -0500")
Message-ID: <xmqqwoona2c6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 82966852-F8F3-11E8-8CBB-BFB3E64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> In my opinion this feature is so contrary to Git's general assumptions
> that it's likely to create a ton of information leaks of the supposedly
> protected data.
> ...

Yup, with s/implemented/designed/, I agree all you said here
(snipped).

> Sorry I don't have a more positive response. What you want to do is
> perfectly reasonable, but I just think it's a mismatch with how Git
> works (and because of the security impact, one missed corner case
> renders the whole thing useless).

Yup, again.

Storing source files encrypted and decrypting with smudge filter
upon checkout (and those without the access won't get keys and will
likely to use sparse checkout to exclude these priviledged sources)
is probably the only workaround that does not involve submodules.
Viewing "diff" and "log -p" would still be a challenge, which
probably could use the same filter as smudge for textconv.

I wonder (and this is the primary reason why I am responding to you)
if it is common enough wish to use the same filter for smudge and
textconv?  So far, our stance (which can be judged from the way the
clean/smudge filters are named) has been that the in-repo
representation is the canonical, and the representation used in the
checkout is ephemeral, and that is why we run "diff", "grep",
etc. over the in-repo representation, but the "encrypted in repo,
decrypted in checkout" abuse would be helped by an option to do the
reverse---find changes and look substrings in the representation
used in the checkout.  I am not sure if there are other use cases
that is helped by such an option.
