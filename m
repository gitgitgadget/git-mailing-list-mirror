Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF719C433E0
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 18:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89BF764E4F
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 18:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239432AbhBDSwq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Feb 2021 13:52:46 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58241 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239444AbhBDSwa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Feb 2021 13:52:30 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F197B122861;
        Thu,  4 Feb 2021 13:51:48 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=upgM2Is1K5kqcXCKFP3Kte/qCc0=; b=p8KdJG
        rxjAVOEYoetQhoPZc5iCnEl0fjEWb+meeywmLkNc+VqvIU499OIpGM1ej2kAMkF5
        4TuzXdv82PzU1h2FsRXZNj1f/OCZJ6udt3y/m3zYfBTE58/jc/F3KxLLOf3NXSvF
        VaBnqR10bC81QSJJvIBvp1unuGPmpeIPbIZjY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JZeiF5ThkmZOY/2+VVjEGhqer1bFgeyy
        6MBxn11JtBoNbyoyZbIZh26tTnYh6OQutDU5wtSvff7h5PdU2FEAh5plKSmpoKJm
        SlR1DHjHzBiTh20KXrOw1E/Wl93+/caSoXrPzkyA3tBAjdP1P6rWr7G7OuttMsPY
        gcqwdXCrZFQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E92E2122860;
        Thu,  4 Feb 2021 13:51:48 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3BC9612285F;
        Thu,  4 Feb 2021 13:51:46 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 2/3] range-diff/format-patch: handle commit ranges
 other than A..B
References: <pull.841.v3.git.1611765444.gitgitgadget@gmail.com>
        <pull.841.v4.git.1612431093.gitgitgadget@gmail.com>
        <448e6a64fa157990fcc973ce2fe4a9fc2ba1ab32.1612431093.git.gitgitgadget@gmail.com>
Date:   Thu, 04 Feb 2021 10:51:44 -0800
In-Reply-To: <448e6a64fa157990fcc973ce2fe4a9fc2ba1ab32.1612431093.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Thu, 04 Feb 2021
        09:31:31 +0000")
Message-ID: <xmqq7dnn7jjz.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 07CCFD10-671A-11EB-8B0F-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

>  int is_range_diff_range(const char *arg)
>  {
> -	return !!strstr(arg, "..");
> +	char *copy = xstrdup(arg); /* setup_revisions() modifies it */
> +	const char *argv[] = { "", copy, "--", NULL };
> +	int i, positive = 0, negative = 0;
> +	struct rev_info revs;
> +
> +	init_revisions(&revs, NULL);
> +	if (setup_revisions(3, argv, &revs, 0) == 1) {
> +		for (i = 0; i < revs.pending.nr; i++)
> +			if (revs.pending.objects[i].item->flags & UNINTERESTING)
> +				negative++;
> +			else
> +				positive++;
> +	}
> +
> +	free(copy);
> +	object_array_clear(&revs.pending);
> +	return negative > 0 && positive > 0;
>  }

One thing that worries me with this code is that I do not see
anybody that clears UNINTERESTING bit in the flags.  In-core objects
are singletons, so if a user fed the command two ranges,

	git range-diff A..B C..A

and this code first handled "A..B", smudging the in-core instance of
the commit object A with UNINTERESTING bit, that in-core instance
will be reused when the second range argument "C..A" is given to
this function again.

At that point, has anybody cleared the UNINTERESTING bit in the
flags word for the in-core commit A?  I do not see it done in this
function, but perhaps I am missing it done in the init/setup
functions (I somehow doubt it, though)?

Shoudn't we be calling clear_commit_marks(ALL_REF_FLAGS) on the
commits in revs.pending[] array before we clear it?  Depending on
the shape of "arg" that is end-user supplied, we may have walked the
history in handle_dotdot_1() to parse it (e.g. "A...B").

Also we'd want to see what needs to be cleared in revs.cmdline
that would have been populated by calls to add_rev_cmdline().

Other than that, I quite like the way the actual code turned out to
be.

> diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
> index 6eb344be0312..e217cecac9ed 100755
> --- a/t/t3206-range-diff.sh
> +++ b/t/t3206-range-diff.sh
> @@ -150,6 +150,14 @@ test_expect_success 'simple A B C (unmodified)' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'A^! and A^-<n> (unmodified)' '
> +	git range-diff --no-color topic^! unmodified^-1 >actual &&
> +	cat >expect <<-EOF &&
> +	1:  $(test_oid t4) = 1:  $(test_oid u4) s/12/B/
> +	EOF
> +	test_cmp expect actual
> +'
> +
>  test_expect_success 'trivial reordering' '
>  	git range-diff --no-color master topic reordered >actual &&
>  	cat >expect <<-EOF &&
