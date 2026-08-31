Received: from mta1.migadu.com (out-125.mta1.migadu.com [95.215.58.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F05D3358B0
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 13:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788182055; cv=none; b=NPYO+SuZeFk33yUqcYIWAvZta473jz2O3a6XmkmZn4L3QRuDGm0RuvH1u3GwJ2I6YrpObexPrNh9MvZiT//WL6EizrkXCBiq4uoX1zagb3GUN8tlU1P9fPEcusIOMyBeDjdFm5dUzr4xgu1rruiVh4QgImOyLBo97S4ykqx7aR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788182055; c=relaxed/simple;
	bh=Y880xEbon/0V7ui2RBLkXVNgGy8P8FAil3cm4r//J00=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j8UHpuU/8lSHo3pGEM1Q+bQXLYbTe1IRbM5szZqo9aOHZXvjiRCGU4/Zsvxajk/kJctmPGhQ9pp5/7zwPzYBRJwtoRqTERkhDuTlTJ4qkrVe+hNksGLF7Hje4PNJdJTtARzY9AjQHhlg8DFfS4D3WgLJ0HlA3bVER8WrQ6QnQ9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=gO1blrsb; arc=none smtp.client-ip=95.215.58.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="gO1blrsb"
X-Envelope-To: git@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Y880xEbon/0V7ui2RBLkXVNgGy8P8FAil3cm4r//J00=;
 c=simple/simple; d=iotcl.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788182050; v=1; x=1788786850;
 b=gO1blrsbPNJEpkmjf5q634I4mJScS282sQyOIPYoJCmwpvWFeLNF71KVAWFsBXCGBwbamz0w
 QNhz1j1Hfpe3d8OEpFsLBS+epbZiX/ogKLnderT7clkWFY7f2QJK/EvuCLt/KGJPakPqwEAEPTo
 5NjYwI8X30oL336U4w3jH5CQ=
X-Envelope-To: git@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 6249c06dc26af3cd;
	Mon, 31 Aug 2026 13:14:10 +0000
X-Mizu-Trace-ID: 6249c06dc26af3cd
X-Migadu-Flow: FLOW_OUT
From: Toon Claes <toon@iotcl.com>
Date: Mon, 31 Aug 2026 15:13:47 +0200
Subject: [PATCH v9 1/3] replay: add helper to put entry into
 replayed_commits
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-toon-git-replay-drop-merges-v9-1-61c4232c6f36@iotcl.com>
References: <20260831-toon-git-replay-drop-merges-v9-0-61c4232c6f36@iotcl.com>
In-Reply-To: <20260831-toon-git-replay-drop-merges-v9-0-61c4232c6f36@iotcl.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Justin Tobler <jltobler@gmail.com>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.16-dev-9febb

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
index 463c900d6c..860e194ba0 100644
--- a/replay.c
+++ b/replay.c
@@ -254,9 +254,9 @@ static void set_up_replay_mode(struct repository *repo,
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
@@ -267,6 +267,21 @@ static struct commit *mapped_commit(kh_oid_map_t *replayed_commits,
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
@@ -287,7 +302,7 @@ static struct commit *pick_regular_commit(struct repository *repo,
 		base_tree = lookup_tree(repo, repo->hash_algo->empty_tree);
 	}
 
-	replayed_base = mapped_commit(replayed_commits, base, onto);
+	replayed_base = get_mapped_commit(replayed_commits, base, onto);
 	replayed_base_tree = repo_get_commit_tree(repo, replayed_base);
 	pickme_tree = repo_get_commit_tree(repo, pickme);
 
@@ -427,8 +442,6 @@ int replay_revisions(struct rev_info *revs,
 	replayed_commits = kh_init_oid_map();
 	while ((commit = get_revision(revs))) {
 		const struct name_decoration *decoration;
-		khint_t pos;
-		int hr;
 
 		if (commit->parents && commit->parents->next)
 			die(_("replaying merge commits is not supported yet!"));
@@ -440,11 +453,7 @@ int replay_revisions(struct rev_info *revs,
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
2.55.0.679.g6767b8d81c

