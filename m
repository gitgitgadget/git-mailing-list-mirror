Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65836C433F5
	for <git@archiver.kernel.org>; Fri, 18 Mar 2022 01:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbiCRBuw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Mar 2022 21:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231506AbiCRBuv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Mar 2022 21:50:51 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36B8F3FB3
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 18:49:33 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 23840106662;
        Thu, 17 Mar 2022 21:49:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=IBYR0qErwqID
        kl/GzaNs4AeDWalxamaTdyaqTNVwtmk=; b=TIu9GHMzZmylLL70kU7lTHDlNaUJ
        NyLTXNWOb2yQm9/u5laugCl7piH5Uqd71kak+B3BO+6dpJ7aIZK79GzkR/8moWi0
        szODoI8XyVCXvKod62IZOs7aJUZfo4hptS5MEu1u0KAwWVOouaaZBQKwG951100Q
        hKQbkU20QaLSam8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1C16C106660;
        Thu, 17 Mar 2022 21:49:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 80C3810665F;
        Thu, 17 Mar 2022 21:49:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 7/8] reflog: convert to parse_options() API
References: <cover-0.8-00000000000-20220317T180439Z-avarab@gmail.com>
        <patch-7.8-19e1ff0c569-20220317T180439Z-avarab@gmail.com>
Date:   Thu, 17 Mar 2022 18:49:31 -0700
In-Reply-To: <patch-7.8-19e1ff0c569-20220317T180439Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 17 Mar
 2022 19:08:39 +0100")
Message-ID: <xmqqy218av2s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A82EDF84-A65D-11EC-87C4-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

>  int cmd_reflog(int argc, const char **argv, const char *prefix)
>  {
> -	if (argc > 1 && !strcmp(argv[1], "-h"))
> -		usage(_(reflog_usage));
> +	struct option options[] =3D {
> +		OPT_END()
> +	};
> =20
> -	/* With no command, we default to showing it. */
> -	if (argc < 2 || *argv[1] =3D=3D '-')
> -		return cmd_log_reflog(argc, argv, prefix);
> +	argc =3D parse_options(argc, argv, prefix, options, reflog_usage,
> +			     PARSE_OPT_KEEP_DASHDASH | PARSE_OPT_KEEP_ARGV0 |
> +			     PARSE_OPT_KEEP_UNKNOWN |
> +			     PARSE_OPT_NO_INTERNAL_HELP);
> +
> +	/*
> +	  * With "git reflog" we default to showing it. !argc is
> +	  * impossible with PARSE_OPT_KEEP_ARGV0.
> +	  */

Funny indentation?

> +	if (argc =3D=3D 1)
> +		goto log_reflog;
> +
> +	if (!strcmp(argv[1], "-h"))
> +		usage_with_options(reflog_usage, options);
> +	else if (*argv[1] =3D=3D '-')
> +		goto log_reflog;

Unfortunate.  KEEP_UNKNOWN is unwieldy, but it is no worse than the
original.  We do not have options that are common to all "git reflog"
subcommands, so the first token after "git reflog" being anything
that begins with "-" is a sign that the default "show" command is
being asked for.

> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index 0f439c99d61..1d004744589 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -329,7 +329,7 @@ test_commit () {
>  	else
>  		$echo "${3-$1}" >"$indir$file"
>  	fi &&
> -	git ${indir:+ -C "$indir"} add "$file" &&
> +	git ${indir:+ -C "$indir"} add -- "$file" &&

OK.

Looking good.
