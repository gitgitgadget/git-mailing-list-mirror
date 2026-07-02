Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FD637A83D
	for <git@vger.kernel.org>; Thu,  2 Jul 2026 17:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783015149; cv=none; b=ua88Itksk95UaILSkJP9hSfL3CpBoLCEHj9O0ZmyMx7xc/5DfNYnf9sIOp87AlRi7Cs3ipsylTe4SMWEErkG9EdkBcadVVKCE59Td4zFHSLsip4mmdhed8c1N9pa+6osoDX42mGnEoauTy4jgpK1d3y3r6NW3ClRcvqdHaJNGnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783015149; c=relaxed/simple;
	bh=pnQQFQpDZUOQ4s0cWjIMfvgideeZ1ApxCOLyhViToJI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OIYTg9qfYQAnhhskVhK51YxXByEf+5oARuIyQPfMOed6bXWlDXxsVpIm8906tMhIhR7xTek5ds5PvzQ/lvKRy1dFh/zi3Xua7kuj9EcnY3rThPCCmvmtY8Ef2aLyLEDI1eH0AI3fT+R0H3vjh/eQt+g4WxJG1z4EqruPDUATh6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=TidhNQRr; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="TidhNQRr"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1783015144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cn+9pzfINZKZi7zNQMVCLyr5qPgtBBo+DHq3+rgeTGc=;
	b=TidhNQRrJBXvYJwf6QZHIHxva39jJXUbiMta9I4N7jInBSyanD9reJJJIXrdwhpioWk1uc
	FuMHc1GdXN6DUURSgbwkYWmoX9cfjmTmH7g5byKExzklrqSr3+EB7GIYuYShDKdpCGuxC2
	D4B/z4KQG2pdbVL8g4BLq+uiFX+V3nU=
From: Toon Claes <toon@iotcl.com>
Date: Thu, 02 Jul 2026 19:58:44 +0200
Subject: [PATCH v6 2/3] replay: resolve the replay base outside
 pick_regular_commit()
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-toon-git-replay-drop-merges-v6-2-78a07cdd0382@iotcl.com>
References: <20260702-toon-git-replay-drop-merges-v6-0-78a07cdd0382@iotcl.com>
In-Reply-To: <20260702-toon-git-replay-drop-merges-v6-0-78a07cdd0382@iotcl.com>
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
reduces the number of parameters of pick_regular_commit(), making it's
interface cleaner.

This refactoring doesn't bring any behavior changes.

Signed-off-by: Toon Claes <toon@iotcl.com>
---
 replay.c | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/replay.c b/replay.c
index b9f8fc47ce..5aee0eafbc 100644
--- a/replay.c
+++ b/replay.c
@@ -280,25 +280,19 @@ static void put_mapped_commit(kh_oid_map_t *replayed_commits,
 
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
 
@@ -439,12 +433,26 @@ int replay_revisions(struct rev_info *revs,
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
2.53.0.1323.g189a785ab5

