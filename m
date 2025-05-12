Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BE11E5705
	for <git@vger.kernel.org>; Mon, 12 May 2025 18:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747075894; cv=none; b=dnjty7D6ne+msQg0QWXPTxYjrjpJZbLjhSMHSR5br3Mm0yPpJXYOl9NASwL9cedFUF6zG/3cswCLUAbEL3RULPwvV53B4fKb0LHfAzB7SnHxSS9nHEcy6oomYz++SNZ9D0zLMseauHu92h0l3JRymLxyBnuSrp1pQ4mwcsIbwkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747075894; c=relaxed/simple;
	bh=vcGEY+JTKwyT2+nG/pslcRx16+GpCeiKWNSoCpkXsvc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SCJo3uQDDadTO7gk2pEhghHklziaMOLGyhV0YmRauCHFPcc0ZPFHJvxZpJG8uw9KmeTkpjqBofH7QgxnHjvy2L4mo5o3yt2gTbEO1DVv7FDT8Y6T0D5gm7JCrorcu9OZ/txbO9POLspfEBCWIB26YpHvxg0SaBlH+FyfJCM358c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=E/Xam6kO; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="E/Xam6kO"
Received: (qmail 3456 invoked by uid 109); 12 May 2025 18:51:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=vcGEY+JTKwyT2+nG/pslcRx16+GpCeiKWNSoCpkXsvc=; b=E/Xam6kOofTUlxTHdTIxQssuCuTcppMJIHpwoc24haBPWEyRwpliH/yX6owPEVB1GByJB/7JWgGDOr6IjXgHOFWZmi6vjwfH9yxCcUlC9HR5nM844iDSAYRiGYldphltw+7P2tl3508vlM/u25wwkEC10LeSb8D6iIxDKCnxvUB9uapkKOcKh2ixPP+yyEiCg+SX3v4YQv7KKc7N915QgDS5PX6LoXetZxiisGDGzDur2CnwRMrfuDybTNOoiPa7YJCqKbQgbInVqETCjhYE5Al7Av9M5SY3Pm1dnzSK2vP1ehS1jl6RM3hZORJguHM2GOdG0AWphN2mEvrBhlOBHQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 12 May 2025 18:51:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10356 invoked by uid 111); 12 May 2025 18:51:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 12 May 2025 14:51:33 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 12 May 2025 14:51:30 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 2/3] oidmap: add size function
Message-ID: <20250512185130.GB1276214@coredump.intra.peff.net>
References: <20250512185006.GA1275914@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250512185006.GA1275914@coredump.intra.peff.net>

Callers which want to know how many items are in an oidmap have to look
at the underlying hashmap struct, leaking an implementation detail.
Let's provide a type-appropriate wrapper and use it.

Note in the call from lookup_replace_object(), the caller was actually
looking at the hashmap's tablesize parameter (the allocated size of the
table) rather than hashmap_get_size(), the number of items in the table.
This probably should have been checking the number of items all along,
but the two are functionally equivalent here since we only add to the
map and never remove anything. Thus if there was any allocation, it was
because there is at least one item.

Signed-off-by: Jeff King <peff@peff.net>
---
 commit-graph.c   | 2 +-
 oidmap.h         | 4 ++++
 replace-object.h | 2 +-
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 6394752b0b..1a74e1e1ba 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -222,7 +222,7 @@ static int commit_graph_compatible(struct repository *r)
 
 	if (replace_refs_enabled(r)) {
 		prepare_replace_object(r);
-		if (hashmap_get_size(&r->objects->replace_map->map))
+		if (oidmap_get_size(r->objects->replace_map))
 			return 0;
 	}
 
diff --git a/oidmap.h b/oidmap.h
index 603ae1adbc..67fb32290f 100644
--- a/oidmap.h
+++ b/oidmap.h
@@ -67,6 +67,10 @@ void *oidmap_put(struct oidmap *map, void *entry);
  */
 void *oidmap_remove(struct oidmap *map, const struct object_id *key);
 
+static inline unsigned int oidmap_get_size(struct oidmap *map)
+{
+	return hashmap_get_size(&map->map);
+}
 
 struct oidmap_iter {
 	struct hashmap_iter h_iter;
diff --git a/replace-object.h b/replace-object.h
index ba478eb30c..4226376534 100644
--- a/replace-object.h
+++ b/replace-object.h
@@ -47,7 +47,7 @@ static inline const struct object_id *lookup_replace_object(struct repository *r
 {
 	if (!replace_refs_enabled(r) ||
 	    (r->objects->replace_map_initialized &&
-	     r->objects->replace_map->map.tablesize == 0))
+	     oidmap_get_size(r->objects->replace_map) == 0))
 		return oid;
 	return do_lookup_replace_object(r, oid);
 }
-- 
2.49.0.821.gd3b3298025

