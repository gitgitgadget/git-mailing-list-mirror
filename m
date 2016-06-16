Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.2 required=5.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E5BD1FE4E
	for <e@80x24.org>; Thu, 16 Jun 2016 09:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752666AbcFPJjf (ORCPT <rfc822;e@80x24.org>);
	Thu, 16 Jun 2016 05:39:35 -0400
Received: from cloud.peff.net ([50.56.180.127]:55533 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752217AbcFPJje (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2016 05:39:34 -0400
Received: (qmail 10126 invoked by uid 102); 16 Jun 2016 09:39:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Jun 2016 05:39:34 -0400
Received: (qmail 14489 invoked by uid 107); 16 Jun 2016 09:39:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Jun 2016 05:39:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Jun 2016 05:39:31 -0400
Date:	Thu, 16 Jun 2016 05:39:31 -0400
From:	Jeff King <peff@peff.net>
To:	git@vger.kernel.org
Cc:	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 6/7] sign_buffer: use pipe_command
Message-ID: <20160616093931.GF15851@sigill.intra.peff.net>
References: <20160616093248.GA15130@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160616093248.GA15130@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Similar to the prior commit for verify_signed_buffer, the
motivation here is both to make the code simpler, and to
avoid any possible deadlocks with gpg.

In this case we have the same "write to stdin, then read
from stdout" that the verify case had. This is unlikely to
be a problem in practice, since stdout has the detached
signature, which it cannot compute until it has read all of
stdin (if it were a non-detached signature, that would be a
problem, though).

We don't read from stderr at all currently. However, we will
want to in a future patch, so this also prepares us there
(and in that case gpg _does_ write before reading all of the
input, though again, it is unlikely that a key uid will fill
up a pipe buffer).

Signed-off-by: Jeff King <peff@peff.net>
---
 gpg-interface.c | 24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index c98035d..74f08a2 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -151,40 +151,26 @@ const char *get_signing_key(void)
 int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *signing_key)
 {
 	struct child_process gpg = CHILD_PROCESS_INIT;
-	ssize_t len;
+	int ret;
 	size_t i, j, bottom;
 
-	gpg.in = -1;
-	gpg.out = -1;
 	argv_array_pushl(&gpg.args,
 			 gpg_program,
 			 "-bsau", signing_key,
 			 NULL);
 
-	if (start_command(&gpg))
-		return error(_("could not run gpg."));
+	bottom = signature->len;
 
 	/*
 	 * When the username signingkey is bad, program could be terminated
 	 * because gpg exits without reading and then write gets SIGPIPE.
 	 */
 	sigchain_push(SIGPIPE, SIG_IGN);
-
-	if (write_in_full(gpg.in, buffer->buf, buffer->len) != buffer->len) {
-		close(gpg.in);
-		close(gpg.out);
-		finish_command(&gpg);
-		return error(_("gpg did not accept the data"));
-	}
-	close(gpg.in);
-
-	bottom = signature->len;
-	len = strbuf_read(signature, gpg.out, 1024);
-	close(gpg.out);
-
+	ret = pipe_command(&gpg, buffer->buf, buffer->len,
+			   signature, 1024, NULL, 0);
 	sigchain_pop(SIGPIPE);
 
-	if (finish_command(&gpg) || !len || len < 0)
+	if (ret || signature->len == bottom)
 		return error(_("gpg failed to sign the data"));
 
 	/* Strip CR from the line endings, in case we are on Windows. */
-- 
2.9.0.160.g4984cba

