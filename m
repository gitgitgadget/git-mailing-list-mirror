Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA14C433F5
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 14:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6D3E61026
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 14:05:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233775AbhIJOG7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 10:06:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:43862 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233593AbhIJOG5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 10:06:57 -0400
Received: (qmail 5773 invoked by uid 109); 10 Sep 2021 14:05:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 Sep 2021 14:05:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25318 invoked by uid 111); 10 Sep 2021 14:05:46 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Sep 2021 10:05:46 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 10 Sep 2021 10:05:45 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: [PATCH 2/5] http-backend: handle HTTP_GIT_PROTOCOL CGI variable
Message-ID: <YTtmOfCzvxYrBxso@coredump.intra.peff.net>
References: <YTtleYs48A1NpUpp@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YTtleYs48A1NpUpp@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a client requests the v2 protocol over HTTP, they set the
Git-Protocol header. Webservers will generally make that available to
our CGI as HTTP_GIT_PROTOCOL in the environment. However, that's not
sufficient for upload-pack, etc, to respect it; they look in
GIT_PROTOCOL (without the HTTP_ prefix).

Either the webserver or the CGI is responsible for relaying that HTTP
header into the GIT_PROTOCOL variable. Traditionally, our tests have
configured the webserver to do so, but that's a burden on the server
admin. We can make this work out of the box by having the http-backend
CGI copy the contents of HTTP_GIT_PROTOCOL to GIT_PROTOCOL.

There are no new tests here. By removing the SetEnvIf line from our
test Apache config, we're now relying on this behavior of http-backend
to trigger the v2 protocol there (and there are numerous tests that fail
if this doesn't work).

There is one subtlety here: we copy HTTP_GIT_PROTOCOL only if there is
no existing GIT_PROTOCOL variable. That leaves the webserver admin free
to override the client's decision if they choose. This is unlikely to be
useful in practice, but is more flexible. And indeed, it allows the
v2-to-v0 fallback test added in the previous commit to continue working.

Signed-off-by: Jeff King <peff@peff.net>
---
 http-backend.c          | 4 ++++
 t/lib-httpd/apache.conf | 2 --
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/http-backend.c b/http-backend.c
index b329bf63f0..92ceb31f9a 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -739,6 +739,7 @@ static int bad_request(struct strbuf *hdr, const struct service_cmd *c)
 int cmd_main(int argc, const char **argv)
 {
 	char *method = getenv("REQUEST_METHOD");
+	const char *proto_header;
 	char *dir;
 	struct service_cmd *cmd = NULL;
 	char *cmd_arg = NULL;
@@ -789,6 +790,9 @@ int cmd_main(int argc, const char **argv)
 	http_config();
 	max_request_buffer = git_env_ulong("GIT_HTTP_MAX_REQUEST_BUFFER",
 					   max_request_buffer);
+	proto_header = getenv("HTTP_GIT_PROTOCOL");
+	if (proto_header)
+		setenv(GIT_PROTOCOL_ENVIRONMENT, proto_header, 0);
 
 	cmd->imp(&hdr, cmd_arg);
 	return 0;
diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index 1321357d8b..180a41fe96 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -81,8 +81,6 @@ PassEnv GIT_TRACE
 PassEnv GIT_CONFIG_NOSYSTEM
 PassEnv GIT_TEST_SIDEBAND_ALL
 
-SetEnvIf Git-Protocol ".*" GIT_PROTOCOL=$0
-
 Alias /dumb/ www/
 Alias /auth/dumb/ www/auth/dumb/
 
-- 
2.33.0.731.g24eb83922d

