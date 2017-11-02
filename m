Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3ACA202A0
	for <e@80x24.org>; Thu,  2 Nov 2017 01:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932433AbdKBBUP (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 21:20:15 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65201 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751988AbdKBBUO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 21:20:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 21281AC414;
        Wed,  1 Nov 2017 21:20:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xXKWMFn/tF4wi8tBRuLiKHclG54=; b=r9rk0A
        K9+iQvGVr+4uv8JAmqTEFK3Y9UPPTw0mzrmkFLKzk4lg8ToMHUfYRe0Yo2dEtNu5
        nJW1M6+RplemO+edm0apeBodHSOjBs0k8LFXLbhMCMz2JQuqibi6E1JlSHF9thFt
        Uk9Ql6VkuQjFIQF25tsRM8zFShl8qLx60NRd0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xTwnU+m2SBbDSy0/kxZ6oj98nfJSgs40
        sr+VYTz5HgYAht88rcaKvv9w4+2CORtAG8ZG27IoLapuOJ7UGH4tZrDvDdLAnpr2
        NUm29e1t5hR8MhA2sTfLlBblQaVUZ8K0v9gkm570oUCOOvivixelEogHAUbkceKX
        T9OevuMoXF4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1787BAC413;
        Wed,  1 Nov 2017 21:20:14 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7BBCCAC412;
        Wed,  1 Nov 2017 21:20:13 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>, Kevin D <me@ikke.info>
Subject: Re: [PATCHv2 2/7] revision.h: introduce blob/tree walking in order of the commits
References: <20171031003351.22341-1-sbeller@google.com>
        <20171031211852.13001-1-sbeller@google.com>
        <20171031211852.13001-3-sbeller@google.com>
        <xmqqr2tiveqp.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.21.1.1711011316590.6482@virtualbox>
        <CAPc5daWpUMOCYyK=S8JiAV5DHF6BYDff8wH0N6QDeR=nvOXnLA@mail.gmail.com>
        <alpine.DEB.2.21.1.1711012235070.6482@virtualbox>
        <20171101213911.aokzrnchr6s2r2uq@sigill.intra.peff.net>
        <alpine.DEB.2.21.1.1711012333060.6482@virtualbox>
Date:   Thu, 02 Nov 2017 10:20:12 +0900
In-Reply-To: <alpine.DEB.2.21.1.1711012333060.6482@virtualbox> (Johannes
        Schindelin's message of "Wed, 1 Nov 2017 23:33:51 +0100 (CET)")
Message-ID: <xmqqzi85schf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FA06BAA8-BF6B-11E7-B179-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > Given that the test_expect_* functions evaluate the code, it makes me
>> > wonder whether those `return` statements really return appropriately, or
>> > one call level too low.
>> 
>> The test_expect functions eval the actual snippets inside a dummy
>> function. This is intentional exactly to allow them to call "return" at
>> will.
>
> Tricksy. And a bit unintuitive for script kings such as myself, but okay.

Exactly.

The hidden assumption on the way how "return" interacts with
the way we use "eval" is the reason why I said "Ugly? Yes, Correct?
Questionable" in the first place.
