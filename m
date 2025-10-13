Received: from mail.lohmann.sh (mail.lohmann.sh [23.88.42.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AD02FE566
	for <git@vger.kernel.org>; Mon, 13 Oct 2025 09:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.42.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760348563; cv=none; b=bhe4TzDJwUcT6lmIIdBc+yYWG9RNGqz7GxQCjFth3H3Yb4KCFZkumOJrPUxzbJ34DHS/8xMBeScQUPjnl0pBI8zCvE/ZvcE5Ws59NV1IL8zA7SdI8qpCdzs1DgPZcAZ5zPpVKI5FPESNcqqvwdrzNLqcLIjgz5GBFYiI4Xl/cwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760348563; c=relaxed/simple;
	bh=YZbrysTon97Dkw9QcPrKY/nyCyO4arqd/KJkik3TXSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gtYnRCm1oDouOpnKHPCYwbJxDCdFEszB90CRCOktnoBsy8EP2MYe0FYCNHu9GUiODl2e6t+Sv2bzx/WXep15iSnQkPFTW8KiPc3/PvETInfkbXlL2HdOb0fquaPBDBl57LGdzYNTt/WchiOv7sGAZjQMIIv09Gp1BoR7+jLNGpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lohmann.sh; spf=pass smtp.mailfrom=lohmann.sh; dkim=pass (2048-bit key) header.d=lohmann.sh header.i=@lohmann.sh header.b=UyXgnnwu; arc=none smtp.client-ip=23.88.42.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lohmann.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lohmann.sh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lohmann.sh header.i=@lohmann.sh header.b="UyXgnnwu"
From: Michael Lohmann <git@lohmann.sh>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lohmann.sh; s=mail3;
	t=1760348557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=baGJzsdfLNytpeGM++8l1tU1jVpY1/Rr30pdom/CZ1Y=;
	b=UyXgnnwujGEAgnYNLQ6fF0xWsygM86rOZjOlCcuFHOobFll2gXclG0E1w+nqWDcB78Ajxy
	4IrTZHIGGICHXaAPbdczAu6HS6zxsRtAfAzXS5i3R01KQHbPJeK6bHs/QGf9IetRnbfheI
	rFCn21nZHTfCiBDEluzNGgV+ABHdUZ4iBLU6ThVpK9RTP3lxBz/dSdFdqI4rjJhNh36wqQ
	zQYHTjGQouzPKbdrbZ29mP0tec3iMesym7gTzhtNmXbFc5J+hbRAgKxXBoP3INfAFiw+km
	RxuXeJMU2uSFvijUE4LlHI2cNPTGg9LDkf6K1dGd3/gKKx5zNK4xJf+g0Prbjw==
To: git@vger.kernel.org
Cc: Michael Lohmann <git@lohmann.sh>
Subject: [PATCH 3/5] setup: refactor `ensure_safe_repository()` testing priorities
Date: Mon, 13 Oct 2025 11:41:44 +0200
Message-ID: <20251013094152.23597-4-git@lohmann.sh>
In-Reply-To: <20251013094152.23597-1-git@lohmann.sh>
References: <20251013094152.23597-1-git@lohmann.sh>
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

