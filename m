Received: from mail-4018.proton.ch (mail-4018.proton.ch [185.70.40.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9105158D94
	for <git@vger.kernel.org>; Wed, 10 Apr 2024 09:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712742982; cv=none; b=Mnxd3DRRZ90200RJkF7SRkHjhY5HsWXBORxLFqF9AX4nC9Syrw2WyOroTn9I8exQ21rSvi7RaSTlC3Wm+7+qNa9m6bwDvx97ge+k4CDJbSvxoHvhJ+Y0M6YX+fxxb83N76tLDnvd4/FhlglVk6waZexYruVk1bFsj5tgpE6WllA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712742982; c=relaxed/simple;
	bh=+LufLcEgng0g1Pf9BgXypzSiKEFDVMHT56tRVC5bFlQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S8QEiZkPJMQ2a8KuO2wm92nLZD087st61dqzw0+tncVOv1cU3Z1iQFsY/pwM3rm5bWx1m+nlu5/eSoxNqz9zMEcBBDohbU8zr+xUHoU2WW1L0IVEM96mebNQdko2I9uL1qwHTjXUI9vnJZzzR5haJko96rPwajROP0JEyIdWYNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archibald.dev; spf=pass smtp.mailfrom=archibald.dev; dkim=pass (2048-bit key) header.d=archibald.dev header.i=@archibald.dev header.b=q3pNdLSp; arc=none smtp.client-ip=185.70.40.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archibald.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=archibald.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=archibald.dev header.i=@archibald.dev header.b="q3pNdLSp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archibald.dev;
	s=protonmail3; t=1712742978; x=1713002178;
	bh=t/Vw+eoaj23wlDUu558gUEWe1Jb3JRPb2OFpWlIEVa8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=q3pNdLSpXbTGOH2a0RpeyVNwufRYnO7soegmjyDcgoYK7td4QKZbKE6LKCkAwnPqB
	 Xv3qQUTAdA4ftHhStsBLdx5Nkc5cQOHpOFjazN2lV7qI+6QX4Xwax3uJiVtY/sSm8M
	 36H9vjg7bGLUaCh/J4Av0PgesC5K+uXS2INKhLPv+9Lqk4mucD03GmDQEzjfQVccD0
	 qKJNkfCOjBbSiJhmuzYhpe4TxOAQIsZNtjwWvMiEivmHtByiZkd+4HYgNi4th8uDc8
	 kBjjI1x+JodxGFa2pzrrP2H5w2AuDm7kN1en+R6VMu0+5ZIhkmE2KaR5xH3Zm5mxJn
	 h6Zs9v6U6ZITg==
Date: Wed, 10 Apr 2024 09:56:11 +0000
To: git@vger.kernel.org
From: Thalia Archibald <thalia@archibald.dev>
Cc: Patrick Steinhardt <ps@pks.im>, Chris Torek <chris.torek@gmail.com>, Elijah Newren <newren@gmail.com>, Thalia Archibald <thalia@archibald.dev>
Subject: [PATCH v3 7/8] fast-import: forbid escaped NUL in paths
Message-ID: <dc67464b6aec46c5b6ac0d9cb8549d48a35c5353.1712741871.git.thalia@archibald.dev>
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

NUL cannot appear in paths. Even disregarding filesystem path
limitations, the tree object format delimits with NUL, so such a path
cannot be encoded by Git.

When a quoted path is unquoted, it could possibly contain NUL from
"\000". Forbid it so it isn't truncated.

fast-import still has other issues with NUL, but those will be addressed
later.

Signed-off-by: Thalia Archibald <thalia@archibald.dev>
---
 Documentation/git-fast-import.txt | 1 +
 builtin/fast-import.c             | 2 ++
 t/t9300-fast-import.sh            | 1 +
 3 files changed, 4 insertions(+)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-imp=
ort.txt
index db53b50268..edda30f90c 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -660,6 +660,7 @@ and must be in canonical form. That is it must not:
=20
 The root of the tree can be represented by an empty string as `<path>`.
=20
+`<path>` cannot contain NUL, either literally or escaped as `\000`.
 It is recommended that `<path>` always be encoded using UTF-8.
=20
 `filedelete`
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 7a398dc975..98096b6fa7 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -2269,6 +2269,8 @@ static void parse_path(struct strbuf *sb, const char =
*p, const char **endp,
 =09if (*p =3D=3D '"') {
 =09=09if (unquote_c_style(sb, p, endp))
 =09=09=09die("Invalid %s: %s", field, command_buf.buf);
+=09=09if (strlen(sb->buf) !=3D sb->len)
+=09=09=09die("NUL in %s: %s", field, command_buf.buf);
 =09} else {
 =09=09if (include_spaces)
 =09=09=09*endp =3D p + strlen(p);
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 5cde8f8d01..1e68426852 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -3300,6 +3300,7 @@ test_path_base_fail () {
 =09local change=3D"$1" prefix=3D"$2" field=3D"$3" suffix=3D"$4"
 =09test_path_fail "$change" 'unclosed " in '"$field"          "$prefix" '"=
hello.c'    "$suffix" "Invalid $field"
 =09test_path_fail "$change" "invalid escape in quoted $field" "$prefix" '"=
hello\xff"' "$suffix" "Invalid $field"
+=09test_path_fail "$change" "escaped NUL in quoted $field"    "$prefix" '"=
hello\000"' "$suffix" "NUL in $field"
 }
 test_path_eol_quoted_fail () {
 =09local change=3D"$1" prefix=3D"$2" field=3D"$3"
--=20
2.44.0


