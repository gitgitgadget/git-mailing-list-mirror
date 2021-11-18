Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B302EC433F5
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 23:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86A866139F
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 23:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbhKRX1A (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 18:27:00 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59579 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbhKRX1A (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 18:27:00 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4AF2D168884;
        Thu, 18 Nov 2021 18:23:59 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=ItPC84LZ5JUBxdg9vVIQ+mTs4QJfCCZrbtsZnn
        I5bK0=; b=ZjPtirPSBztj5Ul/USBLkl7eV8sv0Wry+Tt+q+ziZHkUmgbbKwwtoF
        vpfpzcXA11ApyaA8JiFxLvOBuz0Fb7eBBcdpEjLAMIqGzNVZWp7MpHPmptsHpBJ3
        PcRLcUhoe3j2rWApNckqDMzKydJMAW0Rb22kVFtafVZG1qxoEq/1A=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 436F9168883;
        Thu, 18 Nov 2021 18:23:59 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A1665168880;
        Thu, 18 Nov 2021 18:23:56 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Carlo Arenas <carenas@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: New-ish warning in refs.c with GCC (at least 11.2) under -O3
In-Reply-To: <YZQhLh2BU5Hquhpo@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 16 Nov 2021 16:22:54 -0500")
References: <211115.86a6i5s4bn.gmgdl@evledraar.gmail.com>
        <YZLhrSoTzrC7wcQo@coredump.intra.peff.net>
        <YZQUxkYI3TES3vDo@nand.local>
        <YZQhLh2BU5Hquhpo@coredump.intra.peff.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
Date:   Thu, 18 Nov 2021 15:23:55 -0800
Message-ID: <xmqqwnl5ujxw.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9A0AEDD4-48C6-11EC-85DF-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> +	/*
> +	 * Should be a noop per the ALLOWED_FLAGS check above, but this
> +	 * is necessary to work around a problem with some versions of
> +	 * "gcc -O3 -Wnonnull", which otherwise thinks that you can have the
> +	 * flag set with a NULL new_oid.
> +	 */
> +	flags &= ~REF_HAVE_OLD | REF_HAVE_NEW;

Are you missing parentheses around ~(OLD|NEW)?

>  	flags |= (new_oid ? REF_HAVE_NEW : 0) | (old_oid ? REF_HAVE_OLD : 0);
>  
>  	ref_transaction_add_update(transaction, refname, flags,
>
> I do find it interesting that gcc really _is_ convinced that those flags
> can be set coming in, since clearing them makes the problem go away.
> ...
> Reading over the code, it all looks OK. And that size is...weirdly huge.

The original bug is really annoying and this looks even worse.
Hopefully it won't come down from experimental to more stable tracks
before they are corrected.

