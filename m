From: Jeff King <peff@peff.net>
Subject: [PATCH v2 1/2] t/perf: time rev-list with UNINTERESTING commits
Date: Mon, 20 Jan 2014 21:25:12 -0500
Message-ID: <20140121022511.GA4672@sigill.intra.peff.net>
References: <20140121022431.GA4614@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 21 03:25:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5R1i-00085R-Vh
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jan 2014 03:25:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753519AbaAUCZP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jan 2014 21:25:15 -0500
Received: from cloud.peff.net ([50.56.180.127]:35987 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752329AbaAUCZO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jan 2014 21:25:14 -0500
Received: (qmail 30077 invoked by uid 102); 21 Jan 2014 02:25:14 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 20 Jan 2014 20:25:14 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Jan 2014 21:25:12 -0500
Content-Disposition: inline
In-Reply-To: <20140121022431.GA4614@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240740>

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
 t/perf/p0001-rev-list.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/t/perf/p0001-rev-list.sh b/t/perf/p0001-rev-list.sh
index 4f71a63..16359d5 100755
--- a/t/perf/p0001-rev-list.sh
+++ b/t/perf/p0001-rev-list.sh
@@ -14,4 +14,16 @@ test_perf 'rev-list --all --objects' '
 	git rev-list --all --objects >/dev/null
 '
 
+test_expect_success 'create new unreferenced commit' '
+	commit=$(git commit-tree HEAD^{tree} -p HEAD)
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
