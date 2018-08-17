Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AD241F954
	for <e@80x24.org>; Fri, 17 Aug 2018 20:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbeHRACh (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Aug 2018 20:02:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:59290 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726334AbeHRACh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Aug 2018 20:02:37 -0400
Received: (qmail 8883 invoked by uid 109); 17 Aug 2018 20:57:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 17 Aug 2018 20:57:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28536 invoked by uid 111); 17 Aug 2018 20:57:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 17 Aug 2018 16:57:47 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Aug 2018 16:57:41 -0400
Date:   Fri, 17 Aug 2018 16:57:41 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 4/6] t/perf: add perf tests for fetches from a bitmapped
 server
Message-ID: <20180817205741.GD20088@sigill.intra.peff.net>
References: <20180817205427.GA19580@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180817205427.GA19580@sigill.intra.peff.net>
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
2.18.0.1205.g3878b1e64a

