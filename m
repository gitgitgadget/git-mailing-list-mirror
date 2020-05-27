Return-Path: <SRS0=7zPC=7J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0174C433DF
	for <git@archiver.kernel.org>; Wed, 27 May 2020 06:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D00DD207E8
	for <git@archiver.kernel.org>; Wed, 27 May 2020 06:40:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbgE0Gk5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 02:40:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:57074 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725613AbgE0Gk5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 02:40:57 -0400
Received: (qmail 19905 invoked by uid 109); 27 May 2020 06:40:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 27 May 2020 06:40:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32748 invoked by uid 111); 27 May 2020 06:40:57 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 27 May 2020 02:40:57 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 27 May 2020 02:40:56 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Dana Dahlstrom <dahlstrom@google.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] checkout: add tests for -b and --track
Message-ID: <20200527064056.GA4005121@coredump.intra.peff.net>
References: <CACqwCQiLpZ1HFzgJw0p0KR3jXNsxkhjXmF_huzhv+qkMZmybBQ@mail.gmail.com>
 <20200521191626.GC1308489@coredump.intra.peff.net>
 <9f26099a-e77b-ede4-bee3-27382a5a0875@web.de>
 <20200523162914.GA2178752@coredump.intra.peff.net>
 <ebe696b2-bf68-ccd1-b930-dce274ec9279@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ebe696b2-bf68-ccd1-b930-dce274ec9279@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 24, 2020 at 09:22:51AM +0200, René Scharfe wrote:

> Test git checkout -b with and without --track and demonstrate unexpected
> error messages when it's given an extra (i.e. unsupported) path
> argument.  In both cases it reports:
> 
>    $ git checkout -b foo origin/master bar
>    fatal: 'bar' is not a commit and a branch 'foo' cannot be created from it
> 
> The problem is that the start point we gave for the new branch is
> "origin/master" and "bar" is just some extra argument -- it could even
> be a valid commit, which would make the message even more confusing.  We
> have more fitting error messages in git commit, but get confused; use
> the text of the rights ones in the tests.

Did you mean "more fitting error message in git checkout"?

> Original-test-by: Jeff King <peff@peff.net>

I didn't think I really contributed much, but OK. :)

> diff --git a/t/t2018-checkout-branch.sh b/t/t2018-checkout-branch.sh
> index 21583154d8..d99b699396 100755
> --- a/t/t2018-checkout-branch.sh
> +++ b/t/t2018-checkout-branch.sh
> @@ -260,4 +260,14 @@ test_expect_success 'checkout -b to a new branch preserves mergeable changes des
>  	test_cmp expect actual
>  '
> 
> +test_expect_success 'checkout -b rejects an invalid start point' '
> +	test_must_fail git checkout -b branch4 file1 2>err &&
> +	test_i18ngrep "is not a commit" err
> +'
> +
> +test_expect_failure 'checkout -b rejects an extra path argument' '
> +	test_must_fail git checkout -b branch5 branch1 file1 2>err &&
> +	test_i18ngrep "Cannot update paths and switch to branch" err
> +'

OK, covering the normal case without --track, both with and without the
extra arg. Makes sense.

> +test_expect_success 'checkout --track -b creates a new tracking branch' '
> +	git checkout --track -b branch1 master &&
> +	test $(git rev-parse --abbrev-ref HEAD) = branch1 &&
> +	test $(git config --get branch.branch1.remote) = . &&
> +	test $(git config --get branch.branch1.merge) = refs/heads/master
> +'
> +
> +test_expect_failure 'checkout --track -b rejects an extra path argument' '
> +	test_must_fail git checkout --track -b branch2 master one.t 2>err &&
> +	test_i18ngrep "cannot be used with updating paths" err
> +'

And these ones with --track, which produces a different error message.
Makes sense.

-Peff
