Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48F2A20954
	for <e@80x24.org>; Mon,  4 Dec 2017 22:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752753AbdLDWHD (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 17:07:03 -0500
Received: from cloud.peff.net ([104.130.231.41]:47996 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752464AbdLDWHC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 17:07:02 -0500
Received: (qmail 11091 invoked by uid 109); 4 Dec 2017 22:07:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 04 Dec 2017 22:07:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27541 invoked by uid 111); 4 Dec 2017 22:07:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Mon, 04 Dec 2017 17:07:22 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 04 Dec 2017 17:07:00 -0500
Date:   Mon, 4 Dec 2017 17:07:00 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     lars.schneider@autodesk.com, git@vger.kernel.org,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH 2/2] progress: drop delay-threshold code
Message-ID: <20171204220700.GB18828@sigill.intra.peff.net>
References: <20171204220228.GA29422@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171204220228.GA29422@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Since 180a9f2268 (provide a facility for "delayed" progress
reporting, 2007-04-20), the progress code has allowed
callers to skip showing progress if they have reached a
percentage-threshold of the total work before the delay
period passes.

But since 8aade107dd (progress: simplify "delayed" progress
API, 2017-08-19), that parameter is not available to outside
callers (we always passed zero after that commit, though
that was corrected in the previous commit to "100%").

Let's drop the threshold code, which never triggers in
any meaningful way.

Signed-off-by: Jeff King <peff@peff.net>
---
I tweaked your patch slightly to clean up the now-simplified
conditional.

 progress.c | 24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/progress.c b/progress.c
index b774cb1cd1..5f87f4568f 100644
--- a/progress.c
+++ b/progress.c
@@ -34,7 +34,6 @@ struct progress {
 	unsigned total;
 	unsigned last_percent;
 	unsigned delay;
-	unsigned delayed_percent_threshold;
 	struct throughput *throughput;
 	uint64_t start_ns;
 };
@@ -83,20 +82,8 @@ static int display(struct progress *progress, unsigned n, const char *done)
 {
 	const char *eol, *tp;
 
-	if (progress->delay) {
-		if (!progress_update || --progress->delay)
-			return 0;
-		if (progress->total) {
-			unsigned percent = n * 100 / progress->total;
-			if (percent > progress->delayed_percent_threshold) {
-				/* inhibit this progress report entirely */
-				clear_progress_signal();
-				progress->delay = -1;
-				progress->total = 0;
-				return 0;
-			}
-		}
-	}
+	if (progress->delay && (!progress_update || --progress->delay))
+		return 0;
 
 	progress->last_value = n;
 	tp = (progress->throughput) ? progress->throughput->display.buf : "";
@@ -206,7 +193,7 @@ int display_progress(struct progress *progress, unsigned n)
 }
 
 static struct progress *start_progress_delay(const char *title, unsigned total,
-					     unsigned percent_threshold, unsigned delay)
+					     unsigned delay)
 {
 	struct progress *progress = malloc(sizeof(*progress));
 	if (!progress) {
@@ -219,7 +206,6 @@ static struct progress *start_progress_delay(const char *title, unsigned total,
 	progress->total = total;
 	progress->last_value = -1;
 	progress->last_percent = -1;
-	progress->delayed_percent_threshold = percent_threshold;
 	progress->delay = delay;
 	progress->throughput = NULL;
 	progress->start_ns = getnanotime();
@@ -229,12 +215,12 @@ static struct progress *start_progress_delay(const char *title, unsigned total,
 
 struct progress *start_delayed_progress(const char *title, unsigned total)
 {
-	return start_progress_delay(title, total, 100, 2);
+	return start_progress_delay(title, total, 2);
 }
 
 struct progress *start_progress(const char *title, unsigned total)
 {
-	return start_progress_delay(title, total, 0, 0);
+	return start_progress_delay(title, total, 0);
 }
 
 void stop_progress(struct progress **p_progress)
-- 
2.15.0.691.g622df76569
