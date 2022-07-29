Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFBF9C00144
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 16:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238068AbiG2QpE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 12:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238026AbiG2QpB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 12:45:01 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32F921251
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 09:45:00 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 191A813A5E4;
        Fri, 29 Jul 2022 12:45:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VRyJXaiMt/UgcyLcsUKD9cjKxh39nDA4EtwsGG
        xFnFs=; b=adIrz6U5yk91HwjAb7cCZyIB19O73Ul4E9UOC3x7EwHqO59TwETw2R
        j5B+pQ7ms9sBMIDd7qKcG2vd6DrCGYvY3qGMCb+VX6kkTacrmH/ieiC9M2pnJo1/
        93QO7peezInbLsUKA5/jg45rKA/dtkDrzAFQd065Q4IqmUFqWSbJE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0F40D13A5E2;
        Fri, 29 Jul 2022 12:45:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6B6DD13A5E1;
        Fri, 29 Jul 2022 12:44:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] tests: replace mingw_test_cmp with a helper in C
References: <pull.1309.git.1659106382128.gitgitgadget@gmail.com>
Date:   Fri, 29 Jul 2022 09:44:58 -0700
In-Reply-To: <pull.1309.git.1659106382128.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Fri, 29 Jul 2022 14:53:01
        +0000")
Message-ID: <xmqqwnbv7trp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C8DBE2B8-0F5D-11ED-A8FC-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> +	const char *argv[] = {
> +		"diff", "--no-index", NULL, NULL, NULL
> +	};

Don't we want to have "--" before the two paths?

> +	if (!(f0 = !strcmp(argv[1], "-") ? stdin : fopen(argv[1], "r")))
> +		return error_errno("could not open '%s'", argv[1]);
> +	if (!(f1 = !strcmp(argv[2], "-") ? stdin : fopen(argv[2], "r"))) {
> +		fclose(f0);
> +		return error_errno("could not open '%s'", argv[2]);
> +	}

It is tricky that you need to take "-" and treat it as the standard
input stream in either argv[1] or argv[2] (but not both).  If would
be a different story in an end-user facing program, but because this
is a test helper, feeding wrong input is developer's fault, and I do
not mind lack of attention to detail of error checking to make sure
we avoid comparing alternating lines of the standard input.

> +	for (;;) {
> +		int r0 = strbuf_getline(&b0, f0);
> +		int r1 = strbuf_getline(&b1, f1);
> +
> +		if (r0 == EOF) {
> +			fclose(f0);
> +			fclose(f1);
> +			strbuf_release(&b0);
> +			strbuf_release(&b1);
> +			if (r1 == EOF)
> +				return 0;

If both hit the EOF at the same time, we know they are the same, OK.

> +cmp_failed:
> +			if (!run_diff(argv[1], argv[2]))

If one of argv[] was "-", then this wouldn't work correctly, as the
other file is read from the beginning but the "-" side have consumed
the initial part of the input and we cannot unseek it.  This bug
needs to be fixed only if we expect a useful and reliable output
from the helper.

But otherwise the idea is sound.  We compare them line by line,
using strbuf_getline() to ignore differences in CRLF and LF that
originates at 4d715ac0 (Windows: a test_cmp that is agnostic to
random LF <> CRLF conversions, 2013-10-26).  Only when we find the
input different, we use "git diff --no-index" to make the difference
(and unfortunately more, as it does not ignore CRLF <> LF
differences) visible.

> +				die("Huh? 'diff --no-index %s %s' succeeded",
> +				    argv[1], argv[2]);

Nice attention to (possibly irrelevant) detail here.  I would have
ignored the return value and reported "they are different" at this
point, though.  The line-by-line comparison we did was the
authoritative one, and "git diff --no-index" is merely used for
human readable output.

In any case, "test-tool mingwcmp" would be a better name that
highlights the spirit of 4d715ac0 to ignore CRLF <> LF issues.  IOW,
it does a lot more than "cmp" replacement, and we shouldn't mislead
users/developers into thinking it is a plain "cmp" replacement.

Thanks.

> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 7726d1da88a..220c259e796 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -1546,7 +1546,7 @@ case $uname_s in
>  	test_set_prereq SED_STRIPS_CR
>  	test_set_prereq GREP_STRIPS_CR
>  	test_set_prereq WINDOWS
> -	GIT_TEST_CMP=mingw_test_cmp
> +	GIT_TEST_CMP="test-tool cmp"
>  	;;
>  *CYGWIN*)
>  	test_set_prereq POSIXPERM
>
> base-commit: 23b219f8e3f2adfb0441e135f0a880e6124f766c
