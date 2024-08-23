Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265D41494D6
	for <git@vger.kernel.org>; Fri, 23 Aug 2024 22:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.242.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724453207; cv=none; b=RUrSbv4BBz2U7O6S3YIaCs9RYw2dVjwUlUMHU1X57chOfOFFxKYEkcdF+5ag0P8/Eelo9dFm9ETIZJW5e9S6sGP7Mgtjy9gPjAUbDbyhrZCdCXeBE/oCgzHdrSth/EIlhlimjshZTMhR/X9xgHrv6W86eDR5MXDI9hU9zwtBoCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724453207; c=relaxed/simple;
	bh=SArNgN2UzZkvQadUCzwbYY3hHG/wMQSy2RtMHHcigeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rFHR4xnFQdvySHlbbr4oUhVarCEl4ZEfrbkr6tF46dlpPk0RRp62UYXyBFoYClVYaXdRw8d+HnpcAs3mKb5Y3529iID2ZxllzBls9MwTvycNUo3xoDvOy+0stcLYiSyxAv1RsWu7zMoNqBoNZon1IQt2NsiX6Q24tE66pG+QvrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org; spf=pass smtp.mailfrom=80x24.org; dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b=0azNF5v+; arc=none smtp.client-ip=173.255.242.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=80x24.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b="0azNF5v+"
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A0DD1F47C;
	Fri, 23 Aug 2024 22:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
	s=selector1; t=1724453191;
	bh=SArNgN2UzZkvQadUCzwbYY3hHG/wMQSy2RtMHHcigeo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0azNF5v+uGWW9adkzRuIn9QgWNQkooPZFEyD9q1jXMKMkb729SjwkJ9VvuPPXwRY0
	 9yskjXfeIEsJF5pMZi2jkWCGmAKf16Yeh87gaNwV4EzHgouRSJDqhsOVKugKIS9IAC
	 QGBcuPvtt3VJO8YZaqQ+HvHjH++KHWIbI32vRz3o=
From: Eric Wong <e@80x24.org>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 01/10] packfile: move sizep computation
Date: Fri, 23 Aug 2024 22:46:21 +0000
Message-ID: <20240823224630.1180772-2-e@80x24.org>
In-Reply-To: <20240823224630.1180772-1-e@80x24.org>
References: <20240823224630.1180772-1-e@80x24.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff King <peff@peff.net>

Moving the sizep computation now makes the next commit to avoid
redundant object info lookups easier to understand.  There is
no user-visible change, here.

[ew: commit message]

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Eric Wong <e@80x24.org>
---
 packfile.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/packfile.c b/packfile.c
index 813584646f..4028763947 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1536,24 +1536,24 @@ int packed_object_info(struct repository *r, struct packed_git *p,
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
 
