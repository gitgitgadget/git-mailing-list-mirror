Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04F0D1FAFB
	for <e@80x24.org>; Sat,  8 Apr 2017 10:36:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751660AbdDHKgV (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Apr 2017 06:36:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:58462 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751397AbdDHKgT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Apr 2017 06:36:19 -0400
Received: (qmail 5670 invoked by uid 109); 8 Apr 2017 10:36:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 08 Apr 2017 10:36:16 +0000
Received: (qmail 10840 invoked by uid 111); 8 Apr 2017 10:36:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 08 Apr 2017 06:36:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 08 Apr 2017 06:36:14 -0400
Date:   Sat, 8 Apr 2017 06:36:14 -0400
From:   Jeff King <peff@peff.net>
To:     git@jeffhostetler.com
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v7 2/3] p0004-read-tree: perf test to time read-tree
Message-ID: <20170408103614.w6xhbdbslonwcr65@sigill.intra.peff.net>
References: <20170407212047.64950-1-git@jeffhostetler.com>
 <20170407212047.64950-3-git@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170407212047.64950-3-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 07, 2017 at 09:20:46PM +0000, git@jeffhostetler.com wrote:

> diff --git a/t/perf/p0004-read-tree.sh b/t/perf/p0004-read-tree.sh
> new file mode 100755
> index 0000000..a70e969

I think p0004 is taken by your lazy-init-name-hash script already
(which, btw, I think is missing its executable bit).

> +## usage: dir depth width files
> +fill_index() {
> +	awk -v arg_dir=$1 -v arg_depth=$2 -v arg_width=$3 -v arg_files=$4 '
> +		function make_paths(dir, depth, width, files, f, w) {
> +			for (f = 1; f <= files; f++) {
> +				print dir "/file" f
> +			}
> +			if (depth > 0) {
> +				for (w = 1; w <= width; w++) {
> +					make_paths(dir "/dir" w, depth - 1, width, files)
> +				}
> +			}
> +		}
> +		END { make_paths(arg_dir, arg_depth, arg_width, arg_files) }
> +' </dev/null |
> +	sed "s/^/100644 $EMPTY_BLOB	/" |
> +	git update-index --index-info
> +	return 0
> +}

I saw some discussion earlier on testing synthetic versus real
repositories. The original point of the perf test suite was to find
performance regressions between versions. So periodically you'd run:

  cd t/perf
  ./run v2.10.0 HEAD

and make sure that nothing got inexplicably slower. And for that, using
real repositories is nice, because it's showing real user-impacting
performance changes, not synthetic benchmarks.

In an ideal world, people run it against their own real repositories and
can report back to the list when they see a problem. So running the
whole suite against your monstrous Windows repo would be a nice
benchmark to do periodically (I shudder to think how long it might take
to run, though).

Of course, perf scripts are also a nice way to show off your
improvements. And synthetic repos can often exaggerate the improvement
(which is sometimes good to see changes, but also sometimes bad if
real-world repos don't show the improvement). And they also serve as a
reproduction case for people who don't necessarily have access to the
extreme repo that motivated the test in the first place.

But one side effect of writing the perf test the way you have it here is
that you _can't_ easily run it against a real repo. I think the perf
suite could provide better tools for this. You can already say "run this
test against repo X" with GIT_PERF_REPO. But there's no way to say
"create a synthetic repo with parameters X,Y,Z, and run against that".

IOW, I think rather than having the perf-scripts themselves create the
synthetic repo, we should have a _library_ of synthetic repos that the
test-runners can choose from. I'm imagining a world where your repo
setup goes into t/perf/repos/many-files.sh (which could even take your
depth, width, and files parameters to allow experimenting), and then you
could run "GIT_PERF_REPO=many-files ./p0004-read-tree.sh".

> +br_base=xxx_base_xxx
> +br_work1=xxx_work1_xxx
> +br_work2=xxx_work2_xxx
> +br_work3=xxx_work3_xxx

FWIW, I really dislike the extra level of indirection here. You still
have to consistently say $br_base everywhere. Why not just call the
branch "br_base" in the first place?

My experience has been that debugging tests is much easier when as
little state is carried in the environment as possible. Because it's
quite often reasonable to do:

  ./t1234-whatever.sh -v -i
  cd trash*
  git cmd-that-failed

where you can pick the final line out from the failed test output. When
the command involves $br_base, I have to dig into the script to find out
what's in that variable.

I know that perf tests need less debugging than the regular regression
tests, but I'd hate to see this pattern get applied liberally.

-Peff
