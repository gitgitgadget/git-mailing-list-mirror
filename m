Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DAF423A65
	for <git@vger.kernel.org>; Tue, 16 Jun 2026 09:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781602044; cv=none; b=Dz+jDMHYjgq8RCHJ/dE8Sv8CdCS7wT7Z5mZ9cU9VHfEva/pilumLUlEr2Yjhid/VzeHxR1Pu/mJAbdNrOOWPHIpQvrHyZP2gHO1LY8sDO2iXsUXz/YcgOM+ewn3Twsw9bXejuZB5cqpWPYuqb0nThpn65vV19B6LIczC3bOw0Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781602044; c=relaxed/simple;
	bh=prFBX61Qql/cVBkZZkdJanaYevpXcvPgKew1Vv3oKQQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N+Zt1EQ4CMJvTxjzde9zmK4qw6XJ08K68o40LjNvhF43OG2575h1PQJPb6cdVAYlcXx0RjIALSxDZj5XsZLgTDouxLdby39es9S7bdjZcvw8jrM3AMaYReMY44rHeNbNAwXsB0ZwxlAFlWuEY82KrJz2ljBGfMCLsWqpG9AiCTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=5/nj/BUB; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="5/nj/BUB"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1781602041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pPY2A8d+4mqTEQqqn2krGb2vSfMTbnaz2WeBow7i5Es=;
	b=5/nj/BUBrKxMzF4ea2Fa9gRA8h7T4v8nllY3wFI0yZUxzRDsSX1cHCn8zXFi0Kw80LNUQW
	3RjnokfbE0EY7jyIOfkYzSv/OUIvajQ83aUcw67mrDqSogI/2HGi51Xjl3xTyCQbJ6waJU
	dGJQb4sl2ckG14FiO73vzNA03tHbTyc=
From: Toon Claes <toon@iotcl.com>
Date: Tue, 16 Jun 2026 11:26:36 +0200
Subject: [PATCH v3 2/3] replay: add helper to put entry into mapped_commits
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260616-toon-git-replay-drop-merges-v3-2-153e9eb99ce1@iotcl.com>
References: <20260616-toon-git-replay-drop-merges-v3-0-153e9eb99ce1@iotcl.com>
In-Reply-To: <20260616-toon-git-replay-drop-merges-v3-0-153e9eb99ce1@iotcl.com>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>
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

