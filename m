Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E5B8C433EF
	for <git@archiver.kernel.org>; Fri,  8 Jul 2022 21:08:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240024AbiGHVIM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jul 2022 17:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239790AbiGHVIL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jul 2022 17:08:11 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA565C9C2
        for <git@vger.kernel.org>; Fri,  8 Jul 2022 14:08:10 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A1383145926;
        Fri,  8 Jul 2022 17:08:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=6Ceo/6t7YzMz
        2NqA9EluhdOJwsON62xRySD0YRzEhRQ=; b=YhxE8ifwnywPQ6BcSKbgaMG7qw6R
        QVKOrWHdd1XZ34cQN2naUmyiu2u1XEwtOU1U36b+AiXdz2JdaiM7/5VaCTifrPam
        AxLBRlXvDlU3vQkpJeDcCUIOC8bA+RzVNaGcvYF/NfruP3kWiXWqSblBZu2BvXDu
        toH+9vXFAxKHGe8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9908F145925;
        Fri,  8 Jul 2022 17:08:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F1E2E145924;
        Fri,  8 Jul 2022 17:08:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] multi-pack-index: simplify handling of unknown --options
References: <20220708202847.662319-1-szeder.dev@gmail.com>
Date:   Fri, 08 Jul 2022 14:08:07 -0700
In-Reply-To: <20220708202847.662319-1-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Fri, 8 Jul 2022 22:28:47 +0200")
Message-ID: <xmqqh73ruxc8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 117D366E-FF02-11EC-9D8A-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> Although parse_options() can handle unknown --options just fine, none
> of 'git multi-pack-index's subcommands rely on it, but do it on their
> own: they invoke parse_options() with the PARSE_OPT_KEEP_UNKNOWN flag,
> then check whether there are any unparsed arguments left, and print
> usage and quit if necessary.

The existing code check if there are any unparsed arguments or
options. =20

Omitting PARSE_OPT_KEEP_UNKNOWN allows parse_options() to deal with
unknown options by complaining, but it happily leaves non-options on
the command line and reports how many of them there are.

Doesn't this patch make

	$ git multi-pack-index write what-is-this-extra-arg-doing-here

silently ignore the extra argument instead of barfing on it?

> Let parse_options() handle unknown options instead, which, besides
> simpler code, has the additional benefit that it prints not only the
> usage but an "error: unknown option `foo'" message as well.

Yes, I agree that getting rid of KEEP_UNKNOWN is a very good idea
for this reason.  But I suspect that we still need the "did we get
an extra argument we do not know what to do with?" check.

Thanks.

> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> ---
>  builtin/multi-pack-index.c | 20 ++++----------------
>  1 file changed, 4 insertions(+), 16 deletions(-)
>
> diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
> index 5edbb7fe86..97a87ad8cb 100644
> --- a/builtin/multi-pack-index.c
> +++ b/builtin/multi-pack-index.c
> @@ -134,10 +134,7 @@ static int cmd_multi_pack_index_write(int argc, co=
nst char **argv)
>  		opts.flags |=3D MIDX_PROGRESS;
>  	argc =3D parse_options(argc, argv, NULL,
>  			     options, builtin_multi_pack_index_write_usage,
> -			     PARSE_OPT_KEEP_UNKNOWN);
> -	if (argc)
> -		usage_with_options(builtin_multi_pack_index_write_usage,
> -				   options);
> +			     0);
> =20
>  	FREE_AND_NULL(options);
> =20
> @@ -176,10 +173,7 @@ static int cmd_multi_pack_index_verify(int argc, c=
onst char **argv)
>  		opts.flags |=3D MIDX_PROGRESS;
>  	argc =3D parse_options(argc, argv, NULL,
>  			     options, builtin_multi_pack_index_verify_usage,
> -			     PARSE_OPT_KEEP_UNKNOWN);
> -	if (argc)
> -		usage_with_options(builtin_multi_pack_index_verify_usage,
> -				   options);
> +			     0);
> =20
>  	FREE_AND_NULL(options);
> =20
> @@ -202,10 +196,7 @@ static int cmd_multi_pack_index_expire(int argc, c=
onst char **argv)
>  		opts.flags |=3D MIDX_PROGRESS;
>  	argc =3D parse_options(argc, argv, NULL,
>  			     options, builtin_multi_pack_index_expire_usage,
> -			     PARSE_OPT_KEEP_UNKNOWN);
> -	if (argc)
> -		usage_with_options(builtin_multi_pack_index_expire_usage,
> -				   options);
> +			     0);
> =20
>  	FREE_AND_NULL(options);
> =20
> @@ -232,10 +223,7 @@ static int cmd_multi_pack_index_repack(int argc, c=
onst char **argv)
>  	argc =3D parse_options(argc, argv, NULL,
>  			     options,
>  			     builtin_multi_pack_index_repack_usage,
> -			     PARSE_OPT_KEEP_UNKNOWN);
> -	if (argc)
> -		usage_with_options(builtin_multi_pack_index_repack_usage,
> -				   options);
> +			     0);
> =20
>  	FREE_AND_NULL(options);
