Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5271494D6
	for <git@vger.kernel.org>; Fri, 23 Aug 2024 22:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.242.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724453221; cv=none; b=Jix5czwYggxFIqG4XD6h+cTKentRlKSJIcAoCsLzwv7RFdcCN9VwQiXbga55MX1MRKm0UZTsZI50/aynXLW+E4hF5D8mRBzYyJPa6JF/WToWfEkYMzvn4Z88J0IOHdjtyCfriQaUJxLdtuS81kjLKF2UI1QsZRlaNHPM+LCopw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724453221; c=relaxed/simple;
	bh=0uSYoHBRtgj/qBAnm1Qlgx5WLjkFSKGVnkr45CCe6uA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VpvFQJdi9O8i2LG7rm/aKGkmfuEV8J82mFCOJ80IcgHJjERp2kOutifzwDQSqgI5lPkbsJ4WeDVPIms89Gc3DK4i16aQu9EQpiu3+hVfPmHUH0bwg46LW7cynqbt1+dpzL6huM5wKsGvDGlm5qRFYLAz0f/Eh1NhcSz0Ebuk7nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org; spf=pass smtp.mailfrom=80x24.org; dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b=LZLbjYZK; arc=none smtp.client-ip=173.255.242.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=80x24.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b="LZLbjYZK"
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1DEE1F518;
	Fri, 23 Aug 2024 22:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
	s=selector1; t=1724453191;
	bh=0uSYoHBRtgj/qBAnm1Qlgx5WLjkFSKGVnkr45CCe6uA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LZLbjYZKYkMzFi7xL1PPwrdt8Vw0uVtmT/+r8vj3lQiTqVvjYE9Q5k9r7On/KNEvv
	 koJ+b7PmYwRLvcNRmrNGUSzOe0FBDDhVQG1W4Fnm/p8cdCbYPDxH04/FXpzgOvH3dN
	 zzMeysPgl1WZTGG+/U+oG7uegZdoiAqfkBc5yRDg=
From: Eric Wong <e@80x24.org>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 03/10] packfile: fix off-by-one in content_limit comparison
Date: Fri, 23 Aug 2024 22:46:23 +0000
Message-ID: <20240823224630.1180772-4-e@80x24.org>
In-Reply-To: <20240823224630.1180772-1-e@80x24.org>
References: <20240823224630.1180772-1-e@80x24.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

object-file.c::loose_object_info() accepts objects matching
content_limit exactly, so it follows packfile handling allows
slurping objects which match loose object handling and slurp
objects with size matching the content_limit exactly.

This change is merely for consistency with the majority of
existing code and there is no user visible change in nearly all
cases.  The only exception being the corner case when the object
size matches content_limit exactly where users will see a
speedup from avoiding an extra lookup.

Signed-off-by: Eric Wong <e@80x24.org>
---
 packfile.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/packfile.c b/packfile.c
index c12a0515b3..8ec86d2d69 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1557,7 +1557,7 @@ int packed_object_info(struct repository *r, struct packed_git *p,
 		}
 
 		if (oi->contentp) {
-			if (oi->sizep && *oi->sizep < oi->content_limit) {
+			if (oi->sizep && *oi->sizep <= oi->content_limit) {
 				*oi->contentp = cache_or_unpack_entry(r, p, obj_offset,
 								      oi->sizep, &type);
 				if (!*oi->contentp)
