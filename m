Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6526FA7
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 00:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711065854; cv=none; b=BRnR49vF1QApRI844nkWnp4AH/ES96Hfm34GN8J0NuNuVIwrD5EFG221601KjxUC4wuqDh99UCQZ+Jfh5nj4jnAgjWZvydB/ZPB2ZQH26PFUpnN1Aqc+5gxaJn81v8zu+1aA8sm9g1Tv6L94bVtXCRk70VWAVG1b+aiW+S6I4k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711065854; c=relaxed/simple;
	bh=Cdxjvkcvts9GRDS6Mn5tch/ecFZG2SziGfTPEUMhQYE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bVqpmlNdXZmSfCK7oAuJwQib7zI8MXkAaiG4jhRBNE9x190+CHDMs7LLHzxoprYzjnOJTprxNtYiQSwgMRpKzU3lDi+e0S5E1rQpMT/vKi37E1qznCGbc66As0deLBO0AhqxZpxJ/e2u3BNFOd8NEVFV5jwtF0pnwzB54VYeHaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archibald.dev; spf=pass smtp.mailfrom=archibald.dev; dkim=pass (2048-bit key) header.d=archibald.dev header.i=@archibald.dev header.b=qXMFPeHd; arc=none smtp.client-ip=185.70.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archibald.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=archibald.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=archibald.dev header.i=@archibald.dev header.b="qXMFPeHd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archibald.dev;
	s=protonmail3; t=1711065847; x=1711325047;
	bh=lnr5Yo35SRcJxBK8Gpcc0T08RtF1yx9dss8eTsKgAdo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=qXMFPeHdTXWfFoWgu56WPFHiCTRY36Znl8LkllwS+Bdp200T2NQC3QfFGl3KCeAuN
	 4JhADnWAg3225cmx3B1H0l9+o3LwoJetv129Z8SKQgl3g4UElE9wq9MTj94yUJVyG/
	 9UaeEieFho4/v1XUG+j/xyiY5IQdz87piXmm9+Iw4VkzGbwfreBWGHDsw0gCAvr89S
	 DqFfosSDUhFUNr3cW0+KVhQzJrDC3AyUGTe0ylvjiGhQSOr3KPRtcHrCq1WyCc0AH+
	 /dSyXxUGirDDWGj1I9KxTRvorkwMMPFDPm0OGYuzRR7uiEe4PUUk+Va/Wx7u9OlkC3
	 lD/1Duf6HVpAw==
Date: Fri, 22 Mar 2024 00:03:55 +0000
To: git@vger.kernel.org
From: Thalia Archibald <thalia@archibald.dev>
Cc: Elijah Newren <newren@gmail.com>, Thalia Archibald <thalia@archibald.dev>
Subject: [PATCH 6/6] fast-import: forbid escaped NUL in paths
Message-ID: <20240322000304.76810-7-thalia@archibald.dev>
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
index 4aa8ccbefd..411413e8c3 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -657,6 +657,7 @@ and must be in canonical form. That is it must not:
 The root of the tree can be represented by a quoted empty string (`""`)
 as `<path>`.
=20
+`<path>` cannot contain NUL, either literally or escaped as `\000`.
 It is recommended that `<path>` always be encoded using UTF-8.
=20
 `filedelete`
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index ae8494d0ac..e36f59084e 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -2283,6 +2283,8 @@ static void parse_path(struct strbuf *sb, const char =
*p, const char **endp, int
 =09if (*p =3D=3D '"') {
 =09=09if (unquote_c_style(sb, p, endp))
 =09=09=09die("Invalid %s: %s", field, command_buf.buf);
+=09=09if (strlen(sb->buf) !=3D sb->len)
+=09=09=09die("NUL in %s: %s", field, command_buf.buf);
 =09} else {
 =09=09if (allow_spaces)
 =09=09=09*endp =3D p + strlen(p);
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index ef04b43f46..994a80e442 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -3285,6 +3285,7 @@ test_path_fail () {
 test_path_base_fail () {
 =09test_path_fail 'unclosed " in '"$field"          '"hello.c'    "Invalid=
 $field"
 =09test_path_fail "invalid escape in quoted $field" '"hello\xff"' "Invalid=
 $field"
+=09test_path_fail "escaped NUL in quoted $field"    '"hello\000"' "NUL in =
$field"
 }
 test_path_eol_quoted_fail () {
 =09test_path_base_fail
--=20
2.44.0


