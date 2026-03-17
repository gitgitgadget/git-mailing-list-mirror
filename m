Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3002D838C
	for <git@vger.kernel.org>; Tue, 17 Mar 2026 18:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773773837; cv=none; b=AhN5QLlu504tdzvXYMBJcNBe+4WBaEJE7w+kzQCaW3H9WC5nmf5NBg4gzdB5Vnfctg36T8gN6w2/fT1n6JPMBjth3dlqrpCwp9GCs4sqBDtYPfcsJYh54+pzNA7LavewMzfZOpSvOBeUYqk7MryXU/rbh8PbeD4bsuQOVbGk0W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773773837; c=relaxed/simple;
	bh=TWsD2NJdUSNz80/avQ6sjhTjNbJXV2X0RLBktG9uAOE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=uGGAOBKzv6mcgVhAK3tM0KjwB+00C6dkicWCowD6yz/tHFajOGRI1JrGjmPmvsF7Gro+O3szmKLbwdPboXYUV7Fu4E+DOp1wfBaagf13AVDD4jaGN6Kn/8GM+A4vw7bBX9LXH7Xvq+I8n1upDCDM0pjFDPM9BNX+e/j56yiEVNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=eom9KPm7; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="eom9KPm7"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1773773827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DGi/p3XUBCXUBmuu0x+6D/SooAANZXGXMIM7hn4Nsg4=;
	b=eom9KPm7+LH9C6TZjPiMylrbuX1xbOo7+wenoJWVTt/lf654vssJ5z2sWrQmXEaAMSqk1j
	ztg44/P2TVkeJbyGMyH61O4zTG0nj4oXf8ZlzLtfmprlbzY93TtGVfBgJ9l2ufWL6Plt1N
	IqlPV2vXI4Dd0m8ZOFY1o/img3K6oyQ=
From: Toon Claes <toon@iotcl.com>
Date: Tue, 17 Mar 2026 19:56:26 +0100
Subject: [PATCH] replay: support replaying down from root commit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260317-toon-replay-down-to-root-v1-1-cb5c249e15fd@iotcl.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXM3QrCMAyG4VsZOTbQdMWJtyIebGumEWlG2vnD2
 L1b9fD54HtXyGzCGY7NCsYPyaKpgnYNjNc+XRglVoN3fu9a6rCoJjSe7/0boz5THdBUC8ZA3oX
 DRF0gqPfZeJLXL306/52X4cZj+fZg2z4vQJ3gfAAAAA==
X-Change-ID: 20260317-toon-replay-down-to-root-d412048f1741
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
 replay.c                 | 18 ++++++++++--------
 t/t3650-replay-basics.sh | 10 +++++++---
 2 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/replay.c b/replay.c
index a63f6714c4..63ff56552e 100644
--- a/replay.c
+++ b/replay.c
@@ -225,12 +225,18 @@ static struct commit *pick_regular_commit(struct repository *repo,
 	struct commit *base, *replayed_base;
 	struct tree *pickme_tree, *base_tree, *replayed_base_tree;
 
-	base = pickme->parents->item;
-	replayed_base = mapped_commit(replayed_commits, base, onto);
+	if (pickme->parents) {
+		base = pickme->parents->item;
+		replayed_base = mapped_commit(replayed_commits, base, onto);
+		base_tree = repo_get_commit_tree(repo, base);
+	} else {
+		base = NULL;
+		replayed_base = onto;
+		base_tree = lookup_tree(repo, repo->hash_algo->empty_tree);
+	}
 
 	replayed_base_tree = repo_get_commit_tree(repo, replayed_base);
 	pickme_tree = repo_get_commit_tree(repo, pickme);
-	base_tree = repo_get_commit_tree(repo, base);
 
 	merge_opt->branch1 = short_commit_name(repo, replayed_base);
 	merge_opt->branch2 = short_commit_name(repo, pickme);
@@ -293,8 +299,6 @@ int replay_revisions(struct rev_info *revs,
 	set_up_replay_mode(revs->repo, &revs->cmdline, opts->onto,
 			   &detached_head, &advance, &onto, &update_refs);
 
-	/* FIXME: Should allow replaying commits with the first as a root commit */
-
 	if (prepare_revision_walk(revs) < 0) {
 		ret = error(_("error preparing revisions"));
 		goto out;
@@ -309,9 +313,7 @@ int replay_revisions(struct rev_info *revs,
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

