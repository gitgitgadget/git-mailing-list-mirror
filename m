Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76ECF132122
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 02:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721701147; cv=none; b=DyOchc9EuO/2zbIHd56c/eovW7V6Q+f5Dcs55h3WZQ4Sld+p6sgNn504Q1yxaw2ydckULNCqsGxFNLXtCp7HgGOHQMYe36IUnW7D3Jfq9ojrmr3yuzoxNE9xwFSqgQ8L7A3nAXiijSKlGUo69+//4moZngKjrHUhEJ9wyniKZ1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721701147; c=relaxed/simple;
	bh=cPH0vqUY2/Rz8Q6E/5uPXS8eqhhAKGF5ymfCa2iIMEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cWDobIsexSS9wYhd5eKcxAvddzO5RrytsIR+Dr+pnoWpKBF6p9J/UVJcMuedD/7dtOxTCYPvszkIzndSrtw/5SX2VZ/Qq+kFGHNeDINBP01Rp4lpP5Xoyyso+Sh4waS+O1KhUM/jbQkd1fW6/b6X+mahKeDvyDyS94IWgjqwMTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=C7+/eYLi; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="C7+/eYLi"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5D18425861;
	Mon, 22 Jul 2024 22:19:04 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=cPH0vqUY2/Rz8Q6E/5uPXS8eq
	hhAKGF5ymfCa2iIMEk=; b=C7+/eYLitiGIhlEViyv5AGMWvQzyr0N0IQoxOXWvA
	rIWygGiWAwwFsQmEr6Ur9DBcKT2eFDkvYCAJHRir17NQMhXDPa/7hMZ7l9zVYaSf
	FkdMeLeC0Gef64WfqxhVJuZH/DwcZUVa1lZdi8mDtvvGUTVP7/OxTHEVOv2maPuh
	UQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5578525860;
	Mon, 22 Jul 2024 22:19:04 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B394D2585E;
	Mon, 22 Jul 2024 22:19:03 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 1/3] safe.directory: normalize the checked path
Date: Mon, 22 Jul 2024 19:18:58 -0700
Message-ID: <20240723021900.388020-2-gitster@pobox.com>
X-Mailer: git-send-email 2.46.0-rc1-52-gda884b23f2
In-Reply-To: <20240723021900.388020-1-gitster@pobox.com>
References: <20240720220915.2933266-1-gitster@pobox.com>
 <20240723021900.388020-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 EE54B2B4-4899-11EF-BC0A-34EEED2EC81B-77302942!pb-smtp1.pobox.com
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
2.46.0-rc1-52-gda884b23f2

