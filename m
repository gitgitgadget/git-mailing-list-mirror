Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64915524BD
	for <git@vger.kernel.org>; Thu, 28 Mar 2024 10:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.242.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711620866; cv=none; b=l8RIhtcwoF13GiRYWimOCAZMOBOAGLa4/NhWzEGukto9TuXxUGxFkWsc61CmOEVaTqd5OF8kyfGvq0mAGXKjYQEM1f8KrT15VMR4gWx/nVdA7+YaeJ0bxlyJLgSh479MZlrg3xCzxbeUiBerYRmYizGHegZ4h/pug20TFnwznsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711620866; c=relaxed/simple;
	bh=ICtXQZ21cArDrjjGp3fDu0j/A4RIpCgPgQ2r0/N3t7Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A8WFGpxDaxpr07ekS3/kuPnGkxDBT+vAHcWOVrInbaarJ59fWxEHfFp1NOwYEulWUIk1Ro7z5vCn8OsIFeawrPRyKKuJ3N0bgrZeimTzHp34lXROWc6/pq/mWY9LyGJ3aHEbs1+VL6Y+SzjKvC60YgW5yogJmIsY/JIXnjXA38Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org; spf=pass smtp.mailfrom=80x24.org; dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b=Xp/UXdde; arc=none smtp.client-ip=173.255.242.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=80x24.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b="Xp/UXdde"
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 435BF1F51B
	for <git@vger.kernel.org>; Thu, 28 Mar 2024 10:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
	s=selector1; t=1711620837;
	bh=ICtXQZ21cArDrjjGp3fDu0j/A4RIpCgPgQ2r0/N3t7Y=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Xp/UXddenJjUy+gCzmgu/oFyTWUWFTJvWnggemuYKbVObfwGpHbsIzecwkVDtx2Me
	 p/oiP3i4dfQJr8PIw66w7n2igARI71wzj29G8zAoJhPG4nDM6mgekK0gBNtd5a5W4A
	 MAE6fq6ytA/4jbyO0wsThvPkPlh9n41NXMFyKK3w=
From: Eric Wong <e@80x24.org>
To: git@vger.kernel.org
Subject: [PATCH 3/3] khashl: fix ensemble lookups on empty table
Date: Thu, 28 Mar 2024 10:13:56 +0000
Message-ID: <20240328101356.300374-4-e@80x24.org>
In-Reply-To: <20240328101356.300374-1-e@80x24.org>
References: <20240328101356.300374-1-e@80x24.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ->bits field of regular khashl structs is invalid when
the ->keys array is NULL.  Thus the ensemble *_getp implementation
must follow existing *_get and *_getp usage conventions and
check the iterator against kh_end().

This fixes a fast-import crash on t3427-rebase-subtree.sh in an
abandoned commit to use the ensemble implementation for oid_map
and oid_pos.  I've abandoned the aforementioned commit for now
since it was more intrusive, more expensive for small tables,
and realloc(3) on glibc is already optimized using mremap(2) for
large hash resizes.

Signed-off-by: Eric Wong <e@80x24.org>
---
 khashl.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/khashl.h b/khashl.h
index 1e724bbf88..30f85dc5e2 100644
--- a/khashl.h
+++ b/khashl.h
@@ -265,7 +265,7 @@ typedef struct {
 		low = hash & ((1U<<g->bits) - 1); \
 		h = &g->sub[low]; \
 		ret = prefix##_sub_getp_core(h, key, hash); \
-		if (ret == 1U<<h->bits) r.sub = low, r.pos = (khint_t)-1; \
+		if (ret >= kh_end(h)) r.sub = low, r.pos = (khint_t)-1; \
 		else r.sub = low, r.pos = ret; \
 		return r; \
 	} \
