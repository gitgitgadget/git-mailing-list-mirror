Return-Path: <SRS0=cV3L=C2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 272DAC43461
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 16:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D986621D41
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 16:48:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728595AbgIQQsq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 12:48:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:60252 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728517AbgIQQsL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 12:48:11 -0400
Received: (qmail 1807 invoked by uid 109); 17 Sep 2020 16:47:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 17 Sep 2020 16:47:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10649 invoked by uid 111); 17 Sep 2020 16:47:44 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 17 Sep 2020 12:47:44 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 17 Sep 2020 12:47:43 -0400
From:   Jeff King <peff@peff.net>
To:     Rasmus Villemoes <rv@rasmusvillemoes.dk>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <stefanbeller@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH] packfile: actually set approximate_object_count_valid
Message-ID: <20200917164743.GA3731633@coredump.intra.peff.net>
References: <4a018cb9-da40-a98f-a1b9-73be30ae79ec@rasmusvillemoes.dk>
 <20200917125333.GA3024501@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200917125333.GA3024501@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 17, 2020 at 08:53:33AM -0400, Jeff King wrote:

> Still not great, but caching the count did save us 15%. That seems worth
> it to me (1000 packs is more than we'd hope for, but not uncommon in a
> poorly maintained repo). The failure to set the flag is just a bug;
> looks like mine from 8e3f52d778 (find_unique_abbrev: move logic out of
> get_short_sha1(), 2016-10-03).
> 
> You're right that caching runs the risk of the cache being invalidated.
> But in this case I think we're covered. We'd generally modify packed_git
> only via reprepare_packed_git(), prepare_packed_git(), and we do reset
> the flag there. Plus count is only meant to be approximate, so even if
> it ended up stale within a single process, I don't think it would be
> that big a deal.

So here it is wrapped up as a patch. I think it's worth fixing (as
opposed to dropping the unused flag code). Thanks for finding it.

-- >8 --
Subject: [PATCH] packfile: actually set approximate_object_count_valid

The approximate_object_count() function tries to compute the count only
once per process. But ever since it was introduced in 8e3f52d778
(find_unique_abbrev: move logic out of get_short_sha1(), 2016-10-03), we
failed to actually set the "valid" flag, meaning we'd compute it fresh
on every call.

This turns out not to be _too_ bad, because we're only iterating through
the packed_git list, and not making any system calls. But since it may
get called for every abbreviated hash we output, even this can add up if
you have many packs.

Here are before-and-after timings for a new perf test which just asks
rev-list to abbreviate each commit hash (the test repo is linux.git,
with commit-graphs):

  Test                            origin              HEAD
  ----------------------------------------------------------------------------
  5303.3: rev-list (1)            28.91(28.46+0.44)   29.03(28.65+0.38) +0.4%
  5303.4: abbrev-commit (1)       1.18(1.06+0.11)     1.17(1.02+0.14) -0.8%
  5303.7: rev-list (50)           28.95(28.56+0.38)   29.50(29.17+0.32) +1.9%
  5303.8: abbrev-commit (50)      3.67(3.56+0.10)     3.57(3.42+0.15) -2.7%
  5303.11: rev-list (1000)        30.34(29.89+0.43)   30.82(30.35+0.46) +1.6%
  5303.12: abbrev-commit (1000)   86.82(86.52+0.29)   77.82(77.59+0.22) -10.4%
  5303.15: load 10,000 packs      0.08(0.02+0.05)     0.08(0.02+0.06) +0.0%

It doesn't help at all when we have 1 pack (5303.4), but we get a 10%
speedup when there are 1000 packs (5303.12). That's a modest speedup for
a case that's already slow and we'd hope to avoid in general (note how
slow it is even after, because we have to look in each of those packs
for abbreviations). But it's a one-line change that clearly matches the
original intent, so it seems worth doing.

The included perf test may also be useful for keeping an eye on any
regressions in the overall abbreviation code.

Reported-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
Signed-off-by: Jeff King <peff@peff.net>
---
 packfile.c                 | 1 +
 t/perf/p5303-many-packs.sh | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/packfile.c b/packfile.c
index 9ef27508f2..e69012e7f2 100644
--- a/packfile.c
+++ b/packfile.c
@@ -923,6 +923,7 @@ unsigned long repo_approximate_object_count(struct repository *r)
 			count += p->num_objects;
 		}
 		r->objects->approximate_object_count = count;
+		r->objects->approximate_object_count_valid = 1;
 	}
 	return r->objects->approximate_object_count;
 }
diff --git a/t/perf/p5303-many-packs.sh b/t/perf/p5303-many-packs.sh
index 7ee791669a..f4c2ab0584 100755
--- a/t/perf/p5303-many-packs.sh
+++ b/t/perf/p5303-many-packs.sh
@@ -73,6 +73,10 @@ do
 		git rev-list --objects --all >/dev/null
 	'
 
+	test_perf "abbrev-commit ($nr_packs)" '
+		git rev-list --abbrev-commit HEAD >/dev/null
+	'
+
 	# This simulates the interesting part of the repack, which is the
 	# actual pack generation, without smudging the on-disk setup
 	# between trials.
-- 
2.28.0.982.gdd163d6eb1

