Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 615AAC433EF
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 19:55:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239893AbhLHT7C (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 14:59:02 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56141 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236468AbhLHT67 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 14:58:59 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 30F5D15EAE3;
        Wed,  8 Dec 2021 14:55:25 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=y9jyFANOJ8V/
        CPhFdY1oGfdJ/1DwM8Zy0tnb8TQRwQM=; b=ZoLL4Jqp4zpm0efBZYGVW+GKC9Gk
        t5JN1gm+INfYlCTsHjcVjjaXWewElA0mSx2sbquu54uyKRecdgoyz3AZkeL77eyl
        LSiD+ubxj4dsJAP9nMyLyWi+2kwg4Mdeeu01OjcuUnj8OL8WP5TEbCWrCJItEL6q
        4S6BqPwzAFKymI4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 29D1B15EAE2;
        Wed,  8 Dec 2021 14:55:25 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6727115EAE0;
        Wed,  8 Dec 2021 14:55:20 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>, Matt Rogers <mattr94@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v10 00/15] Upstreaming the Scalar command
References: <pull.1005.v9.git.1638273289.gitgitgadget@gmail.com>
        <pull.1005.v10.git.1638538470.gitgitgadget@gmail.com>
        <CABPp-BGpe9Q5k22Yu8a=1xwu=pZYSeNQoqEgf+DN07cU4EB1ew@mail.gmail.com>
        <xmqq4k7nmksi.fsf@gitster.g>
        <211207.86ilw0matb.gmgdl@evledraar.gmail.com>
Date:   Wed, 08 Dec 2021 11:55:18 -0800
In-Reply-To: <211207.86ilw0matb.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 07 Dec 2021 21:05:31 +0100")
Message-ID: <xmqqh7bi27o9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C60B8494-5860-11EC-937A-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> It was just broken because it added a test run to the "pedantic" run,
> and didn't properly integrate with the multi-"make test" runs on
> "master" , both of which are addressed by the patch below.
>
> diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
> index 2ef9fbfdd38..af99699f82b 100755
> --- a/ci/run-build-and-tests.sh
> +++ b/ci/run-build-and-tests.sh
> @@ -15,6 +15,26 @@ then
>  	export DEVOPTS=3Dpedantic
>  fi
> =20
> +make() {
> +	scalar_tests=3D
> +	for target
> +	do
> +		if test $target =3D "test"
> +		then
> +			scalar_tests=3Dt
> +		fi
> +	done
> +
> +	# Do whatever we would have done with "make"
> +	command make "$@"
> +
> +	# Running tests? Run scalar tests too
> +	if test -n "$scalar_tests"
> +	then
> +		command make -C contrib/scalar test
> +	fi
> +}
> +
>  make
>  case "$jobname" in
>  linux-gcc)
> @@ -52,6 +72,4 @@ esac
> =20
>  check_unignored_build_artifacts
> =20
> -make && make -C contrib/scalar test
> -
>  save_good_tree

That is an interesting way to demonstrate how orthogonal the issues
are, which in turn means that it is not such a big deal to add back
the coverage to the part that goes to contrib/scalar/.  As the actual
implementation, it is a bit too icky, though.
