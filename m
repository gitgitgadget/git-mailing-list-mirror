Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7042917C6C
	for <git@vger.kernel.org>; Mon, 22 Jul 2024 08:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721635663; cv=none; b=a+MTO61xt0azAjpiV9EYL5LiFKEERGcPZPTK+g2q4L5qRduw4g54ihMOn4WKU+8N9543W4l8srgGb3RTsn8DWvkRjqTgniWf/kVDCOF5Nf3MeZ72/JCdTUDsZEAFrrP1uxTDRGxgQt4vkkUBPahFMI/8ITrooOkHPJ2RKXHvcx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721635663; c=relaxed/simple;
	bh=FkuZcvlYOayglpaS9kjoSAD0HAY/mFxeot/kyRtGP48=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pbjURCCHj7SmWL49Rr1kM+NT/8VWYH68uNe+096JHWDQu0S2bTqdRZ+DmN5cfTGdCec0qfAb6B8QYkp4M9onOTtNvubJESIMEQnFZppIzzHNb3d8k+KmvfPaHemFswoX+AQQU2qwZLJmb+iKxgZ4HtycQTkr3/4bb3v0m4nwPfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=VOj+cDKL; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="VOj+cDKL"
X-Envelope-To: git@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1721635655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lfZpifwY0kzrAYfYBxiuPtJj00RIanAtwylqmBLe8rU=;
	b=VOj+cDKL+m/TGFHBNZLsrd8WzukHJvG8GSsCBgeFcRYJRq8zUoLHa83UUyRkNBZkfsw+cN
	0boTHDy0uYglI0Jrb5Nvp5WH0X0V++0k95ZNa7BnMS0W0UoFc08qEHVFipdUNFdHTg8FBS
	lACSjIN88vRHMbkr3XpO/iQsrmYeKRA=
X-Envelope-To: toon@iotcl.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Toon Claes <toon@iotcl.com>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>
Subject: [PATCH] fetch: use bundle URIs when having creationToken heuristic
Date: Mon, 22 Jul 2024 10:07:05 +0200
Message-ID: <20240722080705.2614195-1-toon@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

At the moment, bundle URIs are only used on git-clone(1). For a clone
the use of bundle URI is trivial, because repository is empty so
downloading bundles will never result in downloading objects that are in
the repository already.

For git-fetch(1), this more complicated to use bundle URI. We want to
avoid downloading bundles that only contains objects that are in the
local repository already.

One way to achieve this is possible when the "creationToken" heuristic
is used for bundle URIs. With this heuristic, the server sends along a
creationToken for each bundle. When a client downloads bundles with such
creationToken, the highest known value is written to
`fetch.bundleCreationToken` in the git-config. The next time bundles are
advertised by the server, bundles with a lower creationToken value are
ignored. This was already implemented by 7903efb717 (bundle-uri:
download in creationToken order, 2023-01-31) in
fetch_bundles_by_token().

Using the creationToken heuristic is optional, but without it the
client has no idea which bundles are new and which only have objects the
client already has.

With this knowledge, make git-fetch(1) get bundle URI information from
the server, but only use bundle URIs if the creationToken heuristic is
used.

The code added in builtin/fetch.c is very similar to the code in
builtin/clone.c, so while at it make sure we always clean up the bundles
list advertised by the server.

Signed-off-by: Toon Claes <toon@iotcl.com>
---
 builtin/clone.c             | 13 +++++-----
 builtin/fetch.c             | 17 +++++++++++++
 t/t5584-fetch-bundle-uri.sh | 49 +++++++++++++++++++++++++++++++++++++
 3 files changed, 73 insertions(+), 6 deletions(-)
 create mode 100755 t/t5584-fetch-bundle-uri.sh

diff --git a/builtin/clone.c b/builtin/clone.c
index af6017d41a..29f0470aea 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1406,9 +1406,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 			git_config_set_gently("fetch.bundleuri", bundle_uri);
 	} else {
 		/*
-		* Populate transport->got_remote_bundle_uri and
-		* transport->bundle_uri. We might get nothing.
-		*/
+		 * Populate transport->bundles. We might get nothing or fail
+		 * trying, but clone can continue without bundles as well.
+		 */
 		transport_get_remote_bundle_uri(transport);

 		if (transport->bundles &&
@@ -1419,10 +1419,11 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 			else if (fetch_bundle_list(the_repository,
 						   transport->bundles))
 				warning(_("failed to fetch advertised bundles"));
-		} else {
-			clear_bundle_list(transport->bundles);
-			FREE_AND_NULL(transport->bundles);
 		}
+
+		clear_bundle_list(transport->bundles);
+		if (transport->bundles)
+			FREE_AND_NULL(transport->bundles);
 	}

 	if (refs)
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 693f02b958..1e944f81af 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1694,6 +1694,23 @@ static int do_fetch(struct transport *transport,
 			retcode = 1;
 	}

+	/*
+	 * Populate transport->bundles. We might get nothing or fail
+	 * trying, but fetch can continue without bundles as well.
+	 */
+	transport_get_remote_bundle_uri(transport);
+
+	if (transport->bundles &&
+	    hashmap_get_size(&transport->bundles->bundles) &&
+	    (transport->bundles->heuristic == BUNDLE_HEURISTIC_CREATIONTOKEN)) {
+		if (fetch_bundle_list(the_repository, transport->bundles))
+			warning(_("failed to fetch advertised bundles"));
+	}
+
+	clear_bundle_list(transport->bundles);
+	if (transport->bundles)
+		FREE_AND_NULL(transport->bundles);
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
