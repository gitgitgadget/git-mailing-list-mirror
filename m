Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEF824A049
	for <git@vger.kernel.org>; Tue, 29 Jul 2025 18:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753815494; cv=none; b=WjDaBiz68byix5RHSyncAxIHd+gnmA1PkX5MeD5KnSViX6TEASJwsdVFKlsgo109rLXNLG8YCkDlvH8ym5H9lv7SMX32OVwN4yjUSZWO2+jBEpKpE/hCE5dRBy/kARDTgTP9uWh59G8MuqgrqP/rYq6/U/HxvrpZ2G6HObPcgyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753815494; c=relaxed/simple;
	bh=f/JKwKHeEmKpLrQ0362ikCwpSInIQbwJMKpIIS0VHF0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YoxB+3hN3vsZkQ4XIl1CBz4mTwFgouEU35FTEXnYLi23RwXKksTTwwPDFGROsh3/aXh+PCIGL2tUApPbIr+Jz6qR9CfZ2k2TeyRYBoqviFoV1EBZXApiS+0wapxQ9Ot+USUSoXfM+huzCcfkSxPrYgP7m5m9ta2lnc2rnCYbkH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=TX/zTyOQ; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="TX/zTyOQ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1753815489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yIVvf5Oj9LRfwwOyLZMXD4UXBU37m1lzfsbmXaFrP1M=;
	b=TX/zTyOQvqMFpwQWGIAXOAKuFkRLuKtABJtk2X/FgzRlFqpnDNJlVy8IglWta4FMFTgEOw
	oN/S5WNBjpdhawLBA2MSXY0FM8QPIOCQZZxu12jg/5ELk8rQztOQNWlthYTQ4fNkOeC4+v
	+MQzG0nFG+e+ZHRMpm5ZErdt8q2fF7g=
From: Toon Claes <toon@iotcl.com>
Date: Tue, 29 Jul 2025 20:57:42 +0200
Subject: [PATCH 1/3] combine-diff: zero memory used for callback filepairs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250729-toon-max-depth-v1-1-c177e39c40fb@iotcl.com>
References: <20250729-toon-max-depth-v1-0-c177e39c40fb@iotcl.com>
In-Reply-To: <20250729-toon-max-depth-v1-0-c177e39c40fb@iotcl.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Justin Tobler <jltobler@gmail.com>, 
 Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

From: Jeff King <peff@peff.net>

In commit 25e5e2bf85 (combine-diff: support format_callback,
2011-08-19), the combined-diff code learned how to make a multi-sourced
`diff_filepair` to pass to a diff callback. When we create each
filepair, we do not bother to fill in many of the fields, because they
would make no sense (e.g. there can be no rename score or broken_pair
flag because we do not go through the diffcore filters). However, we did
not even bother to zero them, leading to random values. Let's make sure
everything is blank with xcalloc(), just as the regular diff code does.

We would potentially want to set the `status` flag to
something non-zero, but it is not clear to what. Possibly a
new DIFF_STATUS_COMBINED would make sense, as this is not
strictly a modification, nor does it fit any other category.

Since it is not yet clear what callers would want, this
patch simply leaves it as `0`, the same empty flag that is
seen when `diffcore_std` is not used at all.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Toon Claes <toon@iotcl.com>
---
 combine-diff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/combine-diff.c b/combine-diff.c
index 4ea2dc93c4..3878faabe7 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1315,7 +1315,7 @@ static struct diff_filepair *combined_pair(struct combine_diff_path *p,
 	struct diff_filepair *pair;
 	struct diff_filespec *pool;
 
-	pair = xmalloc(sizeof(*pair));
+	CALLOC_ARRAY(pair, 1);
 	CALLOC_ARRAY(pool, st_add(num_parent, 1));
 	pair->one = pool + 1;
 	pair->two = pool;

-- 
2.50.1.327.g047016eb4a

