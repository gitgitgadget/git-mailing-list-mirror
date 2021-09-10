Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F27BCC433EF
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 14:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFCBD6108B
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 14:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233827AbhIJOK1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 10:10:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:43872 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233784AbhIJOKZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 10:10:25 -0400
Received: (qmail 5793 invoked by uid 109); 10 Sep 2021 14:09:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 Sep 2021 14:09:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25350 invoked by uid 111); 10 Sep 2021 14:09:14 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Sep 2021 10:09:14 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 10 Sep 2021 10:09:13 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: [PATCH 3/5] docs/http-backend: mention v2 protocol
Message-ID: <YTtnCfE48oW1qs9J@coredump.intra.peff.net>
References: <YTtleYs48A1NpUpp@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YTtleYs48A1NpUpp@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Historically there was a little bit of configuration needed at the
webserver level in order to get the client's v2 protocol probes to Git.
But when we introduced the v2 protocol, we never documented these.

As of the previous commit, this should mostly work out of the box
without any explicit configuration. But it's worth documenting this to
make it clear how we expect it to work, especially in the face of
webservers which don't provide all headers over the CGI interface. Or
anybody who runs across this documentation but has an older version of
Git (or _used_ to have an older version, and wonders why they still have
a SetEnvIf line in their Apache config and whether it's still
necessary).

Signed-off-by: Jeff King <peff@peff.net>
---
I used the vague "older versions of Git" here, which might not be as
helpful as we could be.  But it seemed presumptuous to say "before
2.34", since we don't know the fate of the topic, nor even that we for
sure will call the next version 2.34.

I guess we could swap out "older versions" for "before 2.34" later,
after the topic graduates and the release gets closer, but it does seem
like something that we'd easily forget to do. I dunno.

 Documentation/git-http-backend.txt | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-http-backend.txt b/Documentation/git-http-backend.txt
index 558966aa83..0c5c0dde19 100644
--- a/Documentation/git-http-backend.txt
+++ b/Documentation/git-http-backend.txt
@@ -16,7 +16,9 @@ A simple CGI program to serve the contents of a Git repository to Git
 clients accessing the repository over http:// and https:// protocols.
 The program supports clients fetching using both the smart HTTP protocol
 and the backwards-compatible dumb HTTP protocol, as well as clients
-pushing using the smart HTTP protocol.
+pushing using the smart HTTP protocol. It also supports Git's
+more-efficient "v2" protocol if properly configured; see the
+discussion of `GIT_PROTOCOL` in the ENVIRONMENT section below.
 
 It verifies that the directory has the magic file
 "git-daemon-export-ok", and it will refuse to export any Git directory
@@ -77,6 +79,18 @@ Apache 2.x::
 SetEnv GIT_PROJECT_ROOT /var/www/git
 SetEnv GIT_HTTP_EXPORT_ALL
 ScriptAlias /git/ /usr/libexec/git-core/git-http-backend/
+
+# This is not strictly necessary using Apache and a modern version of
+# git-http-backend, as the webserver will pass along the header in the
+# environment as HTTP_GIT_PROTOCOL, and http-backend will copy that into
+# GIT_PROTOCOL. But you may need this line (or something similar if you
+# are using a different webserver), or if you want to support older Git
+# versions that did not do that copying.
+#
+# Having the webserver set up GIT_PROTOCOL is perfectly fine even with
+# modern versions (and will take precedence over HTTP_GIT_PROTOCOL,
+# which means it can be used to override the client's request).
+SetEnvIf Git-Protocol ".*" GIT_PROTOCOL=$0
 ----------------------------------------------------------------
 +
 To enable anonymous read access but authenticated write access,
@@ -264,6 +278,16 @@ a repository with an extremely large number of refs.  The value can be
 specified with a unit (e.g., `100M` for 100 megabytes). The default is
 10 megabytes.
 
+Clients may probe for optional protocol capabilities (like the v2
+protocol) using the `Git-Protocol` HTTP header. In order to support
+these, the contents of that header must appear in the `GIT_PROTOCOL`
+environment variable. Most webservers will pass this header to the CGI
+via the `HTTP_GIT_PROTOCOL` variable, and `git-http-backend` will
+automatically copy that to `GIT_PROTOCOL`. However, some webservers may
+be more selective about which headers they'll pass, in which case they
+need to be configured explicitly (see the mention of `Git-Protocol` in
+the Apache config from the earlier EXAMPLES section).
+
 The backend process sets GIT_COMMITTER_NAME to '$REMOTE_USER' and
 GIT_COMMITTER_EMAIL to '$\{REMOTE_USER}@http.$\{REMOTE_ADDR\}',
 ensuring that any reflogs created by 'git-receive-pack' contain some
-- 
2.33.0.731.g24eb83922d

