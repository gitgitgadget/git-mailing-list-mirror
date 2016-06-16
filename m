Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.2 required=5.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B37C51FE4E
	for <e@80x24.org>; Thu, 16 Jun 2016 09:34:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752568AbcFPJeL (ORCPT <rfc822;e@80x24.org>);
	Thu, 16 Jun 2016 05:34:11 -0400
Received: from cloud.peff.net ([50.56.180.127]:55514 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750902AbcFPJeK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2016 05:34:10 -0400
Received: (qmail 9881 invoked by uid 102); 16 Jun 2016 09:34:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Jun 2016 05:34:09 -0400
Received: (qmail 14406 invoked by uid 107); 16 Jun 2016 09:34:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Jun 2016 05:34:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Jun 2016 05:34:07 -0400
Date:	Thu, 16 Jun 2016 05:34:07 -0400
From:	Jeff King <peff@peff.net>
To:	git@vger.kernel.org
Cc:	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/7] verify_signed_buffer: drop pbuf variable
Message-ID: <20160616093406.GB15851@sigill.intra.peff.net>
References: <20160616093248.GA15130@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160616093248.GA15130@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

If our caller gave us a non-NULL gpg_status parameter, we
write the gpg status into their strbuf. If they didn't, then
we write it to a temporary local strbuf (since we still need
to look at it).  The variable "pbuf" adds an extra layer of
indirection so that the rest of the function can just access
whichever is appropriate.

However, the name "pbuf" isn't very descriptive, and it's
easy to get confused about what is supposed to be in it
(especially because we are reading both "status" and
"output" from gpg).

Rather than give it a more descriptive name, we can just use
gpg_status as our indirection pointer. Either it points to
the caller's input, or we can point it directly to our
temporary buffer.

Signed-off-by: Jeff King <peff@peff.net>
---
 gpg-interface.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index 0ed9fa7..216cad8 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -211,7 +211,6 @@ int verify_signed_buffer(const char *payload, size_t payload_size,
 	char path[PATH_MAX];
 	int fd, ret;
 	struct strbuf buf = STRBUF_INIT;
-	struct strbuf *pbuf = &buf;
 
 	fd = git_mkstemp(path, PATH_MAX, ".git_vtag_tmpXXXXXX");
 	if (fd < 0)
@@ -242,9 +241,9 @@ int verify_signed_buffer(const char *payload, size_t payload_size,
 		strbuf_read(gpg_output, gpg.err, 0);
 		close(gpg.err);
 	}
-	if (gpg_status)
-		pbuf = gpg_status;
-	strbuf_read(pbuf, gpg.out, 0);
+	if (!gpg_status)
+		gpg_status = &buf;
+	strbuf_read(gpg_status, gpg.out, 0);
 	close(gpg.out);
 
 	ret = finish_command(&gpg);
@@ -252,7 +251,7 @@ int verify_signed_buffer(const char *payload, size_t payload_size,
 
 	unlink_or_warn(path);
 
-	ret |= !strstr(pbuf->buf, "\n[GNUPG:] GOODSIG ");
+	ret |= !strstr(gpg_status->buf, "\n[GNUPG:] GOODSIG ");
 	strbuf_release(&buf); /* no matter it was used or not */
 
 	return ret;
-- 
2.9.0.160.g4984cba

