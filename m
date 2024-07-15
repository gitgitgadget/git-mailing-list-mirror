Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40614C6D
	for <git@vger.kernel.org>; Mon, 15 Jul 2024 00:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.242.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721003755; cv=none; b=Ge7cIAzIjuzAeTuXtuY3ED36Tbu0Vp4S6P+wxv5MJ2XHXKI/kbjHCd696bCcWUsTFWr9FFW7B+JcPdmg7INC71KJrzH0t/6wz0X7O+0OyAptgdvpB4n1+WXh/1TT1kgQQ019nb3r7dxVVl7oYvhwuXuOMvRefFz18KIbS4OhdZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721003755; c=relaxed/simple;
	bh=WZBQ3mGXGyaF2er44iQ0z9ZuQHs0WIHcufbfV4YYIrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b4KWC9SHlfqWBsKYxfe4tbRZmqhaeXxH5QnUBH40abh1Ha/O4KqEaeqRDpQpqjFdIJSyzMwhgJBbBmHhP+bxR8BF+CgZA9chGkChiZUM8ZOEwZKiLP096FLNUWcgE0he84GZjmOK+pw55Z4XnXp1kEVvuyCDhes5N31+aluyIFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org; spf=pass smtp.mailfrom=80x24.org; dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b=FsVYGROG; arc=none smtp.client-ip=173.255.242.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=80x24.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b="FsVYGROG"
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F2511F5B6;
	Mon, 15 Jul 2024 00:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
	s=selector1; t=1721003720;
	bh=WZBQ3mGXGyaF2er44iQ0z9ZuQHs0WIHcufbfV4YYIrs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FsVYGROGOHqn47+bd7wNHBiENILQP48BOF0YazcZxVvbbyz9w/ak7scMdjSTTT+7l
	 Kx8gDIlPaGsdaimxVCLavo6NsmJ3qTZ2tnC2C9KIuz1tyMP1UVDTEneO4HsVZY6Cy7
	 udnb2CDAfV2J/VdBp2zlsLAuMA5BjM0Q/OWFo2IM=
From: Eric Wong <e@80x24.org>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>
Subject: [PATCH v1 04/10] packfile: inline cache_or_unpack_entry
Date: Mon, 15 Jul 2024 00:35:13 +0000
Message-ID: <20240715003519.2671385-5-e@80x24.org>
In-Reply-To: <20240715003519.2671385-1-e@80x24.org>
References: <20240715003519.2671385-1-e@80x24.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We need to check delta_base_cache anyways to fill in the
`whence' field in `struct object_info'.  Inlining
cache_or_unpack_entry() makes it easier to only do the hashmap
lookup once and avoid a redundant lookup later on.

This code reorganization will also make an optimization to
use the cache entry directly easier to implement.

Signed-off-by: Eric Wong <e@80x24.org>
---
 packfile.c | 48 +++++++++++++++++++++---------------------------
 1 file changed, 21 insertions(+), 27 deletions(-)

diff --git a/packfile.c b/packfile.c
index 371da96cdb..1a409ec142 100644
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
@@ -1521,21 +1504,36 @@ int packed_object_info(struct repository *r, struct packed_git *p,
 		       off_t obj_offset, struct object_info *oi)
 {
 	struct pack_window *w_curs = NULL;
-	unsigned long size;
 	off_t curpos = obj_offset;
 	enum object_type type;
+	struct delta_base_cache_entry *ent;
 
 	/*
 	 * We always get the representation type, but only convert it to
 	 * a "real" type later if the caller is interested. Likewise...
 	 * tbd.
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
@@ -1559,8 +1557,8 @@ int packed_object_info(struct repository *r, struct packed_git *p,
 
 		if (oi->contentp) {
 			if (oi->sizep && *oi->sizep <= oi->content_limit) {
-				*oi->contentp = cache_or_unpack_entry(r, p, obj_offset,
-								      oi->sizep, &type);
+				*oi->contentp = unpack_entry(r, p, obj_offset,
+							&type, oi->sizep);
 				if (!*oi->contentp)
 					type = OBJ_BAD;
 			} else {
@@ -1609,10 +1607,6 @@ int packed_object_info(struct repository *r, struct packed_git *p,
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
