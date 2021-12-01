Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC3BC433F5
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 22:25:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353573AbhLAW2f (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 17:28:35 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62721 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353470AbhLAW2e (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 17:28:34 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F17F2FA996;
        Wed,  1 Dec 2021 17:25:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tSAJ9bun3h+pv3k71jJyT/pADf6GTMJydhDmWT
        2HQ4M=; b=bJUfnq1aC2LgA1JBGSV1AWNYUO0KPzCaYdRJmV6FX5kbCp6R8lh9HH
        iPxev1qn+fG2YaRax1XPaq7Fs7KhxlgcM0HtDJS9l9DdSmivKkRpCKIAl1fLH/rX
        YTNuKbj5dGPM4NP692+Z+unC4m9azSxgfy2GIbyJ4Na1Tw19McJQs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E7303FA994;
        Wed,  1 Dec 2021 17:25:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 409C4FA993;
        Wed,  1 Dec 2021 17:25:12 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Slavica =?utf-8?B?xJB1a2nEhw==?= <slawica92@hotmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/2] t2016: require the PERL prereq only when necessary
References: <pull.1087.git.1638281655.gitgitgadget@gmail.com>
        <a0cf71031781b481b092d0f501bc4d78376543f3.1638281655.git.gitgitgadget@gmail.com>
Date:   Wed, 01 Dec 2021 14:25:11 -0800
In-Reply-To: <a0cf71031781b481b092d0f501bc4d78376543f3.1638281655.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Tue, 30 Nov 2021
        14:14:14 +0000")
Message-ID: <xmqqlf14ynco.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8CB6FC8E-52F5-11EC-9AF6-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> The scripted version of the interactive mode of `git add` still requires
> Perl, but the built-in version does not. Let's only require the PERL
> prereq if testing the scripted version.
>
> This addresses a long-standing NEEDSWORK added in 35166b1fb54 (t2016:
> add a NEEDSWORK about the PERL prerequisite, 2020-10-07).
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  t/t2016-checkout-patch.sh | 42 ++++++++++++++++++++-------------------
>  1 file changed, 22 insertions(+), 20 deletions(-)

Good.  I suspect there may not be too many developers who lack PERL
prerequisite around here, so it is not like the built-in version was
not sufficiently tested in developers' environment without this
patch, but it is nice to see us move in this direction.  Of course,
when we remove the non-builtin version, we'd further be able to lose
these prerequisites.

> diff --git a/t/t2016-checkout-patch.sh b/t/t2016-checkout-patch.sh
> index abfd586c32b..71c5a15be00 100755
> --- a/t/t2016-checkout-patch.sh
> +++ b/t/t2016-checkout-patch.sh
> @@ -4,7 +4,13 @@ test_description='git checkout --patch'
>  
>  . ./lib-patch-mode.sh
>  
> -test_expect_success PERL 'setup' '
> +if ! test_bool_env GIT_TEST_ADD_I_USE_BUILTIN false && ! test_have_prereq PERL
> +then
> +	skip_all='skipping interactive add tests, PERL not set'
> +	test_done
> +fi
> +
> +test_expect_success 'setup' '
>  	mkdir dir &&
>  	echo parent > dir/foo &&
>  	echo dummy > bar &&
> @@ -18,44 +24,40 @@ test_expect_success PERL 'setup' '
>  
>  # note: bar sorts before dir/foo, so the first 'n' is always to skip 'bar'
>  
> -# NEEDSWORK: Since the builtin add-p is used when $GIT_TEST_ADD_I_USE_BUILTIN
> -# is given, we should replace the PERL prerequisite with an ADD_I prerequisite
> -# which first checks if $GIT_TEST_ADD_I_USE_BUILTIN is defined before checking
> -# PERL.
> -test_expect_success PERL 'saying "n" does nothing' '
> +test_expect_success 'saying "n" does nothing' '

