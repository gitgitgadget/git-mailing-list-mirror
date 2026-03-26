Received: from mailproxy08.manitu.net (mailproxy08.manitu.net [217.11.48.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C870D3FFAB8
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 15:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.11.48.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774538971; cv=none; b=Yfm/+D6YTgr3AOHHsJH6NS2hytonDKZzmtBH7aeNSXTwxQu8RUjmUe5faNPS0JadM91ZTpSDEiQVjdUpU8JRUmqk4mmGiSMHqpFBB5PTpPMUGfgqxaJEMwV1z4DhJgwW0MbA7iBThDjd4zBaC1r1xfPyBGSpj4SkW2Er+ZIu/to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774538971; c=relaxed/simple;
	bh=+hqAjHn4sQYE8vv3DyBTLoupflxhYpxpmbLe8pF9ts8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C4m+V5vP2u2sgyIbY0iw2paUWoxgexEfqjtIMQJTITMenHxWfxvtnDGmK3QOf2dflWSApoPqnH2Q+bSjNVUpreM1M6yPdsHVwpkXNk2ThBtrUf4ZFdkKRUAe29kHS1gYVTQ10Mc5TCC4N//GY+UCKRIMj5Z73xIt0TEQig5jfaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grubix.eu; spf=pass smtp.mailfrom=grubix.eu; dkim=pass (2048-bit key) header.d=grubix.eu header.i=@grubix.eu header.b=U1PMBSky; arc=none smtp.client-ip=217.11.48.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grubix.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grubix.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=grubix.eu header.i=@grubix.eu header.b="U1PMBSky"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grubix.eu;
	s=manitu-webhosting; t=1774538576;
	bh=CeAZl63add4rytWBwpVpybH9M17Ixr4i52+3kQjRxY8=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=U1PMBSkyuhg4pKxuIGOCK5BbDD/Ay3bnKVXiNLvKykhXC19vMPoDUeZXh0+NGVCEF
	 utbceuSXa+ZVenLtZKr8Zolnuwpntp1LqkMiGJa0XkMcDjGxkFnC4llMyk3pxf+uDB
	 jXnJMzRHn6FV5mFvcIXFLbdpidWvdv6SnZy6Nc1seQdcKrdntI5j9tghwC4PSxrSkp
	 mMZmvrmWDiqDqixjharDPjm8CDnJmoFkcu31VCVUD7/1WYPxCdNaY/JanUhUm/9DPH
	 JwUX/1jm5L/2e6AP+/GQD+06e/yNDXSLXi9uBAe4DZykC6lzpQWBVzZUOD0iuTX1M4
	 rWqQLr0pneJZw==
From: Michael J Gruber <git@grubix.eu>
To: git@vger.kernel.org
Subject: [PATCH 2/6] do not discard const: make git-compat-util ISOC23-like
Date: Thu, 26 Mar 2026 16:22:48 +0100
Message-ID: <cfea3c6f006f926319da79bb7d97d57fb3b580e9.1774537954.git.git@grubix.eu>
In-Reply-To: <cover.1774537954.git.git@grubix.eu>
References: <cover.1774537954.git.git@grubix.eu>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

find_last_dir() should and can return a const pointer. This change fixes
the warnings with ISOC23 for git-compat-util and - via explicit casts -
makes it clear where we mutate the returned memory.
---
 git-compat-util.h | 2 +-
 scalar.c          | 2 +-
 submodule.c       | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 4b4ea2498f..3c3dbe298c 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -335,7 +335,7 @@ static inline int is_path_owned_by_current_uid(const char *path,
 #endif
 
 #ifndef find_last_dir_sep
-static inline char *git_find_last_dir_sep(const char *path)
+static inline const char *git_find_last_dir_sep(const char *path)
 {
 	return strrchr(path, '/');
 }
diff --git a/scalar.c b/scalar.c
index 4efb6ac36d..44f432d7f0 100644
--- a/scalar.c
+++ b/scalar.c
@@ -479,7 +479,7 @@ static int cmd_clone(int argc, const char **argv)
 		/* Strip suffix `.git`, if any */
 		strbuf_strip_suffix(&buf, ".git");
 
-		enlistment = find_last_dir_sep(buf.buf);
+		enlistment = (char *) find_last_dir_sep(buf.buf);
 		if (!enlistment) {
 			die(_("cannot deduce worktree name from '%s'"), url);
 		}
diff --git a/submodule.c b/submodule.c
index b1a0363f9d..57933386bc 100644
--- a/submodule.c
+++ b/submodule.c
@@ -2268,7 +2268,7 @@ static int check_casefolding_conflict(const char *git_dir,
 	DIR *dir = NULL;
 	int ret = 0;
 
-	if ((p = find_last_dir_sep(modules_dir)))
+	if ((p = (char *) find_last_dir_sep(modules_dir)))
 		*p = '\0';
 
 	/* No conflict is possible if modules_dir doesn't exist (first clone) */
-- 
2.53.0.1195.g771ffcb452

