Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D5551FEAA
	for <e@80x24.org>; Fri, 17 Jun 2016 23:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753071AbcFQXiq (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 19:38:46 -0400
Received: from cloud.peff.net ([50.56.180.127]:56467 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751087AbcFQXip (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2016 19:38:45 -0400
Received: (qmail 8202 invoked by uid 102); 17 Jun 2016 23:38:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Jun 2016 19:38:45 -0400
Received: (qmail 30290 invoked by uid 107); 17 Jun 2016 23:38:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Jun 2016 19:38:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Jun 2016 19:38:43 -0400
Date:	Fri, 17 Jun 2016 19:38:43 -0400
From:	Jeff King <peff@peff.net>
To:	git@vger.kernel.org
Cc:	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 3/7] verify_signed_buffer: use tempfile object
Message-ID: <20160617233843.GC31958@sigill.intra.peff.net>
References: <20160617233819.GA31909@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160617233819.GA31909@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

We use git_mkstemp to create a temporary file, and try to
clean it up in all exit paths from the function. But that
misses any cases where we die by signal, or by calling die()
in a sub-function. In addition, we missed one of the exit
paths.

Let's convert to using a tempfile object, which handles the
hard cases for us, and add the missing cleanup call. Note
that we would not simply want to rely on program exit to
catch our missed cleanup, as this function may be called
many times in a single program (for the same reason, we use
a static tempfile instead of heap-allocating a new one; that
gives an upper bound on our memory usage).

Signed-off-by: Jeff King <peff@peff.net>
---
 gpg-interface.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index 216cad8..854c1e5 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -3,6 +3,7 @@
 #include "strbuf.h"
 #include "gpg-interface.h"
 #include "sigchain.h"
+#include "tempfile.h"
 
 static char *configured_signing_key;
 static const char *gpg_program = "gpg";
@@ -208,28 +209,32 @@ int verify_signed_buffer(const char *payload, size_t payload_size,
 			 struct strbuf *gpg_output, struct strbuf *gpg_status)
 {
 	struct child_process gpg = CHILD_PROCESS_INIT;
-	char path[PATH_MAX];
+	static struct tempfile temp;
 	int fd, ret;
 	struct strbuf buf = STRBUF_INIT;
 
-	fd = git_mkstemp(path, PATH_MAX, ".git_vtag_tmpXXXXXX");
+	fd = mks_tempfile_t(&temp, ".git_vtag_tmpXXXXXX");
 	if (fd < 0)
-		return error_errno(_("could not create temporary file '%s'"), path);
-	if (write_in_full(fd, signature, signature_size) < 0)
-		return error_errno(_("failed writing detached signature to '%s'"), path);
+		return error_errno(_("could not create temporary file"));
+	if (write_in_full(fd, signature, signature_size) < 0) {
+		error_errno(_("failed writing detached signature to '%s'"),
+			    temp.filename.buf);
+		delete_tempfile(&temp);
+		return -1;
+	}
 	close(fd);
 
 	argv_array_pushl(&gpg.args,
 			 gpg_program,
 			 "--status-fd=1",
-			 "--verify", path, "-",
+			 "--verify", temp.filename.buf, "-",
 			 NULL);
 	gpg.in = -1;
 	gpg.out = -1;
 	if (gpg_output)
 		gpg.err = -1;
 	if (start_command(&gpg)) {
-		unlink(path);
+		delete_tempfile(&temp);
 		return error(_("could not run gpg."));
 	}
 
@@ -249,7 +254,7 @@ int verify_signed_buffer(const char *payload, size_t payload_size,
 	ret = finish_command(&gpg);
 	sigchain_pop(SIGPIPE);
 
-	unlink_or_warn(path);
+	delete_tempfile(&temp);
 
 	ret |= !strstr(gpg_status->buf, "\n[GNUPG:] GOODSIG ");
 	strbuf_release(&buf); /* no matter it was used or not */
-- 
2.9.0.165.g4aacdc3

