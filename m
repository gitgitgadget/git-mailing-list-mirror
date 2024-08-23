Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D5A185B72
	for <git@vger.kernel.org>; Fri, 23 Aug 2024 22:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.242.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724453241; cv=none; b=JEa5btVl4RtSS4kaCaArSd3L5YVkoJ5ysDIR6+C4Ad9Qg4IyYWdBkr6tc0VH7DRa3F4EkDfpdKK3/ipOV+92i9RqJTVhCeh1k4trxHHQFqHrMVnmPuZxma7NB6oGdFWuN/ihhE6JJJfMUQNSlbi5wFYl4cIraINZ7W5Ys1Sfjew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724453241; c=relaxed/simple;
	bh=zb2xoGXnokuGuwwvXQvRs+zGHt7IWeuNo1s76QQNlNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AezbtQznJfFjtBRht/9onTekHSO/YETmENx5TbDyInz6SWigl1HGgsqwJ7xZN42fZ7K/LLT7WO27ThU0YFAxkBA8J8zPrcIsmWPdusnge48pSCDWl8EFhoUK1Xdd0zmdeN9apwXPkDS4piMSlWQLl6oFcz7Gb/zWIjAjaPUvtDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org; spf=pass smtp.mailfrom=80x24.org; dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b=aef2FtuY; arc=none smtp.client-ip=173.255.242.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=80x24.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b="aef2FtuY"
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4056D1F543;
	Fri, 23 Aug 2024 22:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
	s=selector1; t=1724453192;
	bh=zb2xoGXnokuGuwwvXQvRs+zGHt7IWeuNo1s76QQNlNQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aef2FtuYMxaf0+88QeMLBe11+ZUIjykwu8oh9/K0y4QZqYHxM1cOzXh9EMYPhiMav
	 d1XkbDWbagV6MS13R99/M0PcBbXR8B89QqLkp4+MVmcOrFy62Zk8r1WgRzU7h4C1c1
	 yfUOlSWa7++u0T0Y5LYDV6wrjrSuiitr+5NecrJk=
From: Eric Wong <e@80x24.org>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 06/10] packfile: packed_object_info avoids packed_to_object_type
Date: Fri, 23 Aug 2024 22:46:26 +0000
Message-ID: <20240823224630.1180772-7-e@80x24.org>
In-Reply-To: <20240823224630.1180772-1-e@80x24.org>
References: <20240823224630.1180772-1-e@80x24.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For entries in the delta base cache, packed_to_object_type calls
can be omitted.  This prepares us to bypass content_limit for
non-blob types in the following commit.

Signed-off-by: Eric Wong <e@80x24.org>
---
 packfile.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/packfile.c b/packfile.c
index 40c6c2e387..94d20034e4 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1527,7 +1527,7 @@ int packed_object_info(struct repository *r, struct packed_git *p,
 {
 	struct pack_window *w_curs = NULL;
 	off_t curpos = obj_offset;
-	enum object_type type;
+	enum object_type type, final_type = OBJ_BAD;
 	struct delta_base_cache_entry *ent;
 
 	/*
@@ -1538,7 +1538,7 @@ int packed_object_info(struct repository *r, struct packed_git *p,
 	ent = get_delta_base_cache_entry(p, obj_offset);
 	if (ent) {
 		oi->whence = OI_DBCACHED;
-		type = ent->type;
+		final_type = type = ent->type;
 		if (oi->sizep)
 			*oi->sizep = ent->size;
 		if (oi->contentp) {
@@ -1556,6 +1556,7 @@ int packed_object_info(struct repository *r, struct packed_git *p,
 	} else if (oi->contentp && !oi->content_limit) {
 		*oi->contentp = unpack_entry(r, p, obj_offset, &type,
 						oi->sizep);
+		final_type = type;
 		if (!*oi->contentp)
 			type = OBJ_BAD;
 	} else {
@@ -1585,6 +1586,7 @@ int packed_object_info(struct repository *r, struct packed_git *p,
 			if (oi->sizep && *oi->sizep <= oi->content_limit) {
 				*oi->contentp = unpack_entry(r, p, obj_offset,
 							&type, oi->sizep);
+				final_type = type;
 				if (!*oi->contentp)
 					type = OBJ_BAD;
 			} else {
@@ -1606,17 +1608,17 @@ int packed_object_info(struct repository *r, struct packed_git *p,
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
