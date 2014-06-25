From: Jeff King <peff@peff.net>
Subject: [PATCH 8/8] perf: add tests for tag --contains
Date: Wed, 25 Jun 2014 19:53:35 -0400
Message-ID: <20140625235335.GH23146@sigill.intra.peff.net>
References: <20140625233429.GA20457@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 26 01:53:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wzx0Y-0005vC-80
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jun 2014 01:53:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755871AbaFYXxi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2014 19:53:38 -0400
Received: from cloud.peff.net ([50.56.180.127]:51233 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753356AbaFYXxh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2014 19:53:37 -0400
Received: (qmail 5703 invoked by uid 102); 25 Jun 2014 23:53:37 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 25 Jun 2014 18:53:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Jun 2014 19:53:35 -0400
Content-Disposition: inline
In-Reply-To: <20140625233429.GA20457@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252480>

These tests can demonstrate the changes in "tag --contains"
speed over time. The interesting points in history are:

  - pre-ffc4b80, where we used a series of N merge-base
    traversals

  - ffc4b80 up to the current master, where we moved to a
    single depth-first traversal

  - the previous commit, where we moved from depth-first to
    a multi-tip merge-base

The interesting cases to measure are:

  - checking which tags contain a recent commit (we use
    HEAD~100 here)

  - checking which tags contain a very ancient commit (we
    use the last commit output by rev-list)

  - checking which tags contain a commit in the middle (we
    use HEAD~5000, which goes back 5 years in git.git)

  - all of the above, but instead of looking at all commits,
    considering only recent ones (we pick the most recent
    tag by its tagger date)

Here are the timings for git.git:

    Test                              ffc4b80^          origin/master             HEAD
    ----------------------------------------------------------------------------------------------------
    7000.3: contains recent/all       1.97(1.96+0.01)   0.26(0.25+0.00) -86.8%    0.27(0.26+0.00) -86.3%
    7000.4: contains recent/v2.0.1    0.08(0.08+0.00)   0.25(0.24+0.01) +212.5%   0.02(0.02+0.00) -75.0%
    7000.5: contains old/all          0.90(0.89+0.00)   0.18(0.17+0.00) -80.0%    0.27(0.26+0.00) -70.0%
    7000.6: contains old/v2.0.1       0.25(0.23+0.02)   0.03(0.03+0.00) -88.0%    0.25(0.24+0.00) +0.0%
    7000.7: contains ancient/all      1.98(1.97+0.01)   0.26(0.24+0.01) -86.9%    0.28(0.25+0.02) -85.9%
    7000.8: contains ancient/v2.0.1   1.95(1.94+0.00)   0.26(0.24+0.01) -86.7%    0.27(0.26+0.00) -86.2%

You can see that ffc4b80 vastly improved the normal case of
checking all tags. This is because we avoid walking over the
same parts of history over and over. However, when looking
only for a recent tag (v2.0.1 in these tests), it sometimes
performs much worse than the original. This is not
surprising. For a merge-base solution, we can quit when we
hit history shared between the contained commit and the tag.
For ffc4b80's depth-first approach, we typically go all the
way to the roots before backtracking. For the ancient/v2.0.1
case, that's not a big deal, because the merge base requires
us doing that anyway. But for recent/v2.0.1, the merge-base
answer should involve only recent history.

The new traversal code performs about as well as the
depth-first code in the normal case, but fixes the
regression in the recent/v2.0.1 case.

Signed-off-by: Jeff King <peff@peff.net>
---
There are still two things about the timings that puzzle me a bit.

One is that the old/all case gets slower moving from the depth-first
traversal to the merge-base one. I think this is simply because the
depth-first one may get "lucky" sometimes, and hit the commit we are
looking for on the way down. So its average case is somewhat better than
its worst case (and I would not be surprised if my choice of HEAD~5000
helps it, because it follows first parents first).

The second question is why ffc4b80^ is so much slower on the v2.0.1
tests than the new code. They should both be doing a single merge-base
traversal, and I'd expect them to take about the same amount of time
(for that matter, ancient/v2.0.1 should take the same amount of time as
the depth-first code, since they all basically have to read all of the
commits once). My guess is that there's some other speedup that has
happened in the years between ffc4b80 and now.

 t/perf/p7000-tag-contains.sh | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100755 t/perf/p7000-tag-contains.sh

diff --git a/t/perf/p7000-tag-contains.sh b/t/perf/p7000-tag-contains.sh
new file mode 100755
index 0000000..846f106
--- /dev/null
+++ b/t/perf/p7000-tag-contains.sh
@@ -0,0 +1,30 @@
+#!/bin/sh
+
+test_description='speed of tag --contains lookups'
+. ./perf-lib.sh
+
+test_perf_default_repo
+
+test_expect_success 'find reference points' '
+	recent=$(git rev-parse HEAD~100) &&
+	old=$(git rev-parse HEAD~5000) &&
+	ancient=$(git rev-list | tail -n 1)
+'
+
+test_expect_success 'find most recent tag' '
+	tag=$(git for-each-ref --sort=-taggerdate \
+			       --format="%(refname:short)" \
+			       refs/tags |
+	      head -n 1)
+'
+
+for distance in recent old ancient; do
+	contains=$(eval echo \$$distance)
+	for match in "" "$tag"; do
+		test_perf "contains $distance/${match:-all}" "
+			git tag -l --contains $contains $match
+		"
+	done
+done
+
+test_done
-- 
2.0.0.566.gfe3e6b2
