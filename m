Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAC4381E89
	for <git@vger.kernel.org>; Thu,  2 Jul 2026 17:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783015139; cv=none; b=BfU3XNS5b42SZmVXB1Fk8PDLSiBQCSkedbWTL56p74N3R2eCt86t1HfOeXdK8XdcI18r8a+CCHKrjOX+osJ4dHDwvuR/n1M8WV2p3Gr7XBD/VNiYVKc/3pZ2Y0FgtidotUk7U9B6UgdJb123rov98YSmwzIel2kHV+CcVFQThR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783015139; c=relaxed/simple;
	bh=1dA0u4BZz2yEkhqsrtQy1tAsPyEN954WY4VXxFdMPR4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qSPh8D6liBzEMBk0K6leYfgdUM8IxYM98HfEo3iA1OcjqY4JpOslFQIqHGmRFImsLYCeWqicpzuYI9Bwoq+bTL6J0ZHAnim2cvI/gfS6+ZQ/yB6nCtRiDXwz/QLvp7be2leZox948ezkWt/35tZmQNoLWLw0CxZeXMVM8cSV204=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=H10oTirM; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="H10oTirM"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1783015135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PDyyTJtLg3ZqA9bur8gL2Uk9iqAx03w1V0g6I25VSC0=;
	b=H10oTirMjTV17QN3jRmUcogamRNX9OTty81J5h2BRPCpZ9Y33gmx2TgjyGkh/s1XAlCMI4
	Ej5NR2C5J/7NXwzll51ayI0gNR+fjNi8cAOYR0wYRQ1IHVeLNaMPu/NsNFM3dbcjYTnVo/
	LXeu67hXgrxyDdimaKYHWDiXszcYLlc=
From: Toon Claes <toon@iotcl.com>
Date: Thu, 02 Jul 2026 19:58:43 +0200
Subject: [PATCH v6 1/3] replay: add helper to put entry into
 replayed_commits
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-toon-git-replay-drop-merges-v6-1-78a07cdd0382@iotcl.com>
References: <20260702-toon-git-replay-drop-merges-v6-0-78a07cdd0382@iotcl.com>
In-Reply-To: <20260702-toon-git-replay-drop-merges-v6-0-78a07cdd0382@iotcl.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Toon Claes <toon@iotcl.com>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
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

