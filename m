Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 922CECD4844
	for <git@archiver.kernel.org>; Fri, 22 Sep 2023 17:04:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbjIVREk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Sep 2023 13:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjIVREh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2023 13:04:37 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99B4F1
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 10:04:31 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BB11228F1B;
        Fri, 22 Sep 2023 13:04:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=qMNDQoKaJeCImGWA77MAw34seoKuVtc4NmZ5Zv
        w25TM=; b=ZTzLm40hjj0j7IdH4SrKkH2Biur5981NvO9CE/1daeoxePjf5WE+M2
        +zmxWj65qetzZLDd8lB3QD+pHWChzAKAHnyUCKV4Vw+bB+l0Dg9nRPZr3ZYdanG+
        X7+ktBWwS/dwV+lZ6BZ+mHJX7hmLfBScWohqyMyu/UjtwMZc/rDuI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B38F728F1A;
        Fri, 22 Sep 2023 13:04:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3E07A28F19;
        Fri, 22 Sep 2023 13:04:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Dragan Simic <dsimic@manjaro.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] diff --stat: set the width defaults in a helper function
In-Reply-To: <166396f0a98e248fc3d1236757632c5d648ddc0b.1695364961.git.dsimic@manjaro.org>
        (Dragan Simic's message of "Fri, 22 Sep 2023 08:44:18 +0200")
References: <166396f0a98e248fc3d1236757632c5d648ddc0b.1695364961.git.dsimic@manjaro.org>
Date:   Fri, 22 Sep 2023 10:04:24 -0700
Message-ID: <xmqqjzsi2l7r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 15D4353C-596A-11EE-BBFC-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dragan Simic <dsimic@manjaro.org> writes:

> Extract the commonly used initialization of the --stat-width=<width>,
> --stat-name-width=<width> and --stat-graph-with=<width> parameters to the
> internal default values into a helper function, to avoid repeating the same
> initialization code in a few places.

Thanks.

If this is only about settings related to controlling widths of
various elements on diffstat lines, isn't the "std" in name a bit
too broad, though?  init_diffstat_widths(&rev.diffopt) or something
like that might be a better fit.  I dunno if it is a huge deal,
though.

> Add a couple of tests to additionally cover existing configuration options
> diff.statNameWidth=<width> and diff.statGraphWidth=<width> when used by
> git-merge to generate --stat outputs.  This closes the gap in the tests that
> existed previously for the --stat tests, reducing the chances for having
> any regressions introduced by this commit.

Nice.

> While there, perform a bunch of small wording improvements and some minor
> code cleanups in the improved unit test, as spotted, to make it a bit neater
> and to improve its test-level consistency.

Alright.  The last category of changes need somebody else to review
them in addition to myself, as I expect that it would be somewhat
subjective and I tend to be change-averse.

The code changes all looked sensible.

> diff --git a/t/t4052-stat-output.sh b/t/t4052-stat-output.sh
> index beb2ec2a55..aa947d93cf 100755
> --- a/t/t4052-stat-output.sh
> +++ b/t/t4052-stat-output.sh
> @@ -12,32 +12,31 @@ TEST_PASSES_SANITIZE_LEAK=true
>  . ./test-lib.sh
>  . "$TEST_DIRECTORY"/lib-terminal.sh
>  
> -# 120 character name
> -name=aaaaaaaaaa
> -name=$name$name$name$name$name$name$name$name$name$name$name$name
> +# 120-character name
> +printf -v name 'a%.0s' {1..120}

This is a totally unnecessary and unacceptable change.  "-v name"
may be available in the built-in variant found in bash, but you
would likely find that it is missing from other shells.  {1..120} is
also a bash-ism.

And because we are still calling the result a "name" (not
"filename") ...

>  cat >expect72 <<-'EOF'
>   ...aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1 +
>  EOF
> -test_expect_success "format-patch: small change with long name gives more space to the name" '
> +test_expect_success "format-patch: small change with long filename gives more space to the filename" '

... I do not see the point of this change (and similar ones in the
rest of the patch).  Even the configuration is called statNameWidth
and not statFileNameWidth.  In the context of the tests that check
"stat-output" (that is in the filename of this script), we should be
able to use "name" consistently without causing any confusion, as it
is unlikely to be mistaken with other kinds of "name".

> -test_expect_success "format-patch --cover-letter ignores COLUMNS (big change)" '
> +test_expect_success "format-patch --cover-letter ignores COLUMNS envvar with big change" '

Not wrong per-se, but I wonder if it is necessary to stress that
COLUMNS is an environment variable that tells the programs how wide
a terminal they are showing their output.  A usual shell variable
would not affect the "git" process it runs, and COLUMNS without any
dot in it cannot be our configuration variable, so even without deep
knowledge of tradition, I thought it would be rather obvious.

Same comment for "statNameWidth config"; with fewer number of bytes,
it would be more descriptive to say "diff.statNameWidth".

> -	test_expect_success "$cmd --stat-graph-width with big change" '
> +	test_expect_success "$cmd --stat-graph-width=width with big change" '
>  		git $cmd $args --stat-graph-width=26 >output &&

This may be a good change, especially if there are tests that feed
different parameters and if it helps clarifying which variant is
tested, e.g. "--stat=<width>,<name-width>" vs "--stat=<width>".

Ah, wait, "--stat-graph-width" always takes a single value, so the
above justification does not quite apply.  But still, it is not
making it worse, and because there is another test that is labeled
with "--stat-width=width", being consistent with it has value.

OK.

> -	test_expect_success "$cmd --stat-graph-width --graph with big change" '
> +	test_expect_success "$cmd --stat-graph-width=width --graph with big change" '

Ditto.

Thanks.
