Received: from mail-4018.proton.ch (mail-4018.proton.ch [185.70.40.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338C44F613
	for <git@vger.kernel.org>; Fri, 12 Apr 2024 08:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712909046; cv=none; b=GUtuF/LB2wypwuO28f0eckPW90SfSnCFHAAXUlJxYTBPw3mil+0LkIJUIXhDOGXA5Xche79y0327LntRoPJMKztfMrkKGp57IrJgWXoV1g+qGaY4NN6Tj+LtKLR1sGFZmdKXrolCIjBgqx5h1ruyVXhZ7rDt+PpSc/OmKABHlIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712909046; c=relaxed/simple;
	bh=k+pLT4PIYqviTDyYAphQAwEACvBr1m+hE52S9ZgE7Mg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BizQZEZi8JWvmF2QBgizs7DmyAkepVoEAVeITWlQFHc8lJZLqsUiTCkQbPIfclMtu5jODY5PGchhEoywtXFg6U3d3zCOoMdZSFxC18fG36iZP3iMTEoRVZfvJSEPVtW9c/dwkak3qbMsN++PAJT71BuVAaf6Y9qIBanv3OO/LTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archibald.dev; spf=pass smtp.mailfrom=archibald.dev; dkim=pass (2048-bit key) header.d=archibald.dev header.i=@archibald.dev header.b=HRjixYZ4; arc=none smtp.client-ip=185.70.40.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archibald.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=archibald.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=archibald.dev header.i=@archibald.dev header.b="HRjixYZ4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archibald.dev;
	s=protonmail3; t=1712909032; x=1713168232;
	bh=Wjx0/vNzkEA8Dge4sHLHtIbHEcUPnEm25eCrjqldGkQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=HRjixYZ4/sGewhdKvEsLKZ8F8PhjLU0qafI9n9RlB7DG0/Cip+QaYHuLlONH9O7Qe
	 mmK04cpfJxpfoamcqlf1U7LFcYkKwTpI9Dmn12lump8bG4bU4isgFmzdXOKKvnSo4E
	 kCDe2+I9ifOqbZE1DDqzBWiH30tyN/SZE+9aRXmNUhrUDRzeuYMSORN4F16JXzCRrd
	 X3gUB4400gWabnmE0gqoieu/k6v/CluQDuArjBUlofHTpe1U7zO+deh12slFL0sRel
	 cvvfLp161Vzu98ACtlWtDJxk5q4cHVUTtK58VmLOzRLBbfPFRn4m/u0fG1BCHghYwA
	 dwOI2+ddmK5AA==
Date: Fri, 12 Apr 2024 08:03:47 +0000
To: git@vger.kernel.org
From: Thalia Archibald <thalia@archibald.dev>
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, Chris Torek <chris.torek@gmail.com>, Elijah Newren <newren@gmail.com>, Thalia Archibald <thalia@archibald.dev>
Subject: [PATCH v4 7/8] fast-import: forbid escaped NUL in paths
Message-ID: <5b464f4b014760d0d9ca3413dacaa7e48f22291f.1712907684.git.thalia@archibald.dev>
In-Reply-To: <cover.1712907684.git.thalia@archibald.dev>
References: <20240322000304.76810-1-thalia@archibald.dev> <cover.1711960552.git.thalia@archibald.dev> <cover.1712741870.git.thalia@archibald.dev> <cover.1712907684.git.thalia@archibald.dev>
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
index c6082c3b49..8b6dde45f1 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -661,6 +661,7 @@ and its value must be in canonical form. That is it mus=
t not:
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


