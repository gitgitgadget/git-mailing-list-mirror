Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A80C6C433ED
	for <git@archiver.kernel.org>; Sun, 16 May 2021 12:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C21E610F7
	for <git@archiver.kernel.org>; Sun, 16 May 2021 12:53:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbhEPMyY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 May 2021 08:54:24 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65046 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232828AbhEPMyV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 May 2021 08:54:21 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8BB2713408B;
        Sun, 16 May 2021 08:53:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=xBnMEXEC+sqm
        PzB9Km96qbCEKtadeZCPrlEflzhLARY=; b=QXiAY4t9f+QOboqS5TC7YTpgx0r3
        1v2WBnJSWsBZ65FjkRvMhrcTQTcr85x9jGL/RHdc1jR8eF4rAoMWF4qySWiW0KcW
        uP8qyyQOGP2TrwANKBPvEeyzMnnF0q66W0v1NXtvT7AEZjGTUf1tZwnpJkUrh490
        BeFrVIHvAxoX9X8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8400913408A;
        Sun, 16 May 2021 08:53:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CDE6A134089;
        Sun, 16 May 2021 08:53:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Wolfgang =?utf-8?Q?M=C3=BCller?= <wolf@oriole.systems>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH] rev-parse: fix segfault with missing --path-format
 argument
References: <20210516120449.661636-1-wolf@oriole.systems>
Date:   Sun, 16 May 2021 21:53:01 +0900
In-Reply-To: <20210516120449.661636-1-wolf@oriole.systems> ("Wolfgang
        =?utf-8?Q?M=C3=BCller=22's?= message of "Sun, 16 May 2021 14:04:49 +0200")
Message-ID: <xmqqsg2m6dsi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A72B7538-B645-11EB-92CE-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Wolfgang M=C3=BCller <wolf@oriole.systems> writes:

> Calling "git rev-parse --path-format" without an argument segfaults
> instead of giving an error message. Commit fac60b8925 (rev-parse: add
> option for absolute or relative path formatting, 2020-12-13) added the
> argument parsing code but forgot to handle NULL.
>
> Returning an error makes sense here because there is no default value w=
e
> could use. Add a test case to verify.
>
> Signed-off-by: Wolfgang M=C3=BCller <wolf@oriole.systems>
> ---
> Since this is my first contribution to the project and I'm still
> learning the ropes, I left this patch as RFC.
>
> For a bit of background information, I ran into this expecting the
> following to work:
>
> 	git rev-parse --path-format relative --show-toplevel
>
> I'm unsure how many git subcommands specifically require "=3D" between =
the
> option and the argument, but before now I always expected things to
> "just work" when leaving it out.
>
> This fix is based on maint.
>
> Thanks for your time and attention.

Nicely done.

>  builtin/rev-parse.c  | 2 ++
>  t/t1500-rev-parse.sh | 4 ++++
>  2 files changed, 6 insertions(+)
>
> diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
> index 85bad9052e..7af8dab8bc 100644
> --- a/builtin/rev-parse.c
> +++ b/builtin/rev-parse.c
> @@ -759,6 +759,8 @@ int cmd_rev_parse(int argc, const char **argv, cons=
t char *prefix)
>  				continue;
>  			}
>  			if (opt_with_value(arg, "--path-format", &arg)) {
> +				if (!arg)
> +					die("--path-format requires an argument");

As die() is end-user facing, you'd probably want

	die(_("--path-format requires an argument"));

We do have untranslated die() nearby for the same option, which may
want to be cleaned up either in a preliminary patch, or in this same
patch as an unrelated fix "while we are at it".

>  				if (!strcmp(arg, "absolute")) {
>  					format =3D FORMAT_CANONICAL;
>  				} else if (!strcmp(arg, "relative")) {
> diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
> index deae916707..a1a8ce5265 100755
> --- a/t/t1500-rev-parse.sh
> +++ b/t/t1500-rev-parse.sh
> @@ -146,6 +146,10 @@ test_expect_success '--path-format can change in t=
he middle of the command line'
>  	test_cmp expect actual
>  '
> =20
> +test_expect_success '--path-format does not segfault without an argume=
nt' '
> +	test_must_fail git rev-parse --path-format --show-toplevel

The above is certainly worth testing for, but if we ever upgrade the
command line parser of "rev-parse" to be compatible with the parser
based on the parse-options API to allow both "--opt=3Dval" and "--opt
val", it will start to fail for an entirely different reason, namely
"--show-toplevel" will be taken as the argument to "--path-format",
and we'd get "unknown argument to --path-format".  So it might be
prudent to test both, i.e.

	test_must_fail git rev-parse --path-format --show-toplevel &&
	test_must_fail git rev-parse --show-toplevel --path-format
