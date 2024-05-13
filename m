Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A495159167
	for <git@vger.kernel.org>; Mon, 13 May 2024 19:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715628090; cv=none; b=fgvn/5DdaPzrqEfTaOKKShHhOBMXOG+Fo9BuhcHl30evlmY3va6itw3EL269XZqZq+lGB080ngCBOO55t+IIXstKoEkLYRQn4xGIwAwGflbSJoiffP6yK2o7q/73WiUICvjAGhfdmwjJJJI6uNejJ+SDcGWGruSSQ9s8J86bXfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715628090; c=relaxed/simple;
	bh=wqp7w1zyWlp7wA3i3qZ2C5LBLi2axcaLx7ZSnkFISWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZM62pHYEe25HQmPz+Lh1qz7HCUUF3wlaJmjE2bHHko0xIcDOFb4Stc7Kj8oOz5sj01ru5WINi/LXGlb+5y2lbFYpGt89vtbT4yAcXDqYELThHzQgLnMyxTFfjXkx/3DuoiHtlvuEnLHGLhbgQGwz073HcHZsjndx0HFu5hI+YoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Yw1Yf9ry; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Yw1Yf9ry"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 64F22279AB;
	Mon, 13 May 2024 15:21:27 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=wqp7w1zyWlp7wA3i3qZ2C5LBL
	i2axcaLx7ZSnkFISWc=; b=Yw1Yf9ry6LK9NMLxzwNGylqATZMCvOEF5iyb7oK40
	QKiK+GykMIIKFSinX/uWxQpzzepmVwIehESLkFQNNi9iWpjAVQK6FucBnyqaQbxo
	Z4G//yfLayV9s4IkBGTTZtg72zyMa5Ki2zGDG8HB8oNxea+PFKhXlDAPHp+Cp5fA
	rA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5CB16279AA;
	Mon, 13 May 2024 15:21:27 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C54B4279A9;
	Mon, 13 May 2024 15:21:26 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 4/4] builtin/hash-object: fix uninitialized hash function
Date: Mon, 13 May 2024 12:21:12 -0700
Message-ID: <20240513192112.866021-5-gitster@pobox.com>
X-Mailer: git-send-email 2.45.0-145-g3e4a232f6e
In-Reply-To: <20240513192112.866021-1-gitster@pobox.com>
References: <cover.1715582857.git.ps@pks.im>
 <20240513192112.866021-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 FE529172-115D-11EF-80A8-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

From: Patrick Steinhardt <ps@pks.im>

The git-hash-object(1) command allows users to hash an object even
without a repository. Starting with c8aed5e8da (repository: stop setting
SHA1 as the default object hash, 2024-05-07), this will make us hit an
uninitialized hash function, which subsequently leads to a segfault.

Fix this by falling back to SHA-1 explicitly when running outside of a
Git repository. Eventually, we should expose this function as a command
line option to the users so that they can pick which object hash to use
by themselves.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/hash-object.c   | 7 +++++++
 t/t1007-hash-object.sh  | 6 ++++++
 t/t1517-outside-repo.sh | 2 +-
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index 82ca6d2bfd..0855f4f8aa 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -123,6 +123,13 @@ int cmd_hash_object(int argc, const char **argv, con=
st char *prefix)
 	else
 		prefix =3D setup_git_directory_gently(&nongit);
=20
+	/*
+	 * TODO: Allow the hash algorithm to be configured by the user via a
+	 *       command line option when not using `-w`.
+	 */
+	if (nongit)
+		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
+
 	if (vpath && prefix) {
 		vpath_free =3D prefix_filename(prefix, vpath);
 		vpath =3D vpath_free;
diff --git a/t/t1007-hash-object.sh b/t/t1007-hash-object.sh
index 64aea38486..4c138c6ca4 100755
--- a/t/t1007-hash-object.sh
+++ b/t/t1007-hash-object.sh
@@ -260,4 +260,10 @@ test_expect_success '--literally with extra-long typ=
e' '
 	echo example | git hash-object -t $t --literally --stdin
 '
=20
+test_expect_success '--stdin outside of repository' '
+	nongit git hash-object --stdin <hello >actual &&
+	echo "$(test_oid hello)" >expect &&
+	test_cmp expect actual
+'
+
 test_done
diff --git a/t/t1517-outside-repo.sh b/t/t1517-outside-repo.sh
index ac5f3191cc..854bb8f343 100755
--- a/t/t1517-outside-repo.sh
+++ b/t/t1517-outside-repo.sh
@@ -30,7 +30,7 @@ test_expect_success 'compute a patch-id outside reposit=
ory' '
 	test_cmp patch-id.expect patch-id.actual
 '
=20
-test_expect_failure 'hash-object outside repository' '
+test_expect_success 'hash-object outside repository' '
 	git hash-object --stdin <sample.patch >hash.expect &&
 	(
 		cd non-repo &&
--=20
2.45.0-145-g3e4a232f6e

