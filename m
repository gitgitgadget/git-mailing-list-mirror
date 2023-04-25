Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33EC4C6FD18
	for <git@archiver.kernel.org>; Tue, 25 Apr 2023 05:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233152AbjDYFzX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Apr 2023 01:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbjDYFzW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2023 01:55:22 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129CF9028
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 22:55:20 -0700 (PDT)
Received: (qmail 21819 invoked by uid 109); 25 Apr 2023 05:55:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 25 Apr 2023 05:55:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 933 invoked by uid 111); 25 Apr 2023 05:55:20 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 25 Apr 2023 01:55:20 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 25 Apr 2023 01:55:19 -0400
From:   Jeff King <peff@peff.net>
To:     Thomas Bock <bockthom@cs.uni-saarland.de>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: [PATCH v2 4/4] parse_commit(): describe more date-parsing failure
 modes
Message-ID: <20230425055519.GD4015649@coredump.intra.peff.net>
References: <20230425055244.GA4014505@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230425055244.GA4014505@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The previous few commits improved the parsing of dates in malformed
commit objects. But there's one big case left implicit: we may still
feed garbage to parse_timestamp(). This is preferable to trying to be
more strict, but let's document the thinking in a comment.

Signed-off-by: Jeff King <peff@peff.net>
---
Obviously not strictly necessary, but it felt like this was worth
pointing out, and it felt weird to shove it into patch 3.

 commit.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/commit.c b/commit.c
index 2f1b5d505b..2ac141e198 100644
--- a/commit.c
+++ b/commit.c
@@ -136,6 +136,16 @@ static timestamp_t parse_commit_date(const char *buf, const char *tail)
 	/*
 	 * We know there is at least one non-whitespace character, so we'll
 	 * begin parsing there and stop at worst case at eol.
+	 *
+	 * Note that we may feed parse_timestamp() non-digit garbage here if
+	 * the commit is malformed. If we see a totally unexpected token like
+	 * "foo" here, it will return 0, which is our error/sentinel value
+	 * anyway. For something like "123foo456", it will parse as far as it
+	 * can. That might be questionable (versus returning "0"), but it would
+	 * help in a hypothetical case like "123456+0100", where the whitespace
+	 * from the timezone is missing. Since such syntactic errors may be
+	 * baked into history and hard to correct now, let's err on trying to
+	 * make our best guess here, rather than insist on perfect syntax.
 	 */
 	return parse_timestamp(dateptr, NULL, 10);
 }
-- 
2.40.0.653.g15ca972062
