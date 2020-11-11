Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37775C5517A
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 16:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B424B20756
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 16:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HGL2wwW5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgKKQkN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 11:40:13 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55906 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbgKKQkM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 11:40:12 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DDCECA18AE;
        Wed, 11 Nov 2020 11:40:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=idkWEF0ITR3ZKH0ynF5bQ4Uu32s=; b=HGL2ww
        W54f6wG2VJJKA6SfHSQC1R0suehW/PP5Xh9eUA58yJLMIPpPULRhc0FzCWweqVnt
        cl2aHhtrFaT+/ja/kWJMox4AbBfiTJ0TEEMXPUwvx26G3+L0jtmax9hADKPVLiZk
        BSPqryhA32BgGQZaJX/VGjMes51ZZbAIuRQT8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=P6VP63n+5CxfqRw9Hm0spsnOpNhbWImq
        3eipRgOtk9Z+D3HWcd1FrgXmYkdybc5XalZw3lu/EbMVWOsGZ7vZ4Wl9WVSeRQhK
        ak0pfUhsAh0mN+Tl63Fj6/1bRsORSVOYoVQutzRzsL5BHdmzPVDh94k0NKtAGNgi
        aLaNGKlHVqI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BB64FA18AC;
        Wed, 11 Nov 2020 11:40:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4D0F2A18AA;
        Wed, 11 Nov 2020 11:40:08 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Daniel Gurney <dgurney99@gmail.com>, git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] compat/bswap.h: don't assume MSVC is little-endian
References: <20201111083227.605518-1-dgurney99@gmail.com>
        <nycvar.QRO.7.76.6.2011111723050.18437@tvgsbejvaqbjf.bet>
Date:   Wed, 11 Nov 2020 08:40:07 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2011111723050.18437@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Wed, 11 Nov 2020 17:23:22 +0100
        (CET)")
Message-ID: <xmqqo8k34zko.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8F284D80-243C-11EB-B4B0-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> ...
>> So let's go back to the old way of detecting MSVC, and then checking
>> architecture from a list of little-endian architecture macros.
>>
>> Note that MSVC does not treat ARM64 as bi-endian, so we can safely treat
>> it as little-endian.
>>
>> Helped-by: brian m. carlson <sandals@crustytoothpaste.net>
>> Helped-by: Jeff King <peff@peff.net>
>> Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
>> Helped-by: Junio C Hamano <gitster@pobox.com>
>> Signed-off-by: Daniel Gurney <dgurney99@gmail.com>
>
> ACK!
>
> Thank you so much,
> Dscho

Thanks, all.
