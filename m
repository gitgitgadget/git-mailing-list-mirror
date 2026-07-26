Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424262737F9
	for <git@vger.kernel.org>; Sun, 26 Jul 2026 08:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785055628; cv=none; b=gXQ0dVZ9b0IJnU0IBzYnriwuffulIKQ4sy+0HcE3IgHaErubRDFLMOc676L+11LmltAgtkhlUcAkjRzVdZa7U/d/UHmBRPtJQwJxik1nnueahEPS/sa/uEore9rXCsV5SuJgCBJfDmoAvi3cnO81eePTeXtV1H5Bu67ea6syze4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785055628; c=relaxed/simple;
	bh=W5zA7zeTfFzTuWgkP9CqV8cmINGmrGe5en4Mw0AU+l0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IgtusNOPRQlBCu/1aM6rIPesvQ/xuszl/aPvZgpFyBPqfuvYr5EGpYZtmvbG3vQe55n0GYCZmLhNO7pIHtxx00IVDcwIaXZhxuOrPwYjsbePus3TVHFJvWmSIBhLr1qJJlXzPw/urUgqCpdWv0TXCJtQiUGQLw84aBKzEOa7kk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=SU5UNlE1; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="SU5UNlE1"
Received: (qmail 56996 invoked by uid 106); 26 Jul 2026 08:47:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=W5zA7zeTfFzTuWgkP9CqV8cmINGmrGe5en4Mw0AU+l0=; b=SU5UNlE1ceoqA6RZyGwn1X5nDP0u8YBc8K9pLwaacJoFmO+wTD80lAAHTWN3TKDbKGba3xKTiUn3h3fbiSFFfm/QYAhxbA2OcGT46Z66fN7hykCsTiYthD2ZNbXBfgS/prHCd+rN5wWKRRp1vx1znBZ1/8ktvNHdwYxFETPryC/Evr7c8tvhDgQx5tsf+bioPetv5/ErOZjc/mgkuLfUxy3IRJ9vjZmquGEKdpNN3Oj3Z/0sNRBAL1WssuUW03NflXH/t1Af4cbwBkWE8TqNKuM88Jo59VmdoBsI5gpksI1/v8Q4A1ETqCrAd2jd6BRXlOAi5hZtMlpb+nhcdkMx6w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 26 Jul 2026 08:47:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 57972 invoked by uid 111); 26 Jul 2026 08:47:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 26 Jul 2026 04:47:10 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 26 Jul 2026 04:47:05 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: [PATCH 2/2] diff-lib: skip paths outside prefix in oneway_diff()
Message-ID: <20260726084705.GB3529698@coredump.intra.peff.net>
References: <20260726084550.GC2366012@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260726084550.GC2366012@coredump.intra.peff.net>

Commit 8174627b3d (diff-lib: ignore paths that are outside $cwd if
--relative asked, 2021-08-22) taught run_diff_files() to skip entries
outside the requested prefix before processing them.

Do the same in oneway_diff(), which handles the diff-index code path.
The lower-level diff queue functions already reject such paths, but
checking here avoids unnecessary work and keeps them out of every
do_oneway_diff() code path.

Signed-off-by: Jeff King <peff@peff.net>
---
 diff-lib.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/diff-lib.c b/diff-lib.c
index 95f920a9a0..9986f5b141 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -528,6 +528,11 @@ static int oneway_diff(const struct cache_entry * const *src,
 	if (tree == o->df_conflict_entry)
 		tree = NULL;
 
+	if (revs->diffopt.prefix &&
+	    strncmp((idx ? idx : tree)->name, revs->diffopt.prefix,
+		    revs->diffopt.prefix_length))
+		return 0;
+
 	if (ce_path_match(revs->diffopt.repo->index,
 			  idx ? idx : tree,
 			  &revs->prune_data, NULL)) {
-- 
2.55.0.742.gf2bff09aa6
