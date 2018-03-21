Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D985C1F404
	for <e@80x24.org>; Wed, 21 Mar 2018 05:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751458AbeCUFsn (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 01:48:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:36978 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750810AbeCUFsm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 01:48:42 -0400
Received: (qmail 29097 invoked by uid 109); 21 Mar 2018 05:48:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 21 Mar 2018 05:48:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6934 invoked by uid 111); 21 Mar 2018 05:49:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 21 Mar 2018 01:49:38 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Mar 2018 01:48:40 -0400
Date:   Wed, 21 Mar 2018 01:48:40 -0400
From:   Jeff King <peff@peff.net>
To:     phillip.wood@dunelm.org.uk
Cc:     Brian Henderson <henderson.bj@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 2/7] diff-highlight: use test_tick in graph test
Message-ID: <20180321054840.GB14016@sigill.intra.peff.net>
References: <20180321054718.GA13936@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180321054718.GA13936@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The exact ordering output by Git may depend on the commit
timestamps, so let's make sure they're actually
monotonically increasing, and not all the same (or worse,
subject to how long the test script takes to run).

Let's use test_tick to make sure this is stable. Note that
we actually have to rearrange the order of the branches to
match the expected graph structure (which means that
previously we might racily have been testing a slightly
different output, though the test is written in such a way
that we'd still pass).

Signed-off-by: Jeff King <peff@peff.net>
---
 .../diff-highlight/t/t9400-diff-highlight.sh   | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/contrib/diff-highlight/t/t9400-diff-highlight.sh b/contrib/diff-highlight/t/t9400-diff-highlight.sh
index bf62f036c7..deab90ed91 100755
--- a/contrib/diff-highlight/t/t9400-diff-highlight.sh
+++ b/contrib/diff-highlight/t/t9400-diff-highlight.sh
@@ -52,9 +52,9 @@ test_strip_patch_header () {
 # dh_test_setup_history generates a contrived graph such that we have at least
 # 1 nesting (E) and 2 nestings (F).
 #
-#	  A branch
+#	  A master
 #	 /
-#	D---E---F master
+#	D---E---F branch
 #
 #	git log --all --graph
 #	* commit
@@ -74,18 +74,22 @@ dh_test_setup_history () {
 
 	cat file1 >file &&
 	git add file &&
+	test_tick &&
 	git commit -m "D" &&
 
 	git checkout -b branch &&
 	cat file2 >file &&
-	git commit -a -m "A" &&
-
-	git checkout master &&
-	cat file2 >file &&
+	test_tick &&
 	git commit -a -m "E" &&
 
 	cat file3 >file &&
-	git commit -a -m "F"
+	test_tick &&
+	git commit -a -m "F" &&
+
+	git checkout master &&
+	cat file2 >file &&
+	test_tick &&
+	git commit -a -m "A"
 }
 
 left_trim () {
-- 
2.17.0.rc0.402.ged0b3fd1ee

