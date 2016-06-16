Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.2 required=5.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C1BC1FE4E
	for <e@80x24.org>; Thu, 16 Jun 2016 09:33:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136AbcFPJdd (ORCPT <rfc822;e@80x24.org>);
	Thu, 16 Jun 2016 05:33:33 -0400
Received: from cloud.peff.net ([50.56.180.127]:55509 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750902AbcFPJdb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2016 05:33:31 -0400
Received: (qmail 9821 invoked by uid 102); 16 Jun 2016 09:33:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Jun 2016 05:33:31 -0400
Received: (qmail 14386 invoked by uid 107); 16 Jun 2016 09:33:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Jun 2016 05:33:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Jun 2016 05:33:29 -0400
Date:	Thu, 16 Jun 2016 05:33:29 -0400
From:	Jeff King <peff@peff.net>
To:	git@vger.kernel.org
Cc:	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/7] gpg-interface: use child_process.args
Message-ID: <20160616093328.GA15851@sigill.intra.peff.net>
References: <20160616093248.GA15130@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160616093248.GA15130@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Our argv allocations are relatively straightforward, but
this avoids us having to manually keep the count up to date
(or create new to-be-replaced slots in the declaration) when
we add new arguments.

Signed-off-by: Jeff King <peff@peff.net>
---
 gpg-interface.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index c4b1e8c..0ed9fa7 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -150,17 +150,15 @@ const char *get_signing_key(void)
 int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *signing_key)
 {
 	struct child_process gpg = CHILD_PROCESS_INIT;
-	const char *args[4];
 	ssize_t len;
 	size_t i, j, bottom;
 
-	gpg.argv = args;
 	gpg.in = -1;
 	gpg.out = -1;
-	args[0] = gpg_program;
-	args[1] = "-bsau";
-	args[2] = signing_key;
-	args[3] = NULL;
+	argv_array_pushl(&gpg.args,
+			 gpg_program,
+			 "-bsau", signing_key,
+			 NULL);
 
 	if (start_command(&gpg))
 		return error(_("could not run gpg."));
@@ -210,13 +208,11 @@ int verify_signed_buffer(const char *payload, size_t payload_size,
 			 struct strbuf *gpg_output, struct strbuf *gpg_status)
 {
 	struct child_process gpg = CHILD_PROCESS_INIT;
-	const char *args_gpg[] = {NULL, "--status-fd=1", "--verify", "FILE", "-", NULL};
 	char path[PATH_MAX];
 	int fd, ret;
 	struct strbuf buf = STRBUF_INIT;
 	struct strbuf *pbuf = &buf;
 
-	args_gpg[0] = gpg_program;
 	fd = git_mkstemp(path, PATH_MAX, ".git_vtag_tmpXXXXXX");
 	if (fd < 0)
 		return error_errno(_("could not create temporary file '%s'"), path);
@@ -224,12 +220,15 @@ int verify_signed_buffer(const char *payload, size_t payload_size,
 		return error_errno(_("failed writing detached signature to '%s'"), path);
 	close(fd);
 
-	gpg.argv = args_gpg;
+	argv_array_pushl(&gpg.args,
+			 gpg_program,
+			 "--status-fd=1",
+			 "--verify", path, "-",
+			 NULL);
 	gpg.in = -1;
 	gpg.out = -1;
 	if (gpg_output)
 		gpg.err = -1;
-	args_gpg[3] = path;
 	if (start_command(&gpg)) {
 		unlink(path);
 		return error(_("could not run gpg."));
-- 
2.9.0.160.g4984cba

