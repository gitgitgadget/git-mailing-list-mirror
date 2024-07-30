Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA4AC153
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 01:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722301820; cv=none; b=iXUCrkaWsD5oqIsETVXyQHWSzah+PuT0Levi3Bpda4ilc5QRYqTHOtSwC+S2cr5xcwWw9wP4mcz5wYQNvW/jI2XtDaEfemS/rsuTL3CpyghM4zDXny93HoTtDHtUNrLghab8o2NkVz9rEaraSWSqqYh1P+Nan71IcwdIl/r/8I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722301820; c=relaxed/simple;
	bh=9OTt+0c2Uf1R1g5SjcOyrvdU5PqjEeLivytCoTY+ib8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jOrtbeVxozUckW4MUrafXpB6l16I4ndb+ROoAzrSXbGj0aHctDeY+og+PBFiABCZvueYcoHLEJNIqtGRJ5XG7UToXGDFPu9bfrY+8e6SqiGB00Ak8fbnGnHgNmMAdgKDT4dJZkOCuo8OKyRg/Md/nxr6IP0q98NTkhhJV7oLxMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=aECPpPfY; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="aECPpPfY"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id A93093B13E;
	Mon, 29 Jul 2024 21:10:18 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=9OTt+0c2Uf1R1g5SjcOyrvdU5
	PqjEeLivytCoTY+ib8=; b=aECPpPfYuLt1jH3X1ebHPQaKfVtpKf5O4WpIWmvYu
	UQMwzP2QhY9vqkyBW1QMzURkJnOucNgdjgfCSk5pIEOSzh73iu7I3F6rmlnSXqWx
	iGzh4vtSAdA72VOkST4xjPh9FustFYVbAetDoB0lMBfo1ciCTOrEvsI2HIM78sRN
	o0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id A1C5D3B13D;
	Mon, 29 Jul 2024 21:10:18 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2DDBC3B13C;
	Mon, 29 Jul 2024 21:10:15 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v3 3/3] safe.directory: setting safe.directory="." allows the "current" directory
Date: Mon, 29 Jul 2024 18:10:04 -0700
Message-ID: <20240730011004.4030246-4-gitster@pobox.com>
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
 7A6A783A-4E10-11EF-B859-9625FCCAB05B-77302942!pb-smtp21.pobox.com
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
2.46.0-71-g1aa693ace8

