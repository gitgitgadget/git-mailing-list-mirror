Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DA3A1F45F
	for <e@80x24.org>; Mon,  6 May 2019 20:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbfEFUYy (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 May 2019 16:24:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:49410 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726268AbfEFUYx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 May 2019 16:24:53 -0400
Received: (qmail 6058 invoked by uid 109); 6 May 2019 20:24:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 06 May 2019 20:24:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3517 invoked by uid 111); 6 May 2019 20:25:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 06 May 2019 16:25:29 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 May 2019 16:24:51 -0400
Date:   Mon, 6 May 2019 16:24:51 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] perf-lib.sh: make "./run <revisions>" use the correct
 gits
Message-ID: <20190506202451.GA19850@sigill.intra.peff.net>
References: <20190502222409.GA15631@sigill.intra.peff.net>
 <20190506191611.16770-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190506191611.16770-1-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 06, 2019 at 09:16:11PM +0200, Ævar Arnfjörð Bjarmason wrote:

> Perhaps there's some better way to fix this, but it seems to me that
> the best solution is to just make this behavior less magical. We know
> in run_dirs_helper() that we're about to run performance tests on a
> given <revision>, so let's just set GIT_TEST_INSTALLED to an absolute
> path there, and then make getting logging target from a previously
> relative path less magical, we'll just explicitly pass down the
> relative path as a variable.
> 
> This makes e.g. these cases all work:
> 
>     ./run . $PWD/../../ origin/master origin/next HEAD -- <tests>
> 
> As well as just a plain one-off:
> 
>     ./run <tests>

Doing this naively would break anybody doing:

  GIT_TEST_INSTALLED=some-relative-path ./p1234-foo.sh

but I doubt that actually matters in practice (notably this already does
not work with non-perf tests, as test-lib.sh does not do any
normalization).

I don't think your patch does, because it leaves the extra absolutizing
in perf-lib.sh. But then it doesn't feel like it's really simplified
anything. ;)

> diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
> index 169f92eae3..b15ee1d262 100644
> --- a/t/perf/perf-lib.sh
> +++ b/t/perf/perf-lib.sh
> @@ -32,6 +32,10 @@ TEST_NO_MALLOC_CHECK=t
>  if test -z "$GIT_TEST_INSTALLED"; then
>  	perf_results_prefix=
>  else
> +	if test -n "$GIT_PERF_DIR_MYDIR_REL"
> +	then
> +		GIT_TEST_INSTALLED=$GIT_PERF_DIR_MYDIR_REL
> +	fi
>  	perf_results_prefix=$(printf "%s" "${GIT_TEST_INSTALLED%/bin-wrappers}" | tr -c "[a-zA-Z0-9]" "[_*]")"."
>  	GIT_TEST_INSTALLED=$ABSOLUTE_GIT_TEST_INSTALLED
>  fi

So we reset GIT_TEST_INSTALLED to the relative path here (ignoring
what's in it!), and then afterwards set it to the absolute path. That
still seems rather magical. :)

What if instead we:

  - taught test-lib.sh to make GIT_TEST_INSTALLED absolute (since after
    all it is the one who is planning to chdir and wreck the relative
    path)

  - let callers pass in $GIT_PERF_RESULTS_PREFIX instead of guessing at
    it ourselves from the path name. Then the "run" script could quite
    reasonably just pass in the tree oid it already has instead of us
    trying to decode it. And nobody would care about whether
    $GIT_TEST_INSTALLED has been mangled.

I thought about going this route for my original patch, but I wanted to
fix the regression (which I agree is quite serious and embarrassing) as
quickly and simply as possible.

-Peff
