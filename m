Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D724C7F
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 07:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676FD1727
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 23:03:12 -0800 (PST)
Received: (qmail 25203 invoked by uid 109); 9 Nov 2023 07:03:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Nov 2023 07:03:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20239 invoked by uid 111); 9 Nov 2023 07:03:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Nov 2023 02:03:15 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 9 Nov 2023 02:03:10 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 0/9] some more chunk-file bounds-checks fixes
Message-ID: <20231109070310.GA2697602@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

This is a follow-up to the series from:

  https://lore.kernel.org/git/20231009205544.GA3281950@coredump.intra.peff.net/

which was merged to master as jk/chunk-bounds. There were a few issues
left open by that series and its review:

  1. the midx code didn't check fanout ordering

  2. whether we needed to sprinkle some more st_mult() on it

  3. improving some of the error messages (translations, some
     consistency, maybe more details)

  4. possible refactoring with a pair_chunk_expect() API (Taylor posted
     a series in that direction, which is currently in limbo)

The patches here fix the remaining correctness issues (points 1 and 2,
along with a few other small issues I found). There's some improvement
on 3, but I stopped short of adding lots more details. Partially because
the series was already getting big, and partially because going further
may depend on what we do with 4.

With regards to the pair_chunk_expect() thing, this series is
incompatible (textually, but not conceptually) with what Taylor posted
earlier, just because I'm moving some checks into the chunk-reader
callbacks. Because it's fixing user-visible bugs, I think we'd want to
do this first, and then (possibly) rebase Taylor's series on top. But I
also think some of the things I noticed around overflow (especially
patches 1 and 6) may inform how we'd want the pair_chunk_expect() API to
look.

This is a continuation of the jk/chunk-bounds topic, which is new in the
v2.43 cycle. But it should be OK to leave this until after the release.
Nothing here is fixing a regression in the 2.43 release candidates; it's
just a few bits that were incomplete. That said, I did try to float the
correctness bits to the first two patches just in case. ;)

  [1/9]: commit-graph: handle overflow in chunk_size checks
  [2/9]: midx: check consistency of fanout table
  [3/9]: commit-graph: drop redundant call to "lite" verification
  [4/9]: commit-graph: clarify missing-chunk error messages
  [5/9]: commit-graph: abort as soon as we see a bogus chunk
  [6/9]: commit-graph: use fanout value for graph size
  [7/9]: commit-graph: check order while reading fanout chunk
  [8/9]: commit-graph: drop verify_commit_graph_lite()
  [9/9]: commit-graph: mark chunk error messages for translation

 commit-graph.c              | 94 +++++++++++++------------------------
 midx.c                      | 20 ++++----
 t/t5318-commit-graph.sh     | 16 ++++---
 t/t5319-multi-pack-index.sh | 14 ++++++
 4 files changed, 67 insertions(+), 77 deletions(-)

-Peff
