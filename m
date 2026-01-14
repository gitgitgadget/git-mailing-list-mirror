Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8522163
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 10:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768386312; cv=none; b=szVwpO8ymd/l+6oKrToekbXAJ2G/Q8lQITrMDbKm3yvdJNFBdiNmdiIzapcoOi+3nF7qdnxslV7NIcqarMUC8mGq4CMyWpZS+vohyrV4VIMqYGH0YoAcvd6J8LnH3gM4WPvT/D1HL/jSQHVi2J4Jduuk56yto/zSF0zIQjMqfwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768386312; c=relaxed/simple;
	bh=g/x+dTGE0LlqztKZLa3uOrY9SF/WGW8pBuI1i+9bOIs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fNXo66l8cfyVxJE3fsC14Nzmt50FqtMVvpArWUzo7TlKxnXAOXrYaFng8l6/RfbS93OTRoAEyrEuFUBJ/A2izDONQ4AA6nAllm5jEq2hBrY5uv9anDCTVCLTjLpUe7ToThrtqsl9IdWKfjrnHR7OJurL5sQJQUjPbI18+YlPvLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=1RwXmhcX; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="1RwXmhcX"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1768386307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4fA+PBUP2HtUTcYlkMhfNxLTdipsjs/IwxP453o0eYo=;
	b=1RwXmhcXwp2vay+BMaPcokW1wqFpknpStSDkmJ5GJspmLmL1nylDtVTetJL8qXpbpkE35U
	cSWu84N8GmXONmmTBnXMmZPs7zu60oXhYqkg9JkLWYcFe6QsNSDQmbq0uP5bHuklHqDsuo
	uM0yCr+3aPNVM6FwLFPnUej5fUtRRpo=
From: Toon Claes <toon@iotcl.com>
Date: Wed, 14 Jan 2026 11:24:47 +0100
Subject: [PATCH v2 3/3] last-modified: verify revision argument is a
 commit-ish
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-toon-last-modified-tree-v2-3-ba3b1860898f@iotcl.com>
References: <20260114-toon-last-modified-tree-v2-0-ba3b1860898f@iotcl.com>
In-Reply-To: <20260114-toon-last-modified-tree-v2-0-ba3b1860898f@iotcl.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Toon Claes <toon@iotcl.com>, 
 Gusted <gusted@codeberg.org>
X-Migadu-Flow: FLOW_OUT

Passing a tree OID to git-last-modified(1) would trigger BUG behavior.

    git last-modified HEAD^{tree}
    BUG: builtin/last-modified.c:456: paths remaining beyond boundary in last-modified

Fix this error by verifying the parsed revision peels to a commit-ish.

While at it, also fix a memory leak in populate_paths_from_revs().

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

