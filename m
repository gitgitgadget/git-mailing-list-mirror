Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8780C433F5
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 21:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9039260E94
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 21:39:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347305AbhIGVk5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 17:40:57 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59681 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbhIGVky (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 17:40:54 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 803081450F2;
        Tue,  7 Sep 2021 17:39:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=2xH5HK0oy7rb
        vnlP8SyLU/mZ1nYhw8mrSKB5JX7BezQ=; b=bn2IW+Qbrpq+vcEnLhnJ1ej2rjI9
        OFneIrpuN2phgsZOr2vSbtq/eNt0SeTnSf5zhWxCqwuJgapO/U8ItDHF32t/E79i
        xC0Ftg/lIdUs/v/S4OnVkSWrCqd5sDIHz0ADqddvKcGZ7nrdKSwVTbao0QmSyraM
        CaLkQlVaLCE+JNY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 78DAF1450F1;
        Tue,  7 Sep 2021 17:39:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C5A261450ED;
        Tue,  7 Sep 2021 17:39:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, bagasdotme@gmail.com, emilyshaffer@google.com
Subject: Re: [PATCH 1/2] bugreport: avoid duplicating options in usage()
References: <20210903115933.622847-1-bagasdotme@gmail.com>
        <20210904021231.88534-1-carenas@gmail.com>
        <20210904021231.88534-2-carenas@gmail.com>
Date:   Tue, 07 Sep 2021 14:39:43 -0700
In-Reply-To: <20210904021231.88534-2-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Fri, 3 Sep 2021 19:12:30 -0700")
Message-ID: <xmqq35qg9iao.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1DE7E020-1024-11EC-85CD-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

> 238b439d69 (bugreport: add tool to generate debugging info, 2020-04-16)
> includes the options with the commandline, which then means they will
> be duplicated in the output of `git bugreport -h`.
>
> remove them and while at it, make sure usage() is called if the wrong
> number of parameters is provided (ex: `git bugreport help`)

'remove' -> 'Remove'.

>  static const char * const bugreport_usage[] =3D {
> -	N_("git bugreport [-o|--output-directory <file>] [-s|--suffix <format=
>]"),
> +	N_("git bugreport"),

I do not quite see this as an improvement.  Without this change, the
user will see

	usage: git bugreport [-o <file>] [-s <format>]

	    -o <file>
		... explanation of what -o does ...
	    -s <format>
		... explanation of what -s does ...

and with the patch, it becomes unclear, especially for those who are
not used to "git subcommand -h" output convention, as we'd see only

	usage: git bugreport

on the first line, no?  If the patch is to use

	N_("git bugreport [<options>]")

as the new text, then that would be an improvement, though.

> @@ -141,6 +140,8 @@ int cmd_bugreport(int argc, const char **argv, cons=
t char *prefix)
> =20
>  	argc =3D parse_options(argc, argv, prefix, bugreport_options,
>  			     bugreport_usage, 0);
> +	if (argc)
> +		usage_with_options(bugreport_usage, bugreport_options);

This is a good change (until we gain positional argument to the
subcommand, at which time we'd need to rethink the error checking).

>  	/* Prepare the path to put the result */
>  	prefixed_filename =3D prefix_filename(prefix,
