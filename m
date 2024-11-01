Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F843C13C
	for <git@vger.kernel.org>; Fri,  1 Nov 2024 12:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730463378; cv=none; b=RX+Ri4JuFhtwp986ITPtq5ldEfufrzI/RJoSMkEcx8Uc6pp18ynafjpo3jLc+z46vbM8943S4H4ojfa3zY2WMIQyAUVovNFWmvTOE2fFedh6XYQtdgCNl0MYsapFk35Z9kA1hBE3NBFlqk2q91aPMpecH5J4eCo0u8SOIRYm3GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730463378; c=relaxed/simple;
	bh=usw6WeDTNuUzMzS5JEbNtzCGtiKyWIQOUPCEOnXpBFA=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AQvOi7Lxo+sWaME74oNJVjFBsUrn4QvFgIrMPFLqHfRZRkh6YALBcTD4ydixgVWFeghjkTPPFCcpYspufA25CxJLxGuzEUcZ/CODrrvR7ft15YYtFUo5EyI2uGNGyFEpYtaw8b+sr3S9WvzSLDuo8a2KvY6uwLx7zhtjNxyH3Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=YSaOml2Z; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="YSaOml2Z"
Received: (qmail 28161 invoked by uid 109); 1 Nov 2024 12:16:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:subject:message-id:mime-version:content-type; s=20240930; bh=usw6WeDTNuUzMzS5JEbNtzCGtiKyWIQOUPCEOnXpBFA=; b=YSaOml2Zcchzvq3Nngd/t+nET7YkePISp5E8ZMq5QStO30bNT+cXw+Dazwl1jeedZCPxgyLsOanwaPwQBLSJvR57lIPX+pFRUunLLZgxwiGOjJZcrN88Igo5+2pQ7oX4h2aiPJQdF1E/zqMgHpefg93mYJHUYANh0woAGPTkxcJlakPzkQCS6s51+/gRZ57GjOWI4ARxqhjAOFuMtPYHN9JMlY9jCXq0EKW8jqUNR7bg5fOKkrW5UKyCmL5AF70OMo/jOvwz+Pu3bFOZ9E+RqyRARlWud/EWkNJO4jA/xDkRAuItuGPyI6AvUosz+uWMi4HDE8C5eFN/hQOEB11gcQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 01 Nov 2024 12:16:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12550 invoked by uid 111); 1 Nov 2024 12:16:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 01 Nov 2024 08:16:06 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 1 Nov 2024 08:16:06 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH] rev-list: skip bitmap traversal for --left-right
Message-ID: <20241101121606.GA2327410@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Running:

  git rev-list --left-right --use-bitmap-index one...two

will produce output without any left-right markers, since the bitmap
traversal returns only a single set of reachable commits. Instead we
should refuse to use bitmaps here and produce the correct output using a
traditional traversal.

This is probably not the only remaining option that misbehaves with
bitmaps, but it's particularly egregious in that it feels like it
_could_ work. Doing two separate traversals for the left/right sides and
then taking the symmetric set differences should yield the correct
answer, but our traversal code doesn't know how to do that.

It's not clear if naively doing two separate traversals would always be
a performance win. A traditional traversal only needs to walk down to
the merge base, but bitmaps always fill out the full reachability set.
So depending on your bitmap coverage, we could end up walking old bits
of history twice to fill out the same uninteresting bits on both sides.
We'd also of course end up with a very large --boundary set, if the user
asked for that.

So this might or might not be something worth implementing later. But
for now, let's make sure we don't produce the wrong answer if somebody
tries it.

The test covers this, but also the same thing with "--count" (which is
what I originally tried in a real-world case). Ironically the
try_bitmap_count() code already realizes that "--left-right" won't work
there. But that just causes us to fall back to the regular bitmap
traversal code, which itself doesn't handle counting (we produce a list
of objects rather than a count).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/rev-list.c      |  7 +++++++
 t/t5310-pack-bitmaps.sh | 12 ++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index f62bcbf2b1..3078787115 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -485,6 +485,13 @@ static int try_bitmap_traversal(struct rev_info *revs,
 	if (revs->max_count >= 0)
 		return -1;
 
+	/*
+	 * We can't know which commits were left/right in a single traversal,
+	 * and we don't yet know how to traverse them separately.
+	 */
+	if (revs->left_right)
+		return -1;
+
 	bitmap_git = prepare_bitmap_walk(revs, filter_provided_objects);
 	if (!bitmap_git)
 		return -1;
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index 7044c7d7c6..6bcbea64cc 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -503,6 +503,18 @@ test_expect_success 'boundary-based traversal is used when requested' '
 	done
 '
 
+test_expect_success 'left-right not confused by bitmap index' '
+	git rev-list --left-right other...HEAD >expect &&
+	git rev-list --use-bitmap-index --left-right other...HEAD >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'left-right count not confused by bitmap-index' '
+	git rev-list --left-right --count other...HEAD >expect &&
+	git rev-list --use-bitmap-index --left-right --count other...HEAD >actual &&
+	test_cmp expect actual
+'
+
 test_bitmap_cases "pack.writeBitmapLookupTable"
 
 test_expect_success 'verify writing bitmap lookup table when enabled' '
-- 
2.47.0.441.g1a09955689
