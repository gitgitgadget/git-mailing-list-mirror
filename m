Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A809122D4F1
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 20:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754600001; cv=none; b=RJcPCuiJAgO3s92xhydqV0+O0JVpV1oSGni6jnqcEyZ0YMGxwj7KzCGVNkMNahkLEEN2ssKR0C1zeMyM+1uTCbLHy1bTt5zu1+bCAINdtqytqe6BMjstN0nYqmrtkePdvlwFdMkrhcueHeYnZHu3joXDuLqQNUFB5WPckIt86Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754600001; c=relaxed/simple;
	bh=f/JKwKHeEmKpLrQ0362ikCwpSInIQbwJMKpIIS0VHF0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aRK1yO1bfM0ub+/dIJhXt39+5wDTQWZtAKN0YiYYzy9YEHTxxzJrL9aITdSc4V9n4yO6Qm00HnshIzOR2WRoD3iZvUq42rejfpEUpVnk8fRi5B8QbaWxExWKB51xZEovUJXAB+bxThbyOvlh4JIYQmYMwRiH9cNV60AcigBbdg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=n4H1/VAw; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="n4H1/VAw"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1754599995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yIVvf5Oj9LRfwwOyLZMXD4UXBU37m1lzfsbmXaFrP1M=;
	b=n4H1/VAwqlKCGtuJ7vBBBYgiTvcLZ0pLvevJsfUbxAT9cBQVF9IQyNC3jRgiYLj2B60iET
	QWFgHvUaBexZfUbM/tUiYpCjlEu9qHZzLqKWjTtYTinUVSSyhXpDDCEzUfJS/ds3MWYaCF
	0IGPef2ycsksgmxzCGjWSGmnkajAM94=
From: Toon Claes <toon@iotcl.com>
Date: Thu, 07 Aug 2025 22:52:56 +0200
Subject: [PATCH v2 1/3] combine-diff: zero memory used for callback
 filepairs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250807-toon-max-depth-v2-1-50b7e5c81665@iotcl.com>
References: <20250807-toon-max-depth-v2-0-50b7e5c81665@iotcl.com>
In-Reply-To: <20250807-toon-max-depth-v2-0-50b7e5c81665@iotcl.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Justin Tobler <jltobler@gmail.com>, 
 Patrick Steinhardt <ps@pks.im>, Toon Claes <toon@iotcl.com>
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

