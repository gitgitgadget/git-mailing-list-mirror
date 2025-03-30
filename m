Received: from mail.normalmode.org (h01.normalmode.org [157.230.60.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B665524F
	for <git@vger.kernel.org>; Sun, 30 Mar 2025 11:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.230.60.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743334146; cv=none; b=pxWzt/cKtXvgOrc66VQ0HzrmUP8IPmNFSws8nO4C/SAieBhP5//EAkmbP58U/LgBhkYTHHytHSaQ/W0vXYqNEddirpudQp54FZQlFagWjdS5VG5W9UiLEExUz6BDlsvQp4kdtnZ/hSgvqgcG1eUA0mTATg2bA6+HsoUTMw1fvks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743334146; c=relaxed/simple;
	bh=rwqB/PHaqlT4UOex1PNB756DS+eQRCKcT+0c2WnC+7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FzkVZA3fO2TDcVN9Iyvak6o3qrg59jDuGGsAVyD6Q4IAjAotCZu21DpLyPtp9P75nTojLMEi9b9Kb63XI9Pj1hsDk7G3G+bedU97iACPN7Ax/lOhxmKTAlA4A+KX1Pk+WPqmP45mHMyMkRRNri0EibcW6tdYOl37wVpRJFRtt/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us; spf=pass smtp.mailfrom=lfurio.us; dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b=aRo4myCF; arc=none smtp.client-ip=157.230.60.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lfurio.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b="aRo4myCF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lfurio.us; s=default;
	t=1743334143; bh=rwqB/PHaqlT4UOex1PNB756DS+eQRCKcT+0c2WnC+7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aRo4myCF4gERmgzsAZLC0qRL9EOfNXzlmaZFQWD2XG8ij6yre65c3VFe5pxHo3SM5
	 ddrpAi8FukoPRds/ciKvgTgfKMFn/nfor5ahYcrFh8NGTg4nbNpL/9GBvYM9ugiTQU
	 vO5n7tVtY3b9DDh5yUQwc+5hulRiT4AgnX7GXagw=
Received: by mail.normalmode.org (Postfix) with ESMTPSA id 37FE2616F2;
	Sun, 30 Mar 2025 11:29:03 +0000 (UTC)
From: Matt Hunter <m@lfurio.us>
To: git@vger.kernel.org
Cc: Matt Hunter <m@lfurio.us>,
	Johannes Sixt <j6t@kdbg.org>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2] revision: fix --left/right-only use with unrelated histories
Date: Sun, 30 Mar 2025 07:24:06 -0400
Message-ID: <20250330112850.2477673-1-m@lfurio.us>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250330055809.1019090-1-m@lfurio.us>
References: <20250330055809.1019090-1-m@lfurio.us>
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

Range-diff against v1:
1:  1982f14d70 ! 1:  4f5b264b26 revision: fix --left/right-only use with unrelated histories
    @@ t/t6000-rev-list-misc.sh: test_expect_success 'rev-list --unpacked' '
     +	git rev-list --left-only  HEAD...cmp >head &&
     +	git rev-list --right-only HEAD...cmp >cmp  &&
     +
    -+	test $(comm -12 <(sort head) <(sort cmp) | wc -l) = "0"
    ++	sort head >head.sorted &&
    ++	sort cmp >cmp.sorted &&
    ++	comm -12 head.sorted cmp.sorted >actual &&
    ++	test_line_count = 0 actual
     +'
     +
      test_done

base-commit: 683c54c999c301c2cd6f715c411407c413b1d84e

 revision.c               |  2 ++
 t/t6000-rev-list-misc.sh | 15 +++++++++++++++
 2 files changed, 17 insertions(+)

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
index 6289a2e8b0..d338f7ecb4 100755
--- a/t/t6000-rev-list-misc.sh
+++ b/t/t6000-rev-list-misc.sh
@@ -182,4 +182,19 @@ test_expect_success 'rev-list --unpacked' '
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
+	sort head >head.sorted &&
+	sort cmp >cmp.sorted &&
+	comm -12 head.sorted cmp.sorted >actual &&
+	test_line_count = 0 actual
+'
+
 test_done
-- 
2.49.0

