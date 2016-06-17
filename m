Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11D761FEAA
	for <e@80x24.org>; Fri, 17 Jun 2016 23:39:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753452AbcFQXi6 (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 19:38:58 -0400
Received: from cloud.peff.net ([50.56.180.127]:56488 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753158AbcFQXi6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2016 19:38:58 -0400
Received: (qmail 8256 invoked by uid 102); 17 Jun 2016 23:38:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Jun 2016 19:38:57 -0400
Received: (qmail 30351 invoked by uid 107); 17 Jun 2016 23:39:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Jun 2016 19:39:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Jun 2016 19:38:55 -0400
Date:	Fri, 17 Jun 2016 19:38:55 -0400
From:	Jeff King <peff@peff.net>
To:	git@vger.kernel.org
Cc:	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 6/7] sign_buffer: use pipe_command
Message-ID: <20160617233855.GF31958@sigill.intra.peff.net>
References: <20160617233819.GA31909@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160617233819.GA31909@sigill.intra.peff.net>
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
2.9.0.165.g4aacdc3

