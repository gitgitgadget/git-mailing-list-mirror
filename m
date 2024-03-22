Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE812F46
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 00:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.77.79.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711065833; cv=none; b=MdmfWZ6k/DW9FFm3bsueDLXNIWHuNeoQPkR3DpEHzCQlIzYaa0YEhW1Gp0fhU4TsXq9+hvaxVJLCbfHuKSXxqI/dmNKN8jhJJFuokRSFE1HIUXHa3M81k3UeXZXGDh/qdMZiURYLEPTapUnSOYS1eYfD4GYLFa3Tr1v9cdZwf3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711065833; c=relaxed/simple;
	bh=guTgMK5fn+GJSbO9d3qPZucMKBTloDk8TIpL4ZNO34k=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YBQiOqssV7CezfqXrG8oO1sblRuDQsYLkmcm5JwcQPusvEp3ojhVUkVuW+0cNc3oKKdKVIK30DfirfGmdHxOgwwyCdFAoYfvlRG7UOu16DcYwIrHdgWUR3U6WMWovwVCfxuyUdQamTicifZgjZ1w/FVGH2Jxm9NDN4SR+WJ7vJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archibald.dev; spf=pass smtp.mailfrom=archibald.dev; dkim=pass (2048-bit key) header.d=archibald.dev header.i=@archibald.dev header.b=Bc94Rupy; arc=none smtp.client-ip=51.77.79.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archibald.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=archibald.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=archibald.dev header.i=@archibald.dev header.b="Bc94Rupy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archibald.dev;
	s=protonmail3; t=1711065822; x=1711325022;
	bh=Oenh1LklGYfd/Ee/HzkxO6i7XQEo05IcD9zsRgYPeT0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Bc94Rupyi+SN6fhmpLlYU8+PMfkMUNVrtCnFrEMs8vemSboamHy2TTc56Arf8S9ds
	 HKkRIb2x3wCWUOyp3Sg5vUfHvFs2RpwQ9vsKxdfqzqBaSKA9uS8aWR/l2XDfpJ+SKP
	 GwPkGsBjX6jAg7O30Sx+NJlnrRyvp2SyuZogX1JQk126XgTfxrGChCh+2wwAUD9ldk
	 wARmIDZMEdeihhdBomjMWq/MT9deU6UbpaC436zct5DzZbixhUtZao1y7AIFj1ud3p
	 roi0Ms4JoX616tKhbHNKYFU2mwtsF0LXjJwjem9AUz5BwojAaYZn4XVqp84NRNAaaC
	 +TNJ1xBKg+25g==
Date: Fri, 22 Mar 2024 00:03:25 +0000
To: git@vger.kernel.org
From: Thalia Archibald <thalia@archibald.dev>
Cc: Elijah Newren <newren@gmail.com>, Thalia Archibald <thalia@archibald.dev>
Subject: [PATCH 2/6] fast-import: directly use strbufs for paths
Message-ID: <20240322000304.76810-3-thalia@archibald.dev>
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

Previously, one case would not write the path to the strbuf: when the
path is unquoted and at the end of the string. It was essentially
copy-on-write. However, with the logic simplification of the previous
commit, this case was eliminated and the strbuf is always populated.

Directly use the strbufs now instead of an alias.

Since this already changes all the lines that use the strbufs, rename
them from `uq` to be more descriptive. That they are unquoted is not
their most important property, so name them after what they carry.

Additionally, `file_change_m` no longer needs to copy the path before
reading inline data.

Signed-off-by: Thalia Archibald <thalia@archibald.dev>
---
 builtin/fast-import.c | 54 ++++++++++++++++++-------------------------
 1 file changed, 22 insertions(+), 32 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index b2adec8d9a..1b3d6784c1 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -2322,7 +2322,7 @@ static void parse_path_space(struct strbuf *sb, const=
 char *p, const char **endp
=20
 static void file_change_m(const char *p, struct branch *b)
 {
-=09static struct strbuf uq =3D STRBUF_INIT;
+=09static struct strbuf path =3D STRBUF_INIT;
 =09struct object_entry *oe;
 =09struct object_id oid;
 =09uint16_t mode, inline_data =3D 0;
@@ -2359,12 +2359,11 @@ static void file_change_m(const char *p, struct bra=
nch *b)
 =09=09=09die("Missing space after SHA1: %s", command_buf.buf);
 =09}
=20
-=09parse_path_eol(&uq, p, "path");
-=09p =3D uq.buf;
+=09parse_path_eol(&path, p, "path");
=20
 =09/* Git does not track empty, non-toplevel directories. */
-=09if (S_ISDIR(mode) && is_empty_tree_oid(&oid) && *p) {
-=09=09tree_content_remove(&b->branch_tree, p, NULL, 0);
+=09if (S_ISDIR(mode) && is_empty_tree_oid(&oid) && *path.buf) {
+=09=09tree_content_remove(&b->branch_tree, path.buf, NULL, 0);
 =09=09return;
 =09}
=20
@@ -2385,10 +2384,6 @@ static void file_change_m(const char *p, struct bran=
ch *b)
 =09=09if (S_ISDIR(mode))
 =09=09=09die("Directories cannot be specified 'inline': %s",
 =09=09=09=09command_buf.buf);
-=09=09if (p !=3D uq.buf) {
-=09=09=09strbuf_addstr(&uq, p);
-=09=09=09p =3D uq.buf;
-=09=09}
 =09=09while (read_next_command() !=3D EOF) {
 =09=09=09const char *v;
 =09=09=09if (skip_prefix(command_buf.buf, "cat-blob ", &v))
@@ -2414,49 +2409,45 @@ static void file_change_m(const char *p, struct bra=
nch *b)
 =09=09=09=09command_buf.buf);
 =09}
=20
-=09if (!*p) {
+=09if (!*path.buf) {
 =09=09tree_content_replace(&b->branch_tree, &oid, mode, NULL);
 =09=09return;
 =09}
-=09tree_content_set(&b->branch_tree, p, &oid, mode, NULL);
+=09tree_content_set(&b->branch_tree, path.buf, &oid, mode, NULL);
 }
=20
 static void file_change_d(const char *p, struct branch *b)
 {
-=09static struct strbuf uq =3D STRBUF_INIT;
+=09static struct strbuf path =3D STRBUF_INIT;
=20
-=09parse_path_eol(&uq, p, "path");
-=09p =3D uq.buf;
-=09tree_content_remove(&b->branch_tree, p, NULL, 1);
+=09parse_path_eol(&path, p, "path");
+=09tree_content_remove(&b->branch_tree, path.buf, NULL, 1);
 }
=20
 static void file_change_cr(const char *p, struct branch *b, int rename)
 {
-=09const char *s, *d;
-=09static struct strbuf s_uq =3D STRBUF_INIT;
-=09static struct strbuf d_uq =3D STRBUF_INIT;
+=09static struct strbuf source =3D STRBUF_INIT;
+=09static struct strbuf dest =3D STRBUF_INIT;
 =09struct tree_entry leaf;
=20
-=09parse_path_space(&s_uq, p, &p, "source");
-=09parse_path_eol(&d_uq, p, "dest");
-=09s =3D s_uq.buf;
-=09d =3D d_uq.buf;
+=09parse_path_space(&source, p, &p, "source");
+=09parse_path_eol(&dest, p, "dest");
=20
 =09memset(&leaf, 0, sizeof(leaf));
 =09if (rename)
-=09=09tree_content_remove(&b->branch_tree, s, &leaf, 1);
+=09=09tree_content_remove(&b->branch_tree, source.buf, &leaf, 1);
 =09else
-=09=09tree_content_get(&b->branch_tree, s, &leaf, 1);
+=09=09tree_content_get(&b->branch_tree, source.buf, &leaf, 1);
 =09if (!leaf.versions[1].mode)
-=09=09die("Path %s not in branch", s);
-=09if (!*d) {=09/* C "path/to/subdir" "" */
+=09=09die("Path %s not in branch", source.buf);
+=09if (!*dest.buf) {=09/* C "path/to/subdir" "" */
 =09=09tree_content_replace(&b->branch_tree,
 =09=09=09&leaf.versions[1].oid,
 =09=09=09leaf.versions[1].mode,
 =09=09=09leaf.tree);
 =09=09return;
 =09}
-=09tree_content_set(&b->branch_tree, d,
+=09tree_content_set(&b->branch_tree, dest.buf,
 =09=09&leaf.versions[1].oid,
 =09=09leaf.versions[1].mode,
 =09=09leaf.tree);
@@ -3186,7 +3177,7 @@ static void parse_ls(const char *p, struct branch *b)
 {
 =09struct tree_entry *root =3D NULL;
 =09struct tree_entry leaf =3D {NULL};
-=09static struct strbuf uq =3D STRBUF_INIT;
+=09static struct strbuf path =3D STRBUF_INIT;
=20
 =09/* ls SP (<tree-ish> SP)? <path> */
 =09if (*p =3D=3D '"') {
@@ -3201,9 +3192,8 @@ static void parse_ls(const char *p, struct branch *b)
 =09=09=09root->versions[1].mode =3D S_IFDIR;
 =09=09load_tree(root);
 =09}
-=09parse_path_eol(&uq, p, "path");
-=09p =3D uq.buf;
-=09tree_content_get(root, p, &leaf, 1);
+=09parse_path_eol(&path, p, "path");
+=09tree_content_get(root, path.buf, &leaf, 1);
 =09/*
 =09 * A directory in preparation would have a sha1 of zero
 =09 * until it is saved.  Save, for simplicity.
@@ -3211,7 +3201,7 @@ static void parse_ls(const char *p, struct branch *b)
 =09if (S_ISDIR(leaf.versions[1].mode))
 =09=09store_tree(&leaf);
=20
-=09print_ls(leaf.versions[1].mode, leaf.versions[1].oid.hash, p);
+=09print_ls(leaf.versions[1].mode, leaf.versions[1].oid.hash, path.buf);
 =09if (leaf.tree)
 =09=09release_tree_content_recursive(leaf.tree);
 =09if (!b || root !=3D &b->branch_tree)
--=20
2.44.0


