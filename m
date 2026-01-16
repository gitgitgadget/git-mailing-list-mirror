Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A86A18872A
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 13:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768568960; cv=none; b=mzBwFj02P15G6fVmxycGiPAAh+xKiR7Ep/LdWQrgo468ob1Y0w0H5zj4XWw+MjlicwERYsg1Wxlx9cTGnquGM0OFCjQm0yHRpBL37JIVdD9Q0rCdYKA9is/PWydMl+drvgIZF73hLXAJq6GgZbE0SlXPQxc2+rEQ7g991f07ho8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768568960; c=relaxed/simple;
	bh=UJlTfJ4glXBaNYx9gytfcJl8B/qIOW2QoppTeCU8koQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J7kgVyOsIPsD2xcMDbs8g68roW+Hc53aYuYIV8BS9diFpAyXQbkIWe8UNyLaEenMcWyuEIYBPhx91g1HXLNiDeBggQqhSH9u/6KmTars+MvWmwSIxv97GxMXjwQ5L3U8VOjLGOkwX+6mtbTF1FYLiXCoAxh8Um6Hcz9p4QUt3/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=j0SeHc1O; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="j0SeHc1O"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1768568956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bq+d1LJ2Oh7UGoiLjXey6SLuk8CjUI4OT4fmh3tFqQg=;
	b=j0SeHc1Ol+chEWtlmhW91q4Fy8KfRJ3cxMOxtLymdWBIgOG1Dzfsfvye2YqJNeqAr7r4B/
	MMQo5JUIeBKSV3dfQDm8QzR0GALWpzypkkvuCtQRL7LTrItDWge+8rGEY1D08PiKd9aNv/
	im4uRK6EgIC0JpZPc2Ze/MnRVK+rzoo=
From: Toon Claes <toon@iotcl.com>
Date: Fri, 16 Jan 2026 14:08:40 +0100
Subject: [PATCH v3 4/4] last-modified: verify revision argument is a
 commit-ish
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260116-toon-last-modified-tree-v3-4-e6ade4dc35ab@iotcl.com>
References: <20260116-toon-last-modified-tree-v3-0-e6ade4dc35ab@iotcl.com>
In-Reply-To: <20260116-toon-last-modified-tree-v3-0-e6ade4dc35ab@iotcl.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Toon Claes <toon@iotcl.com>, Gusted <gusted@codeberg.org>
X-Migadu-Flow: FLOW_OUT

Passing a tree OID to git-last-modified(1) would trigger BUG behavior.

    git last-modified HEAD^{tree}
    BUG: builtin/last-modified.c:456: paths remaining beyond boundary in last-modified

Fix this error by verifying the parsed revision is a commit-ish.

Reported-by: Gusted <gusted@codeberg.org>
Signed-off-by: Toon Claes <toon@iotcl.com>
---
 builtin/last-modified.c  |  5 +++++
 t/t8020-last-modified.sh | 13 +++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/builtin/last-modified.c b/builtin/last-modified.c
index 0df85be318..5366cedd0f 100644
--- a/builtin/last-modified.c
+++ b/builtin/last-modified.c
@@ -150,6 +150,11 @@ static int populate_paths_from_revs(struct last_modified *lm)
 			goto out;
 		}
 
+		if (!repo_peel_to_type(lm->rev.repo, obj->path, 0, obj->item, OBJ_COMMIT)) {
+			ret = error(_("revision argument is not a commit-ish"));
+			goto out;
+		}
+
 		diff_tree_oid(lm->rev.repo->hash_algo->empty_tree,
 			      &obj->item->oid, "", &diffopt);
 		diff_flush(&diffopt);
diff --git a/t/t8020-last-modified.sh b/t/t8020-last-modified.sh
index 1183ae667b..22635de447 100755
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
@@ -55,6 +56,13 @@ test_expect_success 'last-modified recursive' '
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
@@ -235,4 +243,9 @@ test_expect_success 'last-modified complains about unknown arguments' '
 	grep "unknown last-modified argument: --foo" err
 '
 
+test_expect_success 'last-modified expects commit-ish' '
+	test_must_fail git last-modified HEAD^{tree} 2>err &&
+	grep "revision argument is not a commit-ish" err
+'
+
 test_done

-- 
2.52.0

