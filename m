Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534DF433B1
	for <git@vger.kernel.org>; Fri,  1 Nov 2024 04:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730435911; cv=none; b=RmlqCXLRtmEipCKG7Af9Dxlde5Eb+xmjqNBAZ5deAc388vfgrkSYMZBe66QMKYGB+mIB/im/vchZ9EKd1rQkW1nGfU6K1+QOgI9HwbSSk2IbgSvxbmI7lhMze01w8RKndBECRDVOEa71Bs0ZF1FpVbAqADFwWxLxJhDOyx1N7SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730435911; c=relaxed/simple;
	bh=QqCSLPu1D3gw2IRVwKS84R/Lxy0dsZa2dP6NiMpoZwg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BiEBXNiSd7adAg2HPFwpK8nwZbD8b4LI84n8zdOBeGNvKzKYO7Cg9CYkND8LBsj4O+R1RsnDIrXWRPivNnt0zKtj+X9BmHeJMaQ9BxElClELdeSgGx5k9dvOxEjSHEwJovqIUOeHbEYF0p4+LZXrGDgOZKR5k93zxnDiiZRDkPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=nC4pzs3j; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="nC4pzs3j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1730435905; x=1730695105;
	bh=d4udTVzGNYsGEBxJiDuby2/girbDZ5aioz8gviX8GcA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=nC4pzs3jM2DRxfs8imXfM2xnx9KhM7L2HSyRvQnuYtC2EGLkwaALXe9+Pxa1idwK3
	 EQqmVCPc86wAhtDmKyWbnPxkyzAwHlJsU7KSp1sknMfqBgjxC3Lqi+CzEZRlKxJTUO
	 Gy7dNZ2VmFuGmGoLLhTUrnePSLS0qQoSgdpzsLdyw6UATBasRCWisII+zMUQr74OsI
	 j98hliPnSbj70A/bqJhA3k9HJhc30y0Fw/rImjIZS3b85y6MB0Go7D7/hAEJFPCm+O
	 JbbUmV/21vNQGPaQvRG3zfa9WNi0b3WoTN3mEWXueuEAi/hGD/PGwTgWm4KTm4d3NU
	 b9Xz17L03YtRg==
Date: Fri, 01 Nov 2024 04:38:20 +0000
To: git@vger.kernel.org
From: Caleb White <cdwhite3@pm.me>
Cc: Taylor Blau <me@ttaylorr.com>, Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano <gitster@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>, Caleb White <cdwhite3@pm.me>
Subject: [PATCH v4 1/8] setup: correctly reinitialize repository version
Message-ID: <20241031-wt_relative_options-v4-1-07a3dc0f02a3@pm.me>
In-Reply-To: <20241031-wt_relative_options-v4-0-07a3dc0f02a3@pm.me>
References: <20241031-wt_relative_options-v4-0-07a3dc0f02a3@pm.me>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: 1b5161b766f04c7b691c7c1c1db5bad669a17273
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

When reinitializing a repository, Git does not account for extensions
other than `objectformat` and `refstorage` when determining the
repository version. This can lead to a repository being downgraded to
version 0 if extensions are set, causing Git future operations to fail.

This patch teaches Git to check if other extensions are defined in the
config to ensure that the repository version is set correctly.

Signed-off-by: Caleb White <cdwhite3@pm.me>
---
 setup.c                         | 32 +++++++++++++++++++++++---------
 t/t5504-fetch-receive-strict.sh |  6 +++---
 2 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/setup.c b/setup.c
index 7b648de0279116b381eea46800ad130606926103..1e5c2eacb19eb6b230d7c9954f6=
6fc7ae0b05631 100644
--- a/setup.c
+++ b/setup.c
@@ -2204,8 +2204,8 @@ void initialize_repository_version(int hash_algo,
 =09=09=09=09   enum ref_storage_format ref_storage_format,
 =09=09=09=09   int reinit)
 {
-=09char repo_version_string[10];
-=09int repo_version =3D GIT_REPO_VERSION;
+=09struct strbuf repo_version =3D STRBUF_INIT;
+=09int target_version =3D GIT_REPO_VERSION;
=20
 =09/*
 =09 * Note that we initialize the repository version to 1 when the ref
@@ -2216,12 +2216,7 @@ void initialize_repository_version(int hash_algo,
 =09 */
 =09if (hash_algo !=3D GIT_HASH_SHA1 ||
 =09    ref_storage_format !=3D REF_STORAGE_FORMAT_FILES)
-=09=09repo_version =3D GIT_REPO_VERSION_READ;
-
-=09/* This forces creation of new config file */
-=09xsnprintf(repo_version_string, sizeof(repo_version_string),
-=09=09  "%d", repo_version);
-=09git_config_set("core.repositoryformatversion", repo_version_string);
+=09=09target_version =3D GIT_REPO_VERSION_READ;
=20
 =09if (hash_algo !=3D GIT_HASH_SHA1 && hash_algo !=3D GIT_HASH_UNKNOWN)
 =09=09git_config_set("extensions.objectformat",
@@ -2234,6 +2229,25 @@ void initialize_repository_version(int hash_algo,
 =09=09=09       ref_storage_format_to_name(ref_storage_format));
 =09else if (reinit)
 =09=09git_config_set_gently("extensions.refstorage", NULL);
+
+=09if (reinit) {
+=09=09struct strbuf config =3D STRBUF_INIT;
+=09=09struct repository_format repo_fmt =3D REPOSITORY_FORMAT_INIT;
+
+=09=09strbuf_git_common_path(&config, the_repository, "config");
+=09=09read_repository_format(&repo_fmt, config.buf);
+
+=09=09if (repo_fmt.v1_only_extensions.nr)
+=09=09=09target_version =3D GIT_REPO_VERSION_READ;
+
+=09=09strbuf_release(&config);
+=09=09clear_repository_format(&repo_fmt);
+=09}
+
+=09strbuf_addf(&repo_version, "%d", target_version);
+=09git_config_set("core.repositoryformatversion", repo_version.buf);
+
+=09strbuf_release(&repo_version);
 }
=20
 static int is_reinit(void)
@@ -2333,7 +2347,7 @@ static int create_default_files(const char *template_=
path,
 =09=09adjust_shared_perm(repo_get_git_dir(the_repository));
 =09}
=20
-=09initialize_repository_version(fmt->hash_algo, fmt->ref_storage_format, =
0);
+=09initialize_repository_version(fmt->hash_algo, fmt->ref_storage_format, =
reinit);
=20
 =09/* Check filemode trustability */
 =09path =3D git_path_buf(&buf, "config");
diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict=
.sh
index 138e6778a477650ecbe2dc3e480c5fe83d4bb485..290d2a591adae02acf5bcf24dbb=
ff2a0bbfceac8 100755
--- a/t/t5504-fetch-receive-strict.sh
+++ b/t/t5504-fetch-receive-strict.sh
@@ -171,7 +171,7 @@ test_expect_success 'fsck with invalid or bogus skipLis=
t input' '
 =09test_must_fail git -c fsck.skipList=3Ddoes-not-exist -c fsck.missingEma=
il=3Dignore fsck 2>err &&
 =09test_grep "could not open.*: does-not-exist" err &&
 =09test_must_fail git -c fsck.skipList=3D.git/config -c fsck.missingEmail=
=3Dignore fsck 2>err &&
-=09test_grep "invalid object name: \[core\]" err
+=09test_grep "invalid object name: " err
 '
=20
 test_expect_success 'fsck with other accepted skipList input (comments & e=
mpty lines)' '
@@ -234,7 +234,7 @@ test_expect_success 'push with receive.fsck.skipList' '
 =09test_grep "could not open.*: does-not-exist" err &&
 =09git --git-dir=3Ddst/.git config receive.fsck.skipList config &&
 =09test_must_fail git push --porcelain dst bogus 2>err &&
-=09test_grep "invalid object name: \[core\]" err &&
+=09test_grep "invalid object name: " err &&
=20
 =09git --git-dir=3Ddst/.git config receive.fsck.skipList SKIP &&
 =09git push --porcelain dst bogus
@@ -263,7 +263,7 @@ test_expect_success 'fetch with fetch.fsck.skipList' '
 =09test_grep "could not open.*: does-not-exist" err &&
 =09git --git-dir=3Ddst/.git config fetch.fsck.skipList dst/.git/config &&
 =09test_must_fail git --git-dir=3Ddst/.git fetch "file://$(pwd)" $refspec =
2>err &&
-=09test_grep "invalid object name: \[core\]" err &&
+=09test_grep "invalid object name: " err &&
=20
 =09git --git-dir=3Ddst/.git config fetch.fsck.skipList dst/.git/SKIP &&
 =09git --git-dir=3Ddst/.git fetch "file://$(pwd)" $refspec

--=20
2.47.0


