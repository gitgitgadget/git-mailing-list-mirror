Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF45C77B73
	for <git@archiver.kernel.org>; Thu, 27 Apr 2023 08:17:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242989AbjD0IRa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Apr 2023 04:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243023AbjD0IR1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2023 04:17:27 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00BC544A2
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 01:17:25 -0700 (PDT)
Received: (qmail 20729 invoked by uid 109); 27 Apr 2023 08:17:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 27 Apr 2023 08:17:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17305 invoked by uid 111); 27 Apr 2023 08:17:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 27 Apr 2023 04:17:25 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 27 Apr 2023 04:17:24 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Thomas Bock <bockthom@cs.uni-saarland.de>,
        Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v3 4/4] parse_commit(): describe more date-parsing failure
 modes
Message-ID: <20230427081724.GB1478467@coredump.intra.peff.net>
References: <20230427081330.GA1461786@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230427081330.GA1461786@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The previous few commits improved the parsing of dates in malformed
commit objects. But there's one big case left implicit: we may still
feed garbage to parse_timestamp(). This is preferable to trying to be
more strict, but let's document the thinking in a comment.

Signed-off-by: Jeff King <peff@peff.net>
---
 commit.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/commit.c b/commit.c
index 8dfe92cf37..e2e4fd2db9 100644
--- a/commit.c
+++ b/commit.c
@@ -148,6 +148,15 @@ static timestamp_t parse_commit_date(const char *buf, const char *tail)
 	/*
 	 * We know there is at least one digit (or dash), so we'll begin
 	 * parsing there and stop at worst case at eol.
+	 *
+	 * Note that we may feed parse_timestamp() extra characters here if the
+	 * commit is malformed, and it will parse as far as it can. For
+	 * example, "123foo456" would return "123". That might be questionable
+	 * (versus returning "0"), but it would help in a hypothetical case
+	 * like "123456+0100", where the whitespace from the timezone is
+	 * missing. Since such syntactic errors may be baked into history and
+	 * hard to correct now, let's err on trying to make our best guess
+	 * here, rather than insist on perfect syntax.
 	 */
 	return parse_timestamp(dateptr, NULL, 10);
 }
-- 
2.40.1.663.g410c33770c.dirty
