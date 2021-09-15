Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81BAFC433EF
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 17:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B190611CA
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 17:33:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbhIORex (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 13:34:53 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52123 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhIORew (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 13:34:52 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 677A0F6092;
        Wed, 15 Sep 2021 13:33:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bRpJIy+cR+UwplWZIczq//F9p3HApdUVRXIo1M
        ps8UY=; b=PMM5q1u5R4GlD4T28TiaWJv26hSt1mxcxMrt49Bo90RAhggzhCwYKU
        9bh7I9ueSg80LAe7z/DInLEYckrsKIaWJEHstc/V4VaqM9/al51aWhDbztiZrohB
        EMEGHrrm/1BgzFev+NeLFSbK9YQE/k/8+vqUOJpNgq2hvbbDpbwas=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5A31FF6091;
        Wed, 15 Sep 2021 13:33:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D54DAF6090;
        Wed, 15 Sep 2021 13:33:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 09/11] serve: reject bogus v2 "command=ls-refs=foo"
References: <YUE1alo58cGyTw6/@coredump.intra.peff.net>
        <YUE1ym1dALRQLztq@coredump.intra.peff.net>
Date:   Wed, 15 Sep 2021 10:33:32 -0700
In-Reply-To: <YUE1ym1dALRQLztq@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 14 Sep 2021 19:52:42 -0400")
Message-ID: <xmqq8rzxyc9f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0C73C782-164B-11EC-A197-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> When we see a line from the client like "command=ls-refs", we parse
> everything after the equals sign as a capability, which we check against
> our capabilities table. If we don't recognize the command (e.g.,
> "command=foo"), we'll reject it. But we use the same parser that checks
> for regular capabilities like "object-format=sha256". And so we'll
> accept "ls-refs=foo", even though everything after the equals is bogus,
> and simply ignored.

Maybe I am slow but I had to read the above a few times and finally
look at the implementation of parse_command() to realize that what
the last sentence describes is:

    When parse_command() is fed "command=ls-refs=foo", it strips
    "command=", feeds "ls-refs=foo" to get_capability(), and because
    we do not ensure value is NULL, we silently ignore "=foo" that
    is bogus.

And it makes sense.  It would probably have helped if I peeked the
updated test ;-)

> This isn't really hurting anything, but the request does violate the
> spec. Let's tighten it up to prevent any surprising behavior.

Good.
