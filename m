Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643342E06E4
	for <git@vger.kernel.org>; Fri, 23 Jan 2026 14:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769178818; cv=none; b=GJ+gskgqYac5i6OJ2JwjKusyH2Nsxgp8vfJfSY6ij1YOq7hIAo3BSIi6Lmvkd/wMXUVJr38JLTFgF/8GIERdryx20hOb8phbFNH7aUmwKNg4wow0ArZfXDID1pCCSMC2OxcingRwich3L+wLyhB4NB6XkvQpGRauyUOpHH0I9/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769178818; c=relaxed/simple;
	bh=3159OxO3Xf3o1F01msCXSpsVA8mnfAEtT1n30YeeNCs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OELtkmbC9x3xp+dCu2vfM7pJPYxOqE5nFrsX5s3Yc/hBtVIL0FvL4ratcfBauROWPBYhHYwKiYySB3Qjb+4SO4ELlBc+lZ4KRGpMd9VLK2RdTA6aIlye0av2qe6NtlR2BOODNFtYPCk78Zqa2WphdprShansgEElIpxWXPxwulQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=hLSUAcUJ; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="hLSUAcUJ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1769178814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7sKrB6f0gEwy/vNqKeoFqNy0Xzvc9tualp6wE2OSEg8=;
	b=hLSUAcUJuYjewhaXadU5e2aEliSgCqBTh6nOp4k03T706Csw3cFskKFl3iFmTB41cyHWJ5
	rfydbDrnsPf05oF9M74+YJgOxIzK5FjaQFyKR5KayJLuopNf891EfzRO5Q2hBi7ZZVhj+N
	EKziwYQsFPqYm5LLac4cQ80XSLUjQbo=
From: Toon Claes <toon@iotcl.com>
Date: Fri, 23 Jan 2026 15:33:04 +0100
Subject: [PATCH v4 4/4] last-modified: verify revision argument is a
 commit-ish
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260123-toon-last-modified-tree-v4-4-86bf97bad4e2@iotcl.com>
References: <20260123-toon-last-modified-tree-v4-0-86bf97bad4e2@iotcl.com>
In-Reply-To: <20260123-toon-last-modified-tree-v4-0-86bf97bad4e2@iotcl.com>
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
index 0df85be318..686cb258bb 100644
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
index 91901eed58..c88ec1854f 100755
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
2.52.0

