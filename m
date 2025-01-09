Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16F31AA781
	for <git@vger.kernel.org>; Thu,  9 Jan 2025 08:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736412848; cv=none; b=IrBE6jSuuxkmuJdtBMBYNSgPSwy8hBgMYe4zLWxNTw2E5fODZiRyymWNcCyXxgsko41yJ7dh6xBqLzf0jl0WLbsnc9q9pCB4fj8EltZkbhjTau28Rbsud6lhvzi5vOEkvbHnvlbuYBtba3rI2JODD+ZHLHvpX9PPLT7JB9iamUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736412848; c=relaxed/simple;
	bh=f9zfJVlcFITIzi5YsgeYJ6NO9Av9Ldj+N/k5qUJepcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qNBTNF9tBkkSP+MxIfi+T12qbRh1LRBNW6Fwk97BUNZtX8pqyBpnMDJxiLCWxw20/v3ZtToyhZGefewU1pBwivM7nhfevbxeIEK9O+rhCueuSOoPXnhVqedDfCM2IHEbKNXgu9/G6ibBt74/r+/Hdv4SxJKsseTc2udBhbBcncg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=AiI46p4p; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="AiI46p4p"
Received: (qmail 25772 invoked by uid 109); 9 Jan 2025 08:54:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=f9zfJVlcFITIzi5YsgeYJ6NO9Av9Ldj+N/k5qUJepcQ=; b=AiI46p4p7fM5wbYl/mcyNTJ9eqelCKRPtI1VV3oFZh8j+L9M7YQKtnmvcsw/8cKqMhHhUrKCfu8MweidmoB/LnCmGs89xNmdN2p/lrHPRA8BKxBXcxiCNXKA0TmRaXLbSxhE1BbUjnXn7/ODGpRI3vsd87/n+a5uVgo6CJoZzeF1vw+SIuEKO9F5VHjGzr+WTrAbj598MgnFcIes5KD9QwO0UZFgpQiO2qc2HyIsNtPTun9wF67Yzz53I0FDzQ4kseKdIGw9CZOx0FNQ7ltpvYQHYksatgo+LTAaS3ztl2xQ0CHWtpTDK5WOoOECiq5I+312+L8bdd5tzj2HT8wTpw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Jan 2025 08:54:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20430 invoked by uid 111); 9 Jan 2025 08:54:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Jan 2025 03:54:05 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 9 Jan 2025 03:54:05 -0500
From: Jeff King <peff@peff.net>
To: Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Wink Saville <wink@saville.com>
Subject: [PATCH 13/14] tree-diff: simplify emit_path() list management
Message-ID: <20250109085405.GM2748836@coredump.intra.peff.net>
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

In emit_path() we may append a new combine_diff_path entry to our list,
decide that we don't want it (because opt->pathchange() told us so) and
then roll it back.

Between the addition and the rollback, it doesn't matter if it's in the
list or not (no functions can even tell, since it's a singly-linked list
and we pass around just the tail entry).

So it's much simpler to just wait until opt->pathchange() tells us
whether to keep it, and either attach it (or free it) then. We do still
have to allocate it up front since it's that struct itself which is
passed to the pathchange callback.

Signed-off-by: Jeff King <peff@peff.net>
---
 tree-diff.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/tree-diff.c b/tree-diff.c
index a1a611bef6..f5ec19113c 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -177,14 +177,12 @@ static struct combine_diff_path *emit_path(struct combine_diff_path *tail,
 
 	if (emitthis) {
 		int keep;
-		struct combine_diff_path *pprev = tail, *p;
+		struct combine_diff_path *p;
 
 		strbuf_add(base, path, pathlen);
 		p = combine_diff_path_new(base->buf, base->len, mode,
 					  oid ? oid : null_oid(),
 					  nparent);
-		tail->next = p;
-		tail = p;
 		strbuf_setlen(base, old_baselen);
 
 		for (i = 0; i < nparent; ++i) {
@@ -220,10 +218,11 @@ static struct combine_diff_path *emit_path(struct combine_diff_path *tail,
 		if (opt->pathchange)
 			keep = opt->pathchange(opt, p);
 
-		if (!keep) {
+		if (keep) {
+			tail->next = p;
+			tail = p;
+		} else {
 			free(p);
-			pprev->next = NULL;
-			tail = pprev;
 		}
 	}
 
-- 
2.48.0.rc2.413.gc1c80375a3

