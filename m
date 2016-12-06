Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF5071FC96
	for <e@80x24.org>; Tue,  6 Dec 2016 18:25:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751965AbcLFSZd (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 13:25:33 -0500
Received: from cloud.peff.net ([104.130.231.41]:52585 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751388AbcLFSZa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 13:25:30 -0500
Received: (qmail 4593 invoked by uid 109); 6 Dec 2016 18:24:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 06 Dec 2016 18:24:30 +0000
Received: (qmail 15689 invoked by uid 111); 6 Dec 2016 18:25:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 06 Dec 2016 13:25:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Dec 2016 13:24:29 -0500
Date:   Tue, 6 Dec 2016 13:24:29 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        sbeller@google.com, bburky@bburky.com, jrnieder@gmail.com
Subject: [PATCH v2 1/6] http: simplify update_url_from_redirect
Message-ID: <20161206182429.6jp23tltvlznrh2p@sigill.intra.peff.net>
References: <20161206182414.466uotqfufcimpqb@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161206182414.466uotqfufcimpqb@sigill.intra.peff.net>
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
index d8e427b69..d4034a14b 100644
--- a/http.c
+++ b/http.c
@@ -1500,7 +1500,7 @@ static int update_url_from_redirect(struct strbuf *base,
 				    const struct strbuf *got)
 {
 	const char *tail;
-	size_t tail_len;
+	size_t new_len;
 
 	if (!strcmp(asked, got->buf))
 		return 0;
@@ -1509,14 +1509,12 @@ static int update_url_from_redirect(struct strbuf *base,
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
2.11.0.191.gdb26c57

