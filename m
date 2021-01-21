Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1556AC433DB
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 23:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9CFE206B7
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 23:43:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725819AbhAUXnA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jan 2021 18:43:00 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64234 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbhAUXm5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jan 2021 18:42:57 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6E00E109EDB;
        Thu, 21 Jan 2021 18:42:15 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TvF+wFCfriVoJ5cDxXbM6JWWVA4=; b=fY+vH7
        ENA6Ps3ffK+fUx2megVecUqIiCvcNEWy6fJusgPX9+n015ZreuS8FYW7gplHK7cH
        AO2AZPG+OTUm3w5KY4jjJC8NcgSFzu9yl8HnjDPRckT40J+BmrC3JhwV/1CRzdGp
        73dp+SKOqSrR3YwLk1dDT78LY4vxABCOsOxCs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xHQuK1Uot6U9HNpmUcKI/DJUhTNRfeX4
        N0kItc/E6NwTCpaHuJ9Hf8Y2+o+cVHIXXH1valjga2P+s5+X95jwhlN39TLKAlK4
        vZhjrmoXejc10Qz5cw7WbIZBkN//dmRBlMyQnkNeFx9GRmJZgc1eteZPpGD3CQvq
        Q3e2IZBihHE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6653B109ED9;
        Thu, 21 Jan 2021 18:42:15 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B3575109ED8;
        Thu, 21 Jan 2021 18:42:12 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/3] range-diff: handle commit ranges other than A..B
References: <pull.841.git.1611267638.gitgitgadget@gmail.com>
        <88c15617b4ba8ae3211b1a01861eb4165f3eda38.1611267638.git.gitgitgadget@gmail.com>
Date:   Thu, 21 Jan 2021 15:42:10 -0800
In-Reply-To: <88c15617b4ba8ae3211b1a01861eb4165f3eda38.1611267638.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Thu, 21 Jan 2021
        22:20:37 +0000")
Message-ID: <xmqq1redc0x9.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 49038DF4-5C42-11EB-9436-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> In the `SPECIFYING RANGES` section of gitrevisions[7], two ways are
> described to specify commit ranges that `range-diff` does not yet
> accept: "<commit>^!" and "<commit>^-<n>".
>
> Let's accept them.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin/range-diff.c  | 21 ++++++++++++++++++++-
>  t/t3206-range-diff.sh |  8 ++++++++
>  2 files changed, 28 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/range-diff.c b/builtin/range-diff.c
> index 551d3e689cb..6097635c432 100644
> --- a/builtin/range-diff.c
> +++ b/builtin/range-diff.c
> @@ -13,7 +13,26 @@ NULL
>  
>  static int is_range(const char *range)
>  {
> -	return !!strstr(range, "..");
> +	size_t i;
> +	char c;
> +
> +	if (strstr(range, ".."))
> +		return 1;
> +
> +	i = strlen(range);
> +	c = i ? range[--i] : 0;
> +	if (c == '!')
> +		i--; /* might be ...^! or ...^@ */

I am confused.  If it ends with '!', I do not see how it can end
with "^@".

If the input were "!", i gets strlen("!") which is 1, c gets '!'
while predecrementing i down to 0, and we notice c is '!' and
decrement i again to make it (size_t)(-1) which is a fairly large
number.

Then we skip all the else/if cascade, ensure that i is positive, and
happily access range[i], which likely is way out of bounds (but it
probably is almost one turn around the earth out of bounds, it may
access just a single byte before the array).

Am I reading the code right?

IOW, "git range-diff \! A..B" would do something strange, I would
guess.

> +	else if (isdigit(c)) {
> +		/* handle ...^-<n> */
> +		while (i > 2 && isdigit(range[--i]))
> +			; /* keep trimming trailing digits */
> +		if (i < 2 || range[i--] != '-')
> +			return 0;
> +	} else
> +		return 0;
> +
> +	return i > 0 && range[i] == '^';
>  }
>  
>  int cmd_range_diff(int argc, const char **argv, const char *prefix)
> diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
> index 6eb344be031..e217cecac9e 100755
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
