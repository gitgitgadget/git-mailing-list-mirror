Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B621474A9
	for <git@vger.kernel.org>; Thu,  9 Jan 2025 08:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736411302; cv=none; b=Jx4yobPVnDoN/9Ve78NbWWiMj9tasOwW7XZJCEwkL0icyRJdfQnwr+KkTrN9KrPovJ2EsdyhPVi682FAu8K84YpLl93fpKMeZrDKVxyZ1zsBmgnwYLNnwhUFrhorrNo2oS+5Navg2XP10m5yylyLBSnwdzvvc7tRva5dAdLkicU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736411302; c=relaxed/simple;
	bh=cArmnpCmd6pAC8db4ltR9mcqlveZ7lJ53Ch2qLUrZ4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gf/IlO6sneotueYpZknbuqDt6MX2CQ5fu8a3FL9877cBJRWnc6Y5Y8WCJxNbQ2duTv+IVasxOIGsPTkfWH3uwCaYhHyPnTtm2yBKw2jMCu3xtysBi1Ar90+wm7B4wzP3OoR6QSOXgjyExsuAv3YhMPS47KKYZzhSUowGypJoMlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=EGryqRnH; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="EGryqRnH"
Received: (qmail 25590 invoked by uid 109); 9 Jan 2025 08:28:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=cArmnpCmd6pAC8db4ltR9mcqlveZ7lJ53Ch2qLUrZ4s=; b=EGryqRnH49rIznR0rHuTHIRdIvMyo5HVv+L7y40yoHF9fuaIE6ahwaZzk0ZEhrNu+qCylZau0VQMLVzHj4UPQFWs0NHTl1iYYGMYfM1XKFJpoHpNF7WqsQ7HDfUV2UP8iG3E7eAs7u9p8YL9XAFnbGxCSyRf21VP10vazIlllp5fKypXltsQCF76xyQV3GrcTsr2+pS+SpcNMZ3QPtMV/7OSh6S1s6BQ/eL7+MPnJujLAIOprRfOpwCQbH0SCm1JKOlD2dQpa3bhCfSk0h9qh3BlavpTdyNBkbCP1mC9C1o8f+eRp15kB1SzCg1pmCqUbzhvn/J3LiCjBN96zB32zA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Jan 2025 08:28:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20063 invoked by uid 111); 9 Jan 2025 08:28:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Jan 2025 03:28:19 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 9 Jan 2025 03:28:18 -0500
From: Jeff King <peff@peff.net>
To: Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Wink Saville <wink@saville.com>
Subject: [PATCH 01/14] run_diff_files(): delay allocation of combine_diff_path
Message-ID: <20250109082818.GA2748836@coredump.intra.peff.net>
References: <20250109082723.GA2748497@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250109082723.GA2748497@coredump.intra.peff.net>

While looping over the index entries, when we see a higher level stage
the first thing we do is allocate a combine_diff_path struct for it. But
this can leak; if check_removed() returns an error, we'll continue to
the next iteration of the loop without cleaning up.

We can fix this by just delaying the allocation by a few lines.

I don't think this leak is triggered in the test suite, but it's pretty
easy to see by inspection. My ulterior motive here is that the delayed
allocation means we have all of the data needed to initialize "dpath" at
the time of malloc, making it easier to factor out a constructor
function.

Signed-off-by: Jeff King <peff@peff.net>
---
 diff-lib.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index c6d3bc4d37..85b8f1fa59 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -156,18 +156,6 @@ void run_diff_files(struct rev_info *revs, unsigned int option)
 			size_t path_len;
 			struct stat st;
 
-			path_len = ce_namelen(ce);
-
-			dpath = xmalloc(combine_diff_path_size(5, path_len));
-			dpath->path = (char *) &(dpath->parent[5]);
-
-			dpath->next = NULL;
-			memcpy(dpath->path, ce->name, path_len);
-			dpath->path[path_len] = '\0';
-			oidclr(&dpath->oid, the_repository->hash_algo);
-			memset(&(dpath->parent[0]), 0,
-			       sizeof(struct combine_diff_parent)*5);
-
 			changed = check_removed(ce, &st);
 			if (!changed)
 				wt_mode = ce_mode_from_stat(ce, st.st_mode);
@@ -178,7 +166,19 @@ void run_diff_files(struct rev_info *revs, unsigned int option)
 				}
 				wt_mode = 0;
 			}
+
+			path_len = ce_namelen(ce);
+
+			dpath = xmalloc(combine_diff_path_size(5, path_len));
+			dpath->path = (char *) &(dpath->parent[5]);
+
+			dpath->next = NULL;
+			memcpy(dpath->path, ce->name, path_len);
+			dpath->path[path_len] = '\0';
+			oidclr(&dpath->oid, the_repository->hash_algo);
 			dpath->mode = wt_mode;
+			memset(&(dpath->parent[0]), 0,
+			       sizeof(struct combine_diff_parent)*5);
 
 			while (i < entries) {
 				struct cache_entry *nce = istate->cache[i];
-- 
2.48.0.rc2.413.gc1c80375a3

