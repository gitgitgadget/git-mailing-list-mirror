Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F47ACE7A88
	for <git@archiver.kernel.org>; Sat, 23 Sep 2023 06:57:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjIWGt6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Sep 2023 02:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjIWGt4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Sep 2023 02:49:56 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8841E199
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 23:49:50 -0700 (PDT)
Received: (qmail 9564 invoked by uid 109); 23 Sep 2023 06:49:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 23 Sep 2023 06:49:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24855 invoked by uid 111); 23 Sep 2023 06:49:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 23 Sep 2023 02:49:51 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 23 Sep 2023 02:49:48 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/6] ci: add a GitHub workflow to submit Coverity scans
Message-ID: <20230923064948.GB1469941@coredump.intra.peff.net>
References: <pull.1588.git.1695379323.gitgitgadget@gmail.com>
 <8cb92968c5ebd38f328ed325ddf7f2e531dc9190.1695379323.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8cb92968c5ebd38f328ed325ddf7f2e531dc9190.1695379323.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 22, 2023 at 10:41:58AM +0000, Johannes Schindelin via GitGitGadget wrote:

> Note: The initial version of this patch used
> `vapier/coverity-scan-action` to benefit from that Action's caching of
> the Coverity tool, which is rather large. Sadly, that Action only
> supports Linux, and we want to have the option of building on Windows,
> too. Besides, in the meantime Coverity requires `cov-configure` to be
> runantime, and that Action was not adjusted accordingly, i.e. it seems
> not to be maintained actively. Therefore it would seem prudent to
> implement the steps manually instead of using that Action.

I'm still unsure of the cov-configure thing, as I have never needed it
(and the "vapier" Action worked fine for me). But the lack of Windows
support is obviously a deal-breaker. I wondered if it might be worth
trying to submit a PR to that project to fix it for everybody, but I saw
that you commented on their "Windows support" issue, which has been
sitting unanswered since it was opened in May. It's possible they might
be more responsive to an actual PR, but I agree that it may be simpler
to just go our own way here.

> +jobs:
> +  coverity:
> +    if: contains(fromJSON(vars.ENABLE_COVERITY_SCAN_FOR_BRANCHES || '[""]'), github.ref_name)
> +    runs-on: ubuntu-latest
> +    env:
> +      COVERITY_PROJECT: git
> +      COVERITY_LANGUAGE: cxx
> +      COVERITY_PLATFORM: linux64

Ah, now I see why you were bothered by using "git/git" at the project
name earlier. That is what I assumed we would use (and certainly I use
"peff/git" on the Coverity side), but I forgot that we already have the
general "git" name on the Coverity side (which isn't to say we couldn't
switch to using the "git/git" name, but I am happy for us to be just
"git" there).

> +    steps:
> +      - uses: actions/checkout@v3
> +      - run: ci/install-dependencies.sh
> +        env:
> +          runs_on_pool: ubuntu-latest
> +
> +      - name: download the Coverity Build Tool (${{ env.COVERITY_LANGUAGE }} / ${{ env.COVERITY_PLATFORM}})
> +        run: |
> +          curl https://scan.coverity.com/download/$COVERITY_LANGUAGE/$COVERITY_PLATFORM \
> +            --no-progress-meter \
> +            --output $RUNNER_TEMP/cov-analysis.tgz \
> +            --data "token=${{ secrets.COVERITY_SCAN_TOKEN }}&project=$COVERITY_PROJECT"

You might want "--fail" or "--fail-with-body" here. I think any
server-side errors (like a missing or invalid token or project name)
will result in a 401. Having curl reported that as a non-zero exit
should stop the Action with a failure, rather than silently continuing.

This is mostly a style suggestion, but I think you can use:

  --form token="${{ secrets.COVERITY_SCAN_TOKEN }}" \
  --form project="$COVERITY_PROJECT"

here, which IMHO is a little more readable than "data". It probably
doesn't matter in practice, but I think it would also would handle any
encoding for us (though note that if we wanted to be really careful, the
TOKEN secret would need shell quoting).

Using --form will use multipart/form-data instead of
application/x-www-form-url-encoded, but coverity seems happy with
either.

> +      - name: extract the Coverity Build Tool
> +        run: |
> +          mkdir $RUNNER_TEMP/cov-analysis &&
> +          tar -xzf $RUNNER_TEMP/cov-analysis.tgz --strip 1 -C $RUNNER_TEMP/cov-analysis

OK, we are starting without Windows support yet. :)

> +      - name: build with cov-build
> +        run: |
> +          export PATH="$RUNNER_TEMP/cov-analysis/bin:$PATH" &&
> +          cov-configure --gcc &&
> +          cov-build --dir cov-int make -j$(nproc)
> +      - name: package the build
> +        run: tar -czvf cov-int.tgz cov-int

OK, this looks a lot like what my custom rule does (no surprise, since
we are all adapting Coverity's instructions).

> +      - name: submit the build to Coverity Scan
> +        run: |
> +          curl \
> +            --form token="${{ secrets.COVERITY_SCAN_TOKEN }}" \
> +            --form email="${{ secrets.COVERITY_SCAN_EMAIL }}" \
> +            --form file=@cov-int.tgz \
> +            --form version="${{ github.sha }}" \
> +            "https://scan.coverity.com/builds?project=$COVERITY_PROJECT"

Likewise. I add:

  --form description="$(./git version)"

to mine, but I am not even sure where that ends up (the "version" is
probably the most interesting bit, as that is shown on the Coverity
project page).

I notice you put the "project" variable in the query string. Can it be
a --form, too, for symmetry? (In mine, I seem to have it as _both_,
which is probably just a mistake). Not a huge deal either way, but just
a small readability thing.

As with above, we'd probably want --fail or --fail-with-body here to
detect errors (since otherwise a failed upload goes completely
unreported).

-Peff
