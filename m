Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A493EC433EF
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 19:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241001AbiDUTLY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 15:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380740AbiDUTLW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 15:11:22 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6B64CD43
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 12:08:30 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 874BF1284C7;
        Thu, 21 Apr 2022 15:08:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=DupzCLHXNMgW
        OxHMkjiWF7Qt41aVZpf7lGa3+HhDKws=; b=wA6gdeOChOiudXFclQ85X2jOPI1I
        QAIslBaSQYqa4HToGnje5VvVNydkJbauABy1hqX7UUpmyaNOLzZ1XtgZVpD7HNZV
        J9rao/Y8l3HTZ/y/cs81HByOwuj5uHfHAknrva0EbIs+1IYzWylOa8LHEAH1JXqX
        24nyh+SEaD+Bu/E=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7DBBD1284C6;
        Thu, 21 Apr 2022 15:08:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DD14A1284C5;
        Thu, 21 Apr 2022 15:08:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Carlo Arenas <carenas@gmail.com>,
        Phillip Wood <phillip.wood@talktalk.net>
Subject: Re: [PATCH v2] CI: select CC based on CC_PACKAGE (again)
References: <patch-1.1-d89ad4d5b7c-20220421T130310Z-avarab@gmail.com>
        <patch-v2-1.1-92acf9420a9-20220421T174733Z-avarab@gmail.com>
Date:   Thu, 21 Apr 2022 12:08:27 -0700
In-Reply-To: <patch-v2-1.1-92acf9420a9-20220421T174733Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 21 Apr
 2022 19:48:28
        +0200")
Message-ID: <xmqqzgkegspg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6D9AE2BE-C1A6-11EC-993B-5E84C8D8090B-77302942!pb-smtp1.pobox.com
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

Thanks for diagnosing how things were broken.

> On Thu, Apr 21 2022, Phillip Wood wrote:
>
>> CC is set in .github/workflows/main.yaml for the ubuntu and macos jobs
>> so I think they will not fallback to using CC_PACKAGE and therefore
>> not pick up the correct compiler.
> ...
> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> index c35200defb9..f12819a00d7 100644
> --- a/.github/workflows/main.yml
> +++ b/.github/workflows/main.yml
> @@ -236,7 +236,6 @@ jobs:
>            - jobname: linux-TEST-vars
>              cc: gcc
>              os: ubuntu
> -            cc_package: gcc-8
>              pool: ubuntu-latest
>            - jobname: osx-clang
>              cc: clang
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

OK, so we favor CC_PACKAGE (from the matrix.vector.cc_package) if
set, and then cc (again, from the matrix.vector.cc) if set, and then
finally use "gcc" as a fallback.  In the osx-gcc job, cc_package is
set to gcc-9 while in the osx-clang, cc is gcc that confusingly calls
for clang.  That sounds like it would do the right thing for two
macs.

For other jobs with different settings for cc and cc_package, does
this have any effect?  I do not think I saw any mention in the
proposed log message.

		vector.cc	vector.cc_package	old	new
linux-clang	clang		-			clang	clang
linux-sha256	clang		-			clang	clang
linux-gcc	gcc		gcc-8			gcc	gcc-8
osx-clang	clang		-			clang	clang
osx-gcc		gcc		gcc-9			clang	gcc-9
linux-gcc-default gcc		-			gcc	gcc

So, linux-gcc job used to use whichever "gcc" the platform gave us,
but now it explicitly asks for gcc-8, which may or may not be
different from what linux-gcc-default uses, and there is no other
difference by this change.  We may get a better test coverage (if
the default gcc is not gcc-8) or no improvement (if the default is
gcc-8), so it is a strict improvement worth recording as an intended
side effect in the proposed log message to help future developers.

Other than that, looks good to me.

