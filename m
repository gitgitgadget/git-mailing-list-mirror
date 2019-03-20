Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9237E20248
	for <e@80x24.org>; Wed, 20 Mar 2019 08:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbfCTIOD (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 04:14:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:57410 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727528AbfCTIOD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 04:14:03 -0400
Received: (qmail 19601 invoked by uid 109); 20 Mar 2019 08:14:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 20 Mar 2019 08:14:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6283 invoked by uid 111); 20 Mar 2019 08:14:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 20 Mar 2019 04:14:24 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Mar 2019 04:14:01 -0400
Date:   Wed, 20 Mar 2019 04:14:01 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 03/13] log: drop unused "len" from show_tagger()
Message-ID: <20190320081400.GC10403@sigill.intra.peff.net>
References: <20190320081258.GA5621@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190320081258.GA5621@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We pass the length of the found "tagger" line to show_tagger(), but it
does not use it; instead, it passes the string to pp_user_info(), which
reads until newline or NUL. This is OK for our purposes because we
always read the object contents into a buffer with an extra NUL (and
indeed, our sole caller already relies on this by using starts_with).

Let's drop the ignored parameter. And while we're touching the caller,
let's use skip_prefix() to avoid a magic number.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/log.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 6595471ddf..35314d12ec 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -490,7 +490,7 @@ int cmd_whatchanged(int argc, const char **argv, const char *prefix)
 	return cmd_log_walk(&rev);
 }
 
-static void show_tagger(char *buf, int len, struct rev_info *rev)
+static void show_tagger(const char *buf, struct rev_info *rev)
 {
 	struct strbuf out = STRBUF_INIT;
 	struct pretty_print_context pp = {0};
@@ -546,11 +546,11 @@ static int show_tag_object(const struct object_id *oid, struct rev_info *rev)
 	assert(type == OBJ_TAG);
 	while (offset < size && buf[offset] != '\n') {
 		int new_offset = offset + 1;
+		const char *ident;
 		while (new_offset < size && buf[new_offset++] != '\n')
 			; /* do nothing */
-		if (starts_with(buf + offset, "tagger "))
-			show_tagger(buf + offset + 7,
-				    new_offset - offset - 7, rev);
+		if (skip_prefix(buf + offset, "tagger ", &ident))
+			show_tagger(ident, rev);
 		offset = new_offset;
 	}
 
-- 
2.21.0.701.g4401309e11

