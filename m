Received: from mail.normalmode.org (h01.normalmode.org [157.230.60.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B97312E7F
	for <git@vger.kernel.org>; Sun, 30 Mar 2025 06:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.230.60.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743314625; cv=none; b=DF2dwV1kQ9Ho7ZmMktOznl1eagIUqjxT9GS/UxxNNGmCyAal5ThJVH0RKS73hbGMnLUkjuILyjPV12nxFAtwUxAxRqV0ZdWlecNNXEiZBobhvQO+PRIdmEgX8+x8YNa9yt4KPRceVXd+yoRGMb+aUfR04LpzTBpU0lP8SxVrgtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743314625; c=relaxed/simple;
	bh=Fq0yuUvm64eXbhF9oa9SJolGL2Pp+EF3OhQLaMhwJ4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FtSWxreA2WNiigor+YMSEcwFQO/QuqaB79VHNpyo3oLK8s1QGbvxEjJRhGIHpyMRyNGSdVrrOo3o2T1+w2ECb2qYul7LSOJnRO3EXOawwaZLsjwxh9YUYQL7jsTIP47oTWl3Awl1hAuz4pGBVqMHgmX2ho4vq117Kq8UXlwMy5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us; spf=pass smtp.mailfrom=lfurio.us; dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b=qbCZKR1A; arc=none smtp.client-ip=157.230.60.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lfurio.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b="qbCZKR1A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lfurio.us; s=default;
	t=1743314293; bh=Fq0yuUvm64eXbhF9oa9SJolGL2Pp+EF3OhQLaMhwJ4Y=;
	h=From:To:Cc:Subject:Date:From;
	b=qbCZKR1AltsnoJEPQcV4ymfahxtfZANqz0swNWCw/JgIYHMD2pTU+BSTw6YNBKqnz
	 pAtGeNDUOUBqUihJxz9TeG/7dmUAhuEM/RPF1TOZC26HQEXGDbYPARzISZ+0L/H2KL
	 IZlNwfN28aITjAOzqOKzP4Az5+rxZAliEqubXVro=
Received: by mail.normalmode.org (Postfix) with ESMTPSA id AE2D8616F3;
	Sun, 30 Mar 2025 05:58:13 +0000 (UTC)
From: Matt Hunter <m@lfurio.us>
To: git@vger.kernel.org
Cc: Matt Hunter <m@lfurio.us>
Subject: [PATCH] revision: fix --left/right-only use with unrelated histories
Date: Sun, 30 Mar 2025 01:49:24 -0400
Message-ID: <20250330055809.1019090-1-m@lfurio.us>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a similar fix as 023756f4eb (revision walker: --cherry-pick is a
limited operation), but for the --left-only and --right-only options.

When computing a symmetric difference between two unrelated histories,
no suitable merge base exists, and so no boundary commit is flagged as
UNINTERESTING.  Previously, we relied on the presence of such boundary
to trigger limiting and thus consideration of either "revs->left_only"
or "revs->right_only".

A number of other entries in the option parser have started including
overrides for "revs->limited = 1".  Do the same for these options.

Signed-off-by: Matt Hunter <m@lfurio.us>
---

Patch applies to the current maint branch (git v2.49.0).

I made a best guess at what the most logical home for this test case
should be, so please let me know if somewhere else is preferred.  All
tests pass when this is cherry-picked to seen.  There is only a minor
conflict, as a few different tests have appeared in this same spot.

 revision.c               |  2 ++
 t/t6000-rev-list-misc.sh | 12 ++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/revision.c b/revision.c
index c4390f0938..e045445bc3 100644
--- a/revision.c
+++ b/revision.c
@@ -2488,10 +2488,12 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 			die(_("options '%s' and '%s' cannot be used together"),
 			    "--left-only", "--right-only/--cherry");
 		revs->left_only = 1;
+		revs->limited = 1;
 	} else if (!strcmp(arg, "--right-only")) {
 		if (revs->left_only)
 			die(_("options '%s' and '%s' cannot be used together"), "--right-only", "--left-only");
 		revs->right_only = 1;
+		revs->limited = 1;
 	} else if (!strcmp(arg, "--cherry")) {
 		if (revs->left_only)
 			die(_("options '%s' and '%s' cannot be used together"), "--cherry", "--left-only");
diff --git a/t/t6000-rev-list-misc.sh b/t/t6000-rev-list-misc.sh
index 6289a2e8b0..58f1f746e0 100755
--- a/t/t6000-rev-list-misc.sh
+++ b/t/t6000-rev-list-misc.sh
@@ -182,4 +182,16 @@ test_expect_success 'rev-list --unpacked' '
 	test_cmp expect actual
 '
 
+test_expect_success 'rev-list one-sided unrelated symmetric diff' '
+	test_tick &&
+	git commit --allow-empty -m xyz &&
+	git branch cmp &&
+	git rebase --force-rebase --root &&
+
+	git rev-list --left-only  HEAD...cmp >head &&
+	git rev-list --right-only HEAD...cmp >cmp  &&
+
+	test $(comm -12 <(sort head) <(sort cmp) | wc -l) = "0"
+'
+
 test_done

base-commit: 683c54c999c301c2cd6f715c411407c413b1d84e
-- 
2.49.0

