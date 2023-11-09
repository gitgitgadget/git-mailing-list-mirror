Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8176AA7
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 07:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B076A2590
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 23:13:13 -0800 (PST)
Received: (qmail 25347 invoked by uid 109); 9 Nov 2023 07:13:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Nov 2023 07:13:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20605 invoked by uid 111); 9 Nov 2023 07:13:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Nov 2023 02:13:17 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 9 Nov 2023 02:13:12 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 3/9] commit-graph: drop redundant call to "lite" verification
Message-ID: <20231109071312.GC2698043@coredump.intra.peff.net>
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

The idea of verify_commit_graph_lite() is to have cheap verification
checks both for everyday use of the graph files (to avoid out of bounds
reads, etc) as well as for doing a full check via "commit-graph verify"
(which will also check the hash, etc).

But the expensive verification checks operate on a commit_graph struct,
which we get by using the normal everyday-reader code! So any problem
we'd find by calling it would have been found before we even got to the
verify_one_commit_graph() function.

Removing it simplifies the code a bit, but also frees us up to move the
"lite" verification steps around within that everyday-reader code.

Signed-off-by: Jeff King <peff@peff.net>
---
 commit-graph.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 5d7d7a89e5..d9fc08de86 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -2690,10 +2690,6 @@ static int verify_one_commit_graph(struct repository *r,
 	struct commit *seen_gen_zero = NULL;
 	struct commit *seen_gen_non_zero = NULL;
 
-	verify_commit_graph_error = verify_commit_graph_lite(g);
-	if (verify_commit_graph_error)
-		return verify_commit_graph_error;
-
 	if (!commit_graph_checksum_valid(g)) {
 		graph_report(_("the commit-graph file has incorrect checksum and is likely corrupt"));
 		verify_commit_graph_error = VERIFY_COMMIT_GRAPH_ERROR_HASH;
-- 
2.43.0.rc1.572.g273fc7bed6

