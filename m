Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFB8157E99
	for <git@vger.kernel.org>; Fri, 25 Oct 2024 22:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729895396; cv=none; b=oAd3Gkb5MeFfCY0z6RCFuZyySBdvAkhecntO6lWjS46FnZt/txVpKPuGpQMQ4KFljy/Htd0DDYEV4f7vgZ/ghWyDi48DlRROicj0yuMJnf8KApRS+Fyi2zDr5lZePASq7971Am+dbbWbAXZbzBC+sXlLU6vlIMekopGL/nh0j9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729895396; c=relaxed/simple;
	bh=2ac0Jw1Bk+RM2pDQkHP9zlnWvcdwixPdiFwi+3CGTYY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D6wzHgjH05xJ2RrwtJHBjJDGdNDmPFAIBfBXNCVs5JlG/paJswkw2K8Y1TLXB7fc5fohVTY56xhy5Jzjc2KNgbUGJbID6KUmDy11Q0qGiyxjnlGNuihU1tO273fdwvniWFsxoXxJbT1wsQdQ/VA4pnFQmpxpJV8v1J5xMhd41Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=gRZuNI5Y; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="gRZuNI5Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1729895392; x=1730154592;
	bh=TOca0vDen4H30zKztrGoVDuQLGAvPo0EcPWHyO0nipI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=gRZuNI5YVwYpLdUtsTmDCWy4B+qTj8mmdE9l+qrtlJHzdL8u7b0yBljtsrl0YURJP
	 XO9qSRD+XmfMADyWBfPDtZuOoD74Br0sfSrXDZN5ILgDmLnKgtpX0PDQHZjDHL9CGk
	 F+mzYORYfhhCY8/Mt8jUkc/yOZG2AbqJ5Lh111PYJxEg7hr0SCbxzjg1OyJzC0oc0s
	 rZgSEJ/QY6BrxW4HGDggIS6CZnZkM3pwOrGpIIYLqaxIPaEIKqp/sTzV2qnC9ArF7j
	 DxSTB76XXM7c0yYiBsyTTOMB+SvUTRIYITfcZZP11pq3Dz4QckfWpgDL2+/f7xHAVH
	 1Qy+mU5DHLBYg==
Date: Fri, 25 Oct 2024 22:29:47 +0000
To: git@vger.kernel.org
From: Caleb White <cdwhite3@pm.me>
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>, Phillip Wood <phillip.wood123@gmail.com>, shejialuo <shejialuo@gmail.com>, Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Caleb White <cdwhite3@pm.me>
Subject: [PATCH 2/2] worktree: add `relativeWorktrees` extension
Message-ID: <20241025-wt_relative_options-v1-2-c3005df76bf9@pm.me>
In-Reply-To: <20241025-wt_relative_options-v1-0-c3005df76bf9@pm.me>
References: <20241025-wt_relative_options-v1-0-c3005df76bf9@pm.me>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: b265cf202f0c4e182756885d8fbdd645aa7121cb
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

A new extension, `relativeWorktrees`, is added to indicate that at least
one worktree in the repository has been linked with relative paths. This
extension is automatically set when a worktree is created or repaired
using the `--relative-paths` option, or when the
`worktree.useRelativePaths` config is set to `true`.

The `relativeWorktrees` extension ensures older Git versions do not
attempt to automatically prune worktrees with relative paths, as they
would not not recognize the paths as being valid.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Caleb White <cdwhite3@pm.me>
---
 Documentation/config/extensions.txt |  6 ++++++
 repository.c                        |  1 +
 repository.h                        |  1 +
 setup.c                             |  7 +++++++
 setup.h                             |  1 +
 t/t2400-worktree-add.sh             | 13 +++++++++++++
 worktree.c                          |  8 ++++++++
 7 files changed, 37 insertions(+)

diff --git a/Documentation/config/extensions.txt b/Documentation/config/ext=
ensions.txt
index 5dc569d1c9c77c15e32441493289f9c9dd5e7f0b..5cb4721a0e0ae1ed64f90492c0d=
c18b96473cb33 100644
--- a/Documentation/config/extensions.txt
+++ b/Documentation/config/extensions.txt
@@ -63,6 +63,12 @@ Note that this setting should only be set by linkgit:git=
-init[1] or
 linkgit:git-clone[1]. Trying to change it after initialization will not
 work and will produce hard-to-diagnose issues.
=20
+relativeWorktrees::
+=09If enabled, indicates at least one worktree has been linked with
+=09relative paths. Automatically set if a worktree has been created or
+=09repaired with either the `--relative-paths` option or with the
+=09`worktree.useRelativePaths` config set to `true`.
+
 worktreeConfig::
 =09If enabled, then worktrees will load config settings from the
 =09`$GIT_DIR/config.worktree` file in addition to the
diff --git a/repository.c b/repository.c
index f988b8ae68a6a29792e7f2c980a02bd0e388a3b9..1a6a62bbd03a5dc4fdade3eb45e=
a2696968abc23 100644
--- a/repository.c
+++ b/repository.c
@@ -283,6 +283,7 @@ int repo_init(struct repository *repo,
 =09repo_set_compat_hash_algo(repo, format.compat_hash_algo);
 =09repo_set_ref_storage_format(repo, format.ref_storage_format);
 =09repo->repository_format_worktree_config =3D format.worktree_config;
+=09repo->repository_format_relative_worktrees =3D format.relative_worktree=
s;
=20
 =09/* take ownership of format.partial_clone */
 =09repo->repository_format_partial_clone =3D format.partial_clone;
diff --git a/repository.h b/repository.h
index 24a66a496a6ff516ce06d47b7329b3d36eb701ca..c4c92b2ab9c9e3b425dc2974636=
e33d1f4089c69 100644
--- a/repository.h
+++ b/repository.h
@@ -150,6 +150,7 @@ struct repository {
=20
 =09/* Configurations */
 =09int repository_format_worktree_config;
+=09int repository_format_relative_worktrees;
=20
 =09/* Indicate if a repository has a different 'commondir' from 'gitdir' *=
/
 =09unsigned different_commondir:1;
diff --git a/setup.c b/setup.c
index 7b648de0279116b381eea46800ad130606926103..6bf56cf72c4b46a95f46f9b3901=
f7e77d702cec7 100644
--- a/setup.c
+++ b/setup.c
@@ -683,6 +683,9 @@ static enum extension_result handle_extension(const cha=
r *var,
 =09=09=09=09     "extensions.refstorage", value);
 =09=09data->ref_storage_format =3D format;
 =09=09return EXTENSION_OK;
+=09} else if (!strcmp(ext, "relativeworktrees")) {
+=09=09data->relative_worktrees =3D git_config_bool(var, value);
+=09=09return EXTENSION_OK;
 =09}
 =09return EXTENSION_UNKNOWN;
 }
@@ -1854,6 +1857,8 @@ const char *setup_git_directory_gently(int *nongit_ok=
)
 =09=09=09=09=09=09    repo_fmt.ref_storage_format);
 =09=09=09the_repository->repository_format_worktree_config =3D
 =09=09=09=09repo_fmt.worktree_config;
+=09=09=09the_repository->repository_format_relative_worktrees =3D
+=09=09=09=09repo_fmt.relative_worktrees;
 =09=09=09/* take ownership of repo_fmt.partial_clone */
 =09=09=09the_repository->repository_format_partial_clone =3D
 =09=09=09=09repo_fmt.partial_clone;
@@ -1950,6 +1955,8 @@ void check_repository_format(struct repository_format=
 *fmt)
 =09=09=09=09    fmt->ref_storage_format);
 =09the_repository->repository_format_worktree_config =3D
 =09=09fmt->worktree_config;
+=09the_repository->repository_format_relative_worktrees =3D
+=09=09fmt->relative_worktrees;
 =09the_repository->repository_format_partial_clone =3D
 =09=09xstrdup_or_null(fmt->partial_clone);
 =09clear_repository_format(&repo_fmt);
diff --git a/setup.h b/setup.h
index e496ab3e4de580c2d9f95a7ea0eaf90e0d41b070..18dc3b73686ce28fac2fe04282c=
e95f8bf3e6b74 100644
--- a/setup.h
+++ b/setup.h
@@ -129,6 +129,7 @@ struct repository_format {
 =09int precious_objects;
 =09char *partial_clone; /* value of extensions.partialclone */
 =09int worktree_config;
+=09int relative_worktrees;
 =09int is_bare;
 =09int hash_algo;
 =09int compat_hash_algo;
diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index 630c13230b3cc762ce8d943e22be8891aa2b1871..d36d8a4db0e9248777876975795=
44f10f92dc0cf 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -1248,4 +1248,17 @@ test_expect_success 'move repo without breaking rela=
tive internal links' '
 =09)
 '
=20
+test_expect_success 'relative worktree sets extension config' '
+=09test_when_finished "rm -rf repo" &&
+=09git init repo &&
+=09git -C repo commit --allow-empty -m base &&
+=09git -C repo worktree add --relative-paths ./foo &&
+=09git -C repo config get core.repositoryformatversion >actual &&
+=09echo 1 >expected &&
+=09test_cmp expected actual &&
+=09git -C repo config get extensions.relativeworktrees >actual &&
+=09echo true >expected &&
+=09test_cmp expected actual
+'
+
 test_done
diff --git a/worktree.c b/worktree.c
index f4cee73d7a1edecafdff30b6d5e2d9dd1365b93e..0ae4a5f796f10c017ef90413e96=
9e1622b54a897 100644
--- a/worktree.c
+++ b/worktree.c
@@ -1024,6 +1024,14 @@ void write_worktree_linking_files(struct strbuf dotg=
it, struct strbuf gitdir)
 =09strbuf_strip_suffix(&repo, "/gitdir");
 =09strbuf_realpath(&repo, repo.buf, 1);
=20
+=09if (use_relative_paths && !the_repository->repository_format_relative_w=
orktrees) {
+=09=09if (upgrade_repository_format(1) < 0)
+=09=09=09die(_("unable to upgrade repository format to support relative wo=
rktrees"));
+=09=09if (git_config_set_gently("extensions.relativeWorktrees", "true"))
+=09=09=09die(_("unable to set extensions.relativeWorktrees setting"));
+=09=09the_repository->repository_format_relative_worktrees =3D 1;
+=09}
+
 =09if (use_relative_paths) {
 =09=09write_file(gitdir.buf, "%s/.git", relative_path(path.buf, repo.buf, =
&tmp));
 =09=09write_file(dotgit.buf, "gitdir: %s", relative_path(repo.buf, path.bu=
f, &tmp));

--=20
2.47.0


