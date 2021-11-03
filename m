Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E29EEC433F5
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 17:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1628604AC
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 17:42:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbhKCRoy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Nov 2021 13:44:54 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57752 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbhKCRox (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Nov 2021 13:44:53 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9D25CE385A;
        Wed,  3 Nov 2021 13:42:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=drbIUO7qKbowIEKCoJkaFxSLZwcWD3hjQMOezk
        i2A6s=; b=fc4LQAZTjAtqECRUP25YnDiO6P5JX42WcDmMeHI/l/WDu6amCHLHyQ
        zjDtV75n7axte+G1EtSMWBS4l3v6eXE2m/zo8DUK+VSRP+gAbjTE21ni2aypMFOq
        ZWClCBLrfEuKIWDo1WF8wG4FMdP57cAiDd2O9Cm0oFulYbr6JYIfI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 94B81E3859;
        Wed,  3 Nov 2021 13:42:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0A686E3858;
        Wed,  3 Nov 2021 13:42:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Alejandro Sanchez <asanchez1987@gmail.com>
Subject: Re: [PATCH 2/2] prompt.c: add and use a GIT_TEST_TERMINAL_PROMPT=true
References: <20190524062724.GC25694@sigill.intra.peff.net>
        <cover-0.2-00000000000-20211102T155046Z-avarab@gmail.com>
        <patch-2.2-964e7f4531f-20211102T155046Z-avarab@gmail.com>
        <YYJ5IpvGRoDvp8V6@coredump.intra.peff.net>
Date:   Wed, 03 Nov 2021 10:42:14 -0700
In-Reply-To: <YYJ5IpvGRoDvp8V6@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 3 Nov 2021 07:57:22 -0400")
Message-ID: <xmqqo8716sqx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 628689F4-3CCD-11EC-BE44-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Basically, I think I just disagree with this paragraph entirely. Moving
> to stdin in the commits you referenced was done to help testing, but I
> also think it's just a more flexible direction overall.

It is OK, and it is more convenient for writing test scripts, to
take interactive input from the standard input stream, if the
command does not use the standard input for other purposes.

"git am -i <mbox" cannot take prompted input via the standard input,
but "git am -i mbox" is an easy workaround, for example.

Commands that are designed to be used in the downstream of a pipe
(e.g. "git rev-list ... | git pack-objects") cannot easily use such
a workaround, so they may still need to open and interact with
/dev/tty if they want to do an interactive input, though [*].

[Footnote]

* "pack-objects" is an excellent example of a command that takes its
  primary input from the standard input, but is a horrible example
  otherwise, because it probably would not make sense for it to take
  any prompted input.
