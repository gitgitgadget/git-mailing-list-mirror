Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FBBFC433DB
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 22:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D45C2312E
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 22:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405319AbhALWe7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 17:34:59 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54598 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405306AbhALWe6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 17:34:58 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C235A9E07C;
        Tue, 12 Jan 2021 17:34:17 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=woo55GUbQHVRoko4Q8eq6n9cX
        QA=; b=SI00JKWzz1BWQ2l1nF/2vzY9DvJZ07c+frUEZ+8/s79AzNuBEQRE2ZWLl
        IldEUSff2awaxhP8w97dAi8PmdXtNKKAwT9X6gKmXAGw6Wh3JLKsQ1/A+XV7Xcn9
        DKi18PZX9Axea+8Epl+ssF+cznVusFijKkhEkK52kPATJJDNmo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=C1SLuC1RoE61PQ++RBo
        kVagV5+lsOgdYIVTqFKr14swfYlMJXWhJKsTIkzYGDmh3XVf4veq/1Amhl2lSjT8
        56qOqoP2vY0OQVHGMQUizDc3yImrUJjnbx1d0GlhhVRQckwkT1qEaZXgEcJEn/hC
        O7yLmXAo/bcwwJCl4KYuhhvw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B91729E07B;
        Tue, 12 Jan 2021 17:34:17 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3FEDA9E07A;
        Tue, 12 Jan 2021 17:34:17 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 10/22] mailmap tests: get rid of overly complex blame
 fuzzing
References: <20210105130359.21139-1-avarab@gmail.com>
        <20210112201806.13284-11-avarab@gmail.com>
Date:   Tue, 12 Jan 2021 14:34:16 -0800
Message-ID: <xmqqlfcx239z.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4E2038B4-5526-11EB-985F-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> +	6 6 1
> +	Santa Claus
> +	7 7 1
> +	CTO
> +	EOF
> +
> +	git blame --porcelain one >actual.blame &&
> +	grep -E \
> +		-e "[0-9]+ [0-9]+ [0-9]+$" \
> +		-e "^author .*$" \
> +		actual.blame >actual.grep &&
> +	cut -d " " -f2-4 <actual.grep >actual.fuzz &&

An approach along the lines of ...

	NUM=3D"[0-9][0-9]*"
	sed -n -e "s/^author //p" \
	-e "s/^$OID_REGEX \($NUM $NUM $NUM\)$/\1/p"

... would allow you to drop "cut" and also not assume that names do
not have more than 3 tokens.
