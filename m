Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A21339AC
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 03:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728357164; cv=none; b=in2TltI7MTgnhi/LV+xdaKTG8nkFwLGfiyu3WG3q5uGVn10f/ofcJirsk7hgYairivBRZuZmtA0rrEmB9lmp32ynLwfiqKhB3R9YgPV+9qOY2+7gfPoAQBY/oFYP98w/1z6OVz7CNyX+iLUetPkAFbhUFbbl3SBBT10p0hEKi+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728357164; c=relaxed/simple;
	bh=9T51WAywh1Jq1jLkJBvYcRgNm+UBSsglEp6rmK+hCaM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mRYgkiC53KwzmlS+utbanNvJjAZBH9/LpA6SKlF2Xt9rd7vYb/Im8rt0PSqEhuJFi+MvKGu25rtFgf8tPerCUyafgNOdIs+GHQ1ymvShk+nupHbJwM2IT+WowgbbsoxKaHUDV1PB6/pa1HMLE+KokWZ3oqgjZHVWiDKPLnKqm5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sjnoDz7J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sjnoDz7J"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DCB30C4CECF;
	Tue,  8 Oct 2024 03:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728357163;
	bh=9T51WAywh1Jq1jLkJBvYcRgNm+UBSsglEp6rmK+hCaM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=sjnoDz7J6m1eAnBdVqyCWMZtcToKjiG3Tp3KVDKcTqr3aD6WdK4+mFvC9LvsBMzZU
	 V5DcFurUtqEB5oti7v4biuS3lhYmR/EGOFKI8mr8pNKp64ETG4Vj87ouI1kylBMjWV
	 4z2dd9N/NlXnmkFWYMAAsQWnyD9BFpySl8bKc+TX6o3RJDWcd9nNI4DaHl8PsF5KZG
	 CQ64WxmoxctbCyGdWZo7TdqaipftggnTmJQ9DeZv41lqs2zxrEpso1X672PENaZom5
	 YvbFLqEmRtsgV6jCgx6MiZfGV1Wsi+gZicoQ01Tsd/B09rohQktLbrYNRfjAVX+qVb
	 R6WTkroyjP3WQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B91CED25D;
	Tue,  8 Oct 2024 03:12:43 +0000 (UTC)
From: Caleb White via B4 Relay <devnull+cdwhite3.pm.me@kernel.org>
Date: Mon, 07 Oct 2024 22:12:30 -0500
Subject: [PATCH v3 1/3] worktree: refactor infer_backlink() to use *strbuf
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241007-wt_relative_paths-v3-1-622cf18c45eb@pm.me>
References: <20241007-wt_relative_paths-v3-0-622cf18c45eb@pm.me>
In-Reply-To: <20241007-wt_relative_paths-v3-0-622cf18c45eb@pm.me>
To: git@vger.kernel.org
Cc: Caleb White <cdwhite3@pm.me>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4890; i=cdwhite3@pm.me;
 h=from:subject:message-id;
 bh=zrAfmW4oSQtKeqK6gArxGYDGxJj91cW2eT1VwhBlJEc=;
 b=owGbwMvMwCVmxF73kO8jewrjabUkhnSWxVpy3ituewhs3ePTv89LrfdPUmflFbOIh051O7kvb
 V0karGio5SFQYyLQVZMkeXN1u8F6qmPM7g/lM+GmcPKBDKEgYtTACZieIqRYYpj8puq8m6naRX7
 ZpZ07VpuKptvf/PwjsTf+XxZ/sk65gz/nayddZVtZPKzd6WdfKa1erGf6tytjyS2Hmjz8Un6ynW
 VCwA=
X-Developer-Key: i=cdwhite3@pm.me; a=openpgp;
 fpr=99981A649E1CA829A335E77493EDE5A0C788BC38
X-Endpoint-Received: by B4 Relay for cdwhite3@pm.me/default with
 auth_id=237
X-Original-From: Caleb White <cdwhite3@pm.me>
Reply-To: cdwhite3@pm.me

From: Caleb White <cdwhite3@pm.me>

This lays the groundwork for the next patch, which needs the backlink
returned from infer_backlink() as a `strbuf`. It seemed inefficient to
convert from `strbuf` to `char*` and back to `strbuf` again.

This refactors infer_backlink() to return an integer result and use a
pre-allocated `strbuf` for the inferred backlink path, replacing the
previous `char*` return type and improving efficiency.

Signed-off-by: Caleb White <cdwhite3@pm.me>
---
 worktree.c | 48 ++++++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/worktree.c b/worktree.c
index ec95ea2986107b3bc12d38b0825d7c6e87402bc6..0cba0d6e6e9ad02ace04a0301104a04a07cbef65 100644
--- a/worktree.c
+++ b/worktree.c
@@ -642,10 +642,9 @@ static int is_main_worktree_path(const char *path)
  * be able to infer the gitdir by manually reading /path/to/worktree/.git,
  * extracting the <id>, and checking if <repo>/worktrees/<id> exists.
  */
-static char *infer_backlink(const char *gitfile)
+static int infer_backlink(const char *gitfile, struct strbuf *inferred)
 {
 	struct strbuf actual = STRBUF_INIT;
-	struct strbuf inferred = STRBUF_INIT;
 	const char *id;
 
 	if (strbuf_read_file(&actual, gitfile, 0) < 0)
@@ -658,17 +657,18 @@ static char *infer_backlink(const char *gitfile)
 	id++; /* advance past '/' to point at <id> */
 	if (!*id)
 		goto error;
-	strbuf_git_common_path(&inferred, the_repository, "worktrees/%s", id);
-	if (!is_directory(inferred.buf))
+	strbuf_reset(inferred);
+	strbuf_git_common_path(inferred, the_repository, "worktrees/%s", id);
+	if (!is_directory(inferred->buf))
 		goto error;
 
 	strbuf_release(&actual);
-	return strbuf_detach(&inferred, NULL);
+	return 1;
 
 error:
 	strbuf_release(&actual);
-	strbuf_release(&inferred);
-	return NULL;
+	strbuf_reset(inferred); /* clear invalid path */
+	return 0;
 }
 
 /*
@@ -680,10 +680,11 @@ void repair_worktree_at_path(const char *path,
 {
 	struct strbuf dotgit = STRBUF_INIT;
 	struct strbuf realdotgit = STRBUF_INIT;
+	struct strbuf backlink = STRBUF_INIT;
+	struct strbuf inferred_backlink = STRBUF_INIT;
 	struct strbuf gitdir = STRBUF_INIT;
 	struct strbuf olddotgit = STRBUF_INIT;
-	char *backlink = NULL;
-	char *inferred_backlink = NULL;
+	char *dotgit_contents = NULL;
 	const char *repair = NULL;
 	int err;
 
@@ -699,23 +700,23 @@ void repair_worktree_at_path(const char *path,
 		goto done;
 	}
 
-	inferred_backlink = infer_backlink(realdotgit.buf);
-	backlink = xstrdup_or_null(read_gitfile_gently(realdotgit.buf, &err));
-	if (err == READ_GITFILE_ERR_NOT_A_FILE) {
+	infer_backlink(realdotgit.buf, &inferred_backlink);
+	dotgit_contents = xstrdup_or_null(read_gitfile_gently(realdotgit.buf, &err));
+	if (dotgit_contents) {
+		strbuf_addstr(&backlink, dotgit_contents);
+	} else if (err == READ_GITFILE_ERR_NOT_A_FILE) {
 		fn(1, realdotgit.buf, _("unable to locate repository; .git is not a file"), cb_data);
 		goto done;
 	} else if (err == READ_GITFILE_ERR_NOT_A_REPO) {
-		if (inferred_backlink) {
+		if (inferred_backlink.len) {
 			/*
 			 * Worktree's .git file does not point at a repository
 			 * but we found a .git/worktrees/<id> in this
 			 * repository with the same <id> as recorded in the
 			 * worktree's .git file so make the worktree point at
-			 * the discovered .git/worktrees/<id>. (Note: backlink
-			 * is already NULL, so no need to free it first.)
+			 * the discovered .git/worktrees/<id>.
 			 */
-			backlink = inferred_backlink;
-			inferred_backlink = NULL;
+			strbuf_swap(&backlink, &inferred_backlink);
 		} else {
 			fn(1, realdotgit.buf, _("unable to locate repository; .git file does not reference a repository"), cb_data);
 			goto done;
@@ -743,13 +744,11 @@ void repair_worktree_at_path(const char *path,
 	 * in the "copy" repository. In this case, point the "copy" worktree's
 	 * .git file at the "copy" repository.
 	 */
-	if (inferred_backlink && fspathcmp(backlink, inferred_backlink)) {
-		free(backlink);
-		backlink = inferred_backlink;
-		inferred_backlink = NULL;
+	if (inferred_backlink.len && fspathcmp(backlink.buf, inferred_backlink.buf)) {
+		strbuf_swap(&backlink, &inferred_backlink);
 	}
 
-	strbuf_addf(&gitdir, "%s/gitdir", backlink);
+	strbuf_addf(&gitdir, "%s/gitdir", backlink.buf);
 	if (strbuf_read_file(&olddotgit, gitdir.buf, 0) < 0)
 		repair = _("gitdir unreadable");
 	else {
@@ -763,9 +762,10 @@ void repair_worktree_at_path(const char *path,
 		write_file(gitdir.buf, "%s", realdotgit.buf);
 	}
 done:
-	free(backlink);
-	free(inferred_backlink);
+	free(dotgit_contents);
 	strbuf_release(&olddotgit);
+	strbuf_release(&backlink);
+	strbuf_release(&inferred_backlink);
 	strbuf_release(&gitdir);
 	strbuf_release(&realdotgit);
 	strbuf_release(&dotgit);

-- 
2.46.2


