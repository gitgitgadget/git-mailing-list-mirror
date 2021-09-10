Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1702FC433F5
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 16:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEBA36108B
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 16:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbhIJQx4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 12:53:56 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62172 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhIJQxz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 12:53:55 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E8833E66AF;
        Fri, 10 Sep 2021 12:52:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=xfaydfsjJ63u
        G9xBZdTU59mz8cVROtf0cr8X/nW4noM=; b=waSva+BdaYMmwkLq5E62AuXJrrX2
        MHv+PBWi8Y6F2MuJ+Teu79mIJIuUN+/dJpbO6LeUdoXiR8UcHeEYIp7choo01h4r
        y5XQ4phGg54Lfz7MbbxT7LnvMXrGCHsjdtPXHddTZO/7PVO8V3ael23QY7JKOYPT
        uSB/T6QL0wNrh6U=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E0201E66AE;
        Fri, 10 Sep 2021 12:52:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6E1F6E66AC;
        Fri, 10 Sep 2021 12:52:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v2 0/8] post-v2.33 "drop support for ancient curl"
 follow-up
References: <cover-0.5-00000000000-20210908T152807Z-avarab@gmail.com>
        <cover-v2-0.8-00000000000-20210910T105523Z-avarab@gmail.com>
Date:   Fri, 10 Sep 2021 09:52:42 -0700
In-Reply-To: <cover-v2-0.8-00000000000-20210910T105523Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 10 Sep
 2021 13:04:25
        +0200")
Message-ID: <xmqqr1dwtlt1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 846AC8B4-1257-11EC-8580-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Version 1 of this had a really bad bug where we'd effectively make all
> supported curl versions act like 7.19.4, i.e. the oldest supported
> version except for a couple of our supported features. This is because
> most of the things checked with the "ifdef" checks are enum fields,
> not macros. So basically the "devil's advocate" Jeff King pointed out
> in [2] was already the case. Oops!

Wow.  Thanks for bothering to actually test ;-)

Because we learned that "#ifdef CURL_SOME_FEATURE_WE_WANT" is not a
generally applicable way to conditionally build for various features
and we'd need to switch on the version numbers, it is now clear (at
least to me) that the central registry approach would be a direction
to go.

> In this v2 we're instead checking LIBCURL_VERSION_NUM consistently,
> even in those cases where we are checking things that are defined via
> macros.

Nice.

>     ++ * For each X symbol we need from curl we define our own
>     ++ * GIT_CURL_HAVE_X. If multiple similar symbols with the same pre=
fix
>     ++ * were defined in the same version we pick one and check for tha=
t name.
>      + *
>      + * Keep any symbols in date order of when their support was
>      + * introduced, oldest first, in the official version of cURL libr=
ary.
>     @@ git-curl-compat.h (new)
>      +/**
>      + * CURLOPT_TCP_KEEPALIVE was added in 7.25.0, released in March 2=
012.
>      + */
>     -+#ifdef CURLOPT_TCP_KEEPALIVE
>     ++#if LIBCURL_VERSION_NUM >=3D 0x071900
>      +#define GITCURL_HAVE_CURLOPT_TCP_KEEPALIVE 1
>      +#endif

What we have in the posted patch is perfectly OK and serviceable,
but this organization somewhat surprised me. =20

Instead of one #if...#endif block per a feature macro, I expected to
see a sequence of

	/* 7.34.0 (0x072200) - Dec 2013 */
	#if 0x072200 < VERSION
	#define HAVE_FOO 1
	#define HAVE_BAR 1
	...
	#endif

	/* 7.25.0 (0x071900) - March 2012 */
	#if 0x071900 < VERSION
	#define HAVE_BAZ 1
	#define HAVE_QUX 1
	...
        #endif


because it would make it more clear which features can now be
unconditionally used when we raise the cut-off point for the oldest
supported version if we group these entries along the versions.

Thanks.
