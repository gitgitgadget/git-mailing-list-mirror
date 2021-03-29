Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65920C433C1
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 22:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33C396196E
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 22:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbhC2W1Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 18:27:25 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64272 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbhC2WYf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 18:24:35 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4204BB8EBC;
        Mon, 29 Mar 2021 18:24:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=PXzvRelCI6CD
        1IeshpoDfqzfk6s=; b=XxqwH5H3ufgrWczRTp81QFvyy2AEhlp549/OxyOfZdiW
        Pk6x2bxbPhXd6CtiYzTfY4YPYhjmwyxUhyY+WMZk6KvqW3X/zKJDvUNX6IJQuYEv
        LSmph7rGgb2QO9E2HH+7Y7I7g0etcLTiOybWMQpEHEiKI5r/FL+D56u5RkAzwSA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=TwVBn5
        6uriU8jsEqNIC32jJLJAMea5iWruppJA2DSNRugcsCBWgxDYzVNdaTj+PoKxwWKK
        UZ5U4v5+2/jPSKlGSsCgDxEUdFlZe1YRIMeF7QbWEu6zoUHuedc+uR278HfOMEhq
        qYUpl63oEBer47CIZkCk1H11zFa2F7fq51ew4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3A4D9B8EBB;
        Mon, 29 Mar 2021 18:24:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B723AB8EBA;
        Mon, 29 Mar 2021 18:24:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Andreas =?utf-8?Q?F?= =?utf-8?Q?=C3=A4rber?= 
        <andreas.faerber@web.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/6] Makefile: refactor out "ln || ln -s || cp" pattern
References: <cover-0.6-00000000000-20210329T161723Z-avarab@gmail.com>
        <cover-0.7-00000000000-20210329T162327Z-avarab@gmail.com>
        <patch-3.7-bde9de756b4-20210329T162327Z-avarab@gmail.com>
Date:   Mon, 29 Mar 2021 15:24:33 -0700
In-Reply-To: <patch-3.7-bde9de756b4-20210329T162327Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 29 Mar
 2021 18:31:41 +0200")
Message-ID: <xmqqsg4dha3i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 89B8BA66-90DD-11EB-9554-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Refactor out the hard-to-read and maintain "ln || ln -s || cp"
> pattern.
>
> This was initially added in 3e073dc5611 (Makefile: always provide a
> fallback when hardlinks fail, 2008-08-25), but since then it's become
> a lot more complex as we've added:
>
>  * 3426e34fedd (Add NO_CROSS_DIRECTORY_HARDLINKS support to the
>    Makefile, 2009-05-11)
>
>  * NO_INSTALL_HARDLINKS in 70de5e65e8c (Makefile:
>    NO_INSTALL_HARDLINKS, 2012-05-02)
>
>  * INSTALL_SYMLINKS in ad874608d8c (Makefile: optionally symlink
>    libexec/git-core binaries to bin/git, 2018-03-13)
>
>  * SKIP_DASHED_BUILT_INS 179227d6e21 (Optionally skip linking/copying
>    the built-ins, 2020-09-21)
>
> Each of those commits had to add a new special-case to this code,
> resulting in quite an unmaintainable mess for adding any sort of new
> option.
>
> Let's use the newly introduced ln-or-cp.sh script instead, note that
> we only sometimes pass the --no-cross-directory-hardlinks option, per
> the previous behavior. The target of the "ln -s" is also another
> special snowflake, but we're careful to carry that forward.

Nice.  These explicit command-line options to the helper may be
harder to initially write and maintain than just exporting the
relevant $(MAKE) macros and using it from the helper, but once
it works correctly, it is much easier to see what is going on.

And obviously, if we want to fix the "I do not ever want to see any
symlinks", it is very clear that main_with_fallbacks is where the
change needs to go.

Raelly nice.
