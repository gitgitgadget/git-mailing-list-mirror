Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BC61361CD
	for <git@vger.kernel.org>; Wed, 28 Feb 2024 22:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709160502; cv=none; b=k9ZJuMn9niNLgskIpQk1QJFDJByLIXumgzaPJCsuvEhs4kGQpLHuIyH4y7QIXQpiyKeaFSB9U9vf8qGuJj89mErWSSOFoRIOGlzHdLJxuR8w1HbwOYv1SLgodJnanOKFJMnq1CtwE11HLXwvPkq2yJn4xgX5DKslnIFTTMlthJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709160502; c=relaxed/simple;
	bh=Bcp53yGtifgnvINt+GVL2eDqzu7fMqY/yMh8JsXe4iM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kVxw37W055pr0voMwkeXFgOv/wGWXEChLXpWU6mSKefTGvLrDZxvQzQvsoWycic5a+l/bejl0xLqe21eyEcnXNIEJUldqZUtWvakQfWKlLp+jQMI6AEpaM4znG+K/Pumc79CgiyslZuYmoUflSdijuehahq5f3JeYjRew3DPny4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 23785 invoked by uid 109); 28 Feb 2024 22:48:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 28 Feb 2024 22:48:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26973 invoked by uid 111); 28 Feb 2024 22:48:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 28 Feb 2024 17:48:21 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 28 Feb 2024 17:48:18 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 3/4] upload-pack: use existing config mechanism for
 advertisement
Message-ID: <20240228224818.GA1158952@coredump.intra.peff.net>
References: <20240228224625.GA1158651@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240228224625.GA1158651@coredump.intra.peff.net>

When serving a v2 capabilities request, we call upload_pack_advertise()
to tell us the set of features we can advertise to the client. That
involves looking at various config options, all of which need to be kept
in sync with the rules we use in upload_pack_config to set flags like
allow_filter, allow_sideband_all, and so on. If these two pieces of code
get out of sync then we may refuse to respect a capability we
advertised, or vice versa accept one that we should not.

Instead, let's call the same config helper that we'll use for processing
the actual client request, and then just pick the values out of the
resulting struct. This is only a little bit shorter than the current
code, but we don't repeat any policy logic (e.g., we don't have to worry
about the magic sideband-all environment variable here anymore).

And this reveals a gap in the existing code: there is no struct flag for
the packfile-uris capability (we accept it even if it is not advertised,
which we should not). We'll leave the advertisement code for now and
deal with it in the next patch.

Signed-off-by: Jeff King <peff@peff.net>
---
 upload-pack.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 6bda20754d..491ef51daa 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1841,41 +1841,35 @@ int upload_pack_v2(struct repository *r, struct packet_reader *request)
 int upload_pack_advertise(struct repository *r,
 			  struct strbuf *value)
 {
+	struct upload_pack_data data;
+
+	upload_pack_data_init(&data);
+	get_upload_pack_config(r, &data);
+
 	if (value) {
-		int allow_filter_value;
-		int allow_ref_in_want;
-		int allow_sideband_all_value;
 		char *str = NULL;
 
 		strbuf_addstr(value, "shallow wait-for-done");
 
-		if (!repo_config_get_bool(r,
-					 "uploadpack.allowfilter",
-					 &allow_filter_value) &&
-		    allow_filter_value)
+		if (data.allow_filter)
 			strbuf_addstr(value, " filter");
 
-		if (!repo_config_get_bool(r,
-					 "uploadpack.allowrefinwant",
-					 &allow_ref_in_want) &&
-		    allow_ref_in_want)
+		if (data.allow_ref_in_want)
 			strbuf_addstr(value, " ref-in-want");
 
-		if (git_env_bool("GIT_TEST_SIDEBAND_ALL", 0) ||
-		    (!repo_config_get_bool(r,
-					   "uploadpack.allowsidebandall",
-					   &allow_sideband_all_value) &&
-		     allow_sideband_all_value))
+		if (data.allow_sideband_all)
 			strbuf_addstr(value, " sideband-all");
 
 		if (!repo_config_get_string(r,
 					    "uploadpack.blobpackfileuri",
 					    &str) &&
 		    str) {
 			strbuf_addstr(value, " packfile-uris");
 			free(str);
 		}
 	}
 
+	upload_pack_data_clear(&data);
+
 	return 1;
 }
-- 
2.44.0.rc2.424.gbdbf4d014b

