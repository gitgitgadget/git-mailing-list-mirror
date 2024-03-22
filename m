Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468D638D
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 00:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711065829; cv=none; b=TBg5zLPgi30c9mDq4nr6/JtOKP18soZ82PbEQmvhPWi8S/d7KEBkZyPJMkm9q6QklNBR2RNNvKW6fLuGuZ/6DY0dZgrQ8nCHe8NSvoGfURuKxmQUDQP/NS5QEfpPl9PkgCv3PWBeMDQtc49R8aPNWlkXojIvqHTEEVUULDMWqyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711065829; c=relaxed/simple;
	bh=P7xUPbFPcsR4OH3Ix+vLPng3avVXijxaKs1jZjU06SM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WHgisSfFH/9abtJBzuau9vWMeEwJLhfLk07lcL3S6kqWJq/6WuIA8B/456pb79PqTiHfdXP2/QvQXYU4Yo45l1dHU23rrEki/3qe/n0GE91EzvXSde8pmZDgblwtvCWCt3GaStdOwEIfyRmUDoHwU6MwuCg055T01tNrrRrT9gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archibald.dev; spf=pass smtp.mailfrom=archibald.dev; dkim=pass (2048-bit key) header.d=archibald.dev header.i=@archibald.dev header.b=uaOiD8qB; arc=none smtp.client-ip=185.70.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archibald.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=archibald.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=archibald.dev header.i=@archibald.dev header.b="uaOiD8qB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archibald.dev;
	s=protonmail3; t=1711065825; x=1711325025;
	bh=P7xUPbFPcsR4OH3Ix+vLPng3avVXijxaKs1jZjU06SM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=uaOiD8qB10zD0+g1MYhBC7VoW6OdyytkedW9c7K1bic1ImLNCxzGV1vPWDMMUJQZi
	 ytCH1mVQjZBBi/993yWJ0wZOgVB/2sojZ2XLQaWYraePKgaeoU5CXpv3o8BgA7gLrQ
	 fVXNKrttSrDWCiRDjwWVPjGjtS4YUUr9Pzk3WXbnjeAtl6uulRLukRQoyuZ8jWbjiF
	 UH7UYMmSMKaO8d16o8+DZcqij3djILo8H5XhQHoWTBo7mWTMCPd+HeLuuJpirDPfBh
	 4u7A2U6+X/5pzNAr7ZUx5PhfdYBIKEyOqw+mgdzZgKfVKF5gP2mDxOxbOWZSdZwx4X
	 tnNNRGJRT6pTA==
Date: Fri, 22 Mar 2024 00:03:33 +0000
To: git@vger.kernel.org
From: Thalia Archibald <thalia@archibald.dev>
Cc: Elijah Newren <newren@gmail.com>, Thalia Archibald <thalia@archibald.dev>
Subject: [PATCH 3/6] fast-import: release unfreed strbufs
Message-ID: <20240322000304.76810-4-thalia@archibald.dev>
In-Reply-To: <20240322000304.76810-1-thalia@archibald.dev>
References: <20240322000304.76810-1-thalia@archibald.dev>
Feedback-ID: 63908566:user:proton
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

These strbufs are owned. Release them at the end of their scopes.

Signed-off-by: Thalia Archibald <thalia@archibald.dev>
---
 builtin/fast-import.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 1b3d6784c1..d6f998f363 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -2364,6 +2364,7 @@ static void file_change_m(const char *p, struct branc=
h *b)
 =09/* Git does not track empty, non-toplevel directories. */
 =09if (S_ISDIR(mode) && is_empty_tree_oid(&oid) && *path.buf) {
 =09=09tree_content_remove(&b->branch_tree, path.buf, NULL, 0);
+=09=09strbuf_release(&path);
 =09=09return;
 =09}
=20
@@ -2409,11 +2410,11 @@ static void file_change_m(const char *p, struct bra=
nch *b)
 =09=09=09=09command_buf.buf);
 =09}
=20
-=09if (!*path.buf) {
+=09if (*path.buf)
+=09=09tree_content_set(&b->branch_tree, path.buf, &oid, mode, NULL);
+=09else
 =09=09tree_content_replace(&b->branch_tree, &oid, mode, NULL);
-=09=09return;
-=09}
-=09tree_content_set(&b->branch_tree, path.buf, &oid, mode, NULL);
+=09strbuf_release(&path);
 }
=20
 static void file_change_d(const char *p, struct branch *b)
@@ -2422,6 +2423,7 @@ static void file_change_d(const char *p, struct branc=
h *b)
=20
 =09parse_path_eol(&path, p, "path");
 =09tree_content_remove(&b->branch_tree, path.buf, NULL, 1);
+=09strbuf_release(&path);
 }
=20
 static void file_change_cr(const char *p, struct branch *b, int rename)
@@ -2440,17 +2442,18 @@ static void file_change_cr(const char *p, struct br=
anch *b, int rename)
 =09=09tree_content_get(&b->branch_tree, source.buf, &leaf, 1);
 =09if (!leaf.versions[1].mode)
 =09=09die("Path %s not in branch", source.buf);
-=09if (!*dest.buf) {=09/* C "path/to/subdir" "" */
+=09if (*dest.buf)
+=09=09tree_content_set(&b->branch_tree, dest.buf,
+=09=09=09&leaf.versions[1].oid,
+=09=09=09leaf.versions[1].mode,
+=09=09=09leaf.tree);
+=09else=09/* C "path/to/subdir" "" */
 =09=09tree_content_replace(&b->branch_tree,
 =09=09=09&leaf.versions[1].oid,
 =09=09=09leaf.versions[1].mode,
 =09=09=09leaf.tree);
-=09=09return;
-=09}
-=09tree_content_set(&b->branch_tree, dest.buf,
-=09=09&leaf.versions[1].oid,
-=09=09leaf.versions[1].mode,
-=09=09leaf.tree);
+=09strbuf_release(&source);
+=09strbuf_release(&dest);
 }
=20
 static void note_change_n(const char *p, struct branch *b, unsigned char *=
old_fanout)
@@ -2804,6 +2807,7 @@ static void parse_new_commit(const char *arg)
 =09free(author);
 =09free(committer);
 =09free(encoding);
+=09strbuf_release(&msg);
=20
 =09if (!store_object(OBJ_COMMIT, &new_data, NULL, &b->oid, next_mark))
 =09=09b->pack_id =3D pack_id;
@@ -2886,6 +2890,7 @@ static void parse_new_tag(const char *arg)
 =09strbuf_addch(&new_data, '\n');
 =09strbuf_addbuf(&new_data, &msg);
 =09free(tagger);
+=09strbuf_release(&msg);
=20
 =09if (store_object(OBJ_TAG, &new_data, NULL, &t->oid, next_mark))
 =09=09t->pack_id =3D MAX_PACK_ID;
@@ -3171,6 +3176,7 @@ static void print_ls(int mode, const unsigned char *h=
ash, const char *path)
 =09=09strbuf_addch(&line, '\n');
 =09}
 =09cat_blob_write(line.buf, line.len);
+=09strbuf_release(&line);
 }
=20
 static void parse_ls(const char *p, struct branch *b)
@@ -3206,6 +3212,7 @@ static void parse_ls(const char *p, struct branch *b)
 =09=09release_tree_content_recursive(leaf.tree);
 =09if (!b || root !=3D &b->branch_tree)
 =09=09release_tree_entry(root);
+=09strbuf_release(&path);
 }
=20
 static void checkpoint(void)
--=20
2.44.0


