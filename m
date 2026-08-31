Received: from mta1.migadu.com (out-226.mta1.migadu.com [95.215.58.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A598535589
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 15:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788189560; cv=none; b=X/j8zPi7SoAbZ+b4M7xU19q//h94BxSsqnwu4AgXsVC0AnxMTed2f9a64I3bJAIRxkMAlLuHYKrNM8NCrZiS5YmhzRfmUnw1JwvBJmYFiCrEDd4brP7htzFumango2T45pyRcG1jy0ghMpk2aGNVReBfJq+dRRUe9d5JxPt6UyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788189560; c=relaxed/simple;
	bh=V8oj8Oz4PQlw04y8kLsJEBMEvYZRdVzIwGTROasen4Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aWd0ioc88BI4nC58WJ+L5MRLpN+1DGSBVwFUf5DjfuZmfgQpVQ7vUj7kCm+qEH7Rvsfl2u+CFa/s10fFEEXWGLsSA5Gh8pMm2pBvgXWZadLyNNDIrNyU8QEfinFr43pl8t+AuRqYoK9ClFoNcltVisdQn6BrtiCuMqkQnAtsz/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=R0CU1/c+; arc=none smtp.client-ip=95.215.58.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="R0CU1/c+"
X-Envelope-To: git@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=V8oj8Oz4PQlw04y8kLsJEBMEvYZRdVzIwGTROasen4Y=;
 c=simple/simple; d=iotcl.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788189556; v=1; x=1788794356;
 b=R0CU1/c+GzcMOUtcWeBx1Puyy1YG7P+QMZiCFnyCB+0pExKQPqGOmDgzPuHbaGoiNvvzq+fH
 dzibJ3kWzX/K2EWRxU2eOKtkSjfwajLzw+K5JS5wLsq3PakPGGtJkR5ueuCI7vRYpxfK4+RxxP6
 3hfli4BL4/sm9EaMdPGWsSrQ=
X-Envelope-To: git@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 0a71f554b59e0214;
	Mon, 31 Aug 2026 15:19:15 +0000
X-Mizu-Trace-ID: 0a71f554b59e0214
X-Migadu-Flow: FLOW_OUT
From: Toon Claes <toon@iotcl.com>
Date: Mon, 31 Aug 2026 17:18:44 +0200
Subject: [PATCH v3 4/6] revision: add Bloom check that includes parent
 directories
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-toon-speed-up-last-modified-v3-4-2bbb864acf93@iotcl.com>
References: <20260831-toon-speed-up-last-modified-v3-0-2bbb864acf93@iotcl.com>
In-Reply-To: <20260831-toon-speed-up-last-modified-v3-0-2bbb864acf93@iotcl.com>
To: git@vger.kernel.org
Cc: Gusted <gusted@codeberg.org>, Jeff King <peff@peff.net>, 
 Toon Claes <toon@iotcl.com>, Taylor Blau <me@ttaylorr.com>
X-Mailer: b4 0.16-dev-9febb

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
index ed46b90b00..a560146b4d 100644
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

