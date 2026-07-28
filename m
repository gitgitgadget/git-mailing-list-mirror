Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033533C454F
	for <git@vger.kernel.org>; Tue, 28 Jul 2026 15:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785253588; cv=none; b=DBaIt3h65x6ISEb7liEc9wu1UvsUSWIm0fqrlfn28md3o1FaHrtgrX9edoPCRT3FRkiUpYHFntQnDhUm6C/xXY5337vbV/VnXAd/MJf0kAEf70LE/nuDYPF0CEKoiT5V8ayLvpjABkGQFkG8WmLi5lyoohtXuSBkG8NSvDPrliM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785253588; c=relaxed/simple;
	bh=DX2Dh8sHP7OB/ZKSTxr/0PCJKB4gRqaYMXBgty1fSu4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UQnXlfinYwAZC4RvVymFsi0NGksG1I1hTZkrQkYFxEY+Zzzn0Oap8IK5HdNnx2CcbWLBEnIrzV8H6ckyZvJ6RUwc3Bz1d+QsUwqBp+000tgQhTGIsJ1P6BWwDuD1qBy7vL1uRR8PVTcaYQhv54Bj0M+At5DIVOCv9iSz44FrBc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=2ke2Ac3I; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="2ke2Ac3I"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1785253584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vHPxsnItaB4cxja++5U+UdvDPJUKnAKtbosiSrxF/JE=;
	b=2ke2Ac3ITH/gWkXwUp5tV8/u7XGB+Bnsv3x4234blHo9/MVpTAoeOzlyKVUArdqsFO1K+q
	E+dXFiwi3r+tLHo3jhCGKb1bwpfG3nzAGKN4Of9gO0tKj3mlyb9FiCzSl2Bpyjg8TlrWha
	n4mzW+8SDQEyscmFysK2Hh7Ni7eh+k8=
From: Toon Claes <toon@iotcl.com>
Date: Tue, 28 Jul 2026 17:45:52 +0200
Subject: [PATCH v8 2/3] replay: resolve the replay base outside
 pick_regular_commit()
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-toon-git-replay-drop-merges-v8-2-ced11dffe749@iotcl.com>
References: <20260728-toon-git-replay-drop-merges-v8-0-ced11dffe749@iotcl.com>
In-Reply-To: <20260728-toon-git-replay-drop-merges-v8-0-ced11dffe749@iotcl.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Toon Claes <toon@iotcl.com>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Migadu-Flow: FLOW_OUT

Depending on what gets passed into the function pick_regular_commit(),
it decides the new base for the replayed commit. It first tries to find
the replayed results of `pickme`'s parent in the `replayed_commits` map.
If not found, it falls back to `onto`.

When using git-replay(1) with --onto, the fallback is the revision
passed in with this option, but when using --revert, the fallback is
`last_commit`.

It's rather confusing the base is decided partly inside
pick_regular_commit() and partly by its caller.

Move the base selection completely into the caller: replay_revisions().
This bundles all the logic of deciding on the base together. Also, this
reduces the number of parameters of pick_regular_commit(), making its
interface cleaner.

This refactoring doesn't bring any behavior changes.

Signed-off-by: Toon Claes <toon@iotcl.com>
---
 replay.c | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/replay.c b/replay.c
index 860e194ba0..7e35f40d37 100644
--- a/replay.c
+++ b/replay.c
@@ -284,25 +284,19 @@ static void put_mapped_commit(kh_oid_map_t *replayed_commits,
 
 static struct commit *pick_regular_commit(struct repository *repo,
 					  struct commit *pickme,
-					  kh_oid_map_t *replayed_commits,
-					  struct commit *onto,
+					  struct commit *replayed_base,
 					  struct merge_options *merge_opt,
 					  struct merge_result *result,
 					  enum replay_mode mode,
 					  enum replay_empty_commit_action empty)
 {
-	struct commit *base, *replayed_base;
 	struct tree *pickme_tree, *base_tree, *replayed_base_tree;
 
-	if (pickme->parents) {
-		base = pickme->parents->item;
-		base_tree = repo_get_commit_tree(repo, base);
-	} else {
-		base = NULL;
+	if (pickme->parents)
+		base_tree = repo_get_commit_tree(repo, pickme->parents->item);
+	else
 		base_tree = lookup_tree(repo, repo->hash_algo->empty_tree);
-	}
 
-	replayed_base = get_mapped_commit(replayed_commits, base, onto);
 	replayed_base_tree = repo_get_commit_tree(repo, replayed_base);
 	pickme_tree = repo_get_commit_tree(repo, pickme);
 
@@ -443,12 +437,26 @@ int replay_revisions(struct rev_info *revs,
 	while ((commit = get_revision(revs))) {
 		const struct name_decoration *decoration;
 
+		/*
+		 * Decide where to replay this commit on.
+		 * If the parent commit was replayed already, the replayed result
+		 * can be found in `replayed_commits`. Otherwise fall back to `onto`.
+		 * When reverting, commits are replayed in reverse order and thus
+		 * its parent isn't replayed yet. Therefore revert commits are
+		 * always replayed onto `last_commit`.
+		 */
+		struct commit *parent = commit->parents ? commit->parents->item : NULL;
+		struct commit *base = get_mapped_commit(replayed_commits, parent, onto);
+
+		if (mode == REPLAY_MODE_REVERT)
+			base = last_commit;
+
 		if (commit->parents && commit->parents->next)
 			die(_("replaying merge commits is not supported yet!"));
 
-		last_commit = pick_regular_commit(revs->repo, commit, replayed_commits,
-						  mode == REPLAY_MODE_REVERT ? last_commit : onto,
-						  &merge_opt, &result, mode, opts->empty);
+		last_commit = pick_regular_commit(revs->repo, commit, base,
+						  &merge_opt, &result,
+						  mode, opts->empty);
 		if (!last_commit)
 			break;
 

-- 
2.55.0.424.g13c7afec21

