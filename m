Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15AB0C433EF
	for <git@archiver.kernel.org>; Fri, 15 Apr 2022 18:31:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346657AbiDOSd7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Apr 2022 14:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346620AbiDOSd4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Apr 2022 14:33:56 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A306A8BE36
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 11:31:25 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 00305194AB0;
        Fri, 15 Apr 2022 14:31:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=OlOdE4VJX0jl
        B6QiBv8dG4xSUrZTS8X/MfK3T4GE85A=; b=Yx18OP3pZYfJDk8MvvYgEwMTPVsT
        NYoLErlW4RAYus3WE99iuC8078h2Ouzav7QfRs2H8prRgaSnGtX8zWtmAVfbFcmF
        RK+D7Cl+sIxE8q7pOcQ/uIM66YuFrDb+QOS3blhuhGboENslGmZpucMTVCpQHDeB
        RAU/da69LTs9x+U=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EC179194AAF;
        Fri, 15 Apr 2022 14:31:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 798C8194AA7;
        Fri, 15 Apr 2022 14:31:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, avarab@gmail.com
Subject: Re: [PATCH] ci: lock "pedantic" job into fedora 35 and other cleanup
References: <20220415123922.30926-1-carenas@gmail.com>
Date:   Fri, 15 Apr 2022 11:31:20 -0700
In-Reply-To: <20220415123922.30926-1-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Fri, 15 Apr 2022 05:39:22 -0700")
Message-ID: <xmqqwnfqci6f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3F7CA05E-BCEA-11EC-978D-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

> Fedora 36 is scheduled to be released in Apr 19th, but it includes
> a prerelease of gcc 12 that has known issues[1] with our codebase
> and therefore requires extra changes to not break a DEVELOPER=3D1
> build.
>
> Lock the CI job to the current release image, and while at it rename
> the job to better reflect what it is currently doing, instead of its
> original objective.

Please spell out what "original objective" is, why we are changing
the purpose of the target, and how such a change is justifiable.

I've always thought that the original objective was to try to see if
we still compile with the "-pedantic" option on.  Is it now "we want
to make sure a recent but not latest version of Fedora is OK"?  Why
do we want to do so?

Please write your log message with an explicit focus to help the
future developers decide, when they want to bump the version from 35
to say 40 in the future, if it does or does not violate the spirit
of this change.

> Finally add git which was a known[2] issue for a while.

Instead of referring to an external message, spell it out, it is not
all that long.

    Without working "git" installed, "save_good_tree" step in the CI
    were not running correctly at all.  This was originally noticed
    in [2]; take the fix suggested there.

All in all, each of these three independent and unrelated changes
may individually be a good thing to do on its own (or may not be),
i.e.

 * Avoid fedora 36 and later at least for now
 * Do not build with pedantic any more
 * Install "git" to help "save_good_tree" step in the CI

but they are unrelated changes that deserves their own justification.


> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> index c35200defb9..48e212f4110 100644
> --- a/.github/workflows/main.yml
> +++ b/.github/workflows/main.yml
> @@ -282,8 +282,8 @@ jobs:
>          - jobname: linux32
>            os: ubuntu32
>            image: daald/ubuntu32:xenial
> -        - jobname: pedantic
> -          image: fedora
> +        - jobname: fedora
> +          image: fedora:35
>      env:
>        jobname: ${{matrix.vector.jobname}}
>      runs-on: ubuntu-latest
> diff --git a/ci/install-docker-dependencies.sh b/ci/install-docker-depe=
ndencies.sh
> index 78b7e326da6..660e25d1d26 100755
> --- a/ci/install-docker-dependencies.sh
> +++ b/ci/install-docker-dependencies.sh
> @@ -15,8 +15,8 @@ linux-musl)
>  	apk add --update build-base curl-dev openssl-dev expat-dev gettext \
>  		pcre2-dev python3 musl-libintl perl-utils ncurses >/dev/null
>  	;;
> -pedantic)
> +fedora)
>  	dnf -yq update >/dev/null &&
> -	dnf -yq install make gcc findutils diffutils perl python3 gettext zli=
b-devel expat-devel openssl-devel curl-devel pcre2-devel >/dev/null
> +	dnf -yq install make gcc git findutils diffutils perl python3 gettext=
 zlib-devel expat-devel openssl-devel curl-devel pcre2-devel >/dev/null
>  	;;
>  esac
> diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
> index 280dda7d285..de0f8d36d7c 100755
> --- a/ci/run-build-and-tests.sh
> +++ b/ci/run-build-and-tests.sh
> @@ -37,10 +37,9 @@ linux-clang)
>  linux-sha256)
>  	export GIT_TEST_DEFAULT_HASH=3Dsha256
>  	;;
> -pedantic)
> +fedora)
>  	# Don't run the tests; we only care about whether Git can be
>  	# built.
> -	export DEVOPTS=3Dpedantic
>  	export MAKE_TARGETS=3Dall
>  	;;
>  esac
