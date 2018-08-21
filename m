Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8DDA1F954
	for <e@80x24.org>; Tue, 21 Aug 2018 19:07:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbeHUW2W (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Aug 2018 18:28:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:50762 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727233AbeHUW2W (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Aug 2018 18:28:22 -0400
Received: (qmail 6970 invoked by uid 109); 21 Aug 2018 19:07:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 21 Aug 2018 19:07:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26079 invoked by uid 111); 21 Aug 2018 19:07:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 21 Aug 2018 15:07:06 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Aug 2018 15:06:58 -0400
Date:   Tue, 21 Aug 2018 15:06:58 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 4/6] t/perf: add perf tests for fetches from a bitmapped
 server
Message-ID: <20180821190658.GD30764@sigill.intra.peff.net>
References: <20180821184140.GA24165@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180821184140.GA24165@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A server with bitmapped packs can serve a clone very
quickly. However, fetches are not necessarily made any
faster, because we spend a lot less time in object traversal
(which is what bitmaps help with) and more time finding
deltas (because we may have to throw out on-disk deltas if
the client does not have the base).

As a first step to making this faster, this patch introduces
a new perf script to measure fetches into a repo of various
ages from a fully-bitmapped server.

We separately measure the work done by the server (in
pack-objects) and that done by the client (in index-pack).
Furthermore, we measure the size of the resulting pack.

Breaking it down like this (instead of just doing a regular
"git fetch") lets us see how much each side benefits from
any changes. And since we know the pack size, if we estimate
the network speed, then one could calculate a complete
wall-clock time for the operation (though the script does
not do this automatically).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/perf/p5311-pack-bitmaps-fetch.sh | 45 ++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100755 t/perf/p5311-pack-bitmaps-fetch.sh

diff --git a/t/perf/p5311-pack-bitmaps-fetch.sh b/t/perf/p5311-pack-bitmaps-fetch.sh
new file mode 100755
index 0000000000..b04575951f
--- /dev/null
+++ b/t/perf/p5311-pack-bitmaps-fetch.sh
@@ -0,0 +1,45 @@
+#!/bin/sh
+
+test_description='performance of fetches from bitmapped packs'
+. ./perf-lib.sh
+
+test_perf_default_repo
+
+test_expect_success 'create bitmapped server repo' '
+	git config pack.writebitmaps true &&
+	git config pack.writebitmaphashcache true &&
+	git repack -ad
+'
+
+# simulate a fetch from a repository that last fetched N days ago, for
+# various values of N. We do so by following the first-parent chain,
+# and assume the first entry in the chain that is N days older than the current
+# HEAD is where the HEAD would have been then.
+for days in 1 2 4 8 16 32 64 128; do
+	title=$(printf '%10s' "($days days)")
+	test_expect_success "setup revs from $days days ago" '
+		now=$(git log -1 --format=%ct HEAD) &&
+		then=$(($now - ($days * 86400))) &&
+		tip=$(git rev-list -1 --first-parent --until=$then HEAD) &&
+		{
+			echo HEAD &&
+			echo ^$tip
+		} >revs
+	'
+
+	test_perf "server $title" '
+		git pack-objects --stdout --revs \
+				 --thin --delta-base-offset \
+				 <revs >tmp.pack
+	'
+
+	test_size "size   $title" '
+		wc -c <tmp.pack
+	'
+
+	test_perf "client $title" '
+		git index-pack --stdin --fix-thin <tmp.pack
+	'
+done
+
+test_done
-- 
2.19.0.rc0.398.g138a08f6f6

