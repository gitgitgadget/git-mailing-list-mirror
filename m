Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122B11494D6
	for <git@vger.kernel.org>; Fri, 23 Aug 2024 22:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.242.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724453228; cv=none; b=b6150xlddYb/hCS+B+D7YRps3UazH6fq9uD9rOfxUwFxLNMQa9Pnd0dUD8EOPtdeuOdrqmoDNkvFH7A1aBQeUAx2dEYoaGCyTqxVj4IfAcEO2+REiiuMHiCAUj1L4RYOuA8LhqYLz+3I+1z0LyK/P4zL02ZNlUDnn9yqDYj3TO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724453228; c=relaxed/simple;
	bh=ruXvqtXfHI9fbe8aylVbfYydgcKGcefYxmqgx+bQKAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RqkM1nyKD+K/eUhtjzQsjrLClIrgWEQt7wxh6qnXeR7LP/NWfmk/HoadFyd1zPsCtjE/nMGYVi/MRbDPBQ/+G1YcdOVTGvC8qUrbEo50IN0Y87XeTnetxtBt83UC9Ubh1znNoHuvcvM4G+xmqHG79tRbgNQV02qSb7pYuE5ybO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org; spf=pass smtp.mailfrom=80x24.org; dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b=bJElrAGV; arc=none smtp.client-ip=173.255.242.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=80x24.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b="bJElrAGV"
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id D101A1F51A;
	Fri, 23 Aug 2024 22:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
	s=selector1; t=1724453191;
	bh=ruXvqtXfHI9fbe8aylVbfYydgcKGcefYxmqgx+bQKAU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bJElrAGV2xlJbGjHXAMk+4yOP9h3vDFXGyiE7iDWaNQ8ccYQD4rnE9Dpgpd42uu4e
	 b4/787v/6pIX93xQKJZMm72980bonk/CJOA4PECv8wS4QIePyRF/nON6f3Rev+wV5b
	 LPOdbMBKuoDaPdVEB7SpVIWK2qHLR8dI5f5LCuOA=
From: Eric Wong <e@80x24.org>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 04/10] packfile: inline cache_or_unpack_entry
Date: Fri, 23 Aug 2024 22:46:24 +0000
Message-ID: <20240823224630.1180772-5-e@80x24.org>
In-Reply-To: <20240823224630.1180772-1-e@80x24.org>
References: <20240823224630.1180772-1-e@80x24.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We need to check delta_base_cache anyways to fill in the
`whence' field in `struct object_info'.  Inlining (and getting
rid of) cache_or_unpack_entry() makes it easier to only do the
hashmap lookup once and avoid a redundant lookup later on.

This code reorganization will also make an optimization to
use the cache entry directly easier to implement in the next
commit.

Signed-off-by: Eric Wong <e@80x24.org>
---
 packfile.c | 48 +++++++++++++++++++++---------------------------
 1 file changed, 21 insertions(+), 27 deletions(-)

diff --git a/packfile.c b/packfile.c
index 8ec86d2d69..0a90a5ed67 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1444,23 +1444,6 @@ static void detach_delta_base_cache_entry(struct delta_base_cache_entry *ent)
 	free(ent);
 }
 
-static void *cache_or_unpack_entry(struct repository *r, struct packed_git *p,
-				   off_t base_offset, unsigned long *base_size,
-				   enum object_type *type)
-{
-	struct delta_base_cache_entry *ent;
-
-	ent = get_delta_base_cache_entry(p, base_offset);
-	if (!ent)
-		return unpack_entry(r, p, base_offset, type, base_size);
-
-	if (type)
-		*type = ent->type;
-	if (base_size)
-		*base_size = ent->size;
-	return xmemdupz(ent->data, ent->size);
-}
-
 static inline void release_delta_base_cache(struct delta_base_cache_entry *ent)
 {
 	free(ent->data);
@@ -1521,20 +1504,35 @@ int packed_object_info(struct repository *r, struct packed_git *p,
 		       off_t obj_offset, struct object_info *oi)
 {
 	struct pack_window *w_curs = NULL;
-	unsigned long size;
 	off_t curpos = obj_offset;
 	enum object_type type;
+	struct delta_base_cache_entry *ent;
 
 	/*
 	 * We always get the representation type, but only convert it to
 	 * a "real" type later if the caller is interested.
 	 */
-	if (oi->contentp && !oi->content_limit) {
-		*oi->contentp = cache_or_unpack_entry(r, p, obj_offset, oi->sizep,
-						      &type);
+	oi->whence = OI_PACKED;
+	ent = get_delta_base_cache_entry(p, obj_offset);
+	if (ent) {
+		oi->whence = OI_DBCACHED;
+		type = ent->type;
+		if (oi->sizep)
+			*oi->sizep = ent->size;
+		if (oi->contentp) {
+			if (!oi->content_limit ||
+					ent->size <= oi->content_limit)
+				*oi->contentp = xmemdupz(ent->data, ent->size);
+			else
+				*oi->contentp = NULL; /* caller must stream */
+		}
+	} else if (oi->contentp && !oi->content_limit) {
+		*oi->contentp = unpack_entry(r, p, obj_offset, &type,
+						oi->sizep);
 		if (!*oi->contentp)
 			type = OBJ_BAD;
 	} else {
+		unsigned long size;
 		type = unpack_object_header(p, &w_curs, &curpos, &size);
 
 		if (oi->sizep) {
@@ -1558,8 +1556,8 @@ int packed_object_info(struct repository *r, struct packed_git *p,
 
 		if (oi->contentp) {
 			if (oi->sizep && *oi->sizep <= oi->content_limit) {
-				*oi->contentp = cache_or_unpack_entry(r, p, obj_offset,
-								      oi->sizep, &type);
+				*oi->contentp = unpack_entry(r, p, obj_offset,
+							&type, oi->sizep);
 				if (!*oi->contentp)
 					type = OBJ_BAD;
 			} else {
@@ -1608,10 +1606,6 @@ int packed_object_info(struct repository *r, struct packed_git *p,
 		} else
 			oidclr(oi->delta_base_oid, the_repository->hash_algo);
 	}
-
-	oi->whence = in_delta_base_cache(p, obj_offset) ? OI_DBCACHED :
-							  OI_PACKED;
-
 out:
 	unuse_pack(&w_curs);
 	return type;
