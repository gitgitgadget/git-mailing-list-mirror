Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F11EB64DC
	for <git@archiver.kernel.org>; Mon,  3 Jul 2023 06:34:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjGCGed (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jul 2023 02:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbjGCGeb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jul 2023 02:34:31 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1E8C6
        for <git@vger.kernel.org>; Sun,  2 Jul 2023 23:34:29 -0700 (PDT)
Received: (qmail 12998 invoked by uid 109); 3 Jul 2023 06:34:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 03 Jul 2023 06:34:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2546 invoked by uid 111); 3 Jul 2023 06:34:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 03 Jul 2023 02:34:32 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 3 Jul 2023 02:34:28 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 3/3] imap-send: drop unused fields from imap_cmd_cb
Message-ID: <20230703063428.GC3524421@coredump.intra.peff.net>
References: <20230703063247.GA3524302@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230703063247.GA3524302@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The imap_cmd_cb struct has several fields which are totally unused.
Presumably they did useful things in the upstream isync code from which
this is derived, but they don't in our more limited program. This is
particularly confusing for the "done" callback, which (as of the
previous patch) no longer matches the signature of the adjacent "cont"
callback.

Since we're unlikely to share code with isync going forward, we should
feel free to simplify the code here. Note that "done" is examined but
never set, so we can also drop a little bit of code outside of the
struct definition.

Signed-off-by: Jeff King <peff@peff.net>
---
 imap-send.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 81a87f434b..c1952d99e8 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -138,11 +138,9 @@ struct imap_store {
 
 struct imap_cmd_cb {
 	int (*cont)(struct imap_store *ctx, const char *prompt);
-	void (*done)(struct imap_store *ctx, struct imap_cmd *cmd, int response);
 	void *ctx;
 	char *data;
 	int dlen;
-	int uid;
 };
 
 struct imap_cmd {
@@ -828,8 +826,6 @@ static int get_cmd_result(struct imap_store *ctx, struct imap_cmd *tcmd)
 			}
 			if ((resp2 = parse_response_code(ctx, &cmdp->cb, cmd)) > resp)
 				resp = resp2;
-			if (cmdp->cb.done)
-				cmdp->cb.done(ctx, cmdp, resp);
 			free(cmdp->cb.data);
 			free(cmdp->cmd);
 			free(cmdp);
-- 
2.41.0.586.g3c0cc15bc7
