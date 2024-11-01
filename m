Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D000D433B1
	for <git@vger.kernel.org>; Fri,  1 Nov 2024 04:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730435926; cv=none; b=New3m1juSe05sW3nMVUPXLiC5Bfz84BD5MMlJeEK0UM6LgWwF1LHrSUNNDc4v5yv9Luq2f5AsiUDX1JHXSXwzdCUsLgyEaP+eYrpfUCMJrarThB7htHqTakh61E2wHOBFOjUQQ+ZuTuK2fiXgFgWqL+t7jobdRH1obpGmMd7DCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730435926; c=relaxed/simple;
	bh=MGlYr4BJ2MzPAyfhZjOJw6s8y3kIjGM7tcLl9OI2rR4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g7Qo2sML6Tu+2xaGjqVftGPHD54HSWTJrQin451hbnL5O5bB19NKW/J0lBbFIpP8lWkyixKz46/qQTK2csW6tMPnTvz/dIzsSOeg0I3EPM25q1Cc3e3WvGz33I9Y5EPuoKy++nMq+t2Z7GZsoHlY3/uczHwjUG6yBVJNPP9pHZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=j7O4+Ovi; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="j7O4+Ovi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1730435922; x=1730695122;
	bh=Pz2745YuyaR91mhAlfM9GNNbzXiADDE1WJj81J2OlEc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=j7O4+Ovi9XR+VYJHJdlCcOkSWD4yAuWCTPb6QmXm+xQBi4YYvoykY+4uRG6e67Tk9
	 yxJU+jVsP+fkLhRosSKt2bnmcBOwgCsb/h0+0eQLPGqTHA94YWOT+OxOYW62DgMaZl
	 HN9oshL0MeaHwHHyTAjZVqQ+m7WrE1E+QiobhxpLlgk/Txm/wTIGNjcSxIz762xtkO
	 jPRZ+5P+4GKIsC2AwdCFrqxlyLbtahBRvNVpAVKVJKskXmfkj4+IEIpFVJSBBUQl+4
	 GVYuBmOx+QoP5C/vJk/jLWW8GnD6t14Rn+spdNX14fSmmxaG8Z9TL1Imb6SShLZ0x2
	 KNJFqFI560VYg==
Date: Fri, 01 Nov 2024 04:38:38 +0000
To: git@vger.kernel.org
From: Caleb White <cdwhite3@pm.me>
Cc: Taylor Blau <me@ttaylorr.com>, Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano <gitster@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>, Caleb White <cdwhite3@pm.me>
Subject: [PATCH v4 4/8] worktree: add `write_worktree_linking_files()` function
Message-ID: <20241031-wt_relative_options-v4-4-07a3dc0f02a3@pm.me>
In-Reply-To: <20241031-wt_relative_options-v4-0-07a3dc0f02a3@pm.me>
References: <20241031-wt_relative_options-v4-0-07a3dc0f02a3@pm.me>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: 6666a80e94cde4ac0e134ec137729b6afd005d1b
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

A new helper function, `write_worktree_linking_files()`, centralizes
the logic for computing and writing either relative or absolute
paths, based on the provided configuration. This function accepts
`strbuf` pointers to both the worktree=E2=80=99s `.git` link and the
repository=E2=80=99s `gitdir`, and then writes the appropriate path to each=
.
The `relativeWorktrees` extension is automatically set when a worktree
is linked with relative paths.

Signed-off-by: Caleb White <cdwhite3@pm.me>
---
 worktree.c | 36 ++++++++++++++++++++++++++++++++++++
 worktree.h | 14 ++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/worktree.c b/worktree.c
index 9346d51c438cbd029e9e57591edd8c9f30cc7638..ab6f1e036fa019285a1a5152dec=
b9aed5202909f 100644
--- a/worktree.c
+++ b/worktree.c
@@ -1032,3 +1032,39 @@ int init_worktree_config(struct repository *r)
 =09free(main_worktree_file);
 =09return res;
 }
+
+void write_worktree_linking_files(struct strbuf dotgit,
+=09=09=09=09  struct strbuf gitdir,
+=09=09=09=09  int use_relative_paths)
+{
+=09struct strbuf path =3D STRBUF_INIT;
+=09struct strbuf repo =3D STRBUF_INIT;
+=09struct strbuf tmp =3D STRBUF_INIT;
+
+=09strbuf_addbuf(&path, &dotgit);
+=09strbuf_strip_suffix(&path, "/.git");
+=09strbuf_realpath(&path, path.buf, 1);
+=09strbuf_addbuf(&repo, &gitdir);
+=09strbuf_strip_suffix(&repo, "/gitdir");
+=09strbuf_realpath(&repo, repo.buf, 1);
+
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
+=09if (use_relative_paths) {
+=09=09write_file(gitdir.buf, "%s/.git", relative_path(path.buf, repo.buf, =
&tmp));
+=09=09write_file(dotgit.buf, "gitdir: %s", relative_path(repo.buf, path.bu=
f, &tmp));
+=09} else {
+=09=09write_file(gitdir.buf, "%s/.git", path.buf);
+=09=09write_file(dotgit.buf, "gitdir: %s", repo.buf);
+=09}
+
+=09strbuf_release(&path);
+=09strbuf_release(&repo);
+=09strbuf_release(&tmp);
+}
diff --git a/worktree.h b/worktree.h
index e96118621638667d87c5d7e0452ed10bd1ddf606..4786aa545ca1fa12bb16a55ddf5=
a59c06503b2c5 100644
--- a/worktree.h
+++ b/worktree.h
@@ -215,4 +215,18 @@ void strbuf_worktree_ref(const struct worktree *wt,
  */
 int init_worktree_config(struct repository *r);
=20
+/**
+ * Write the .git file and gitdir file that links the worktree to the repo=
sitory.
+ *
+ * The `dotgit` parameter is the path to the worktree's .git file, and `gi=
tdir`
+ * is the path to the repository's `gitdir` file.
+ *
+ * Example
+ *  dotgit: "/path/to/foo/.git"
+ *  gitdir: "/path/to/repo/worktrees/foo/gitdir"
+ */
+void write_worktree_linking_files(struct strbuf dotgit,
+=09=09=09=09  struct strbuf gitdir,
+=09=09=09=09  int use_relative_paths);
+
 #endif

--=20
2.47.0


