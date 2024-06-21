Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BF112D1EB
	for <git@vger.kernel.org>; Fri, 21 Jun 2024 09:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718961805; cv=none; b=clpmVvCiYBor7eEJKFhslLq5En5d1YqBOEmJHHNGqtlo5+lfCDchpOmx+ytAzxZeOXDMYjm5s5afLzIAdkjZCgCwyamG76lsTsbk+T6r1joGozS9EMaYeLgKwTUkig/j+01CHArdlE56Q4F+6CFlY9N/f8iIpNMUzXJunwPhrSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718961805; c=relaxed/simple;
	bh=aUJBq4m25N3A8Ksotq7lmut6NNPcjLuGmb6yCpPZH1I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rOtVmw1vgFtFgKQaDJArayiSRaelv3Xo4NY97uGTc4Qb9HMOYMgj/rUd4Nvj+MngEeERh291UovJtEzYmq1N42Dtzgjaj/wXxBDm54J5dxFMUoXLovqnanFAYnINHTjQjWl/+wbV7N0Wb8wTf9JpvhgMOlh75fLrTGXlJ+O5l3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=Lah5xY3F; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="Lah5xY3F"
X-Envelope-To: git@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1718961797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=u3lKP325ZAFj9rmgpaRwuB35UChTcURfUYjmsZVEC80=;
	b=Lah5xY3FMXQRxsPRNk3mZXmqIP/3o0chsnq+kmForBhxc7xvxYABkF6RIPf7n4vQyGOHzF
	PLgasnGCt0aVnEdxXZthTJjs5a3WcAssaLot2r/qJLEWsGv2BvgwUAB0E0FcDoTCorV/ib
	Yxq5ZjQ/NCZSraFIQoQuMh0SgXzAtMU=
X-Envelope-To: toon@iotcl.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Toon Claes <toon@iotcl.com>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>
Subject: [PATCH] bundle-uri.c: Fix double increment in depth
Date: Fri, 21 Jun 2024 11:22:58 +0200
Message-ID: <20240621092258.1557258-1-toon@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

A bundle URI can serve a gitformat-bundle(5) or a bundle list. This
plain text file is in the Git config format containing other bundle
URIs. To avoid these bundle lists to nest too deep, we've set a limit
with `max_bundle_uri_depth`. Although, when walk through the tree of
bundles, the current depth is incremented in download_bundle_list() and
then calls download_bundle_to_file(), which also increments the depth.
Remove the increment in download_bundle_to_file().

Signed-off-by: Toon Claes <toon@iotcl.com>
---
 bundle-uri.c                |  2 +-
 t/t5558-clone-bundle-uri.sh | 62 +++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/bundle-uri.c b/bundle-uri.c
index 91b3319a5c..7b1a711919 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -436,7 +436,7 @@ static int download_bundle_to_file(struct remote_bundle_info *bundle, void *data
 	if (ctx->mode == BUNDLE_MODE_ANY && ctx->count)
 		return 0;

-	res = fetch_bundle_uri_internal(ctx->r, bundle, ctx->depth + 1, ctx->list);
+	res = fetch_bundle_uri_internal(ctx->r, bundle, ctx->depth, ctx->list);

 	/*
 	 * Only increment count if the download succeeded. If our mode is
diff --git a/t/t5558-clone-bundle-uri.sh b/t/t5558-clone-bundle-uri.sh
index 1ca5f745e7..f3a8494297 100755
--- a/t/t5558-clone-bundle-uri.sh
+++ b/t/t5558-clone-bundle-uri.sh
@@ -259,6 +259,68 @@ test_expect_success 'clone bundle list (file, any mode, all failures)' '
 	! grep "refs/bundles/" refs
 '

+test_expect_success 'clone bundle list (file, above max depth)' '
+	cat >bundle-list-1 <<-EOF &&
+	[bundle]
+		version = 1
+		mode = any
+
+	[bundle "bundle-list-2"]
+		uri = file://$(pwd)/bundle-list-2
+	EOF
+
+	cat >bundle-list-2 <<-EOF &&
+	[bundle]
+		version = 1
+		mode = any
+
+	[bundle "bundle-list-3"]
+		uri = file://$(pwd)/bundle-list-3
+	EOF
+
+	cat >bundle-list-3 <<-EOF &&
+	[bundle]
+		version = 1
+		mode = any
+
+	[bundle "bundle-list-4"]
+		uri = file://$(pwd)/bundle-list-4
+	EOF
+
+	cat >bundle-list-4 <<-EOF &&
+	[bundle]
+		version = 1
+		mode = any
+
+	[bundle "bundle-0"]
+		uri = file://$(pwd)/clone-from/bundle-0.bundle
+	EOF
+
+	git clone --bundle-uri="file://$(pwd)/bundle-list-1" \
+		clone-from clone-too-deep 2>err &&
+	! grep "fatal" err &&
+	grep "warning: exceeded bundle URI recursion limit" err &&
+
+	git -C clone-from for-each-ref --format="%(objectname)" >oids &&
+	git -C clone-too-deep cat-file --batch-check <oids &&
+
+	git -C clone-too-deep for-each-ref --format="%(refname)" >refs &&
+	! grep "refs/bundles/" refs
+'
+
+test_expect_success 'clone bundle list (file, below max depth)' '
+	git clone --bundle-uri="file://$(pwd)/bundle-list-2" \
+		clone-from clone-max-depth 2>err &&
+	! grep "fatal" err &&
+	! grep "warning: exceeded bundle URI recursion limit" err &&
+
+	git -C clone-from for-each-ref --format="%(objectname)" >oids &&
+	git -C clone-max-depth cat-file --batch-check <oids &&
+
+	git -C clone-max-depth for-each-ref --format="%(refname)" >refs &&
+	! grep "refs/bundles/" refs
+'
+
 #########################################################################
 # HTTP tests begin here

--
2.45.0
