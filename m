Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B512594
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 07:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E4E2126
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 23:25:08 -0800 (PST)
Received: (qmail 25498 invoked by uid 109); 9 Nov 2023 07:25:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Nov 2023 07:25:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20894 invoked by uid 111); 9 Nov 2023 07:25:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Nov 2023 02:25:11 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 9 Nov 2023 02:25:07 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 7/9] commit-graph: check order while reading fanout chunk
Message-ID: <20231109072507.GG2698043@coredump.intra.peff.net>
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

We read the fanout chunk, storing a pointer to it, but only confirm that
the entries are monotonic in a final "lite" verification step. Let's
move that into the actual OIDF chunk callback, so that we can report
problems immediately (for all the reasons given in the previous
"commit-graph: abort as soon as we see a bogus chunk" commit).

Signed-off-by: Jeff King <peff@peff.net>
---
 commit-graph.c          | 25 +++++++++++++------------
 t/t5318-commit-graph.sh |  1 +
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 094814c2ba..4ba523cd15 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -277,8 +277,6 @@ struct commit_graph *load_commit_graph_one_fd_st(struct repository *r,
 
 static int verify_commit_graph_lite(struct commit_graph *g)
 {
-	int i;
-
 	/*
 	 * Basic validation shared between parse_commit_graph()
 	 * which'll be called every time the graph is used, and the
@@ -291,27 +289,30 @@ static int verify_commit_graph_lite(struct commit_graph *g)
 	 * over g->num_commits, or runs a checksum on the commit-graph
 	 * itself.
 	 */
-	for (i = 0; i < 255; i++) {
-		uint32_t oid_fanout1 = ntohl(g->chunk_oid_fanout[i]);
-		uint32_t oid_fanout2 = ntohl(g->chunk_oid_fanout[i + 1]);
-
-		if (oid_fanout1 > oid_fanout2) {
-			error("commit-graph fanout values out of order");
-			return 1;
-		}
-	}
-
 	return 0;
 }
 
 static int graph_read_oid_fanout(const unsigned char *chunk_start,
 				 size_t chunk_size, void *data)
 {
 	struct commit_graph *g = data;
+	int i;
+
 	if (chunk_size != 256 * sizeof(uint32_t))
 		return error("commit-graph oid fanout chunk is wrong size");
 	g->chunk_oid_fanout = (const uint32_t *)chunk_start;
 	g->num_commits = ntohl(g->chunk_oid_fanout[255]);
+
+	for (i = 0; i < 255; i++) {
+		uint32_t oid_fanout1 = ntohl(g->chunk_oid_fanout[i]);
+		uint32_t oid_fanout2 = ntohl(g->chunk_oid_fanout[i + 1]);
+
+		if (oid_fanout1 > oid_fanout2) {
+			error("commit-graph fanout values out of order");
+			return 1;
+		}
+	}
+
 	return 0;
 }
 
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 8bd7fcefb5..7fe7c72a87 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -867,6 +867,7 @@ test_expect_success 'reader notices out-of-bounds fanout' '
 	check_corrupt_chunk OIDF 0 $(printf "%02x000000" $(test_seq 0 254)) &&
 	cat >expect.err <<-\EOF &&
 	error: commit-graph fanout values out of order
+	error: commit-graph required OID fanout chunk missing or corrupted
 	EOF
 	test_cmp expect.err err
 '
-- 
2.43.0.rc1.572.g273fc7bed6

