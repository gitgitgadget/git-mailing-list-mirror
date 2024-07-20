Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF66E1494BD
	for <git@vger.kernel.org>; Sat, 20 Jul 2024 22:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721513368; cv=none; b=YdKefujgWKr+/IMNaVTg7bGpjC5Ezg/SM02Yp0Cr+lGCXy1bx+NVWuTnWiXbzc41ucmmb7/3Pkzg41s9+6720GGh1TnZv4ggzU0XgvvyV2AslAJ4lmwC5bKTZFzywcanRuE+VfYCK9ONpY1fYi8o8vBQdE4tf3KXlHC/aM9YCRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721513368; c=relaxed/simple;
	bh=4cbRXQLMDVByK4C75iqJRC2Fj0Z+EikHvxM20LBwZHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q1l3M3Do6b1KWLMUB9/pbnpvoe4L7Cas7dJC2vBtbQqrttF8ls8z4nGr5WOpsyc+4PxPHpdRq4Xt7BPFOZIOBqGox0bvxVbJhmtGrh8Pkmub3xv7W43iQW1cpt3AVFKSYfIyCkF2tpyDYMJgt1J1uUi1QgI4kUrTEm6yVGCHUFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=kg40n/nM; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kg40n/nM"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7104B2715B;
	Sat, 20 Jul 2024 18:09:20 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=4cbRXQLMDVByK4C75iqJRC2Fj
	0Z+EikHvxM20LBwZHw=; b=kg40n/nMh+MlDGebmyVbHDzYNxBGQSlB/DSRaMfu+
	swkZ3ykXta+AXWzjYEn/iK0bPLUtCzlp3LhD2HElxkNE8J63L3ri46DKOA8nHv+Y
	WSt2dRtmo0Ztx/lXkkqN0UdN+G3NRBbkPE4Amur5m3sFApQ49gHAA0Aps7xmplSV
	TU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6918C2715A;
	Sat, 20 Jul 2024 18:09:20 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C418B27159;
	Sat, 20 Jul 2024 18:09:19 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH 2/2] safe.directory: normalize the configured path
Date: Sat, 20 Jul 2024 15:09:13 -0700
Message-ID: <20240720220915.2933266-3-gitster@pobox.com>
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
 B66338E6-46E4-11EF-9CB7-34EEED2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

The pathname of a repository comes from getcwd() and it could be a
path aliased via symbolic links, e.g., the real directory may be
/home/u/repository but a symbolic link /home/u/repo may point at it,
and the clone request may come as "git clone file:///home/u/repo/"

A request to check if /home/u/repository is safe would be rejected
if the safe.directory configuration allows /home/u/repo/ but not its
alias /home/u/repository/.  Normalize the paths configured for the
safe.directory configuration variable before comparing them with the
path being checked.

Suggested-by: Phillip Wood <phillip.wood123@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 setup.c                   | 12 +++++++++++
 t/t0033-safe-directory.sh | 45 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/setup.c b/setup.c
index 45bbbe329f..29304d7452 100644
--- a/setup.c
+++ b/setup.c
@@ -1236,6 +1236,16 @@ static int safe_directory_cb(const char *key, cons=
t char *value,
=20
 		if (!git_config_pathname(&allowed, key, value)) {
 			const char *check =3D allowed ? allowed : value;
+			char *to_free =3D real_pathdup(check, 0);
+
+			if (!to_free) {
+				warning(_("safe.directory '%s' cannot be normalized"),
+					check);
+				goto next;
+			} else {
+				check =3D to_free;
+			}
+
 			if (ends_with(check, "/*")) {
 				size_t len =3D strlen(check);
 				if (!fspathncmp(check, data->path, len - 1))
@@ -1243,7 +1253,9 @@ static int safe_directory_cb(const char *key, const=
 char *value,
 			} else if (!fspathcmp(data->path, check)) {
 				data->is_safe =3D 1;
 			}
+			free(to_free);
 		}
+	next:
 		if (allowed !=3D value)
 			free(allowed);
 	}
diff --git a/t/t0033-safe-directory.sh b/t/t0033-safe-directory.sh
index 3e487e7f4b..17d45d481e 100755
--- a/t/t0033-safe-directory.sh
+++ b/t/t0033-safe-directory.sh
@@ -164,4 +164,49 @@ test_expect_success SYMLINKS 'checked leading paths =
are normalized' '
 	git -C repo/s for-each-ref
 '
=20
+test_expect_success SYMLINKS 'configured paths are normalized' '
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
+		git config --global safe.directory "$(pwd)/repo"
+	) &&
+	git -C repository/ for-each-ref >/dev/null &&
+	git -C repo/ for-each-ref
+'
+
+test_expect_success SYMLINKS 'configured leading paths are normalized' '
+	test_when_finished "rm -rf repository; rm -f repo" &&
+	(
+		sane_unset GIT_TEST_ASSUME_DIFFERENT_OWNER &&
+		git config --global --unset-all safe.directory
+	) &&
+	mkdir -p repository &&
+	git init repository/s &&
+	ln -s repository repo &&
+	(
+		cd repository &&
+		sane_unset GIT_TEST_ASSUME_DIFFERENT_OWNER &&
+		test_commit sample
+	) &&
+
+	(
+		sane_unset GIT_TEST_ASSUME_DIFFERENT_OWNER &&
+		git config --global safe.directory "$(pwd)/repo/*"
+	) &&
+	git -C repository/s for-each-ref >/dev/null &&
+	git -C repo/s for-each-ref
+'
+
 test_done
--=20
2.46.0-rc1-48-g0900f1888e

