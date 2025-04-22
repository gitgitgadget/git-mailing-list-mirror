Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6198D1E1A05
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 17:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745344033; cv=none; b=Zgu+EIowXgZ53xiO0UusqERPgoA15Hd1O8vtpDC1TJRLZG0WlNnBrZhB7PpsM1rGKXeQloWUXbVcK9A4/6hHS4XFACrSNK2QdR7CIaaxfLAyLouLn610UW1U7hy5ZRy2+jOUzPZ/SBfQxIg0o/OvTpk341UVpzUYQfmWR/CovPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745344033; c=relaxed/simple;
	bh=Ydu17y6z55li+LlWvOSA6TB/tFltEHFvuPQjp/MxovI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V56dcQTKeoDWiyz/EohIfriqx8voqjivtuNIc9un65PBdFxEYH1aqK8iXUUdSa9NWOqAdXsWorb+UChjo41F4H7Qk+5gI30/r/KLtoqXw4Wb5oMmcczpn3yeOce28SkABh8Oallxl2ppdfhy4PJf379aB8J8tMxol5YjEodftcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=oU2JaiuS; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="oU2JaiuS"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1745344028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D5HsB+3z997Ky1/GLpfOLS+Qz7YgE/pb7WOBF0ZzHqE=;
	b=oU2JaiuSkZA/9VOqpeselOIolom28jelBlX/aPiuFXVvftUMGOT3TtVbDll0Ag1kQaJtgl
	0VHCLaHvfYzmoAcd8jtCMn/di+e6Pb6NGQ2dqqgIlKMkOAVdmo6rdH4kQZkTnbKu+jgOuJ
	mMthV4+r5Tfc9iL5oBkXxX27KOZe3mA=
From: Toon Claes <toon@iotcl.com>
Date: Tue, 22 Apr 2025 19:46:28 +0200
Subject: [PATCH RFC 5/5] blame-tree.c: initialize revision machinery
 without walk
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250422-toon-new-blame-tree-v1-5-fdb51b8a394a@iotcl.com>
References: <20250422-toon-new-blame-tree-v1-0-fdb51b8a394a@iotcl.com>
In-Reply-To: <20250422-toon-new-blame-tree-v1-0-fdb51b8a394a@iotcl.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>, 
 Derrick Stolee <stolee@gmail.com>, Toon Claes <toon@iotcl.com>
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
 blame-tree.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/blame-tree.c b/blame-tree.c
index 2cb7a5045c..e244797b7e 100644
--- a/blame-tree.c
+++ b/blame-tree.c
@@ -271,6 +271,13 @@ static int maybe_changed_path(struct blame_tree *bt,
 	if (!filter)
 		return 1;
 
+	for (int i = 0; i < bt->rev.bloom_keys_nr; i++) {
+		if (!(bloom_filter_contains(filter,
+					    &bt->rev.bloom_keys[i],
+					    bt->rev.bloom_filter_settings)))
+			return 0;
+	}
+
 	hashmap_for_each_entry(&bt->paths, &iter, e, hashent) {
 		if (active && !active->active[e->diff_idx])
 			continue;
@@ -364,6 +371,7 @@ int blame_tree_run(struct blame_tree *bt, blame_tree_callback cb, void *cbdata)
 	struct prio_queue queue = { compare_commits_by_gen_then_commit_date };
 	struct prio_queue not_queue = { compare_commits_by_gen_then_commit_date };
 	struct blame_tree_callback_data data;
+	struct commit_list *list;
 
 	data.paths = &bt->paths;
 	data.callback = cb;
@@ -372,6 +380,9 @@ int blame_tree_run(struct blame_tree *bt, blame_tree_callback cb, void *cbdata)
 	bt->rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
 	bt->rev.diffopt.format_callback = blame_diff;
 	bt->rev.diffopt.format_callback_data = &data;
+	bt->rev.no_walk = 1;
+
+	prepare_revision_walk(&bt->rev);
 
 	max_count = bt->rev.max_count;
 
@@ -379,14 +390,12 @@ int blame_tree_run(struct blame_tree *bt, blame_tree_callback cb, void *cbdata)
 	scratch = xcalloc(bt->all_paths_nr, sizeof(char));
 
 	/*
-	 * bt->rev.pending holds the set of boundary commits for our walk.
+	 * bt->rev.commits holds the set of boundary commits for our walk.
 	 *
 	 * Loop through each such commit, and place it in the appropriate queue.
 	 */
-	for (size_t i = 0; i < bt->rev.pending.nr; i++) {
-		struct commit *c = lookup_commit(bt->rev.repo,
-						 &bt->rev.pending.objects[i].item->oid);
-		repo_parse_commit(bt->rev.repo, c);
+	for (list = bt->rev.commits; list; list = list->next) {
+		struct commit *c = list->item;
 
 		if (c->object.flags & BOTTOM) {
 			prio_queue_put(&not_queue, c);
@@ -409,12 +418,6 @@ int blame_tree_run(struct blame_tree *bt, blame_tree_callback cb, void *cbdata)
 		}
 	}
 
-	/*
-	 * Now that we have processed the pending commits, allow the revision
-	 * machinery to flush them by calling prepare_revision_walk().
-	 */
-	prepare_revision_walk(&bt->rev);
-
 	while (queue.nr) {
 		int parent_i;
 		struct commit_list *p;

-- 
2.49.0.rc2

