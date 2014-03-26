From: Jeff King <peff@peff.net>
Subject: [PATCH 2/6] t/perf/aggregate: factor our percent calculations
Date: Wed, 26 Mar 2014 03:22:37 -0400
Message-ID: <20140326072237.GB32193@sigill.intra.peff.net>
References: <20140326072215.GA31739@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ben Maurer <bmaurer@fb.com>, Siddharth Agarwal <sid0@fb.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 26 08:22:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSiAf-0005E2-GW
	for gcvg-git-2@plane.gmane.org; Wed, 26 Mar 2014 08:22:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752780AbaCZHWk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2014 03:22:40 -0400
Received: from cloud.peff.net ([50.56.180.127]:47385 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751394AbaCZHWj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2014 03:22:39 -0400
Received: (qmail 14482 invoked by uid 102); 26 Mar 2014 07:22:39 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 26 Mar 2014 02:22:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Mar 2014 03:22:37 -0400
Content-Disposition: inline
In-Reply-To: <20140326072215.GA31739@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245163>

This will let us reuse the code when we add new values to
aggregate besides times.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/perf/aggregate.perl | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/t/perf/aggregate.perl b/t/perf/aggregate.perl
index 15f7fc1..690cd8c 100755
--- a/t/perf/aggregate.perl
+++ b/t/perf/aggregate.perl
@@ -16,21 +16,24 @@ sub get_times {
 	return ($rt, $4, $5);
 }
 
+sub relative_change {
+	my ($r, $firstr) = @_;
+	if ($firstr > 0) {
+		return sprintf "%+.1f%%", 100.0*($r-$firstr)/$firstr;
+	} elsif ($r == 0) {
+		return "=";
+	} else {
+		return "+inf";
+	}
+}
+
 sub format_times {
 	my ($r, $u, $s, $firstr) = @_;
 	if (!defined $r) {
 		return "<missing>";
 	}
 	my $out = sprintf "%.2f(%.2f+%.2f)", $r, $u, $s;
-	if (defined $firstr) {
-		if ($firstr > 0) {
-			$out .= sprintf " %+.1f%%", 100.0*($r-$firstr)/$firstr;
-		} elsif ($r == 0) {
-			$out .= " =";
-		} else {
-			$out .= " +inf";
-		}
-	}
+	$out .= ' ' . relative_change($r, $firstr) if defined $firstr;
 	return $out;
 }
 
-- 
1.9.1.601.g7ec968e
