Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D3041F404
	for <e@80x24.org>; Thu, 25 Jan 2018 00:55:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932902AbeAYAzH (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 19:55:07 -0500
Received: from cloud.peff.net ([104.130.231.41]:56556 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932250AbeAYAzH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 19:55:07 -0500
Received: (qmail 19520 invoked by uid 109); 25 Jan 2018 00:55:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 25 Jan 2018 00:55:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31569 invoked by uid 111); 25 Jan 2018 00:55:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 24 Jan 2018 19:55:44 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Jan 2018 19:55:05 -0500
Date:   Wed, 24 Jan 2018 19:55:05 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 1/6] t5570: use ls-remote instead of clone for interp tests
Message-ID: <20180125005504.GA26850@sigill.intra.peff.net>
References: <20180125005447.GA26661@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180125005447.GA26661@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We don't actually care about the clone operation here; we
just want to know if we were able to actually contact the
remote repository. Using ls-remote does that more
efficiently, and without us having to worry about managing
the tmp.git directory.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5570-git-daemon.sh | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/t/t5570-git-daemon.sh b/t/t5570-git-daemon.sh
index 225a022e8a..f92ebc5cd5 100755
--- a/t/t5570-git-daemon.sh
+++ b/t/t5570-git-daemon.sh
@@ -167,23 +167,20 @@ test_expect_success 'access repo via interpolated hostname' '
 	git init --bare "$repo" &&
 	git push "$repo" HEAD &&
 	>"$repo"/git-daemon-export-ok &&
-	rm -rf tmp.git &&
 	GIT_OVERRIDE_VIRTUAL_HOST=localhost \
-		git clone --bare "$GIT_DAEMON_URL/interp.git" tmp.git &&
-	rm -rf tmp.git &&
+		git ls-remote "$GIT_DAEMON_URL/interp.git" &&
 	GIT_OVERRIDE_VIRTUAL_HOST=LOCALHOST \
-		git clone --bare "$GIT_DAEMON_URL/interp.git" tmp.git
+		git ls-remote "$GIT_DAEMON_URL/interp.git"
 '
 
 test_expect_success 'hostname cannot break out of directory' '
-	rm -rf tmp.git &&
 	repo="$GIT_DAEMON_DOCUMENT_ROOT_PATH/../escape.git" &&
 	git init --bare "$repo" &&
 	git push "$repo" HEAD &&
 	>"$repo"/git-daemon-export-ok &&
 	test_must_fail \
 		env GIT_OVERRIDE_VIRTUAL_HOST=.. \
-		git clone --bare "$GIT_DAEMON_URL/escape.git" tmp.git
+		git ls-remote "$GIT_DAEMON_URL/escape.git"
 '
 
 stop_git_daemon
-- 
2.16.1.273.gfdaa03aa74

