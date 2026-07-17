Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEC02D949F
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 15:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784303241; cv=none; b=gDwtlK3bDZuhqXPTxtoBAJumrjPXH2XpNj3yf0WT24opl2GsuLElYUPDpTUkzAZpg2e9iG2bDimRFY7RDIP//dWV6TEyPN657KiSljyM/Kw/nu63ZLhDoIEVisCAAut7iDo3bpEGy6GTydQCOuQi2SM646v+oXm1xbgD053hd6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784303241; c=relaxed/simple;
	bh=Ui8D39/p+Pn0mkVe403OBMwYnCy2xQSfblBwxbgq6oo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T7+vtFbjbXLXXndA/miPTAh3Ez5C1kIPyNRBeV5NTnU7rwvVFKmYSr24+IFNmJgKHTA4Uffs/ZKU8JSzUNAluF83IQZ5eN5INMQNC3VzRVdxw19SzaAV1rU59TvJQgRyf3KmPxWM5q2SdIr2K7++GGCEFVJpNP37+ERaw4wwCFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=oWQ3CqID; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="oWQ3CqID"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1784303237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4znqxcEoptAr8NGbnT35Q5wP7rkffVWG09Wi11gOJIg=;
	b=oWQ3CqIDp2qjK8qPOWh7zI4ZDYn4R6Z8p76JVlj+iq/TzFhuPL4dfaOy2Q2CNHwfXLFmfN
	+vcHSsdS2Yg+qmK3MYbC+lUW1Ps6+kZp7Ip4M0h+VEMgMDF8vXY0SgMeRlcpzNjJ7KTL/z
	nTNQRgpVB6Eis4YX0VbdfVH2SgsZ0Fc=
From: Toon Claes <toon@iotcl.com>
Date: Fri, 17 Jul 2026 17:47:00 +0200
Subject: [PATCH 2/4] revision: expose check for paths maybe changed in
 Bloom filter
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260717-toon-speed-up-last-modified-v1-2-410418f18614@iotcl.com>
References: <20260717-toon-speed-up-last-modified-v1-0-410418f18614@iotcl.com>
In-Reply-To: <20260717-toon-speed-up-last-modified-v1-0-410418f18614@iotcl.com>
To: git@vger.kernel.org
Cc: Gusted <gusted@codeberg.org>, Jeff King <peff@peff.net>, 
 Toon Claes <toon@iotcl.com>
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

Signed-off-by: Toon Claes <toon@iotcl.com>
---
 revision.c | 31 +++++++++++++++++++++----------
 revision.h | 17 +++++++++++++++++
 2 files changed, 38 insertions(+), 10 deletions(-)

diff --git a/revision.c b/revision.c
index f3c9407a66..040b30b5ee 100644
--- a/revision.c
+++ b/revision.c
@@ -748,26 +748,20 @@ static int check_maybe_different_in_bloom_filter(struct rev_info *revs,
 						 struct commit *commit)
 {
 	struct bloom_filter *filter;
-	int result = 0;
-
-	if (!revs->bloom_keyvecs_nr)
-		return -1;
+	int result;
 
 	if (commit_graph_generation(commit) == GENERATION_NUMBER_INFINITY)
 		return -1;
 
 	filter = get_bloom_filter(revs->repo, commit);
-
 	if (!filter) {
 		count_bloom_filter_not_present++;
 		return -1;
 	}
 
-	for (size_t nr = 0; !result && nr < revs->bloom_keyvecs_nr; nr++) {
-		result = bloom_filter_contains_vec(filter,
-						   revs->bloom_keyvecs[nr],
-						   revs->bloom_filter_settings);
-	}
+	result = revs_maybe_changed_in_bloom(revs, filter);
+	if (result < 0)
+		return result;
 
 	if (result)
 		count_bloom_filter_maybe++;
@@ -777,6 +771,23 @@ static int check_maybe_different_in_bloom_filter(struct rev_info *revs,
 	return result;
 }
 
+int revs_maybe_changed_in_bloom(struct rev_info *revs,
+				struct bloom_filter *filter)
+{
+	int result = 0;
+
+	if (!revs->bloom_keyvecs_nr)
+		return -1;
+
+	for (size_t nr = 0; !result && nr < revs->bloom_keyvecs_nr; nr++) {
+		result = bloom_filter_contains_vec(filter,
+						   revs->bloom_keyvecs[nr],
+						   revs->bloom_filter_settings);
+	}
+
+	return result;
+}
+
 static int rev_compare_tree(struct rev_info *revs,
 			    struct commit *parent, struct commit *commit, int nth_parent)
 {
diff --git a/revision.h b/revision.h
index 569b3fa1cb..7569c210cc 100644
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
@@ -493,6 +494,22 @@ void reset_revision_walk(void);
  */
 int prepare_revision_walk(struct rev_info *revs);
 
+/**
+ * Take in a changed-path Bloom filter that belongs to a commit, and consult it
+ * to see if it might have modified any of the paths in the `revs`.
+ * The caller should look up `filter`, probably with get_bloom_filter().
+ * prepare_revision_walk() needs to be called in advance to ensure
+ * pathspec key vectors are set up.
+ *
+ * Returns -1 if no sensible answer could be given because of missing
+ * preconditions (no pathspec key vectors).
+ * Returns 0 if the commit definitely did not change any of the paths and 1 if
+ * the commit maybe has changed one of them, although that might be a
+ * false-positive.
+ */
+int revs_maybe_changed_in_bloom(struct rev_info *revs,
+				struct bloom_filter *filter);
+
 /* Drain the commits linked list into the priority queue. */
 void rev_info_commit_list_to_queue(struct rev_info *revs);
 /**

-- 
2.53.0.1323.g189a785ab5

