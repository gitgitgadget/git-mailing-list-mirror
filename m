Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.2 required=5.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA6911FE4E
	for <e@80x24.org>; Thu, 16 Jun 2016 09:38:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752644AbcFPJi4 (ORCPT <rfc822;e@80x24.org>);
	Thu, 16 Jun 2016 05:38:56 -0400
Received: from cloud.peff.net ([50.56.180.127]:55528 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751530AbcFPJiz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2016 05:38:55 -0400
Received: (qmail 10114 invoked by uid 102); 16 Jun 2016 09:38:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Jun 2016 05:38:55 -0400
Received: (qmail 14470 invoked by uid 107); 16 Jun 2016 09:39:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Jun 2016 05:39:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Jun 2016 05:38:52 -0400
Date:	Thu, 16 Jun 2016 05:38:52 -0400
From:	Jeff King <peff@peff.net>
To:	git@vger.kernel.org
Cc:	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/7] verify_signed_buffer: use pipe_command
Message-ID: <20160616093852.GE15851@sigill.intra.peff.net>
References: <20160616093248.GA15130@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160616093248.GA15130@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This is shorter and should make the function easier to
follow. But more importantly, it removes the possibility of
any deadlocks based on reading or writing to gpg.

It's not clear if such a deadlock is possible in practice.

We do write the whole payload before reading anything, so we
could deadlock there. However, in practice gpg will need to
read our whole input to verify the signature, so it will
drain our payload first. It could write an error to stderr
before reading, but it's unlikely that such an error
wouldn't be followed by it immediately exiting, or that the
error would actually be larger than a pipe buffer.

On the writing side, we drain stderr (with the
human-readable output) in its entirety before reading stdout
(with the status-fd data). Running strace on "gpg --verify"
does show interleaved output on the two descriptors:

  write(2, "gpg: ", 5)                    = 5
  write(2, "Signature made Thu 16 Jun 2016 0"..., 73) = 73
  write(1, "[GNUPG:] SIG_ID tQw8KGcs9rBfLvAj"..., 66) = 66
  write(1, "[GNUPG:] GOODSIG 69808639F9430ED"..., 60) = 60
  write(2, "gpg: ", 5)                    = 5
  write(2, "Good signature from \"Jeff King <"..., 47) = 47
  write(2, "\n", 1)                       = 1
  write(2, "gpg: ", 5)                    = 5
  write(2, "                aka \"Jeff King <"..., 49) = 49
  write(2, "\n", 1)                       = 1
  write(1, "[GNUPG:] VALIDSIG C49CE24156AF08"..., 135) = 135
  write(1, "[GNUPG:] TRUST_ULTIMATE\n", 24) = 24

The second line written to stdout there contains the
signer's UID, which can be arbitrarily long. If it fills the
pipe buffer, then gpg would block writing to its stdout,
while we are blocked trying to read its stderr.

In practice, GPG seems to limit UIDs to 2048 bytes, so
unless your pipe buffer size is quite small, or unless gpg
does not enforce the limit under some conditions, this seems
unlikely in practice.

Still, it is not hard for us to be cautious and just use
pipe_command.

Signed-off-by: Jeff King <peff@peff.net>
---
 gpg-interface.c | 22 +++-------------------
 1 file changed, 3 insertions(+), 19 deletions(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index 854c1e5..c98035d 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -229,29 +229,13 @@ int verify_signed_buffer(const char *payload, size_t payload_size,
 			 "--status-fd=1",
 			 "--verify", temp.filename.buf, "-",
 			 NULL);
-	gpg.in = -1;
-	gpg.out = -1;
-	if (gpg_output)
-		gpg.err = -1;
-	if (start_command(&gpg)) {
-		delete_tempfile(&temp);
-		return error(_("could not run gpg."));
-	}
 
-	sigchain_push(SIGPIPE, SIG_IGN);
-	write_in_full(gpg.in, payload, payload_size);
-	close(gpg.in);
-
-	if (gpg_output) {
-		strbuf_read(gpg_output, gpg.err, 0);
-		close(gpg.err);
-	}
 	if (!gpg_status)
 		gpg_status = &buf;
-	strbuf_read(gpg_status, gpg.out, 0);
-	close(gpg.out);
 
-	ret = finish_command(&gpg);
+	sigchain_push(SIGPIPE, SIG_IGN);
+	ret = pipe_command(&gpg, payload, payload_size,
+			   gpg_status, 0, gpg_output, 0);
 	sigchain_pop(SIGPIPE);
 
 	delete_tempfile(&temp);
-- 
2.9.0.160.g4984cba

