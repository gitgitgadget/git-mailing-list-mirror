Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FD2B1F5CB
	for <e@80x24.org>; Mon, 22 Apr 2019 21:19:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729314AbfDVVTz (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Apr 2019 17:19:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:37294 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729275AbfDVVTy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Apr 2019 17:19:54 -0400
Received: (qmail 6396 invoked by uid 109); 22 Apr 2019 21:19:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 22 Apr 2019 21:19:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2985 invoked by uid 111); 22 Apr 2019 21:20:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 22 Apr 2019 17:20:26 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Apr 2019 17:19:52 -0400
Date:   Mon, 22 Apr 2019 17:19:52 -0400
From:   Jeff King <peff@peff.net>
To:     Martin Fick <mfick@codeaurora.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH] p5302: create the repo in each index-pack test
Message-ID: <20190422211952.GA4728@sigill.intra.peff.net>
References: <259296914.jpyqiltySj@mfick-lnx>
 <20190420035825.GB3559@sigill.intra.peff.net>
 <16052712.dFCfNLlQnN@mfick-lnx>
 <20190422205653.GA30286@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190422205653.GA30286@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 22, 2019 at 04:56:53PM -0400, Jeff King wrote:

> > I am running some index packs to test the theory, I can tell you already that 
> > the 56 thread versions was much slower, it took 397m25.622s. I am running a 
> > few other tests also, but it will take a while to get an answer. Since things 
> > take hours to test, I made a repo with a single branch (and the tags for that 
> > branch) from this bigger repo using a git init/git fetch. The single branch 
> > repo takes about 12s to clone, but it takes around 14s with 3 threads to run 
> > index-pack, any ideas why it is slower than a clone?
> 
> Are you running it in the same repo, or in another newly-created repo?
> Or alternatively, in a new repo but repeatedly running index-pack? After
> the first run, that repo will have all of the objects. And so for each
> object it sees, index-pack will say "woah, we already had that one;
> let's double check that they're byte for byte identical" which carries
> extra overhead (and probably makes the lock contention way worse, too,
> because accessing existing objects just has one big coarse lock).
> 
> So definitely do something like:
> 
>   for threads in 1 2 3 4 5 12 56; do
> 	rm -rf repo.git
> 	git init --bare repo.git
> 	GIT_FORCE_THREADS=$threads \
> 	  git -C repo.git index-pack -v --stdin </path/to/pack
>   done
> 
> to test.

This is roughly what p5302 is going, though it does not go as high as
56 (though it seems like there is probably not much point in doing so).

However, I did notice this slight bug in it. After this fix, here are my
numbers from indexing git.git:

  Test                                           HEAD             
  ----------------------------------------------------------------
  5302.2: index-pack 0 threads                   22.72(22.55+0.16)
  5302.3: index-pack 1 thread                    23.26(23.02+0.24)
  5302.4: index-pack 2 threads                   13.19(24.06+0.23)
  5302.5: index-pack 4 threads                   7.96(24.65+0.25) 
  5302.6: index-pack 8 threads                   7.94(45.06+0.38) 
  5302.7: index-pack default number of threads   9.37(23.82+0.18) 

So it looks like "4" is slightly better than the default of "3" for me.

I'm running it on linux.git now, but it will take quite a while to come
up with a result.

-- >8 --
Subject: [PATCH] p5302: create the repo in each index-pack test

The p5302 script runs "index-pack --stdin" in each timing test. It does
two things to try to get good timings:

  1. we do the repo creation in a separate (non-timed) setup test, so
     that our timing is purely the index-pack run

  2. we use a separate repo for each test; this is important because the
     presence of existing objects in the repo influences the result
     (because we'll end up doing collision checks against them)

But this forgets one thing: we generally run each timed test multiple
times to reduce the impact of noise. Which means that repeats of each
test after the first will be subject to the collision slowdown from
point 2, and we'll generally just end up taking the first time anyway.

Instead, let's create the repo in the test (effectively undoing point
1). That does add a constant amount of extra work to each iteration, but
it's quite small compared to the actual effects we're interested in
measuring.

Signed-off-by: Jeff King <peff@peff.net>
---
The very first 0-thread one will run faster because it has less to "rm
-rf", but I think we can ignore that.

 t/perf/p5302-pack-index.sh | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/t/perf/p5302-pack-index.sh b/t/perf/p5302-pack-index.sh
index 99bdb16c85..a9b3e112d9 100755
--- a/t/perf/p5302-pack-index.sh
+++ b/t/perf/p5302-pack-index.sh
@@ -13,35 +13,40 @@ test_expect_success 'repack' '
 	export PACK
 '
 
-test_expect_success 'create target repositories' '
-	for repo in t1 t2 t3 t4 t5 t6
-	do
-		git init --bare $repo
-	done
-'
-
 test_perf 'index-pack 0 threads' '
-	GIT_DIR=t1 git index-pack --threads=1 --stdin < $PACK
+	rm -rf repo.git &&
+	git init --bare repo.git &&
+	GIT_DIR=repo.git git index-pack --threads=1 --stdin < $PACK
 '
 
 test_perf 'index-pack 1 thread ' '
-	GIT_DIR=t2 GIT_FORCE_THREADS=1 git index-pack --threads=1 --stdin < $PACK
+	rm -rf repo.git &&
+	git init --bare repo.git &&
+	GIT_DIR=repo.git GIT_FORCE_THREADS=1 git index-pack --threads=1 --stdin < $PACK
 '
 
 test_perf 'index-pack 2 threads' '
-	GIT_DIR=t3 git index-pack --threads=2 --stdin < $PACK
+	rm -rf repo.git &&
+	git init --bare repo.git &&
+	GIT_DIR=repo.git git index-pack --threads=2 --stdin < $PACK
 '
 
 test_perf 'index-pack 4 threads' '
-	GIT_DIR=t4 git index-pack --threads=4 --stdin < $PACK
+	rm -rf repo.git &&
+	git init --bare repo.git &&
+	GIT_DIR=repo.git git index-pack --threads=4 --stdin < $PACK
 '
 
 test_perf 'index-pack 8 threads' '
-	GIT_DIR=t5 git index-pack --threads=8 --stdin < $PACK
+	rm -rf repo.git &&
+	git init --bare repo.git &&
+	GIT_DIR=repo.git git index-pack --threads=8 --stdin < $PACK
 '
 
 test_perf 'index-pack default number of threads' '
-	GIT_DIR=t6 git index-pack --stdin < $PACK
+	rm -rf repo.git &&
+	git init --bare repo.git &&
+	GIT_DIR=repo.git git index-pack --stdin < $PACK
 '
 
 test_done
-- 
2.21.0.1182.g3590c06d32

