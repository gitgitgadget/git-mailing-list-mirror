Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589AD342C93
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 02:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783564932; cv=none; b=LHwqYuOhcKeE2ci5aD59G5EsT7A0g9HLIcaXz4wW5q8X7Ityga8jjUd7n+QvjrRonApERJ9ioKsZLpD4wTvMKMoABHxpIwCw7tsMVjZY6A78qhcdGU4fvfB7zk9Ig9nU0rJwsv8Y/H9GTlWSBKQbnGAJaK7XHgP3ko99Ui2r9tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783564932; c=relaxed/simple;
	bh=5llp6VIs230ktI1BoW9NeFfj3zD1rocjpyMLJpq1N/Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rPGFNKI4xhPd3b9Pc67i7Fe+qkZTHpj6fd2BpZMyHwRcABu032YJ2uf3aFYC7cCuRjztkDDZ1pDReNSFHcCxcmuwVxtIYtvamN5wvXXua7lfXprBOfo19av0NKgUTKyo0e9VJQtlYnNCmKaMRfoH9jX7WFILx92yL0nMeNPlrFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iOnFF/Pj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iOnFF/Pj"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1CD9DC2BCB9;
	Thu,  9 Jul 2026 02:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783564932;
	bh=5llp6VIs230ktI1BoW9NeFfj3zD1rocjpyMLJpq1N/Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=iOnFF/Pj+mZnNut7HCcqtJMMe2mu5gD0WZNe+4QtdvCsTcVuzoAnxVefYnIsZIfPt
	 W6pLt/MtFqnx/35k5NFhwRFvBHZl+22y0uhIspHPtZc0og2aKhiUMOz6x0NhU9Aer+
	 3nSD9kvuGIFjXPa+fi/hlxDG1EMJAi4yJAqxVxn3OCQb1oOjadaXNboEnTDCx1iY1/
	 5nEB//yQlkxkHVy0cvRZF4FWSczIr8ufE88Xd4EymccASTi1zBsFi79x0kXD921K//
	 Kr/paokpyeGid5yc8TEUWUHZf4RFTTrtDlMHrTp2bWPDsSgavRD/KizDy9XcNMwSyi
	 PfmV2OPbMZzTw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B81C44503;
	Thu,  9 Jul 2026 02:42:12 +0000 (UTC)
From: Chen Linxuan via B4 Relay <devnull+me.black-desk.cn@kernel.org>
Date: Thu, 09 Jul 2026 10:41:42 +0800
Subject: [PATCH v7 2/3] repository: keep a symlink-preserving copy of the
 worktree path
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-includeif-worktree-v7-2-e87e705e8df6@black-desk.cn>
References: <20260709-includeif-worktree-v7-0-e87e705e8df6@black-desk.cn>
In-Reply-To: <20260709-includeif-worktree-v7-0-e87e705e8df6@black-desk.cn>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
 Chen Linxuan <me@black-desk.cn>, Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=8240; i=me@black-desk.cn;
 h=from:subject:message-id;
 bh=qqXSuQzEDoaR4X8BjyqKWi6IDgpDCw2oTif2AlZlyNM=;
 b=owEBbQKS/ZANAwAKAXYe5hQ5ma6LAcsmYgBqTwqAIawcSReqwnqKoJpbGV38fiA+xPy9oTnix
 rFuDYLKdRWJAjMEAAEKAB0WIQTO1VElAk6xdvy0ZVp2HuYUOZmuiwUCak8KgAAKCRB2HuYUOZmu
 i1V0D/0YGAbq2exHxc8Um15GqKeD/tOn/YG6hH6SU0vqMKms8lhHOCHuXVL5SGfKaC0S/ozksej
 Lzh3RyGeg4aA2IzUrIPRItxL4G98W6b9aS4fHKqvIsPm8wUYup11ZB85xTsiMqH5YUHLCvQsYXA
 7Lwf7st3C1QN7UYLxRKQ6NwTs0J5cUEjetOCMpDpxttUA4ag9vrygJbr2IrKISkEvOI3eqWt2XS
 Ct2MWxmo1fvkWZNI1nfpd/KqLnM/nhWyNyWVoQ3no39KPwf//+SboLxp2C795VuKih+QiIxDcjO
 zki3VT6XB6qQq/oKH39hjU5KxaavCAACLZgL1Qb4Xj1564dqEJWL7mwbVvtLetpau2Y8/yXfmDq
 wtcAYEbkmw5vpDG+TcVCdJsRg0tosXfeZ4RHZ0pdYu0udbonVO8q+e+YsSMt3QHklt/JhPODr2D
 /0kEHDw1M+/3uYxUFveOK8NqF13U/z6PW/X4ShacnDN43YTDWbSLsSgg8NRHIE9rruHpA4DJYnU
 qB2wTfPhzI1bPHydnG/MJVA337rBdIkjPcL+5qeKUh/6QidN+3ZSybAP3tPbWD72uumy6K/+l/K
 OEcHTO0ZwI67m+T/1KXs6Ub4XTl2Jz0yJyJsSPhu3AAG9a2p0JwV775VExys9OZvuqHGfGVz0py
 RaRZ/kV1KoQ3m1w==
X-Developer-Key: i=me@black-desk.cn; a=openpgp;
 fpr=D818ACDD385CAE92D4BAC01A6269794D24791D21
X-Endpoint-Received: by B4 Relay for me@black-desk.cn/default with
 auth_id=573
X-Original-From: Chen Linxuan <me@black-desk.cn>
Reply-To: me@black-desk.cn

From: Chen Linxuan <me@black-desk.cn>

repo_set_worktree() stores only the realpath-resolved working directory in
repo->worktree, which discards any symlinks the user followed to get
there.  A follow-up commit needs to match that path the way "gitdir:"
does, i.e. against both the real and the symlinked spelling, which
requires the original spelling to still be available.

Add repo->worktree_original, plus a repo_get_work_tree_original()
accessor, to hold that symlink-preserving spelling.  repo_set_worktree()
derives it from the given path; for the discovered-repository case, where
the setup code has already chdir()d to the worktree root by the time
set_git_work_tree(repo, ".") runs, logical_path_from_cwd() recovers it
from $PWD instead.

repo->worktree is unchanged; repo_get_work_tree_original() has no callers
yet and is wired up in the next commit.

Signed-off-by: Chen Linxuan <me@black-desk.cn>
---
 repository.c | 26 ++++++++++++++++++
 repository.h | 10 +++++++
 setup.c      | 86 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 121 insertions(+), 1 deletion(-)

diff --git a/repository.c b/repository.c
index 73d80bcffdf5..a29d55a6fcd3 100644
--- a/repository.c
+++ b/repository.c
@@ -149,6 +149,11 @@ const char *repo_get_work_tree(struct repository *repo)
 	return repo->worktree;
 }
 
+const char *repo_get_work_tree_original(struct repository *repo)
+{
+	return repo->worktree_original;
+}
+
 static void repo_set_commondir(struct repository *repo,
 			       const char *commondir)
 {
@@ -252,8 +257,28 @@ static int repo_init_gitdir(struct repository *repo, const char *gitdir)
 
 void repo_set_worktree(struct repository *repo, const char *path)
 {
+	struct strbuf worktree = STRBUF_INIT;
+
+	/*
+	 * Resolve the canonical path first. This preserves the historical
+	 * behaviour for unusable worktree paths (e.g. a bogus GIT_WORK_TREE):
+	 * strbuf_realpath() dies on error before we touch the copy below.
+	 */
 	repo->worktree = real_pathdup(path, 1);
 
+	/*
+	 * Keep a symlink-preserving copy: absolute and normalized, but not
+	 * realpath-resolved. Normalization can only fail for inputs that
+	 * realpath tolerates (the rest already died above); fall back to the
+	 * physical path so callers never see a NULL.
+	 */
+	strbuf_add_absolute_path(&worktree, path);
+	if (strbuf_normalize_path(&worktree) < 0)
+		repo->worktree_original = xstrdup(repo->worktree);
+	else
+		repo->worktree_original = strbuf_detach(&worktree, NULL);
+	strbuf_release(&worktree);
+
 	trace2_def_repo(repo);
 }
 
@@ -379,6 +404,7 @@ void repo_clear(struct repository *repo)
 	FREE_AND_NULL(repo->graft_file);
 	FREE_AND_NULL(repo->index_file);
 	FREE_AND_NULL(repo->worktree);
+	FREE_AND_NULL(repo->worktree_original);
 	FREE_AND_NULL(repo->submodule_prefix);
 	FREE_AND_NULL(repo->ref_storage_payload);
 
diff --git a/repository.h b/repository.h
index 7d649e32e7fa..f08fbfde4a07 100644
--- a/repository.h
+++ b/repository.h
@@ -114,6 +114,15 @@ struct repository {
 	 * A NULL value indicates that there is no working directory.
 	 */
 	char *worktree;
+	/*
+	 * Symlink-preserving spelling of the working directory: absolute and
+	 * normalized, but NOT realpath-resolved (keeps any symlinks the user
+	 * followed to get here). Used by includeIf "worktree:" so it can match
+	 * both the real and the symlinked spelling, the way "gitdir:" does.
+	 * Falls back to the same value as "worktree" when no logical path is
+	 * available.
+	 */
+	char *worktree_original;
 	bool worktree_initialized;
 	bool worktree_config_is_bogus;
 
@@ -221,6 +230,7 @@ const char *repo_get_object_directory(struct repository *repo);
 const char *repo_get_index_file(struct repository *repo);
 const char *repo_get_graft_file(struct repository *repo);
 const char *repo_get_work_tree(struct repository *repo);
+const char *repo_get_work_tree_original(struct repository *repo);
 
 /*
  * Define a custom repository layout. Any field can be NULL, which
diff --git a/setup.c b/setup.c
index 0de56a074f7c..fbbeb95f99db 100644
--- a/setup.c
+++ b/setup.c
@@ -1213,12 +1213,94 @@ static const char *setup_explicit_git_dir(struct repository *repo,
 	return NULL;
 }
 
+/*
+ * Do "a" and "b" refer to the same filesystem entry? Both must report a
+ * nonzero (dev,ino): some filesystems return (0,0) for unrelated paths,
+ * which would otherwise look identical.
+ */
+static int same_entry(const char *a, const char *b)
+{
+	struct stat sa, sb;
+
+	if (stat(a, &sa) || stat(b, &sb))
+		return 0;
+	return (sa.st_dev || sa.st_ino) &&
+	       sa.st_dev == sb.st_dev && sa.st_ino == sb.st_ino;
+}
+
+/*
+ * Recover the symlink-preserving spelling of the worktree root.
+ *
+ * strbuf_add_absolute_path() already consults $PWD to keep symlinks when
+ * resolving a relative path, so set_git_work_tree()'s other callers get a
+ * symlink-preserving worktree path for free.  This function exists for the
+ * discovered-repository case: setup_git_directory_gently() chdir()s to the
+ * worktree root *before* set_git_work_tree(repo, ".") runs, so by the time
+ * "." is resolved $PWD still names the caller's original directory and no
+ * longer agrees with the physical cwd, and strbuf_add_absolute_path()
+ * falls back to the realpath.  We close that gap by deriving the logical
+ * root here, from $PWD, while we still have the original physical cwd and
+ * the root offset in hand.
+ *
+ * "cwd" is the physical current directory (getcwd), and "root_len" is the
+ * length of the worktree root within it; cwd->buf[root_len..] is therefore
+ * the part of the path below the root (empty when git ran at the root).
+ *
+ * $PWD, maintained by the shell, may spell that same directory through
+ * symlinks.  If we can confirm $PWD really names cwd's directory (same
+ * device/inode) and that the below-root suffix matches, we swap the
+ * physical root prefix for $PWD's prefix and keep the user's symlinks.
+ * Only symlinks in the root prefix itself are preserved: the below-root
+ * suffix is matched byte-for-byte, so a symlink below the root is not.
+ *
+ * Returns the allocated logical path, or NULL when $PWD is missing, already
+ * physical, or untrustworthy.
+ */
+static char *logical_path_from_cwd(struct strbuf *cwd, int root_len)
+{
+	const char *pwd = getenv("PWD");
+	size_t suffix_len, pwd_len;
+	struct strbuf path = STRBUF_INIT;
+
+	if (!pwd || !is_absolute_path(pwd) || !strcmp(pwd, cwd->buf))
+		return NULL;
+	/*
+	 * $PWD is a plain environment variable: it can be set to anything,
+	 * or left stale after a chdir.  Only borrow its symlink-preserving
+	 * spelling once we prove it still points at the same directory as
+	 * the physical cwd; otherwise give up and return NULL.
+	 */
+	if (!same_entry(cwd->buf, pwd))
+		return NULL;
+
+	/*
+	 * Drop the below-root suffix from $PWD.  It must match the physical
+	 * suffix exactly; the only spelling difference we accept is in the
+	 * root prefix -- i.e. the symlinks we want to preserve.
+	 */
+	suffix_len = cwd->len - root_len;
+	pwd_len = strlen(pwd);
+	if (suffix_len) {
+		const char *suffix = cwd->buf + root_len;
+
+		if (suffix_len > pwd_len ||
+		    fspathcmp(pwd + pwd_len - suffix_len, suffix))
+			return NULL;
+		pwd_len -= suffix_len;
+	}
+
+	strbuf_add(&path, pwd, pwd_len);
+	return strbuf_detach(&path, NULL);
+}
+
 static const char *setup_discovered_git_dir(struct repository *repo,
 					    const char *gitdir,
 					    struct strbuf *cwd, int offset,
 					    struct repository_format *repo_fmt,
 					    int *nongit_ok)
 {
+	char *worktree = NULL;
+
 	if (check_repository_format_gently(gitdir, repo_fmt, nongit_ok))
 		return NULL;
 
@@ -1245,7 +1327,9 @@ static const char *setup_discovered_git_dir(struct repository *repo,
 	}
 
 	/* #0, #1, #5, #8, #9, #12, #13 */
-	set_git_work_tree(repo, ".");
+	worktree = logical_path_from_cwd(cwd, offset);
+	set_git_work_tree(repo, worktree ? worktree : ".");
+	free(worktree);
 	if (strcmp(gitdir, DEFAULT_GIT_DIR_ENVIRONMENT))
 		set_git_dir(repo, gitdir, 0);
 	if (offset >= cwd->len)

-- 
2.53.0


