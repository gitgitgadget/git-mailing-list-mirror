Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6946A1AA3F6
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 18:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722365050; cv=none; b=LByTi5JYOeX2pJuAS2tZ3Xw9sf5CxysdIH4bjlQyJDesiNzqOMwZNU8xm3WpLeOTFCOWtnR0E1xTZ9VwlYGdb3u3Wm4AYgwlUazBwPTAagMXaI2q9skd8T7n1lAh+Z1JFHMqQj0dch4ddyAA5YeZtLKlfIMVrgdkqVGTFM1JjrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722365050; c=relaxed/simple;
	bh=F3oKBO04l6XBcfTHkpxxV+9vd8FrFUFXNIwcJiswUI8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cUyT20wxa7BGcp91dXYmW7pG69BHrU3xlAYwCsI9q5BSYC/YaEjL+I5JpX7V4RLrhTUPOckUq3xGDvmbFaRpmVp4Jlhu8wscFBhDe9rA4KKLUZUhN1jwXWpOtlqBtnVjhDnCStCvfqNqx8gp9G+pQlvg+/qSIqPbtqMGB72Gv6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=LgLWHgHa; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LgLWHgHa"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2A08734F2A;
	Tue, 30 Jul 2024 14:44:08 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=F3oKBO04l6XBcfTHkpxxV+9vd
	8FrFUFXNIwcJiswUI8=; b=LgLWHgHaee8EfXejIgtz8JQPJoKzt8N9b98jeSmnI
	Ypd2cZqc3NJ4em0LLvy4/NMA5s+VWt2xmbrl6Vzj4CJj8HjjicA3kyBwXZbMlpLi
	2UKI3C21uI7dkY5B707ZXRy5zrIYlm8P4GAeO7cwWvAqUtzNOT8cX0WxM0gBHGkd
	2k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1D09234F29;
	Tue, 30 Jul 2024 14:44:08 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6D03E34F26;
	Tue, 30 Jul 2024 14:44:07 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v4 4/4] safe.directory: setting safe.directory="." allows the "current" directory
Date: Tue, 30 Jul 2024 11:43:52 -0700
Message-ID: <20240730184352.2503276-5-gitster@pobox.com>
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
 B3C7B9D8-4EA3-11EF-A703-34EEED2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

When "git daemon" enters a repository, it chdir's to the requested
repository and then uses "." (the curent directory) to consult the
"is this repository considered safe?" when it is not owned by the
same owner as the process.

Make sure this access will be allowed by setting safe.directory to
".", as that was once advertised on the list as a valid workaround
to the overly tight safe.directory settings introduced by 2.45.1
(cf. <834862fd-b579-438a-b9b3-5246bf27ce8a@gmail.com>).

Also add simlar test to show what happens in the same setting if the
safe.directory is set to "*" instead of "."; in short, "." is a bit
tighter (as it is custom designed for git-daemon situation) than
"anything goes" settings given by "*".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t0033-safe-directory.sh | 64 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/t/t0033-safe-directory.sh b/t/t0033-safe-directory.sh
index ea74657255..e97a84764f 100755
--- a/t/t0033-safe-directory.sh
+++ b/t/t0033-safe-directory.sh
@@ -233,4 +233,68 @@ test_expect_success SYMLINKS 'configured leading pat=
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
+	# What is allowed is repository/subdir but the repository
+	# path is repository.
+	test_must_fail git -C repository/subdir for-each-ref &&
+
+	# Likewise, repository .git/refs is allowed with "." but
+	# repository/.git that is accessed is not allowed.
+	test_must_fail git -C repository/.git/refs for-each-ref
+'
+
+test_expect_success 'safe.directory set to asterisk' '
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
+		git config --global safe.directory "*"
+	) &&
+	# these are trivial
+	git -C repository for-each-ref &&
+	git -C repository/ for-each-ref &&
+	git -C repository/.git for-each-ref &&
+	git -C repository/.git/ for-each-ref &&
+
+	# With "*", everything is allowed, and the repository is
+	# discovered, which is different behaviour from "." above.
+	git -C repository/subdir for-each-ref &&
+
+	# Likewise.
+	git -C repository/.git/refs for-each-ref
+'
+
 test_done
--=20
2.46.0-77-g633c50689c

