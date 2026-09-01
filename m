Received: from mta1.migadu.com (out-115.mta1.migadu.com [95.215.58.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66ECE477E51
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 09:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788254982; cv=none; b=Uo/aCvoEt/6lJoDxh7AuyXmH8+YEVqMG9kNpexzJATXVtt9U2Rh2Mzw/Bvcn4sztKfR0/OtdymAkxU5xnJrSXOCFNV1WhVsc0iPx2lIpZERV+47IIL0LLwc9/6mmgFCVgyDaDmdIlH0Cc5inVZappKKVg/vMX7PqSmXg1I38YY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788254982; c=relaxed/simple;
	bh=H26zG09TPACFdRHTREs7kYkds78kmmu5EgAdUG670H0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d5PwKXzuXQ+tLmqUfgPyXcHiTDIyFPjXpEc5rimVZT4Aoa/MH3NrfMK/DKZRh4KMud4bVDInNsNVq5cmJ83wcwet02x86o5J028Y4+liZaOf5gb8Se1qqsUZxVZ3J13Id2+3J7Y+DmvDHwl4ybcOwVCGNqlwxfT1qfkAo859fl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=NchgqM1L; arc=none smtp.client-ip=95.215.58.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="NchgqM1L"
X-Envelope-To: git@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=H26zG09TPACFdRHTREs7kYkds78kmmu5EgAdUG670H0=;
 c=simple/simple; d=iotcl.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788254978; v=1; x=1788859778;
 b=NchgqM1Lu4s/K8vsAbQCTwI2RnzH1tdKKtTW8+xQ//HWoDiq6DuAzzPliDvmkxSAuN2zF4pG
 CEd5e4CFmAIF4FUBJNJHVdH5gmB47BjOKzFWTH4mx19Ep18GnGey8tCleCUnjrsDFwjThqEoRC8
 6033WXWZUVpjB+ULo09O1XvU=
X-Envelope-To: git@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 23454e885c5dce8c;
	Tue, 01 Sep 2026 09:29:38 +0000
X-Mizu-Trace-ID: 23454e885c5dce8c
X-Migadu-Flow: FLOW_OUT
From: Toon Claes <toon@iotcl.com>
Date: Tue, 01 Sep 2026 11:10:23 +0200
Subject: [PATCH v4 3/6] bloom: add helper to check if any key in a vector
 is present
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-toon-speed-up-last-modified-v4-3-a09949800404@iotcl.com>
References: <20260901-toon-speed-up-last-modified-v4-0-a09949800404@iotcl.com>
In-Reply-To: <20260901-toon-speed-up-last-modified-v4-0-a09949800404@iotcl.com>
To: git@vger.kernel.org
Cc: Gusted <gusted@codeberg.org>, Jeff King <peff@peff.net>, 
 Taylor Blau <me@ttaylorr.com>, Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.16-dev-9febb

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

