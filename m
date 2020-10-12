Return-Path: <SRS0=3/hf=DT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44AD0C433DF
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 16:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C82B62080A
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 16:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="l8jIkpB+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390772AbgJLQ4i (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 12:56:38 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52660 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390761AbgJLQ4i (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Oct 2020 12:56:38 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6DC349F559;
        Mon, 12 Oct 2020 12:56:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cZVOSf3zvGPu8NKM1az5eJryVSc=; b=l8jIkp
        B+rKeyHHEZJXiP8GG4G4ixJGznwbcbMncfPU2DemdlJUL+K9E03CzSTfoRkzTRqQ
        pyntWGGYu5hy2vG2vrhAdzjeVsTLm1soMPWo2jSfZMjYmziri1Hj9C4M+mDLczAw
        4foPiEECOGkjZmOu+u4HQWlCWjZSTPFgRphPQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=H+eGedgvfz/DGuW2jPW9OtrmIjOxVKZG
        KiMLQ2Hk6iilxlRrdODo/xlyxBLLdzlplXNbwoi24Z3K3pdv8jRVK4DfrwbkGBoy
        gyWJH/pliZBr2WzZJ1x21hBmXiugFHfb1RNPGFCwvjBmr1VaJo1yp2RzA+LEmYzH
        DHVplN9xk70=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6351D9F558;
        Mon, 12 Oct 2020 12:56:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DFE139F54E;
        Mon, 12 Oct 2020 12:56:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Samuel =?utf-8?Q?=C4=8Cavoj?= <samuel@cavoj.net>,
        git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH] sequencer: fix gpg option passed to octopus merge
References: <20201011224804.722607-1-samuel@cavoj.net>
        <20201011225850.GA490427@camp.crustytoothpaste.net>
        <nycvar.QRO.7.76.6.2010121233590.50@tvgsbejvaqbjf.bet>
        <6f650960-6b32-4be5-b909-86685c6ad5ea@gmail.com>
Date:   Mon, 12 Oct 2020 09:56:35 -0700
In-Reply-To: <6f650960-6b32-4be5-b909-86685c6ad5ea@gmail.com> (Phillip Wood's
        message of "Mon, 12 Oct 2020 14:15:09 +0100")
Message-ID: <xmqq5z7fqt6k.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E36C5A4C-0CAB-11EB-8CE9-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> In run_git_commit() we do
>
> 	if (opts->gpg_sign)
> 		strvec_pushf(&cmd.args, "-S%s", opts->gpg_sign);
> 	else
> 		strvec_push(&cmd.args, "--no-gpg-sign");
>
> I'm not immediately clear why we pass --no-gpg-sign when
> opts->gpg_sign isn't set ...

Isn't it because there is a configuration that the &cmd may honor
that forces gpg signing all the time?

> but it makes me wonder if we should be doing
> that here as well

Possibly.
