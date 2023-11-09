Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D4DD532
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 07:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49EE42126
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 23:24:37 -0800 (PST)
Received: (qmail 25484 invoked by uid 109); 9 Nov 2023 07:24:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Nov 2023 07:24:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20872 invoked by uid 111); 9 Nov 2023 07:24:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Nov 2023 02:24:40 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 9 Nov 2023 02:24:35 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 6/9] commit-graph: use fanout value for graph size
Message-ID: <20231109072435.GF2698043@coredump.intra.peff.net>
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

Commit-graph, midx, and pack idx files all have both a lookup table of
oids and an oid fanout table. In midx and pack idx files, we take the
final entry of the fanout table as the source of truth for the number of
entries, and then verify that the size of the lookup table matches that.
But for commit-graph files, we do the opposite: we use the size of the
lookup table as the source of truth, and then check the final fanout
entry against it.

As noted in 4169d89645 (commit-graph: check consistency of fanout
table, 2023-10-09), either is correct. But there are a few reasons to
prefer the fanout table as the source of truth:

  1. The fanout entries are 32-bits on disk, and that defines the
     maximum number of entries we can store. But since the size of the
     lookup table is only bounded by the filesystem, it can be much
     larger. And hence computing it as the commit-graph does means that
     we may truncate the result when storing it in a uint32_t.

  2. We read the fanout first, then the lookup table. If we're verifying
     the chunks as we read them, then we'd want to take the fanout as
     truth (we have nothing yet to check it against) and then we can
     check that the lookup table matches what we already know.

  3. It is pointlessly inconsistent with the midx and pack idx code.
     Since the three have to do similar size and bounds checks, it is
     easier to reason about all three if they use the same approach.

So this patch moves the assignment of g->num_commits to the fanout
parser, and then we can check the size of the lookup chunk as soon as we
try to load it.

There's already a test covering this situation, which munges the final
fanout entry to 2^32-1. In the current code we complain that it does not
agree with the table size. But now that we treat the munged value as the
source of truth, we'll complain that the lookup table is the wrong size
(again, either is correct). So we'll have to update the message we
expect (and likewise for an earlier test which does similar munging).

There's a similar test for this situation on the midx side, but rather
than making a very-large fanout value, it just truncates the lookup
table. We could do that here, too, but the very-large fanout value
actually shows an interesting corner case. On a 32-bit system,
multiplying to find the expected table size would cause an integer
overflow. Using st_mult() would detect that, but cause us to die()
rather than falling back to the non-graph code path. Checking the size
using division (as we do with existing chunk-size checks) avoids the
overflow entirely, and the test demonstrates this when run on a 32-bit
system.

Signed-off-by: Jeff King <peff@peff.net>
---
 commit-graph.c          | 8 +++-----
 t/t5318-commit-graph.sh | 5 +++--
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 374575b484..094814c2ba 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -300,10 +300,6 @@ static int verify_commit_graph_lite(struct commit_graph *g)
 			return 1;
 		}
 	}
-	if (ntohl(g->chunk_oid_fanout[255]) != g->num_commits) {
-		error("commit-graph oid table and fanout disagree on size");
-		return 1;
-	}
 
 	return 0;
 }
@@ -315,6 +311,7 @@ static int graph_read_oid_fanout(const unsigned char *chunk_start,
 	if (chunk_size != 256 * sizeof(uint32_t))
 		return error("commit-graph oid fanout chunk is wrong size");
 	g->chunk_oid_fanout = (const uint32_t *)chunk_start;
+	g->num_commits = ntohl(g->chunk_oid_fanout[255]);
 	return 0;
 }
 
@@ -323,7 +320,8 @@ static int graph_read_oid_lookup(const unsigned char *chunk_start,
 {
 	struct commit_graph *g = data;
 	g->chunk_oid_lookup = chunk_start;
-	g->num_commits = chunk_size / g->hash_len;
+	if (chunk_size / g->hash_len != g->num_commits)
+		return error(_("commit-graph OID lookup chunk is the wrong size"));
 	return 0;
 }
 
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index affb959d64..8bd7fcefb5 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -560,7 +560,7 @@ test_expect_success 'detect incorrect fanout' '
 
 test_expect_success 'detect incorrect fanout final value' '
 	corrupt_graph_and_verify $GRAPH_BYTE_FANOUT2 "\01" \
-		"oid table and fanout disagree on size"
+		"OID lookup chunk is the wrong size"
 '
 
 test_expect_success 'detect incorrect OID order' '
@@ -850,7 +850,8 @@ test_expect_success 'reader notices too-small oid fanout chunk' '
 test_expect_success 'reader notices fanout/lookup table mismatch' '
 	check_corrupt_chunk OIDF 1020 "FFFFFFFF" &&
 	cat >expect.err <<-\EOF &&
-	error: commit-graph oid table and fanout disagree on size
+	error: commit-graph OID lookup chunk is the wrong size
+	error: commit-graph required OID lookup chunk missing or corrupted
 	EOF
 	test_cmp expect.err err
 '
-- 
2.43.0.rc1.572.g273fc7bed6

