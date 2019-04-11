Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E68220248
	for <e@80x24.org>; Thu, 11 Apr 2019 13:50:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbfDKNt7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Apr 2019 09:49:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:54930 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726106AbfDKNt7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Apr 2019 09:49:59 -0400
Received: (qmail 7172 invoked by uid 109); 11 Apr 2019 13:49:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 11 Apr 2019 13:49:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27942 invoked by uid 111); 11 Apr 2019 13:50:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 11 Apr 2019 09:50:28 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Apr 2019 09:49:57 -0400
Date:   Thu, 11 Apr 2019 09:49:57 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?546L5YGl5by6?= <jianqiang.wang@securitygossip.com>
Subject: [PATCH 4/4] progress: use xmalloc/xcalloc
Message-ID: <20190411134957.GD9182@sigill.intra.peff.net>
References: <20190411134736.GA28543@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190411134736.GA28543@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since the early days of Git, the progress code allocates its struct with
a bare malloc(), not xmalloc(). If the allocation fails, we just avoid
showing progress at all.

While perhaps a noble goal not to fail the whole operation because of
optional progress, in practice:

  1. Any failure to allocate a few dozen bytes here means critical path
     allocations are likely to fail, too.

  2. These days we use a strbuf for throughput progress (and there's a
     patch under discussion to do the same for non-throughput cases,
     too). And that uses xmalloc() under the hood, which means we'd
     still die on some allocation failures.

Let's switch to xmalloc(). That makes us consistent with the rest of Git
and makes it easier to audit for other (less careful) bare mallocs.

Signed-off-by: Jeff King <peff@peff.net>
---
This one is obviously less urgent than the others in that it doesn't
trigger a segfault. So this is purely cleanup.

 progress.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/progress.c b/progress.c
index 5a99c9fbf0..699ac33c4f 100644
--- a/progress.c
+++ b/progress.c
@@ -139,12 +139,10 @@ void display_throughput(struct progress *progress, uint64_t total)
 	now_ns = getnanotime();
 
 	if (!tp) {
-		progress->throughput = tp = calloc(1, sizeof(*tp));
-		if (tp) {
-			tp->prev_total = tp->curr_total = total;
-			tp->prev_ns = now_ns;
-			strbuf_init(&tp->display, 0);
-		}
+		progress->throughput = tp = xcalloc(1, sizeof(*tp));
+		tp->prev_total = tp->curr_total = total;
+		tp->prev_ns = now_ns;
+		strbuf_init(&tp->display, 0);
 		return;
 	}
 	tp->curr_total = total;
@@ -196,13 +194,7 @@ int display_progress(struct progress *progress, uint64_t n)
 static struct progress *start_progress_delay(const char *title, uint64_t total,
 					     unsigned delay)
 {
-	struct progress *progress = malloc(sizeof(*progress));
-	if (!progress) {
-		/* unlikely, but here's a good fallback */
-		fprintf(stderr, "%s...\n", title);
-		fflush(stderr);
-		return NULL;
-	}
+	struct progress *progress = xmalloc(sizeof(*progress));
 	progress->title = title;
 	progress->total = total;
 	progress->last_value = -1;
-- 
2.21.0.922.g1a559e573c
