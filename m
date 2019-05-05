Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F7B41F45F
	for <e@80x24.org>; Sun,  5 May 2019 05:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbfEEF0H (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 May 2019 01:26:07 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51881 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbfEEF0G (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 May 2019 01:26:06 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C871C6D9A9;
        Sun,  5 May 2019 01:26:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8a5Lt11ZfFI3hVAFMwMrsrK9NFQ=; b=LPe5Yx
        ULqubcTcyfq9j4rvm2fklf9Le6e5VmeN2xvioObZJVQdEW2olT+Okb1O4FSYJs53
        jkLTsZ8rwhq5N2BXBKU8F+/lmTC+XHpCFZurnpz2G7cYzjm+YWGH9EbyDRZOfvSP
        9HoDtFFmocF4tBcjI6DCtN8FM+W5PRtfuNjxo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PRWJKNGXtiM6jJnvUIVwLWJKq/wdGmE2
        bmeFooc6a3+ljMFMwl7eyY/t8ra/Pu7Yau8jT2cm25hFUbRAUh+yLgRwnf92sBet
        O557aXOm0pyVLVPML+lQJrY8SjfOGMfDo8Le0oF+x2HwRQkSoqe/BnQsiP6uG9nH
        aNzb4GsCLbM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C116B6D9A8;
        Sun,  5 May 2019 01:26:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EEA5D6D9A6;
        Sun,  5 May 2019 01:26:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Rohit Ashiwal via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Subject: Re: [PATCH 1/2] archive: replace write_or_die() calls with write_block_or_die()
References: <pull.145.git.gitgitgadget@gmail.com>
        <7a9525a78a7b7b237150b9264cf675a4a0b37267.1555110278.git.gitgitgadget@gmail.com>
        <20190413013451.GB2040@sigill.intra.peff.net>
        <xmqqzhouwizg.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1904261028220.45@tvgsbejvaqbjf.bet>
        <xmqqd0l8tjph.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1904291732370.45@tvgsbejvaqbjf.bet>
        <20190501180936.GB4109@sigill.intra.peff.net>
Date:   Sun, 05 May 2019 14:25:59 +0900
In-Reply-To: <20190501180936.GB4109@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 1 May 2019 14:09:37 -0400")
Message-ID: <xmqqsgttsc9k.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4594BC14-6EF6-11E9-B617-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> FWIW, I agree with you here. These patches are not making anything worse
> (and may even make them better, since we'd probably need to swap out the
> BLOCKSIZE constant for a run-time "blocksize" variable in fewer places).

It's just that leaving the interface uneven is an easy way to
introduce an unnecessary bug, e.g.

	-type function(args) {
	+type function(args, size_t blocksize) {
		decls;
	-	helper_one(BLOCKSIZE, other, args);
	+	helper_one(blocksize, other, args);
		helper_two(its, args);
	-	helper_three(BLOCKSIZE, even, more, args);
	+	helper_three(blocksize, even, more, args);
	 }

when this caller is away from the implementation of helper_two()
that hardcodes the assumption that this callchain only uses
BLOCKSIZE and in an implicit way.

And that can easily be avoided by defensively making helper_two() to
take BLOCKSIZE as an argument as everybody else in the caller does.

I do not actually care too deeply, though.  Hopefully whoever adds
"-b" would be careful enough to follow all callchain, and at least
look at all the callees that are file-scope static, and the one I
have trouble with _is_ a file-scope static.

Or maybe nobody does "-b", in which case this ticking time bomb will
not trigger, so we'd be OK.


