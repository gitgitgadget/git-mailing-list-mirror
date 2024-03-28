Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778C24F898
	for <git@vger.kernel.org>; Thu, 28 Mar 2024 10:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.242.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711620851; cv=none; b=UubQSUYf5Tx/H3NIm145q4rakCrfvOEB6NCYF1elLRrQhPwDR6NpPZCX7s2EGbnTr1ZQmMthU1tCQHwGm8gayTDGuXxx/yzcY4F4UyYlyFqPZuQX9bsW1gJWX8+oBf9ybbZesGfpB2XHtvGy4kgp6WTA+AnYrCLhHcBLuBLTRDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711620851; c=relaxed/simple;
	bh=dEys3V09NyfME1QeiokPFMql68pkfxRaCMR9aIwiFtw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eRjmk8LtE09B6T7jJHYV0KPCRafDUfu5OXqFsBSY8bG2db5zJiBZGPqLyYLW/qTfwGUWQ3HJ195T0iAfmmEKXrnACMVZrYVGqk+k1q7dD9sfmGUTubSiSq7GxBGRFVD3tWLuEszK3s1qizjGtKFhCe79IoMolbXnr1G+67H9jfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org; spf=pass smtp.mailfrom=80x24.org; dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b=sl/SLzSX; arc=none smtp.client-ip=173.255.242.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=80x24.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b="sl/SLzSX"
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDB9E1F461
	for <git@vger.kernel.org>; Thu, 28 Mar 2024 10:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
	s=selector1; t=1711620836;
	bh=dEys3V09NyfME1QeiokPFMql68pkfxRaCMR9aIwiFtw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=sl/SLzSX984hCLKkH8muXHS9B0LF/+9WtoI+cJhoMhUUkZdbY1SUdfajG+vwB+3if
	 yY0647NvHy+EVbxIozMPdkP3K8sDJTTXEfD4C2/gyNdkBlFbuapf6IVTydWqhNcgL+
	 EGqhVD/zAePk1WhMu2La2J8LQ187if1gN8Dj4otc=
From: Eric Wong <e@80x24.org>
To: git@vger.kernel.org
Subject: [PATCH 1/3] list-objects-filter: use kh_size API
Date: Thu, 28 Mar 2024 10:13:54 +0000
Message-ID: <20240328101356.300374-2-e@80x24.org>
In-Reply-To: <20240328101356.300374-1-e@80x24.org>
References: <20240328101356.300374-1-e@80x24.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to ease a potential migration to from khash to khashl,
use the kh_size() macro instead of accessing the .size field
directly.

Signed-off-by: Eric Wong <e@80x24.org>
---
 list-objects-filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/list-objects-filter.c b/list-objects-filter.c
index 4346f8da45..440f112d23 100644
--- a/list-objects-filter.c
+++ b/list-objects-filter.c
@@ -704,7 +704,7 @@ static void filter_combine__free(void *filter_data)
 	for (sub = 0; sub < d->nr; sub++) {
 		list_objects_filter__free(d->sub[sub].filter);
 		oidset_clear(&d->sub[sub].seen);
-		if (d->sub[sub].omits.set.size)
+		if (kh_size(&d->sub[sub].omits.set))
 			BUG("expected oidset to be cleared already");
 	}
 	free(d->sub);
