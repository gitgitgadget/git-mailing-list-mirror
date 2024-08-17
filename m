Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6095A83A06
	for <git@vger.kernel.org>; Sat, 17 Aug 2024 07:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723879781; cv=none; b=Pkf82KZB6HhDzxJNpabyp31DLhfI9CO1gcygRvHmI7mTbgN14MNNUdXhtUF39zAUPflzhO6eXwFEN8ZHejS/g9vDAUUQmIFGaage7jkfTtmdKl0ADQduLoan9d19rwRq3zCN0hh0oRYCfHJSzk+7iyu52uDmBzutwLV9I6hqy74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723879781; c=relaxed/simple;
	bh=xA23hBW1h6exUVtVn11HXbb7CfdyletrlSKyC0veqfE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fsLxzCfagn/YYDlTIt/huGZb13vccak2f/y+eq4i5WlBO0Q7ab1dXscvo/dDkzyvZPiWp7hsDZyM49qk+LOhjIiwJaa7SjKIJO8vL93iiTkbF6lq3hrPHKVDaiG7E+l1KC+dzVb/cDECOyheOI4dFbl3JgZAtiWMe2in3sxD61c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 23586 invoked by uid 109); 17 Aug 2024 07:29:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 17 Aug 2024 07:29:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27575 invoked by uid 111); 17 Aug 2024 07:29:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 17 Aug 2024 03:29:42 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 17 Aug 2024 03:29:37 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 3/5] pack-bitmap: drop unused parameters from
 select_pseudo_merges()
Message-ID: <20240817072937.GC1535915@coredump.intra.peff.net>
References: <20240817072621.GA1535666@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240817072621.GA1535666@coredump.intra.peff.net>

We take the array of indexed_commits (and its length), but there's no
need. The selection is based on ref reachability, not the linearized set
of commits we're packing.

Signed-off-by: Jeff King <peff@peff.net>
---
A careful reader may wonder whether we ought to be using the set of
commits to limit what we're willing to select (since we can't make a
bitmap for a commit that isn't in our index).

And this is indeed a problem, but the solution doesn't involve using
indexed_commits. It should be fixed in this series:

  https://lore.kernel.org/git/c9a64b1d2a9d6b3fe1f5fb0a7303e043114fcd8f.1723743050.git.me@ttaylorr.com/

 pack-bitmap-write.c | 2 +-
 pseudo-merge.c      | 3 +--
 pseudo-merge.h      | 3 +--
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 7787600234..9b9ca1cc36 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -737,7 +737,7 @@ void bitmap_writer_select_commits(struct bitmap_writer *writer,
 
 	stop_progress(&writer->progress);
 
-	select_pseudo_merges(writer, indexed_commits, indexed_commits_nr);
+	select_pseudo_merges(writer);
 }
 
 
diff --git a/pseudo-merge.c b/pseudo-merge.c
index 1d7f5381a4..c952a7cba9 100644
--- a/pseudo-merge.c
+++ b/pseudo-merge.c
@@ -425,8 +425,7 @@ static void sort_pseudo_merge_matches(struct pseudo_merge_matches *matches)
 	QSORT(matches->unstable, matches->unstable_nr, commit_date_cmp);
 }
 
-void select_pseudo_merges(struct bitmap_writer *writer,
-			  struct commit **commits, size_t commits_nr)
+void select_pseudo_merges(struct bitmap_writer *writer)
 {
 	struct progress *progress = NULL;
 	uint32_t i;
diff --git a/pseudo-merge.h b/pseudo-merge.h
index 3aecba772b..4b5febaa63 100644
--- a/pseudo-merge.h
+++ b/pseudo-merge.h
@@ -95,8 +95,7 @@ struct pseudo_merge_commit_idx {
  *
  * Optionally shows a progress meter.
  */
-void select_pseudo_merges(struct bitmap_writer *writer,
-			  struct commit **commits, size_t commits_nr);
+void select_pseudo_merges(struct bitmap_writer *writer);
 
 /*
  * Represents a serialized view of a file containing pseudo-merge(s)
-- 
2.46.0.585.gd6679c16d8

