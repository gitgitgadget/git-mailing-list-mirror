Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCC9DDAC
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 07:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B892590
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 23:14:35 -0800 (PST)
Received: (qmail 25363 invoked by uid 109); 9 Nov 2023 07:14:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Nov 2023 07:14:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20635 invoked by uid 111); 9 Nov 2023 07:14:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Nov 2023 02:14:39 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 9 Nov 2023 02:14:34 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 4/9] commit-graph: clarify missing-chunk error messages
Message-ID: <20231109071434.GD2698043@coredump.intra.peff.net>
References: <20231109070310.GA2697602@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231109070310.GA2697602@coredump.intra.peff.net>

When a required commit-graph chunk cannot be loaded, we leave its entry
in the struct NULL, and then later complain that it is missing. But
that's just one reason we might not have loaded it, as we also do some
data quality checks.

Let's switch these messages to say "missing or corrupted", which is
exactly what the midx code says for the same cases. Likewise, we'll use
the same phrasing and capitalization as those for consistency. And while
we're here, we can mark them for translation (just like the midx ones).

Signed-off-by: Jeff King <peff@peff.net>
---
I went with "corrupted" here for consistency with the others (versus
"corrupt"). If we think there's a reason to prefer one over the other,
I'm happy to take a patch on top fixing all of them.

 commit-graph.c          |  6 +++---
 t/t5318-commit-graph.sh | 10 +++++-----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index d9fc08de86..989ebbe816 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -292,15 +292,15 @@ static int verify_commit_graph_lite(struct commit_graph *g)
 	 * itself.
 	 */
 	if (!g->chunk_oid_fanout) {
-		error("commit-graph is missing the OID Fanout chunk");
+		error(_("commit-graph required OID fanout chunk missing or corrupted"));
 		return 1;
 	}
 	if (!g->chunk_oid_lookup) {
-		error("commit-graph is missing the OID Lookup chunk");
+		error(_("commit-graph required OID lookup chunk missing or corrupted"));
 		return 1;
 	}
 	if (!g->chunk_commit_data) {
-		error("commit-graph is missing the Commit Data chunk");
+		error(_("commit-graph required commit data chunk missing or corrupted"));
 		return 1;
 	}
 
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index d4fc65e078..affb959d64 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -540,17 +540,17 @@ test_expect_success 'detect low chunk count' '
 
 test_expect_success 'detect missing OID fanout chunk' '
 	corrupt_graph_and_verify $GRAPH_BYTE_OID_FANOUT_ID "\0" \
-		"missing the OID Fanout chunk"
+		"commit-graph required OID fanout chunk missing or corrupted"
 '
 
 test_expect_success 'detect missing OID lookup chunk' '
 	corrupt_graph_and_verify $GRAPH_BYTE_OID_LOOKUP_ID "\0" \
-		"missing the OID Lookup chunk"
+		"commit-graph required OID lookup chunk missing or corrupted"
 '
 
 test_expect_success 'detect missing commit data chunk' '
 	corrupt_graph_and_verify $GRAPH_BYTE_COMMIT_DATA_ID "\0" \
-		"missing the Commit Data chunk"
+		"commit-graph required commit data chunk missing or corrupted"
 '
 
 test_expect_success 'detect incorrect fanout' '
@@ -842,7 +842,7 @@ test_expect_success 'reader notices too-small oid fanout chunk' '
 	check_corrupt_chunk OIDF clear $(printf "000000%02x" $(test_seq 250)) &&
 	cat >expect.err <<-\EOF &&
 	error: commit-graph oid fanout chunk is wrong size
-	error: commit-graph is missing the OID Fanout chunk
+	error: commit-graph required OID fanout chunk missing or corrupted
 	EOF
 	test_cmp expect.err err
 '
@@ -874,7 +874,7 @@ test_expect_success 'reader notices too-small commit data chunk' '
 	check_corrupt_chunk CDAT clear 00000000 &&
 	cat >expect.err <<-\EOF &&
 	error: commit-graph commit data chunk is wrong size
-	error: commit-graph is missing the Commit Data chunk
+	error: commit-graph required commit data chunk missing or corrupted
 	EOF
 	test_cmp expect.err err
 '
-- 
2.43.0.rc1.572.g273fc7bed6

