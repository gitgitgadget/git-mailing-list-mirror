From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] t/perf: time rev-list with UNINTERESTING commits
Date: Mon, 20 Jan 2014 16:31:01 -0500
Message-ID: <20140120213101.GA16095@sigill.intra.peff.net>
References: <20140120212845.GA11451@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 20 22:31:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5MR3-0004rt-90
	for gcvg-git-2@plane.gmane.org; Mon, 20 Jan 2014 22:31:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751669AbaATVbF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jan 2014 16:31:05 -0500
Received: from cloud.peff.net ([50.56.180.127]:35847 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750743AbaATVbD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jan 2014 16:31:03 -0500
Received: (qmail 14407 invoked by uid 102); 20 Jan 2014 21:31:03 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 20 Jan 2014 15:31:03 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Jan 2014 16:31:01 -0500
Content-Disposition: inline
In-Reply-To: <20140120212845.GA11451@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240727>

We time a straight "rev-list --all" and its "--object"
counterpart, both going all the way to the root. However, we
do not time a partial history walk. This patch adds an
extreme case: a walk over a very small slice of history, but
with a very large set of UNINTERESTING tips. This is similar
to the connectivity check run by git on a small fetch, or
the walk done by any pre-receive hooks that want to check
incoming commits.

This test reveals a performance regression in git v1.8.4.2,
caused by fbd4a70 (list-objects: mark more commits as edges
in mark_edges_uninteresting, 2013-08-16):

Test                                             fbd4a703^         fbd4a703
------------------------------------------------------------------------------------------
0001.1: rev-list --all                           0.69(0.67+0.02)   0.69(0.68+0.01) +0.0%
0001.2: rev-list --all --objects                 3.47(3.44+0.02)   3.48(3.44+0.03) +0.3%
0001.4: rev-list $commit --not --all             0.04(0.04+0.00)   0.04(0.04+0.00) +0.0%
0001.5: rev-list --objects $commit --not --all   0.04(0.03+0.00)   0.27(0.24+0.02) +575.0%

Signed-off-by: Jeff King <peff@peff.net>
---
Sorry for the long lines in the commit message. I'm open to suggestions
on reformatting.

 t/perf/p0001-rev-list.sh | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/t/perf/p0001-rev-list.sh b/t/perf/p0001-rev-list.sh
index 4f71a63..b7258a7 100755
--- a/t/perf/p0001-rev-list.sh
+++ b/t/perf/p0001-rev-list.sh
@@ -14,4 +14,21 @@ test_perf 'rev-list --all --objects' '
 	git rev-list --all --objects >/dev/null
 '
 
+test_expect_success 'create new unreferenced commit' '
+	git checkout --detach HEAD &&
+	echo content >>file &&
+	git add file &&
+	git commit -m detached &&
+	commit=$(git rev-parse --verify HEAD) &&
+	git checkout -
+'
+
+test_perf 'rev-list $commit --not --all' '
+	git rev-list $commit --not --all >/dev/null
+'
+
+test_perf 'rev-list --objects $commit --not --all' '
+	git rev-list --objects $commit --not --all >/dev/null
+'
+
 test_done
-- 
1.8.5.2.500.g8060133
