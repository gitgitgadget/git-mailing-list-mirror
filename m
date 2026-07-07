Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E9A44DB95
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 19:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783451278; cv=none; b=YeWgqZDyA68L07eBNLhEzM3afyvaV3hhc94EHcsZ/rVFFkyWCtPIDnZ+EBUMdZ7CU6Y9FY+QyPufAvenrlRqSh6GTY1znIcO75K5U7jhx8FQWD0paNYBCOWPbuujugli9sGpIjR8en91T2S7JnXlvMoUw7NpYrnTIhnlWEM2s/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783451278; c=relaxed/simple;
	bh=qtduuihNZ6DJOcUXwAAEPVIDC7L7cJ+l5nHdk231I14=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ba8FwSTMA37pmL8FTCg427WP40+CtM+mGyrNE9xkf9W57UcomOiGLr7S4qT67ktcejdlFvEfi+g/sDRptKib+B9i8PTs8+s2xXSg2uZ7dM+zo86X6AK8kjV+xFi2bZ3WK00wDinZMuU2vK8qHOceBC2r9muiuwlNIV+lHgDC940=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=xLTvp3ob; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="xLTvp3ob"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1783451264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZH/ygRau3e2GtdvLo+GJuU4Wn5F1xpr24MJS/4om5l8=;
	b=xLTvp3obDS9/4sgBWR3qNHw/jJAhOXaqaFPIz/X2TWn+qnEh7CX6FyZ+y02AVeGFqg6Jst
	S0HN4fKmZY4qVNQhm7EZ4LcKAMzBTtvj/mblrHU34ngtjbk0wk4DSS7DWD4LX7YdXKA9PA
	JfBn185LXrtD2h+syfIlt60SNQjkZKE=
From: Toon Claes <toon@iotcl.com>
Date: Tue, 07 Jul 2026 21:07:25 +0200
Subject: [PATCH v7 1/3] replay: add helper to put entry into
 replayed_commits
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-toon-git-replay-drop-merges-v7-1-808ab9b4afa6@iotcl.com>
References: <20260707-toon-git-replay-drop-merges-v7-0-808ab9b4afa6@iotcl.com>
In-Reply-To: <20260707-toon-git-replay-drop-merges-v7-0-808ab9b4afa6@iotcl.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Toon Claes <toon@iotcl.com>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Migadu-Flow: FLOW_OUT

The function replay_revisions() in replay.c is rather lengthy. Extract
the logic to put a commit entry into a `struct mapped_commits` into a
helper function put_mapped_commit().

While at it, rename mapped_commit() to get_mapped_commit() to pair with
this new function.

Signed-off-by: Toon Claes <toon@iotcl.com>
---
 replay.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/replay.c b/replay.c
index da531d5bc6..b9f8fc47ce 100644
--- a/replay.c
+++ b/replay.c
@@ -250,9 +250,9 @@ static void set_up_replay_mode(struct repository *repo,
 	strset_clear(&rinfo.positive_refs);
 }
 
-static struct commit *mapped_commit(kh_oid_map_t *replayed_commits,
-				    struct commit *commit,
-				    struct commit *fallback)
+static struct commit *get_mapped_commit(kh_oid_map_t *replayed_commits,
+					struct commit *commit,
+					struct commit *fallback)
 {
 	khint_t pos;
 	if (!commit)
@@ -263,6 +263,21 @@ static struct commit *mapped_commit(kh_oid_map_t *replayed_commits,
 	return kh_value(replayed_commits, pos);
 }
 
+static void put_mapped_commit(kh_oid_map_t *replayed_commits,
+			      struct commit *commit,
+			      struct commit *new_commit)
+{
+	khint_t pos;
+	int ret;
+
+	pos = kh_put_oid_map(replayed_commits, commit->object.oid, &ret);
+	if (ret == 0)
+		BUG("Duplicate rewritten commit: %s",
+		    oid_to_hex(&commit->object.oid));
+
+	kh_value(replayed_commits, pos) = new_commit;
+}
+
 static struct commit *pick_regular_commit(struct repository *repo,
 					  struct commit *pickme,
 					  kh_oid_map_t *replayed_commits,
@@ -283,7 +298,7 @@ static struct commit *pick_regular_commit(struct repository *repo,
 		base_tree = lookup_tree(repo, repo->hash_algo->empty_tree);
 	}
 
-	replayed_base = mapped_commit(replayed_commits, base, onto);
+	replayed_base = get_mapped_commit(replayed_commits, base, onto);
 	replayed_base_tree = repo_get_commit_tree(repo, replayed_base);
 	pickme_tree = repo_get_commit_tree(repo, pickme);
 
@@ -423,8 +438,6 @@ int replay_revisions(struct rev_info *revs,
 	replayed_commits = kh_init_oid_map();
 	while ((commit = get_revision(revs))) {
 		const struct name_decoration *decoration;
-		khint_t pos;
-		int hr;
 
 		if (commit->parents && commit->parents->next)
 			die(_("replaying merge commits is not supported yet!"));
@@ -436,11 +449,7 @@ int replay_revisions(struct rev_info *revs,
 			break;
 
 		/* Record commit -> last_commit mapping */
-		pos = kh_put_oid_map(replayed_commits, commit->object.oid, &hr);
-		if (hr == 0)
-			BUG("Duplicate rewritten commit: %s\n",
-			    oid_to_hex(&commit->object.oid));
-		kh_value(replayed_commits, pos) = last_commit;
+		put_mapped_commit(replayed_commits, commit, last_commit);
 
 		/* Update any necessary branches */
 		if (ref)

-- 
2.53.0.1323.g189a785ab5

