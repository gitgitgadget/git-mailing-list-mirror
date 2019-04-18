Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4024B20248
	for <e@80x24.org>; Thu, 18 Apr 2019 20:08:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389807AbfDRUIa (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Apr 2019 16:08:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:34298 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1732589AbfDRUI3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Apr 2019 16:08:29 -0400
Received: (qmail 3793 invoked by uid 109); 18 Apr 2019 20:08:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 18 Apr 2019 20:08:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3936 invoked by uid 111); 18 Apr 2019 20:09:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 18 Apr 2019 16:09:00 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Apr 2019 16:08:27 -0400
Date:   Thu, 18 Apr 2019 16:08:27 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] t5304: add a test for pruning with bitmaps
Message-ID: <20190418200827.GB15249@sigill.intra.peff.net>
References: <20190214043127.GA19019@sigill.intra.peff.net>
 <20190214043743.GB19183@sigill.intra.peff.net>
 <49e2aa9b-ff22-a8d1-ba72-1c881ff5fab4@gmail.com>
 <20190418194953.GA15249@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190418194953.GA15249@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 18, 2019 at 03:49:53PM -0400, Jeff King wrote:

> > This block after "if (bitmap_git)" is not exercised by the (non-performance)
> > test suite, so the rest of the code above is not tested, either. Could a test
> > of this "prune" capability be added to the regression tests around the bitmaps?
> 
> I have somewhat mixed feelings here.  We can add a test with a trivial
> bitmap to get code coverage here. But as with many optimizations
> (bitmaps, but also your commit graph work), we get a much more thorough
> correctness test by re-running the whole test suite (though we do not
> yet have one for running with bitmaps on), and a better test that the
> optimization is kicking in and working via the t/perf tests.
> 
> I dunno. I guess it does not hurt to at least to at least make sure this
> code is running in the normal suite. I don't think that will find the
> more interesting regressions, but at least saves us the from the most
> egregious ones ("oops, the whole thing segfaults because somebody
> changed the API" kinds of things).

So here's a test. This goes on top of jk/prune-optim (which is also
already in master).

-- >8 --
Subject: [PATCH] t5304: add a test for pruning with bitmaps

Commit fde67d6896 (prune: use bitmaps for reachability traversal,
2019-02-13) uses bitmaps for pruning when they're available, but only
covers this functionality in the t/perf tests. This makes a kind of
sense, since the point is that the behaviour is indistinguishable before
and after the patch, just faster.

But since the bitmap code path is not exercised at all in the regular
test suite, it leaves us open to a regression where the behavior does in
fact change. The most thorough way to test that would be running the
whole suite with bitmaps enabled. But we don't yet have a way to do
that, and anyway it's expensive to do so. Let's at least add a basic
test that exercises this path and make sure we prune an object we should
(and not one that we shouldn't).

That would hopefully catch the most obvious breakages early.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5304-prune.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
index 1eeb828a15..df60f18fb8 100755
--- a/t/t5304-prune.sh
+++ b/t/t5304-prune.sh
@@ -341,4 +341,12 @@ test_expect_success 'prune: handle expire option correctly' '
 	git prune --no-expire
 '
 
+test_expect_success 'trivial prune with bitmaps enabled' '
+	git repack -adb &&
+	blob=$(echo bitmap-unreachable-blob | git hash-object -w --stdin) &&
+	git prune --expire=now &&
+	git cat-file -e HEAD &&
+	test_must_fail git cat-file -e $blob
+'
+
 test_done
-- 
2.21.0.1090.g9d17dac192

