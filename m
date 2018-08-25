Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0203A1F404
	for <e@80x24.org>; Sat, 25 Aug 2018 08:15:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbeHYLxh (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Aug 2018 07:53:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:55774 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726412AbeHYLxh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Aug 2018 07:53:37 -0400
Received: (qmail 5561 invoked by uid 109); 25 Aug 2018 08:15:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 25 Aug 2018 08:15:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2510 invoked by uid 111); 25 Aug 2018 08:15:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 25 Aug 2018 04:15:34 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 25 Aug 2018 04:15:25 -0400
Date:   Sat, 25 Aug 2018 04:15:25 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH 8/9] read-cache: use oideq() in ce_compare functions
Message-ID: <20180825081525.GH737@sigill.intra.peff.net>
References: <20180825080031.GA32139@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180825080031.GA32139@sigill.intra.peff.net>
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
2.19.0.rc0.412.g7005db4e88

