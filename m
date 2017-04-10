Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E44E20960
	for <e@80x24.org>; Mon, 10 Apr 2017 22:13:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752781AbdDJWNm (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Apr 2017 18:13:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:59488 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752151AbdDJWNm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2017 18:13:42 -0400
Received: (qmail 29721 invoked by uid 109); 10 Apr 2017 22:13:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Apr 2017 22:13:42 +0000
Received: (qmail 29394 invoked by uid 111); 10 Apr 2017 22:14:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Apr 2017 18:14:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Apr 2017 18:13:39 -0400
Date:   Mon, 10 Apr 2017 18:13:39 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 2/3] receive-pack: document user-visible quarantine effects
Message-ID: <20170410221339.5fs26rzca6wk73de@sigill.intra.peff.net>
References: <20170410221058.2ao64wedg2pa6uc2@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170410221058.2ao64wedg2pa6uc2@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 722ff7f87 (receive-pack: quarantine objects until
pre-receive accepts, 2016-10-03) changed the underlying
details of how we take in objects. This is mostly
transparent to the user, but there are a few things they
might notice. Let's document them.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-receive-pack.txt | 28 ++++++++++++++++++++++++++++
 Documentation/githooks.txt         |  3 +++
 2 files changed, 31 insertions(+)

diff --git a/Documentation/git-receive-pack.txt b/Documentation/git-receive-pack.txt
index 0ccd5fbc7..7267ecfbe 100644
--- a/Documentation/git-receive-pack.txt
+++ b/Documentation/git-receive-pack.txt
@@ -114,6 +114,8 @@ will be performed, and the update, post-receive and post-update
 hooks will not be invoked either.  This can be useful to quickly
 bail out if the update is not to be supported.
 
+See the notes on the quarantine environment below.
+
 update Hook
 -----------
 Before each ref is updated, if $GIT_DIR/hooks/update file exists
@@ -214,6 +216,32 @@ if the repository is packed and is served via a dumb transport.
 	exec git update-server-info
 
 
+Quarantine Environment
+----------------------
+
+When `receive-pack` takes in objects, they are placed into a temporary
+"quarantine" directory within the `$GIT_DIR/objects` directory and
+migrated into the main object store only after the `pre-receive` hook
+has completed. If the push fails before then, the temporary directory is
+removed entirely.
+
+This has a few user-visible effects and caveats:
+
+  1. Pushes which fail due to problems with the incoming pack, missing
+     objects, or due to the `pre-receive` hook will not leave any
+     on-disk data. This is usually helpful to prevent repeated failed
+     pushes from filling up your disk, but can make debugging more
+     challenging.
+
+  2. Any objects created by the `pre-receive` hook will be created in
+     the quarantine directory (and migrated only if it succeeds).
+
+  3. The `pre-receive` hook MUST NOT update any refs to point to
+     quarantined objects. Other programs accessing the repository will
+     not be able to see the objects (and if the pre-receive hook fails,
+     those refs would become corrupted).
+
+
 SEE ALSO
 --------
 linkgit:git-send-pack[1], linkgit:gitnamespaces[7]
diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 9565dc3fd..32343ae29 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -256,6 +256,9 @@ environment variables will not be set. If the client selects
 to use push options, but doesn't transmit any, the count variable
 will be set to zero, `GIT_PUSH_OPTION_COUNT=0`.
 
+See the section on "Quarantine Environment" in
+linkgit:git-receive-pack[1] for some caveats.
+
 [[update]]
 update
 ~~~~~~
-- 
2.12.2.952.g759391acc

