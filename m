Received: from mail.lohmann.sh (mail.lohmann.sh [23.88.42.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2AC2192FA
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 05:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.42.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760592836; cv=none; b=SZN2m5uA7YF19/O4yypBZKQ5bpDNpc1leBzwcezIOed+Y1BNnpeGzF6opkyf3vYlM3hMY5PQPk4mwXemBegXb6QKF/RECXJAZ+B8IBfnXY5n3GdSfqSnmv2MQnYRoEHWLhSVwnwIQfZJSrPwlz/9ym9TqHRtHpn47cIkPlaH/1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760592836; c=relaxed/simple;
	bh=rw2vD1nJGTD0KHUwu9HPBfh+NMTyrANCqcBTvgcmHXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dRdOFCHGjTBKG+qH4MM6OBaAhrG7B6L3p3YK7RMEwEI2uDSsmetbE8MbslZb1BhwqQu03JU816yzenTYKeKGuee3RAvM1k9mrM6/fxcwoe3qVRSiMimKY+GHEb/9ETaoZi3F+VocQLdBZrqnB47/SmoB9L+O8E8fvjmWbi9ft/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lohmann.sh; spf=pass smtp.mailfrom=lohmann.sh; dkim=pass (2048-bit key) header.d=lohmann.sh header.i=@lohmann.sh header.b=mv9UUk0z; arc=none smtp.client-ip=23.88.42.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lohmann.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lohmann.sh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lohmann.sh header.i=@lohmann.sh header.b="mv9UUk0z"
From: Michael Lohmann <git@lohmann.sh>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lohmann.sh; s=mail3;
	t=1760592825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NOuSKZrt9fsatvyp9v4xP/OWNeHSUsoptcb+IMlxRpI=;
	b=mv9UUk0zbL/mfJqRJJvc8hFvERTg12MApRXol9pF8AHZPSpEgURB0HqOkphizFm5TDAs8m
	apLMQ7LFdcB9m1IHZpECQm+clMGDmXdTHGpLP2snmxJNSiwE+yX8XvC9T+XVYCS/oin658
	bh9xN695yz4BsVwl9ggTfnrXZuLmmiM3D25WbhkZAA9k9EEz2j9zifM7h40VcQhk4CsI8s
	k7F+AT1VlBQLuYFsrc5q/QUBkqG842bKNGynMC2XbLH8VaLDMdLkwNxDOqqaU5JYBUhlNf
	R5I0hrC0mBNJsCkHLHBT4yRDEIlclvvjA12W58lVR+2f10Ktq/aC4OYP2GkRSw==
To: git@lohmann.sh
Cc: git@vger.kernel.org
Subject: [PATCH v3 3/5] setup: refactor `ensure_safe_repository()` testing priorities
Date: Thu, 16 Oct 2025 07:33:20 +0200
Message-ID: <20251016053322.44495-4-git@lohmann.sh>
In-Reply-To: <20251016053322.44495-1-git@lohmann.sh>
References: <20251013094152.23597-1-git@lohmann.sh>
 <20251016053322.44495-1-git@lohmann.sh>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the current code, this change does not make any difference because
there is no explicit rule that lets you reject a directory that the
ownership-based rule may accept.  In a later step in this series,
however, we will introduce a mechanism to allow such an explicit rule,
at which point the order of checks, i.e. seeing the explicit rule reject
a directory and failing the operation before consulting the
ownership-based rule, will start to matter.  As a preliminary change,
reorder the existing checks.

Signed-off-by: Michael Lohmann <git@lohmann.sh>
---
 setup.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/setup.c b/setup.c
index c6e1204c05..5ec68be379 100644
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
 
 void die_upon_unsafe_repo(const char *gitfile, const char *worktree,
-- 
2.51.1.476.g147428281d

