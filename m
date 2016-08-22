Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1CDA2018E
	for <e@80x24.org>; Mon, 22 Aug 2016 22:01:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932514AbcHVWBO (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Aug 2016 18:01:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:59307 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1756834AbcHVWBN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2016 18:01:13 -0400
Received: (qmail 29717 invoked by uid 109); 22 Aug 2016 22:01:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Aug 2016 22:01:12 +0000
Received: (qmail 17626 invoked by uid 111); 22 Aug 2016 22:01:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Aug 2016 18:01:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Aug 2016 18:01:10 -0400
Date:   Mon, 22 Aug 2016 18:01:10 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 7/7] t/perf: add basic perf tests for delta base cache
Message-ID: <20160822220109.567ez5kslxggcb7a@sigill.intra.peff.net>
References: <20160822215725.qdikfcaz3smhulau@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160822215725.qdikfcaz3smhulau@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This just shows off the improvements done by the last few
patches, and gives us a baseline for noticing regressions in
the future. Here are the results with linux.git as the perf
"large repo":

Test                origin                HEAD
-------------------------------------------------------------------
0003.1: log --raw   43.41(40.36+2.69)     33.86(30.96+2.41) -22.0%
0003.2: log -S      313.61(309.74+3.78)   298.75(295.58+3.00) -4.7%

(for a large repo, the "log -S" improvements are greater if
you bump the delta base cache limit, but I think it makes
sense to test the "stock" behavior, since that is what most
people will see).

Signed-off-by: Jeff King <peff@peff.net>
---
I also got good times for "log -S" when measuring git.git (but _not_
when measuring "log --raw", because of its size). So I guess perhaps the
script could measure both. I'm not sure if the perf framework is ready
for using both test_default_repo and test_large_repo, though.

 t/perf/p0003-delta-base-cache.sh | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100755 t/perf/p0003-delta-base-cache.sh

diff --git a/t/perf/p0003-delta-base-cache.sh b/t/perf/p0003-delta-base-cache.sh
new file mode 100755
index 0000000..62369ea
--- /dev/null
+++ b/t/perf/p0003-delta-base-cache.sh
@@ -0,0 +1,31 @@
+#!/bin/sh
+
+test_description='Test operations that emphasize the delta base cache.
+
+We look at both "log --raw", which should put only trees into the delta cache,
+and "log -Sfoo --raw", which should look at both trees and blobs.
+
+Any effects will be emphasized if the test repository is fully packed (loose
+objects obviously do not use the delta base cache at all). It is also
+emphasized if the pack has long delta chains (e.g., as produced by "gc
+--aggressive"), though cache is still quite noticeable even with the default
+depth of 50.
+
+The setting of core.deltaBaseCacheLimit in the source repository is also
+relevant (depending on the size of your test repo), so be sure it is consistent
+between runs.
+'
+. ./perf-lib.sh
+
+test_perf_large_repo
+
+# puts mostly trees into the delta base cache
+test_perf 'log --raw' '
+	git log --raw >/dev/null
+'
+
+test_perf 'log -S' '
+	git log --raw -Sfoo >/dev/null
+'
+
+test_done
-- 
2.10.0.rc1.118.ge2299eb
