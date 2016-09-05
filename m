Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D295F20705
	for <e@80x24.org>; Mon,  5 Sep 2016 21:52:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933373AbcIEVwV (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Sep 2016 17:52:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:38480 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932217AbcIEVwU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2016 17:52:20 -0400
Received: (qmail 7964 invoked by uid 109); 5 Sep 2016 21:52:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 05 Sep 2016 21:52:20 +0000
Received: (qmail 22348 invoked by uid 111); 5 Sep 2016 21:52:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 05 Sep 2016 17:52:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Sep 2016 17:52:17 -0400
Date:   Mon, 5 Sep 2016 17:52:17 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 3/5] t5305: use "git -C"
Message-ID: <20160905215217.6jg2tois6uavwmkr@sigill.intra.peff.net>
References: <20160905215141.b6unqtjqko7775is@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160905215141.b6unqtjqko7775is@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This test unpacks objects into a separate repository, and
accesses it by setting GIT_DIR in a subshell. We can do the
same thing these days by using "git init <repo>" and "git
-C". In most cases this is shorter, though when there are
multiple commands, we may end up repeating the "-C".

However, this repetition can actually be a good thing. This
patch also fixes a bug introduced by 512477b (tests: use
"env" to run commands with temporary env-var settings,
2014-03-18). That commit essentially converted:

   (GIT_DIR=...; export GIT_DIR
    cmd1 &&
    cmd2)

into:

   (GIT_DIR=... cmd1 &&
    cmd2)

which obviously loses the GIT_DIR setting for cmd2 (we never
noticed the bug because it simply runs "cmd2" in the parent
repo, which means we were simply failing to test anything
interesting). By using "git -C" rather than a subshell, it
becomes quite obvious where each command is supposed to be
running.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5305-include-tag.sh | 28 +++++++---------------------
 1 file changed, 7 insertions(+), 21 deletions(-)

diff --git a/t/t5305-include-tag.sh b/t/t5305-include-tag.sh
index 787fc83..089a3e9 100755
--- a/t/t5305-include-tag.sh
+++ b/t/t5305-include-tag.sh
@@ -33,20 +33,14 @@ test_expect_success 'pack without --include-tag' '
 
 test_expect_success 'unpack objects' '
 	rm -rf clone.git &&
-	(
-		GIT_DIR=clone.git &&
-		export GIT_DIR &&
-		git init &&
-		git unpack-objects <test-1-${packname_1}.pack
-	)
+	git init clone.git &&
+	git -C clone.git unpack-objects <test-1-${packname_1}.pack
 '
 
 test_expect_success 'check unpacked result (have commit, no tag)' '
 	git rev-list --objects $commit >list.expect &&
-	(
-		test_must_fail env GIT_DIR=clone.git git cat-file -e $tag &&
-		git rev-list --objects $commit
-	) >list.actual &&
+	test_must_fail git -C clone.git cat-file -e $tag &&
+	git -C clone.git rev-list --objects $commit >list.actual &&
 	test_cmp list.expect list.actual
 '
 
@@ -59,21 +53,13 @@ test_expect_success 'pack with --include-tag' '
 
 test_expect_success 'unpack objects' '
 	rm -rf clone.git &&
-	(
-		GIT_DIR=clone.git &&
-		export GIT_DIR &&
-		git init &&
-		git unpack-objects <test-2-${packname_1}.pack
-	)
+	git init clone.git &&
+	git -C clone.git unpack-objects <test-2-${packname_1}.pack
 '
 
 test_expect_success 'check unpacked result (have commit, have tag)' '
 	git rev-list --objects mytag >list.expect &&
-	(
-		GIT_DIR=clone.git &&
-		export GIT_DIR &&
-		git rev-list --objects $tag
-	) >list.actual &&
+	git -C clone.git rev-list --objects $tag >list.actual &&
 	test_cmp list.expect list.actual
 '
 
-- 
2.10.0.rc2.154.gb4a4b8b

