Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76830C433FE
	for <git@archiver.kernel.org>; Tue, 18 Oct 2022 01:01:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbiJRBBW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 21:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbiJRBBT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 21:01:19 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9A8A44B
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 18:01:18 -0700 (PDT)
Received: (qmail 28717 invoked by uid 109); 18 Oct 2022 01:01:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 Oct 2022 01:01:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13365 invoked by uid 111); 18 Oct 2022 01:01:19 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 17 Oct 2022 21:01:19 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 17 Oct 2022 21:01:17 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 01/12] diffstat_consume(): assert non-zero length
Message-ID: <Y0363eQnvcNkCG/O@coredump.intra.peff.net>
References: <Y036whEorZV0rOgB@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y036whEorZV0rOgB@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The callback interface for xdiff_emit_line_fn gives us a line/len pair,
but diffstat_consume() never looks at "len". At first glance this seems
like a bug that could cause us to read further than xdiff intends. But
in practice, we read only the first character, and xdiff would never
pass us an empty line.

Let's add a run-time assertion that this is true, which clarifies our
assumption and silences -Wunused-parameter.

Signed-off-by: Jeff King <peff@peff.net>
---
 diff.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/diff.c b/diff.c
index 648f6717a5..bba888a34a 100644
--- a/diff.c
+++ b/diff.c
@@ -2488,6 +2488,9 @@ static int diffstat_consume(void *priv, char *line, unsigned long len)
 	struct diffstat_t *diffstat = priv;
 	struct diffstat_file *x = diffstat->files[diffstat->nr - 1];
 
+	if (!len)
+		BUG("xdiff fed us an empty line");
+
 	if (line[0] == '+')
 		x->added++;
 	else if (line[0] == '-')
-- 
2.38.0.371.g300879f34e

