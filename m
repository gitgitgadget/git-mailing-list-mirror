Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB801CE7A88
	for <git@archiver.kernel.org>; Sat, 23 Sep 2023 06:10:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjIWGLD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Sep 2023 02:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjIWGLC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Sep 2023 02:11:02 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD27A19E
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 23:10:55 -0700 (PDT)
Received: (qmail 9373 invoked by uid 109); 23 Sep 2023 06:10:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 23 Sep 2023 06:10:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24669 invoked by uid 111); 23 Sep 2023 06:10:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 23 Sep 2023 02:10:55 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 23 Sep 2023 02:10:53 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] .github/workflows: add coverity action
Message-ID: <20230923061053.GA1469962@coredump.intra.peff.net>
References: <4590e1381feb8962cadf2b40b22086531d662ef8.1692675172.git.me@ttaylorr.com>
 <b23951c569660e1891a7fb3ad2c2ea1952897bd7.1695332105.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b23951c569660e1891a7fb3ad2c2ea1952897bd7.1695332105.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 21, 2023 at 05:53:31PM -0400, Taylor Blau wrote:

> diff --git a/.github/workflows/coverity.yml b/.github/workflows/coverity.yml
> new file mode 100644
> index 0000000000..3ba00b3929
> --- /dev/null
> +++ b/.github/workflows/coverity.yml
> @@ -0,0 +1,22 @@
> +name: Coverity
> +
> +on: [push, pull_request]
> +
> +jobs:
> +  coverity:
> +    if: (vars.ENABLE_COVERITY == 'true') &&
> +      (vars.COVERITY_BRANCHES == '' ||
> +       contains(vars.COVERITY_BRANCHES, github.ref_name) ||
> +       contains(vars.COVERITY_BRANCHES, '*'))

I wonder if we really need this ENABLE_COVERITY flag. It's not _too_
hard to set up, but it feels like we can eliminate a setup step and just
infer it from other variables.  Either:

  1. Treat unset COVERITY_BRANCHES as "do not run". Unlike the CI job,
     there's not much useful signal in running this for every PR. A
     human has to go periodically look at the coverity output and make
     sense of it. So I think it's something that would get run
     periodically (say, on updates of "next") just for one or two
     branches.

  2. Use COVERITY_SCAN_EMAIL as a clue that the feature it is enabled. I
     don't think we can do that as-is because it's a secret, not a var.
     But is there a reason for the EMAIL to be a secret? I don't think
     repository vars are fully public; they're just not hidden as deeply
     as secrets. It seems like the right level of privacy for an email.

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

I ran the action and it worked out of the box for me (I have everything
set up on the coverity side already from my custom workflow), modulo one
hiccup. I initially had COVERITY_SCAN_EMAIL as a var, so the upload
failed, complaining of an empty email.

But much to my surprise, the Action still succeeded. It didn't record
the HTTP result code, so I'm not sure if we could detect this with "curl
--fail-with-body" or if we'd have to scrape the output. It may not be
that big a deal either way, though, since the coverity output really is
useless until a human periodically scans over it (but it would be nice
to know if it was routinely failing; I might not notice if it didn't).

-Peff
