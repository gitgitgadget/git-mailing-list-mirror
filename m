Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFC915B12F
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 14:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721832647; cv=none; b=Z2buKQhMQKCAFc3K4qI+nAfH0YpIdz8QtmmH0XfQ//Mfq5cwMsLxbw2fzH4vKT5qdu186ouH+Y7Rnsc3Z3w1V5gya6FyNSKe5Knv0l8OwdFwbKtqd4F5EW3IHNQkq0DwUxsIO8w13TKvfY1ahC544xyakhtNVWnUMNCzwBwtwF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721832647; c=relaxed/simple;
	bh=ipt8rPlsSdaXCRB3krCoIDVVDRvnLvHLuZyH9uw1QLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=reqmLc35+RO8TkG37v68XKqFDU7Ixl13Ned5IX1yQzpgTpi2FIod5X6wLoUtbYo+ZqOQAtWgcJPDgtYWp6144aRbhBkIurLcTcfQpNHtKvH3+CPqHbjBwojxpghn35y8I/V1vK/gfrz8ap0uhrPHVfOUmHv6DJjdb7WB8hLOq9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=13slI0ed; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="13slI0ed"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1721832641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o5WUUG3jZDsdwKDIV+xT96cK4AKsQ4tkPPYDeVAkeQY=;
	b=13slI0ed4O8jqgFlSnZZqMhTbKWL43x51pCJ4wYssoT5aFji+rhNi4xI3lf+Imvt1ankMR
	UbzpTkhSNfOv2lIKTJpAurDbUUxjk5+5pyvE9t0nUncPeZk5f8kivDBYx2P9TkPDJIas7n
	CMCT3AHHZkpm+kMzI0y8iizISMMczSQ=
From: Toon Claes <toon@iotcl.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	Toon Claes <toon@iotcl.com>
Subject: [PATCH v2 2/3] transport: introduce transport_has_remote_bundle_uri()
Date: Wed, 24 Jul 2024 16:49:56 +0200
Message-ID: <20240724144957.3033840-3-toon@iotcl.com>
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

The public function transport_get_remote_bundle_uri() exists to fetch
the bundle URI(s) from the remote. This function is only called from
builtin/clone.c (not taking test-tool into account). There it ignores
the return value, because it doesn't matter whether the server didn't
return any bundles or if it failed trying to fetch them, clone can
continue without bundle URIs. After calling it, it checks if anything
is collected in the bundle list and starts fetching them.

Add public function transport_has_remote_bundle_uri() instead. This
calls the (now made private) transport_get_remote_bundle_uri() function
and returns whether any bundle URI is received. This makes reuse of the
code easier and avoids code duplication when we add bundle URI support
to git-fetch(1).

Signed-off-by: Toon Claes <toon@iotcl.com>
---
 builtin/clone.c            | 23 +++++++----------------
 t/helper/test-bundle-uri.c |  2 +-
 transport.c                | 14 +++++++++++++-
 transport.h                |  7 ++++---
 4 files changed, 25 insertions(+), 21 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index aa507395a0..25535c1814 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1404,22 +1404,13 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 				bundle_uri);
 		else if (has_heuristic)
 			git_config_set_gently("fetch.bundleuri", bundle_uri);
-	} else {
-		/*
-		* Populate transport->got_remote_bundle_uri and
-		* transport->bundle_uri. We might get nothing.
-		*/
-		transport_get_remote_bundle_uri(transport);
-
-		if (transport->bundles &&
-		    hashmap_get_size(&transport->bundles->bundles)) {
-			/* At this point, we need the_repository to match the cloned repo. */
-			if (repo_init(the_repository, git_dir, work_tree))
-				warning(_("failed to initialize the repo, skipping bundle URI"));
-			else if (fetch_bundle_list(the_repository,
-						   transport->bundles))
-				warning(_("failed to fetch advertised bundles"));
-		}
+	} else if (transport_has_remote_bundle_uri(transport)) {
+		/* At this point, we need the_repository to match the cloned repo. */
+		if (repo_init(the_repository, git_dir, work_tree))
+			warning(_("failed to initialize the repo, skipping bundle URI"));
+		else if (fetch_bundle_list(the_repository,
+					   transport->bundles))
+			warning(_("failed to fetch advertised bundles"));
 	}

 	if (refs)
diff --git a/t/helper/test-bundle-uri.c b/t/helper/test-bundle-uri.c
index 0c5fa723d8..bd558d5e57 100644
--- a/t/helper/test-bundle-uri.c
+++ b/t/helper/test-bundle-uri.c
@@ -90,7 +90,7 @@ static int cmd_ls_remote(int argc, const char **argv)
 	}

 	transport = transport_get(remote, NULL);
-	if (transport_get_remote_bundle_uri(transport) < 0) {
+	if (!transport_has_remote_bundle_uri(transport)) {
 		error(_("could not get the bundle-uri list"));
 		status = 1;
 		goto cleanup;
diff --git a/transport.c b/transport.c
index 12cc5b4d96..1a7d86fa40 100644
--- a/transport.c
+++ b/transport.c
@@ -1536,7 +1536,7 @@ int transport_fetch_refs(struct transport *transport, struct ref *refs)
 	return rc;
 }

-int transport_get_remote_bundle_uri(struct transport *transport)
+static int transport_get_remote_bundle_uri(struct transport *transport)
 {
 	int value = 0;
 	const struct transport_vtable *vtable = transport->vtable;
@@ -1561,6 +1561,18 @@ int transport_get_remote_bundle_uri(struct transport *transport)

 	if (vtable->get_bundle_uri(transport) < 0)
 		return error(_("could not retrieve server-advertised bundle-uri list"));
+
+	return 0;
+}
+
+int transport_has_remote_bundle_uri(struct transport *transport)
+{
+	transport_get_remote_bundle_uri(transport);
+
+	if (transport->bundles &&
+	    hashmap_get_size(&transport->bundles->bundles))
+		return 1;
+
 	return 0;
 }

diff --git a/transport.h b/transport.h
index 6393cd9823..5ea9641558 100644
--- a/transport.h
+++ b/transport.h
@@ -294,10 +294,11 @@ const struct ref *transport_get_remote_refs(struct transport *transport,
 					    struct transport_ls_refs_options *transport_options);

 /**
- * Retrieve bundle URI(s) from a remote. Populates "struct
- * transport"'s "bundle_uri" and "got_remote_bundle_uri".
+ * Try fetch bundle URI(s) from a remote and returns 1 if one or more
+ * bundle URI(s) are received from the server.
+ * Populates "struct transport"'s "bundles" and "got_remote_bundle_uri".
  */
-int transport_get_remote_bundle_uri(struct transport *transport);
+int transport_has_remote_bundle_uri(struct transport *transport);

 /*
  * Fetch the hash algorithm used by a remote.
--
2.45.2
