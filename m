Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37EDB202B1
	for <e@80x24.org>; Fri,  7 Jul 2017 08:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752447AbdGGIlw (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jul 2017 04:41:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:33404 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751981AbdGGIlv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2017 04:41:51 -0400
Received: (qmail 7348 invoked by uid 109); 7 Jul 2017 08:41:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 07 Jul 2017 08:41:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20540 invoked by uid 111); 7 Jul 2017 08:42:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 07 Jul 2017 04:42:01 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 07 Jul 2017 04:41:49 -0400
Date:   Fri, 7 Jul 2017 04:41:49 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Kyle Meyer <kyle@kyleam.com>,
        git@vger.kernel.org, Sahil Dua <sahildua2305@gmail.com>,
        Eric Wong <e@80x24.org>
Subject: [PATCH v2 3/4] reflog-walk: don't free reflogs added to cache
Message-ID: <20170707084148.albskufmqkeyfedn@sigill.intra.peff.net>
References: <20170707083636.kjsr5ry3237paeiv@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170707083636.kjsr5ry3237paeiv@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The add_reflog_for_walk() function keeps a cache mapping
refnames to their reflog contents. We use a cached reflog
entry if available, and otherwise allocate and store a new
one.

Since 5026b47175 (add_reflog_for_walk: avoid memory leak,
2017-05-04), when we hit an error parsing a date-based
reflog spec, we free the reflog memory but leave the cache
entry pointing to the now-freed memory.

We can fix this by just leaving the memory intact once it
has made it into the cache. This may leave an unused entry
in the cache, but that's OK. And it means we also catch a
similar situation: we may not have allocated at all in this
invocation, but simply be pointing to a cached entry from a
previous invocation (which is relying on that entry being
present).

The new test in t1411 exercises this case and fails when run
with --valgrind or ASan.

Signed-off-by: Jeff King <peff@peff.net>
---
 reflog-walk.c          | 4 ----
 t/t1411-reflog-show.sh | 4 ++++
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/reflog-walk.c b/reflog-walk.c
index aec718beba..2a43537326 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -215,10 +215,6 @@ int add_reflog_for_walk(struct reflog_walk_info *info,
 	if (recno < 0) {
 		commit_reflog->recno = get_reflog_recno_by_time(reflogs, timestamp);
 		if (commit_reflog->recno < 0) {
-			if (reflogs) {
-				free(reflogs->ref);
-				free(reflogs);
-			}
 			free(commit_reflog);
 			return -1;
 		}
diff --git a/t/t1411-reflog-show.sh b/t/t1411-reflog-show.sh
index ae96eeb66a..b9cb76654b 100755
--- a/t/t1411-reflog-show.sh
+++ b/t/t1411-reflog-show.sh
@@ -177,4 +177,8 @@ test_expect_success 'showing multiple reflogs works' '
 	git log -g HEAD HEAD >actual
 '
 
+test_expect_success 'showing multiple reflogs with an old date' '
+	git log -g HEAD@{1979-01-01} HEAD >actual
+'
+
 test_done
-- 
2.13.2.1000.g8590c1af5d

