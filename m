Received: from mail-40136.proton.ch (mail-40136.proton.ch [185.70.40.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB37DDDB8
	for <git@vger.kernel.org>; Sun, 14 Apr 2024 01:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713057103; cv=none; b=PaF+j0b2wl7giK/f44j6LFpjNORRZBvzOYEEM0/30HWLDgCSBgRoF3KQvIWrLr50Q6YxWvY8GuwM+a97H5dgAQEb+C+BhE8MS226Ypu331pEXNtroYEc1QFCD8+tpHZYBMeQaERc8eTKu1IdRg1dhGvEXLRiXswS4xqTqYKeoC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713057103; c=relaxed/simple;
	bh=sSij8iuiqqYU7E37FgUizkBVKzS1O/LGP5srry0ispA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u5IvaSkJeALqGXoJA6WdnGQuxMou2xyGDGcQcWV5fZjySqm2vQnaNt9PFSRus49Pbs8TdJL0H8rv0hElWw5O6UMKNmwTJ1Tq7nk/pgU9NLcZJUSpj59p+8gHUJU7QhTXN0OnbZrGD7MEuhHYOgFzRwBbKTTAjWpuyelDgrohWMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archibald.dev; spf=pass smtp.mailfrom=archibald.dev; dkim=pass (2048-bit key) header.d=archibald.dev header.i=@archibald.dev header.b=Pf39BxpA; arc=none smtp.client-ip=185.70.40.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archibald.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=archibald.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=archibald.dev header.i=@archibald.dev header.b="Pf39BxpA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archibald.dev;
	s=protonmail3; t=1713057097; x=1713316297;
	bh=v/bMgWMXnujUrrBAYom0Y+D8eJC66qvLQl8HFV2qtJ8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Pf39BxpAdhHeNRuugL5SmmrfyXsP6G9trhOvai2BkP7HMustPyB9WH4KMtbuvENEG
	 Gp+mF9Hd7IWd8XG4T0rWYVWVIdwAeJoJSN+sW+Cat+0P6tp1qSc20YiVFH8iw2Gzb7
	 tSm7vd5KPOj1foKiKmeKtOXx4KIKkQZ2jJqhJZ+aFhsYmeapdi9y4i18G8A4EOdRR+
	 fKNZvlSR97ky3c/ceWk+hPfNNSqXwvc+Fqt1EBtg5NonuQP9BevNn7opu5ytR7ayQH
	 6jqzZdXAzTKqd/o/gKzIn4KswJBSkY6Jzj18CNvT1Nxs5p1luQ+1+ehKgg+POMvt8W
	 964itWRK+hFrA==
Date: Sun, 14 Apr 2024 01:11:32 +0000
To: git@vger.kernel.org
From: Thalia Archibald <thalia@archibald.dev>
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, Chris Torek <chris.torek@gmail.com>, Elijah Newren <newren@gmail.com>, Thalia Archibald <thalia@archibald.dev>
Subject: [PATCH v5 0/8] fast-import: tighten parsing of paths
Message-ID: <cover.1713056559.git.thalia@archibald.dev>
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

> fast-import has subtle differences in how it parses file paths between ea=
ch
> occurrence of <path> in the grammar. Many errors are suppressed or not ch=
ecked,
> which could lead to silent data corruption. A particularly bad case is wh=
en a
> front-end sent escapes that Git doesn't recognize (e.g., hex escapes are =
not
> supported), it would be treated as literal bytes instead of a quoted stri=
ng.
>
> Bring path parsing into line with the documented behavior and improve
> documentation to fill in missing details.

Changes since v4:
* Refine C comments and parameter name.

Thalia


Thalia Archibald (8):
  fast-import: tighten path unquoting
  fast-import: directly use strbufs for paths
  fast-import: allow unquoted empty path for root
  fast-import: remove dead strbuf
  fast-import: improve documentation for path quoting
  fast-import: document C-style escapes for paths
  fast-import: forbid escaped NUL in paths
  fast-import: make comments more precise

 Documentation/git-fast-import.txt |  31 +-
 builtin/fast-import.c             | 162 ++++----
 t/t9300-fast-import.sh            | 624 +++++++++++++++++++++---------
 3 files changed, 555 insertions(+), 262 deletions(-)

Range-diff against v4:
1:  d6ea8aca46 ! 1:  2c18fe5fe9 fast-import: tighten path unquoting
    @@ builtin/fast-import.c: static uintmax_t parse_mark_ref_space(const c=
har **p)
      }
     =20
     +/*
    -+ * Parse the path string into the strbuf. It may be quoted with escap=
e sequences
    -+ * or unquoted without escape sequences. When unquoted, it may only c=
ontain a
    -+ * space if `include_spaces` is nonzero.
    ++ * Parse the path string into the strbuf. The path can either be quot=
ed with
    ++ * escape sequences or unquoted without escape sequences. Unquoted st=
rings may
    ++ * contain spaces only if `is_last_field` is nonzero; otherwise, it s=
tops
    ++ * parsing at the first space.
     + */
     +static void parse_path(struct strbuf *sb, const char *p, const char *=
*endp,
    -+=09=09int include_spaces, const char *field)
    ++=09=09int is_last_field, const char *field)
     +{
     +=09if (*p =3D=3D '"') {
     +=09=09if (unquote_c_style(sb, p, endp))
     +=09=09=09die("Invalid %s: %s", field, command_buf.buf);
     +=09} else {
    -+=09=09if (include_spaces)
    -+=09=09=09*endp =3D p + strlen(p);
    -+=09=09else
    -+=09=09=09*endp =3D strchrnul(p, ' ');
    ++=09=09/*
    ++=09=09 * Unless we are parsing the last field of a line,
    ++=09=09 * SP is the end of this field.
    ++=09=09 */
    ++=09=09*endp =3D is_last_field
    ++=09=09=09? p + strlen(p)
    ++=09=09=09: strchrnul(p, ' ');
     +=09=09strbuf_add(sb, p, *endp - p);
     +=09}
     +}
     +
     +/*
     + * Parse the path string into the strbuf, and complain if this is not=
 the end of
    -+ * the string. It may contain spaces even when unquoted.
    ++ * the string. Unquoted strings may contain spaces.
     + */
     +static void parse_path_eol(struct strbuf *sb, const char *p, const ch=
ar *field)
     +{
    @@ builtin/fast-import.c: static uintmax_t parse_mark_ref_space(const c=
har **p)
     +
     +/*
     + * Parse the path string into the strbuf, and ensure it is followed b=
y a space.
    -+ * It may not contain spaces when unquoted. Update *endp to point to =
the first
    ++ * Unquoted strings may not contain spaces. Update *endp to point to =
the first
     + * character after the space.
     + */
     +static void parse_path_space(struct strbuf *sb, const char *p,
2:  9499f34aae =3D 2:  4e9f3aa52c fast-import: directly use strbufs for pat=
hs
3:  9b1e6b80f5 =3D 3:  cae5764cec fast-import: allow unquoted empty path fo=
r root
4:  1a2b0dc616 =3D 4:  96ff70895a fast-import: remove dead strbuf
5:  fb0d870d53 =3D 5:  e1a1b0395d fast-import: improve documentation for pa=
th quoting
6:  4b6017ded8 =3D 6:  08e6fb37be fast-import: document C-style escapes for=
 paths
7:  5b464f4b01 =3D 7:  a01d0a1b25 fast-import: forbid escaped NUL in paths
8:  6eb66fce45 =3D 8:  65d7896e39 fast-import: make comments more precise
--=20
2.44.0


