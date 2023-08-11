Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A508C0015E
	for <git@archiver.kernel.org>; Fri, 11 Aug 2023 17:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233979AbjHKR65 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 13:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjHKR64 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 13:58:56 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B616C10F
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 10:58:55 -0700 (PDT)
Received: (qmail 28475 invoked by uid 109); 11 Aug 2023 17:58:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 11 Aug 2023 17:58:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28503 invoked by uid 111); 11 Aug 2023 17:58:54 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 11 Aug 2023 13:58:54 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 11 Aug 2023 13:58:54 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 0/5] commit-graph: fsck zero/non-zero generation
 number fixes
Message-ID: <20230811175854.GA2816191@coredump.intra.peff.net>
References: <ZNUiEXF5CP6WMk9A@nand.local>
 <cover.1691773533.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1691773533.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 11, 2023 at 01:05:39PM -0400, Taylor Blau wrote:

> Here's a small reroll of a series that I sent which expanded on a patch
> that Peff sent earlier in the thread to remove a section of unreachable
> code that was noticed by Coverity in the `verify_one_commit_graph()`
> function.
> 
> Everything is the same in the first three patches. The fourth patch is
> slightly modified to (in addition to flipping the conditional) extract
> the mixed zero/non-zero generation number checks out to its own
> function.
> 
> The fifth patch is new, and avoids repeatedly warning about mixed
> generation numbers by treating `generation_zero` as a bitfield.

This all looks correct to me. Let me show what I thought the result
might look like, just because I think the result is a bit simpler.  We
may be hitting diminishing returns on refactoring here, though, so if
you're not wildly impressed, I'm happy enough if we go with what you've
written.

This applies on top of yours, but probably would replace patches 2, 4,
and 5 (the flip-flop case isn't even really worth testing after this,
since the message can obviously only be shown once).

 commit-graph.c          | 42 +++++++++--------------------------
 t/t5318-commit-graph.sh | 18 ++-------------
 2 files changed, 13 insertions(+), 47 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 8d924b4509..079bbc8598 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -2560,45 +2560,19 @@ static void graph_report(const char *fmt, ...)
 	va_end(ap);
 }
 
-#define GENERATION_ZERO_EXISTS 1
-#define GENERATION_NUMBER_EXISTS 2
-#define GENERATION_NUMBER_BOTH_EXIST \
-	(GENERATION_ZERO_EXISTS | GENERATION_NUMBER_EXISTS)
-
 static int commit_graph_checksum_valid(struct commit_graph *g)
 {
 	return hashfile_checksum_valid(g->data, g->data_len);
 }
 
-static void verify_mixed_generation_numbers(struct commit_graph *g,
-					    struct commit *graph_commit,
-					    int *generation_zero)
-{
-	if (commit_graph_generation_from_graph(graph_commit)) {
-		if (*generation_zero & GENERATION_ZERO_EXISTS)
-			graph_report(_("commit-graph has non-zero generation "
-				       "number for commit %s, but zero "
-				       "elsewhere"),
-				     oid_to_hex(&graph_commit->object.oid));
-		*generation_zero |= GENERATION_NUMBER_EXISTS;
-	} else {
-		if (*generation_zero & GENERATION_NUMBER_EXISTS)
-			graph_report(_("commit-graph has generation number "
-				       "zero for commit %s, but non-zero "
-				       "elsewhere"),
-				     oid_to_hex(&graph_commit->object.oid));
-		*generation_zero |= GENERATION_ZERO_EXISTS;
-	}
-}
-
 static int verify_one_commit_graph(struct repository *r,
 				   struct commit_graph *g,
 				   struct progress *progress,
 				   uint64_t *seen)
 {
 	uint32_t i, cur_fanout_pos = 0;
 	struct object_id prev_oid, cur_oid;
-	int generation_zero = 0;
+	struct commit *seen_gen_zero = NULL, *seen_gen_non_zero = NULL;
 
 	verify_commit_graph_error = verify_commit_graph_lite(g);
 	if (verify_commit_graph_error)
@@ -2704,11 +2678,12 @@ static int verify_one_commit_graph(struct repository *r,
 			graph_report(_("commit-graph parent list for commit %s terminates early"),
 				     oid_to_hex(&cur_oid));
 
-		if (generation_zero != GENERATION_NUMBER_BOTH_EXIST)
-			verify_mixed_generation_numbers(g, graph_commit,
-							&generation_zero);
+		if (!commit_graph_generation_from_graph(graph_commit))
+			seen_gen_zero = graph_commit;
+		else
+			seen_gen_non_zero = graph_commit;
 
-		if (generation_zero & GENERATION_ZERO_EXISTS)
+		if (seen_gen_zero)
 			continue;
 
 		/*
@@ -2734,6 +2709,11 @@ static int verify_one_commit_graph(struct repository *r,
 				     odb_commit->date);
 	}
 
+	if (seen_gen_zero && seen_gen_non_zero)
+		graph_report(_("commit-graph has both zero and non-zero generations (e.g., commits %s and %s"),
+			     oid_to_hex(&seen_gen_zero->object.oid),
+			     oid_to_hex(&seen_gen_non_zero->object.oid));
+
 	return verify_commit_graph_error;
 }
 
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 2626d41c94..ca5e2c87ae 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -620,26 +620,12 @@ test_expect_success 'detect incorrect chunk count' '
 
 test_expect_success 'detect mixed generation numbers (non-zero to zero)' '
 	corrupt_graph_and_verify $GRAPH_BYTE_COMMIT_GENERATION_LAST "\0\0\0\0" \
-		"but non-zero elsewhere"
+		"both zero and non-zero"
 '
 
 test_expect_success 'detect mixed generation numbers (zero to non-zero)' '
 	corrupt_graph_and_verify $GRAPH_BYTE_COMMIT_GENERATION "\0\0\0\0" \
-		"but zero elsewhere"
-'
-
-test_expect_success 'detect mixed generation numbers (flip-flop)' '
-	corrupt_graph_setup &&
-	for pos in \
-		$GRAPH_BYTE_COMMIT_GENERATION \
-		$GRAPH_BYTE_COMMIT_GENERATION_LAST
-	do
-		printf "\0\0\0\0" | dd of="full/$objdir/info/commit-graph" bs=1 \
-		seek="$pos" conv=notrunc || return 1
-	done &&
-
-	test_must_fail git -C full commit-graph verify 2>err &&
-	test 1 -eq "$(grep -c "generation number" err)"
+		"both zero and non-zero"
 '
 
 test_expect_success 'git fsck (checks commit-graph when config set to true)' '
