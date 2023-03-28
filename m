Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA8FC761A6
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 21:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjC1VI2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 17:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjC1VIV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 17:08:21 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654FB1FFF
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 14:08:16 -0700 (PDT)
Received: (qmail 2548 invoked by uid 109); 28 Mar 2023 21:08:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 28 Mar 2023 21:08:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2388 invoked by uid 111); 28 Mar 2023 21:08:14 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Mar 2023 17:08:14 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 28 Mar 2023 17:08:14 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Michael J Gruber <git@grubix.eu>
Subject: Re: [PATCH 0/4] some chainlint fixes and performance improvements
Message-ID: <20230328210814.GA1754178@coredump.intra.peff.net>
References: <20230328202043.GA1241391@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230328202043.GA1241391@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 28, 2023 at 04:20:44PM -0400, Jeff King wrote:

> The rest are some old performance improvement ideas I had for the
> internal chain-linter. I doubt they make a huge difference overall,
> but they can be measured in certain cases.  The first one to me looks
> like an obvious win. The second one is debatable, as it involves some
> hand-waving. The third one turned out not to make anything faster, but
> makes the code a little simpler.

BTW, I noticed something really funky when timing t3070 for this series.

  $ time ./t3070-wildmatch.sh
  [a bunch of output]
  real	0m4.750s
  user	0m3.665s
  sys	0m0.955s

  $ time ./t3070-wildmatch.sh >/dev/null
  real	0m18.664s
  user	0m9.185s
  sys	0m9.495s

Er, what? It gets way slower when redirected to /dev/null. I can't
figure out why. Replacing the actual tests with a simple command shows
the same behavior, so it's not a problem in the tested commands. I tried
simplifying what the test script was doing, but it really looks like the
slowdown scales with the number of subshells/forks.

The problem is also independent of shell (bash vs dash). And here's an
even weirder bit. If I pipe the output through cat, it's still fast:

  $ time ./t3070-wildmatch.sh | cat
  [lots of output]
  real	0m4.719s
  user	0m3.636s
  sys	0m0.946s

but when cat goes to /dev/null, it's slow again!

  $ time ./t3070-wildmatch.sh | cat >/dev/null
  real	0m18.383s
  user	0m8.987s
  sys	0m9.450s

So our scripts are seeing the same environment (a pipe), but somehow cat
on the other side is slowing things down. Which seems to me like it
could be a kernel problem, but it's hard to imagine what. I tried a few
versions and couldn't find one that didn't exhibit it.  This is a Debian
unstable machine (so running kernel 6.1.20). Another machine running
stable (so kernel 5.15) did not exhibit the problem, but there are many
different variables beyond kernel version there.

So this doesn't seem like a Git problem at all, but it's an interesting
mystery, and I wondered if anybody else has run into it.

-Peff
