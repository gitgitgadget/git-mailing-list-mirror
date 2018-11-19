Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D53381F87F
	for <e@80x24.org>; Mon, 19 Nov 2018 19:49:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbeKTGOa (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 01:14:30 -0500
Received: from cloud.peff.net ([104.130.231.41]:44904 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725843AbeKTGOa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 01:14:30 -0500
Received: (qmail 21814 invoked by uid 109); 19 Nov 2018 19:49:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 19 Nov 2018 19:49:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21608 invoked by uid 111); 19 Nov 2018 19:48:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 19 Nov 2018 14:48:44 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 19 Nov 2018 14:49:20 -0500
Date:   Mon, 19 Nov 2018 14:49:20 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] test-lib-functions: make 'test_cmp_rev' more informative
 on failure
Message-ID: <20181119194920.GB7330@sigill.intra.peff.net>
References: <20181119132818.3116-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181119132818.3116-1-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 19, 2018 at 02:28:18PM +0100, SZEDER Gábor wrote:

> The 'test_cmp_rev' helper is merely a wrapper around 'test_cmp'
> checking the output of two 'git rev-parse' commands, which means that
> its output on failure is not particularly informative, as it's
> basically two OIDs with a bit of extra clutter of the diff header, but
> without any indication of which two revisions have caused the failure:
> 
>   --- expect.rev  2018-11-17 14:02:11.569747033 +0000
>   +++ actual.rev  2018-11-17 14:02:11.569747033 +0000
>   @@ -1 +1 @@
>   -d79ce1670bdcb76e6d1da2ae095e890ccb326ae9
>   +139b20d8e6c5b496de61f033f642d0e3dbff528d
> 
> It also pollutes the test repo with these two intermediate files,
> though that doesn't seem to cause any complications in our current
> tests (meaning that I couldn't find any tests that have to work around
> the presence of these files by explicitly removing or ignoring them).
> 
> Enhance 'test_cmp_rev' to provide a more useful output on failure with
> less clutter:
> 
>   error: two revisions point to different objects:
>     'HEAD^': d79ce1670bdcb76e6d1da2ae095e890ccb326ae9
>     'extra': 139b20d8e6c5b496de61f033f642d0e3dbff528d
> 
> Doing so is more convenient when storing the OIDs outputted by 'git
> rev-parse' in a local variable each, which, as a bonus, won't pollute
> the repository with intermediate files.
> 
> While at it, also ensure that 'test_cmp_rev' is invoked with the right
> number of parameters, namely two.

This is an improvement, in my opinion (and I agree that using your new
BUG for this last part would be better still). It also saves a process
in the common case.

One question:

> +	else
> +		local r1 r2
> +		r1=$(git rev-parse --verify "$1") &&
> +		r2=$(git rev-parse --verify "$2") &&
> +		if test "$r1" != "$r2"
> +		then
> +			cat >&4 <<-EOF
> +			error: two revisions point to different objects:
> +			  '$1': $r1
> +			  '$2': $r2
> +			EOF
> +			return 1
> +		fi

Why does this cat go to descriptor 4? I get why you'd want it to (it's
meant for the user's eyes, and that's where 4 goes), but we do not
usually bother to do so for our helper functions (like test_cmp).

I don't think it matters usually in practice, because nobody tries to
capture the stderr of test_cmp, etc. I don't think it would ever hurt,
though. Should we be doing that for all the others, too?

-Peff
