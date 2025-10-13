Received: from mail.lohmann.sh (mail.lohmann.sh [23.88.42.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22BB2FA0C6
	for <git@vger.kernel.org>; Mon, 13 Oct 2025 21:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.42.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760391995; cv=none; b=eOc36QWADBIi8F3T5f/yzGbmi5u9p4CIOZBbHOiFEifQ/P6PdrkmiEoco6kL5Xd5A5LGhOHS34wbvh1QnPE4TPjOmaLa0qSUhqG5n4s7D8ZPCVs2Kt5DDCTuzjlKizaUIAQJzARmjD5muayQpgCXo9FOaGo28K4NQ1rz4HMENXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760391995; c=relaxed/simple;
	bh=YZbrysTon97Dkw9QcPrKY/nyCyO4arqd/KJkik3TXSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kFd36nZD6WQfkQUqVrUpvK3vXSn6FjLDkvmRRePKaU8Cax6ZkSVGdoUV3ms4xbozqAAy3PLOEsTLsvJDW6uAce3QKu4x3BXeCM7OnQNmqVbpw+ODbySam5DyXqjqe/02DjUM2KqtdT+28aQVhxNacSl/LBb7ej5rSe+Ff8/SIz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lohmann.sh; spf=pass smtp.mailfrom=lohmann.sh; dkim=pass (2048-bit key) header.d=lohmann.sh header.i=@lohmann.sh header.b=ei5VNDWn; arc=none smtp.client-ip=23.88.42.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lohmann.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lohmann.sh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lohmann.sh header.i=@lohmann.sh header.b="ei5VNDWn"
From: Michael Lohmann <git@lohmann.sh>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lohmann.sh; s=mail3;
	t=1760391989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=baGJzsdfLNytpeGM++8l1tU1jVpY1/Rr30pdom/CZ1Y=;
	b=ei5VNDWngxmMdWHysj7WR0RIoRpucjbcZuRN6Ko3VYuqiE0RBMacsi85ygzEKpRdKd2LEe
	VCYdNuT6ERiXCwn8xzAX1VZfOVhNIbfggwU9jKnvOcBEt75GEsytW6uZQHrmmv5IDThhcP
	DFodBZZC+122MD3+3XYaX1+cq+nsiLiwvci5kx6MGgKrfWILEMfa5ArOTM4DdYMfWk0AXV
	YAkbt2NSxUMd7abDVfLKl4nB+abbNTO5O0v8EhpYlyqAC5NXjB5/v/8+m2FsdEJUgEejpk
	V6EVemdm4tNeBiunH2avB+LayLvvIzmB65x8LV3w1YbJ9Tm2dZc97rEj+lzIig==
To: ben.knoble@gmail.com
Cc: git@lohmann.sh,
	git@vger.kernel.org
Subject: [PATCH v2 3/5] setup: refactor `ensure_safe_repository()` testing priorities
Date: Mon, 13 Oct 2025 23:46:06 +0200
Message-ID: <20251013214608.33581-4-git@lohmann.sh>
In-Reply-To: <20251013214608.33581-1-git@lohmann.sh>
References: <CALnO6CBLr2iL0r+ywM4Vjw0=J2DNFv9Nhhq_PHuxt4eK=Z95ww@mail.gmail.com>
 <20251013214608.33581-1-git@lohmann.sh>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The implicit ownership test takes precedence over the explicit
allow-listing of a path by "safe.directory" config. Sort by "priority"
(explicitness). This also allows to more easily integrate additional
checks.

Make the explicit safe.directory check take precedence over owner check.

Signed-off-by: Michael Lohmann <git@lohmann.sh>
---
 setup.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/setup.c b/setup.c
index 69f6d1b36c..41a12a85ab 100644
--- a/setup.c
+++ b/setup.c
@@ -1307,12 +1307,6 @@ static int ensure_safe_repository(const char *gitfile,
 {
 	struct safe_directory_data data = { 0 };
 
-	if (!git_env_bool("GIT_TEST_ASSUME_DIFFERENT_OWNER", 0) &&
-	    (!gitfile || is_path_owned_by_current_user(gitfile, report)) &&
-	    (!worktree || is_path_owned_by_current_user(worktree, report)) &&
-	    (!gitdir || is_path_owned_by_current_user(gitdir, report)))
-		return 1;
-
 	/*
 	 * normalize the data.path for comparison with normalized paths
 	 * that come from the configuration file.  The path is unsafe
@@ -1330,7 +1324,16 @@ static int ensure_safe_repository(const char *gitfile,
 	git_protected_config(safe_directory_cb, &data);
 
 	free(data.path);
-	return data.is_safe;
+	if (data.is_safe)
+		return 1;
+
+	if (!git_env_bool("GIT_TEST_ASSUME_DIFFERENT_OWNER", 0) &&
+	    (!gitfile || is_path_owned_by_current_user(gitfile, report)) &&
+	    (!worktree || is_path_owned_by_current_user(worktree, report)) &&
+	    (!gitdir || is_path_owned_by_current_user(gitdir, report)))
+		return 1;
+
+	return 0;
 }
 
 void die_upon_assumed_unsafe_repo(const char *gitfile, const char *worktree,
-- 
2.50.1 (Apple Git-155)

