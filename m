Received: from mail.lohmann.sh (mail.lohmann.sh [23.88.42.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094412FA0EE
	for <git@vger.kernel.org>; Mon, 13 Oct 2025 21:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.42.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760391995; cv=none; b=hlBLkVTBBal2w0gM8W/Lpm0vt2KsD8SysWaOxs1OBq9en7lRhIAiqltLP9ErrgXZheUKd61Vwvqw0rhTtaNrRjf4cFJcaIa1zv86lOCNPRJrTZ7GUcRIWSOHboiZwdvEorRS6oo4cOJXVFF6M+3KcRQF7UB0UT5/egZ32XVLuCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760391995; c=relaxed/simple;
	bh=kU1AcJPIVzAqQVL/SmODC89/486IifxY+Yu5VArSxhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c4mG68Dzf8KbVgH8YKbjELQdN9FtCFSUQOiy3CMwisP7LP9YEwtH30V7nwSR/h4VYNGqIgl4c154D1opIUQYAsCqHdezJuytsq5Ya/zam5M7k8D7IGCyE8j4jTrzhRFZ+24vIsfkDkZoBHiC1tyCxrVes/4jDAL4lcO3Tv1QrK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lohmann.sh; spf=pass smtp.mailfrom=lohmann.sh; dkim=pass (2048-bit key) header.d=lohmann.sh header.i=@lohmann.sh header.b=tQpHjAZ2; arc=none smtp.client-ip=23.88.42.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lohmann.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lohmann.sh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lohmann.sh header.i=@lohmann.sh header.b="tQpHjAZ2"
From: Michael Lohmann <git@lohmann.sh>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lohmann.sh; s=mail3;
	t=1760391989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MAY9wM/YYO8+ZcMkTkNa19KG/W/qEi4cyL5HbbSXyf8=;
	b=tQpHjAZ2VVgcS8puyP/siBpNAsyppT1/7QftzZZaBLPyuwhsSYyKVmpKpAINYLC/0zFDUA
	tGioQYzWjNzs5HGGIpmBTyCY1TWhozKo/F8YwPfi/aEnPOxclaNtQIkNPugMcFBmUYGKRV
	uJGsMtFUnQnch0VGRC+DfV55dJNScMyKBMGY18f82fiuoGwre4JP9cQKih6Cyp4aWb/j/1
	JKmAkPxKBcMwhNtH+p6yxHSAf5VED0zSfFwIFqar5mwgC4ykSRgm0Frt4auqV1Tplg0cOw
	WZ7HwmgaaJIvtmxo1neGwOaOtNOUtusaR280sps/Fce1AGRLexUGuH46N2sZbg==
To: ben.knoble@gmail.com
Cc: git@lohmann.sh,
	git@vger.kernel.org
Subject: [PATCH v2 2/5] setup: rename `die_upon_assumed_unsafe_repo()` to align with check
Date: Mon, 13 Oct 2025 23:46:05 +0200
Message-ID: <20251013214608.33581-3-git@lohmann.sh>
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

This function dies if the repo in question is deemed to be unsafe and
the ownership is only part of the verification. In addition it already
checks for "safe.directory" config, making the name
`ensure_valid_ownership()` not expressive.
When additional options to check if a repository is considered to be
safe are added, this name is more indicative of the content.

Signed-off-by: Michael Lohmann <git@lohmann.sh>
---
 builtin/clone.c | 2 +-
 path.c          | 4 ++--
 setup.c         | 2 +-
 setup.h         | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index c990f398ef..6faf67dc68 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -263,7 +263,7 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
 	 * operation as the hardlinked files can be rewritten at will by the
 	 * potentially-untrusted user. We thus refuse to do so by default.
 	 */
-	die_upon_dubious_ownership(NULL, NULL, src_repo);
+	die_upon_assumed_unsafe_repo(NULL, NULL, src_repo);
 
 	mkdir_if_missing(dest->buf, 0777);
 
diff --git a/path.c b/path.c
index 7f56eaf993..254ba6c02f 100644
--- a/path.c
+++ b/path.c
@@ -810,7 +810,7 @@ const char *enter_repo(const char *path, unsigned flags)
 			return NULL;
 		gitfile = read_gitfile(used_path.buf);
 		if (!(flags & ENTER_REPO_ANY_OWNER_OK))
-			die_upon_dubious_ownership(gitfile, NULL, used_path.buf);
+			die_upon_assumed_unsafe_repo(gitfile, NULL, used_path.buf);
 		if (gitfile) {
 			strbuf_reset(&used_path);
 			strbuf_addstr(&used_path, gitfile);
@@ -822,7 +822,7 @@ const char *enter_repo(const char *path, unsigned flags)
 	else {
 		const char *gitfile = read_gitfile(path);
 		if (!(flags & ENTER_REPO_ANY_OWNER_OK))
-			die_upon_dubious_ownership(gitfile, NULL, path);
+			die_upon_assumed_unsafe_repo(gitfile, NULL, path);
 		if (gitfile)
 			path = gitfile;
 		if (chdir(path))
diff --git a/setup.c b/setup.c
index 2c41874774..69f6d1b36c 100644
--- a/setup.c
+++ b/setup.c
@@ -1333,7 +1333,7 @@ static int ensure_safe_repository(const char *gitfile,
 	return data.is_safe;
 }
 
-void die_upon_dubious_ownership(const char *gitfile, const char *worktree,
+void die_upon_assumed_unsafe_repo(const char *gitfile, const char *worktree,
 				const char *gitdir)
 {
 	struct strbuf report = STRBUF_INIT, quoted = STRBUF_INIT;
diff --git a/setup.h b/setup.h
index 8522fa8575..25bd5f1e70 100644
--- a/setup.h
+++ b/setup.h
@@ -51,7 +51,7 @@ const char *resolve_gitdir_gently(const char *suspect, int *return_error_code);
  * config settings; for non-bare repositories, their worktree needs to be
  * added, for bare ones their git directory.
  */
-void die_upon_dubious_ownership(const char *gitfile, const char *worktree,
+void die_upon_assumed_unsafe_repo(const char *gitfile, const char *worktree,
 				const char *gitdir);
 
 void setup_work_tree(void);
-- 
2.50.1 (Apple Git-155)

