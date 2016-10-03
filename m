Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E9E5207EC
	for <e@80x24.org>; Mon,  3 Oct 2016 20:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752597AbcJCUeC (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Oct 2016 16:34:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:51415 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752161AbcJCUeA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2016 16:34:00 -0400
Received: (qmail 17197 invoked by uid 109); 3 Oct 2016 20:34:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 03 Oct 2016 20:34:00 +0000
Received: (qmail 29652 invoked by uid 111); 3 Oct 2016 20:34:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 03 Oct 2016 16:34:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 03 Oct 2016 16:33:58 -0400
Date:   Mon, 3 Oct 2016 16:33:58 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH 02/18] t5613: drop test_valid_repo function
Message-ID: <20161003203357.3cpeg2jyalzykm65@sigill.intra.peff.net>
References: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function makes sure that "git fsck" does not report any
errors. But "--full" has been the default since f29cd39
(fsck: default to "git fsck --full", 2009-10-20), and we can
use the exit code (instead of counting the lines) since
e2b4f63 (fsck: exit with non-zero status upon errors,
2007-03-05).

So we can just use "git fsck", which is shorter and more
flexible (e.g., we can use "git -C").

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5613-info-alternate.sh | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/t/t5613-info-alternate.sh b/t/t5613-info-alternate.sh
index e13f57d..4548fb0 100755
--- a/t/t5613-info-alternate.sh
+++ b/t/t5613-info-alternate.sh
@@ -6,11 +6,6 @@
 test_description='test transitive info/alternate entries'
 . ./test-lib.sh
 
-test_valid_repo() {
-	git fsck --full > fsck.log &&
-	test_line_count = 0 fsck.log
-}
-
 base_dir=$(pwd)
 
 test_expect_success 'preparing first repository' \
@@ -52,7 +47,7 @@ git clone --bare -l -s G H'
 
 test_expect_success 'invalidity of deepest repository' \
 'cd H && {
-	test_valid_repo
+	git fsck
 	test $? -ne 0
 }'
 
@@ -60,41 +55,41 @@ cd "$base_dir"
 
 test_expect_success 'validity of third repository' \
 'cd C &&
-test_valid_repo'
+git fsck'
 
 cd "$base_dir"
 
 test_expect_success 'validity of fourth repository' \
 'cd D &&
-test_valid_repo'
+git fsck'
 
 cd "$base_dir"
 
 test_expect_success 'breaking of loops' \
 'echo "$base_dir"/B/.git/objects >> "$base_dir"/A/.git/objects/info/alternates&&
 cd C &&
-test_valid_repo'
+git fsck'
 
 cd "$base_dir"
 
 test_expect_success 'that info/alternates is necessary' \
 'cd C &&
 rm -f .git/objects/info/alternates &&
-! (test_valid_repo)'
+! (git fsck)'
 
 cd "$base_dir"
 
 test_expect_success 'that relative alternate is possible for current dir' \
 'cd C &&
 echo "../../../B/.git/objects" > .git/objects/info/alternates &&
-test_valid_repo'
+git fsck'
 
 cd "$base_dir"
 
 test_expect_success \
     'that relative alternate is only possible for current dir' '
     cd D &&
-    ! (test_valid_repo)
+    ! (git fsck)
 '
 
 cd "$base_dir"
-- 
2.10.0.618.g82cc264

