Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1723570CA
	for <git@vger.kernel.org>; Tue, 27 Jan 2026 13:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769520406; cv=none; b=as8yahE/ubXKRgxtiExdaJVvq0zP8Rgj3qOeBoWQO185HfWFtaeXJtCU/nk2HRvJLlqF/iK19gK+ZVuk8gz5Wra+Afp9LnF6rndFfMPLClZ4QouH4TxCuHdR5jqDS4PukoDqmkKUXRDV6P3w6UgdxNvmgw74S2qlNbpUuC0Us2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769520406; c=relaxed/simple;
	bh=JLqqEeGW4exyvyl5kgag/bO7HV5O46W5FNyj+anUMSA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kZoQUP58WczPfaBdDLSsb0GLrTBrxR8S0x0zOBWukV/WV7g37UTGa03gkqLfxTDkFMELD+8TDpw+UqcuRmOvcbK/J/x5k9HXuXv6WqnhK0LvN6sZz19wgrn/gNvxOoy/pLBpDjprz/8/UTI+2rTuJAisq1ub8z7qr5l2hz6HjjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=VSd1pom5; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="VSd1pom5"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1769520402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0CLxYRT7fJdIHpQgY1Rn0sLLugF3HJaa00ECbUGDyAg=;
	b=VSd1pom529AzY5HROK7abZYfz9iKL1P6VmJg5D25kE0W75i6r+GJNxHNW6VFASMFz78GXo
	Iy9LH4mq1h8FITZNe6u5pNRNd50Xh6tlgUxa/itQwr5Z8dl1iUoVO212JkZLeMDL7jePPD
	BSbaFGJGf1FeyUwz3HsE8RP0VBrKmwU=
From: Toon Claes <toon@iotcl.com>
Date: Tue, 27 Jan 2026 14:26:20 +0100
Subject: [PATCH v5 4/4] last-modified: verify revision argument is a
 commit-ish
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260127-toon-last-modified-tree-v5-4-38d18a0956d4@iotcl.com>
References: <20260127-toon-last-modified-tree-v5-0-38d18a0956d4@iotcl.com>
In-Reply-To: <20260127-toon-last-modified-tree-v5-0-38d18a0956d4@iotcl.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Toon Claes <toon@iotcl.com>, Gusted <gusted@codeberg.org>
X-Migadu-Flow: FLOW_OUT

Passing a non-committish revision to git-last-modified(1) triggers the
following BUG:

    git last-modified HEAD^{tree}
    BUG: builtin/last-modified.c:456: paths remaining beyond boundary in last-modified

Fix this error by ensuring that the given revision peels to a commit.

Reported-by: Gusted <gusted@codeberg.org>
Signed-off-by: Toon Claes <toon@iotcl.com>
---
 builtin/last-modified.c  |  5 +++++
 t/t8020-last-modified.sh | 13 +++++++++++++
 2 files changed, 18 insertions(+)

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
index d1aad12319..6024e8bd60 100755
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
+	grep "revision argument '"'"'HEAD^{tree}'"'"' is a tree, not a commit-ish" err
+'
+
 test_done

-- 
2.53.0.rc1.267.g6e3a78c723

