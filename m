Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA2B0C4332D
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71B9764EE6
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:24:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356867AbhCDAX6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:23:58 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59104 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388001AbhCCUT5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Mar 2021 15:19:57 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8FF1FBDD38;
        Wed,  3 Mar 2021 15:19:13 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TpCXfBNMT6by/AhOxx/2gLzf2ms=; b=U1PEdH
        xSKHl0DH8zQRcWoCNH4Qv86BiZDmoPQTCmkKRiZa7yVLaiM0Y24k5EwOfRdYSElb
        6zFUAPt4/ZdnXnbn1Psg9CqEuVNLrE336MGYXu1xsb4cibA+RJ6DzUGj4Ax6Ashh
        pHS2iAeXqLWqT0WtbDyGMfGONsjgzfGZ1mKXY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wiEtG3AtOrGgYosr9J3GTSodSrp+9EaV
        CnQRLiN4cmHyo1izOq8Czm/48FFGdpJNBHDtCkuJ8MegccKaZQ3AYdIXd65UhieT
        Ccy921fQaxr2ZPEHTloIjb9LY4QRK+LsHj/D5UNJ02kp/POOtzwA4G2fLnWCveyJ
        jE0G6qIySS8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 87490BDD37;
        Wed,  3 Mar 2021 15:19:13 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0EFFEBDD36;
        Wed,  3 Mar 2021 15:19:13 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v4 05/12] simple-ipc: design documentation for new IPC
 mechanism
References: <pull.766.v3.git.1613174954.gitgitgadget@gmail.com>
        <pull.766.v4.git.1613598529.gitgitgadget@gmail.com>
        <22eec60761a88107b2e337ce13eed1020352aa73.1613598529.git.gitgitgadget@gmail.com>
Date:   Wed, 03 Mar 2021 12:19:12 -0800
In-Reply-To: <22eec60761a88107b2e337ce13eed1020352aa73.1613598529.git.gitgitgadget@gmail.com>
        (Jeff Hostetler via GitGitGadget's message of "Wed, 17 Feb 2021
        21:48:41 +0000")
Message-ID: <xmqqr1kwhtxb.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B84CF3B8-7C5D-11EB-A512-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +How the simple-ipc server is started is also outside the scope of the
> +IPC mechanism.  For example, the server might be started during
> +maintenance operations.

Just a tiny nit.

I would expect to see "might be <re>started" if it is followed by
"during maintenance operations"; in other words, I expect "might be
started" to be followed by "as part of the boot-up sequence".

> +The IPC protocol consists of a single request message from the client and
> +an optional request message from the server.  For simplicity, pkt-line
> +routines are used to hide chunking and buffering concerns.  Each side
> +terminates their message with a flush packet.
> +(Documentation/technical/protocol-common.txt)

Hidign chunking and buffering concerns is good, but it introduces
some limitations, like 64k chunk limit, which probably want to be
mentioned (if not explained or described) here.

Do we give any extra meaning over "here, a message ends" to the
flush packet?  The lack of "now it is your turn to speak" (aka
"delim") has long been a weakness of the over-the-wire protocol,
and we'd probably want to learn from the past experience.

> +The actual format of the client and server messages is application
> +specific.  The IPC layer transmits and receives an opaque buffer without
> +any concern for the content within.

Please sell why such a semantic-agnostic layer exists and what
benefit the callers would get out of it.  Perhaps you offer some
mechanism to allow them to send and receive without having to worry
about deadlocks[*]?

THanks.

[Footnote]

*1* ...just an example benefit that may or may not exist.


