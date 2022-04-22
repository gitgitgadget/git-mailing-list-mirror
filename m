Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A81D4C433EF
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 22:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbiDVWJg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Apr 2022 18:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232988AbiDVWIn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Apr 2022 18:08:43 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D4217D4AD
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 13:56:03 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8786418082F;
        Fri, 22 Apr 2022 14:27:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=134daF2/VQn6
        pPgw28+YG/DNc/xMu5yyG+m48JR5x+I=; b=bfJetoLugaN2w/FkyD9jrkV0FxIQ
        PbxCTNlbOrxJKCzmz3AYqfvT5XoJSHAP7hPYROk3LqSZ82KyS920TnkQ6/zUuwbF
        P+IO4NUKsr9Nk5g4vj+X8/IHnnm4K9tXYOnBitef5cqcL7LzZTijYCugou8UMHfP
        WcJmO6Ag4ipwaQs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8026818082E;
        Fri, 22 Apr 2022 14:27:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id F325F18082B;
        Fri, 22 Apr 2022 14:27:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Carlo Arenas <carenas@gmail.com>,
        Phillip Wood <phillip.wood@talktalk.net>
Subject: Re: [PATCH v3] CI: select CC based on CC_PACKAGE (again)
References: <patch-v2-1.1-92acf9420a9-20220421T174733Z-avarab@gmail.com>
        <patch-v3-1.1-8b3444ecc87-20220422T092015Z-avarab@gmail.com>
Date:   Fri, 22 Apr 2022 11:27:53 -0700
In-Reply-To: <patch-v3-1.1-8b3444ecc87-20220422T092015Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 22 Apr
 2022 11:20:53
        +0200")
Message-ID: <xmqqee1p9dna.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: ED4B576E-C269-11EC-9952-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Fix a regression in 707d2f2fe86 (CI: use "$runs_on_pool", not
> "$jobname" to select packages & config, 2021-11-23).
>
> In that commit I changed CC=3Dgcc from CC=3Dgcc-9, but on OSX the "gcc"=
 in
> $PATH points to clang, we need to use gcc-9 instead. Likewise for the
> linux-gcc job CC=3Dgcc-8 was changed to the implicit CC=3Dgcc, which wo=
uld
> select GCC 9.4.0 instead of GCC 8.4.0.
>
> Furthermore in 25715419bf4 (CI: don't run "make test" twice in one
> job, 2021-11-23) when the "linux-TEST-vars" job was split off from
> "linux-gcc" the "cc_package: gcc-8" line was copied along with
> it, so its "cc_package" line wasn't working as intended either.
>
> As a table, this is what's changed by this commit, i.e. it only
> affects the linux-gcc, linux-TEST-vars and osx-gcc jobs:
>
> 	|-------------------+-----------+-------------------+-------+-------|
> 	| jobname           | vector.cc | vector.cc_package | old   | new   |
> 	|-------------------+-----------+-------------------+-------+-------|
> 	| linux-clang       | clang     | -                 | clang | clang |
> 	| linux-sha256      | clang     | -                 | clang | clang |
> 	| linux-gcc         | gcc       | gcc-8             | gcc   | gcc-8 |
> 	| osx-clang         | clang     | -                 | clang | clang |
> 	| osx-gcc           | gcc       | gcc-9             | clang | gcc-9 |
> 	| linux-gcc-default | gcc       | -                 | gcc   | gcc   |
> 	| linux-TEST-vars   | gcc       | gcc-8             | gcc   | gcc-8 |
> 	|-------------------+-----------+-------------------+-------+-------|
>
> Reported-by: Carlo Arenas <carenas@gmail.com>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>
> I just dropped the linux-TEST-vars change from the v2 in lieu of
> trying to get the wording in the commit message right.

OK.  So linux-gcc and linux-gcc-default jobs use different compilers
(if gcc and gcc-8 are different), osx-gcc uses gcc-9 instead of clang.

Thanks.  Will queue.

> diff --git a/ci/lib.sh b/ci/lib.sh
> index cbc2f8f1caa..86e37da9bc5 100755
> --- a/ci/lib.sh
> +++ b/ci/lib.sh
> @@ -122,7 +122,7 @@ then
>  	test macos !=3D "$CI_OS_NAME" || CI_OS_NAME=3Dosx
>  	CI_REPO_SLUG=3D"$GITHUB_REPOSITORY"
>  	CI_JOB_ID=3D"$GITHUB_RUN_ID"
> -	CC=3D"${CC:-gcc}"
> +	CC=3D"${CC_PACKAGE:-${CC:-gcc}}"
>  	DONT_SKIP_TAGS=3Dt
> =20
>  	cache_dir=3D"$HOME/none"
