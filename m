Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBA5B1F404
	for <e@80x24.org>; Tue, 28 Aug 2018 21:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbeH2BQb (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 21:16:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:59560 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726998AbeH2BQb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 21:16:31 -0400
Received: (qmail 29849 invoked by uid 109); 28 Aug 2018 21:23:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 28 Aug 2018 21:23:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5873 invoked by uid 111); 28 Aug 2018 21:23:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 28 Aug 2018 17:23:09 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Aug 2018 17:22:59 -0400
Date:   Tue, 28 Aug 2018 17:22:59 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v2 8/9] read-cache: use oideq() in ce_compare functions
Message-ID: <20180828212259.GH11036@sigill.intra.peff.net>
References: <20180828212126.GA7039@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180828212126.GA7039@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These functions return the full oidcmp() value, but the
callers really only care whether it is non-zero. We can use
the more strict !oideq(), which a compiler may be able to
optimize further.

This does change the meaning of the return value subtly, but
it's unlikely that anybody would try to use them for
ordering. They're static-local in this file, and they
already return other error values that would confuse an
ordering (e.g., open() failure gives -1).

Signed-off-by: Jeff King <peff@peff.net>
---
 read-cache.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 421a7f4953..eb7cea6272 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -213,7 +213,7 @@ static int ce_compare_data(const struct cache_entry *ce, struct stat *st)
 	if (fd >= 0) {
 		struct object_id oid;
 		if (!index_fd(&oid, fd, st, OBJ_BLOB, ce->name, 0))
-			match = oidcmp(&oid, &ce->oid);
+			match = !oideq(&oid, &ce->oid);
 		/* index_fd() closed the file descriptor already */
 	}
 	return match;
@@ -254,7 +254,7 @@ static int ce_compare_gitlink(const struct cache_entry *ce)
 	 */
 	if (resolve_gitlink_ref(ce->name, "HEAD", &oid) < 0)
 		return 0;
-	return oidcmp(&oid, &ce->oid);
+	return !oideq(&oid, &ce->oid);
 }
 
 static int ce_modified_check_fs(const struct cache_entry *ce, struct stat *st)
-- 
2.19.0.rc0.584.g84d5b2a847

