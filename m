Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85AF3A48E6
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 06:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782888126; cv=none; b=Q2qI+F5aRfZ8kdfO8X8rdlw4YRYq7XgbxqMWNQj6HHzMNQHurWhDX/+Rgpz0lEQLwX+Ba03U6SE8UfYOazg52p7tCjMGwtIB8+vCc1wIGci0soTxF2J9IdBfpu5fOUKeiiiGtm9MGShpqn108+RfQd3DWEAuQQ+YlcgtFMRgbJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782888126; c=relaxed/simple;
	bh=5dy8Pl/+i2+mW6ZkV8V8ganH/G3bLMxnuP+9zyCodFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K0T8CVV0Hxwe2RQTNcpj+eXUMZROZpnk0GokmV3B5ioZTGJ0xISzXc2OCUAXpzjz7BFe1TqPjhsakbAsoTv/azJq/bWKVha9JQS7wY58Kx8m63M6NrnSi5Y3AgVNGyqhkb7TW8im8NmS120//35NldEtjrM9BAcPPe4uvlcQBro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=fLDlJEe3; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="fLDlJEe3"
Received: (qmail 77007 invoked by uid 106); 1 Jul 2026 06:42:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=5dy8Pl/+i2+mW6ZkV8V8ganH/G3bLMxnuP+9zyCodFQ=; b=fLDlJEe3AmxfNJ5oQjcVCzU0CpbfsLEXKSCYMfIjVfR8z4GpkdPL13nPsCDQMvpqrqL9mwH2kQCKLbV5oTwEASf/I8ozBPjtf0TjWf0MRjTxBI1RKSrqTB//wHCtSnyh/WExqYFi30zHS/QBVS9p06gmoDqfSvJrdC7VEQ6WO609NT1V1ymsLYYEmOxE4WygzdvPYD6tYNXKrL4RSjZ3SK+KN1tAkfpedgGB4WIkff5GZsD9yYopmh8Cv4DSzBIMUcEsISvq8xyQiincqi01mNkIELxwRa6nbhjfFEmT0Fyd+j3a8lmlAfKksYJLfjGel/QI5690EJrrjzsNZm9I9w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 01 Jul 2026 06:42:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 157831 invoked by uid 111); 1 Jul 2026 06:42:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 01 Jul 2026 02:42:03 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 1 Jul 2026 02:42:03 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 3/3] line-log: drop extra copy of range with bloom filters
Message-ID: <20260701064203.GC2580331@coredump.intra.peff.net>
References: <20260701063538.GA2579765@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260701063538.GA2579765@coredump.intra.peff.net>

When line_log_process_ranges_arbitrary_commit() finds out from a Bloom
filter that a commit didn't touch the path in question, it can quickly
pass its range on to the parent commit.

It does so by making a copy of the range, and passing that copy to
add_line_range(). But add_line_range() already makes its own copy
(either directly, or by merging with an existing range for that parent).
So the copy we make is leaked.

We can plug the leak by just passing our range directly, without the
extra copy.

The bug goes back to f32dde8c12 (line-log: integrate with changed-path
Bloom filters, 2020-05-11). We didn't notice because the test suite
never explicitly combines these features! You can observe it by building
with SANITIZE=leak and running t4211 with some extra flags:

  GIT_TEST_COMMIT_GRAPH=1 \
  GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=1 \
  ./t4211-line-log.sh

It would probably be useful to have some more targeted test coverage of
these features together. But I don't think there's much point in just
blindly copying the existing tests and adding bloom-filter support. We
already do that via the linux-TEST-vars CI job. We just don't run the
leak-checking build with those flags (so if there were a correctness
problem, we'd have noticed, just not a leak).

So I think we'd benefit from somebody clueful thinking about the
interaction of these features and testing the corner cases. But for the
purposes of this leak fix, I think we can just rely on the recipe above
(and consider running an extra leak-test job with more TEST-vars set).

Signed-off-by: Jeff King <peff@peff.net>
---
 line-log.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/line-log.c b/line-log.c
index 5fc75ae275..0179f138f7 100644
--- a/line-log.c
+++ b/line-log.c
@@ -1141,8 +1141,7 @@ int line_log_process_ranges_arbitrary_commit(struct rev_info *rev, struct commit
 
 	if (range) {
 		if (commit->parents && !bloom_filter_check(rev, commit, range)) {
-			struct line_log_data *prange = line_log_data_copy(range);
-			add_line_range(rev, commit->parents->item, prange);
+			add_line_range(rev, commit->parents->item, range);
 			clear_commit_line_range(rev, commit);
 		} else if (commit->parents && commit->parents->next)
 			changed = process_ranges_merge_commit(rev, commit, range);
-- 
2.55.0.394.gcf1c5597d2
