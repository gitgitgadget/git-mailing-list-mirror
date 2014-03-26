From: Jeff King <peff@peff.net>
Subject: [PATCH 4/6] t/perf: add perf tests for fetches from a bitmapped
 server
Date: Wed, 26 Mar 2014 03:22:47 -0400
Message-ID: <20140326072247.GD32193@sigill.intra.peff.net>
References: <20140326072215.GA31739@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ben Maurer <bmaurer@fb.com>, Siddharth Agarwal <sid0@fb.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 26 08:22:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSiAo-0005Oz-DK
	for gcvg-git-2@plane.gmane.org; Wed, 26 Mar 2014 08:22:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753253AbaCZHWu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2014 03:22:50 -0400
Received: from cloud.peff.net ([50.56.180.127]:47394 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753224AbaCZHWt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2014 03:22:49 -0400
Received: (qmail 14519 invoked by uid 102); 26 Mar 2014 07:22:49 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 26 Mar 2014 02:22:49 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Mar 2014 03:22:47 -0400
Content-Disposition: inline
In-Reply-To: <20140326072215.GA31739@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245165>

A server with bitmapped packs can serve a clone very
quickly. However, fetches are not necessarily made any
faster, because we spend a lot less time in object traversal
(which is what bitmaps help with) and more time finding
deltas (because we may have to throw out on-disk deltas if
the client does not have the other side).

As a first step to making this faster, this patch introduces
a new perf script to measure fetches into a repo of various
ages from a fully-bitmapped server.

We separately measure the work done by the server (in
pack-objects) and that done by the client (in index-pack).
Furthermore, we measure the size of the resulting pack.

Breaking it down like this (instead of just doing a regular
"git fetch") lets us see how much each side benefits from
any changes. And since we know the pack size, if we estimate
the network speed, then we can calculate a complete
wall-clock time for the operation.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/perf/p5311-pack-bitmaps-fetch.sh | 45 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100755 t/perf/p5311-pack-bitmaps-fetch.sh

diff --git a/t/perf/p5311-pack-bitmaps-fetch.sh b/t/perf/p5311-pack-bitmaps-fetch.sh
new file mode 100755
index 0000000..b045759
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
1.9.1.601.g7ec968e
