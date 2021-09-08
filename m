Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2427EC433F5
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 10:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C94C61164
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 10:48:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346088AbhIHKt4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 06:49:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:41648 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231440AbhIHKtz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 06:49:55 -0400
Received: (qmail 23156 invoked by uid 109); 8 Sep 2021 10:48:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 08 Sep 2021 10:48:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25858 invoked by uid 111); 8 Sep 2021 10:48:47 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 08 Sep 2021 06:48:47 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 8 Sep 2021 06:48:46 -0400
From:   Jeff King <peff@peff.net>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH] Docs: web server must setenv GIT_PROTOCOL for v2
Message-ID: <YTiVDo4m5B5RcfCg@coredump.intra.peff.net>
References: <20210904151721.445117-1-konstantin@linuxfoundation.org>
 <YTOW352xtsbvJcKy@coredump.intra.peff.net>
 <20210907211128.mauwgxupbredgx7w@meerkat.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210907211128.mauwgxupbredgx7w@meerkat.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 07, 2021 at 05:11:28PM -0400, Konstantin Ryabitsev wrote:

> On Sat, Sep 04, 2021 at 11:55:11AM -0400, Jeff King wrote:
> > Unfortunately there isn't any nginx example config there at all yet. If
> > you have kernel.org config you could share, that would be great. But
> > even starting with just the "here's how you do v2" part would be
> > welcome.
> 
> I'll see if I can come up with something to put into
> Documentation/git-http-backend.txt, but I can't right away -- hopefully in
> early October once a bunch of conferences are over.

It would be great if you could add nginx examples at some point. But in
the meantime, we can do this much easier patch to make sure we don't
forget about mentioning the protocol bits.

-- >8 --
Subject: [PATCH] docs/http-backend: mention v2 protocol

There's a little bit of configuration needed at the webserver level in
order to get the client's v2 protocol probes to Git. But when we
introduced the v2 protocol, we never documented these explicitly.

Commit 9181c4a9ac (Docs: web server must setenv GIT_PROTOCOL for v2,
2021-09-04) now mentions them in the v2 docs themselves, but users
configuring git-over-http for the first time are more likely to be
looking in the git-http-backend manpage. Let's make sure we mention it
there, too, and give some examples.

Both of the included examples here have been tested to work. The one for
lighttpd is a little less direct than I'd like, but I couldn't find a
way to directly set an environment variable to the value of a request
header. From my reading of the documentation, lighttpd will set
HTTP_GIT_PROTOCOL automatically, but git-http-backend looks only at
GIT_PROTOCOL. Arguably http-backend should do this translation itself.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-http-backend.txt | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-http-backend.txt b/Documentation/git-http-backend.txt
index 558966aa83..4797bc8aec 100644
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
@@ -76,6 +78,7 @@ Apache 2.x::
 ----------------------------------------------------------------
 SetEnv GIT_PROJECT_ROOT /var/www/git
 SetEnv GIT_HTTP_EXPORT_ALL
+SetEnvIf Git-Protocol ".*" GIT_PROTOCOL=$0
 ScriptAlias /git/ /usr/libexec/git-core/git-http-backend/
 ----------------------------------------------------------------
 +
@@ -203,6 +206,9 @@ $HTTP["url"] =~ "^/git" {
 		"GIT_PROJECT_ROOT" => "/var/www/git",
 		"GIT_HTTP_EXPORT_ALL" => ""
 	)
+	$REQUEST_HEADER["Git-Protocol"] == "version=2" {
+		setenv.add-environment += ("GIT_PROTOCOL" => "version=2")
+	}
 }
 ----------------------------------------------------------------
 +
@@ -264,6 +270,11 @@ a repository with an extremely large number of refs.  The value can be
 specified with a unit (e.g., `100M` for 100 megabytes). The default is
 10 megabytes.
 
+Clients may probe for optional protocol capabilities using the
+`Git-Protocol` HTTP header. In order to support these, the webserver
+must be configured to pass the contents of that header to
+`git-http-backend` in the `GIT_PROTOCOL` environment variable.
+
 The backend process sets GIT_COMMITTER_NAME to '$REMOTE_USER' and
 GIT_COMMITTER_EMAIL to '$\{REMOTE_USER}@http.$\{REMOTE_ADDR\}',
 ensuring that any reflogs created by 'git-receive-pack' contain some
-- 
2.33.0.621.ga797e945d8

