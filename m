Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABBE217F32
	for <git@vger.kernel.org>; Fri, 25 Oct 2024 20:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729889853; cv=none; b=j65eeIqLStfFCQGSBBw/iaF7Y8emazW/ZBMnf4bR8dneN6hWCXfruwWUwDpfu2AtyhZL664LkdzJfKls9+bWnT0OK8GYxhgam2gOxMjMzR/xD/hb4pbom0w2Xci62j6C3C45bq/QeV0ZW0paRroP/Ncc+EZNJ+8E3UQtT5kurbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729889853; c=relaxed/simple;
	bh=trotKDKj0V2+d2IcSm2zLzMIndsSymQeFHxS6gvlWF0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eoRYZ6kfUEI4JB5YAjs0+tGI+gEs1Oyc68snIOFJxi49Q/nsQF/4kVbF/U01UD4uZh776JUBexjT0eqmeKWCdwRQT+fc3bzEUGUBki0msrCj71vkcJtdBpbWg6BB3EZeyILvgfw1yrxWAfnuE0YkKXJcBVfIJQTkFX9hg/QAc9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=XZyPnK5C; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="XZyPnK5C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1729889849; x=1730149049;
	bh=9cbp4mFdzY8oKrUF0dWYZ0KOeePNfKNdzzgE081WdE4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=XZyPnK5CAXD8edrdvQrhrgbT+PuXjj3jUO9VevUhb6N773OopEH33drGJx51QtxZG
	 sjamMD0Ytnl5LPA7x0A1vRNEV1kDWZHRSItb2mPwFZMaOsDSoDtvAxuuq/BKPHJteh
	 b6TdyrOQCBckxzWbtNaLJMUI4jlniGndNhVH8/vrEkLpcpBvf868YMkBAcXphwp0MO
	 mnCakxP30EyhdE5NSmVCjbkOf0BivLwOkJgZBWrqYLTanoQfkdvk32xdU0tYgpUHE6
	 phmmLs5WiK54K5sufXv35noicefYP0X1TyVMO20eWJX3e7DNImxnV0FeaXmMpeRB92
	 u6EVIbsgq5ZlA==
Date: Fri, 25 Oct 2024 20:57:25 +0000
To: git@vger.kernel.org
From: Caleb White <cdwhite3@pm.me>
Cc: Junio C Hamano <gitster@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>, Phillip Wood <phillip.wood123@gmail.com>, shejialuo <shejialuo@gmail.com>, Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Caleb White <cdwhite3@pm.me>
Subject: [PATCH v3 1/5] worktree: refactor infer_backlink() to use strbuf*
Message-ID: <20241025-wt_relative_paths-v3-1-8860a5321c01@pm.me>
In-Reply-To: <20241025-wt_relative_paths-v3-0-8860a5321c01@pm.me>
References: <20241025-wt_relative_paths-v3-0-8860a5321c01@pm.me>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: c417bfdd8b730a59c4f553b143f3379e65965a73
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The infer_backlink() function initializes a `strbuf` for the inferred
backlink and returns the result as a `char*` by detaching the `strbuf`.

The next patch needs the backlink returned from infer_backlink() as a
`strbuf`. It seemed inefficient to convert from `strbuf` to `char*`
and back to `strbuf` again. This refactors infer_backlink() to return
an integer result and accept a pre-allocated `strbuf` for the inferred
backlink path, improving efficiency.

Signed-off-by: Caleb White <cdwhite3@pm.me>
---
 worktree.c | 52 ++++++++++++++++++++++++++--------------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/worktree.c b/worktree.c
index ec95ea2986107b3bc12d38b0825d7c6e87402bc6..ad60ba0b5843f1676e89b05eca3=
c82aace5fb49b 100644
--- a/worktree.c
+++ b/worktree.c
@@ -641,13 +641,15 @@ static int is_main_worktree_path(const char *path)
  * won't know which <repo>/worktrees/<id>/gitdir to repair. However, we ma=
y
  * be able to infer the gitdir by manually reading /path/to/worktree/.git,
  * extracting the <id>, and checking if <repo>/worktrees/<id> exists.
+ *
+ * Returns -1 on failure and strbuf.len on success.
  */
-static char *infer_backlink(const char *gitfile)
+static int infer_backlink(const char *gitfile, struct strbuf *inferred)
 {
 =09struct strbuf actual =3D STRBUF_INIT;
-=09struct strbuf inferred =3D STRBUF_INIT;
 =09const char *id;
=20
+=09strbuf_reset(inferred);
 =09if (strbuf_read_file(&actual, gitfile, 0) < 0)
 =09=09goto error;
 =09if (!starts_with(actual.buf, "gitdir:"))
@@ -658,17 +660,16 @@ static char *infer_backlink(const char *gitfile)
 =09id++; /* advance past '/' to point at <id> */
 =09if (!*id)
 =09=09goto error;
-=09strbuf_git_common_path(&inferred, the_repository, "worktrees/%s", id);
-=09if (!is_directory(inferred.buf))
+=09strbuf_git_common_path(inferred, the_repository, "worktrees/%s", id);
+=09if (!is_directory(inferred->buf))
 =09=09goto error;
=20
 =09strbuf_release(&actual);
-=09return strbuf_detach(&inferred, NULL);
-
+=09return inferred->len;
 error:
 =09strbuf_release(&actual);
-=09strbuf_release(&inferred);
-=09return NULL;
+=09strbuf_reset(inferred); /* clear invalid path */
+=09return -1;
 }
=20
 /*
@@ -680,10 +681,11 @@ void repair_worktree_at_path(const char *path,
 {
 =09struct strbuf dotgit =3D STRBUF_INIT;
 =09struct strbuf realdotgit =3D STRBUF_INIT;
+=09struct strbuf backlink =3D STRBUF_INIT;
+=09struct strbuf inferred_backlink =3D STRBUF_INIT;
 =09struct strbuf gitdir =3D STRBUF_INIT;
 =09struct strbuf olddotgit =3D STRBUF_INIT;
-=09char *backlink =3D NULL;
-=09char *inferred_backlink =3D NULL;
+=09char *dotgit_contents =3D NULL;
 =09const char *repair =3D NULL;
 =09int err;
=20
@@ -699,23 +701,23 @@ void repair_worktree_at_path(const char *path,
 =09=09goto done;
 =09}
=20
-=09inferred_backlink =3D infer_backlink(realdotgit.buf);
-=09backlink =3D xstrdup_or_null(read_gitfile_gently(realdotgit.buf, &err))=
;
-=09if (err =3D=3D READ_GITFILE_ERR_NOT_A_FILE) {
+=09infer_backlink(realdotgit.buf, &inferred_backlink);
+=09dotgit_contents =3D xstrdup_or_null(read_gitfile_gently(realdotgit.buf,=
 &err));
+=09if (dotgit_contents) {
+=09=09strbuf_addstr(&backlink, dotgit_contents);
+=09} else if (err =3D=3D READ_GITFILE_ERR_NOT_A_FILE) {
 =09=09fn(1, realdotgit.buf, _("unable to locate repository; .git is not a =
file"), cb_data);
 =09=09goto done;
 =09} else if (err =3D=3D READ_GITFILE_ERR_NOT_A_REPO) {
-=09=09if (inferred_backlink) {
+=09=09if (inferred_backlink.len) {
 =09=09=09/*
 =09=09=09 * Worktree's .git file does not point at a repository
 =09=09=09 * but we found a .git/worktrees/<id> in this
 =09=09=09 * repository with the same <id> as recorded in the
 =09=09=09 * worktree's .git file so make the worktree point at
-=09=09=09 * the discovered .git/worktrees/<id>. (Note: backlink
-=09=09=09 * is already NULL, so no need to free it first.)
+=09=09=09 * the discovered .git/worktrees/<id>.
 =09=09=09 */
-=09=09=09backlink =3D inferred_backlink;
-=09=09=09inferred_backlink =3D NULL;
+=09=09=09strbuf_swap(&backlink, &inferred_backlink);
 =09=09} else {
 =09=09=09fn(1, realdotgit.buf, _("unable to locate repository; .git file d=
oes not reference a repository"), cb_data);
 =09=09=09goto done;
@@ -743,13 +745,10 @@ void repair_worktree_at_path(const char *path,
 =09 * in the "copy" repository. In this case, point the "copy" worktree's
 =09 * .git file at the "copy" repository.
 =09 */
-=09if (inferred_backlink && fspathcmp(backlink, inferred_backlink)) {
-=09=09free(backlink);
-=09=09backlink =3D inferred_backlink;
-=09=09inferred_backlink =3D NULL;
-=09}
+=09if (inferred_backlink.len && fspathcmp(backlink.buf, inferred_backlink.=
buf))
+=09=09strbuf_swap(&backlink, &inferred_backlink);
=20
-=09strbuf_addf(&gitdir, "%s/gitdir", backlink);
+=09strbuf_addf(&gitdir, "%s/gitdir", backlink.buf);
 =09if (strbuf_read_file(&olddotgit, gitdir.buf, 0) < 0)
 =09=09repair =3D _("gitdir unreadable");
 =09else {
@@ -763,9 +762,10 @@ void repair_worktree_at_path(const char *path,
 =09=09write_file(gitdir.buf, "%s", realdotgit.buf);
 =09}
 done:
-=09free(backlink);
-=09free(inferred_backlink);
+=09free(dotgit_contents);
 =09strbuf_release(&olddotgit);
+=09strbuf_release(&backlink);
+=09strbuf_release(&inferred_backlink);
 =09strbuf_release(&gitdir);
 =09strbuf_release(&realdotgit);
 =09strbuf_release(&dotgit);

--=20
2.47.0


