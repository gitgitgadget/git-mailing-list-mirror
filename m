Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21772C433C1
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 18:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3700619DD
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 18:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbhC3Sh6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 14:37:58 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61928 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232854AbhC3Sh2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 14:37:28 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 67F60BFCB9;
        Tue, 30 Mar 2021 14:36:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KhGB3VHJOwCHJCIyCoxnk/hG0eU=; b=MqRS2a
        7bQhnmAKqQdIpXwBuCW2aalwddJvTgU2tFIQKqJCYvpf5/gWQUeZo3vF5diXvMOn
        K9GLTR2Dmt2lDKrxd9DGrsbaQ3D/gny5Et+5KtFLRNObz5I8yrxYbAB6bTj2Yo58
        TlL7i5V95rKUoKWfEthwjPvIxHLmMud18yheg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=coM6pyEFU4j8izwjhndTWvJyFZeJei3u
        19eiu4St+AyAeqjpFu2kpTiusCRGaxmgwZEgetDJ5X7rsjbofJfR4f9D1zN/rwJF
        0ZSmKf/X3aY9bOPsDzq6iYRF5fYKAFT0HVzN/qrnczGR7M4tFZlIdpH54lfx3MY5
        yNX29og4aWI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6015EBFCB8;
        Tue, 30 Mar 2021 14:36:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D856BBFCB7;
        Tue, 30 Mar 2021 14:36:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        Andreas =?utf-8?Q?F=C3=A4rber?= <andreas.faerber@web.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/6] Makefile: refactor out "ln || ln -s || cp" pattern
References: <cover-0.6-00000000000-20210329T161723Z-avarab@gmail.com>
        <cover-0.7-00000000000-20210329T162327Z-avarab@gmail.com>
        <patch-3.7-bde9de756b4-20210329T162327Z-avarab@gmail.com>
        <xmqqsg4dha3i.fsf@gitster.g>
        <YGNBoljqknW+Kpif@coredump.intra.peff.net>
Date:   Tue, 30 Mar 2021 11:36:48 -0700
In-Reply-To: <YGNBoljqknW+Kpif@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 30 Mar 2021 11:20:02 -0400")
Message-ID: <xmqqblb0eben.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E33D9602-9186-11EB-85B8-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> Nice.  These explicit command-line options to the helper may be
>> harder to initially write and maintain than just exporting the
>> relevant $(MAKE) macros and using it from the helper, but once
>> it works correctly, it is much easier to see what is going on.
>
> Another option is to make "ln-or-cp" itself a target that "make" knows
> how to build, and bake the values into its "built" version.

Aha.  That is even nicer ;-).
