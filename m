Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F8591F461
	for <e@80x24.org>; Tue, 27 Aug 2019 02:27:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbfH0C1B (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 22:27:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:56886 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727227AbfH0C1B (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 22:27:01 -0400
Received: (qmail 12656 invoked by uid 109); 27 Aug 2019 02:27:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 27 Aug 2019 02:27:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26720 invoked by uid 111); 27 Aug 2019 02:28:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 26 Aug 2019 22:28:24 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 26 Aug 2019 22:27:00 -0400
From:   Jeff King <peff@peff.net>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     git@vger.kernel.org
Subject: Re: Missing file in 2.23 (p5302-pack-index.subtests)?
Message-ID: <20190827022700.GA31125@sigill.intra.peff.net>
References: <20190818160317.GA13772@mit.edu>
 <20190826205012.GB27762@sigill.intra.peff.net>
 <20190827012942.GD28066@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190827012942.GD28066@mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 26, 2019 at 09:29:42PM -0400, Theodore Y. Ts'o wrote:

> > > I presume that's becuase the file t/perf/test-results/p5302-pack-index.subtests is missing?
> > 
> > That file should be created by running p5302. If you do:
> > 
> >   cd t/perf
> >   rm -rf test-results
> >   ./run p5302-pack-index.sh
> > 
> > is it generated?
> 
> No, it wasn't.  See below....

Weird. The output here:

> 1141% rm -rf test-results ; ./run p5302-pack-index.sh
> === Running 1 tests in this tree ===
> warning: $GIT_PERF_LARGE_REPO is $GIT_BUILD_DIR.
> warning: This will work, but may not be a sufficiently large repo
> warning: for representative measurements.
> not ok 1 - repack
> #	
> #		git repack -ad &&
> #		PACK=$(ls .git/objects/pack/*.pack | head -n1) &&
> #		test -f "$PACK" &&
> #		export PACK
> #	
> cannot open test-results/p5302-pack-index.subtests: No such file or directory at ./aggregate.perl line 153.

Implies that we're trying to _write_ to it, and that the problem is that
test-results doesn't exist. That should be set up by this part of
perf-lib:

  perf_results_dir=$TEST_OUTPUT_DIRECTORY/test-results
  test -n "$GIT_PERF_SUBSECTION" && perf_results_dir="$perf_results_dir/$GIT_PERF_SUBSECTION"
  mkdir -p "$perf_results_dir"
  rm -f "$perf_results_dir"/$(basename "$0" .sh).subtests

I don't know why that would be failing for you (and not producing any
kind of message!). You might need to poke at:

  ./p5302-pack-index.sh -x

to see what is going on.

It's also weird that the repack fails for you. And that (presumably?)
this is the only script that fails, since they would all want to do
this.

There are some bits of test-lib.sh that re-exec the script, but I think
we ironed out the weirdness there (and I use "--verbose-log" myself,
which is one such option). But just in case: do you set GIT_TEST_OPTS in
your config.mak?

-Peff
