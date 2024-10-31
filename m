Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088FB10E0
	for <git@vger.kernel.org>; Thu, 31 Oct 2024 05:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730351158; cv=none; b=eA4GXp7UWMOzo2bKbEEVFXRkyhnWtwGVgTileax/SetO4BeO4eKfbR5lctFV6sNTMd5byD/IhYiJq+C4gfE4mxsU/aDAdwQA9Ndg3p+Z5DKL1kevjUUsDeNDBPh5rqA71uZ1UCZxo1fLNRxxN/rOwThwEK0Mu6q4Mc03PfdIZQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730351158; c=relaxed/simple;
	bh=MGlYr4BJ2MzPAyfhZjOJw6s8y3kIjGM7tcLl9OI2rR4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RTYNhhTiSbIXzFGQCMsztdtfyGA8FSO1+YkfZpwrL6WvOYlF9XiWVasYSr7UNIwUwYBuiDKTsYQpboPfjyOpigpW82KSEaOP4mOvGtt5To5CkHeVtYgZq7W6RAIoJFRf8oZ8Qt6FZqMFiMoON7xxmyZqr1vIauBzl2OseX5xtQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=NI0tQUZj; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="NI0tQUZj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1730351153; x=1730610353;
	bh=Pz2745YuyaR91mhAlfM9GNNbzXiADDE1WJj81J2OlEc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=NI0tQUZjNu0gE9N6jtiUgTsECYvSGar+mBS54Q9VoqxfdoixNZ1Oi/GYewZ3pq9Yy
	 vwXqC5CjqhB6XeW8P9muGKOn/mqwLqOZHqe9ks2Fwc3/JEjZjWFL2hcqR+cIgItLYo
	 vNYRH8WNpD7ttYrmMjT9+JNX7OmAe6pPICWEANaDIN0Rb0QcEes9yecv/5qi5PiJvH
	 hLvptbl1RhgDI1vcPU+FoOiDrBT6N5Bw/ru5qxJpKkuwjd9lEA3HeLeKdFnxFQl0aN
	 a0TvPGJs8gjhCef2xgsz6i74zAvdjPpXIQk7IRCSiWgYzEvaJ/kyNyhan19Lj+9mNZ
	 fBi+LrY0LpOLg==
Date: Thu, 31 Oct 2024 05:05:50 +0000
To: git@vger.kernel.org
From: Caleb White <cdwhite3@pm.me>
Cc: Taylor Blau <me@ttaylorr.com>, Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano <gitster@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>, Caleb White <cdwhite3@pm.me>
Subject: [PATCH v3 4/8] worktree: add `write_worktree_linking_files()` function
Message-ID: <20241031-wt_relative_options-v3-4-3e44ccdf64e6@pm.me>
In-Reply-To: <20241031-wt_relative_options-v3-0-3e44ccdf64e6@pm.me>
References: <20241031-wt_relative_options-v3-0-3e44ccdf64e6@pm.me>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: 3529d4b8fe93935826dc31684a7eaba6891f8a64
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


