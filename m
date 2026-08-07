Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3272C378D9F
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 18:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786127253; cv=none; b=UqM6Mu+1Is8KxDdMm0RXEEvX0Dd6EJF46FNYrQkCvNbGwKIlrRKiTb8MZt+qsHTSOW4ojHb6DJIryplISk+X7WjopdPkwEwBWc1lifgN2Jg4ieqGS5XEy5ylVSHgv5IVuxnaiNEMPDnfhj9MWdy8dvMJWuz4zobWorEpf79DGGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786127253; c=relaxed/simple;
	bh=4jNCWxFdyZVOjTylLLdJMYuhef6aKjoYN1Q6PM7wlZ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HKahd3ZKQ9K8PPuAEKgKwPsj+2oPWmIWKin7GhI2/TkS70mfEysXJwwWiJo/gzr82uv9l66v90/X9r2NANb+yyWsHQ5hG3oRVJGU+S9bNNEmgbmeZ0j8hkVHyRwHgOQyBjBrfUxQdzFRDIusMHr0WSWC2H2wDSWIrWrhObcE6LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=m3TD+Wio; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="m3TD+Wio"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1786127248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1UpCSpWCIlx5soJeZzxY/IAgOi1nxlrxVNXuVWgIonA=;
	b=m3TD+Wio5GyGxmm7doMSRxpPFn9b/RxkrSPcdQPY91D476CmaUz9OclqpKdIXeMT7AQ8DR
	y6xMO22Ze4cWKJ1W6A3/XQQhwqZb7yFpKtyd+kvw8bkETIx1VfZl1ha2vugx/e19U1YvaV
	73Dtr8lDF8nBz9ts1MsQNs6NmCIVDrs=
From: Toon Claes <toon@iotcl.com>
Date: Fri, 07 Aug 2026 20:26:50 +0200
Subject: [PATCH v2 4/6] revision: add Bloom check that includes parent
 directories
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-toon-speed-up-last-modified-v2-4-7d87bbdeaf9b@iotcl.com>
References: <20260807-toon-speed-up-last-modified-v2-0-7d87bbdeaf9b@iotcl.com>
In-Reply-To: <20260807-toon-speed-up-last-modified-v2-0-7d87bbdeaf9b@iotcl.com>
To: git@vger.kernel.org
Cc: Gusted <gusted@codeberg.org>, Jeff King <peff@peff.net>, 
 Toon Claes <toon@iotcl.com>, Taylor Blau <me@ttaylorr.com>
X-Migadu-Flow: FLOW_OUT

revs_maybe_changed_in_bloom() reports whether a commit may have changed
any of the paths in the pathspec. It uses bloom_filter_contains_vec(),
which requires all keys of a path's key vector to be present, so it only
answers for the paths themselves.

A caller may track more than those paths. git-last-modified(1) with
--show-trees reports the last modifying commit for the tree entries
containing the paths as well, up to the root. For a pathspec "a/b/c/"
that means it reports "a" and "a/b" next to "a/b/c" and its entries, and
those can each resolve to a different commit. A commit that only changed
"a/top" is the answer for "a", even though it touched nothing under
"a/b".

Such a caller needs to know whether the path, or any of the directories
leading up to it, may have changed. Add
revs_maybe_changed_in_bloom_with_parents(), which asks that question by
using bloom_filter_contains_any_vec() instead. A key vector holds a key
for the path and one for each of its leading directories, so looking up
any of them answers it.

There are no callers yet, one is added in a subsequent commit.

Signed-off-by: Toon Claes <toon@iotcl.com>
---
 revision.c | 15 +++++++++++++++
 revision.h |  8 ++++++++
 2 files changed, 23 insertions(+)

diff --git a/revision.c b/revision.c
index 78dcb40d9f..3195c0cab1 100644
--- a/revision.c
+++ b/revision.c
@@ -789,6 +789,21 @@ bool revs_maybe_changed_in_bloom(struct rev_info *revs,
 	return false;
 }
 
+bool revs_maybe_changed_in_bloom_with_parents(struct rev_info *revs,
+					      struct bloom_filter *filter)
+{
+	if (!revs->bloom_keyvecs_nr || !filter)
+		return true;
+
+	for (size_t nr = 0; nr < revs->bloom_keyvecs_nr; nr++)
+		if (bloom_filter_contains_any_vec(filter,
+						  revs->bloom_keyvecs[nr],
+						  revs->bloom_filter_settings))
+			return true;
+
+	return false;
+}
+
 static int rev_compare_tree(struct rev_info *revs,
 			    struct commit *parent, struct commit *commit, int nth_parent)
 {
diff --git a/revision.h b/revision.h
index 67778558e1..192001ff79 100644
--- a/revision.h
+++ b/revision.h
@@ -507,6 +507,14 @@ int prepare_revision_walk(struct rev_info *revs);
 bool revs_maybe_changed_in_bloom(struct rev_info *revs,
 				 struct bloom_filter *filter);
 
+/**
+ * Same as revs_maybe_changed_in_bloom(), but a change to any of the directories
+ * leading up to a path counts as well. Callers that track the tree entries
+ * containing the paths, and not just the paths themselves, need this.
+ */
+bool revs_maybe_changed_in_bloom_with_parents(struct rev_info *revs,
+					      struct bloom_filter *filter);
+
 /* Drain the commits linked list into the priority queue. */
 void rev_info_commit_list_to_queue(struct rev_info *revs);
 /**

-- 
2.55.0.679.g6767b8d81c

