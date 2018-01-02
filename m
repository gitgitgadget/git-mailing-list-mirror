Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 563301F428
	for <e@80x24.org>; Tue,  2 Jan 2018 21:09:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750984AbeABVJD (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jan 2018 16:09:03 -0500
Received: from cloud.peff.net ([104.130.231.41]:51032 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750800AbeABVJC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jan 2018 16:09:02 -0500
Received: (qmail 11154 invoked by uid 109); 2 Jan 2018 21:09:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 02 Jan 2018 21:09:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19437 invoked by uid 111); 2 Jan 2018 21:09:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Tue, 02 Jan 2018 16:09:32 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Jan 2018 16:09:00 -0500
Date:   Tue, 2 Jan 2018 16:09:00 -0500
From:   Jeff King <peff@peff.net>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Stephan Janssen <sjanssen@you-get.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [PATCH 2/4] t5600: modernize style
Message-ID: <20180102210859.GB22556@sigill.intra.peff.net>
References: <20180102210753.GA10430@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180102210753.GA10430@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an old script which could use some updating before
we add to it:

  - use the standard line-breaking:

      test_expect_success 'title' '
              body
      '

  - run all code inside test_expect blocks to catch
    unexpected failures in setup steps

  - use "test_commit -C" instead of manually entering
    sub-repo

  - use test_when_finished for cleanup steps

  - test_path_is_* as appropriate

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5600-clone-fail-cleanup.sh | 48 ++++++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 23 deletions(-)

diff --git a/t/t5600-clone-fail-cleanup.sh b/t/t5600-clone-fail-cleanup.sh
index f23f92e5a7..7b2a8052f8 100755
--- a/t/t5600-clone-fail-cleanup.sh
+++ b/t/t5600-clone-fail-cleanup.sh
@@ -11,42 +11,44 @@ remove the directory before attempting a clone again.'
 
 . ./test-lib.sh
 
-test_expect_success \
-    'clone of non-existent source should fail' \
-    'test_must_fail git clone foo bar'
+test_expect_success 'clone of non-existent source should fail' '
+	test_must_fail git clone foo bar
+'
 
-test_expect_success \
-    'failed clone should not leave a directory' \
-    '! test -d bar'
+test_expect_success 'failed clone should not leave a directory' '
+	test_path_is_missing bar
+'
 
-# Need a repo to clone
-test_create_repo foo
+test_expect_success 'create a repo to clone' '
+	test_create_repo foo
+'
 
-# create some objects so that we can corrupt the repo later
-(cd foo && touch file && git add file && git commit -m 'add file' >/dev/null 2>&1)
+test_expect_success 'create objects in repo for later corruption' '
+	test_commit -C foo file
+'
 
 # source repository given to git clone should be relative to the
 # current path not to the target dir
-test_expect_success \
-    'clone of non-existent (relative to $PWD) source should fail' \
-    'test_must_fail git clone ../foo baz'
+test_expect_success 'clone of non-existent (relative to $PWD) source should fail' '
+	test_must_fail git clone ../foo baz
+'
 
-test_expect_success \
-    'clone should work now that source exists' \
-    'git clone foo bar'
+test_expect_success 'clone should work now that source exists' '
+	git clone foo bar
+'
 
-test_expect_success \
-    'successful clone must leave the directory' \
-    'test -d bar'
+test_expect_success 'successful clone must leave the directory' '
+	test_path_is_dir bar
+'
 
 test_expect_success 'failed clone --separate-git-dir should not leave any directories' '
+	test_when_finished "rmdir foo/.git/objects.bak" &&
 	mkdir foo/.git/objects.bak/ &&
+	test_when_finished "mv foo/.git/objects.bak/* foo/.git/objects/" &&
 	mv foo/.git/objects/* foo/.git/objects.bak/ &&
 	test_must_fail git clone --separate-git-dir gitdir foo worktree &&
-	test_must_fail test -e gitdir &&
-	test_must_fail test -e worktree &&
-	mv foo/.git/objects.bak/* foo/.git/objects/ &&
-	rmdir foo/.git/objects.bak
+	test_path_is_missing gitdir &&
+	test_path_is_missing worktree
 '
 
 test_done
-- 
2.16.0.rc0.384.gc477e89267

