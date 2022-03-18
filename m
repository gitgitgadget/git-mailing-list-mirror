Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4904CC433F5
	for <git@archiver.kernel.org>; Fri, 18 Mar 2022 01:30:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbiCRBcE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Mar 2022 21:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbiCRBcD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Mar 2022 21:32:03 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FAB3116B6A
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 18:30:45 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AA34A1868E7;
        Thu, 17 Mar 2022 21:30:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=C7NGaypEkFCF
        Ink4cSZSdA+GaZgksyeVVNJU43VpV9I=; b=v2xhpx+7gZ3wJsEjhaR+WCYLZpyl
        bFJWFZ7ycOWqTT2gxPdWMD3gVrr1q8GBwdcMxqFokpVgZyjoGhAF8ur5oRBZPB7m
        WetcP4dqeShYw1/G4zLwij7JLE2Vnb9GshaEGJqoEUGvQRIbNDUCjf00IcEfOjVr
        y+x5hWJZpslnEsA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A478E1868E6;
        Thu, 17 Mar 2022 21:30:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 203441868E5;
        Thu, 17 Mar 2022 21:30:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 6/8] reflog exists: use parse_options() API
References: <cover-0.8-00000000000-20220317T180439Z-avarab@gmail.com>
        <patch-6.8-f88acdc9702-20220317T180439Z-avarab@gmail.com>
Date:   Thu, 17 Mar 2022 18:30:42 -0700
In-Reply-To: <patch-6.8-f88acdc9702-20220317T180439Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 17 Mar
 2022 19:08:38 +0100")
Message-ID: <xmqq35jgcail.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 07025070-A65B-11EC-A8DE-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change the "reflog exists" command added in afcb2e7a3b8 (git-reflog:
> add exists command, 2015-07-21) to use parse_options() instead of its
> own custom command-line parser. This continues work started in
> 33d7bdd6459 (builtin/reflog.c: use parse-options api for expire,
> delete subcommands, 2022-01-06).
>
> As a result we'll understand the --end-of-options synonym for "--", so
> let's test for that.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  builtin/reflog.c         | 38 ++++++++++++++++----------------------
>  t/t1418-reflog-exists.sh |  5 +++++
>  2 files changed, 21 insertions(+), 22 deletions(-)
>
> diff --git a/builtin/reflog.c b/builtin/reflog.c
> index 458764400b5..9847e9db3de 100644
> --- a/builtin/reflog.c
> +++ b/builtin/reflog.c
> @@ -27,8 +27,10 @@ static const char *const reflog_delete_usage[] =3D {
>  	NULL
>  };
> =20
> -static const char reflog_exists_usage[] =3D
> -	BUILTIN_REFLOG_EXISTS_USAGE;
> +static const char *const reflog_exists_usage[] =3D {
> +	BUILTIN_REFLOG_EXISTS_USAGE,
> +	NULL,
> +};

Good.

The discrepanthy in the postimage of [PATCH 4/8] bothered me a lot.

This would immediately help by making it possible to feed it to
parse_options(), but the uniformity will also make it easier to
concatenate common and subcommand specific usage later, I would
presume, if we wanted to.

> +	struct option options[] =3D {
> +		OPT_END()
> +	};
> +	const char *refname;
> =20
> +	argc =3D parse_options(argc, argv, prefix, options, reflog_exists_usa=
ge,
> +			     0);
> +	if (!argc)
> +		usage_with_options(reflog_exists_usage, options);
> =20
> +	refname =3D argv[0];
> +	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL))
> +		die(_("invalid ref format: %s"), refname);
> +	return !reflog_exists(refname);
>  }

Quite straight-forward.  Looking good.
