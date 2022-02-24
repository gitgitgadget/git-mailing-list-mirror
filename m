Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B31C433F5
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 19:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbiBXTD1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 14:03:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbiBXTD0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 14:03:26 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921B912D22E
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 11:02:56 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D2DFD174472;
        Thu, 24 Feb 2022 14:02:55 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=k6aW8kOKlF4JrkdVmcCz/IKotNVqdFA7dM0OsM
        O7x20=; b=U1IvGF+LD9YSnLQD5NoSeQDhnA81l+IFNgY8npJe6td85nlmhi+Dgx
        4L5nsF1XumMt/FiI6GCYGhHBd/wJVc4r2QeSL3htcUMBbpdzKmvMMIf44X3wxy+Y
        c9MW33IdAeW5NR5c4So0+sITBRIYYFqpI2WciinWL7TvsRHLKQe5I=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CBE91174471;
        Thu, 24 Feb 2022 14:02:55 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3E4F5174470;
        Thu, 24 Feb 2022 14:02:53 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, pclouds@gmail.com
Subject: Re: [PATCH v2] switch: mention the --detach option when dying due
 to lack of a branch
References: <20220224064710.2252637-1-alexhenrie24@gmail.com>
Date:   Thu, 24 Feb 2022 11:02:52 -0800
In-Reply-To: <20220224064710.2252637-1-alexhenrie24@gmail.com> (Alex Henrie's
        message of "Wed, 23 Feb 2022 23:47:10 -0700")
Message-ID: <xmqqv8x4m6jn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5E6857E6-95A4-11EC-A63A-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index d9b31bbb6d..9244827ca0 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -1397,23 +1397,31 @@ static void die_expecting_a_branch(const struct branch_info *branch_info)
>  {
>  	struct object_id oid;
>  	char *to_free;
> +	int code;
>  
>  	if (dwim_ref(branch_info->name, strlen(branch_info->name), &oid, &to_free, 0) == 1) {
>  		const char *ref = to_free;
>  
>  		if (skip_prefix(ref, "refs/tags/", &ref))
> -			die(_("a branch is expected, got tag '%s'"), ref);
> -		if (skip_prefix(ref, "refs/remotes/", &ref))
> -			die(_("a branch is expected, got remote branch '%s'"), ref);
> -		die(_("a branch is expected, got '%s'"), ref);
> +			code = die_message(_("a branch is expected, got tag '%s'"), ref);
> +		else if (skip_prefix(ref, "refs/remotes/", &ref))
> +			code = die_message(_("a branch is expected, got remote branch '%s'"), ref);
> +		else
> +			code = die_message(_("a branch is expected, got '%s'"), ref);
>  	}
> -	if (branch_info->commit)
> -		die(_("a branch is expected, got commit '%s'"), branch_info->name);

In the original code, when dwim_ref() said there is a unique hit, we
died with varying messages.  So it was OK to have this check not as
a part of if/elseif/... cascade.

> -	/*
> -	 * This case should never happen because we already die() on
> -	 * non-commit, but just in case.
> -	 */
> -	die(_("a branch is expected, got '%s'"), branch_info->name);
> +	else if (branch_info->commit)

But now, new code only sets code without dying, so we avoid
overwriting the code (and calling die_message() twice) by turning it
"else if".  OK.

> +		code = die_message(_("a branch is expected, got commit '%s'"), branch_info->name);
> +	else
> +		/*
> +		 * This case should never happen because we already die() on
> +		 * non-commit, but just in case.
> +		 */
> +		code = die_message(_("a branch is expected, got '%s'"), branch_info->name);

OK.  So "code" gets assigned exactly once in the above
if/elseif/... cascade.  Not defining the variable with
initialization at the beginning of this function is correct.

> +	if (advice_enabled(ADVICE_SUGGEST_DETACHING_HEAD))
> +		advise(_("If you want to detach HEAD at the commit, try again with the --detach option."));
> +
> +	exit(code);
>  }

OK.

> diff --git a/t/t2060-switch.sh b/t/t2060-switch.sh
> index ebb961be29..f54691bac9 100755
> --- a/t/t2060-switch.sh
> +++ b/t/t2060-switch.sh
> @@ -32,6 +32,17 @@ test_expect_success 'switch and detach' '
>  	test_must_fail git symbolic-ref HEAD
>  '
>  
> +test_expect_success 'suggestion to detach' '
> +	test_must_fail git switch main^{commit} 2>stderr &&
> +	test_i18ngrep "try again with the --detach option" stderr
> +'
> +
> +test_expect_success 'suggestion to detach is suppressed with advice.suggestDetachingHead=false' '
> +	test_config advice.suggestDetachingHead false &&
> +	test_must_fail git switch main^{commit} 2>stderr &&
> +	test_i18ngrep ! "try again with the --detach option" stderr
> +'

OK, we try to be consistent with other tests in the file, and leave
s/test_i18n// to a file-wide clean-up outside the topic.

>  test_expect_success 'switch and detach current branch' '
>  	test_when_finished git switch main &&
>  	git switch main &&
