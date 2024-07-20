Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B1912EBE1
	for <git@vger.kernel.org>; Sat, 20 Jul 2024 22:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721513366; cv=none; b=aTaI3RqWR5+f77pobBw/ASjngZFggBEqnq3ElU5MoIbF4IM1k4zFgYblYzDy2ra81WPScNuhiRfwZNn59jyZqsbZ3iL3969YFJehBf0KuyuNT7FZlDnqR9N0/bH2f6qozfXhVaB316DerIa00Zelc2es0lo6vPUEEZyJZSjFlGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721513366; c=relaxed/simple;
	bh=ZfNlbQ/aHfNyP4W7LaHcZV2R1tvK4+t0gIQoyHjgObk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PqonyqSZu1uROeiMk7t5G0XEHa+VdWPtbWTtScAh9cJFWOysJ6wkJAXw+Pi+wc6gCnJ4U03A+uTwuMDvS2EcTTYvhXNXh4L9URpt6FJNjzlaUq3+YaMxtvAYsDHAVf5bPfiTcRhphpLSWsQgCQK3cKc5N4jMC6p6mfv1C6M++VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=aDEXJxhl; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="aDEXJxhl"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C1ADA1E864;
	Sat, 20 Jul 2024 18:09:18 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=ZfNlbQ/aHfNyP4W7LaHcZV2R1
	tvK4+t0gIQoyHjgObk=; b=aDEXJxhl3fGi7+figiGjk1U0SoIfIRpXD70lYgZXY
	9QX4dhgjLLzw1FVh287P+HRVk9CCKZHRFe/mIjYoUADuzaJVEW1tiS+5pQENzr4W
	7jAkvMFHFIT81fqThiAvz3tk8aJXnaGhjKqcT41Jmenipwah7xHHsNHczcwAbte6
	ig=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B98B71E863;
	Sat, 20 Jul 2024 18:09:18 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 27AC01E862;
	Sat, 20 Jul 2024 18:09:18 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH 1/2] safe.directory: normalize the checked path
Date: Sat, 20 Jul 2024 15:09:12 -0700
Message-ID: <20240720220915.2933266-2-gitster@pobox.com>
X-Mailer: git-send-email 2.46.0-rc1-48-g0900f1888e
In-Reply-To: <20240720220915.2933266-1-gitster@pobox.com>
References: <20240720220915.2933266-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 B568A3CC-46E4-11EF-9661-BAC1940A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

The pathname of a repository comes from getcwd() and it could be a
path aliased via symbolic links, e.g., the real directory may be
/home/u/repository but a symbolic link /home/u/repo may point at it,
and the clone request may come as "git clone file:///home/u/repo/".

A request to check if /home/u/repo is safe would be rejected if the
safe.directory configuration allows /home/u/repository/ but not its
alias /home/u/repo/.  Normalize the path being checked before
comparing with safe.directory value(s).

Suggested-by: Phillip Wood <phillip.wood123@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 setup.c                   | 16 ++++++++++----
 t/t0033-safe-directory.sh | 45 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+), 4 deletions(-)

diff --git a/setup.c b/setup.c
index d458edcc02..45bbbe329f 100644
--- a/setup.c
+++ b/setup.c
@@ -1215,7 +1215,7 @@ static int canonicalize_ceiling_entry(struct string=
_list_item *item,
 }
=20
 struct safe_directory_data {
-	const char *path;
+	char *path;
 	int is_safe;
 };
=20
@@ -1263,9 +1263,7 @@ static int ensure_valid_ownership(const char *gitfi=
le,
 				  const char *worktree, const char *gitdir,
 				  struct strbuf *report)
 {
-	struct safe_directory_data data =3D {
-		.path =3D worktree ? worktree : gitdir
-	};
+	struct safe_directory_data data =3D { 0 };
=20
 	if (!git_env_bool("GIT_TEST_ASSUME_DIFFERENT_OWNER", 0) &&
 	    (!gitfile || is_path_owned_by_current_user(gitfile, report)) &&
@@ -1273,6 +1271,15 @@ static int ensure_valid_ownership(const char *gitf=
ile,
 	    (!gitdir || is_path_owned_by_current_user(gitdir, report)))
 		return 1;
=20
+	/*
+	 * normalize the data.path for comparison with normalized paths
+	 * that come from the configuration file.  The path is unsafe
+	 * if it cannot be normalized.
+	 */
+	data.path =3D real_pathdup(worktree ? worktree : gitdir, 0);
+	if (!data.path)
+		return 0;
+
 	/*
 	 * data.path is the "path" that identifies the repository and it is
 	 * constant regardless of what failed above. data.is_safe should be
@@ -1280,6 +1287,7 @@ static int ensure_valid_ownership(const char *gitfi=
le,
 	 */
 	git_protected_config(safe_directory_cb, &data);
=20
+	free(data.path);
 	return data.is_safe;
 }
=20
diff --git a/t/t0033-safe-directory.sh b/t/t0033-safe-directory.sh
index 5fe61f1291..3e487e7f4b 100755
--- a/t/t0033-safe-directory.sh
+++ b/t/t0033-safe-directory.sh
@@ -119,4 +119,49 @@ test_expect_success 'local clone of unowned repo acc=
epted in safe directory' '
 	test_path_is_dir target
 '
=20
+test_expect_success SYMLINKS 'checked paths are normalized' '
+	test_when_finished "rm -rf repository; rm -f repo" &&
+	(
+		sane_unset GIT_TEST_ASSUME_DIFFERENT_OWNER &&
+		git config --global --unset-all safe.directory
+	) &&
+	git init repository &&
+	ln -s repository repo &&
+	(
+		cd repository &&
+		sane_unset GIT_TEST_ASSUME_DIFFERENT_OWNER &&
+		test_commit sample
+	) &&
+
+	(
+		sane_unset GIT_TEST_ASSUME_DIFFERENT_OWNER &&
+		git config --global safe.directory "$(pwd)/repository"
+	) &&
+	git -C repository/ for-each-ref >/dev/null &&
+	git -C repo/ for-each-ref
+'
+
+test_expect_success SYMLINKS 'checked leading paths are normalized' '
+	test_when_finished "rm -rf repository; rm -f repo" &&
+	(
+		sane_unset GIT_TEST_ASSUME_DIFFERENT_OWNER &&
+		git config --global --unset-all safe.directory
+	) &&
+	mkdir -p repository &&
+	git init repository/s &&
+	ln -s repository repo &&
+	(
+		cd repository/s &&
+		sane_unset GIT_TEST_ASSUME_DIFFERENT_OWNER &&
+		test_commit sample
+	) &&
+
+	(
+		sane_unset GIT_TEST_ASSUME_DIFFERENT_OWNER &&
+		git config --global safe.directory "$(pwd)/repository/*"
+	) &&
+	git -C repository/s for-each-ref >/dev/null &&
+	git -C repo/s for-each-ref
+'
+
 test_done
--=20
2.46.0-rc1-48-g0900f1888e

