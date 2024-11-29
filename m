Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54891A08C1
	for <git@vger.kernel.org>; Fri, 29 Nov 2024 22:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732918974; cv=none; b=G7fumLDJE8SvInTpoPVK9/q1II6LEv89S9gN4ZMasMM4qj+0rUgkDbTBpbiUKkglGdmwR2lJF1p/D5+GBZHYGhF+T4eg7HfsGpnk70yppLPDmG3HLPSCIOkOFsuH/X9uBebdF2//jh7feVlLX+DYn7kGKYmvxADeBVd7NlQQsgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732918974; c=relaxed/simple;
	bh=oKuvO9z41n9rfyQpOAril1UCgmdyXiFdRNvV6hSUsSU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FKLGGoCbURKSGHDdIWimCMdTPl/36VKalbjDY7RNvO4/PUXeCvnqq3jNN9jyphZgO0anWx1eKK3VTNYMYrvYTqMAZEsfyl6nhF0Q95CwXAr+FCoiTHaLpGp1l5iSj43Xr2k2wpouEfWbPD4cRuzhaRZ1BPcm+uQjjQeFDWUM78Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=FtIbPBwB; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="FtIbPBwB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1732918970; x=1733178170;
	bh=4vvDm+XXwPPvMZOS9mtInxYEWB2d92PqOjE/rhRutak=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=FtIbPBwBov/lO8g5VL5BDwH/RgA3k1UbzfnNMdzx7fulHs5AJpfnfDpvFlxVcZHkj
	 FsdfSTKNUCAa7IUx3WWtiadxvWECqHX7zHGBCpEhB/7Wml7ygL3E87sl7T+PLXKDxn
	 Bdf/Tz41FhJtujrTIrj8jPWI/0QNP1/Ht7S0tQJGhOLZMea/hiodaK5ezpR6iERwNk
	 91p3eYpY+9oGwerolF2ibhS4MkR3g7CAMn5h+ZDwc5XTaSRzhmO3nqldRhqiIOjqLn
	 z7ySiRs8Rb/jgeq8TS7LNM8NVGvp+XuuDzP11t5bJVTWIzSs7JnqswnR4wg7Tw5MTA
	 U0GNf/PBUOYZg==
Date: Fri, 29 Nov 2024 22:22:47 +0000
To: git@vger.kernel.org
From: Caleb White <cdwhite3@pm.me>
Cc: Taylor Blau <me@ttaylorr.com>, Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano <gitster@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>, Caleb White <cdwhite3@pm.me>
Subject: [PATCH v6 4/8] worktree: add `write_worktree_linking_files()` function
Message-ID: <20241129-wt_relative_options-v6-4-44e4e0bec8c3@pm.me>
In-Reply-To: <20241129-wt_relative_options-v6-0-44e4e0bec8c3@pm.me>
References: <20241031-wt_relative_options-v4-0-07a3dc0f02a3@pm.me> <20241125-wt_relative_options-v5-0-356d122ff3db@pm.me> <20241129-wt_relative_options-v6-0-44e4e0bec8c3@pm.me>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: e19ff5c78e80a214e367b308eef666937638f822
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
 worktree.c | 35 +++++++++++++++++++++++++++++++++++
 worktree.h | 13 +++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/worktree.c b/worktree.c
index afde5394c8760c328f12aa321be3ac5c199cc0f1..cf05045cc973f121a0a76b5ccfa=
731acf25d1a73 100644
--- a/worktree.c
+++ b/worktree.c
@@ -1032,3 +1032,38 @@ int init_worktree_config(struct repository *r)
 =09free(main_worktree_file);
 =09return res;
 }
+
+void write_worktree_linking_files(struct strbuf dotgit, struct strbuf gitd=
ir,
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
index e96118621638667d87c5d7e0452ed10bd1ddf606..fd040f5d999697b603df929679b=
dddd2ff7f6eea 100644
--- a/worktree.h
+++ b/worktree.h
@@ -215,4 +215,17 @@ void strbuf_worktree_ref(const struct worktree *wt,
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
+void write_worktree_linking_files(struct strbuf dotgit, struct strbuf gitd=
ir,
+=09=09=09=09  int use_relative_paths);
+
 #endif

--=20
2.47.0


