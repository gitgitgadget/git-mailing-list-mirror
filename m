Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B6BE7D0B4
	for <git@archiver.kernel.org>; Thu, 21 Sep 2023 23:30:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjIUXaT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Sep 2023 19:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjIUXaS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2023 19:30:18 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A8E8F
        for <git@vger.kernel.org>; Thu, 21 Sep 2023 16:30:11 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 45DA920738;
        Thu, 21 Sep 2023 19:30:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=CyECR7Y146iW/OfQv1JwWuvN+P2GDuDVW2BysC
        nmeTU=; b=A1a0kUW9zQFTvP7R81FP8BqVzUCVlyYVwIY0Aaw6bz84vBAmACYeiz
        7fa4CPVQM6bivTSTOppkw0Umbqb4O21senrDRuUU2nUfAvPTU8ixYG0IezAakwJE
        3p873mlT4j18oU7lkeWbzx5OaXBRLX3PdJzqQ3vV18lsyYPLfrhAA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3F33420735;
        Thu, 21 Sep 2023 19:30:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9444D20734;
        Thu, 21 Sep 2023 19:30:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] .github/workflows: add coverity action
In-Reply-To: <b23951c569660e1891a7fb3ad2c2ea1952897bd7.1695332105.git.me@ttaylorr.com>
        (Taylor Blau's message of "Thu, 21 Sep 2023 17:53:31 -0400")
References: <4590e1381feb8962cadf2b40b22086531d662ef8.1692675172.git.me@ttaylorr.com>
        <b23951c569660e1891a7fb3ad2c2ea1952897bd7.1695332105.git.me@ttaylorr.com>
Date:   Thu, 21 Sep 2023 16:30:02 -0700
Message-ID: <xmqqo7hv3y11.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CAF28106-58D6-11EE-9F95-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> This fell to the bottom of my queue, but I got back to it today while
> doing some ~~spring~~ fall inbox cleaning :-). Thanks Peff and Johannes
> for helpful review in the first round. Range-diff is below:
>
> Range-diff against v1:
> 1:  f74ae75ddb < -:  ---------- .github/workflows: add coverity action
> -:  ---------- > 1:  b23951c569 .github/workflows: add coverity action

That's a useful range-diff ;-).  Even with --word-diff, range-diff does
not notice that they correspond to each other, without an absurd setting
like --creation-factor=999.

>  .github/workflows/coverity.yml | 22 ++++++++++++++++++++++
>  ci/install-dependencies.sh     |  2 +-
>  ci/lib.sh                      |  2 +-
>  3 files changed, 24 insertions(+), 2 deletions(-)
>  create mode 100644 .github/workflows/coverity.yml
>
> diff --git a/.github/workflows/coverity.yml b/.github/workflows/coverity.yml
> new file mode 100644
> index 0000000000..3ba00b3929
> --- /dev/null
> +++ b/.github/workflows/coverity.yml
> @@ -0,0 +1,22 @@
> +name: Coverity
> +
> +on: [push, pull_request]

This no longer hardcocdes the condition to master and tagged ones,
as ...

> +jobs:
> +  coverity:
> +    if: (vars.ENABLE_COVERITY == 'true') &&
> +      (vars.COVERITY_BRANCHES == '' ||
> +       contains(vars.COVERITY_BRANCHES, github.ref_name) ||
> +       contains(vars.COVERITY_BRANCHES, '*'))

... this lets you control when to run it via the "vars".  This round
also can act on pull-requests in addition to pushes.

> +    runs-on: ubuntu-latest
> +    steps:
> +      - uses: actions/checkout@v3
> +      - run: ci/install-dependencies.sh
> +        env:
> +          jobname: coverity
> +      - uses: vapier/coverity-scan-action@cae3c096a2eb21c431961a49375ac17aea2670ce
> +        with:
> +          email: ${{ secrets.COVERITY_SCAN_EMAIL }}
> +          token: ${{ secrets.COVERITY_SCAN_TOKEN }}
> +          command: make -j8

And the actual implementation is vastly different by just using a
canned one, which requires less maintenance on our end, which is
nice.

> diff --git a/ci/lib.sh b/ci/lib.sh
> index 6fbb5bade1..2ad0ae340e 100755
> --- a/ci/lib.sh
> +++ b/ci/lib.sh
> @@ -227,7 +227,7 @@ export SKIP_DASHED_BUILT_INS=YesPlease
>
>  case "$runs_on_pool" in
>  ubuntu-*)
> -	if test "$jobname" = "linux-gcc-default"
> +	if test "$jobname" = "linux-gcc-default" || test "$jobname" = "coverity"
>  	then
>  		break
>  	fi

This part is new in this iteration, to avoid further customization
that enables more exotic features, which makes sense.


