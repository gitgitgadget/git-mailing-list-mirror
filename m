Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8B3226D04
	for <git@vger.kernel.org>; Fri, 23 May 2025 09:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747992867; cv=none; b=R1PZX7hQLppz14cdDl3JBcE7zTLtoONjPW2Df1RWm7qmJ2/3royj0gDaoBZXBwEBp9aQGXbdG1xg+cCq6Iv2tC87n59zNKCGjuN3bedtkTGCWE1QIVYxYH7mIBPy/4SRuzoERwG4hkJ3LcIy6y6Fz++L2Bab3kyVrStfMAvdB1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747992867; c=relaxed/simple;
	bh=JSuOedShKbT47qSl96RGCiWI2/Mpcb3AFxzDKrZILq8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iV8srA0InRld4AC8YSz6tiSfXyT7pM8YVXa+1heW4Y2jMco8Guv3tA7xhoB2lAw75nYlgfVp7kW3xehyTbeOZ8SOleEXopx026gwSbx6TLZqEezVai+0E1d25unmdOA/+peDA4CQCx6v+j/uYlTWQ6oMsZZwJtDj1BZA8eCqkDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=VFjBM6xh; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="VFjBM6xh"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1747992863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9rizC3QHKnxfaDoBN2ewSGFO3G3NRjy+ymnABSEbUBE=;
	b=VFjBM6xhVbzVK6mWVD91MM81af8WjLlRtL6cE3kNTA2u4JmmnvM7FDNNrzg3105z2kWgll
	9TW+dz0iqqwM3lgMB8fCkjtZ63J84AF4JKHPyItW66w20zFqosAPXDRvJCpKtNleQLTCMe
	XniBzSuLx/RJ5bmrN3vpIsBDOtWGevQ=
From: Toon Claes <toon@iotcl.com>
Date: Fri, 23 May 2025 11:33:52 +0200
Subject: [PATCH RFC v2 5/5] last-modified: initialize revision machinery
 without walk
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250523-toon-new-blame-tree-v2-5-101e4ca4c1c9@iotcl.com>
References: <20250523-toon-new-blame-tree-v2-0-101e4ca4c1c9@iotcl.com>
In-Reply-To: <20250523-toon-new-blame-tree-v2-0-101e4ca4c1c9@iotcl.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>, 
 Derrick Stolee <stolee@gmail.com>, Toon Claes <toon@iotcl.com>, 
 =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= <avarab@gmail.com>, 
 Derrick Stolee <stolee@gmail.com>
X-Migadu-Flow: FLOW_OUT

In a previous commit we inserted a call to 'prepare_revision_walk()'
before we started our traversal. This was done when we leveraged the
revision machinery more (at the time, we were leaning on
'log_tree_commit()' which only worked after calling
'prepare_revision_walk()').

But, we have since dropped 'log_tree_commit()', so we don't need most of
the initialization work of 'prepare_revision_walk()'. Now we ask it to
do very little work during initialization by setting the '->no_walk'
flag to '1', which leaves its internal state alone enough that we can
still function as normal.

Unfortunately, this means that we now no longer complain about
non-commit inputs, since the revision machinery check this for us (it
just silently ignores them).

Based-on-patch-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Toon Claes <toon@iotcl.com>
---
 last-modified.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/last-modified.c b/last-modified.c
index 0a0818cdf1..b1458db0bc 100644
--- a/last-modified.c
+++ b/last-modified.c
@@ -271,6 +271,13 @@ static int maybe_changed_path(struct last_modified *lm,
 	if (!filter)
 		return 1;
 
+	for (int i = 0; i < lm->rev.bloom_keys_nr; i++) {
+		if (!(bloom_filter_contains(filter,
+					    &lm->rev.bloom_keys[i],
+					    lm->rev.bloom_filter_settings)))
+			return 0;
+	}
+
 	hashmap_for_each_entry(&lm->paths, &iter, ent, hashent) {
 		if (active && !active->active[ent->diff_idx])
 			continue;
@@ -364,6 +371,7 @@ int last_modified_run(struct last_modified *lm, last_modified_callback cb, void
 	struct prio_queue queue = { compare_commits_by_gen_then_commit_date };
 	struct prio_queue not_queue = { compare_commits_by_gen_then_commit_date };
 	struct last_modified_callback_data data;
+	struct commit_list *list;
 
 	data.paths = &lm->paths;
 	data.callback = cb;
@@ -372,6 +380,9 @@ int last_modified_run(struct last_modified *lm, last_modified_callback cb, void
 	lm->rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
 	lm->rev.diffopt.format_callback = last_modified_diff;
 	lm->rev.diffopt.format_callback_data = &data;
+	lm->rev.no_walk = 1;
+
+	prepare_revision_walk(&lm->rev);
 
 	max_count = lm->rev.max_count;
 
@@ -379,14 +390,12 @@ int last_modified_run(struct last_modified *lm, last_modified_callback cb, void
 	scratch = xcalloc(lm->all_paths_nr, sizeof(char));
 
 	/*
-	 * lm->rev.pending holds the set of boundary commits for our walk.
+	 * lm->rev.commits holds the set of boundary commits for our walk.
 	 *
 	 * Loop through each such commit, and place it in the appropriate queue.
 	 */
-	for (size_t i = 0; i < lm->rev.pending.nr; i++) {
-		struct commit *c = lookup_commit(lm->rev.repo,
-						 &lm->rev.pending.objects[i].item->oid);
-		repo_parse_commit(lm->rev.repo, c);
+	for (list = lm->rev.commits; list; list = list->next) {
+		struct commit *c = list->item;
 
 		if (c->object.flags & BOTTOM) {
 			prio_queue_put(&not_queue, c);
@@ -409,12 +418,6 @@ int last_modified_run(struct last_modified *lm, last_modified_callback cb, void
 		}
 	}
 
-	/*
-	 * Now that we have processed the pending commits, allow the revision
-	 * machinery to flush them by calling prepare_revision_walk().
-	 */
-	prepare_revision_walk(&lm->rev);
-
 	while (queue.nr) {
 		int parent_i;
 		struct commit_list *p;

-- 
2.49.0

