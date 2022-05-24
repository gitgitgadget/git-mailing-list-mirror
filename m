Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B06C433FE
	for <git@archiver.kernel.org>; Tue, 24 May 2022 17:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239695AbiEXRpM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 13:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbiEXRpL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 13:45:11 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086E85AA58
        for <git@vger.kernel.org>; Tue, 24 May 2022 10:45:09 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C7804125B5D;
        Tue, 24 May 2022 13:45:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=C+UkOpm+NbmfkCGP7kwJr1Xkgv1f7nP+6gMQ04mF+Ow=; b=F2LJ
        5xjt6qalamn0k92to/gYiAzuO1pPErgQprF8wPJ7ywXOPCVmcsvESO9dkq26Ag7H
        E+/yBGoLWfYCHz2yZfYAiu9d4evAU7QvmbY2k2T5q0fP2n0c3BBqKxwKO/YfBQif
        GbVhFGy7H1kWCjpBC3EOio5vYNESSy3c6v6DUNE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B614F125B5B;
        Tue, 24 May 2022 13:45:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AAFA1125B5A;
        Tue, 24 May 2022 13:45:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Carl Smedstad via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Carl Smedstad <carl.smedstad@protonmail.com>
Subject: Re: [PATCH] check-ignore: --non-matching without --verbose
References: <pull.1236.git.1653310466062.gitgitgadget@gmail.com>
Date:   Tue, 24 May 2022 10:45:05 -0700
Message-ID: <xmqqfskyj04e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 40657334-DB89-11EC-A232-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Carl Smedstad via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  -n, --non-matching::
> -	Show given paths which don't match any pattern.	 This only
> -	makes sense when `--verbose` is enabled, otherwise it would
> -	not be possible to distinguish between paths which match a
> -	pattern and those which don't.

OK.  In the current code, verbose mode output can show both the
pattern that decided the fate for the path and the path itself, so
we can afford to include paths that match and that do not match.
There may not be any pattern that matched the path, or the last
pattern that matched the path was negative, or the last pattern that
matched was positive.  Users can tell them apart (the first two
cases are the paths that do not match, the last case is the paths
that do match).  But non-verbose mode only show paths, so showing
both matched and non-matching paths to the output would not make
sense.  But we document that it is a silly thing to ask, and
explicitly reject the combination of non-verbose option and
--non-matching option.

So the option is misnamed; it is more like 'include-non-matching',
not 'non-matching-only'.

> +	Only show given paths which don't match any pattern. If `--verbose` is
> +	enabled, show both paths that match a pattern and those which don't.

But this patch proposes the option to 'non-matching-only' only in
non-verbose mode.  Since "check-ignore --non-matching <pathspec>"
without "--verbose" immediately errors out, making it do something
different does not have too much backward-compatibility worries.

It may be confusing to the users that the set of paths included in
the output, when the same "-n" option is given, were different
between the non-verbose and the verbose mode.  That is one thing I
feel uncomfortable about this change.

I wonder if we are better off to invent a new "--non-matching-only"
option, have it support both the non-verbose and the verbose mode,
and leave the current "-n" alone, with an option to perhaps giving
"--include-non-matching" alias to the latter to clarify?

> diff --git a/builtin/check-ignore.c b/builtin/check-ignore.c
> index 21912569650..10e8bba1057 100644
> --- a/builtin/check-ignore.c
> +++ b/builtin/check-ignore.c
> @@ -113,8 +113,17 @@ static int check_ignore(struct dir_struct *dir,
>  			    pattern->flags & PATTERN_FLAG_NEGATIVE)
>  				pattern = NULL;
>  		}
> -		if (!quiet && (pattern || show_non_matching))
> -			output_pattern(pathspec.items[i].original, pattern);
> +		if (!quiet) {
> +			if (verbose) {
> +				if (show_non_matching || pattern)
> +					output_pattern(pathspec.items[i].original, pattern);
> +			} else {
> +				if (show_non_matching && !pattern)
> +					output_pattern(pathspec.items[i].original, pattern);
> +				if (!show_non_matching && pattern)
> +					output_pattern(pathspec.items[i].original, pattern);
> +			}
> +		}
>  		if (pattern)
>  			num_ignored++;
>  	}
> @@ -175,8 +184,6 @@ int cmd_check_ignore(int argc, const char **argv, const char *prefix)
>  		if (verbose)
>  			die(_("cannot have both --quiet and --verbose"));
>  	}
> -	if (show_non_matching && !verbose)
> -		die(_("--non-matching is only valid with --verbose"));
>  
>  	/* read_cache() is only necessary so we can watch out for submodules. */
>  	if (!no_index && read_cache() < 0)
> diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
> index 5575dade8ee..2ea178797bc 100755
> --- a/t/t0008-ignores.sh
> +++ b/t/t0008-ignores.sh
> @@ -90,7 +90,8 @@ test_check_ignore () {
>  #   1. with -q / --quiet
>  #   2. with default verbosity
>  #   3. with -v / --verbose
> -#   4. with -v / --verbose, *and* -n / --non-matching
> +#   4. with -n / --non-matching
> +#   5. with -v / --verbose, *and* -n / --non-matching
>  #
>  # expecting success each time.  Takes advantage of the fact that
>  # check-ignore --verbose output is the same as normal output except
> @@ -102,7 +103,7 @@ test_check_ignore () {
>  # Arguments:
>  #   - (optional) prereqs for this test, e.g. 'SYMLINKS'
>  #   - test name
> -#   - output to expect from the fourth verbosity mode (the output
> +#   - output to expect from the fifth verbosity mode (the output
>  #     from the other verbosity modes is automatically inferred
>  #     from this value)
>  #   - code to run (should invoke test_check_ignore)
> @@ -124,6 +125,7 @@ test_expect_success_multiple () {
>  
>  	expect_verbose=$( echo "$expect_all" | grep -v '^::	' )
>  	expect=$( echo "$expect_verbose" | sed -e 's/.*	//' )
> +	expect_non_matching=$( echo "$expect_all" | grep '^::	' | sed -e 's/.*	//')
>  
>  	test_expect_success $prereq "$testname${no_index_opt:+ with $no_index_opt}" '
>  		expect "$expect" &&
> @@ -144,6 +146,17 @@ test_expect_success_multiple () {
>  		quiet_opt=
>  	fi
>  
> +	for non_matching_opt in '-n' '--non-matching'
> +	do
> +		test_code="
> +			expect '$expect_non_matching' &&
> +			$code
> +		"
> +		opts="${no_index_opt:+$no_index_opt }$non_matching_opt"
> +		test_expect_success $prereq "$testname${opts:+ with $opts}" "$test_code"
> +	done
> +	non_matching_opt=
> +
>  	for verbose_opt in '-v' '--verbose'
>  	do
>  		for non_matching_opt in '' '-n' '--non-matching'
>
> base-commit: f9b95943b68b6b8ca5a6072f50a08411c6449b55
