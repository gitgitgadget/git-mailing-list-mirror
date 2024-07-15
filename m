Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11304C62
	for <git@vger.kernel.org>; Mon, 15 Jul 2024 00:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.242.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721003769; cv=none; b=Wn94w3t7htrKxPPPB7W/dAUZXxa0oOj1Mpx5pE0Ei92iRXl6MXoJ6AT8I1ZbV5o49gyRxBUTfbF9KAxuAYNrQXeogTKYBfAlwsxqlwRJyynHlRxXu+XB5r6OICqijduQlvlMrlJUmfH4EfL5yAfrDEqx/ADBzTF/reizYzxwb4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721003769; c=relaxed/simple;
	bh=JOhPhjCzcf5BarZEBp2Wfhcc1L/NxMLH9Uc/P1tnxCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qGCTBO26Bu1Fy3KU6PtBh8+DxzHQS5a9JiJ5CX0xRfmoaPItbH9zztRWxoGbgYG5Sydz37FyArYJCJH3bSwQhnWiztbheNAkRoXOifZJy4uE/ZbqybrmoDzRNh80tY0mSk27qnBICsLk8RgW4BM0UzsmqI0Th7u/hMzkAvW1OYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org; spf=pass smtp.mailfrom=80x24.org; dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b=k93l/Cxy; arc=none smtp.client-ip=173.255.242.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=80x24.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b="k93l/Cxy"
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD3401F5B8;
	Mon, 15 Jul 2024 00:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
	s=selector1; t=1721003720;
	bh=JOhPhjCzcf5BarZEBp2Wfhcc1L/NxMLH9Uc/P1tnxCQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k93l/CxyxU2REnocMNvlrLqPqlJ2YJo0Gyds17uMrf2ra+njPmIgCJ+1PIUF+g6x0
	 euQzzIDquoxKZKhKCiwaQxx8LboXitvv4GRIx538I3Xd1fYn79He3hWJhGI5w7lB6F
	 ccEYYRzonRsMfr84u9/F7Fptf+4twIJyK2xKKvfo=
From: Eric Wong <e@80x24.org>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>
Subject: [PATCH v1 06/10] packfile: packed_object_info avoids packed_to_object_type
Date: Mon, 15 Jul 2024 00:35:15 +0000
Message-ID: <20240715003519.2671385-7-e@80x24.org>
In-Reply-To: <20240715003519.2671385-1-e@80x24.org>
References: <20240715003519.2671385-1-e@80x24.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For calls the delta base cache, packed_to_object_type calls
can be omitted.  This prepares us to bypass content_limit for
non-blob types in the following commit.

Signed-off-by: Eric Wong <e@80x24.org>
---
 packfile.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/packfile.c b/packfile.c
index b2660e14f9..c2ba6ab203 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1522,7 +1522,7 @@ int packed_object_info(struct repository *r, struct packed_git *p,
 {
 	struct pack_window *w_curs = NULL;
 	off_t curpos = obj_offset;
-	enum object_type type;
+	enum object_type type, final_type = OBJ_BAD;
 	struct delta_base_cache_entry *ent;
 
 	/*
@@ -1534,7 +1534,7 @@ int packed_object_info(struct repository *r, struct packed_git *p,
 	ent = get_delta_base_cache_entry(p, obj_offset);
 	if (ent) {
 		oi->whence = OI_DBCACHED;
-		type = ent->type;
+		final_type = type = ent->type;
 		if (oi->sizep)
 			*oi->sizep = ent->size;
 		if (oi->contentp) {
@@ -1552,6 +1552,7 @@ int packed_object_info(struct repository *r, struct packed_git *p,
 	} else if (oi->contentp && !oi->content_limit) {
 		*oi->contentp = unpack_entry(r, p, obj_offset, &type,
 						oi->sizep);
+		final_type = type;
 		if (!*oi->contentp)
 			type = OBJ_BAD;
 	} else {
@@ -1581,6 +1582,7 @@ int packed_object_info(struct repository *r, struct packed_git *p,
 			if (oi->sizep && *oi->sizep <= oi->content_limit) {
 				*oi->contentp = unpack_entry(r, p, obj_offset,
 							&type, oi->sizep);
+				final_type = type;
 				if (!*oi->contentp)
 					type = OBJ_BAD;
 			} else {
@@ -1602,17 +1604,17 @@ int packed_object_info(struct repository *r, struct packed_git *p,
 	}
 
 	if (oi->typep || oi->type_name) {
-		enum object_type ptot;
-		ptot = packed_to_object_type(r, p, obj_offset,
-					     type, &w_curs, curpos);
+		if (final_type < 0)
+			final_type = packed_to_object_type(r, p, obj_offset,
+						     type, &w_curs, curpos);
 		if (oi->typep)
-			*oi->typep = ptot;
+			*oi->typep = final_type;
 		if (oi->type_name) {
-			const char *tn = type_name(ptot);
+			const char *tn = type_name(final_type);
 			if (tn)
 				strbuf_addstr(oi->type_name, tn);
 		}
-		if (ptot < 0) {
+		if (final_type < 0) {
 			type = OBJ_BAD;
 			goto out;
 		}
