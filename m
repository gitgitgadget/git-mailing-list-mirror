Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48078BE8
	for <git@vger.kernel.org>; Wed, 10 Apr 2024 09:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712742942; cv=none; b=qTMHW9nIqfbMPWYHkkeiukWQoiEuxv7J0J1G64o6yvH7nfYGl2A9rV+VLPsdTPIIFFF2qujLD2RkHWlQY0u4bYsVsVhLWCXvjnY6fP4QEPZNjNtQH/rEFp+/urOWDrzWGWI+6I0CJkojdMYbd1GedCBJ3mlj86fg6ghhg7N0o84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712742942; c=relaxed/simple;
	bh=pxxmm3bxzfAIUPV62gpv+wcSDBxWNsruE3jxTSTps7A=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UHN8a6PPPdlQJEamVdLy1E1pRP1/LLIsoFFG5dZGpkUTOLAzcLJFQonjTS29RF+y+ERlpMIgAD+JQRUxdkx63r1YDwbhljreRlguiEnYt7KOVozOHQJnA4iUQ/5jgaJnzZzm2Rp0l8T9YKaf0A1oIfmWRN8S21VGEsa5SNGxz4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archibald.dev; spf=pass smtp.mailfrom=archibald.dev; dkim=pass (2048-bit key) header.d=archibald.dev header.i=@archibald.dev header.b=QDYoXxEj; arc=none smtp.client-ip=185.70.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archibald.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=archibald.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=archibald.dev header.i=@archibald.dev header.b="QDYoXxEj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archibald.dev;
	s=protonmail3; t=1712742938; x=1713002138;
	bh=hw2+b6jOE4r+yZIuG8JyvaP6l6clOcSN3si1R7o3CPs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=QDYoXxEjeXbtUHRSshG14xa2I/bHvhpbE1Ee9YSuvq/ZlgpNgBvTeWpQ8616ZZQia
	 Q2ZtdJz8mpDsuqgEUx/rbdMHOhY0Z6eliGsNyLiVA5pLIBwhtNcjo5z8xh2R4lQj6R
	 2Bow62Ku7IZwM5Y/QQUb178LDcZeYoyT4flEktzRxF3mXj35qAGlFHV99s5epytmJy
	 OjYoPQu7KdzhU7yuG7cHGBSUv8brPMu+Gv0XbttnpB0/DlWzONuroX9yOog7Sz7xKz
	 g+OdtKYwVVA5QgYFpH9L6bPwHMx6ZlupKQnOFI4o7U+hjIvUsPrQmqFN2LyTrXOzV1
	 ixK7ovMSlL2bQ==
Date: Wed, 10 Apr 2024 09:55:33 +0000
To: git@vger.kernel.org
From: Thalia Archibald <thalia@archibald.dev>
Cc: Patrick Steinhardt <ps@pks.im>, Chris Torek <chris.torek@gmail.com>, Elijah Newren <newren@gmail.com>, Thalia Archibald <thalia@archibald.dev>
Subject: [PATCH v3 2/8] fast-import: directly use strbufs for paths
Message-ID: <696ca27bb7267d7c881cb18eb74473ebf271bb5c.1712741871.git.thalia@archibald.dev>
In-Reply-To: <cover.1712741870.git.thalia@archibald.dev>
References: <20240322000304.76810-1-thalia@archibald.dev> <cover.1711960552.git.thalia@archibald.dev> <cover.1712741870.git.thalia@archibald.dev>
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
 builtin/fast-import.c | 64 ++++++++++++++++++-------------------------
 1 file changed, 27 insertions(+), 37 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index ce9231afe6..8f6312fbaf 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -2307,7 +2307,7 @@ static void parse_path_space(struct strbuf *sb, const=
 char *p,
=20
 static void file_change_m(const char *p, struct branch *b)
 {
-=09static struct strbuf uq =3D STRBUF_INIT;
+=09static struct strbuf path =3D STRBUF_INIT;
 =09struct object_entry *oe;
 =09struct object_id oid;
 =09uint16_t mode, inline_data =3D 0;
@@ -2344,13 +2344,12 @@ static void file_change_m(const char *p, struct bra=
nch *b)
 =09=09=09die("Missing space after SHA1: %s", command_buf.buf);
 =09}
=20
-=09strbuf_reset(&uq);
-=09parse_path_eol(&uq, p, "path");
-=09p =3D uq.buf;
+=09strbuf_reset(&path);
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
@@ -2371,10 +2370,6 @@ static void file_change_m(const char *p, struct bran=
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
@@ -2400,55 +2395,51 @@ static void file_change_m(const char *p, struct bra=
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
-=09strbuf_reset(&uq);
-=09parse_path_eol(&uq, p, "path");
-=09p =3D uq.buf;
-=09tree_content_remove(&b->branch_tree, p, NULL, 1);
+=09strbuf_reset(&path);
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
-=09strbuf_reset(&s_uq);
-=09parse_path_space(&s_uq, p, &p, "source");
-=09s =3D s_uq.buf;
+=09strbuf_reset(&source);
+=09parse_path_space(&source, p, &p, "source");
=20
 =09if (!*p)
 =09=09die("Missing dest: %s", command_buf.buf);
-=09strbuf_reset(&d_uq);
-=09parse_path_eol(&d_uq, p, "dest");
-=09d =3D d_uq.buf;
+=09strbuf_reset(&dest);
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
@@ -3176,7 +3167,7 @@ static void print_ls(int mode, const unsigned char *h=
ash, const char *path)
=20
 static void parse_ls(const char *p, struct branch *b)
 {
-=09static struct strbuf uq =3D STRBUF_INIT;
+=09static struct strbuf path =3D STRBUF_INIT;
 =09struct tree_entry *root =3D NULL;
 =09struct tree_entry leaf =3D {NULL};
=20
@@ -3193,10 +3184,9 @@ static void parse_ls(const char *p, struct branch *b=
)
 =09=09=09root->versions[1].mode =3D S_IFDIR;
 =09=09load_tree(root);
 =09}
-=09strbuf_reset(&uq);
-=09parse_path_eol(&uq, p, "path");
-=09p =3D uq.buf;
-=09tree_content_get(root, p, &leaf, 1);
+=09strbuf_reset(&path);
+=09parse_path_eol(&path, p, "path");
+=09tree_content_get(root, path.buf, &leaf, 1);
 =09/*
 =09 * A directory in preparation would have a sha1 of zero
 =09 * until it is saved.  Save, for simplicity.
@@ -3204,7 +3194,7 @@ static void parse_ls(const char *p, struct branch *b)
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


