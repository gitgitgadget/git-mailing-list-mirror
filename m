Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4332C433F5
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 22:34:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343649AbhLAWiC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 17:38:02 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54626 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234078AbhLAWiB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 17:38:01 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9B34B17381C;
        Wed,  1 Dec 2021 17:34:39 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CxuDaiy0fYt8DsaKsxE3g6YVDrSnrWfq9y3ZK7
        MxmeI=; b=O/TXKnJWs8YXRZFCoyekYQcn/GSEKcEfa0O+4hY+tieucVzCAc5kOK
        qW8j3+aHzLgW6qeSv4VZcaEY1YWlJ2LPcaczak4e9RiSBQkQnGWVZ3R7irurbvkM
        WnUgJeZrtx9Hls5q9z+HaU/4MqK7GFQuBQIi4QBbK9ay6SKHMS6vY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 939F317381B;
        Wed,  1 Dec 2021 17:34:39 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4C28C17381A;
        Wed,  1 Dec 2021 17:34:35 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Slavica =?utf-8?B?xJB1a2nEhw==?= <slawica92@hotmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/2] add -i: default to the built-in implementation
References: <pull.1087.git.1638281655.gitgitgadget@gmail.com>
        <84824918ae4564a9194a1a55124ee8694f210437.1638281655.git.gitgitgadget@gmail.com>
Date:   Wed, 01 Dec 2021 14:34:33 -0800
In-Reply-To: <84824918ae4564a9194a1a55124ee8694f210437.1638281655.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Tue, 30 Nov 2021
        14:14:15 +0000")
Message-ID: <xmqqee6wymx2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DC4F61B8-52F6-11EC-82CD-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> In 9a5315edfdf (Merge branch 'js/patch-mode-in-others-in-c',
> 2020-02-05), Git acquired a built-in implementation of `git add`'s
> interactive mode that could be turned on via the config option
> `add.interactive.useBuiltin`.
>
> The first official Git version to support this knob was v2.26.0.
>
> In 2df2d81ddd0 (add -i: use the built-in version when
> feature.experimental is set, 2020-09-08), this built-in implementation
> was also enabled via `feature.experimental`. The first version with this
> change was v2.29.0.
>
> More than a year (and very few bug reports) later, it is time to declare
> the built-in implementation mature and to turn it on by default.

I think that declaration is a bit premature.  I do agree that by now
we should have killed as many bugs as we could without unleashing it
tot he general public by keeping it behind the experimental flag, and
we should move forward by turn it on by default.  In a month or two
after this change hits a stable release of major distros, we can learn
that the implementation was mature, but not until then ;-).


> We specifically leave the `add.interactive.useBuiltin` configuration in
> place, to give users an "escape hatch" in the unexpected case should
> they encounter a previously undetected bug in that implementation.

Good thinking.

>  add.interactive.useBuiltin::
> -	[EXPERIMENTAL] Set to `true` to use the experimental built-in
> -	implementation of the interactive version of linkgit:git-add[1]
> -	instead of the Perl script version. Is `false` by default.
> +	Set to `false` to fall back to the original Perl implementation of
> +	the interactive version of linkgit:git-add[1] instead of the built-in
> +	version. Is `true` by default.
> diff --git a/builtin/add.c b/builtin/add.c
> index ef6b619c45e..8ef230a345b 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -237,17 +237,12 @@ int run_add_interactive(const char *revision, const char *patch_mode,
>  	int use_builtin_add_i =
>  		git_env_bool("GIT_TEST_ADD_I_USE_BUILTIN", -1);
>  
> -	if (use_builtin_add_i < 0) {
> -		int experimental;
> -		if (!git_config_get_bool("add.interactive.usebuiltin",
> -					 &use_builtin_add_i))
> -			; /* ok */
> -		else if (!git_config_get_bool("feature.experimental", &experimental) &&
> -			 experimental)
> -			use_builtin_add_i = 1;
> -	}
> +	if (use_builtin_add_i < 0 &&
> +	    git_config_get_bool("add.interactive.usebuiltin",
> +				&use_builtin_add_i))
> +		use_builtin_add_i = 1;
>  
> -	if (use_builtin_add_i == 1) {
> +	if (use_builtin_add_i != 0) {

Nit.

	if (use_builtin_add_i) {

I wondered if these random calls to git_config_get_X() should be
consolidated into the existing add_config() callback, but this
conditional will go away hopefully in a few releases, so it probably
is not worth it.  Inheriting the way the original code grabbed the
configuration variables is good enough for our purpose here.

> diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
> index cc62616d806..660ebe8d108 100755
> --- a/ci/run-build-and-tests.sh
> +++ b/ci/run-build-and-tests.sh
> @@ -29,7 +29,7 @@ linux-gcc)
>  	export GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=1
>  	export GIT_TEST_MULTI_PACK_INDEX=1
>  	export GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=1
> -	export GIT_TEST_ADD_I_USE_BUILTIN=1
> +	export GIT_TEST_ADD_I_USE_BUILTIN=0
>  	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
>  	export GIT_TEST_WRITE_REV_INDEX=1
>  	export GIT_TEST_CHECKOUT_WORKERS=2

OK.

> diff --git a/t/README b/t/README
> index 29f72354bf1..2c22337d6e7 100644
> --- a/t/README
> +++ b/t/README
> @@ -419,7 +419,7 @@ the --sparse command-line argument.
>  GIT_TEST_PRELOAD_INDEX=<boolean> exercises the preload-index code path
>  by overriding the minimum number of cache entries required per thread.
>  
> -GIT_TEST_ADD_I_USE_BUILTIN=<boolean>, when true, enables the
> +GIT_TEST_ADD_I_USE_BUILTIN=<boolean>, when false, disables the
>  built-in version of git add -i. See 'add.interactive.useBuiltin' in
>  git-config(1).
>  
> diff --git a/t/t2016-checkout-patch.sh b/t/t2016-checkout-patch.sh
> index 71c5a15be00..bc3f69b4b1d 100755
> --- a/t/t2016-checkout-patch.sh
> +++ b/t/t2016-checkout-patch.sh
> @@ -4,7 +4,7 @@ test_description='git checkout --patch'
>  
>  . ./lib-patch-mode.sh
>  
> -if ! test_bool_env GIT_TEST_ADD_I_USE_BUILTIN false && ! test_have_prereq PERL
> +if ! test_bool_env GIT_TEST_ADD_I_USE_BUILTIN true && ! test_have_prereq PERL
>  then
>  	skip_all='skipping interactive add tests, PERL not set'
>  	test_done

Looks good.

Thanks.
