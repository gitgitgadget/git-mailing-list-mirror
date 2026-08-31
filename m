Received: from mta1.migadu.com (out-223.mta1.migadu.com [95.215.58.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DB43E5EEA
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 15:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788189553; cv=none; b=bwqKhW0zZqZuKhkyp0KeSyVvxnYbdVyKu0/hqIpNHf4rjpoqBooNVIiUKWOx3LuSLs0lxe1vrA0V4TRU7dEzHCoCJ7/8sWIibJqr7aaBsEWEZbTTfZtPrMGiR/lElqBMw08/bBLdS61eDGMsylmBVTNtJMGFo62trmgSYzNKIhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788189553; c=relaxed/simple;
	bh=LgPkPMn6Skvxyx8zlGokeWGs2vAMfPS36yvtiFtiIbg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RWvAeqKOz2J8gmnxtWH03WDwiH+ehR93pyagu0irTSNdPVKsbS+kx3Fy9+1d4MrX1xWIHGqXqWsHw+4rNMGmMfVf44S2LUqjhLALG/CoGUtIvVdf0lKqTfy7oqdlIMwwwgJnf0EirFwElOXnJWAqLKiox+kaZQQsQqAP6ckWucs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=faUN7jFZ; arc=none smtp.client-ip=95.215.58.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="faUN7jFZ"
X-Envelope-To: git@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=LgPkPMn6Skvxyx8zlGokeWGs2vAMfPS36yvtiFtiIbg=;
 c=simple/simple; d=iotcl.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788189548; v=1; x=1788794348;
 b=faUN7jFZG8vhX2OUMjmWhGebPPj90XcqQI5rYPKhAyiy6b1TPYSkcP9zPCsWtg3A+7+APENc
 MbViYpquo48noTSBUD/zO56RB1Rg3/EQD/Wje2biWYmf0oLyvN8gBf2Ly8Po8isIZ/asAVccOKR
 4OqSJZLxwOTiQx1wOYTE1xF4=
X-Envelope-To: git@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 8d965a1ab6f131ff;
	Mon, 31 Aug 2026 15:19:08 +0000
X-Mizu-Trace-ID: 8d965a1ab6f131ff
X-Migadu-Flow: FLOW_OUT
From: Toon Claes <toon@iotcl.com>
Date: Mon, 31 Aug 2026 17:18:42 +0200
Subject: [PATCH v3 2/6] revision: expose check for paths maybe changed in
 Bloom filter
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-toon-speed-up-last-modified-v3-2-2bbb864acf93@iotcl.com>
References: <20260831-toon-speed-up-last-modified-v3-0-2bbb864acf93@iotcl.com>
In-Reply-To: <20260831-toon-speed-up-last-modified-v3-0-2bbb864acf93@iotcl.com>
To: git@vger.kernel.org
Cc: Gusted <gusted@codeberg.org>, Jeff King <peff@peff.net>, 
 Toon Claes <toon@iotcl.com>, Taylor Blau <me@ttaylorr.com>
X-Mailer: b4 0.16-dev-9febb

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
index 6a6a1b6fa0..ed46b90b00 100644
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

