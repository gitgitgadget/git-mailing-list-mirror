Received: from mta0.migadu.com (out-92.mta0.migadu.com [91.218.175.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1247A33DEDF
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 13:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788182057; cv=none; b=sVaK1CfGBiButdZGN6xlggPaeA4xljWVdW4kgSUIzIuqzz+SHXMGstHC9S4R4IDQOaT06MLCFU1/QgVBoGH5fL1UaC3L5jrjz9NInMgVcspc/F24otD7IlslrEY+neIL5Dr60B1L2ADxtsxw50RltJKvzch16Sh/KDciRYSaqLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788182057; c=relaxed/simple;
	bh=i9X+gulancO/6amvfc60uKgPbEeEVz6B/Uk//oM+Fyk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fb4Ds21BZEuvs3PH0r+PKPYGfCvRc0YAe3IAYGC50FzXGVppfdtCt/y9vsA4g3QVlyaCaaXvY8UOmsZBFpDewD5R7MwYwJMfOr4UZyDzF7LJ9006MVLT39SPkfHPOKc7JfF0FPCFX3pAAbSHpMaAbS2hgt5tN7cT+QhShB6b4l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=Mal2gON8; arc=none smtp.client-ip=91.218.175.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="Mal2gON8"
X-Envelope-To: git@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=i9X+gulancO/6amvfc60uKgPbEeEVz6B/Uk//oM+Fyk=;
 c=simple/simple; d=iotcl.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788182053; v=1; x=1788786853;
 b=Mal2gON8iP+clmoFUjC4ss7AJRuHBYBUhdbXJZLPHODcywuQYHHQ3v5Ls8bghwSgK/DaP580
 Ib/svbaT7folyc3CKSJNJH3lBP9JfQK13sDr19Xug7eKa0GgPeExePKuXElStX63LgkH9XTUHyh
 SlKCowc3YoIdW9MdSMotVJzI=
X-Envelope-To: git@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id b25227591e2e5973;
	Mon, 31 Aug 2026 13:14:13 +0000
X-Mizu-Trace-ID: b25227591e2e5973
X-Migadu-Flow: FLOW_OUT
From: Toon Claes <toon@iotcl.com>
Date: Mon, 31 Aug 2026 15:13:48 +0200
Subject: [PATCH v9 2/3] replay: resolve the replay base outside
 pick_regular_commit()
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-toon-git-replay-drop-merges-v9-2-61c4232c6f36@iotcl.com>
References: <20260831-toon-git-replay-drop-merges-v9-0-61c4232c6f36@iotcl.com>
In-Reply-To: <20260831-toon-git-replay-drop-merges-v9-0-61c4232c6f36@iotcl.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Justin Tobler <jltobler@gmail.com>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.16-dev-9febb

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
2.55.0.679.g6767b8d81c

