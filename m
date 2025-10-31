Received: from mail-05.mail-europe.com (mail-05.mail-europe.com [85.9.206.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FAC1E260C
	for <git@vger.kernel.org>; Fri, 31 Oct 2025 22:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.206.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761948049; cv=none; b=LVJ/E5y3MaWc55Do0N6pWggI3pJQ83Rf6HtnI7ZXdbFcT2t/i8hwazQEk2w3wQ6tLKTZ3OZpwV0JO5c0gUwmw+FKJft9y27lAkPjH2T2nXVBzO/ATC3HxTKU9txfDyHKtthkyj3+htcS64JdFYsy4EKT20UzKSaiMEX0vLE4FQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761948049; c=relaxed/simple;
	bh=WzVorsmuo72Yz+Q6etB24X5RfrdE19UE8Uai4mJVpOI=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=dJ0NneQHCRDtwbKYxxAnPkgL4aTchaid+H5Wc09d8oE42Bkp759lGAvLJWYGLIBRgTAqYC2KHkjU5ADWHCO4xQcPICnOvP/gwtrCQVl/WaZHOCb2LQ2gLNMne/aHccWvzAxqAksdWiEXUiKqfwWMRRTJZ+QUkqTko7DtfZp4eNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=DNQWtKGP; arc=none smtp.client-ip=85.9.206.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="DNQWtKGP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1761948031; x=1762207231;
	bh=WzVorsmuo72Yz+Q6etB24X5RfrdE19UE8Uai4mJVpOI=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=DNQWtKGP+pnuqsbOjHGPuT9zzc4ygzMb4/lTswusSzfBCQz9EwR9Pcw1VK80g0GFh
	 hXjxgMr0XiNh2nDhokZ14UAVw4XDmo5gtf4SvbrUWvX+G1yco1Huw6UbxVB4U7R3vB
	 XkqQccj+ET+jXRUpFASgNHpYICraxFkxW50cEutqxmF4vl5rE3W1ulcvT4DTgnGR32
	 DJhzaT0B7ve3+iBH72ZcOci6qDyani7S+xjHZwwZyJLc/F3nEKfclk4p0zWbZnv6zt
	 po6zmD7Vm0Mg67+ixhuqcjLg0CrahYd8A+6zpgvKS7r6KtuPwD+JBxg7GA3e1nfQxg
	 fkMkpI44bUqpA==
Date: Fri, 31 Oct 2025 22:00:27 +0000
To: "git@vger.kernel.org" <git@vger.kernel.org>
From: keita <rudykeita@proton.me>
Cc: "outreachy@gitgitgadget.github.io" <outreachy@gitgitgadget.github.io>
Subject: [PATCH] fsck: use starts_with() in fsck_commit()
Message-ID: <q4heOh8stc94r_P5mX-tucCyqQ1JdGP2dJ9Dot3WTyDboRWsboWMAIoCQIXuyuRvNRmN5AGQYjhmAnjuxgOXNooUDjPAEEvKPc2k_DCDEtY=@proton.me>
Feedback-ID: 145215173:user:proton
X-Pm-Message-ID: d11b4512abb2aa71532ab6e36022fb531e7c7b58
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable




From 30136adebaffb97edacae2c58c4ea491e39e3f5b Mon Sep 17 00:00:00 2001From:=
 Songiso Cooper Lyambai <rudykeita@proton.me>
Date: Fri, 31 Oct 2025 23:45:23 +0200
Subject: [PATCH] fsck: use starts_with() in fsck_commit()

Replace manual buffer checks with starts_with() for safety and clarity.

This avoids buffer overreads and follows Git's idiomatic style used=C2=
=A0


Signed-off-by: Songiso Cooper Lyambai <rudykeita@proton.me>
---
=C2=A0fsck.c | 124 +++++++++++++++++++++++++++++++-------------------------=
-
=C2=A01 file changed, 67 insertions(+), 57 deletions(-)

diff --git a/fsck.c b/fsck.c
index 341e100d24..7172c4ff1c 100644
--- a/fsck.c
+++ b/fsck.c
@@ -921,67 +921,77 @@ static int fsck_ident(const char **ident,
=C2=A0}

=C2=A0static int fsck_commit(const struct object_id *oid,
- =C2=A0 =C2=A0 =C2=A0 const char *buffer, unsigned long size,
- =C2=A0 =C2=A0 =C2=A0 struct fsck_options *options)
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *buffer, unsi=
gned long size,
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct fsck_options *opt=
ions)
=C2=A0{
- struct object_id tree_oid, parent_oid;
- unsigned author_count;
- int err;
- const char *buffer_begin =3D buffer;
- const char *buffer_end =3D buffer + size;
- const char *p;
+ =C2=A0 =C2=A0struct object_id tree_oid, parent_oid;
+ =C2=A0 =C2=A0unsigned author_count =3D 0;
+ =C2=A0 =C2=A0int err =3D 0;
+ =C2=A0 =C2=A0const char *buffer_end =3D buffer + size;
+ =C2=A0 =C2=A0const char *p;

- /*
- * We _must_ stop parsing immediately if this reports failure, as the
- * memory safety of the rest of the function depends on it. See the
- * comment above the definition of verify_headers() for more details.
- */
- if (verify_headers(buffer, size, oid, OBJ_COMMIT, options))
- return -1;

- if (buffer >=3D buffer_end || !skip_prefix(buffer, "tree ", &buffer))
- return report(options, oid, OBJ_COMMIT, FSCK_MSG_MISSING_TREE, "invalid f=
ormat - expected 'tree' line");
- if (parse_oid_hex(buffer, &tree_oid, &p) || *p !=3D '\n') {
- err =3D report(options, oid, OBJ_COMMIT, FSCK_MSG_BAD_TREE_SHA1, "invalid=
 'tree' line format - bad sha1");
- if (err)
- return err;
- }
- buffer =3D p + 1;
- while (buffer < buffer_end && skip_prefix(buffer, "parent ", &buffer)) {
- if (parse_oid_hex(buffer, &parent_oid, &p) || *p !=3D '\n') {
- err =3D report(options, oid, OBJ_COMMIT, FSCK_MSG_BAD_PARENT_SHA1, "inval=
id 'parent' line format - bad sha1");
- if (err)
- return err;
- }
- buffer =3D p + 1;
- }
- author_count =3D 0;
- while (buffer < buffer_end && skip_prefix(buffer, "author ", &buffer)) {
- author_count++;
- err =3D fsck_ident(&buffer, oid, OBJ_COMMIT, options);
- if (err)
- return err;
- }
- if (author_count < 1)
- err =3D report(options, oid, OBJ_COMMIT, FSCK_MSG_MISSING_AUTHOR, "invali=
d format - expected 'author' line");
- else if (author_count > 1)
- err =3D report(options, oid, OBJ_COMMIT, FSCK_MSG_MULTIPLE_AUTHORS, "inva=
lid format - multiple 'author' lines");
- if (err)
- return err;
- if (buffer >=3D buffer_end || !skip_prefix(buffer, "committer ", &buffer)=
)
- return report(options, oid, OBJ_COMMIT, FSCK_MSG_MISSING_COMMITTER, "inva=
lid format - expected 'committer' line");
- err =3D fsck_ident(&buffer, oid, OBJ_COMMIT, options);
- if (err)
- return err;
- if (memchr(buffer_begin, '\0', size)) {
- err =3D report(options, oid, OBJ_COMMIT, FSCK_MSG_NUL_IN_COMMIT,
- =C2=A0 =C2=A0 "NUL byte in the commit object body");
- if (err)
- return err;
- }
- return 0;
+ /*
+ * We _must_ stop parsing immediately if this reports failure, as the
+ * memory safety of the rest of the function depends on it. See the
+ * comment above the definition of verify_headers() for more details.
+ */
+
+ =C2=A0 =C2=A0if (verify_headers(buffer, size, oid, OBJ_COMMIT, options))
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;
+
+ =C2=A0 =C2=A0
+ =C2=A0 =C2=A0if (!skip_prefix(buffer, "tree ", &buffer))
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0return report(options, oid, OBJ_COMMIT, FSCK_M=
SG_MISSING_TREE,
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"invalid fo=
rmat - expected 'tree' line");
+ =C2=A0 =C2=A0if (parse_oid_hex(buffer, &tree_oid, &p) || *p !=3D '\n') {
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0return report(options, oid, OBJ_COMMIT, FSCK_M=
SG_BAD_TREE_SHA1,
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"invalid 't=
ree' line format - bad sha1");
+ =C2=A0 =C2=A0}
+ =C2=A0 =C2=A0buffer =3D p + 1;
+
+ =C2=A0 =C2=A0while (starts_with(buffer, "parent ")) {
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!skip_prefix(buffer, "parent ", &buffer) |=
|
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0parse_oid_hex(buffer, &parent_oi=
d, &p) || *p !=3D '\n') {
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return report(options, oid, OBJ_=
COMMIT, FSCK_MSG_BAD_PARENT_SHA1,
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0"invalid 'parent' line format - bad sha1");
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0buffer =3D p + 1;
+ =C2=A0 =C2=A0}
+
+ =C2=A0 =C2=A0while (starts_with(buffer, "author ")) {
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0author_count++;
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!skip_prefix(buffer, "author ", &buffer))
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return report(options, oid, OBJ_=
COMMIT, FSCK_MSG_MISSING_AUTHOR,
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0"invalid format - expected 'author' line");
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((err =3D fsck_ident(&buffer, oid, OBJ_COMM=
IT, options)))
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return err;
+ =C2=A0 =C2=A0}
+
+ =C2=A0 =C2=A0if (author_count < 1)
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0return report(options, oid, OBJ_COMMIT, FSCK_M=
SG_MISSING_AUTHOR,
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"invalid fo=
rmat - expected 'author' line");
+ =C2=A0 =C2=A0if (author_count > 1)
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0return report(options, oid, OBJ_COMMIT, FSCK_M=
SG_MULTIPLE_AUTHORS,
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"invalid fo=
rmat - multiple 'author' lines");
+
+ =C2=A0 =C2=A0if (!starts_with(buffer, "committer "))
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0return report(options, oid, OBJ_COMMIT, FSCK_M=
SG_MISSING_COMMITTER,
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"invalid fo=
rmat - expected 'committer' line");
+
+ =C2=A0 =C2=A0if (!skip_prefix(buffer, "committer ", &buffer))
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0return report(options, oid, OBJ_COMMIT, FSCK_M=
SG_MISSING_COMMITTER,
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"invalid fo=
rmat - expected 'committer' line");
+
+ =C2=A0 =C2=A0if ((err =3D fsck_ident(&buffer, oid, OBJ_COMMIT, options)))
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0return err;
+
+ =C2=A0 =C2=A0if (memchr(buffer, '\0', buffer_end - buffer))
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0return report(options, oid, OBJ_COMMIT, FSCK_M=
SG_NUL_IN_COMMIT,
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"NUL byte i=
n the commit object body");
+
+ =C2=A0 =C2=A0return 0;
=C2=A0}
