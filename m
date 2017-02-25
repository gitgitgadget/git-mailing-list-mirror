Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BBCC2022D
	for <e@80x24.org>; Sat, 25 Feb 2017 10:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751683AbdBYKE0 (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Feb 2017 05:04:26 -0500
Received: from cloud.peff.net ([104.130.231.41]:33964 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751588AbdBYKEZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Feb 2017 05:04:25 -0500
Received: (qmail 27734 invoked by uid 109); 25 Feb 2017 09:37:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 25 Feb 2017 09:37:32 +0000
Received: (qmail 21355 invoked by uid 111); 25 Feb 2017 09:37:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 25 Feb 2017 04:37:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 25 Feb 2017 04:37:30 -0500
Date:   Sat, 25 Feb 2017 04:37:30 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 2/2] t/interop: add test of old clients against modern
 git-daemon
Message-ID: <20170225093730.phcefrsjzcr3jwvr@sigill.intra.peff.net>
References: <20170225093231.k7jtvx47jieka7qm@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170225093231.k7jtvx47jieka7qm@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This test just checks that old clients can clone and fetch
from a newer git-daemon. The opposite should also be true,
but it's hard to test ancient versions of git-daemon because
they lack basic options like "--listen".

Note that we have to make a slight tweak to the
lib-git-daemon helper from the regular tests, so that it
starts the daemon with our correct git.a version.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/interop/i5500-git-daemon.sh | 41 +++++++++++++++++++++++++++++++++++++++++
 t/lib-git-daemon.sh           |  3 ++-
 2 files changed, 43 insertions(+), 1 deletion(-)
 create mode 100755 t/interop/i5500-git-daemon.sh

diff --git a/t/interop/i5500-git-daemon.sh b/t/interop/i5500-git-daemon.sh
new file mode 100755
index 000000000..1daf69420
--- /dev/null
+++ b/t/interop/i5500-git-daemon.sh
@@ -0,0 +1,41 @@
+#!/bin/sh
+
+VERSION_A=.
+VERSION_B=v1.0.0
+
+: ${LIB_GIT_DAEMON_PORT:=5500}
+LIB_GIT_DAEMON_COMMAND='git.a daemon'
+
+test_description='clone and fetch by older client'
+. ./interop-lib.sh
+. "$TEST_DIRECTORY"/lib-git-daemon.sh
+
+start_git_daemon --export-all
+
+repo=$GIT_DAEMON_DOCUMENT_ROOT_PATH/repo
+
+test_expect_success "create repo served by $VERSION_A" '
+	git.a init "$repo" &&
+	git.a -C "$repo" commit --allow-empty -m one
+'
+
+test_expect_success "clone with $VERSION_B" '
+	git.b clone "$GIT_DAEMON_URL/repo" child &&
+	echo one >expect &&
+	git.a -C child log -1 --format=%s >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success "fetch with $VERSION_B" '
+	git.a -C "$repo" commit --allow-empty -m two &&
+	(
+		cd child &&
+		git.b fetch
+	) &&
+	echo two >expect &&
+	git.a -C child log -1 --format=%s FETCH_HEAD >actual &&
+	test_cmp expect actual
+'
+
+stop_git_daemon
+test_done
diff --git a/t/lib-git-daemon.sh b/t/lib-git-daemon.sh
index f9cbd4793..987d40680 100644
--- a/t/lib-git-daemon.sh
+++ b/t/lib-git-daemon.sh
@@ -46,7 +46,8 @@ start_git_daemon() {
 
 	say >&3 "Starting git daemon ..."
 	mkfifo git_daemon_output
-	git daemon --listen=127.0.0.1 --port="$LIB_GIT_DAEMON_PORT" \
+	${LIB_GIT_DAEMON_COMMAND:-git daemon} \
+		--listen=127.0.0.1 --port="$LIB_GIT_DAEMON_PORT" \
 		--reuseaddr --verbose \
 		--base-path="$GIT_DAEMON_DOCUMENT_ROOT_PATH" \
 		"$@" "$GIT_DAEMON_DOCUMENT_ROOT_PATH" \
-- 
2.12.0.616.g5f622f3b1
