Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649661AA3D0
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 18:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722365047; cv=none; b=pMg756FjOE+L8Hu2tzYBof46lXHrGd73U8P2tNx8ZWM2EyJKwO6sf0ib1evDqwbMUOJaN3KO2Zatl4HpFGX+ZjaFPrAbFAA/8EL5JiTLv6xMJW4HzH5XNFbkahY8VXmjpiuufNWF2LCGr4LF1RkonB/7RXWHY7vNoIJ5CeJyAAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722365047; c=relaxed/simple;
	bh=1p4bJDibchEEzBB0BwvdUQSyRdi/ytWgmzGHtmyfLys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sy9E5IoBaYXIlrh9H7axw+oI/tVlCB69XQ14olQQS5K8kDV960Bt1haS9PVXcpyiESDrbI6O+/RaXxrh9iflR+pqWfaZM8hSQMO/7PDrKOkU6uphDIPbvnuWddvUD9YauluvLgf/F41H+cIcqhDtl7DvPHU7Jz5RJJE7nyMwdWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ccEAeYKm; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ccEAeYKm"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id B705D39B9D;
	Tue, 30 Jul 2024 14:44:05 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=1p4bJDibchEEzBB0BwvdUQSyR
	di/ytWgmzGHtmyfLys=; b=ccEAeYKmJ4bZThP1b+NbX1JeEXV2GJOj+HpaJ34qw
	34dOePcnHaL5Yod+R2Ad4KndlGEkzc2IFeoJ7iL1nG4f9SxsWssrcHE34d0Wdcw5
	WQ8x5w4S8GkWGuKS/0PNLwlt/li4U6JPaQxFEp2ONi8sH0GZEangKokqjTdxbIzo
	7E=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id AF6B839B9C;
	Tue, 30 Jul 2024 14:44:05 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 46F7739B9B;
	Tue, 30 Jul 2024 14:44:02 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v4 2/4] safe.directory: normalize the checked path
Date: Tue, 30 Jul 2024 11:43:50 -0700
Message-ID: <20240730184352.2503276-3-gitster@pobox.com>
X-Mailer: git-send-email 2.46.0-77-g633c50689c
In-Reply-To: <20240730184352.2503276-1-gitster@pobox.com>
References: <20240730011004.4030246-1-gitster@pobox.com> <20240723021900.388020-1-gitster@pobox.com> <20240720220915.2933266-1-gitster@pobox.com>
 <20240730184352.2503276-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 B0B4B638-4EA3-11EF-B596-92D9AF168FA5-77302942!pb-smtp20.pobox.com
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
 setup.c                   | 16 ++++++++---
 t/t0033-safe-directory.sh | 57 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+), 4 deletions(-)

diff --git a/setup.c b/setup.c
index 3177d010d1..54cce7219b 100644
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
@@ -1261,9 +1261,7 @@ static int ensure_valid_ownership(const char *gitfi=
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
@@ -1271,6 +1269,15 @@ static int ensure_valid_ownership(const char *gitf=
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
@@ -1278,6 +1285,7 @@ static int ensure_valid_ownership(const char *gitfi=
le,
 	 */
 	git_protected_config(safe_directory_cb, &data);
=20
+	free(data.path);
 	return data.is_safe;
 }
=20
diff --git a/t/t0033-safe-directory.sh b/t/t0033-safe-directory.sh
index 5fe61f1291..07ac0f9a01 100755
--- a/t/t0033-safe-directory.sh
+++ b/t/t0033-safe-directory.sh
@@ -119,4 +119,61 @@ test_expect_success 'local clone of unowned repo acc=
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
+	git -C repository for-each-ref &&
+	git -C repository/ for-each-ref &&
+	git -C repo for-each-ref &&
+	git -C repo/ for-each-ref &&
+	test_must_fail git -C repository/.git for-each-ref &&
+	test_must_fail git -C repository/.git/ for-each-ref &&
+	test_must_fail git -C repo/.git for-each-ref &&
+	test_must_fail git -C repo/.git/ for-each-ref
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
+	git -C repository/s for-each-ref &&
+	git -C repository/s/ for-each-ref &&
+	git -C repo/s for-each-ref &&
+	git -C repo/s/ for-each-ref &&
+	git -C repository/s/.git for-each-ref &&
+	git -C repository/s/.git/ for-each-ref &&
+	git -C repo/s/.git for-each-ref &&
+	git -C repo/s/.git/ for-each-ref
+'
+
 test_done
--=20
2.46.0-77-g633c50689c

