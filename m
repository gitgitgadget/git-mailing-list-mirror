Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84534D2FE
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 07:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81252590
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 23:12:08 -0800 (PST)
Received: (qmail 25292 invoked by uid 109); 9 Nov 2023 07:12:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Nov 2023 07:12:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20580 invoked by uid 111); 9 Nov 2023 07:12:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Nov 2023 02:12:12 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 9 Nov 2023 02:12:07 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 2/9] midx: check consistency of fanout table
Message-ID: <20231109071207.GB2698043@coredump.intra.peff.net>
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

The commit-graph, midx, and pack idx on-disk formats all have oid fanout
tables which are fed to bsearch_hash(). If these tables do not increase
monotonically, then the binary search may not only produce bogus values,
it may cause out of bounds reads.

We fixed this for commit graphs in 4169d89645 (commit-graph: check
consistency of fanout table, 2023-10-09). That commit argued that we did
not need to do the same for midx and pack idx files, because they
already did this check. However, that is wrong. We _do_ check the fanout
table for pack idx files when we load them, but we only do so for midx
files when running "git multi-pack-index verify". So it is possible to
get an out-of-bounds read by running a normal command with a specially
crafted midx file.

Let's fix this using the same solution (and roughly the same test) we
did for the commit-graph in 4169d89645. This replaces the same check
from "multi-pack-index verify", because verify uses the same read
routines, we'd bail on reading the midx much sooner now. So let's make
sure to copy its verbose error message.

Signed-off-by: Jeff King <peff@peff.net>
---
 midx.c                      | 20 +++++++++++---------
 t/t5319-multi-pack-index.sh | 14 ++++++++++++++
 2 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/midx.c b/midx.c
index 2f3863c936..1d14661dad 100644
--- a/midx.c
+++ b/midx.c
@@ -64,13 +64,24 @@ void get_midx_rev_filename(struct strbuf *out, struct multi_pack_index *m)
 static int midx_read_oid_fanout(const unsigned char *chunk_start,
 				size_t chunk_size, void *data)
 {
+	int i;
 	struct multi_pack_index *m = data;
 	m->chunk_oid_fanout = (uint32_t *)chunk_start;
 
 	if (chunk_size != 4 * 256) {
 		error(_("multi-pack-index OID fanout is of the wrong size"));
 		return 1;
 	}
+	for (i = 0; i < 255; i++) {
+		uint32_t oid_fanout1 = ntohl(m->chunk_oid_fanout[i]);
+		uint32_t oid_fanout2 = ntohl(m->chunk_oid_fanout[i+1]);
+
+		if (oid_fanout1 > oid_fanout2) {
+			error(_("oid fanout out of order: fanout[%d] = %"PRIx32" > %"PRIx32" = fanout[%d]"),
+			      i, oid_fanout1, oid_fanout2, i + 1);
+			return 1;
+		}
+	}
 	m->num_objects = ntohl(m->chunk_oid_fanout[255]);
 	return 0;
 }
@@ -1782,15 +1793,6 @@ int verify_midx_file(struct repository *r, const char *object_dir, unsigned flag
 	}
 	stop_progress(&progress);
 
-	for (i = 0; i < 255; i++) {
-		uint32_t oid_fanout1 = ntohl(m->chunk_oid_fanout[i]);
-		uint32_t oid_fanout2 = ntohl(m->chunk_oid_fanout[i + 1]);
-
-		if (oid_fanout1 > oid_fanout2)
-			midx_report(_("oid fanout out of order: fanout[%d] = %"PRIx32" > %"PRIx32" = fanout[%d]"),
-				    i, oid_fanout1, oid_fanout2, i + 1);
-	}
-
 	if (m->num_objects == 0) {
 		midx_report(_("the midx contains no oid"));
 		/*
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index c4c6060cee..c20aafe99a 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -1157,4 +1157,18 @@ test_expect_success 'reader notices too-small revindex chunk' '
 	test_cmp expect.err err
 '
 
+test_expect_success 'reader notices out-of-bounds fanout' '
+	# This is similar to the out-of-bounds fanout test in t5318. The values
+	# in adjacent entries should be large but not identical (they
+	# are used as hi/lo starts for a binary search, which would then abort
+	# immediately).
+	corrupt_chunk OIDF 0 $(printf "%02x000000" $(test_seq 0 254)) &&
+	test_must_fail git log 2>err &&
+	cat >expect <<-\EOF &&
+	error: oid fanout out of order: fanout[254] = fe000000 > 5c = fanout[255]
+	fatal: multi-pack-index required OID fanout chunk missing or corrupted
+	EOF
+	test_cmp expect err
+'
+
 test_done
-- 
2.43.0.rc1.572.g273fc7bed6

