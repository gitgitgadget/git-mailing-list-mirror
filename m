Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE7E9CE7AFB
	for <git@archiver.kernel.org>; Thu, 28 Sep 2023 04:39:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjI1EjO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Sep 2023 00:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjI1EjN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Sep 2023 00:39:13 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2DF192
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 21:39:11 -0700 (PDT)
Received: (qmail 3715 invoked by uid 109); 28 Sep 2023 04:39:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 28 Sep 2023 04:39:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9673 invoked by uid 111); 28 Sep 2023 04:39:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 28 Sep 2023 00:39:13 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 28 Sep 2023 00:39:10 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 5/6] commit-graph: tighten chain size check
Message-ID: <20230928043910.GE58367@coredump.intra.peff.net>
References: <20230928043746.GB57926@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230928043746.GB57926@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we open a commit-graph-chain file, if it's smaller than a single
entry, we just quietly treat that as ENOENT. That make some sense if the
file is truly zero bytes, but it means that "commit-graph verify" will
quietly ignore a file that contains garbage if that garbage happens to
be short.

Instead, let's only simulate ENOENT when the file is truly empty, and
otherwise return EINVAL. The normal graph-loading routines don't care,
but "commit-graph verify" will notice and complain about the difference.

It's not entirely clear to me that the 0-is-ENOENT case actually happens
in real life, so we could perhaps just eliminate this special-case
altogether. But this is how we've always behaved, so I'm preserving it
in the name of backwards compatibility (though again, it really only
matters for "verify", as the regular routines are happy to load what
they can).

Signed-off-by: Jeff King <peff@peff.net>
---
 commit-graph.c                | 10 ++++++++--
 t/t5324-split-commit-graph.sh | 12 ++++++++++++
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 8b29c6de24..b1d3e5bf94 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -548,9 +548,15 @@ int open_commit_graph_chain(const char *chain_file,
 		close(*fd);
 		return 0;
 	}
-	if (st->st_size <= the_hash_algo->hexsz) {
+	if (st->st_size < the_hash_algo->hexsz) {
 		close(*fd);
-		errno = ENOENT;
+		if (!st->st_size) {
+			/* treat empty files the same as missing */
+			errno = ENOENT;
+		} else {
+			warning("commit-graph chain file too small");
+			errno = EINVAL;
+		}
 		return 0;
 	}
 	return 1;
diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
index a5ac0440f1..be58545810 100755
--- a/t/t5324-split-commit-graph.sh
+++ b/t/t5324-split-commit-graph.sh
@@ -342,6 +342,18 @@ test_expect_success 'verify after commit-graph-chain corruption (tip)' '
 	)
 '
 
+test_expect_success 'verify notices too-short chain file' '
+	git clone --no-hardlinks . verify-chain-short &&
+	(
+		cd verify-chain-short &&
+		git commit-graph verify &&
+		echo "garbage" >$graphdir/commit-graph-chain &&
+		test_must_fail git commit-graph verify 2>test_err &&
+		grep -v "^+" test_err >err &&
+		grep "commit-graph chain file too small" err
+	)
+'
+
 test_expect_success 'verify across alternates' '
 	git clone --no-hardlinks . verify-alt &&
 	(
-- 
2.42.0.773.ga6e30199be

