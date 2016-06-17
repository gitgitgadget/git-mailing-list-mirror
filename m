Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 922761FEAA
	for <e@80x24.org>; Fri, 17 Jun 2016 23:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752865AbcFQXim (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 19:38:42 -0400
Received: from cloud.peff.net ([50.56.180.127]:56460 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751087AbcFQXil (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2016 19:38:41 -0400
Received: (qmail 8184 invoked by uid 102); 17 Jun 2016 23:38:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Jun 2016 19:38:41 -0400
Received: (qmail 30269 invoked by uid 107); 17 Jun 2016 23:38:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Jun 2016 19:38:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Jun 2016 19:38:39 -0400
Date:	Fri, 17 Jun 2016 19:38:39 -0400
From:	Jeff King <peff@peff.net>
To:	git@vger.kernel.org
Cc:	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 2/7] verify_signed_buffer: drop pbuf variable
Message-ID: <20160617233839.GB31958@sigill.intra.peff.net>
References: <20160617233819.GA31909@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160617233819.GA31909@sigill.intra.peff.net>
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
2.9.0.165.g4aacdc3

