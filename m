Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A0D8C433F5
	for <git@archiver.kernel.org>; Sat, 25 Dec 2021 01:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbhLYBEG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Dec 2021 20:04:06 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65110 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhLYBEF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Dec 2021 20:04:05 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 53968F99B0;
        Fri, 24 Dec 2021 20:04:04 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=B78hKipjaHg02TeGh90LM/up2d7odcKke1hSs0
        ju/j4=; b=bWHhALuJImKjAecWkLEggZi/VvIoPuT/cbB2rwEYSIzhZYGQ3UFlnB
        8W5o0E/e4/3Lx8WjufKCWLWSBpYwVMBH5VuVQCXQUltcjU3ZxBHp42NgcSZml2km
        P4x35FSIErKdRCQpSJwZqrmTvmGQCVxzdzpJmX7hJWzUXfg5Sabwc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 33D9BF99AE;
        Fri, 24 Dec 2021 20:04:04 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2AD41F99AA;
        Fri, 24 Dec 2021 20:04:03 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: Re* [PATCH v5 3/7] grep tests: add missing "grep.patternType"
 config test
References: <cover-v4-0.7-00000000000-20211203T101348Z-avarab@gmail.com>
        <cover-v5-0.7-00000000000-20211222T025214Z-avarab@gmail.com>
        <patch-v5-3.7-f02f246aa23-20211222T025214Z-avarab@gmail.com>
        <xmqq35mj7yd4.fsf@gitster.g> <xmqqfsqh35vu.fsf_-_@gitster.g>
Date:   Fri, 24 Dec 2021 17:04:02 -0800
In-Reply-To: <xmqqfsqh35vu.fsf_-_@gitster.g> (Junio C. Hamano's message of
        "Fri, 24 Dec 2021 16:06:13 -0800")
Message-ID: <xmqqwnjt5wcd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8D13C62C-651E-11EC-936B-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I'll tentatively queue the following patch between your 3/7 and 4/7,
> but it probably is a good idea to squash it into 3/7, as it belongs
> to the same theme: clarify how these two variables are meant to
> interact with each other.

Just as I suspected earlier, up to the [PATCH 6/7] of the series
passes this test and this test reveals the breakage in [PATCH 7/7].

In the review of that step, I said "I am not sure how any change
that says we do not need the "commit" phase can be correct." but
come to think of it, it was a bit too strong.  It is possible to
implement correct semantics without the "commit" phase, as long as
we do not try to decide between basic and extended too hastily when
we see grep.patternType=default, before we are sure that we will not
see any new definition of grep.extendedRegexp [*].  In the extreme,
we could keep it as 'default' until the time just before we compile
the regexp and consult the final value of grep.extendedRegexp to
decide between the two, and such an implementation would still give
correct results without having to have a "commit" phase.


[Footnote]

* The story is the same for the `--patternType=default` command line
  option, but by the time we read the command line option, we should
  be already done with the configuration, and there is no command
  line option to override the grep.extendedRegexp configuration
  variable, so we do not have to worry about that case.  When we
  read --patternType=default from the command line, we can safely
  use the value we know about grep.extendedRegexp and decide to use
  either basic or extended.

  But that is not true for grep.patternType configuration varialble,
  as the additional test I am responding to shows.

> ----- >8 --------- >8 --------- >8 --------- >8 --------- >8 --------- >8 ----
> Subject: [PATCH] t7810: make sure grep.extendedRegexp is also last-one-wins
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  t/t7810-grep.sh | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
> index 113902c3bd..2c17704e01 100755
> --- a/t/t7810-grep.sh
> +++ b/t/t7810-grep.sh
> @@ -451,6 +451,16 @@ do
>  		test_cmp expected actual
>  	'
>  
> +	test_expect_success "grep $L with grep.extendedRegexp is last-one-wins" '
> +		echo "${HC}ab:a+bc" >expected &&
> +		git \
> +			-c grep.extendedRegexp=true \
> +			-c grep.patternType=default \
> +			-c grep.extendedRegexp=false \
> +			grep "a+b*c" $H ab >actual &&
> +		test_cmp expected actual
> +	'
> +
>  	test_expect_success "grep $L with grep.patternType=extended and grep.patternType=default" '
>  		echo "${HC}ab:a+bc" >expected &&
>  		git \
