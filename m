Received: from mta0.migadu.com (out-121.mta0.migadu.com [91.218.175.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB2E4766A3
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 09:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788254979; cv=none; b=q6Dc6WuOHAKm1mCJH1ZAihiqCXPIOUy0aoJk9WxbR2mLMCILpvJsZfzsNG0/NTfSSJQHZ8U/YSGCMPDdedB5dGwA2Oi6UlLEQwhA9kaEmzpxO6+WX90wEyfczUWu10PHLnE+GXoV+dJ1iMZPaAewO2SXd7zkyrO+OFpVUlQX9do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788254979; c=relaxed/simple;
	bh=LgPkPMn6Skvxyx8zlGokeWGs2vAMfPS36yvtiFtiIbg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qaM8T5vyMTj5E0XpYZcZaFM2jJm2lI/awfT8xbgWcK0UEkwDnq/QAI/p8a8hsOyVFj4RY5b/3eu9C//0zazmU7ZQvCUOhLHDRO/3p05TMpfwCV2zBopyaRPBD0g2o5YE4watCkkQ0SJQZpsykqh8/sh0r2FW5YWXZ0F63mCELmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=j9eyB9Mi; arc=none smtp.client-ip=91.218.175.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="j9eyB9Mi"
X-Envelope-To: git@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=LgPkPMn6Skvxyx8zlGokeWGs2vAMfPS36yvtiFtiIbg=;
 c=simple/simple; d=iotcl.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788254975; v=1; x=1788859775;
 b=j9eyB9Mi4ETuk0ins7XRNC2vtWS7DFNAsKIedvdNuqOHV6ugUFIF3cP40CVg6/cLJQ/EidsI
 mtbP4BjHsXgVin6pV4vzbVS8LY9MrUzE7c1GApLOgIa+SYTwn7puPRNwBC1ZdzdmeZWAiFaO0Pr
 EVprhZcopNcBLiW/ioGHQDMU=
X-Envelope-To: git@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 48ae9ac49039a6b5;
	Tue, 01 Sep 2026 09:29:35 +0000
X-Mizu-Trace-ID: 48ae9ac49039a6b5
X-Migadu-Flow: FLOW_OUT
From: Toon Claes <toon@iotcl.com>
Date: Tue, 01 Sep 2026 11:10:22 +0200
Subject: [PATCH v4 2/6] revision: expose check for paths maybe changed in
 Bloom filter
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-toon-speed-up-last-modified-v4-2-a09949800404@iotcl.com>
References: <20260901-toon-speed-up-last-modified-v4-0-a09949800404@iotcl.com>
In-Reply-To: <20260901-toon-speed-up-last-modified-v4-0-a09949800404@iotcl.com>
To: git@vger.kernel.org
Cc: Gusted <gusted@codeberg.org>, Jeff King <peff@peff.net>, 
 Taylor Blau <me@ttaylorr.com>, Toon Claes <toon@iotcl.com>
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

