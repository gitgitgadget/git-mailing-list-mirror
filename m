Received: from sirabella.org (sirabella.org [207.246.81.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A7018AE0
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 02:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.246.81.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709605083; cv=none; b=NedOyR+sT5we3MRyb2XFnrs85fe4Rk1vDp0eaSWdabVxcnIslk1kxEmWpuKA3aXsHKthQ7FG457DN2b2LgDxIDDRbBNqkxJia/c82hHIpNHqgK3vf0Mbvd65FIJvaIWY3X+dYgp7Pon77DrnI1ZzlTsOokOuwHaewj4YlUjZ4T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709605083; c=relaxed/simple;
	bh=s4uPcvIrNOU6CDZ/Z1ykhiL46RrbRygSpi/TTun5Gbo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DdFh5CI7tbpyT+DOG0km8/xdMO4lN1XYYbF4HQkWqV3vTnQgX7gbsnocuCdVE2NKXjIIGf0L+2sEJIvixFWJt4zfOY5WlOPvruGZM+WQfYw5lv+0KCOpdcPBIACIiP0Gcb6aIv6Zs/IzrRbyN8ZeC+hj7ZVcjTk+PdNZ72knmxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sirabella.org; spf=pass smtp.mailfrom=sirabella.org; dkim=pass (1024-bit key) header.d=sirabella.org header.i=@sirabella.org header.b=IWfT0sVr; arc=none smtp.client-ip=207.246.81.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sirabella.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sirabella.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sirabella.org header.i=@sirabella.org header.b="IWfT0sVr"
From: Marco Sirabella <marco@sirabella.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sirabella.org;
	s=mail; t=1709604530;
	bh=S6JOeDUAb9N/YoN7cizqQDkHH3bpkMK8srwkcIoCgBk=;
	h=From:To:Cc:Subject:Date;
	b=IWfT0sVrypB6eEh4DpdskhP5aAh3W7RdaytNdtsY28YwKtq/y+c11guhznJKwByRj
	 hPYY6Y/UKtdKwYgtimjPcj2Uvm9gb7+Nym/RAhDZLN83E/lNaU5lgavnU6AtPfnOg3
	 Kbfc8u/nuyJZA+0xwRCILhF8xU4/gNusc7JVIWuA=
To: git@vger.kernel.org
Cc: Marco Sirabella <marco@sirabella.org>
Subject: [PATCH] gpg-interface: Look up signing keys with only email address
Date: Mon,  4 Mar 2024 18:08:15 -0800
Message-ID: <20240305020815.2980-1-marco@sirabella.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sometimes gpg signing key UIDs include a comment between the name and
parenthesis in the form of:

  John Smith (example) jsmith@example.com

There's no way for git to find signing keys associated with just these
UIDs, so look up a partial match on the email only.

Signed-off-by: Marco Sirabella <marco@sirabella.org>
---
 gpg-interface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index 95e764acb1..3c303e05bd 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -922,7 +922,7 @@ const char *get_signing_key(void)
 		return use_format->get_default_key();
 	}
 
-	return git_committer_info(IDENT_STRICT | IDENT_NO_DATE);
+	return git_committer_info(IDENT_NO_NAME | IDENT_STRICT | IDENT_NO_DATE);
 }
 
 const char *gpg_trust_level_to_str(enum signature_trust_level level)
-- 
2.43.0

