Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A35EE6459
	for <git@archiver.kernel.org>; Fri, 15 Sep 2023 11:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234347AbjIOLeu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Sep 2023 07:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234237AbjIOLet (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2023 07:34:49 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2001AD
        for <git@vger.kernel.org>; Fri, 15 Sep 2023 04:34:44 -0700 (PDT)
Received: (qmail 10770 invoked by uid 109); 15 Sep 2023 11:34:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 15 Sep 2023 11:34:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1530 invoked by uid 111); 15 Sep 2023 11:34:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 15 Sep 2023 07:34:43 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 15 Sep 2023 07:34:43 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 2/2] http: update curl http/2 info matching for curl 8.3.0
Message-ID: <20230915113443.GB3531587@coredump.intra.peff.net>
References: <20230915113237.GA3531328@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230915113237.GA3531328@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To redact header lines in http/2 curl traces, we have to parse past some
prefix bytes that curl sticks in the info lines it passes to us. That
changed once already, and we adapted in db30130165 (http: handle both
"h2" and "h2h3" in curl info lines, 2023-06-17).

Now it has changed again, in curl's fbacb14c4 (http2: cleanup trace
messages, 2023-08-04), which was released in curl 8.3.0. Running a build
of git linked against that version will fail to redact the trace (and as
before, t5559 notices and complains).

The format here is a little more complicated than the other ones, as it
now includes a "stream id". This is not constant but is always numeric,
so we can easily parse past it.

We'll continue to match the old versions, of course, since we want to
work with many different versions of curl. We can't even select one
format at compile time, because the behavior depends on the runtime
version of curl we use, not the version we build against.

Signed-off-by: Jeff King <peff@peff.net>
---
 http.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/http.c b/http.c
index c93e0a7ea6..8f71bf00d8 100644
--- a/http.c
+++ b/http.c
@@ -740,6 +740,8 @@ static int redact_sensitive_header(struct strbuf *header, size_t offset)
 
 static int match_curl_h2_trace(const char *line, const char **out)
 {
+	const char *p;
+
 	/*
 	 * curl prior to 8.1.0 gives us:
 	 *
@@ -751,6 +753,18 @@ static int match_curl_h2_trace(const char *line, const char **out)
 	    skip_iprefix(line, "h2 [", out))
 		return 1;
 
+	/*
+	 * curl 8.3.0 uses:
+	 *   [HTTP/2] [<stream-id>] [<header-name>: <header-val>]
+	 * where <stream-id> is numeric.
+	 */
+	if (skip_iprefix(line, "[HTTP/2] [", &p)) {
+		while (isdigit(*p))
+			p++;
+		if (skip_prefix(p, "] [", out))
+			return 1;
+	}
+
 	return 0;
 }
 
-- 
2.42.0.661.g2507eb519e
