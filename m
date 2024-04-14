Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D5E1BC3E
	for <git@vger.kernel.org>; Sun, 14 Apr 2024 01:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713057147; cv=none; b=Up+1/tZ5WSHRykjwbmsCwfFHyIAWSSM02vS3t9WXTJv+43XDoEwBtz4+iMijCnLzGYIcqjLEwBR2JJzi2xkqb94vw8BYIxkfV2YwaM0vOAUkLa97ExMmmHeqRADbt0j4+uZ4hAjaLEFhrUhbuOfU3q6d4Aj2KJpdyI+49nt9zDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713057147; c=relaxed/simple;
	bh=eEO7L6LPpwSQmJ/GBRArpAQ2SBayePRKI+lqqWOrtv4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j0mbUxmzEGxMWQTwAlQEuXPpFfpk5ADP1WSZFVTqRbwOUPimqYZbmebq4ESDUsPM6ime+UuxbDXjcXKnsU+qyvhGuEwcBATFF/IWAr3k6crq3aLP/vsYLuxY+4vYWHGf8QefjoorgfnzfAiEHEwiVBloclLBlGpHeIUYRQzKzP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archibald.dev; spf=pass smtp.mailfrom=archibald.dev; dkim=pass (2048-bit key) header.d=archibald.dev header.i=@archibald.dev header.b=SEIHAogf; arc=none smtp.client-ip=185.70.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archibald.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=archibald.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=archibald.dev header.i=@archibald.dev header.b="SEIHAogf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archibald.dev;
	s=protonmail3; t=1713057144; x=1713316344;
	bh=acPROlVBCuxc5/xLd4hN8INy3w41VO6OWG9uKJQTf9E=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=SEIHAogfzZJc/QsbI5PkpUv7xCkVMA+96Qm3m88RQusntz1YPoI0QS8m/yL8heGN/
	 2BwIyaYF+illTfXboBNC7ldTGYQGQd1/Ec+38YU22Fitut5TPwFVVY2w86D1oo3i3G
	 k2AvVwF6JvzgNjbKxfJkOYLECqcPJaI2bANFq0ik65fKcJFBQ67UNs/LkjsTvS0dbx
	 WF2m/gkOf3Mw4cNjPsMhl/1B8NopnA4ZCuH+T+euoS7oUUUeq2jEnyyPSaMVuv02un
	 FQIg7KE8d9LX+AIkGJsyj+6Mb8gDMO+Fxyi9G2uY/YB7mjHOEcmP8gDf3vn5vvmdbz
	 0+OWLs4iMIQHA==
Date: Sun, 14 Apr 2024 01:12:19 +0000
To: git@vger.kernel.org
From: Thalia Archibald <thalia@archibald.dev>
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, Chris Torek <chris.torek@gmail.com>, Elijah Newren <newren@gmail.com>, Thalia Archibald <thalia@archibald.dev>
Subject: [PATCH v5 7/8] fast-import: forbid escaped NUL in paths
Message-ID: <a01d0a1b25be19cb3b472a12a648ace5337648d4.1713056559.git.thalia@archibald.dev>
In-Reply-To: <cover.1713056559.git.thalia@archibald.dev>
References: <20240322000304.76810-1-thalia@archibald.dev> <cover.1711960552.git.thalia@archibald.dev> <cover.1712741870.git.thalia@archibald.dev> <cover.1712907684.git.thalia@archibald.dev> <cover.1713056559.git.thalia@archibald.dev>
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
index 832d0055f9..419ffdcdb5 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -2270,6 +2270,8 @@ static void parse_path(struct strbuf *sb, const char =
*p, const char **endp,
 =09if (*p =3D=3D '"') {
 =09=09if (unquote_c_style(sb, p, endp))
 =09=09=09die("Invalid %s: %s", field, command_buf.buf);
+=09=09if (strlen(sb->buf) !=3D sb->len)
+=09=09=09die("NUL in %s: %s", field, command_buf.buf);
 =09} else {
 =09=09/*
 =09=09 * Unless we are parsing the last field of a line,
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


