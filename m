Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11ED91F954
	for <e@80x24.org>; Tue, 21 Aug 2018 19:06:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbeHUW2J (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Aug 2018 18:28:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:50750 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726627AbeHUW2J (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Aug 2018 18:28:09 -0400
Received: (qmail 6931 invoked by uid 109); 21 Aug 2018 19:06:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 21 Aug 2018 19:06:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26047 invoked by uid 111); 21 Aug 2018 19:06:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 21 Aug 2018 15:06:53 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Aug 2018 15:06:45 -0400
Date:   Tue, 21 Aug 2018 15:06:45 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 2/6] t/perf: factor out percent calculations
Message-ID: <20180821190645.GB30764@sigill.intra.peff.net>
References: <20180821184140.GA24165@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180821184140.GA24165@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This will let us reuse the code when we add new values to
aggregate besides times.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/perf/aggregate.perl | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/t/perf/aggregate.perl b/t/perf/aggregate.perl
index bc865160e7..3181b087ab 100755
--- a/t/perf/aggregate.perl
+++ b/t/perf/aggregate.perl
@@ -19,21 +19,24 @@ sub get_times {
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
2.19.0.rc0.398.g138a08f6f6

