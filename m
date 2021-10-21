Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD3A7C433EF
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 23:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B80F9610CB
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 23:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbhJUXc5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 19:32:57 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63595 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhJUXc4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 19:32:56 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 065CC150FA6;
        Thu, 21 Oct 2021 19:30:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ZcCihps+L1dR
        KB645fvAs5UFuMy3keSEogzQttKrLX4=; b=qho7GhxNZ4k7YhIsgE3Z4wVAN5tb
        qBhAv1R+VXHAxq3rrhd+BWAomETb1EbaJAP/QNjNA+wmYeU4UlefeJFpQFbKMFZS
        +7cuMI1VX8UokGrToY9k+cyzvQ8QnJxiuECaxb87uZbmkOuLBr38tR8x0lIP/21r
        nwvSEEOeK6FBHr8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F3C1D150FA5;
        Thu, 21 Oct 2021 19:30:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 586E6150FA3;
        Thu, 21 Oct 2021 19:30:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Andrzej Hunt <andrzej@ahunt.org>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH v2 2/3] config.c: don't leak memory in
 handle_path_include()
References: <patch-1.1-5a47bf2e9c9-20211021T114223Z-avarab@gmail.com>
        <cover-v2-0.3-00000000000-20211021T195133Z-avarab@gmail.com>
        <patch-v2-2.3-d6d04da1d9d-20211021T195133Z-avarab@gmail.com>
Date:   Thu, 21 Oct 2021 16:30:36 -0700
In-Reply-To: <patch-v2-2.3-d6d04da1d9d-20211021T195133Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 21 Oct
 2021 21:54:14
        +0200")
Message-ID: <xmqqmtn2gdlv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E5501B40-32C6-11EC-83EA-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Fix a memory leak in the error() path in handle_path_include(), this
> allows us to run t1305-config-include.sh under SANITIZE=3Dleak,
> previously 4 tests there would fail. This fixes up a leak in
> 9b25a0b52e0 (config: add include directive, 2012-02-06).
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  config.c                  | 7 +++++--
>  t/t1305-config-include.sh | 1 +
>  2 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/config.c b/config.c
> index 2dcbe901b6b..c5873f3a706 100644
> --- a/config.c
> +++ b/config.c
> @@ -148,8 +148,10 @@ static int handle_path_include(const char *path, s=
truct config_include_data *inc

Not a problem introduced by this function, but if you look at this
change with "git show -W", we'd notice that the function name on the
hunk header looks strange.  I think we should add a blank line
before the beginning of the function.

>  	if (!is_absolute_path(path)) {
>  		char *slash;
> =20
> -		if (!cf || !cf->path)
> -			return error(_("relative config includes must come from files"));
> +		if (!cf || !cf->path) {
> +			ret =3D error(_("relative config includes must come from files"));
> +			goto cleanup;
> +		}
> =20
>  		slash =3D find_last_dir_sep(cf->path);
>  		if (slash)
> @@ -167,6 +169,7 @@ static int handle_path_include(const char *path, st=
ruct config_include_data *inc
>  		ret =3D git_config_from_file(git_config_include, path, inc);
>  		inc->depth--;
>  	}
> +cleanup:
>  	strbuf_release(&buf);
>  	free(expanded);
>  	return ret;

Quite straight-forward.  At the point of the new "goto cleanup", the
expanded pointer has already been established, so these two calls
will release the right resource.

Thanks.

> diff --git a/t/t1305-config-include.sh b/t/t1305-config-include.sh
> index ccbb116c016..5cde79ef8c4 100755
> --- a/t/t1305-config-include.sh
> +++ b/t/t1305-config-include.sh
> @@ -1,6 +1,7 @@
>  #!/bin/sh
> =20
>  test_description=3D'test config file include directives'
> +TEST_PASSES_SANITIZE_LEAK=3Dtrue
>  . ./test-lib.sh
> =20
>  # Force setup_explicit_git_dir() to run until the end. This is needed
