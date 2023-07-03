Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A52F0EB64DC
	for <git@archiver.kernel.org>; Mon,  3 Jul 2023 06:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjGCGeF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jul 2023 02:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjGCGeE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jul 2023 02:34:04 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A429BA
        for <git@vger.kernel.org>; Sun,  2 Jul 2023 23:34:03 -0700 (PDT)
Received: (qmail 12949 invoked by uid 109); 3 Jul 2023 06:34:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 03 Jul 2023 06:34:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2543 invoked by uid 111); 3 Jul 2023 06:34:06 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 03 Jul 2023 02:34:06 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 3 Jul 2023 02:34:02 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 2/3] imap-send: drop unused parameter from imap_cmd_cb
 callback
Message-ID: <20230703063402.GB3524421@coredump.intra.peff.net>
References: <20230703063247.GA3524302@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230703063247.GA3524302@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's a generic callback mechanism for handling plus-continuation of
IMAP commands. It takes the imap_cmd struct itself as an argument. That
seems reasonable, and in a larger imap-using program it might be used.
But in imap-send, we have only one such callback (auth_cram_md5) and it
doesn't use this value, triggering -Wunused-parameter warnings.

We could just mark the parameter as UNUSED. But since this is the only
such function, and because we are not likely to share code with the
upstream isync anymore, we can just simplify the interface to remove
this parameter.

Signed-off-by: Jeff King <peff@peff.net>
---
 imap-send.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 0afd88de44..81a87f434b 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -137,7 +137,7 @@ struct imap_store {
 };
 
 struct imap_cmd_cb {
-	int (*cont)(struct imap_store *ctx, struct imap_cmd *cmd, const char *prompt);
+	int (*cont)(struct imap_store *ctx, const char *prompt);
 	void (*done)(struct imap_store *ctx, struct imap_cmd *cmd, int response);
 	void *ctx;
 	char *data;
@@ -786,7 +786,7 @@ static int get_cmd_result(struct imap_store *ctx, struct imap_cmd *tcmd)
 				if (n != (int)cmdp->cb.dlen)
 					return RESP_BAD;
 			} else if (cmdp->cb.cont) {
-				if (cmdp->cb.cont(ctx, cmdp, cmd))
+				if (cmdp->cb.cont(ctx, cmd))
 					return RESP_BAD;
 			} else {
 				fprintf(stderr, "IMAP error: unexpected command continuation request\n");
@@ -917,7 +917,7 @@ static char *cram(const char *challenge_64, const char *user, const char *pass)
 
 #endif
 
-static int auth_cram_md5(struct imap_store *ctx, struct imap_cmd *cmd, const char *prompt)
+static int auth_cram_md5(struct imap_store *ctx, const char *prompt)
 {
 	int ret;
 	char *response;
-- 
2.41.0.586.g3c0cc15bc7

