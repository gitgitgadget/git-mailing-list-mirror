Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCFE15B12F
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 14:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721832651; cv=none; b=j9tcBgby1edDK9HB+OxKsaSPgOgB6PFYj2oaZxkPdsYrkC6nMcjbiFgKQyBA3DhRTj8uHUFDQP/kNLXCHYxhIDFbaFxXaUOUI9QCfj9u8eme7Mhcs4KRZNBk+hYIi8+q+ztZlDnoJHgUVDDKPmlQQ1vHSsiWUFPHMAS6jr3SpvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721832651; c=relaxed/simple;
	bh=tdBsTN7i54G9a6SiEnvB5+ywIWM8xEY7VASxc09pkFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=raQAmPfTHT9sKxVVdFaN0jl6LAdos19it4UB3XoGnvsFMUH4+VVwKjZnUtIBwgHmCNZfGLqdst3RLpHpDX+0iF+roXEJeQ7zOlEZh/kjkNM6VgEGaAC+/9QAwXhuCR5OfnWGb4Qj3a9Yntz+lHRT2JM0hqaD9Z1jkyZCeCcFeH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=TldMvP6C; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="TldMvP6C"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1721832646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SR6ogoa6u3+CSbxCjfLnfb24Z0gXdjdULcZEMelfFmU=;
	b=TldMvP6C+xw3+uS1EhmB35Tb/8eCIpsFWuFb9DYz4RpyZPWZ/yKdAhqxU0GQMnqjPQgTzd
	J928+jjpGDZB26xuByI/Qmf/MKlaQinBvTZhhbA78kHSMZ0oIy83OOY5OcAH2A6fsYsMLw
	7UC9iiptItypQQXA6SUFuomS/HK/cVM=
From: Toon Claes <toon@iotcl.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	Toon Claes <toon@iotcl.com>
Subject: [PATCH v2 3/3] fetch: use bundle URIs when having creationToken heuristic
Date: Wed, 24 Jul 2024 16:49:57 +0200
Message-ID: <20240724144957.3033840-4-toon@iotcl.com>
In-Reply-To: <20240724144957.3033840-1-toon@iotcl.com>
References: <20240722080705.2614195-1-toon@iotcl.com>
 <20240724144957.3033840-1-toon@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

At the moment, bundle URIs are only used by git-clone(1). For a clone
the use of bundle URI is trivial, because the repository is empty so
downloading bundles will never result in downloading objects that are in
the repository already.

For git-fetch(1), this more complicated to use bundle URI. We want to
avoid downloading bundles that only contains objects that are in the
local repository already.

One way to achieve this is possible when the "creationToken" heuristic
is used for bundle URIs. We attempt to download and unbundle the minimum
number of bundles by creationToken in decreasing order. If we fail to
unbundle (after a successful download) then move to the next
non-downloaded bundle and attempt downloading. Once we succeed in
applying a bundle, move to the previous unapplied bundle and attempt to
unbundle it again. At the end the highest applied creationToken is
written to `fetch.bundleCreationToken` in the git-config. The next time
bundles are advertised by the server, bundles with a lower creationToken
value are ignored. This was already implemented by
7903efb717 (bundle-uri: download in creationToken order, 2023-01-31) in
fetch_bundles_by_token().

Using the creationToken heuristic is optional, but without it the client
has no idea which bundles are new, how to sort them, and which only have
objects the client already has.

With this knowledge, make git-fetch(1) use bundle URIs from the server,
but only when the creationToken heuristic is used.

Signed-off-by: Toon Claes <toon@iotcl.com>
---
 builtin/fetch.c             | 13 ++++++++++
 t/t5584-fetch-bundle-uri.sh | 49 +++++++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+)
 create mode 100755 t/t5584-fetch-bundle-uri.sh

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 693f02b958..98e811f438 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1694,6 +1694,19 @@ static int do_fetch(struct transport *transport,
 			retcode = 1;
 	}

+	if (transport_has_remote_bundle_uri(transport)) {
+		/*
+		 * Only use bundle-URIs when they use the creationToken
+		 * heuristic, this allows us to ensure not downloading bundles
+		 * we don't need. You can read the comments in
+		 * fetch_bundles_by_token() to understand how this works.
+		 */
+		if (transport->bundles->heuristic == BUNDLE_HEURISTIC_CREATIONTOKEN) {
+			if (fetch_bundle_list(the_repository, transport->bundles))
+				warning(_("failed to fetch advertised bundles"));
+		}
+	}
+
 	if (fetch_and_consume_refs(&display_state, transport, transaction, ref_map,
 				   &fetch_head, config)) {
 		retcode = 1;
diff --git a/t/t5584-fetch-bundle-uri.sh b/t/t5584-fetch-bundle-uri.sh
new file mode 100755
index 0000000000..6c2383646e
--- /dev/null
+++ b/t/t5584-fetch-bundle-uri.sh
@@ -0,0 +1,49 @@
+#!/bin/sh
+
+test_description='test use of bundle URI in "git fetch"'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+
+test_expect_success 'set up repos and bundles' '
+	git init source &&
+	test_commit -C source A &&
+	git clone --no-local source go-A-to-C &&
+	test_commit -C source B &&
+	git clone --no-local source go-B-to-C &&
+	git clone --no-local source go-B-to-D &&
+	git -C source bundle create B.bundle main &&
+	test_commit -C source C &&
+	git -C source bundle create B-to-C.bundle B..main &&
+	git -C source config uploadpack.advertiseBundleURIs true &&
+	git -C source config bundle.version 1 &&
+	git -C source config bundle.mode all &&
+	git -C source config bundle.heuristic creationToken &&
+	git -C source config bundle.bundle-B.uri "file://$(pwd)/source/B.bundle" &&
+	git -C source config bundle.bundle-B.creationToken 1 &&
+	git -C source config bundle.bundle-B-to-C.uri "file://$(pwd)/source/B-to-C.bundle" &&
+	git -C source config bundle.bundle-B-to-C.creationToken 2
+'
+
+test_expect_success 'fetches one bundle URI to get up-to-date' '
+	git -C go-B-to-C -c transfer.bundleURI=true fetch origin &&
+	test 1 = $(ls go-B-to-C/.git/objects/bundles | wc -l) &&
+	test 2 = $(git -C go-B-to-C config fetch.bundleCreationToken)
+'
+
+test_expect_success 'fetches two bundle URIs to get up-to-date' '
+	git -C go-A-to-C -c transfer.bundleURI=true fetch origin &&
+	test 2 = $(ls go-A-to-C/.git/objects/bundles | wc -l) &&
+	test 2 = $(git -C go-A-to-C config fetch.bundleCreationToken)
+'
+
+test_expect_success 'fetches one bundle URI and objects from remote' '
+	test_commit -C source D &&
+	git -C go-B-to-D -c transfer.bundleURI=true fetch origin &&
+	test 1 = $(ls go-B-to-D/.git/objects/bundles | wc -l) &&
+	test 2 = $(git -C go-B-to-D config fetch.bundleCreationToken)
+'
+
+test_done
--
2.45.2
