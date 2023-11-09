Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51CD4C7F
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 07:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58829211D
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 23:09:49 -0800 (PST)
Received: (qmail 25253 invoked by uid 109); 9 Nov 2023 07:09:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Nov 2023 07:09:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20460 invoked by uid 111); 9 Nov 2023 07:09:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Nov 2023 02:09:52 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 9 Nov 2023 02:09:48 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 1/9] commit-graph: handle overflow in chunk_size checks
Message-ID: <20231109070948.GA2698043@coredump.intra.peff.net>
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

We check the size of chunks with fixed records by multiplying the width
of each record by the number of commits in the file. Like:

  if (chunk_size != g->num_commits * GRAPH_DATA_WIDTH)

If this multiplication overflows, we may not notice a chunk is too small
(which could later lead to out-of-bound reads).

In the current code this is only possible for the CDAT chunk, but the
reasons are quite subtle. We compute g->num_commits by dividing the size
of the OIDL chunk by the hash length (since it consists of a bunch of
hashes). So we know that any size_t multiplication that uses a value
smaller than the hash length cannot overflow. And the CDAT records are
the only ones that are larger (the others are just 4-byte records). So
it's worth fixing all of these, to make it clear that they're not
subject to overflow (without having to reason about seemingly unrelated
code).

The obvious thing to do is add an st_mult(), like:

  if (chunk_size != st_mult(g->num_commits, GRAPH_DATA_WIDTH))

And that certainly works, but it has one downside: if we detect an
overflow, we'll immediately die(). But the commit graph is an optional
file; if we run into other problems loading it, we'll generally return
an error and fall back to accessing the full objects. Using st_mult()
means a malformed file will abort the whole process.

So instead, we can do a division like this:

  if (chunk_size / GRAPH_DATA_WIDTH != g->num_commits)

where there's no possibility of overflow. We do lose a little bit of
precision; due to integer division truncation we'd allow up to an extra
GRAPH_DATA_WIDTH-1 bytes of data in the chunk. That's OK. Our main goal
here is making sure we don't have too _few_ bytes, which would cause an
out-of-bounds read (we could actually replace our "!=" with "<", but I
think it's worth being a little pedantic, as a large mismatch could be a
sign of other problems).

I didn't add a test here. We'd need to generate a very large graph file
in order to get g->num_commits large enough to cause an overflow. And a
later patch in this series will use this same division technique in a
way that is much easier to trigger in the tests.

Signed-off-by: Jeff King <peff@peff.net>
---
There are still several st_mult() calls within commit-graph.c, unrelated
to my jk/chunk-bounds series. I suspect they're all redundant, as the
chunk-size checks give a stricter bound. But checking and removing them
is a separate topic.

I think the midx code has similar st_mult() problems, but it's quite
happy to die() on any error already. So I've left auditing that for
another day.

Another alternative to the division is introducing an st_mult() variant
like:

  if (!st_mult(&out, &a, &b))
        return error(...);

We may want to go there in the long run as part of lib-ification, but I
didn't want to get into it for this series.

 commit-graph.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index ee66098e07..5d7d7a89e5 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -344,7 +344,7 @@ static int graph_read_commit_data(const unsigned char *chunk_start,
 				  size_t chunk_size, void *data)
 {
 	struct commit_graph *g = data;
-	if (chunk_size != g->num_commits * GRAPH_DATA_WIDTH)
+	if (chunk_size / GRAPH_DATA_WIDTH != g->num_commits)
 		return error("commit-graph commit data chunk is wrong size");
 	g->chunk_commit_data = chunk_start;
 	return 0;
@@ -354,7 +354,7 @@ static int graph_read_generation_data(const unsigned char *chunk_start,
 				      size_t chunk_size, void *data)
 {
 	struct commit_graph *g = data;
-	if (chunk_size != g->num_commits * sizeof(uint32_t))
+	if (chunk_size / sizeof(uint32_t) != g->num_commits)
 		return error("commit-graph generations chunk is wrong size");
 	g->chunk_generation_data = chunk_start;
 	return 0;
@@ -364,7 +364,7 @@ static int graph_read_bloom_index(const unsigned char *chunk_start,
 				  size_t chunk_size, void *data)
 {
 	struct commit_graph *g = data;
-	if (chunk_size != g->num_commits * 4) {
+	if (chunk_size / 4 != g->num_commits) {
 		warning("commit-graph changed-path index chunk is too small");
 		return -1;
 	}
-- 
2.43.0.rc1.572.g273fc7bed6

