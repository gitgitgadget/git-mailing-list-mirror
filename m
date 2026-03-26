Received: from mailproxy08.manitu.net (mailproxy08.manitu.net [217.11.48.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9E7405ADA
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 15:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.11.48.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774538588; cv=none; b=TMFhMwM29/FS/Ezos8EZwJBXAAO7jQtoEPoi5rFk8j1Z48Ki5xq0QjnhNfUbMGoD4OyiNLkhMjB4/8Zq7qCt/KTmkaOPlJvuCc0yXHw1FkSxtQEr0FQ9nFeM1mN6+By/bQBh4cOY1+y5mQJtbkiVWE+6aJK4rEobcYI5ZVku/bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774538588; c=relaxed/simple;
	bh=UcNO8nUxMsoiDwEy32ON3ST0ZnDpiXxhBZCTiA9aMIY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jgPXVL1UBbSTclFG12gjtT60Mmkw1BMmXEGTjp7sedEOgNQtZTJ1dRQ3KJLN/PNvn+vKiXYOyyJxf3g52/AZ2t6YYcLPMRxeW2dUZspQybDPndnhMXwCLDio7QxZU5GK4dYiAEsGn2efrgyEx7itzdV7IFhc0NDZPawW7N29KvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grubix.eu; spf=pass smtp.mailfrom=grubix.eu; dkim=pass (2048-bit key) header.d=grubix.eu header.i=@grubix.eu header.b=nx17fQjN; arc=none smtp.client-ip=217.11.48.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grubix.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grubix.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=grubix.eu header.i=@grubix.eu header.b="nx17fQjN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grubix.eu;
	s=manitu-webhosting; t=1774538578;
	bh=+leXXSWB9yvq0W5MUzgVZF6Fcw0VO5X9E6+SAmhPVQ4=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=nx17fQjNztlpiG0ScE4wxl9I0Ee0lB8Wr03ykFIKCgYxor81NQObv7a2n9la7CpRx
	 Hoh2dlXoMdlrvGETCPDGUcVIfFXuJJDcDctpnQYFF9WZd6EBcj1dduonhi0r0DWxFB
	 BJPRIC2fNclOtTOUiqIlpTyXC8O6qwBuXJVElnlnzAqIN6BNIIO/zjY2rcF4kU+oVr
	 YkD2uJJAnUw5i4pHMZOwCrFlJIiBhBBEt1oSOxklB3s9Wn7ax6VHgn9ZXzRhx6WkpQ
	 6U21ZfF7aLepzH///srxLJRzabZmfmi/8wznDWmwhyCmOJb1XLIYKL5sqAwMDp48qh
	 VaHcPExe33cUA==
From: Michael J Gruber <git@grubix.eu>
To: git@vger.kernel.org
Subject: [PATCH 5/6] do not discard const: keep signature
Date: Thu, 26 Mar 2026 16:22:51 +0100
Message-ID: <9a90f93111ec54e5eb9675cb84ac1d70ad95e118.1774537954.git.git@grubix.eu>
In-Reply-To: <cover.1774537954.git.git@grubix.eu>
References: <cover.1774537954.git.git@grubix.eu>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here, while we do not mutate the struct itself, many other signatures
expect a non-const argument - possibly unnecessarily - so we opt to keep
the original signature by casting to non-const.
---
 pseudo-merge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pseudo-merge.c b/pseudo-merge.c
index a2d5bd85f9..ac81792e65 100644
--- a/pseudo-merge.c
+++ b/pseudo-merge.c
@@ -644,7 +644,7 @@ static struct pseudo_merge_commit *find_pseudo_merge(const struct pseudo_merge_m
 	if (!pm->commits_nr)
 		return NULL;
 
-	return bsearch(&pos, pm->commits, pm->commits_nr,
+	return (struct pseudo_merge_commit *) bsearch(&pos, pm->commits, pm->commits_nr,
 		       PSEUDO_MERGE_COMMIT_RAWSZ, pseudo_merge_commit_cmp);
 }
 
-- 
2.53.0.1195.g771ffcb452

