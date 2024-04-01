Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F04DF4A
	for <git@vger.kernel.org>; Mon,  1 Apr 2024 09:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711962240; cv=none; b=Fnj1MVqTb1CvxTzv+OnHNGs8NtYCQZ0bZOVuU81uS/zKvYUlb7haute/gDl4RsMEy3+YyJwrd4xYg7GkaZgeenK6dcKasj0RFaAHvIqaFNnyPdirEMnR98xk113N+SK6tv4bEezn3wOmLV6FnNLDfdvwdJfP6kd7UopRUsT5R5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711962240; c=relaxed/simple;
	bh=7NsE98hYeiijkvMPS61sXwedLvFOZ9LzDmrEjWY8yHc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dXko50DZFw7ZtMW3QiUs0EudlXf7nWtuP5KW7zsoPlJPVBdoUZMSf+mTLdEdkAFr5Ex8LAd3eSeuq3W4tshBiNjz6xZmFlY2Kp118NnhTsxEUn1USMYlw8rGQDehOKrrzWwPVWNL2M03muU1Ho6L5DWdhyOvhy+0I+uRwBo6p+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archibald.dev; spf=pass smtp.mailfrom=archibald.dev; dkim=pass (2048-bit key) header.d=archibald.dev header.i=@archibald.dev header.b=qMkqa/dW; arc=none smtp.client-ip=185.70.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archibald.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=archibald.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=archibald.dev header.i=@archibald.dev header.b="qMkqa/dW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archibald.dev;
	s=protonmail3; t=1711962237; x=1712221437;
	bh=p9i5QU41goC8z573jarcFAXqwBkvjBExzLiu4phrKPk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=qMkqa/dWuzonxG5o0vcZn4vfoVoIqjDnBw0cC1gfgnyLSLMhosJTh8N1xN5Mo7rgg
	 86kOidOdmYksD+oVI70AzUFXIurC8l4ucWuPye1T/dEvPp5gG3rcLcn6WhbI3kNytT
	 qIVulqNstRl1P8/PPQusCeXALDWSIUL9+q9CeC2ZzflK1KCFQzRfM3FUSkgOoSEpjk
	 ptNjQhDM7QjRuQG2nrtt90wwWO6YGAQJf59CxeDKuflcSAH97vrXHFLL0LxV+c0sO2
	 I0XRhW8HXozYDKhbLxZY1TlsHuOqL5ipjtc8L4ThopFb1L4OuiGZ/XXD9ZDhLKSIcK
	 g4xwYSpDUCUvQ==
Date: Mon, 01 Apr 2024 09:03:50 +0000
To: git@vger.kernel.org
From: Thalia Archibald <thalia@archibald.dev>
Cc: Patrick Steinhardt <ps@pks.im>, Elijah Newren <newren@gmail.com>, Thalia Archibald <thalia@archibald.dev>
Subject: [PATCH v2 7/8] fast-import: forbid escaped NUL in paths
Message-ID: <c087c6a8604ddcbda5f09bb41fb9d7e746ed9c55.1711960552.git.thalia@archibald.dev>
In-Reply-To: <cover.1711960552.git.thalia@archibald.dev>
References: <20240322000304.76810-1-thalia@archibald.dev> <cover.1711960552.git.thalia@archibald.dev>
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
index fc6eeaf89c..9d0f53fe04 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -2268,6 +2268,8 @@ static void parse_path(struct strbuf *sb, const char =
*p, const char **endp, int
 =09if (*p =3D=3D '"') {
 =09=09if (unquote_c_style(sb, p, endp))
 =09=09=09die("Invalid %s: %s", field, command_buf.buf);
+=09=09if (strlen(sb->buf) !=3D sb->len)
+=09=09=09die("NUL in %s: %s", field, command_buf.buf);
 =09} else {
 =09=09if (include_spaces)
 =09=09=09*endp =3D p + strlen(p);
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index e10962dffe..794a96df38 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -3294,6 +3294,7 @@ test_path_base_fail () {
 =09local change=3D"$1" prefix=3D"$2" field=3D"$3" suffix=3D"$4"
 =09test_path_fail "$change" 'unclosed " in '"$field"          "$prefix" '"=
hello.c'    "$suffix" "Invalid $field"
 =09test_path_fail "$change" "invalid escape in quoted $field" "$prefix" '"=
hello\xff"' "$suffix" "Invalid $field"
+=09test_path_fail "$change" "escaped NUL in quoted $field"    "$prefix" '"=
hello\000"' "$suffix" "NUL in $field"
 }
 test_path_eol_quoted_fail () {
 =09local change=3D"$1" prefix=3D"$2" field=3D"$3" suffix=3D"$4"
--=20
2.44.0


