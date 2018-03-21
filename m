Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15A4A1F404
	for <e@80x24.org>; Wed, 21 Mar 2018 05:49:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751505AbeCUFt3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 01:49:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:36996 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750810AbeCUFt2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 01:49:28 -0400
Received: (qmail 29151 invoked by uid 109); 21 Mar 2018 05:49:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 21 Mar 2018 05:49:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6970 invoked by uid 111); 21 Mar 2018 05:50:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 21 Mar 2018 01:50:24 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Mar 2018 01:49:26 -0400
Date:   Wed, 21 Mar 2018 01:49:26 -0400
From:   Jeff King <peff@peff.net>
To:     phillip.wood@dunelm.org.uk
Cc:     Brian Henderson <henderson.bj@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 4/7] diff-highlight: test interleaved parallel lines of
 history
Message-ID: <20180321054926.GD14016@sigill.intra.peff.net>
References: <20180321054718.GA13936@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180321054718.GA13936@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The graph test in t9400 covers the case of two simultaneous
branches, but all of the commits during this time are on the
right-hand branch. So we test a graph structure like:

  | |
  | * commit ...
  | |

but we never see the reverse, a commit on the left-hand
branch:

  | |
  * | commit ...
  | |

Since this is an easy thing to get wrong when touching the
graph-matching code, let's cover it by adding one more
commit with its timestamp interleaved with the other branch.

Note that we need to pass --date-order to convince Git to
show it this way (since --topo-order tries to keep lines of
history separate).

Signed-off-by: Jeff King <peff@peff.net>
---
 .../diff-highlight/t/t9400-diff-highlight.sh  | 22 +++++++++++++------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/contrib/diff-highlight/t/t9400-diff-highlight.sh b/contrib/diff-highlight/t/t9400-diff-highlight.sh
index 3f02d31467..33bcdbc90f 100755
--- a/contrib/diff-highlight/t/t9400-diff-highlight.sh
+++ b/contrib/diff-highlight/t/t9400-diff-highlight.sh
@@ -52,15 +52,17 @@ test_strip_patch_header () {
 # dh_test_setup_history generates a contrived graph such that we have at least
 # 1 nesting (E) and 2 nestings (F).
 #
-#	  A master
+#	  A---B master
 #	 /
 #	D---E---F branch
 #
 #	git log --all --graph
 #	* commit
-#	|    A
+#	|    B
 #	| * commit
 #	| |    F
+#	* | commit
+#	| |    A
 #	| * commit
 #	|/
 #	|    E
@@ -78,14 +80,20 @@ dh_test_setup_history () {
 	test_tick &&
 	git commit -a -m "E" &&
 
+	git checkout master &&
+	echo file2 >file &&
+	test_tick &&
+	git commit -a -m "A" &&
+
+	git checkout branch &&
 	echo file3 >file &&
 	test_tick &&
 	git commit -a -m "F" &&
 
 	git checkout master &&
-	echo file2 >file &&
+	echo file3 >file &&
 	test_tick &&
-	git commit -a -m "A"
+	git commit -a -m "B"
 }
 
 left_trim () {
@@ -246,12 +254,12 @@ test_expect_failure 'diff-highlight treats combining code points as a unit' '
 test_expect_success 'diff-highlight works with the --graph option' '
 	dh_test_setup_history &&
 
-	# topo-order so that the order of the commits is the same as with --graph
+	# date-order so that the commits are interleaved for both
 	# trim graph elements so we can do a diff
 	# trim leading space because our trim_graph is not perfect
-	git log --branches -p --topo-order |
+	git log --branches -p --date-order |
 		"$DIFF_HIGHLIGHT" | left_trim >graph.exp &&
-	git log --branches -p --graph |
+	git log --branches -p --date-order --graph |
 		"$DIFF_HIGHLIGHT" | trim_graph | left_trim >graph.act &&
 	test_cmp graph.exp graph.act
 '
-- 
2.17.0.rc0.402.ged0b3fd1ee

