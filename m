Return-Path: <SRS0=lIKx=5L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61EF1C43331
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 07:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E83F20719
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 07:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbgCZHyi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 03:54:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:51824 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726296AbgCZHyh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 03:54:37 -0400
Received: (qmail 517 invoked by uid 109); 26 Mar 2020 07:54:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 26 Mar 2020 07:54:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11863 invoked by uid 111); 26 Mar 2020 08:04:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 26 Mar 2020 04:04:31 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 26 Mar 2020 03:54:36 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH] p5310: stop timing non-bitmap pack-to-disk
Message-ID: <20200326075436.GA2199958@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 645c432d61 (pack-objects: use reachability bitmap index when
generating non-stdout pack, 2016-09-10) added two timing tests for
packing to an on-disk file, both with and without bitmaps. However, the
non-bitmap one isn't interesting to have as part of p5310's regression
suite. It _could_ be used as a baseline to show off the improvement in
the bitmap case, but:

  - the point of the t/perf suite is to find performance regressions,
    and it won't help with that. We don't compare the numbers between
    two tests (which the perf suite has no idea are even related), and
    any change in its numbers would have nothing to do with bitmaps.

  - it did show off the improvement in the commit message of 645c432d61,
    but it wasn't even necessary there. The bitmap case already shows an
    improvement (because before the patch, it behaved the same as the
    non-bitmap case), and the perf suite is even able to show the
    difference between the before and after measurements.

On top of that, it's one of the most expensive tests in the suite,
clocking in around 60s for linux.git on my machine (as compared to 16s
for the bitmapped version). And by default when using "./run", we'd run
it three times!

So let's just drop it. It's not useful and is adding minutes to perf
runs.

Signed-off-by: Jeff King <peff@peff.net>
---
I happened to be running p5310 today and was annoyed by this.

The other really expensive part is the actual "git repack" to generate
the bitmaps. We can't avoid running that (since we need the bitmaps it
generates), but it's mildly annoying that it runs all three times.
However, I think it's worth keeping as a timed test, as it would help us
find a performance regression in the bitmap generation code. It's too
bad we have to do the full repack for each trial, but we don't have a
way to just write bitmaps for an existing pack (it's conceptually
simple, but the code is pretty tied into pack-objects).

 t/perf/p5310-pack-bitmaps.sh | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/t/perf/p5310-pack-bitmaps.sh b/t/perf/p5310-pack-bitmaps.sh
index 7743f4f4c9..80c53edca7 100755
--- a/t/perf/p5310-pack-bitmaps.sh
+++ b/t/perf/p5310-pack-bitmaps.sh
@@ -31,10 +31,6 @@ test_perf 'simulated fetch' '
 	} | git pack-objects --revs --stdout >/dev/null
 '
 
-test_perf 'pack to file' '
-	git pack-objects --all pack1 </dev/null >/dev/null
-'
-
 test_perf 'pack to file (bitmap)' '
 	git pack-objects --use-bitmap-index --all pack1b </dev/null >/dev/null
 '
-- 
2.26.0.576.gb87790c3c1
