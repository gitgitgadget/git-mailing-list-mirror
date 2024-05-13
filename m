Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C4C84D3E
	for <git@vger.kernel.org>; Mon, 13 May 2024 22:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715640109; cv=none; b=u0NXR3LExDJZMS0gjybZEZiX2qNdx0qR0bOA1AlAHY2FhtimPxLdVZTIBNTiDOp+pP+aP36/BDLz/6uglGY25Vsyj8k2dYhfQuXHVbxy7P5MBKqgiZB9S4jhn1cn/52+iRYELtek0S15vQ+fOYY1IvW5PjRYFVbUPcdykJ1FSHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715640109; c=relaxed/simple;
	bh=0ELJNJjJCDdzixAdDVRQTX/8wW6zZB+9PQwG7PDYx0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V5n2O4bHO9fztQy0pvzk7vOZfzlqJ1lNYjWmKZhOQT9lQR+JgZKCZFsguVz8P83duLMan2rLm2MGwIv3E3IrFLj3MW4zCxt4+021dBagas5R6JqloeG42JfXSdSdCBeHc3OqjxNlM+kRUYDjiiyIhM+/wiyZolpYNey77c05z/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=wX8XPj5c; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wX8XPj5c"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 37A64378F8;
	Mon, 13 May 2024 18:41:47 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=0ELJNJjJCDdzixAdDVRQTX/8w
	W6zZB+9PQwG7PDYx0Q=; b=wX8XPj5cpxpyejYF4enk9XeNL5jnUDL4Rv8by+Ba6
	zkyolk2Al+mKCkVikzaQ11EuMV9HqZtKmvt0X7dAbq+dGm42DtFGAk153cNW68S+
	a4e3udcr3rka83lseCp+SndgHRwYM6jlAT3TnF4j/bvGd75lgfilqpTwhBlTZqRo
	h0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 3196D378F7;
	Mon, 13 May 2024 18:41:47 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D95DE378F6;
	Mon, 13 May 2024 18:41:40 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 4/5] builtin/hash-object: fix uninitialized hash function
Date: Mon, 13 May 2024 15:41:26 -0700
Message-ID: <20240513224127.2042052-5-gitster@pobox.com>
X-Mailer: git-send-email 2.45.0-145-g3e4a232f6e
In-Reply-To: <20240513224127.2042052-1-gitster@pobox.com>
References: <cover.1715582857.git.ps@pks.im>
 <20240513224127.2042052-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 F746212A-1179-11EF-882C-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

From: Patrick Steinhardt <ps@pks.im>

The git-hash-object(1) command allows users to hash an object even
without a repository. Starting with c8aed5e8da (repository: stop setting
SHA1 as the default object hash, 2024-05-07), this will make us hit an
uninitialized hash function, which subsequently leads to a segfault.

Fix this by falling back to SHA-1 explicitly when running outside of a
Git repository. Users can use GIT_DEFAULT_HASH_ALGORITHM environment to
specify what hash algorithm they want, so arguably this code should not
be needed.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/hash-object.c   | 3 +++
 t/t1007-hash-object.sh  | 6 ++++++
 t/t1517-outside-repo.sh | 2 +-
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index 82ca6d2bfd..c767414a0c 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -123,6 +123,9 @@ int cmd_hash_object(int argc, const char **argv, cons=
t char *prefix)
 	else
 		prefix =3D setup_git_directory_gently(&nongit);
=20
+	if (nongit && !the_hash_algo)
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
index f1fd5c9888..80261e43c7 100755
--- a/t/t1517-outside-repo.sh
+++ b/t/t1517-outside-repo.sh
@@ -33,7 +33,7 @@ test_expect_success 'compute a patch-id outside reposit=
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

