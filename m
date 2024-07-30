Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5F59479
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 01:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722301817; cv=none; b=ffkN3kTA1Vv0r8ByrD9XO/b9xNPSfb7Xu8K8LrDon6vM16iCcuxabLz56pu3zCyZ08GKr+ZznPVWLBkrc/qpRbV4VHhtBb6X1GYQnJpRGfxFSPJNBEe2sHfoJTu6I7486JD90xWqnbn6nvRiCBKzxm4ipvpEX63KuzeLVtl/++A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722301817; c=relaxed/simple;
	bh=SYbO3IRjSc8D3Bce9D6iOYYpxQxQUbd1awXUVaHxSl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BRbbXTsabEoYZigt+eLgiFDFJK8pCBL3u3zLb5DSczAsQqAgJi70XyrF0m/15RX7qhmg0jHYXQ601jOkn2Mc5mhuRvhaJjV4gkxTv5vEtoxahrC8uYj6sTSTvawmTK39eT8BwYWM+TuMZOkMScwWh7uXOFn3REZvoFCBM7TZTg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ijVtcnEA; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ijVtcnEA"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DCF882CDF1;
	Mon, 29 Jul 2024 21:10:13 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=SYbO3IRjSc8D3Bce9D6iOYYpx
	QxQUbd1awXUVaHxSl0=; b=ijVtcnEAywgrii71RgvCsqDanZ0JN0OC2WH4yzbTB
	sGtQg3vs1U6NM/dyrwdbCeYXj/lG+FqOhrYATY6cksQc4eAHkqlo2h6ryKL8QGMC
	PkeUNNlxL5CCQ/cIMmMqMAQwqjvoOPyJTIRR8+LI5LwIzcFlCRj4+U4TcuiBTC27
	oE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C8EF52CDF0;
	Mon, 29 Jul 2024 21:10:13 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 311B12CDEC;
	Mon, 29 Jul 2024 21:10:13 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH v3 2/3] safe.directory: normalize the configured path
Date: Mon, 29 Jul 2024 18:10:03 -0700
Message-ID: <20240730011004.4030246-3-gitster@pobox.com>
X-Mailer: git-send-email 2.46.0-71-g1aa693ace8
In-Reply-To: <20240730011004.4030246-1-gitster@pobox.com>
References: <20240723021900.388020-1-gitster@pobox.com> <20240720220915.2933266-1-gitster@pobox.com>
 <20240730011004.4030246-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 793BB852-4E10-11EF-9F43-34EEED2EC81B-77302942!pb-smtp1.pobox.com
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

Two and a half things to note, compared to the previous step to
normalize the actual path of the suspected repository, are:

 - A configured safe.directory may be coming from .gitignore in the
   home directory that may be shared across machines.  The path
   meant to match with an entry may not necessarily exist on all of
   such machines, so not being able to convert them to real path on
   this machine is *not* a condition that is worthy of warning.
   Hence, we ignore a path that cannot be converted to a real path.

 - A configured safe.directory is essentially a random string that
   user throws at us, written completely unrelated to the directory
   the current process happens to be in.  Hence it makes little
   sense to give a non-absolute path.  Hence we ignore any
   non-absolute paths, except for ".".

 - The safe.directory set to "." was once advertised on the list as
   a valid workaround for the regression caused by the overly tight
   safe.directory check introduced in 2.45.1; we treat it to mean
   "if we are at the top level of a repository, it is OK".
   (cf. <834862fd-b579-438a-b9b3-5246bf27ce8a@gmail.com>).

Suggested-by: Phillip Wood <phillip.wood123@gmail.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 setup.c                   | 37 ++++++++++++++++++++++---
 t/t0033-safe-directory.sh | 57 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 90 insertions(+), 4 deletions(-)

diff --git a/setup.c b/setup.c
index 45bbbe329f..6012f3f011 100644
--- a/setup.c
+++ b/setup.c
@@ -1236,14 +1236,43 @@ static int safe_directory_cb(const char *key, con=
st char *value,
=20
 		if (!git_config_pathname(&allowed, key, value)) {
 			const char *check =3D allowed ? allowed : value;
-			if (ends_with(check, "/*")) {
-				size_t len =3D strlen(check);
-				if (!fspathncmp(check, data->path, len - 1))
+			char *to_free =3D NULL;
+
+			/*
+			 * Setting safe.directory to a non-absolute path
+			 * makes little sense---it won't be relative to
+			 * the configuration file the item is defined in.
+			 * Except for ".", which means "if we are at the top
+			 * level of a repository, then it is OK", which is
+			 * slightly tighter than "*" that allows discovery.
+			 */
+			if (!is_absolute_path(check) && strcmp(check, ".")) {
+				warning(_("safe.directory '%s' not absolute"),
+					check);
+				goto next;
+			}
+
+			/*
+			 * A .gitconfig in $HOME may be shared across
+			 * different machines and safe.directory entries
+			 * may or may not exist as paths on all of these
+			 * machines.  In other words, it is not a warning
+			 * worthy event when there is no such path on this
+			 * machine---the entry may be useful elsewhere.
+			 */
+			to_free =3D real_pathdup(check, 0);
+			if (!to_free)
+				goto next;
+			if (ends_with(to_free, "/*")) {
+				size_t len =3D strlen(to_free);
+				if (!fspathncmp(to_free, data->path, len - 1))
 					data->is_safe =3D 1;
-			} else if (!fspathcmp(data->path, check)) {
+			} else if (!fspathcmp(data->path, to_free)) {
 				data->is_safe =3D 1;
 			}
+			free(to_free);
 		}
+	next:
 		if (allowed !=3D value)
 			free(allowed);
 	}
diff --git a/t/t0033-safe-directory.sh b/t/t0033-safe-directory.sh
index 07ac0f9a01..ea74657255 100755
--- a/t/t0033-safe-directory.sh
+++ b/t/t0033-safe-directory.sh
@@ -176,4 +176,61 @@ test_expect_success SYMLINKS 'checked leading paths =
are normalized' '
 	git -C repo/s/.git/ for-each-ref
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
+		cd repository/s &&
+		sane_unset GIT_TEST_ASSUME_DIFFERENT_OWNER &&
+		test_commit sample
+	) &&
+
+	(
+		sane_unset GIT_TEST_ASSUME_DIFFERENT_OWNER &&
+		git config --global safe.directory "$(pwd)/repo/*"
+	) &&
+	git -C repository/s for-each-ref &&
+	git -C repository/s/ for-each-ref &&
+	git -C repository/s/.git for-each-ref &&
+	git -C repository/s/.git/ for-each-ref &&
+	git -C repo/s for-each-ref &&
+	git -C repo/s/ for-each-ref &&
+	git -C repo/s/.git for-each-ref &&
+	git -C repo/s/.git/ for-each-ref
+'
+
 test_done
--=20
2.46.0-71-g1aa693ace8

