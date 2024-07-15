Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655BE360
	for <git@vger.kernel.org>; Mon, 15 Jul 2024 00:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.242.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721003734; cv=none; b=pb8ZiZfEnD13KWy9Ro9HLIpL38ujhUGRd8QJz29F5R5r/InSm3nqu1G+gIY2KvkKDc+RBMDA4qo6D+zLbyIEuYWxVaiVSlpo5D8Qz05rchf+jeQALcemRgijnfxZaeJoUosHmUNCY5J0PjeuD+mvRxigfaxhus5NzZDKatMxxPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721003734; c=relaxed/simple;
	bh=mQudGzNO+h8/lc43I6VsFekp2tx9bSkvLl4h0JG336Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=elnESpsv9+VzdPmUY97QncWWSIDyf6to+394AEO2XXN+x3VAnbz64R28q1pxDryLRFMGjGYFpK0OuA1bILp3dvH3a1Yn/fAb/ReDHVOVs5v02dUfTEVZGM8WXht2cYv4MK/CwX/d6KGHhLevXo+ErMPUsWTlp27L/iqy/hxgcsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org; spf=pass smtp.mailfrom=80x24.org; dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b=mdjyel7H; arc=none smtp.client-ip=173.255.242.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=80x24.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b="mdjyel7H"
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01F921F5A4;
	Mon, 15 Jul 2024 00:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
	s=selector1; t=1721003720;
	bh=mQudGzNO+h8/lc43I6VsFekp2tx9bSkvLl4h0JG336Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mdjyel7Hex4cJIL91XPtPU3uAUTF/KSk8Q6yg1X8SuJcqS3UwWa99V/Db8vL32WNG
	 BTuxDH9cDQ9hF60dqlLPmX5GcdO/RpxO6pW1nJYdRmItxGA5cwB2BhoMOzieNmuteL
	 BBOeqEp3iznKMHy+nXQPQx+uH5Xk4Vivs5ZhN0a8=
From: Eric Wong <e@80x24.org>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>
Subject: [PATCH v1 01/10] packfile: move sizep computation
Date: Mon, 15 Jul 2024 00:35:10 +0000
Message-ID: <20240715003519.2671385-2-e@80x24.org>
In-Reply-To: <20240715003519.2671385-1-e@80x24.org>
References: <20240715003519.2671385-1-e@80x24.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff King <peff@peff.net>

This makes the next commit to avoid redundant object info
lookups easier to understand.

[ew: commit message]

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Eric Wong <e@80x24.org>
---
 packfile.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/packfile.c b/packfile.c
index 813584646f..e547522e3d 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1527,7 +1527,8 @@ int packed_object_info(struct repository *r, struct packed_git *p,
 
 	/*
 	 * We always get the representation type, but only convert it to
-	 * a "real" type later if the caller is interested.
+	 * a "real" type later if the caller is interested. Likewise...
+	 * tbd.
 	 */
 	if (oi->contentp) {
 		*oi->contentp = cache_or_unpack_entry(r, p, obj_offset, oi->sizep,
@@ -1536,24 +1537,24 @@ int packed_object_info(struct repository *r, struct packed_git *p,
 			type = OBJ_BAD;
 	} else {
 		type = unpack_object_header(p, &w_curs, &curpos, &size);
-	}
 
-	if (!oi->contentp && oi->sizep) {
-		if (type == OBJ_OFS_DELTA || type == OBJ_REF_DELTA) {
-			off_t tmp_pos = curpos;
-			off_t base_offset = get_delta_base(p, &w_curs, &tmp_pos,
-							   type, obj_offset);
-			if (!base_offset) {
-				type = OBJ_BAD;
-				goto out;
+		if (oi->sizep) {
+			if (type == OBJ_OFS_DELTA || type == OBJ_REF_DELTA) {
+				off_t tmp_pos = curpos;
+				off_t base_offset = get_delta_base(p, &w_curs, &tmp_pos,
+								   type, obj_offset);
+				if (!base_offset) {
+					type = OBJ_BAD;
+					goto out;
+				}
+				*oi->sizep = get_size_from_delta(p, &w_curs, tmp_pos);
+				if (*oi->sizep == 0) {
+					type = OBJ_BAD;
+					goto out;
+				}
+			} else {
+				*oi->sizep = size;
 			}
-			*oi->sizep = get_size_from_delta(p, &w_curs, tmp_pos);
-			if (*oi->sizep == 0) {
-				type = OBJ_BAD;
-				goto out;
-			}
-		} else {
-			*oi->sizep = size;
 		}
 	}
 
