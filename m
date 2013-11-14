From: Jeff King <peff@peff.net>
Subject: [PATCH v3 20/21] t/perf: add tests for pack bitmaps
Date: Thu, 14 Nov 2013 07:48:34 -0500
Message-ID: <20131114124834.GA11612@sigill.intra.peff.net>
References: <20131114124157.GA23784@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Vicent =?utf-8?B?TWFydMOt?= <vicent@github.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 14 13:48:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgwLg-0003wl-JH
	for gcvg-git-2@plane.gmane.org; Thu, 14 Nov 2013 13:48:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752932Ab3KNMsh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Nov 2013 07:48:37 -0500
Received: from cloud.peff.net ([50.56.180.127]:39159 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751181Ab3KNMsg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Nov 2013 07:48:36 -0500
Received: (qmail 11871 invoked by uid 102); 14 Nov 2013 12:48:35 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 14 Nov 2013 06:48:35 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Nov 2013 07:48:34 -0500
Content-Disposition: inline
In-Reply-To: <20131114124157.GA23784@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237844>

This adds a few basic perf tests for the pack bitmap code to
show off its improvements. The tests are:

  1. How long does it take to do a repack (it gets slower
     with bitmaps, since we have to do extra work)?

  2. How long does it take to do a clone (it gets faster
     with bitmaps)?

  3. How does a small fetch perform when we've just
     repacked?

  4. How does a clone perform when we haven't repacked since
     a week of pushes?

Here are results against linux.git:

Test                      origin/master       this tree
-----------------------------------------------------------------------
5310.2: repack to disk    33.64(32.64+2.04)   67.67(66.75+1.84) +101.2%
5310.3: simulated clone   30.49(29.47+2.05)   1.20(1.10+0.10) -96.1%
5310.4: simulated fetch   3.49(6.79+0.06)     5.57(22.35+0.07) +59.6%
5310.6: partial bitmap    36.70(43.87+1.81)   8.18(21.92+0.73) -77.7%

You can see that we do take longer to repack, but we do way
better for further clones. A small fetch performs a bit
worse, as we spend way more time on delta compression (note
the heavy user CPU time, as we have 8 threads) due to the
lack of name hashes for the bitmapped objects.

The final test shows how the bitmaps degrade over time
between packs. There's still a significant speedup over the
non-bitmap case, but we don't do quite as well (we have to
spend time accessing the "new" objects the old fashioned
way, including delta compression).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/perf/p5310-pack-bitmaps.sh | 56 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100755 t/perf/p5310-pack-bitmaps.sh

diff --git a/t/perf/p5310-pack-bitmaps.sh b/t/perf/p5310-pack-bitmaps.sh
new file mode 100755
index 0000000..ac036d0
--- /dev/null
+++ b/t/perf/p5310-pack-bitmaps.sh
@@ -0,0 +1,56 @@
+#!/bin/sh
+
+test_description='Tests pack performance using bitmaps'
+. ./perf-lib.sh
+
+test_perf_large_repo
+
+# note that we do everything through config,
+# since we want to be able to compare bitmap-aware
+# git versus non-bitmap git
+test_expect_success 'setup bitmap config' '
+	git config pack.writebitmaps true
+'
+
+test_perf 'repack to disk' '
+	git repack -ad
+'
+
+test_perf 'simulated clone' '
+	git pack-objects --stdout --all </dev/null >/dev/null
+'
+
+test_perf 'simulated fetch' '
+	have=$(git rev-list HEAD --until=1.week.ago -1) &&
+	{
+		echo HEAD &&
+		echo ^$have
+	} | git pack-objects --revs --stdout >/dev/null
+'
+
+test_expect_success 'create partial bitmap state' '
+	# pick a commit to represent the repo tip in the past
+	cutoff=$(git rev-list HEAD --until=1.week.ago -1) &&
+	orig_tip=$(git rev-parse HEAD) &&
+
+	# now kill off all of the refs and pretend we had
+	# just the one tip
+	rm -rf .git/logs .git/refs/* .git/packed-refs
+	git update-ref HEAD $cutoff
+
+	# and then repack, which will leave us with a nice
+	# big bitmap pack of the "old" history, and all of
+	# the new history will be loose, as if it had been pushed
+	# up incrementally and exploded via unpack-objects
+	git repack -Ad
+
+	# and now restore our original tip, as if the pushes
+	# had happened
+	git update-ref HEAD $orig_tip
+'
+
+test_perf 'partial bitmap' '
+	git pack-objects --stdout --all </dev/null >/dev/null
+'
+
+test_done
-- 
1.8.5.rc0.443.g2df7f3f
