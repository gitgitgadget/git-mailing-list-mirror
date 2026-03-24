Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC6F175A61
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 19:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774380958; cv=none; b=YtKE/dzzykdz9mVxiF6nvcZqUg6Xku37n4k686S7juzbAm3qxaj10knaUZ4S0klDx9wjIfBm+20Hgd0fY1w14pNTEgJLaoqN7OS91ZptYoB5fwBvXWCdP1dUEC2M3fPZv2X/a/BMNhFKJgcJSeDZOxv1OwUJBoJgNTMVnIW1Kos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774380958; c=relaxed/simple;
	bh=KvgIHwIx8Y4uIKsWH3ivAkEUknfDr4atbLickTpeJrg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:
	 In-Reply-To:References:To:Cc; b=SKcoaqRwnKLuKBn1/EDFZ+mSvL5i7c5bMWCApnV8exaIxlEhWH4S+rVihmf81VyeetKcgUl3RiGPl4jAf2eMfr/NIlUbT7UnGTjPQELgmMPFU88VsMFa6hwOJjxxRUKgzEeb3SDouIYOiSOYMgMfd1P75rPkOg6uK/QegRrbHdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=Yw0/9x/R; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="Yw0/9x/R"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1774380952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ilsntOrKwKwO3IWIhUNXkCbZYmFdp1n8MsLoA/4qNqI=;
	b=Yw0/9x/R1fFZQ3JKmy73AORUcbe2SjoXIL2a0oTJBwmEycGo8xS+WBWFbsO9h1HehDE0KR
	Pzjc/s2Fdwo4aOSpoyyhHroQxfEDAeIdy9l/elby9zPgxnjrZVJkLHJkAuDoi+i58DWA9d
	RnAMcpJRS5zuUKkmxilThnkVVkXHxSE=
From: Toon Claes <toon@iotcl.com>
Date: Tue, 24 Mar 2026 20:35:41 +0100
Subject: [PATCH v2] replay: support replaying down from root commit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-toon-replay-down-to-root-v2-1-34e723489f6e@iotcl.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NQQ6CMBBFr0K6dgxTi6gr72FYQDtIDXZIW1FCu
 LsFL+Dy/fz/3ywCeUtBXLJZeBptsOwSyF0mdFe7O4E1iYXM5TE/YAmR2YGnoa8nMPx2KQDPHME
 olLk6tVgqFGk+eGrtZ7u+VT8Or+ZBOq5/a6OzIbKfNveIa+8PzYiAoJtCS3UmLFpztRx1v9f8F
 NWyLF+7hrj40gAAAA==
X-Change-ID: 20260317-toon-replay-down-to-root-d412048f1741
In-Reply-To: <20260317-toon-replay-down-to-root-v1-1-cb5c249e15fd@iotcl.com>
References: <20260317-toon-replay-down-to-root-v1-1-cb5c249e15fd@iotcl.com>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

git-replay(1) doesn't allow replaying commits all the way down to the
root commit. Fix that.

Signed-off-by: Toon Claes <toon@iotcl.com>
---
These changes might conflict Siddharth's series[1] to add '--revert' to
git-replay(1), although resolving that should be trivial.

[1]: https://lore.kernel.org/git/20260313054035.26605-1-siddharthasthana31@gmail.com/
---
Changes in v2:
- Add NULL pointer check for `commit` in mapped_commit().
- Change ancestor message to "empty tree" when replaying root commit.
- Link to v1: https://patch.msgid.link/20260317-toon-replay-down-to-root-v1-1-cb5c249e15fd@iotcl.com
---
 replay.c                 | 27 +++++++++++++++++----------
 t/t3650-replay-basics.sh | 10 +++++++---
 2 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/replay.c b/replay.c
index a63f6714c4..92f2279156 100644
--- a/replay.c
+++ b/replay.c
@@ -209,7 +209,10 @@ static struct commit *mapped_commit(kh_oid_map_t *replayed_commits,
 				    struct commit *commit,
 				    struct commit *fallback)
 {
-	khint_t pos = kh_get_oid_map(replayed_commits, commit->object.oid);
+	khint_t pos;
+	if (!commit)
+		return fallback;
+	pos = kh_get_oid_map(replayed_commits, commit->object.oid);
 	if (pos == kh_end(replayed_commits))
 		return fallback;
 	return kh_value(replayed_commits, pos);
@@ -225,16 +228,24 @@ static struct commit *pick_regular_commit(struct repository *repo,
 	struct commit *base, *replayed_base;
 	struct tree *pickme_tree, *base_tree, *replayed_base_tree;
 
-	base = pickme->parents->item;
-	replayed_base = mapped_commit(replayed_commits, base, onto);
+	if (pickme->parents) {
+		base = pickme->parents->item;
+		base_tree = repo_get_commit_tree(repo, base);
+	} else {
+		base = NULL;
+		base_tree = lookup_tree(repo, repo->hash_algo->empty_tree);
+	}
 
+	replayed_base = mapped_commit(replayed_commits, base, onto);
 	replayed_base_tree = repo_get_commit_tree(repo, replayed_base);
 	pickme_tree = repo_get_commit_tree(repo, pickme);
-	base_tree = repo_get_commit_tree(repo, base);
 
 	merge_opt->branch1 = short_commit_name(repo, replayed_base);
 	merge_opt->branch2 = short_commit_name(repo, pickme);
-	merge_opt->ancestor = xstrfmt("parent of %s", merge_opt->branch2);
+	if (pickme->parents)
+		merge_opt->ancestor = xstrfmt("parent of %s", merge_opt->branch2);
+	else
+		merge_opt->ancestor = xstrdup("empty tree");
 
 	merge_incore_nonrecursive(merge_opt,
 				  base_tree,
@@ -293,8 +304,6 @@ int replay_revisions(struct rev_info *revs,
 	set_up_replay_mode(revs->repo, &revs->cmdline, opts->onto,
 			   &detached_head, &advance, &onto, &update_refs);
 
-	/* FIXME: Should allow replaying commits with the first as a root commit */
-
 	if (prepare_revision_walk(revs) < 0) {
 		ret = error(_("error preparing revisions"));
 		goto out;
@@ -309,9 +318,7 @@ int replay_revisions(struct rev_info *revs,
 		khint_t pos;
 		int hr;
 
-		if (!commit->parents)
-			die(_("replaying down from root commit is not supported yet!"));
-		if (commit->parents->next)
+		if (commit->parents && commit->parents->next)
 			die(_("replaying merge commits is not supported yet!"));
 
 		last_commit = pick_regular_commit(revs->repo, commit, replayed_commits,
diff --git a/t/t3650-replay-basics.sh b/t/t3650-replay-basics.sh
index a03f8f9293..9c55b62757 100755
--- a/t/t3650-replay-basics.sh
+++ b/t/t3650-replay-basics.sh
@@ -81,9 +81,13 @@ test_expect_success 'option --onto or --advance is mandatory' '
 	test_cmp expect actual
 '
 
-test_expect_success 'no base or negative ref gives no-replaying down to root error' '
-	echo "fatal: replaying down from root commit is not supported yet!" >expect &&
-	test_must_fail git replay --onto=topic1 topic2 2>actual &&
+test_expect_success 'replay down to root onto another branch' '
+	git replay --ref-action=print --onto main topic2 >result &&
+
+	test_line_count = 1 result &&
+
+	git log --format=%s $(cut -f 3 -d " " result) >actual &&
+	test_write_lines E D C M L B A >expect &&
 	test_cmp expect actual
 '
 

---
base-commit: ca1db8a0f7dc0dbea892e99f5b37c5fe5861be71
change-id: 20260317-toon-replay-down-to-root-d412048f1741

