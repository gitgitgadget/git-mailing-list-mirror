Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82626C433DB
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 09:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A1CF2333D
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 09:44:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbhAGJok (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 04:44:40 -0500
Received: from cloud.peff.net ([104.130.231.41]:48528 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbhAGJoj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 04:44:39 -0500
Received: (qmail 16085 invoked by uid 109); 7 Jan 2021 09:43:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 07 Jan 2021 09:43:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26453 invoked by uid 111); 7 Jan 2021 09:44:01 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 Jan 2021 04:44:01 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 7 Jan 2021 04:43:58 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Harold Kim <h.kim@flatt.tech>
Subject: [PATCH 1/2] git_connect_git(): forbid newlines in host and path
Message-ID: <X/bX3jUMapnw2hYI@coredump.intra.peff.net>
References: <X/bXV9dGFK2bxBV0@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X/bXV9dGFK2bxBV0@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we connect to a git:// server, we send an initial request that
looks something like:

  002dgit-upload-pack repo.git\0host=example.com

If the repo path contains a newline, then it's included literally, and
we get:

  002egit-upload-pack repo
  .git\0host=example.com

This works fine if you really do have a newline in your repository name;
the server side uses the pktline framing to parse the string, not
newlines. However, there are many _other_ protocols in the wild that do
parse on newlines, such as HTTP. So a carefully constructed git:// URL
can actually turn into a valid HTTP request. For example:

  git://localhost:1234/%0d%0a%0d%0aGET%20/%20HTTP/1.1 %0d%0aHost:localhost%0d%0a%0d%0a

becomes:

  0050git-upload-pack /
  GET / HTTP/1.1
  Host:localhost

  host=localhost:1234

on the wire. Again, this isn't a problem for a real Git server, but it
does mean that feeding a malicious URL to Git (e.g., through a
submodule) can cause it to make unexpected cross-protocol requests.
Since repository names with newlines are presumably quite rare (and
indeed, we already disallow them in git-over-http), let's just disallow
them over this protocol.

Hostnames could likewise inject a newline, but this is unlikely a
problem in practice; we'd try resolving the hostname with a newline in
it, which wouldn't work. Still, it doesn't hurt to err on the side of
caution there, since we would not expect them to work in the first
place.

The ssh and local code paths are unaffected by this patch. In both cases
we're trying to run upload-pack via a shell, and will quote the newline
so that it makes it intact. An attacker can point an ssh url at an
arbitrary port, of course, but unless there's an actual ssh server
there, we'd never get as far as sending our shell command anyway.  We
_could_ similarly restrict newlines in those protocols out of caution,
but there seems little benefit to doing so.

The new test here is run alongside the git-daemon tests, which cover the
same protocol, but it shouldn't actually contact the daemon at all.  In
theory we could make the test more robust by setting up an actual
repository with a newline in it (so that our clone would succeed if our
new check didn't kick in). But a repo directory with newline in it is
likely not portable across all filesystems. Likewise, we could check
git-daemon's log that it was not contacted at all, but we do not
currently record the log (and anyway, it would make the test racy with
the daemon's log write). We'll just check the client-side stderr to make
sure we hit the expected code path.

Reported-by: Harold Kim <h.kim@flatt.tech>
Signed-off-by: Jeff King <peff@peff.net>
---
 connect.c             | 2 ++
 t/t5570-git-daemon.sh | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/connect.c b/connect.c
index 8b8f56cf6d..9c97fee430 100644
--- a/connect.c
+++ b/connect.c
@@ -1160,6 +1160,8 @@ static struct child_process *git_connect_git(int fd[2], char *hostandport,
 		target_host = xstrdup(hostandport);
 
 	transport_check_allowed("git");
+	if (strchr(target_host, '\n') || strchr(path, '\n'))
+		die(_("newline is forbidden in git:// hosts and repo paths"));
 
 	/*
 	 * These underlying connection commands die() if they
diff --git a/t/t5570-git-daemon.sh b/t/t5570-git-daemon.sh
index 8f69a7854f..0fbb194810 100755
--- a/t/t5570-git-daemon.sh
+++ b/t/t5570-git-daemon.sh
@@ -103,6 +103,11 @@ test_expect_success 'fetch notices corrupt idx' '
 	)
 '
 
+test_expect_success 'client refuses to ask for repo with newline' '
+	test_must_fail git clone "$GIT_DAEMON_URL/repo$LF.git" dst 2>stderr &&
+	test_i18ngrep newline.is.forbidden stderr
+'
+
 test_remote_error()
 {
 	do_export=YesPlease
-- 
2.30.0.572.g094076f6a2

