Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF34820A17
	for <e@80x24.org>; Mon, 16 Jan 2017 21:25:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750964AbdAPVZi (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jan 2017 16:25:38 -0500
Received: from cloud.peff.net ([104.130.231.41]:39850 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750970AbdAPVZi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jan 2017 16:25:38 -0500
Received: (qmail 20260 invoked by uid 109); 16 Jan 2017 21:25:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 16 Jan 2017 21:25:37 +0000
Received: (qmail 12344 invoked by uid 111); 16 Jan 2017 21:26:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 16 Jan 2017 16:26:31 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Jan 2017 16:25:35 -0500
Date:   Mon, 16 Jan 2017 16:25:35 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 2/6] fsck: report trees as dangling
Message-ID: <20170116212535.cohvikwkju5zehr4@sigill.intra.peff.net>
References: <20170116212231.ojoqzlajpszifaf3@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170116212231.ojoqzlajpszifaf3@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After checking connectivity, fsck looks through the list of
any objects we've seen mentioned, and reports unreachable
and un-"used" ones as dangling. However, it skips any object
which is not marked as "parsed", as that is an object that
we _don't_ have (but that somebody mentioned).

Since 6e454b9a3 (clear parsed flag when we free tree
buffers, 2013-06-05), that flag can't be relied on, and the
correct method is to check the HAS_OBJ flag. The cleanup in
that commit missed this callsite, though. As a result, we
would generally fail to report dangling trees.

We never noticed because there were no tests in this area
(for trees or otherwise). Let's add some.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fsck.c  |  2 +-
 t/t1450-fsck.sh | 27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index f01b81eeb..3e67203f9 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -225,7 +225,7 @@ static void check_unreachable_object(struct object *obj)
 	 * to complain about it being unreachable (since it does
 	 * not exist).
 	 */
-	if (!obj->parsed)
+	if (!(obj->flags & HAS_OBJ))
 		return;
 
 	/*
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 6eef8b28e..e88ec7747 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -559,4 +559,31 @@ test_expect_success 'fsck --name-objects' '
 	)
 '
 
+# for each of type, we have one version which is referenced by another object
+# (and so while unreachable, not dangling), and another variant which really is
+# dangling.
+test_expect_success 'fsck notices dangling objects' '
+	git init dangling &&
+	(
+		cd dangling &&
+		blob=$(echo not-dangling | git hash-object -w --stdin) &&
+		dblob=$(echo dangling | git hash-object -w --stdin) &&
+		tree=$(printf "100644 blob %s\t%s\n" $blob one | git mktree) &&
+		dtree=$(printf "100644 blob %s\t%s\n" $blob two | git mktree) &&
+		commit=$(git commit-tree $tree) &&
+		dcommit=$(git commit-tree -p $commit $tree) &&
+
+		cat >expect <<-EOF &&
+		dangling blob $dblob
+		dangling commit $dcommit
+		dangling tree $dtree
+		EOF
+
+		git fsck >actual &&
+		# the output order is non-deterministic, as it comes from a hash
+		sort <actual >actual.sorted &&
+		test_cmp expect actual.sorted
+	)
+'
+
 test_done
-- 
2.11.0.642.gd6f8cda6c

