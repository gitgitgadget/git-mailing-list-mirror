Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCA23CC337
	for <git@vger.kernel.org>; Fri, 26 Jun 2026 05:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782452927; cv=none; b=dOzM7ZWmJ/gkwrlQjR815TJeb6DdhD//bsimD7GJBEyRF0lIT3aW0g0d3DGFFZIaXPGg+q01NTc5jGKK6felfwOVOIY1XRQPMRsviWCqfHGEm8iPPYcH/xdhA2l7+qkt6xrrgyk2pV0/+Ih7IZlGDpX3ODqs7+SR0pFZwpXJnww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782452927; c=relaxed/simple;
	bh=cZgEb8LMBA1gSR9FeuE9GY1Aj9CW7i52St6IwY96K1s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TLf3LD8qbHFNnd5Fa5dCjtJSYyvHz6BvjzM8VAFAYm80oJL0elBL9rh8aT/l53Xf/RmuoLC0LAxfPd43R+DD7yrQGcqxaOqWVbdVQE2i8gsBL5sYMyLcHj9JEZLI7xeiwWZHNcq9jWShvY1NhotBFMTQUeblh9Xn40SHpsEWp/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=R0/R65eB; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="R0/R65eB"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1782452922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r9RV9aioNLM+dZgcY2iiGH/w4N8lRu1CXaNs3cNk2Kg=;
	b=R0/R65eB5mNwbV8B6sWGcmjdQugdjOSY1RrM96oSVKyVcYb6ws0WfWNrY/eMwHuXLk8YYg
	Kb3dN3By9mqLD/kwiR+J7jeyAMG6JSCoLyrqiNBbglZv81qt1NEOSLO3+B3dw+zVEMjc2z
	QPSsWa/vaQogxnZ9QUf4EXfD6+oTvkk=
From: Toon Claes <toon@iotcl.com>
Date: Fri, 26 Jun 2026 07:48:12 +0200
Subject: [PATCH v5 2/3] replay: better explain how pick_regular_commit()
 picks a base
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260626-toon-git-replay-drop-merges-v5-2-5e120738b9d0@iotcl.com>
References: <20260626-toon-git-replay-drop-merges-v5-0-5e120738b9d0@iotcl.com>
In-Reply-To: <20260626-toon-git-replay-drop-merges-v5-0-5e120738b9d0@iotcl.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

The function pick_regular_commit() will replay the `pickme` commit. To
determine the ancestor where to replay this commit on, it takes the
parent of the commit and looks up its replayed result in
`replayed_commits`. If no ancestor is found, the `onto` parameter is
used as fallback.

The name `onto` is rather confusing, so rename it to `default_base`. And
while at it, shuffle the function parameters so `struct commit`
parameters are immediate siblings.

When in mode REPLAY_MODE_REVERT, the fallback `default_base` will always
be used. This happens because commits are replayed in reverse order, so
looking up the `pickme`'s parent in `replayed_commits` will always
return empty. And to make these commits stack on top of each other, we
need to pass in `last_commit`.

Signed-off-by: Toon Claes <toon@iotcl.com>
---
 replay.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/replay.c b/replay.c
index 7bde1c7e93..86fba47fb9 100644
--- a/replay.c
+++ b/replay.c
@@ -280,8 +280,8 @@ static void put_mapped_commit(kh_oid_map_t *replayed_commits,
 
 static struct commit *pick_regular_commit(struct repository *repo,
 					  struct commit *pickme,
+					  struct commit *default_base,
 					  kh_oid_map_t *replayed_commits,
-					  struct commit *onto,
 					  struct merge_options *merge_opt,
 					  struct merge_result *result,
 					  enum replay_mode mode,
@@ -298,7 +298,7 @@ static struct commit *pick_regular_commit(struct repository *repo,
 		base_tree = lookup_tree(repo, repo->hash_algo->empty_tree);
 	}
 
-	replayed_base = get_mapped_commit(replayed_commits, base, onto);
+	replayed_base = get_mapped_commit(replayed_commits, base, default_base);
 	replayed_base_tree = repo_get_commit_tree(repo, replayed_base);
 	pickme_tree = repo_get_commit_tree(repo, pickme);
 
@@ -439,11 +439,23 @@ int replay_revisions(struct rev_info *revs,
 	while ((commit = get_revision(revs))) {
 		const struct name_decoration *decoration;
 
+		/*
+		 * pick_regular_commit() looks up the parent of `commit` in
+		 * `replayed_commits` to determine the ancestor to replay onto.
+		 * The `default_base` parameter is used when no ancestor is found,
+		 * which happens for the first commit in the revision range.
+		 * When reverting, commits are replayed in reverse order, so the
+		 * lookup never succeeds, and we need to pass `last_commit`.
+		 */
+		struct commit *base = onto;
+		if (mode == REPLAY_MODE_REVERT)
+			base = last_commit;
+
 		if (commit->parents && commit->parents->next)
 			die(_("replaying merge commits is not supported yet!"));
 
-		last_commit = pick_regular_commit(revs->repo, commit, replayed_commits,
-						  mode == REPLAY_MODE_REVERT ? last_commit : onto,
+		last_commit = pick_regular_commit(revs->repo, commit, base,
+						  replayed_commits,
 						  &merge_opt, &result, mode, opts->empty);
 		if (!last_commit)
 			break;

-- 
2.53.0.1323.g189a785ab5

