Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA838C433F5
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 10:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5C0E60ED8
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 10:57:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351205AbhIHK6g (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 06:58:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:41662 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351119AbhIHK6c (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 06:58:32 -0400
Received: (qmail 23203 invoked by uid 109); 8 Sep 2021 10:57:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 08 Sep 2021 10:57:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26088 invoked by uid 111); 8 Sep 2021 10:57:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 08 Sep 2021 06:57:21 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 8 Sep 2021 06:57:20 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Junio C Hamano <gitster@pobox.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH] Docs: web server must setenv GIT_PROTOCOL for v2
Message-ID: <YTiXEEEs36NCEr9S@coredump.intra.peff.net>
References: <20210904151721.445117-1-konstantin@linuxfoundation.org>
 <YTOW352xtsbvJcKy@coredump.intra.peff.net>
 <20210907211128.mauwgxupbredgx7w@meerkat.local>
 <YTiVDo4m5B5RcfCg@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YTiVDo4m5B5RcfCg@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 08, 2021 at 06:48:47AM -0400, Jeff King wrote:

> Both of the included examples here have been tested to work. The one for
> lighttpd is a little less direct than I'd like, but I couldn't find a
> way to directly set an environment variable to the value of a request
> header. From my reading of the documentation, lighttpd will set
> HTTP_GIT_PROTOCOL automatically, but git-http-backend looks only at
> GIT_PROTOCOL. Arguably http-backend should do this translation itself.

So having discovered this, I kind of wonder if these documentation
patches are barking up the wrong tree. There is no reason we would not
want v2 to work out of the box (after all, it does for git://).

The patch below does that (and could replace both my and Konstantin's
documentation patches).

This also makes me wonder if we should be documenting the use of
AcceptEnv for ssh (which sadly I don't think we can make work
out-of-the-box).

-- >8 --
Subject: [PATCH] http-backend: handle HTTP_GIT_PROTOCOL CGI variable

When a client requests the v2 protocol over HTTP, they set the
Git-Protocol header. Webservers will generaly make that available to our
CGI as HTTP_GIT_PROTOCOL in the environment. However, that's not
sufficient for upload-pack, etc, to respect it; they look in
GIT_PROTOCOL (without the HTTP_ prefix).

Either the webserver or the CGI is responsible for relaying that HTTP
header into the GIT_PROTOCOL variable. Traditionally, our tests have
configured the webserver to do so, but that's a burden on the server
admin. We can make this work out of the box by having the http-backend
CGI copy the contents.

Signed-off-by: Jeff King <peff@peff.net>
---
 http-backend.c          | 4 ++++
 t/lib-httpd/apache.conf | 2 --
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/http-backend.c b/http-backend.c
index b329bf63f0..2f4b4c11de 100644
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
+		setenv(GIT_PROTOCOL_ENVIRONMENT, proto_header, 1);
 
 	cmd->imp(&hdr, cmd_arg);
 	return 0;
diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index afa91e38b0..71761e3299 100644
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
2.33.0.621.ga797e945d8

