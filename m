Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A730C433DB
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 19:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58FA761992
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 19:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbhCVTJl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Mar 2021 15:09:41 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54528 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbhCVTJI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Mar 2021 15:09:08 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 82309B1E87;
        Mon, 22 Mar 2021 15:09:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ucTiwmY/p8NU
        HR7rcBr2c3Tx4iA=; b=FXNybKZK9CZQYeUsudrWH21lBplhNhr8hdmN1EP4L9NM
        BiHJ6CZ8wVaBUv2oBZgHHHpeQyP0Aqq1OZXpgogbiNGDV4ex1EFla/jDMkEEIQJs
        z0REi3k/Oi/+EYywZovuvcNF2hdVQYLwuie6j2JLsAtn+oz+ZhAMwg6q8oaAn+w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=ABKD6T
        IiqC60D8xdpNPJHggpecAmkA1qV7Mi6obN4/8txmxF5577I1/WnfrwyEWsrucyKF
        LddFjtZGd0Qco12l2J1DO8k0/mAHF7mLxJt6YakVV4DMe5HK79RaMHJtwrwgbrzJ
        WafeVEG88laMEImjSAR8slh7a4rq8VDTSk00k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 75F8CB1E86;
        Mon, 22 Mar 2021 15:09:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C69ECB1E84;
        Mon, 22 Mar 2021 15:09:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Jeff King <peff@peff.net>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Wong <e@80x24.org>
Subject: Re: [PATCH v4 2/4] Makefile/coccicheck: speed up and fix bug with
 duplicate hunks
References: <20210306192525.15197-1-avarab@gmail.com>
        <cover.1616414951.git.avarab@gmail.com>
        <3bca3239cb84488a1638f2bb269392f47f78c6da.1616414951.git.avarab@gmail.com>
Date:   Mon, 22 Mar 2021 12:09:06 -0700
In-Reply-To: <3bca3239cb84488a1638f2bb269392f47f78c6da.1616414951.git.avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 22 Mar
 2021 13:11:48
        +0100")
Message-ID: <xmqqwntz57l9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1307EE32-8B42-11EB-87DB-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change the coccicheck target to run on all of our *.c and *.h files
> with --include-headers-for-types, instead of trusting it to find *.h
> files and other includes to modify from its recursive walking of
> includes as it has been doing with only --all-includes.

Meaning '--all-includes' that is fed a C source would use all the
headers included (recursively) in it, but if we add the other
option, --include-headers-for-types, some *.h files are missed?

If so, the above explains both hunks in the patch well (although it
is unclear where that need to include *.h independently comes from,
e.g. if it is working around a bug in spatch that we may expect for
it to be fixed someday).

> diff --git a/Makefile b/Makefile
> index eef99b4705d..e43a9618df5 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1199,7 +1199,8 @@ SPARSE_FLAGS ?=3D
>  SP_EXTRA_FLAGS =3D -Wno-universal-initializer
> =20
>  # For the 'coccicheck' target
> -SPATCH_FLAGS =3D --all-includes --patch .
> +SPATCH_FLAGS =3D --all-includes --include-headers-for-types --patch .
> +
>  # For the 'coccicheck' target; setting SPATCH_BATCH_SIZE higher will
>  # usually result in less CPU usage at the cost of higher peak memory.
>  # Setting it to 0 will feed all files in a single spatch invocation.
> @@ -2860,7 +2861,7 @@ check: config-list.h command-list.h
>  		exit 1; \
>  	fi
> =20
> -FOUND_C_SOURCES =3D $(filter %.c,$(shell $(FIND_SOURCE_FILES)))
> +FOUND_C_SOURCES =3D $(filter %.c %.h,$(shell $(FIND_SOURCE_FILES)))
>  COCCI_SOURCES =3D $(filter-out $(THIRD_PARTY_SOURCES),$(FOUND_C_SOURCE=
S))
> =20
>  %.cocci.patch: %.cocci $(COCCI_SOURCES)
