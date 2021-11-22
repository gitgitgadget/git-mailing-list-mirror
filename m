Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A4ADC433EF
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 21:19:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbhKVVWy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 16:22:54 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52914 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbhKVVWx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 16:22:53 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E841AF54E8;
        Mon, 22 Nov 2021 16:19:45 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ljgNY5r58LXP
        7FUKxFcc2Zf3nOEXiEMBqk7zNDOgWgE=; b=C6AYhFdvqTqeKrJVWsItRhRHVDaG
        RwOaHh7YD6gSBNcUGVsJe0l4LrsG7gouiLDY9aNdJO9q6cmSLsmTy6UUCidTDf/Y
        cNnLlo3N/H1vvoOTDqF+2vUJNAD6PbXa/3v9UdaDsaQ9rzGrltc9BCci/iOhCCD1
        2FMQt+/73xK2M8Q=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DEB79F54E6;
        Mon, 22 Nov 2021 16:19:45 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5048CF54E5;
        Mon, 22 Nov 2021 16:19:45 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Enzo Matsumiya <ematsumiya@suse.de>
Subject: Re: [PATCH 3/5] run-command API users: use strvec_pushv(), not argv
 assignment
References: <YZseJ4jOVIK3+bUD@coredump.intra.peff.net>
        <cover-0.5-00000000000-20211122T153605Z-avarab@gmail.com>
        <patch-3.5-fd6c4c960ba-20211122T153605Z-avarab@gmail.com>
Date:   Mon, 22 Nov 2021 13:19:44 -0800
In-Reply-To: <patch-3.5-fd6c4c960ba-20211122T153605Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 22 Nov
 2021 17:04:05 +0100")
Message-ID: <xmqqlf1fevm7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: EA5B2E00-4BD9-11EC-B5A5-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> diff --git a/add-patch.c b/add-patch.c
> index 8c41cdfe39b..573eef0cc4a 100644
> --- a/add-patch.c
> +++ b/add-patch.c
> @@ -413,7 +413,7 @@ static int parse_diff(struct add_p_state *s, const =
struct pathspec *ps)
>  		strvec_push(&args, ps->items[i].original);
> =20
>  	setup_child_process(s, &cp, NULL);
> -	cp.argv =3D args.v;
> +	strvec_pushv(&cp.args, args.v);
>  	res =3D capture_command(&cp, plain, 0);
>  	if (res) {
>  		strvec_clear(&args);
> @@ -431,7 +431,7 @@ static int parse_diff(struct add_p_state *s, const =
struct pathspec *ps)
> =20
>  		setup_child_process(s, &colored_cp, NULL);
>  		xsnprintf((char *)args.v[color_arg_index], 8, "--color");
> -		colored_cp.argv =3D args.v;
> +		strvec_pushv(&colored_cp.args, args.v);
>  		colored =3D &s->colored;
>  		res =3D capture_command(&colored_cp, colored, 0);
>  		strvec_clear(&args);

We used to use the caller-supplied args, run-command API borrowed
that strvec by pointing at cp.argv, and because it is borrowed,
capture_command() did not use cp.args/cp.env_array and there was no
leak inside run-command API side, whether capture_command succeeded
or failed.  The code was using its own args, so it already correctly
releases it (we can see one such strvec_clear() here).
=20
OK.

I gave the remainder only a cursory look so I cannot call it quite
"reviewed", but presumably all the other changes in this patch are
the same way?

Thanks.
