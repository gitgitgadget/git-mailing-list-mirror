Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB64B13B5B4
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 02:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721701158; cv=none; b=tT2zkXrKgy2GV4jJ6LXJVtU9luhTrFwTSBsZYwyf6TJ349zSQ+K51PQlBiRMubq0G8eUXQn1bEYZu07Jd330xaKDeyyBuD9JZvhNjjg0AmMdx7zIyJ/KafUkPJvYPh/cnqZ9mtQE83LnNk0sPD/Y2gkCLIpvJl4DQr+Rwe7jtH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721701158; c=relaxed/simple;
	bh=fmyYxVtF3kanKHw6ImHfxFQpFJzieB/9x61REybXrWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o3ila5rj315ZiA1paj+eURK01cjyGu14akeqQTvlKlngW/vU6Yc7xJ/WO6Dsl2csD1kblUBvvNQc/AR2B7Vm/7viHHXHA2jGapUuTQejnyiBgSjEooUkJX0oyqSO7/mw03D7+IQLqWXLosx5GcfWS4KnbkbgUJGlCpNmgu8u68Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=tNr/xbJg; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tNr/xbJg"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 88E363FE31;
	Mon, 22 Jul 2024 22:19:16 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=fmyYxVtF3kanKHw6ImHfxFQpF
	JzieB/9x61REybXrWk=; b=tNr/xbJgfn68kXMmlPyQOTqPqXtdsrYY42BkuKOCa
	NHuOa3DiGuPQD7kOytERzt7ECfQ71cUu4QjaeYohtwWHlUlYRLqmZQCmbK6+amGI
	BAS15wttEDmRytzjcJzd6Cy7PWIThScRefzxvl7h8Pmtf56GyyGmSSYA7fi2ZPkt
	HY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 821303FE30;
	Mon, 22 Jul 2024 22:19:16 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C52BF3FE2F;
	Mon, 22 Jul 2024 22:19:10 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 3/3] safe.directory: setting safe.directory="." allows the "current" directory
Date: Mon, 22 Jul 2024 19:19:00 -0700
Message-ID: <20240723021900.388020-4-gitster@pobox.com>
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
 F28BDF10-4899-11EF-84EF-92D9AF168FA5-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

When "git daemon" enters a repository, it chdir's to the requested
repository and then uses "." (the curent directory) to consult the
"is this repository considered safe?" when it is not owned by the
same owner as the process.

Make sure this access will be allowed by setting safe.directory to
".".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t0033-safe-directory.sh | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/t/t0033-safe-directory.sh b/t/t0033-safe-directory.sh
index ea74657255..1eeb794194 100755
--- a/t/t0033-safe-directory.sh
+++ b/t/t0033-safe-directory.sh
@@ -233,4 +233,36 @@ test_expect_success SYMLINKS 'configured leading pat=
hs are normalized' '
 	git -C repo/s/.git/ for-each-ref
 '
=20
+test_expect_success 'safe.directory set to a dot' '
+	test_when_finished "rm -rf repository" &&
+	(
+		sane_unset GIT_TEST_ASSUME_DIFFERENT_OWNER &&
+		git config --global --unset-all safe.directory
+	) &&
+	mkdir -p repository/subdir &&
+	git init repository &&
+	(
+		cd repository &&
+		sane_unset GIT_TEST_ASSUME_DIFFERENT_OWNER &&
+		test_commit sample
+	) &&
+
+	(
+		sane_unset GIT_TEST_ASSUME_DIFFERENT_OWNER &&
+		git config --global safe.directory "."
+	) &&
+	git -C repository for-each-ref &&
+	git -C repository/ for-each-ref &&
+	git -C repository/.git for-each-ref &&
+	git -C repository/.git/ for-each-ref &&
+
+	# what is allowed is repository/subdir but the repository
+	# path is repository.
+	test_must_fail git -C repository/subdir for-each-ref &&
+
+	# likewise, repository .git/refs is allowed with "." but
+	# repository/.git that is accessed is not allowed.
+	test_must_fail git -C repository/.git/refs for-each-ref
+'
+
 test_done
--=20
2.46.0-rc1-52-gda884b23f2

