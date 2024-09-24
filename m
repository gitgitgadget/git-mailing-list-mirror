Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393FF82488
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 21:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727214666; cv=none; b=PaT3HbfCsh2VZRMlDOxF/sLBEhsbHmBuWofR7uE9oherRZNT21LofLpHe5BAlyWUGYQiyJVG8E+ges5sgdvLJiH7tiCFo9pvSBQyAvrEipmnnKEtPxw9d39SxPfYcECnvlRQcj2RirNWhCeLFq7Ym7Q1GCYDD58SeiHkm/MQ6gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727214666; c=relaxed/simple;
	bh=o56a2aNQOF1o4l1//J61Ow9LxbmcQFfy5UFvgGahwqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WF7ms+guK+8XuhHwsPWHm/8pqFsV36z/5yxo6sxMfR7NlC0FMd3ABEeqM33f2LJFuc2TV3Q0nmEZD2PIC1A9HuKSZKCMTzV/K+WAQqdinZxSr0figCHBWnyPY+GyhPndHXCdTMuavKTrQORGpUngykWJmD4nOgvOT3BDk4aMUGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 15411 invoked by uid 109); 24 Sep 2024 21:51:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 24 Sep 2024 21:51:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18494 invoked by uid 111); 24 Sep 2024 21:51:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 24 Sep 2024 17:51:03 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 24 Sep 2024 17:51:03 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 03/28] fetch-pack: fix leaking sought refs
Message-ID: <20240924215103.GC1143820@coredump.intra.peff.net>
References: <20240924214930.GA1143523@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240924214930.GA1143523@coredump.intra.peff.net>

From: Patrick Steinhardt <ps@pks.im>

When calling `fetch_pack()` the caller is expected to pass in a set of
sought-after refs that they want to fetch. This array gets massaged to
not contain duplicate entries, which is done by replacing duplicate refs
with `NULL` pointers. This modifies the caller-provided array, and in
case we do unset any pointers the caller now loses track of that ref and
cannot free it anymore.

Now the obvious fix would be to not only unset these pointers, but to
also free their contents. But this doesn't work because callers continue
to use those refs. Another potential solution would be to copy the array
in `fetch_pack()` so that we dont modify the caller-provided one. But
that doesn't work either because the NULL-ness of those entries is used
by callers to skip over ref entries that we didn't even try to fetch in
`report_unmatched_refs()`.

Instead, we make it the responsibility of our callers to duplicate these
arrays as needed. It ain't pretty, but it works to plug the memory leak.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fetch-pack.c   | 11 ++++++++++-
 t/t5700-protocol-v1.sh |  1 +
 transport.c            | 11 ++++++++++-
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 49222a36fa..c5319232a5 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -53,6 +53,7 @@ int cmd_fetch_pack(int argc,
 	struct ref *fetched_refs = NULL, *remote_refs = NULL;
 	const char *dest = NULL;
 	struct ref **sought = NULL;
+	struct ref **sought_to_free = NULL;
 	int nr_sought = 0, alloc_sought = 0;
 	int fd[2];
 	struct string_list pack_lockfiles = STRING_LIST_INIT_DUP;
@@ -243,6 +244,13 @@ int cmd_fetch_pack(int argc,
 		BUG("unknown protocol version");
 	}
 
+	/*
+	 * Create a shallow copy of `sought` so that we can free all of its entries.
+	 * This is because `fetch_pack()` will modify the array to evict some
+	 * entries, but won't free those.
+	 */
+	DUP_ARRAY(sought_to_free, sought, nr_sought);
+
 	fetched_refs = fetch_pack(&args, fd, remote_refs, sought, nr_sought,
 			 &shallow, pack_lockfiles_ptr, version);
 
@@ -280,7 +288,8 @@ int cmd_fetch_pack(int argc,
 		       oid_to_hex(&ref->old_oid), ref->name);
 
 	for (size_t i = 0; i < nr_sought; i++)
-		free_one_ref(sought[i]);
+		free_one_ref(sought_to_free[i]);
+	free(sought_to_free);
 	free(sought);
 	free_refs(fetched_refs);
 	free_refs(remote_refs);
diff --git a/t/t5700-protocol-v1.sh b/t/t5700-protocol-v1.sh
index a73b4d4ff6..985e04d06e 100755
--- a/t/t5700-protocol-v1.sh
+++ b/t/t5700-protocol-v1.sh
@@ -11,6 +11,7 @@ export GIT_TEST_PROTOCOL_VERSION
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Test protocol v1 with 'git://' transport
diff --git a/transport.c b/transport.c
index 3c4714581f..1098bbd60e 100644
--- a/transport.c
+++ b/transport.c
@@ -414,7 +414,7 @@ static int fetch_refs_via_pack(struct transport *transport,
 	struct git_transport_data *data = transport->data;
 	struct ref *refs = NULL;
 	struct fetch_pack_args args;
-	struct ref *refs_tmp = NULL;
+	struct ref *refs_tmp = NULL, **to_fetch_dup = NULL;
 
 	memset(&args, 0, sizeof(args));
 	args.uploadpack = data->options.uploadpack;
@@ -477,6 +477,14 @@ static int fetch_refs_via_pack(struct transport *transport,
 		goto cleanup;
 	}
 
+	/*
+	 * Create a shallow copy of `sought` so that we can free all of its entries.
+	 * This is because `fetch_pack()` will modify the array to evict some
+	 * entries, but won't free those.
+	 */
+	DUP_ARRAY(to_fetch_dup, to_fetch, nr_heads);
+	to_fetch = to_fetch_dup;
+
 	refs = fetch_pack(&args, data->fd,
 			  refs_tmp ? refs_tmp : transport->remote_refs,
 			  to_fetch, nr_heads, &data->shallow,
@@ -500,6 +508,7 @@ static int fetch_refs_via_pack(struct transport *transport,
 		ret = -1;
 	data->conn = NULL;
 
+	free(to_fetch_dup);
 	free_refs(refs_tmp);
 	free_refs(refs);
 	list_objects_filter_release(&args.filter_options);
-- 
2.46.2.1011.gf1f9323e02

