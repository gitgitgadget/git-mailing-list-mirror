Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A919B1F404
	for <e@80x24.org>; Tue, 28 Aug 2018 21:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbeH2BQf (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 21:16:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:59568 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726998AbeH2BQf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 21:16:35 -0400
Received: (qmail 29863 invoked by uid 109); 28 Aug 2018 21:23:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 28 Aug 2018 21:23:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5879 invoked by uid 111); 28 Aug 2018 21:23:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 28 Aug 2018 17:23:13 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Aug 2018 17:23:03 -0400
Date:   Tue, 28 Aug 2018 17:23:03 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v2 9/9] show_dirstat: simplify same-content check
Message-ID: <20180828212303.GI11036@sigill.intra.peff.net>
References: <20180828212126.GA7039@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180828212126.GA7039@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We use two nested conditionals to store a content_changed
variable, but only bother to look at the result once,
directly after we set it. We can drop the variable entirely
and just use a single "if".

This needless complexity is the result of 2ff3a80334 (Teach
--dirstat not to completely ignore rearranged lines within a
file, 2011-04-11). Before that, we held onto the
content_changed variable much longer.

While we're touching the condition, we can swap out oidcmp()
for !oideq(). Our coccinelle patches didn't previously find
this case because of the intermediate variable, but now it's
a simple boolean in a conditional.

Signed-off-by: Jeff King <peff@peff.net>
---
 diff.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/diff.c b/diff.c
index 5d3219b600..605ba4b6b8 100644
--- a/diff.c
+++ b/diff.c
@@ -2933,16 +2933,11 @@ static void show_dirstat(struct diff_options *options)
 		struct diff_filepair *p = q->queue[i];
 		const char *name;
 		unsigned long copied, added, damage;
-		int content_changed;
 
 		name = p->two->path ? p->two->path : p->one->path;
 
-		if (p->one->oid_valid && p->two->oid_valid)
-			content_changed = oidcmp(&p->one->oid, &p->two->oid);
-		else
-			content_changed = 1;
-
-		if (!content_changed) {
+		if (p->one->oid_valid && p->two->oid_valid &&
+		    oideq(&p->one->oid, &p->two->oid)) {
 			/*
 			 * The SHA1 has not changed, so pre-/post-content is
 			 * identical. We can therefore skip looking at the
@@ -2989,7 +2984,7 @@ static void show_dirstat(struct diff_options *options)
 		 * made to the preimage.
 		 * If the resulting damage is zero, we know that
 		 * diffcore_count_changes() considers the two entries to
-		 * be identical, but since content_changed is true, we
+		 * be identical, but since the oid changed, we
 		 * know that there must have been _some_ kind of change,
 		 * so we force all entries to have damage > 0.
 		 */
-- 
2.19.0.rc0.584.g84d5b2a847
