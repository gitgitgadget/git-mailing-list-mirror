Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E264D132122
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 02:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721701152; cv=none; b=ByULgh8uQoyoOteFi7/66vi1jTMlf60dvNyGG08EyZaqtYtdRV3yfR81Io7MNSk0Zzx5wxVFgvs1KwD9O4IrJVFT540sY0MjETOjBGr8oZw1eKkQV2xkhZbSkVYyVSdT5F0ebuVW/58RAkOIJIIQ57VwkiMecmKzbwNPf6x2ag4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721701152; c=relaxed/simple;
	bh=fEOjwnraNCKPPnTvCz9PL8DGXKdkkaqGisPrgesKQqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fv/FHzCxZHOaDxoIctxFN/Y+JX5NfoSrWoX5qkslEar3YeTMxRDph/7cxhzCcRUv9qigxHu1m1XYdRn+3+Ll3AUQrVdPB3nB26dICIUZzI5B1h1sUmGiU1/QX0gziq0zw9TeU546yfUv6Hr/AaJOX9hsDwTtduU1ALHX5D73E6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=JYVjGEer; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JYVjGEer"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 6F3FD2887C;
	Mon, 22 Jul 2024 22:19:10 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=fEOjwnraNCKPPnTvCz9PL8DGX
	KdkkaqGisPrgesKQqs=; b=JYVjGEerRjjLvJQkude1qiwpg7rsCSWJH1hSfMIdK
	dIVYj45aIhW/BLAquJYR8U8kE5eBBASIFpcC7226FidvJU7738jaqON24hcKGnsX
	ai8yr7m4KJZsXSPX31v6X8TjNyT0ykrsWIgKVFn4OERUu9liAU6hAwFlDeFgLPCF
	eI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 670D92887A;
	Mon, 22 Jul 2024 22:19:10 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B7F8A28879;
	Mon, 22 Jul 2024 22:19:05 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 2/3] safe.directory: normalize the configured path
Date: Mon, 22 Jul 2024 19:18:59 -0700
Message-ID: <20240723021900.388020-3-gitster@pobox.com>
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
 EF887F62-4899-11EF-8D0B-9625FCCAB05B-77302942!pb-smtp21.pobox.com
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
 setup.c                   | 12 +++++++++
 t/t0033-safe-directory.sh | 57 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+)

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
2.46.0-rc1-52-gda884b23f2

