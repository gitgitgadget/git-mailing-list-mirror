Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2101DFE23
	for <git@vger.kernel.org>; Mon, 28 Oct 2024 19:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730142609; cv=none; b=Ew7AsL+TzpmLzldwfpulaDD+YP2O4kdiaazHvN0TwU2jCYgXzLql8ByawLBxifym51sB8ZhbfNujFAydu24kL0aKPvrm90poofB3Zp29pwTEfEvaK3reWvmnG1PKvDM4pRxoST82uzz9+121lT/ZRyWYRoPZiUcL/Q2Ce1FousY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730142609; c=relaxed/simple;
	bh=FNqfxejyTh/NAYvcDN4jJ+OBaGZ998m+fpzdNMlcqsg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gvtdGskx+HM5J22WJVjuk6ZMegEc8OSMewg+Ok1amrV2CksxJzTCNUf4tCTjHDZSglGG3bX8WJG/Y0OFGH4jnxGGHH/7DW4MI8TiQXyq68mJnZH3ESK8MDsgYleUh7GL6awCPHoEp9hPIl9pVu3z7hdynd3VwIm8ZzzeRameVk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=LKDXiuO9; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="LKDXiuO9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1730142605; x=1730401805;
	bh=h0cqGO+in4oPoDTpVBaHNPN66AD5WU3sI3fLGAcaPYI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=LKDXiuO9bYSzZsLWOCyc7l+w3tofdDi5K/sOCGQ39b98BUnUUb725Yl4+Cz+3LFBs
	 ybOOCBX6OrDAHyBJxzgUVulrJPN9EZSkLhwDyN0Df5TA+WUuo8OAiqYC925NgYgLzQ
	 IsASRfilC49luM4CHaCmOSIkVqoV5L+hCfCKpMK6lxOq4kvXOlWmwniUJJ1sx+G8EP
	 +CUGqm/36nMS6AOohxHlDrGLhC1Vt/teLe5ZByu5uqIJd9ddiyNEnvnfE7bn6aF9rd
	 e1rjq+B5j34RjlmVQchhtQxJPOpwVzqVyqEGpefkkerg4fC+6/DkVFLnTpw1OfD04U
	 75ZWeXivS2Mjw==
Date: Mon, 28 Oct 2024 19:10:01 +0000
To: git@vger.kernel.org
From: Caleb White <cdwhite3@pm.me>
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>, Caleb White <cdwhite3@pm.me>
Subject: [PATCH v2 4/5] setup: correctly reinitialize repository version
Message-ID: <20241028-wt_relative_options-v2-4-33a5021bd7bb@pm.me>
In-Reply-To: <20241028-wt_relative_options-v2-0-33a5021bd7bb@pm.me>
References: <20241028-wt_relative_options-v2-0-33a5021bd7bb@pm.me>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: 6c6d262abe2ef4373db5aaa05d352940d4a0e459
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
 setup.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

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

--=20
2.47.0


