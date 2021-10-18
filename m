Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA744C433EF
	for <git@archiver.kernel.org>; Mon, 18 Oct 2021 17:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADA1261212
	for <git@archiver.kernel.org>; Mon, 18 Oct 2021 17:15:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233895AbhJRRRN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Oct 2021 13:17:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:41016 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233886AbhJRRRM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Oct 2021 13:17:12 -0400
Received: (qmail 2871 invoked by uid 109); 18 Oct 2021 17:15:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 18 Oct 2021 17:15:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32556 invoked by uid 111); 18 Oct 2021 17:15:00 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 18 Oct 2021 13:15:00 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 18 Oct 2021 13:15:00 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Fabian Stelzer <fs@gigacodes.de>
Subject: [PATCH 1/2] gpg-interface: fix leak of "line" in parse_ssh_output()
Message-ID: <YW2rlCAtRumXzVfX@coredump.intra.peff.net>
References: <YW2qpuosxr9PNwVa@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YW2qpuosxr9PNwVa@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We xmemdupz() this buffer, but never free it. Let's do so. We'll use a
cleanup label, since there are multiple exits from the function.

Note that it was also declared a "const char *". We could switch that to
"char *" to indicate that it's allocated, but that make it awkward to
use with skip_prefix(). So instead, we'll introduce an extra non-const
pointer.

Signed-off-by: Jeff King <peff@peff.net>
---
 gpg-interface.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index 433482307c..c60b9cd19d 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -365,6 +365,7 @@ static int verify_gpg_signed_buffer(struct signature_check *sigc,
 static void parse_ssh_output(struct signature_check *sigc)
 {
 	const char *line, *principal, *search;
+	char *to_free;
 	char *key = NULL;
 
 	/*
@@ -383,7 +384,7 @@ static void parse_ssh_output(struct signature_check *sigc)
 	sigc->result = 'B';
 	sigc->trust_level = TRUST_NEVER;
 
-	line = xmemdupz(sigc->output, strcspn(sigc->output, "\n"));
+	line = to_free = xmemdupz(sigc->output, strcspn(sigc->output, "\n"));
 
 	if (skip_prefix(line, "Good \"git\" signature for ", &line)) {
 		/* Valid signature and known principal */
@@ -403,7 +404,7 @@ static void parse_ssh_output(struct signature_check *sigc)
 		sigc->result = 'G';
 		sigc->trust_level = TRUST_UNDEFINED;
 	} else {
-		return;
+		goto cleanup;
 	}
 
 	key = strstr(line, "key");
@@ -417,6 +418,9 @@ static void parse_ssh_output(struct signature_check *sigc)
 		 */
 		sigc->result = 'B';
 	}
+
+cleanup:
+	free(to_free);
 }
 
 static int verify_ssh_signed_buffer(struct signature_check *sigc,
-- 
2.33.1.1223.g80c1dbe6e5

