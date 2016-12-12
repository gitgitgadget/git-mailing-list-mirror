Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 234A7203C1
	for <e@80x24.org>; Mon, 12 Dec 2016 21:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753482AbcLLV1j (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Dec 2016 16:27:39 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57285 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753429AbcLLV1j (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2016 16:27:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E919355579;
        Mon, 12 Dec 2016 16:27:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=pcu5rQZfpqUj
        +kHZ/X7n330e4vU=; b=DbJJ1Of3J+WiZdA63FKzNmdINaYywZVqW5TJRYI0gQih
        E6tzFiJfYXRj8g3bySej1g4SreO3VhnYTjNgzn/TmHJf7MxpUEfPVw6wEzAIWiE3
        /MJZiYXpecPr9WY1xkNMAd2AoKP+agZvsXFcI/+GjAVm3zgqXeK63hs5+vMR0Xk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=GXqKLM
        Daoh8QYmXy1ByS8oqp7SOpOXNDvASEHInDfYs97Z1UpSrZP0ghjvp71ed0H1h3iP
        UbOqWt86L6mhVul/lDStIvxcI7E5cw0RBj5JIqETexUK//iDMZksVmFfek60PA4W
        R/qpacgLTXR4xMpehret4anY7BfeOiaiyLoGg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E0A6E55578;
        Mon, 12 Dec 2016 16:27:37 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4CDFB55577;
        Mon, 12 Dec 2016 16:27:37 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Leho Kraav <leho@conversionready.com>, git@vger.kernel.org
Subject: Re: [PATCHv2 5/7] versioncmp: cope with common part overlapping with prerelease suffix
References: <20161005033353.Horde.33pf2naqnF4HgwPWSy9DaHV@webmail.informatik.kit.edu>
        <20161208142401.1329-1-szeder.dev@gmail.com>
        <20161208142401.1329-6-szeder.dev@gmail.com>
Date:   Mon, 12 Dec 2016 13:27:21 -0800
In-Reply-To: <20161208142401.1329-6-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Thu, 8 Dec 2016 15:23:59 +0100")
Message-ID: <xmqqshps96ti.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CDA57D64-C0B1-11E6-8401-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> diff --git a/versioncmp.c b/versioncmp.c
> index a55c23ad5..f86ac562e 100644
> --- a/versioncmp.c
> +++ b/versioncmp.c
> @@ -26,12 +26,15 @@ static int initialized;
> =20
>  /*
>   * off is the offset of the first different character in the two strin=
gs
> - * s1 and s2. If either s1 or s2 contains a prerelease suffix starting
> - * at that offset, it will be forced to be on top.
> + * s1 and s2. If either s1 or s2 contains a prerelease suffix containi=
ng
> + * that offset, then that string will be forced to be on top.
>   *
> - * If both s1 and s2 contain a (different) suffix at that position,
> + * If both s1 and s2 contain a (different) suffix around that position=
,
>   * their order is determined by the order of those two suffixes in the
>   * configuration.
> + * If any of the strings contains more than one different suffixes aro=
und
> + * that position, then that string is sorted according to the containe=
d
> + * suffix which comes first in the configuration.
>   *
>   * Return non-zero if *diff contains the return value for versioncmp()
>   */
> @@ -44,10 +47,21 @@ static int swap_prereleases(const char *s1,
> =20
>  	for (i =3D 0; i < prereleases->nr; i++) {
>  		const char *suffix =3D prereleases->items[i].string;
> -		if (i1 =3D=3D -1 && starts_with(s1 + off, suffix))
> -			i1 =3D i;
> -		if (i2 =3D=3D -1 && starts_with(s2 + off, suffix))
> -			i2 =3D i;
> +		int j, start, suffix_len =3D strlen(suffix);
> +		if (suffix_len < off)
> +			start =3D off - suffix_len + 1;
> +		else
> +			start =3D 0;

Now that this function has to rewind the beginning of the comparison
earlier than the given 'off', it makes me wonder if it still makes
sense for the caller to compute it in the first place.

> +		for (j =3D start; j <=3D off; j++)
> +			if (i1 =3D=3D -1 && starts_with(s1 + j, suffix)) {
> +				i1 =3D i;
> +				break;
> +			}
> +		for (j =3D start; j <=3D off; j++)
> +			if (i2 =3D=3D -1 && starts_with(s2 + j, suffix)) {
> +				i2 =3D i;
> +				break;
> +			}
>  	}
>  	if (i1 =3D=3D -1 && i2 =3D=3D -1)
>  		return 0;
