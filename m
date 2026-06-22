Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15F53998B7
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 12:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782132143; cv=none; b=LRRlnnfzKjARniVMARxO7YdwY7dfyPAlDpzyy9g1zd+C6UWNeNGcreMnm0OfrQ9obKAee1boWcpKKtzSolNHq4YC7fDngnM9UlGbPm96fL4NsDzxvcKU+rV4euUmfPbN5I9Hp3u9Mi3rTgRaaU+5bezBK/n05P+xfE09WLtH9LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782132143; c=relaxed/simple;
	bh=prFBX61Qql/cVBkZZkdJanaYevpXcvPgKew1Vv3oKQQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o3OWhCHT/VvUjttevXbEMvIV3nOfmbuBlqAr0y8uWgrfoXFvUUfsk20JFuNg8MiuzuxNSWctKY+ZjmyK6XeoE7CJzSdJ8RI/5cXMYDcGSod6JMKEiXLhsh9zvG0hN1qGKXY1KPdAGtbxIKGGLpwMTQ0R5gnEUceOiMYM7Z5Mt1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=yFk/lcV8; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="yFk/lcV8"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1782132140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pPY2A8d+4mqTEQqqn2krGb2vSfMTbnaz2WeBow7i5Es=;
	b=yFk/lcV8+Fo5QlQDm09kT+fvvwsYDqYhEGyupFNi9OyiZ3yg+L67f0a6dEFxFAAwiDDQ5M
	fuA/zjVlotyRGdax294XNEZHiLintXHbvleSN9CcNkCjEDcocP2Jz8jYLlN16bJV1z4xPE
	WB/bQDU7SqrdSh7bZNQ40JwbzsHBdrY=
From: Toon Claes <toon@iotcl.com>
Date: Mon, 22 Jun 2026 14:41:56 +0200
Subject: [PATCH v4 2/3] replay: add helper to put entry into mapped_commits
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-toon-git-replay-drop-merges-v4-2-ff257f534319@iotcl.com>
References: <20260622-toon-git-replay-drop-merges-v4-0-ff257f534319@iotcl.com>
In-Reply-To: <20260622-toon-git-replay-drop-merges-v4-0-ff257f534319@iotcl.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

The function replay_revisions() in replay.c is rather lengthy. Extract
the logic to put a commit entry into mapped_commits into a helper
function put_mapped_commit().

While at it, rename mapped_commit() to get_mapped_commit() to pair with
this new function.

Signed-off-by: Toon Claes <toon@iotcl.com>
---
 replay.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/replay.c b/replay.c
index 1f8e5b083b..7921d7dba3 100644
--- a/replay.c
+++ b/replay.c
@@ -243,9 +243,9 @@ static void set_up_replay_mode(struct repository *repo,
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
@@ -256,6 +256,21 @@ static struct commit *mapped_commit(kh_oid_map_t *replayed_commits,
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
+		BUG("Duplicate rewritten commit: %s\n",
+		    oid_to_hex(&commit->object.oid));
+
+	kh_value(replayed_commits, pos) = new_commit;
+}
+
 static struct commit *pick_regular_commit(struct repository *repo,
 					  struct commit *pickme,
 					  kh_oid_map_t *replayed_commits,
@@ -276,7 +291,7 @@ static struct commit *pick_regular_commit(struct repository *repo,
 		base_tree = lookup_tree(repo, repo->hash_algo->empty_tree);
 	}
 
-	replayed_base = mapped_commit(replayed_commits, base, onto);
+	replayed_base = get_mapped_commit(replayed_commits, base, onto);
 	replayed_base_tree = repo_get_commit_tree(repo, replayed_base);
 	pickme_tree = repo_get_commit_tree(repo, pickme);
 
@@ -414,8 +429,6 @@ int replay_revisions(struct rev_info *revs,
 	replayed_commits = kh_init_oid_map();
 	while ((commit = get_revision(revs))) {
 		const struct name_decoration *decoration;
-		khint_t pos;
-		int hr;
 
 		if (commit->parents && commit->parents->next)
 			die(_("replaying merge commits is not supported yet!"));
@@ -427,11 +440,7 @@ int replay_revisions(struct rev_info *revs,
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

