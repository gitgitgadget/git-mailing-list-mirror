Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1CA4EE49AB
	for <git@archiver.kernel.org>; Fri, 25 Aug 2023 21:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbjHYVcV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Aug 2023 17:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbjHYVcF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Aug 2023 17:32:05 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA5A10C7
        for <git@vger.kernel.org>; Fri, 25 Aug 2023 14:32:02 -0700 (PDT)
Received: (qmail 27369 invoked by uid 109); 25 Aug 2023 21:32:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 25 Aug 2023 21:32:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2427 invoked by uid 111); 25 Aug 2023 21:32:03 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 25 Aug 2023 17:32:03 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 25 Aug 2023 17:32:01 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] .github/workflows: add coverity action
Message-ID: <20230825213201.GD2382334@coredump.intra.peff.net>
References: <4590e1381feb8962cadf2b40b22086531d662ef8.1692675172.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4590e1381feb8962cadf2b40b22086531d662ef8.1692675172.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 21, 2023 at 11:34:32PM -0400, Taylor Blau wrote:

> Coverity is a static analysis tool that detects and generates reports on
> various security and code quality issues.
> 
> It is particularly useful when diagnosing memory safety issues which may
> be used as part of exploiting a security vulnerability.

I've been running a variant of this on my private repo for the last year
or two. The biggest issue IMHO is that we don't have a good way to
surface problems publicly. The CI "passes" in the sense that the build
is uploaded to coverity, but the interesting bit is whether any new
defects were found (because there are a ton of existing false positives
that I haven't figured out how to silence). So my flow is something
like:

  1. Push to my fork.

  2. Eventually get an email that says "N new defects found".

  3. If N > 0, log into the coverity site and look at them.

What's the plan for adding this to the main git.git repo? Is it to run
on Junio's tree, and then have interested folks sign up for coverity
access and look at it there? If so, how does step 2 work?

Or is it just to have it, so interested parties can do their own
coverity analysis? I'd be happy enough with that, as I am carrying a
similar patch locally.

> Coverity's website provides a service accepts "builds" (which is more or
> less the collection of '*.o' files generated during a standard build
> with "make") as input and generates reports as output. In order to
> generate a report, we have to first compile Git and then upload the
> build archive to Coverity.

I don't think this is quite right. You run a build with their
"cov-build" wrapper, which does some magic. It _does_ invoke the actual
compiler, but does some extra magic, too (I don't know the details, but
it is running cov-translate and cov-emit on the actual source file).

This maybe seems like nit-picking, but it will play into some questions
I have on the patch itself.

>   - We could upload the build archive to Coverity directly with a
>     straightforward curl request. But using the vapier/coverity-scan
>     Action comes with some additional niceties, such as caching the
>     (rather large) Coverity tool download between runs.

Yeah, that is a nice bonus over what I've been using. The tool download
is 800MB!

> diff --git a/.github/workflows/coverity.yml b/.github/workflows/coverity.yml
> new file mode 100644
> index 0000000000..26b9145d9e
> --- /dev/null
> +++ b/.github/workflows/coverity.yml
> @@ -0,0 +1,35 @@
> +name: Coverity
> +
> +on:
> +  push:
> +    branches:
> +      - master
> +    tags:
> +      - '*'

It's probably a good idea not to run this against every single topic
branch. But it's nice if we can catch bugs _before_ they hit master.
Since this isn't a blocking CI job, that's aspirational (it depends on
somebody looking at the results and patching in a timely manner). But I
routinely do my runs against "next" (actually an integration branch that
I base on "next") and investigate the results within a day or two.

Running against "seen" might be even better (though personally I usually
avoid looking at it too closely, as sometimes it has too much of other
people's broken stuff. I have plenty of my own).

I'm not sure what workflow you're envisioning here.

> +jobs:
> +  coverity:
> +    runs-on: ubuntu-latest
> +    env:
> +      HAVE_COVERITY_TOKEN: ${{ secrets.COVERITY_SCAN_EMAIL != '' && secrets.COVERITY_SCAN_TOKEN != '' }}
> +    steps:
> +      - id: check-coverity
> +        name: check whether Coverity token is configured
> +        run: |
> +          echo "enabled=$HAVE_COVERITY_TOKEN" >>$GITHUB_OUTPUT

This check-coverity step is good, as obviously most people's forks won't
be set up to run it. It is a shame we'll have to kick off an actions vm
just to echo "enabled=0". Is there any way to embed that logic directly
in the yaml (I won't be surprised if the answer is "no"; I've been
looking for years for something similar for check-config in the main
workflow).

> +      - uses: actions/checkout@v3
> +        if: steps.check-coverity.outputs.enabled == 'true'
> +      - run: ci/install-dependencies.sh
> +        env:
> +          CC: gcc
> +          CC_PACKAGE: gcc-9
> +          jobname: linux-gcc-default
> +          runs_on_pool: ubuntu-latest
> +        if: steps.check-coverity.outputs.enabled == 'true'

In the workflow file I've been using, I didn't need to do any of this CC
magic. I do run install-dependencies, but it seems to work fine without
extra variables. I do set runs_on_pool=ubuntu-latest in mine. Maybe that
matters (it does hit UBUNTU_COMMON_PKGS)?

> +      - uses: vapier/coverity-scan-action@v1
> +        if: steps.check-coverity.outputs.enabled == 'true'
> +        with:
> +          email: ${{ secrets.COVERITY_SCAN_EMAIL }}
> +          token: ${{ secrets.COVERITY_SCAN_TOKEN }}
> +          command: make -j8

OK, this is presumably doing the cov-build stuff behind the scenes, as
well as the curl upload. In my file, we have to feed a "project" field.
I guess the action just figures this out from whichever repo we're
using. Do GitHub repo names always correspond to coverity project names?
(It does seem kind of superfluous; I think the SCAN_TOKEN is unique to
the project).

-Peff
