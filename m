Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD607502A9
	for <git@vger.kernel.org>; Mon, 20 May 2024 23:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716246890; cv=none; b=OtBzMYKNzRX10uzJb0Ewb2cENYm8kKOYaBEx0ZJMCraTEmtRz2J2MZTPX5XHM2bfj5GqZ3oj4wpDDnl5MP9DG1L8omq5OuSzsevQJ1fr/eeMl825Zj82FWaSYGlWt6m70sDcT3htKJ6vVF+IxSE1l8b6tglkY9xgdfvjXKaYIlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716246890; c=relaxed/simple;
	bh=x80kiV0VH9KRNKPSklTzFmUGN9JsmhVkPB6snXUHj/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gM2nVv5d4YpjmkRKibhWLCjzFDivw/Iq9kPbb1NUrRFHKp58oL+EtOK4Mka4RUVXoUBvJjP6NctThAu7UvAGCAk3ZBNKqiWN80/vJZhTTLK739OdH6jUhtxRS22vM8oBffAwFv1CH11hWz699Av/TyBSCr4c5KSud3OuyEw9bhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=MYDnLZmQ; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MYDnLZmQ"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 53E1C2891E;
	Mon, 20 May 2024 19:14:48 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=x80kiV0VH9KRNKPSklTzFmUGN
	9JsmhVkPB6snXUHj/4=; b=MYDnLZmQi6f761J9mXgEDbxtFdu9G3BBdhOCyf7Vp
	o17etkFc467VWFaxGJbMeJKiBf7YQ4d2sp96iGxIcU7RU8I0W9/IODs2wHCn3usI
	Ee3OPLg2GFPjCdk8FGEzegZ0Ke2+0uIGGaP9R3CObULFqg/GJozNQCmmvNF8jAvX
	3g=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 4C3902891C;
	Mon, 20 May 2024 19:14:48 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 530C52891B;
	Mon, 20 May 2024 19:14:45 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 4/5] builtin/hash-object: fix uninitialized hash function
Date: Mon, 20 May 2024 16:14:33 -0700
Message-ID: <20240520231434.1816979-5-gitster@pobox.com>
X-Mailer: git-send-email 2.45.1-216-g4365c6fcf9
In-Reply-To: <20240520231434.1816979-1-gitster@pobox.com>
References: <cover.1715582857.git.ps@pks.im>
 <20240520231434.1816979-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 BEFD5240-16FE-11EF-84E1-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

From: Patrick Steinhardt <ps@pks.im>

The git-hash-object(1) command allows users to hash an object even
without a repository. Starting with c8aed5e8da (repository: stop setting
SHA1 as the default object hash, 2024-05-07), this will make us hit an
uninitialized hash function, which subsequently leads to a segfault.

Fix this by falling back to SHA-1 explicitly when running outside of
a Git repository. Users can use GIT_DEFAULT_HASH environment to
specify what hash algorithm they want, so arguably this code should
not be needed.

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
index 64aea38486..d73a5cc237 100755
--- a/t/t1007-hash-object.sh
+++ b/t/t1007-hash-object.sh
@@ -260,4 +260,10 @@ test_expect_success '--literally with extra-long typ=
e' '
 	echo example | git hash-object -t $t --literally --stdin
 '
=20
+test_expect_success '--stdin outside of repository (uses SHA-1)' '
+	nongit git hash-object --stdin <hello >actual &&
+	echo "$(test_oid --hash=3Dsha1 hello)" >expect &&
+	test_cmp expect actual
+'
+
 test_done
diff --git a/t/t1517-outside-repo.sh b/t/t1517-outside-repo.sh
index 278ef57b3a..2d8982d61a 100755
--- a/t/t1517-outside-repo.sh
+++ b/t/t1517-outside-repo.sh
@@ -29,7 +29,7 @@ test_expect_success 'compute a patch-id outside reposit=
ory (uses SHA-1)' '
 	test_cmp patch-id.expect patch-id.actual
 '
=20
-test_expect_failure 'hash-object outside repository (uses SHA-1)' '
+test_expect_success 'hash-object outside repository (uses SHA-1)' '
 	nongit env GIT_DEFAULT_HASH=3Dsha1 \
 		git hash-object --stdin <sample.patch >hash.expect &&
 	nongit \
--=20
2.45.1-216-g4365c6fcf9

