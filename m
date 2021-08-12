Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79163C4338F
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 05:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59FF560FE6
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 05:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234071AbhHLFWG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Aug 2021 01:22:06 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54770 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233763AbhHLFWF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Aug 2021 01:22:05 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B224A1368CB;
        Thu, 12 Aug 2021 01:21:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6I24f4FvQ9LSs6jwGMRBk6aFc5fdKn3OIj3YE+
        sV728=; b=ck4CpgVBgx5W8M8h8ayoKAgCwMfarRomkb76jcnqRll0P/3mwZLXAG
        Q+ZHVYqr+y/MZ/9ZpN46J2yEgkeTBzrGVWcQe6Rd81aE62eIVX2FHIM/afzCatRC
        K3aDG7mMH+Qhv4YuxVkXBP1Fz3tixz68AW+Q6vjlC5zdLKtBTPKx8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9E4F51368CA;
        Thu, 12 Aug 2021 01:21:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D80371368C7;
        Thu, 12 Aug 2021 01:21:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Joel Klinghed via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Joel Klinghed <the_jk@spawned.biz>
Subject: Re: [PATCH v2] commit: restore --edit when combined with --fixup
References: <pull.1014.git.1628689758413.gitgitgadget@gmail.com>
        <pull.1014.v2.git.1628725421868.gitgitgadget@gmail.com>
Date:   Wed, 11 Aug 2021 22:21:36 -0700
In-Reply-To: <pull.1014.v2.git.1628725421868.gitgitgadget@gmail.com> (Joel
        Klinghed via GitGitGadget's message of "Wed, 11 Aug 2021 23:43:41
        +0000")
Message-ID: <xmqq1r6z6xwf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2B0858C2-FB2D-11EB-BE97-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Joel Klinghed via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/builtin/commit.c b/builtin/commit.c
> index 190d215d43b..4c5286840c5 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1333,7 +1333,8 @@ static int parse_and_validate_options(int argc, const char *argv[],
>  		} else {
>  			fixup_commit = fixup_message;
>  			fixup_prefix = "fixup";
> -			use_editor = 0;
> +			if (0 > edit_flag)

Writing this as

			if (edit_flag < 0)

makes it far easier to immediately see that we are talking about a
nagetive edit_flag.

> +				use_editor = 0;
>  		}
>  	}
>  
> diff --git a/t/t7500-commit-template-squash-signoff.sh b/t/t7500-commit-template-squash-signoff.sh
> index 7d02f79c0de..d71c7812180 100755
> --- a/t/t7500-commit-template-squash-signoff.sh
> +++ b/t/t7500-commit-template-squash-signoff.sh
> @@ -281,6 +281,21 @@ test_expect_success 'commit --fixup -m"something" -m"extra"' '
>  
>  extra"
>  '
> +test_expect_success 'commit --fixup --edit' '
> +	commit_for_rebase_autosquash_setup &&

> +	cat >e-append <<-\EOF &&
> +	#!/bin/sh
> +	sed -e "2a\\
> +something\\
> +extra" <"$1" >"$1-"
> +	mv "$1-" "$1"
> +	EOF
> +	chmod 755 e-append &&

Use write_script helper from test-lib-functions.sh here and lose the
hardcoded reference to /bin/sh.

> +	EDITOR="./e-append" git commit --fixup HEAD~1 --edit &&
> +	commit_msg_is "fixup! target message subject linesomething
> +extra"
> +'


Thanks.
