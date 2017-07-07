Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0CAC202AC
	for <e@80x24.org>; Fri,  7 Jul 2017 08:43:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752122AbdGGInT (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jul 2017 04:43:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:33424 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751707AbdGGInT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2017 04:43:19 -0400
Received: (qmail 7437 invoked by uid 109); 7 Jul 2017 08:43:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 07 Jul 2017 08:43:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20561 invoked by uid 111); 7 Jul 2017 08:43:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 07 Jul 2017 04:43:29 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 07 Jul 2017 04:43:16 -0400
Date:   Fri, 7 Jul 2017 04:43:16 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Kyle Meyer <kyle@kyleam.com>,
        git@vger.kernel.org, Sahil Dua <sahildua2305@gmail.com>,
        Eric Wong <e@80x24.org>
Subject: [PATCH v2 4/4] reflog-walk: include all fields when freeing
 complete_reflogs
Message-ID: <20170707084316.jetdonpj75ricara@sigill.intra.peff.net>
References: <20170707083636.kjsr5ry3237paeiv@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170707083636.kjsr5ry3237paeiv@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we encounter an error adding reflogs for a walk, we try
to free any logs we have read. But we didn't free all
fields, meaning that we could in theory leak all of the
"items" array (which would consitute the bulk of the
allocated memory).

This patch adds a helper which frees all of the entries and
uses it as appropriate.

As it turns out, the leak seems impossible to trigger with
the current code. Of the three error paths that free the
complete_reflogs struct, two only kick in when the items
array is empty, and the third was removed entirely in the
previous commit.

So this patch should be a noop in terms of behavior, but it
fixes a potential maintenance headache should anybody add a
new error path and copy the partial-free code. Which is
what happened in 5026b47175 (add_reflog_for_walk: avoid
memory leak, 2017-05-04), though its leaky call was the
third one that was recently removed.

Signed-off-by: Jeff King <peff@peff.net>
---
 reflog-walk.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/reflog-walk.c b/reflog-walk.c
index 2a43537326..ba72020fc3 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -38,6 +38,22 @@ static int read_one_reflog(struct object_id *ooid, struct object_id *noid,
 	return 0;
 }
 
+static void free_complete_reflog(struct complete_reflogs *array)
+{
+	int i;
+
+	if (!array)
+		return;
+
+	for (i = 0; i < array->nr; i++) {
+		free(array->items[i].email);
+		free(array->items[i].message);
+	}
+	free(array->items);
+	free(array->ref);
+	free(array);
+}
+
 static struct complete_reflogs *read_complete_reflog(const char *ref)
 {
 	struct complete_reflogs *reflogs =
@@ -189,20 +205,14 @@ int add_reflog_for_walk(struct reflog_walk_info *info,
 			if (ret > 1)
 				free(b);
 			else if (ret == 1) {
-				if (reflogs) {
-					free(reflogs->ref);
-					free(reflogs);
-				}
+				free_complete_reflog(reflogs);
 				free(branch);
 				branch = b;
 				reflogs = read_complete_reflog(branch);
 			}
 		}
 		if (!reflogs || reflogs->nr == 0) {
-			if (reflogs) {
-				free(reflogs->ref);
-				free(reflogs);
-			}
+			free_complete_reflog(reflogs);
 			free(branch);
 			return -1;
 		}
-- 
2.13.2.1000.g8590c1af5d
