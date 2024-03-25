Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F0F8174F
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 23:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.242.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711408053; cv=none; b=cG8qxZzQ0Ah/DiXLoE9NWf2Psy1qB6u1SRMMo4sb95v0RAorjsUTRayN6C3oN62YgRX7rAtv6SEoauhqdStc5g/Xx63U97E3kKRA0OAUbH8mjpubJzEiwAEJTeEXSjQkw8mB3GerGobNqW1MT5rPFC+bjOZZs4zAsRPw/vYd8+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711408053; c=relaxed/simple;
	bh=lzOP+ucr4p+PyTQgRs/NmEzhnCR2dluI1XxwF4qKPjE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CJqty0PdCnhvHlD8x6N8vksWn95aQ8nZRfEBn7mny9InsvSpf98tyYU8pD4b/tbyfepfXdXmxu6aIcQ1Y3lnNNWHB5ZcMh9UWAsCBHIaauhi1Lx8Mtv+Rp+nd+b8sjGrNIxw2TqtWdeby1DDs2jfoSNxMd7okUJyWcD2sGQeOWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org; spf=pass smtp.mailfrom=80x24.org; dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b=iO8n7U/4; arc=none smtp.client-ip=173.255.242.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=80x24.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b="iO8n7U/4"
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCA101F51B
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 23:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
	s=selector1; t=1711408024;
	bh=lzOP+ucr4p+PyTQgRs/NmEzhnCR2dluI1XxwF4qKPjE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=iO8n7U/4/T6ywo8WD6tbUqpYLpmgklRHLoLcAOeTDhOz3OmcH7/Mr1T7Zrfw8Hz20
	 96I9YLz3zULu0zQbmkdkFxCGyOgiPWCGHJSlniS4zjxkRYSlJN469g6gmKyeLjEPvD
	 14dUuhMsT6wTLayXdAY5EzNc159xuc+Z2VL6rPnc=
From: Eric Wong <e@80x24.org>
To: git@vger.kernel.org
Subject: [PATCH 3/3] khashl: fix ensemble lookups on empty table
Date: Mon, 25 Mar 2024 23:07:03 +0000
Message-ID: <20240325230704.262272-4-e@80x24.org>
In-Reply-To: <20240325230704.262272-1-e@80x24.org>
References: <20240325230704.262272-1-e@80x24.org>
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
index 3660fd2ce4..8ffe80fbb2 100644
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
