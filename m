Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989A0378D8C
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 18:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786127247; cv=none; b=bb1XKiPJI5x1w66rDVF1UR6zWyw6u9ZByDbIWupKAuVxaeWCP1pHbte3aEbbGyY2e7cL0NvYOCVjZ/KyRRfPIhFGjCCowuj4zDx4/tp2BcoLedkIoDJDqovgLhhDx2CCouC/E8BiUZ1c9O+AuSs+UDpPS2A+DtvvF/ko+5J/1yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786127247; c=relaxed/simple;
	bh=Qmd7MyMngEPaT8M+d/+fbpm2ztVDXwMaNk7CucYCCNs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FluzWD64P2BJ4/wpONvVQqXh8ohOgyAdJDe5eCXGlpNF3IQlrZ+ixlAk6mIhuj8HnGlavGbP8ybgdLwsHDUNQtYQ/bobNhsFJrJIheNiXbycZDOou+UGTUYcXLwGvDGD4cmY2tCyrbtZz9eMnB999Bkjj0OpPMx28HGadmH8BTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=OU3FKHYc; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="OU3FKHYc"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1786127242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pvIX8DltNdXcpTieg7V/JYqsrMaSyQfOK3671PFrIY8=;
	b=OU3FKHYcwkVGBlmXNSM/Vu6gzUtrQaSwTjLHp8uuqfJF1YpKdh6v9+e/Ds19xqqX6PDDnq
	GetPWfBjY4tz4L3iX/9iwZ1vnSMerdGmF6jAqR517RiWsy4vvoviPHLo/EAQVVq5/rW9c1
	zsJcz3CwJl2CewnglGWTm6cL75uitcY=
From: Toon Claes <toon@iotcl.com>
Date: Fri, 07 Aug 2026 20:26:48 +0200
Subject: [PATCH v2 2/6] revision: expose check for paths maybe changed in
 Bloom filter
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-toon-speed-up-last-modified-v2-2-7d87bbdeaf9b@iotcl.com>
References: <20260807-toon-speed-up-last-modified-v2-0-7d87bbdeaf9b@iotcl.com>
In-Reply-To: <20260807-toon-speed-up-last-modified-v2-0-7d87bbdeaf9b@iotcl.com>
To: git@vger.kernel.org
Cc: Gusted <gusted@codeberg.org>, Jeff King <peff@peff.net>, 
 Toon Claes <toon@iotcl.com>, Taylor Blau <me@ttaylorr.com>
X-Migadu-Flow: FLOW_OUT

check_maybe_different_in_bloom_filter() looks up a commit's changed-path
Bloom filter and consults it to see whether the commit might have
modified any of the paths in the pathspec that `revs` was set up with.
In a follow-up commit we want to reuse this logic from another builtin.

That caller, however, has already looked up the commit's Bloom filter
for its own purposes, so having the function look it up again would mean
a redundant lookup.

Extract the filter-consulting part into a new public function,
revs_maybe_changed_in_bloom(). This function takes an already looked-up
`struct bloom_filter` instead of a commit.
The existing check_maybe_different_in_bloom_filter() becomes a thin
wrapper that looks up the filter and delegates.

Expose the new function via revision.h so other builtins can reuse the
exact same filtering that `git log <pathspec>` performs.

The existing function check_maybe_different_in_bloom_filter() returns a
tristate value. This returns either:

 * `-1` : No Bloom filter was used.
 *  `0` : The commit definitely did not change any of the paths.
 *  `1` : The commit maybe changed one of the paths.

These return values are used to keep count of false-positives. But
because the new function revs_maybe_changed_in_bloom() is not involved
in counting statistics, it returns a boolean value telling whether the
commit definitely did not change any of the paths, or maybe changed some
of them.

Signed-off-by: Toon Claes <toon@iotcl.com>
---
 revision.c | 30 ++++++++++++++++++++----------
 revision.h | 12 ++++++++++++
 2 files changed, 32 insertions(+), 10 deletions(-)

diff --git a/revision.c b/revision.c
index 5b53902c05..78dcb40d9f 100644
--- a/revision.c
+++ b/revision.c
@@ -750,7 +750,6 @@ static int check_maybe_different_in_bloom_filter(struct rev_info *revs,
 						 struct commit *commit)
 {
 	struct bloom_filter *filter;
-	int result = 0;
 
 	if (!revs->bloom_keyvecs_nr)
 		return -1;
@@ -765,18 +764,29 @@ static int check_maybe_different_in_bloom_filter(struct rev_info *revs,
 		return -1;
 	}
 
-	for (size_t nr = 0; !result && nr < revs->bloom_keyvecs_nr; nr++) {
-		result = bloom_filter_contains_vec(filter,
-						   revs->bloom_keyvecs[nr],
-						   revs->bloom_filter_settings);
+	if (revs_maybe_changed_in_bloom(revs, filter)) {
+		count_bloom_filter_maybe++;
+		return 1;
 	}
 
-	if (result)
-		count_bloom_filter_maybe++;
-	else
-		count_bloom_filter_definitely_not++;
+	count_bloom_filter_definitely_not++;
+
+	return 0;
+}
+
+bool revs_maybe_changed_in_bloom(struct rev_info *revs,
+				 struct bloom_filter *filter)
+{
+	if (!revs->bloom_keyvecs_nr || !filter)
+		return true;
+
+	for (size_t nr = 0; nr < revs->bloom_keyvecs_nr; nr++)
+		if (bloom_filter_contains_vec(filter,
+					      revs->bloom_keyvecs[nr],
+					      revs->bloom_filter_settings))
+			return true;
 
-	return result;
+	return false;
 }
 
 static int rev_compare_tree(struct rev_info *revs,
diff --git a/revision.h b/revision.h
index acf6d06b24..67778558e1 100644
--- a/revision.h
+++ b/revision.h
@@ -68,6 +68,7 @@ struct string_list;
 struct saved_parents;
 struct follow_pathspec_slab;
 struct bloom_keyvec;
+struct bloom_filter;
 struct bloom_filter_settings;
 struct option;
 struct parse_opt_ctx_t;
@@ -495,6 +496,17 @@ void reset_revision_walk(void);
  */
 int prepare_revision_walk(struct rev_info *revs);
 
+/**
+ * Consult a changed-path Bloom filter to determine if the commit to which the
+ * filter belongs might have changed any of the paths in the `revs`.
+ * prepare_revision_walk() needs to be called in advance to ensure
+ * pathspec key vectors are set up.
+ *
+ * Returns false iff the commit definitely did not change any of the paths.
+ */
+bool revs_maybe_changed_in_bloom(struct rev_info *revs,
+				 struct bloom_filter *filter);
+
 /* Drain the commits linked list into the priority queue. */
 void rev_info_commit_list_to_queue(struct rev_info *revs);
 /**

-- 
2.55.0.679.g6767b8d81c

