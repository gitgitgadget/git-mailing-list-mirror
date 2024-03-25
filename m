Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F048174F
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 23:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.242.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711408037; cv=none; b=bNoMgibf4NFogyplWZKU7MCu6FCsQpAk+3X6GBoOPUjvIaZ1xbgMRXk3L5joaa8rrHuX5zmrxEln6JwWxRhniTcWDCkx7Lmi3YHGM7vAbThER4so4QEzrDrSjAQ49TQjN629e+q/fKqOIV0pB522DX7jHQPZcatADurvge5m7J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711408037; c=relaxed/simple;
	bh=dEys3V09NyfME1QeiokPFMql68pkfxRaCMR9aIwiFtw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nYe4xxDI1DDvyWBu5tNtTOHeHy0MsuuF8oZcp4odbnBIcnhezwc9qco/zpcXsdPddEFWw8tIiTWGR58GW+ioYAfaKnGB9N9qbpwU0vEDvR5t7zSlG/IcTc2KsFf6trG76Tg5PW6Z+eimLgoRD8fcRcjdPNtY4x0kWJtDhDLlsAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org; spf=pass smtp.mailfrom=80x24.org; dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b=k1XsqITT; arc=none smtp.client-ip=173.255.242.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=80x24.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b="k1XsqITT"
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90F8B1F461
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 23:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
	s=selector1; t=1711408024;
	bh=dEys3V09NyfME1QeiokPFMql68pkfxRaCMR9aIwiFtw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=k1XsqITT5XHBeI+cN0vqqAEMwsDzOR1bpI3xVY814LlIX5+w789Tjr5RVbBnaJtTV
	 fAv2mO9eyfDMhG4zu2THXh4y6aWUqi5srEObrFka1V7MjhAFUeDmtmk3DnlG6mH7ab
	 AK0rjYo1KCoYvYfVMLDLr2kfmbzzCESzV6RMw5WQ=
From: Eric Wong <e@80x24.org>
To: git@vger.kernel.org
Subject: [PATCH 1/3] list-objects-filter: use kh_size API
Date: Mon, 25 Mar 2024 23:07:01 +0000
Message-ID: <20240325230704.262272-2-e@80x24.org>
In-Reply-To: <20240325230704.262272-1-e@80x24.org>
References: <20240325230704.262272-1-e@80x24.org>
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
