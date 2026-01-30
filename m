Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7D9322557
	for <git@vger.kernel.org>; Fri, 30 Jan 2026 14:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769783236; cv=none; b=Np7P+FkanlOyQX5caz+xAxXzqI7cMrlb52fnkUT+heqxJUFqIkgwdIZLy/dXejZq1oRmFBoLypLCR2wIwSQg1dWgr8rtLdk3+SvnQFFpCIg1c0K3rMgdV96AQnO5EDM252uZJ6jljYGSyMey4RWN6HEozzQ+57GCYx/yoa+g1CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769783236; c=relaxed/simple;
	bh=p8OpQzRnfIP5jAtfpSEhg9Yc5WYt70z/nJ6BOsH4208=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RhuJonxwtX1qhPgjVL4Eb4kCX9A7BstUvMCMy9XtO8lVzy/LD654QwQxa/Lml1CH/36/COUqRS4N9UfKoV+zQXcIR2IV6LajAm7osMDpeehR+0qvjlPayN8LWhfVt3gVNidYNWzF5d+zzDYDH3Y3qb4c72x3o00dxqcqkt0wVA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=gB6gpMWz; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="gB6gpMWz"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1769783230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=spO5AbFTpvjpDoO540QhbkACl5C8TsdHXQDjgInu3qI=;
	b=gB6gpMWzX0cPm9knDWVySGLk9jb8Cr+o0FanPeTWkYfe+lS83t6jzlCBb21Yd6Dtke2gxc
	Z0V3FVdflI2T2qnOwmaVMTsr+4dRtmsDcVdfDFMJPeio1WXjEelxWivpF/0TFCTFGBrRAq
	nQmiO3XuDyJiM6UmZPam2G/Lmg0YDCE=
From: Toon Claes <toon@iotcl.com>
Date: Fri, 30 Jan 2026 15:26:38 +0100
Subject: [PATCH v6 4/4] last-modified: verify revision argument is a
 commit-ish
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260130-toon-last-modified-tree-v6-4-db827e5df985@iotcl.com>
References: <20260130-toon-last-modified-tree-v6-0-db827e5df985@iotcl.com>
In-Reply-To: <20260130-toon-last-modified-tree-v6-0-db827e5df985@iotcl.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Gusted <gusted@codeberg.org>, Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

Passing a non-committish revision to git-last-modified(1) triggers the
following BUG:

    git last-modified HEAD^{tree}
    BUG: builtin/last-modified.c:456: paths remaining beyond boundary in last-modified

Fix this error by ensuring that the given revision peels to a commit.

This change also adds a test to verify git-last-modified(1) can operate
on an annotated tag. For this an annotated tag is added that points to
the second commit. But this causes ambiguous results when calling
git-name-rev(1) with `--tags`, because now two tags point to the same
commit. To remove this ambiguity, pass `--exclude=<tag>` to
git-name-rev(1) to exclude the new annotated tag.

Reported-by: Gusted <gusted@codeberg.org>
Signed-off-by: Toon Claes <toon@iotcl.com>
---
 builtin/last-modified.c  |  5 +++++
 t/t8020-last-modified.sh | 15 ++++++++++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/builtin/last-modified.c b/builtin/last-modified.c
index e02ec8428b..d0944673f0 100644
--- a/builtin/last-modified.c
+++ b/builtin/last-modified.c
@@ -150,6 +150,11 @@ static int populate_paths_from_revs(struct last_modified *lm)
 			goto out;
 		}
 
+		if (!repo_peel_to_type(lm->rev.repo, obj->path, 0, obj->item, OBJ_COMMIT)) {
+			ret = error(_("revision argument '%s' is a %s, not a commit-ish"), obj->name, type_name(obj->item->type));
+			goto out;
+		}
+
 		diff_tree_oid(lm->rev.repo->hash_algo->empty_tree,
 			      &obj->item->oid, "", &diffopt);
 		diff_flush(&diffopt);
diff --git a/t/t8020-last-modified.sh b/t/t8020-last-modified.sh
index d1aad12319..ec5bdc6aa0 100755
--- a/t/t8020-last-modified.sh
+++ b/t/t8020-last-modified.sh
@@ -8,6 +8,7 @@ test_expect_success 'setup' '
 	test_commit 1 file &&
 	mkdir a &&
 	test_commit 2 a/file &&
+	git tag -mA t2 2 &&
 	mkdir a/b &&
 	test_commit 3 a/b/file
 '
@@ -30,7 +31,7 @@ check_last_modified() {
 
 	cat >expect &&
 	git ${indir:+-C "$indir"} last-modified "$@" >tmp.1 &&
-	git name-rev --annotate-stdin --name-only --tags \
+	git name-rev --annotate-stdin --name-only --tags --exclude=t2 \
 		<tmp.1 >tmp.2 &&
 	tr '\t' ' ' <tmp.2 >actual &&
 	test_cmp expect actual
@@ -51,6 +52,13 @@ test_expect_success 'last-modified recursive' '
 	EOF
 '
 
+test_expect_success 'last-modified on annotated tag' '
+	check_last_modified t2 <<-\EOF
+	2 a
+	1 file
+	EOF
+'
+
 test_expect_success 'last-modified recursive with show-trees' '
 	check_last_modified -r -t <<-\EOF
 	3 a/b
@@ -236,4 +244,9 @@ test_expect_success 'last-modified complains about unknown arguments' '
 	test_grep "unknown last-modified argument: --foo" err
 '
 
+test_expect_success 'last-modified expects commit-ish' '
+	test_must_fail git last-modified HEAD^{tree} 2>err &&
+	test_grep "revision argument ${SQ}HEAD^{tree}${SQ} is a tree, not a commit-ish" err
+'
+
 test_done

-- 
2.53.0.rc1.267.g6e3a78c723

