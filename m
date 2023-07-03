Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF33EB64DC
	for <git@archiver.kernel.org>; Mon,  3 Jul 2023 06:33:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjGCGde (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jul 2023 02:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjGCGdc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jul 2023 02:33:32 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8CABA
        for <git@vger.kernel.org>; Sun,  2 Jul 2023 23:33:31 -0700 (PDT)
Received: (qmail 12891 invoked by uid 109); 3 Jul 2023 06:33:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 03 Jul 2023 06:33:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2537 invoked by uid 111); 3 Jul 2023 06:33:34 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 03 Jul 2023 02:33:34 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 3 Jul 2023 02:33:30 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 1/3] imap-send: use server conf argument in setup_curl()
Message-ID: <20230703063330.GA3524421@coredump.intra.peff.net>
References: <20230703063247.GA3524302@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230703063247.GA3524302@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Our caller passes in an imap_server_conf struct, but we ignore it
totally, and instead read the config directly from the global "server"
variable. This works OK, since our sole caller will pass in that same
global variable. But the intent seems to have been to use the passed-in
variable, as otherwise it has no purpose (and many other functions use
the same pattern).

Let's use the passed-in value, which also silences a -Wunused-parameter
warning.

It would be nice if "server" was not a global here, as we could avoid
making similar mistakes. But changing that would be a larger refactor,
as it must be accessed as a global in a few spots (e.g., filling it in
with the config callback).

Signed-off-by: Jeff King <peff@peff.net>
---
 imap-send.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 7f5426177a..0afd88de44 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1415,42 +1415,42 @@ static CURL *setup_curl(struct imap_server_conf *srvc, struct credential *cred)
 	if (!curl)
 		die("curl_easy_init failed");
 
-	server_fill_credential(&server, cred);
-	curl_easy_setopt(curl, CURLOPT_USERNAME, server.user);
-	curl_easy_setopt(curl, CURLOPT_PASSWORD, server.pass);
+	server_fill_credential(srvc, cred);
+	curl_easy_setopt(curl, CURLOPT_USERNAME, srvc->user);
+	curl_easy_setopt(curl, CURLOPT_PASSWORD, srvc->pass);
 
-	strbuf_addstr(&path, server.use_ssl ? "imaps://" : "imap://");
-	strbuf_addstr(&path, server.host);
+	strbuf_addstr(&path, srvc->use_ssl ? "imaps://" : "imap://");
+	strbuf_addstr(&path, srvc->host);
 	if (!path.len || path.buf[path.len - 1] != '/')
 		strbuf_addch(&path, '/');
 
-	uri_encoded_folder = curl_easy_escape(curl, server.folder, 0);
+	uri_encoded_folder = curl_easy_escape(curl, srvc->folder, 0);
 	if (!uri_encoded_folder)
 		die("failed to encode server folder");
 	strbuf_addstr(&path, uri_encoded_folder);
 	curl_free(uri_encoded_folder);
 
 	curl_easy_setopt(curl, CURLOPT_URL, path.buf);
 	strbuf_release(&path);
-	curl_easy_setopt(curl, CURLOPT_PORT, server.port);
+	curl_easy_setopt(curl, CURLOPT_PORT, srvc->port);
 
-	if (server.auth_method) {
+	if (srvc->auth_method) {
 #ifndef GIT_CURL_HAVE_CURLOPT_LOGIN_OPTIONS
 		warning("No LOGIN_OPTIONS support in this cURL version");
 #else
 		struct strbuf auth = STRBUF_INIT;
 		strbuf_addstr(&auth, "AUTH=");
-		strbuf_addstr(&auth, server.auth_method);
+		strbuf_addstr(&auth, srvc->auth_method);
 		curl_easy_setopt(curl, CURLOPT_LOGIN_OPTIONS, auth.buf);
 		strbuf_release(&auth);
 #endif
 	}
 
-	if (!server.use_ssl)
+	if (!srvc->use_ssl)
 		curl_easy_setopt(curl, CURLOPT_USE_SSL, (long)CURLUSESSL_TRY);
 
-	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYPEER, server.ssl_verify);
-	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYHOST, server.ssl_verify);
+	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYPEER, srvc->ssl_verify);
+	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYHOST, srvc->ssl_verify);
 
 	curl_easy_setopt(curl, CURLOPT_READFUNCTION, fread_buffer);
 
-- 
2.41.0.586.g3c0cc15bc7

