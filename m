Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3CA3EE6457
	for <git@archiver.kernel.org>; Fri, 15 Sep 2023 11:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234404AbjIOLdY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Sep 2023 07:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234354AbjIOLdX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2023 07:33:23 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DAECC1
        for <git@vger.kernel.org>; Fri, 15 Sep 2023 04:33:17 -0700 (PDT)
Received: (qmail 10761 invoked by uid 109); 15 Sep 2023 11:33:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 15 Sep 2023 11:33:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1518 invoked by uid 111); 15 Sep 2023 11:33:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 15 Sep 2023 07:33:16 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 15 Sep 2023 07:33:16 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 1/2] http: factor out matching of curl http/2 trace lines
Message-ID: <20230915113316.GA3531587@coredump.intra.peff.net>
References: <20230915113237.GA3531328@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230915113237.GA3531328@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have to parse out curl's http/2 trace lines so we can redact their
headers. We already match two different types of lines from various
vintages of curl. In preparation for adding another (which will be
slightly more complex), let's pull the matching into its own function,
rather than doing it in the middle of a conditional.

While we're doing so, let's expand the comment a bit to describe the two
matches. That probably should have been part of db30130165 (http: handle
both "h2" and "h2h3" in curl info lines, 2023-06-17), but will become
even more important as we add new types.

Signed-off-by: Jeff King <peff@peff.net>
---
 http.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/http.c b/http.c
index e138b4b96f..c93e0a7ea6 100644
--- a/http.c
+++ b/http.c
@@ -738,18 +738,29 @@ static int redact_sensitive_header(struct strbuf *header, size_t offset)
 	return ret;
 }
 
+static int match_curl_h2_trace(const char *line, const char **out)
+{
+	/*
+	 * curl prior to 8.1.0 gives us:
+	 *
+	 *     h2h3 [<header-name>: <header-val>]
+	 *
+	 * Starting in 8.1.0, the first token became just "h2".
+	 */
+	if (skip_iprefix(line, "h2h3 [", out) ||
+	    skip_iprefix(line, "h2 [", out))
+		return 1;
+
+	return 0;
+}
+
 /* Redact headers in info */
 static void redact_sensitive_info_header(struct strbuf *header)
 {
 	const char *sensitive_header;
 
-	/*
-	 * curl's h2h3 prints headers in info, e.g.:
-	 *   h2h3 [<header-name>: <header-val>]
-	 */
 	if (trace_curl_redact &&
-	    (skip_iprefix(header->buf, "h2h3 [", &sensitive_header) ||
-	     skip_iprefix(header->buf, "h2 [", &sensitive_header))) {
+	    match_curl_h2_trace(header->buf, &sensitive_header)) {
 		if (redact_sensitive_header(header, sensitive_header - header->buf)) {
 			/* redaction ate our closing bracket */
 			strbuf_addch(header, ']');
-- 
2.42.0.661.g2507eb519e

