Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815DC379960
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 18:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786127249; cv=none; b=oW/GoLI5ZlpVaR3jG5huDRcttcwJL5YeIjsFURj9oLYWgHSwKdfgoyW0y0S8UTxS2WRlPCzhU/3gMqqBpGbW7fjfM6MWgzKtLWthMjTiieSNScdEEkphx42iBA9wNG4SQz7tEyLRJ8tUea+dGsKGFgW/QglFh3d6QeebCPGp+h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786127249; c=relaxed/simple;
	bh=H26zG09TPACFdRHTREs7kYkds78kmmu5EgAdUG670H0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EIbvz7m5/b66WodwkV4fmMp2lzGWzL1do0Vh/ZuHn2+cQUPo2Nb6BsWY0EL9rns7gixyz5U5oRvogJYKUSgx6ET4vXDCjJ5I5zHMUghJyUdUfWCg31i/Wx2d+2QX7XkdPD84HN6YwWN+DAkj9EbNSaDBe/Ulyxe6HcNly52QuNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=mnvm/HfT; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="mnvm/HfT"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1786127245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TOJUCG2gCLLCbDhnd0Y4iaz9DE9l5skFycJIvBvzM8s=;
	b=mnvm/HfTUKoTIxFGizdZtpPc6UlW9HGJSDoL6MQsmzl1f/wNTc+c5V6u3n0slEUzxNAQTQ
	Neb34OX0qBqQZ+cs5qin7O5LPHNRFuDFp0HZxTicPkYBhKpTtfUgY0937XGz6JGgTkx1Xm
	urrYJlCqP2ABC2dDDMHcL11eBSucCIo=
From: Toon Claes <toon@iotcl.com>
Date: Fri, 07 Aug 2026 20:26:49 +0200
Subject: [PATCH v2 3/6] bloom: add helper to check if any key in a vector
 is present
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-toon-speed-up-last-modified-v2-3-7d87bbdeaf9b@iotcl.com>
References: <20260807-toon-speed-up-last-modified-v2-0-7d87bbdeaf9b@iotcl.com>
In-Reply-To: <20260807-toon-speed-up-last-modified-v2-0-7d87bbdeaf9b@iotcl.com>
To: git@vger.kernel.org
Cc: Gusted <gusted@codeberg.org>, Jeff King <peff@peff.net>, 
 Toon Claes <toon@iotcl.com>, Taylor Blau <me@ttaylorr.com>
X-Migadu-Flow: FLOW_OUT

The changed-path Bloom filter of a commit stores a key for every changed
path together with each of its leading directories. To query if a path
was changed, bloom_keyvec_new() fills a key vector the same way: a key
for the given path and one for each of its leading directories. For
example, for "a/b/c" the vector holds keys for "a/b/c", "a/b" and "a".

A Bloom filter can only ever prove absence. When a key is not in the
filter, the path it was made for definitely did not change. When it is
in the filter, the path may have changed, as the key can be a false
positive.

bloom_filter_contains_vec() looks up all keys of a vector and reports
whether all of them are present. That answers: Is this path maybe
changed by this commit?

A caller that also cares about the directories containing the path asks
a different question: Is this path, or any directory leading up to it,
maybe changed by this commit?

Consider the Bloom filter of a commit that changed "a/b/d". It holds
keys for "a/b/d", "a/b" and "a", so looking up the vector of "a/b/c"
with bloom_filter_contains_vec() reports that nothing changed, even
though "a/b" and "a" did.

Add bloom_filter_contains_any_vec(), which reports whether any key in
the vector is present. It returns 0 only when none of the keys are in
the filter, which means the path and all directories leading up to it
definitely did not change.

There are no callers yet, one is added in a subsequent commit.

Signed-off-by: Toon Claes <toon@iotcl.com>
---
 bloom.c | 12 ++++++++++++
 bloom.h | 11 +++++++++++
 2 files changed, 23 insertions(+)

diff --git a/bloom.c b/bloom.c
index caf22f9831..b96534e6e3 100644
--- a/bloom.c
+++ b/bloom.c
@@ -607,6 +607,18 @@ int bloom_filter_contains_vec(const struct bloom_filter *filter,
 	return ret;
 }
 
+int bloom_filter_contains_any_vec(const struct bloom_filter *filter,
+				  const struct bloom_keyvec *vec,
+				  const struct bloom_filter_settings *settings)
+{
+	int ret = 0;
+
+	for (size_t nr = 0; !ret && nr < vec->count; nr++)
+		ret = bloom_filter_contains(filter, &vec->key[nr], settings);
+
+	return ret;
+}
+
 uint32_t test_bloom_murmur3_seeded(uint32_t seed, const char *data, size_t len,
 				   int version)
 {
diff --git a/bloom.h b/bloom.h
index 92ab2100d3..f508db23ad 100644
--- a/bloom.h
+++ b/bloom.h
@@ -164,6 +164,17 @@ int bloom_filter_contains_vec(const struct bloom_filter *filter,
 			      const struct bloom_keyvec *v,
 			      const struct bloom_filter_settings *settings);
 
+/*
+ * bloom_filter_contains_any_vec - Check if any key in a key vector is in the
+ * Bloom filter.
+ *
+ * Returns 1 if **any** key in the vector is present in the filter, 0 if none
+ * of them are.
+ */
+int bloom_filter_contains_any_vec(const struct bloom_filter *filter,
+				  const struct bloom_keyvec *v,
+				  const struct bloom_filter_settings *settings);
+
 uint32_t test_bloom_murmur3_seeded(uint32_t seed, const char *data, size_t len,
 				   int version);
 

-- 
2.55.0.679.g6767b8d81c

