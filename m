Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C76FC07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 20:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F11A1611CD
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 20:09:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234644AbhGLULz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 16:11:55 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64593 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbhGLULy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 16:11:54 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E86A3139AA5;
        Mon, 12 Jul 2021 16:09:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XU51RXnC0upgxQE37MnwRZLcjuMRC+gbDUy2vt
        FOvoM=; b=jUJeO6jLOe9vRMIVtTamad+LOhdjcKrp6jZXBU1qpmTN59OAzlLuLP
        94DywMUha0XFwuxEohjPfcgxaAzuVYdHb8Fm99D4HfPB5fmGEnLeL4WStyaqwio6
        AgYjW+RpOsVrTpSspK7HGHcm9y+DGoOT7wKzQZmg2G05eMg5NhS3c=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E0892139AA4;
        Mon, 12 Jul 2021 16:09:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 05082139A9E;
        Mon, 12 Jul 2021 16:09:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jiang Xin <worldhello.net@gmail.com>,
        Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH] revision: allow pseudo options after --end-of-options
References: <20210708150316.10855-1-worldhello.net@gmail.com>
        <YOcvaFL7+6qcIOUa@camp.crustytoothpaste.net>
        <CANYiYbGYzbMoU_2wb4duppASoYUjGLsJsr692Xe3GaVBOXUsBA@mail.gmail.com>
        <YOoXCJV2ssef/KsN@camp.crustytoothpaste.net>
        <YOyByjmGu1oDXK4X@coredump.intra.peff.net>
        <xmqqim1f5pz8.fsf@gitster.g>
        <YOycOlyqwwWZJ6rH@coredump.intra.peff.net>
Date:   Mon, 12 Jul 2021 13:09:01 -0700
In-Reply-To: <YOycOlyqwwWZJ6rH@coredump.intra.peff.net> (Jeff King's message
        of "Mon, 12 Jul 2021 15:47:06 -0400")
Message-ID: <xmqq4kcz47mq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 00CD45EC-E34D-11EB-AA87-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Jul 12, 2021 at 11:47:23AM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > I don't think fully-qualifying refs is a complete solution, though. The
>> > common use case for --end-of-options is that you're passing along names
>> > from somewhere else, and you don't know how to qualify them. E.g., in:
>> >
>> >   git rev-list --end-of-options "$rev" --
>> >
>> > you need to behave differently if you got "1234abcd" versus "foo" versus
>> > "refs/heads/foo".
>> 
>> I suspect that you can prefix "^^" unconditionally, just like --not
>> can be emulated away by unconditionally prefixing "^".
>
> That would be clever, but I think we only parse a single "^":
>
>   $ git rev-list ^HEAD
>   [no output]
>   $ git rev-list ^^HEAD
>   fatal: bad revision '^^HEAD'
>
>   $ git rev-parse ^HEAD
>   ^d486ca60a51c9cb1fe068803c3f540724e95e83a
>   $ git rev-parse ^^HEAD
>   ^^HEAD
>   fatal: ambiguous argument '^^HEAD': unknown revision or path not in the working tree.
>
> -Peff

;-)  Surprised.
