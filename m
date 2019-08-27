Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45B301F461
	for <e@80x24.org>; Tue, 27 Aug 2019 03:35:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbfH0DfF (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 23:35:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:56944 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728025AbfH0DfF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 23:35:05 -0400
Received: (qmail 13390 invoked by uid 109); 27 Aug 2019 03:35:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 27 Aug 2019 03:35:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27105 invoked by uid 111); 27 Aug 2019 03:36:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 26 Aug 2019 23:36:28 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 26 Aug 2019 23:35:04 -0400
From:   Jeff King <peff@peff.net>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     git@vger.kernel.org
Subject: Re: Missing file in 2.23 (p5302-pack-index.subtests)?
Message-ID: <20190827033503.GA571@sigill.intra.peff.net>
References: <20190818160317.GA13772@mit.edu>
 <20190826205012.GB27762@sigill.intra.peff.net>
 <20190827012942.GD28066@mit.edu>
 <20190827022700.GA31125@sigill.intra.peff.net>
 <20190827025811.GJ28066@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190827025811.GJ28066@mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 26, 2019 at 10:58:11PM -0400, Theodore Y. Ts'o wrote:

> On Mon, Aug 26, 2019 at 10:27:00PM -0400, Jeff King wrote:
> > > cannot open test-results/p5302-pack-index.subtests: No such file or directory at ./aggregate.perl line 153.
> > 
> > Implies that we're trying to _write_ to it, and that the problem is that
> > test-results doesn't exist. That should be set up by this part of
> > perf-lib:
> 
> Hmm....   test-results does exist after the failure:

Ah, never mind. I was thinking it was coming from this line in perf-lib:

   echo "$test_count" >>"$perf_results_dir"/$base.subtests

But it it is pretty clear from this line of your output:

> cannot open test-results/p5302-pack-index.subtests: No such file or directory at ./aggregate.perl line 153.

...that this is the aggregate script that is run afterwards complaining.
So for whatever reason, the actual p5302 script is exiting early, before
it writes anything into the subtests file (from the line above).

That subtests write is done in test_wrapper_(), which is only triggered
for actual timing tests, not for setup tests (like the repack step that
starts this script). So the plausible sequence of events here is:

  1. The first "test_expect_success repack" test fails for some reason.
     Try running "./p5302-pack-index -v -i -x" to see more output.

  2. After the initial failure, the script exits totally rather than
     continue. That's due to this line in perf-lib, which acts as if
     "-i" is always set:

       # Performance tests should never fail.  If they do, stop immediately
       immediate=t

     That makes sense, since any timings we do after a setup step fails
     would invalidate the result. And if it's not the _first_ such step
     that fails, we'll just have a truncated subtests file, and some
     timings will be missing. But when the first one fails, there's no
     file at all.

     We could probably leave a more consistent state in that case. E.g.,
     something like this:

diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index b58a43ea43..cfac2c3cbe 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -48,7 +48,7 @@ export MODERN_GIT
 perf_results_dir=$TEST_OUTPUT_DIRECTORY/test-results
 test -n "$GIT_PERF_SUBSECTION" && perf_results_dir="$perf_results_dir/$GIT_PERF_SUBSECTION"
 mkdir -p "$perf_results_dir"
-rm -f "$perf_results_dir"/$(basename "$0" .sh).subtests
+>"$perf_results_dir"/$(basename "$0" .sh).subtests
 
 die_if_build_dir_not_repo () {
 	if ! ( cd "$TEST_DIRECTORY/.." &&


     which would just quietly omit the rest of p5302. It is unfortunate
     that you wouldn't get some note in the output saying "hey, we
     didn't run some tests!".

     A lot of this has to do with the hackish way that the list of tests
     is generated. If you do something like:

       ./run HEAD^ HEAD p5302-pack-index.sh

     and the tests fail in HEAD^ but not HEAD, you'll get a nice table
     listing all of the tests, with a nil field for each one that didn't
     run in HEAD^.

     But that's because the second run, on HEAD, actually generated a
     correct p5302-pack-index.subtests file, that actually mentioned the
     tests! If the order were reversed, you'd get an empty list.

     So I think in the long run, it would be nice to have some way of
     generating the list that's more robust to failures. But I suspect
     doing that is going to be hard; a lot of this is rooted in the fact
     that there's no data structure with the set of tests, but literally
     an executable shell script that decides what to run.

So short answer: use "-v" to figure out why the repack is failing, and
the rest is just Git's perf suite being a bit hacky.

-Peff
