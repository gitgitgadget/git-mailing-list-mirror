Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0B021FC96
	for <e@80x24.org>; Thu,  1 Dec 2016 09:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758477AbcLAJEt (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 04:04:49 -0500
Received: from cloud.peff.net ([104.130.231.41]:49663 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757640AbcLAJEm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 04:04:42 -0500
Received: (qmail 4915 invoked by uid 109); 1 Dec 2016 09:03:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 01 Dec 2016 09:03:53 +0000
Received: (qmail 30679 invoked by uid 111); 1 Dec 2016 09:04:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 01 Dec 2016 04:04:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Dec 2016 04:03:52 -0500
Date:   Thu, 1 Dec 2016 04:03:52 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jann Horn <jannh@google.com>
Subject: [PATCH 1/6] http: simplify update_url_from_redirect
Message-ID: <20161201090351.4sy4nwxjhbyvacb6@sigill.intra.peff.net>
References: <20161201090336.xjbb47bublfcpglo@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161201090336.xjbb47bublfcpglo@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function looks for a common tail between what we asked
for and where we were redirected to, but it open-codes the
comparison. We can avoid some confusing subtractions by
using strip_suffix_mem().

Signed-off-by: Jeff King <peff@peff.net>
---
 http.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/http.c b/http.c
index 4c4a812fc..840dbd1c7 100644
--- a/http.c
+++ b/http.c
@@ -1664,7 +1664,7 @@ static int update_url_from_redirect(struct strbuf *base,
 				    const struct strbuf *got)
 {
 	const char *tail;
-	size_t tail_len;
+	size_t new_len;
 
 	if (!strcmp(asked, got->buf))
 		return 0;
@@ -1673,14 +1673,12 @@ static int update_url_from_redirect(struct strbuf *base,
 		die("BUG: update_url_from_redirect: %s is not a superset of %s",
 		    asked, base->buf);
 
-	tail_len = strlen(tail);
-
-	if (got->len < tail_len ||
-	    strcmp(tail, got->buf + got->len - tail_len))
+	new_len = got->len;
+	if (!strip_suffix_mem(got->buf, &new_len, tail))
 		return 0; /* insane redirect scheme */
 
 	strbuf_reset(base);
-	strbuf_add(base, got->buf, got->len - tail_len);
+	strbuf_add(base, got->buf, new_len);
 	return 1;
 }
 
-- 
2.11.0.319.g1f4e1e0

