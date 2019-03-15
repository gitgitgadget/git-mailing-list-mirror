Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 907ED202BB
	for <e@80x24.org>; Fri, 15 Mar 2019 06:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbfCOG0q (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Mar 2019 02:26:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:52034 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728025AbfCOG0q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Mar 2019 02:26:46 -0400
Received: (qmail 16145 invoked by uid 109); 15 Mar 2019 06:26:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 15 Mar 2019 06:26:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29680 invoked by uid 111); 15 Mar 2019 06:25:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 15 Mar 2019 02:25:50 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Mar 2019 02:25:28 -0400
Date:   Fri, 15 Mar 2019 02:25:28 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH 2/2] pack-objects: default to writing bitmap hash-cache
Message-ID: <20190315062528.GB13466@sigill.intra.peff.net>
References: <20190315062133.GA13385@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190315062133.GA13385@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Enabling pack.writebitmaphashcache should always be a performance win.
It costs only 4 bytes per object on disk, and the timings in ae4f07fbcc
(pack-bitmap: implement optional name_hash cache, 2013-12-21) show it
improving fetch and partial-bitmap clone times by 40-50%.

The only reason we didn't enable it by default at the time is that early
versions of JGit's bitmap reader complained about the presence of
optional header bits it didn't understand. But that was changed in
JGit's d2fa3987a (Use bitcheck to check for presence of OPT_FULL option,
2013-10-30), which made it into JGit v3.5.0 in late 2014.

So let's turn this option on by default. It's backwards-compatible with
all versions of Git, and if you are also using JGit on the same
repository, you'd only run into problems using a version that's almost 5
years old.

We'll drop the manual setting from all of our test scripts, including
perf tests. This isn't strictly necessary, but it has two advantages:

  1. If the hash-cache ever stops being enabled by default, our perf
     regression tests will notice.

  2. We can use the modified perf tests to show off the behavior of an
     otherwise unconfigured repo, as shown below.

These are the results of a few of a perf tests against linux.git that
showed interesting results. You can see the expected speedup in 5310.4,
which was noted in ae4f07fbcc. Curiously, 5310.8 did not improve (and
actually got slower), despite seeing the opposite in ae4f07fbcc.
I don't have an explanation for that.

The tests from p5311 did not exist back then, but do show improvements
(a smaller pack due to better deltas, which we found in less time).

  Test                                    HEAD^                HEAD
  -------------------------------------------------------------------------------------
  5310.4: simulated fetch                 7.39(22.70+0.25)     5.64(11.43+0.22) -23.7%
  5310.8: clone (partial bitmap)          18.45(24.83+1.19)    19.94(28.40+1.36) +8.1%
  5311.31: server (128 days)              0.41(1.13+0.05)      0.34(0.72+0.02) -17.1%
  5311.32: size   (128 days)                         7.4M                 7.0M -4.8%
  5311.33: client (128 days)              1.33(1.49+0.06)      1.29(1.37+0.12) -3.0%

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/config/pack.txt      | 4 +---
 builtin/pack-objects.c             | 2 +-
 t/perf/p5310-pack-bitmaps.sh       | 3 +--
 t/perf/p5311-pack-bitmaps-fetch.sh | 1 -
 t/t5310-pack-bitmaps.sh            | 3 +--
 5 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/Documentation/config/pack.txt b/Documentation/config/pack.txt
index 425c73aa52..9cdcfa7324 100644
--- a/Documentation/config/pack.txt
+++ b/Documentation/config/pack.txt
@@ -124,6 +124,4 @@ pack.writeBitmapHashCache::
 	bitmapped and non-bitmapped objects (e.g., when serving a fetch
 	between an older, bitmapped pack and objects that have been
 	pushed since the last gc). The downside is that it consumes 4
-	bytes per object of disk space, and that JGit's bitmap
-	implementation does not understand it, causing it to complain if
-	Git and JGit are used on the same repository. Defaults to false.
+	bytes per object of disk space. Defaults to true.
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index a154fc29f6..5264bf055a 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -97,7 +97,7 @@ static off_t reuse_packfile_offset;
 static int use_bitmap_index_default = 1;
 static int use_bitmap_index = -1;
 static int write_bitmap_index;
-static uint16_t write_bitmap_options;
+static uint16_t write_bitmap_options = BITMAP_OPT_HASH_CACHE;
 
 static int exclude_promisor_objects;
 
diff --git a/t/perf/p5310-pack-bitmaps.sh b/t/perf/p5310-pack-bitmaps.sh
index bb91dbb173..6a3a42531b 100755
--- a/t/perf/p5310-pack-bitmaps.sh
+++ b/t/perf/p5310-pack-bitmaps.sh
@@ -12,8 +12,7 @@ test_perf_large_repo
 # We intentionally use the deprecated pack.writebitmaps
 # config so that we can test against older versions of git.
 test_expect_success 'setup bitmap config' '
-	git config pack.writebitmaps true &&
-	git config pack.writebitmaphashcache true
+	git config pack.writebitmaps true
 '
 
 test_perf 'repack to disk' '
diff --git a/t/perf/p5311-pack-bitmaps-fetch.sh b/t/perf/p5311-pack-bitmaps-fetch.sh
index b04575951f..47c3fd7581 100755
--- a/t/perf/p5311-pack-bitmaps-fetch.sh
+++ b/t/perf/p5311-pack-bitmaps-fetch.sh
@@ -7,7 +7,6 @@ test_perf_default_repo
 
 test_expect_success 'create bitmapped server repo' '
 	git config pack.writebitmaps true &&
-	git config pack.writebitmaphashcache true &&
 	git repack -ad
 '
 
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index 44a038881a..a26c8ba9a2 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -34,8 +34,7 @@ test_expect_success 'setup repo with moderate-sized history' '
 	bitmaptip=$(git rev-parse master) &&
 	blob=$(echo tagged-blob | git hash-object -w --stdin) &&
 	git tag tagged-blob $blob &&
-	git config repack.writebitmaps true &&
-	git config pack.writebitmaphashcache true
+	git config repack.writebitmaps true
 '
 
 test_expect_success 'full repack creates bitmaps' '
-- 
2.21.0.543.g90eed137f3
