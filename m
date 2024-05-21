Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EC21494A2
	for <git@vger.kernel.org>; Tue, 21 May 2024 19:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716321457; cv=none; b=s8cxch/wzfStUbn/HYDwOmjwcw4WPTHMIWdzyoI+YPrAVOi/qaGeRBx6JBEOYZXjiUAuBYcjPMKx3QIv9kF0ai2r1Xw3WOsFjvuBZ0VaUSOJId1fUIsJT8v0/4j9ZwFvmPUrhWEN18gPgg2ueVmBG65R4xe60Ndcl3NaBBkO8rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716321457; c=relaxed/simple;
	bh=sGt4fckFb6a1hc82xeYVNXay/KtR5awbOaVQNzV3dmA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NHq5QBU9U5S+ZQGFQrwheGsMbtPSoBMoPGDdu9KF3UUtEZ9KWxFM11/udH0rXjwQb8U6eh11qtXXRS3m1ACB8lCopaFpRvSCsOnFtQg707pKEc69NqFnFsMtHKhVU9jESkv+/ZMDaZCYX9S3uIwuoeTqojUHQhHfAJHCuLaaxZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=czSSnJWZ; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="czSSnJWZ"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 3B73E2DBF2;
	Tue, 21 May 2024 15:57:36 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=sGt4fckFb6a1hc82xeYVNXay/
	KtR5awbOaVQNzV3dmA=; b=czSSnJWZc/aiKQC1LlWlPsydWFhTR/Ri2SLSOGG8X
	WDlsEaxxyZfeBjtaQ6NvvwoQvVPpja5Aw6llqO0bxczBj3gjCAOJfnWiBVdbSmaw
	rWxGteaFkH4yAbhVcGUN6hYlb8iAxhzFl28KDX4QdMNxBpUS8Ru/VB1VFLHJ8YgN
	Ms=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 3368B2DBF1;
	Tue, 21 May 2024 15:57:36 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 413192DBF0;
	Tue, 21 May 2024 15:57:33 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 12/12] Revert "fetch/clone: detect dubious ownership of local repositories"
Date: Tue, 21 May 2024 12:56:58 -0700
Message-ID: <20240521195659.870714-13-gitster@pobox.com>
X-Mailer: git-send-email 2.45.1-216-g4365c6fcf9
In-Reply-To: <20240521195659.870714-1-gitster@pobox.com>
References: <20240521195659.870714-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 5CEFA9D2-17AC-11EF-81CE-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

This partially reverts f4aa8c8b (fetch/clone: detect dubious
ownership of local repositories, 2024-04-10) that broke typical
read-only use cases (e.g. by git-daemon serving fetches and clones)
where "nobody" who has no write permission serves repositories owned
by others.  The function to die upon seeing dubious ownership is
still kept, as there are other users of it, but calls to it from the
generic repository discovery code path, which triggered in cases far
wider than originally intended (i.e. to stop local clones), have
been removed.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 path.c                        | 2 --
 t/t0411-clone-from-partial.sh | 6 +++---
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/path.c b/path.c
index d61f70e87d..492e17ad12 100644
--- a/path.c
+++ b/path.c
@@ -840,7 +840,6 @@ const char *enter_repo(const char *path, int strict)
 		if (!suffix[i])
 			return NULL;
 		gitfile =3D read_gitfile(used_path.buf);
-		die_upon_dubious_ownership(gitfile, NULL, used_path.buf);
 		if (gitfile) {
 			strbuf_reset(&used_path);
 			strbuf_addstr(&used_path, gitfile);
@@ -851,7 +850,6 @@ const char *enter_repo(const char *path, int strict)
 	}
 	else {
 		const char *gitfile =3D read_gitfile(path);
-		die_upon_dubious_ownership(gitfile, NULL, path);
 		if (gitfile)
 			path =3D gitfile;
 		if (chdir(path))
diff --git a/t/t0411-clone-from-partial.sh b/t/t0411-clone-from-partial.s=
h
index b3d6ddc4bc..a481ed97b7 100755
--- a/t/t0411-clone-from-partial.sh
+++ b/t/t0411-clone-from-partial.sh
@@ -23,7 +23,7 @@ test_expect_success 'create evil repo' '
 	>evil/.git/shallow
 '
=20
-test_expect_success 'local clone must not fetch from promisor remote and=
 execute script' '
+test_expect_failure 'local clone must not fetch from promisor remote and=
 execute script' '
 	rm -f script-executed &&
 	test_must_fail git clone \
 		--upload-pack=3D"GIT_TEST_ASSUME_DIFFERENT_OWNER=3Dtrue git-upload-pac=
k" \
@@ -33,7 +33,7 @@ test_expect_success 'local clone must not fetch from pr=
omisor remote and execute
 	test_path_is_missing script-executed
 '
=20
-test_expect_success 'clone from file://... must not fetch from promisor =
remote and execute script' '
+test_expect_failure 'clone from file://... must not fetch from promisor =
remote and execute script' '
 	rm -f script-executed &&
 	test_must_fail git clone \
 		--upload-pack=3D"GIT_TEST_ASSUME_DIFFERENT_OWNER=3Dtrue git-upload-pac=
k" \
@@ -43,7 +43,7 @@ test_expect_success 'clone from file://... must not fet=
ch from promisor remote a
 	test_path_is_missing script-executed
 '
=20
-test_expect_success 'fetch from file://... must not fetch from promisor =
remote and execute script' '
+test_expect_failure 'fetch from file://... must not fetch from promisor =
remote and execute script' '
 	rm -f script-executed &&
 	test_must_fail git fetch \
 		--upload-pack=3D"GIT_TEST_ASSUME_DIFFERENT_OWNER=3Dtrue git-upload-pac=
k" \
--=20
2.45.1-216-g4365c6fcf9

