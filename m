Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1661C433EF
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 14:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A261E61026
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 14:09:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233809AbhIJOLI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 10:11:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:43884 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233702AbhIJOLI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 10:11:08 -0400
Received: (qmail 5807 invoked by uid 109); 10 Sep 2021 14:09:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 Sep 2021 14:09:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25356 invoked by uid 111); 10 Sep 2021 14:09:56 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Sep 2021 10:09:56 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 10 Sep 2021 10:09:56 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: [PATCH 4/5] docs/git: discuss server-side config for GIT_PROTOCOL
Message-ID: <YTtnNLiKyZ3OkQqy@coredump.intra.peff.net>
References: <YTtleYs48A1NpUpp@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YTtleYs48A1NpUpp@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The v2 protocol requires that the GIT_PROTOCOL environment variable gets
passed around, but we don't have any documentation describing how this
is supposed to work. In particular, we need to note what server admins
might need to configure to make things work.

The definition of the GIT_PROTOCOL variable is probably the best place
for this, since:

  - we deal with multiple transports (ssh, http, etc).
    Transport-specific documentation (like the git-http-backend bits
    added in the previous commit) are helpful for those transports, but
    this gives a broader overview. Plus we do not have a specific
    transport endpoint program for ssh, so this is a reasonable place to
    mention it.

  - the server side of the protocol involves multiple programs. For now,
    upload-pack is the only endpoint which uses GIT_PROTOCOL, but that
    will likely expand in the future. We're better off with a central
    discussion of what the server admin might need to do. However, for
    discoverability, this patch adds a pointer from upload-pack's
    documentation.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-upload-pack.txt |  8 ++++++++
 Documentation/git.txt             | 15 +++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/Documentation/git-upload-pack.txt b/Documentation/git-upload-pack.txt
index 9822c1eb1a..070fc78008 100644
--- a/Documentation/git-upload-pack.txt
+++ b/Documentation/git-upload-pack.txt
@@ -44,6 +44,14 @@ OPTIONS
 <directory>::
 	The repository to sync from.
 
+ENVIRONMENT
+-----------
+
+`GIT_PROTOCOL`::
+	Internal variable used for handshaking the wire protocol. Server
+	admins may need to configure some transports to allow this
+	variable to be passed. See the discussion in linkgit:git[1].
+
 SEE ALSO
 --------
 linkgit:gitnamespaces[7]
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 6dd241ef83..e4b82599fc 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -894,6 +894,21 @@ for full details.
 	Contains a colon ':' separated list of keys with optional values
 	'key[=value]'.  Presence of unknown keys and values must be
 	ignored.
++
+Note that servers may need to be configured to allow this variable to
+pass over some transports. It will be propagated automatically when
+accessing local repositories (i.e., `file://` or a filesystem path), as
+well as over the `git://` protocol. For git-over-http, it should work
+automatically in most configurations, but see the discussion in
+linkgit:git-http-backend[1]. For git-over-ssh, the ssh server may need
+to be configured to allow clients to pass this variable (e.g., by using
+`AcceptEnv GIT_PROTOCOL` with OpenSSH).
++
+This configuration is optional. If the variable is not propagated, then
+clients will fall back to the original "v0" protocol (but may miss out
+on some performance improvements or features). This variable currently
+only affects clones and fetches; it is not yet used for pushes (but may
+be in the future).
 
 `GIT_OPTIONAL_LOCKS`::
 	If set to `0`, Git will complete any requested operation without
-- 
2.33.0.731.g24eb83922d

