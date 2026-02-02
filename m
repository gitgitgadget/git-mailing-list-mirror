Received: from mail-24424.protonmail.ch (mail-24424.protonmail.ch [109.224.244.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9577D3EBF3D
	for <git@vger.kernel.org>; Mon,  2 Feb 2026 21:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770067528; cv=none; b=bi1wmnNStszSI5TxTEYj9Y48kzBNPXFfsRqc1K/3mFcYJYSOC2wyt1mAV8YXoGifPjyMYLGNAiTlXPe4IPf54LyPVsFcffRMtW7qUo7qk8Btg4/gZDQ7+luIwDYk+fAi6TEZPQL6GS/EGEt3Letbf1HCWQwpYbGrhK8xbkGf3K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770067528; c=relaxed/simple;
	bh=yvaCzfSN0rZmpk2XqdkQ2pKmZEUesRhxcy2J7sm9u08=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=csIxbdp1FuMPxNZ7ixKLQ9cW+s0rxN/encO2EwownDJ2cPAcefJQYtPjLM6YNnbBQZgx9UakOk2qOjK9fcXPBacQoiE8++q6YYmBrE5fwfxWFvxw/Lpf4MftLTp+BUX6t2TcEp51XAeJU9z+PAc081E4IjyJ5Bp7iRpsnl7mJ7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=snJkbuek; arc=none smtp.client-ip=109.224.244.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="snJkbuek"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1770067518; x=1770326718;
	bh=o1WajuS0BEIvwn/4wObspf1nPyHTlUY02KW7QtSsZHE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=snJkbuekGmXuC0eIxJQ34ZwECBKw89ws5b8qWxqwx1OcToXY/emOXjFJwxqxLuzsl
	 sLD3zZv7qBD62+3eL9ARc22Gf9IjG7lv7sxgCJ5sByD/0a2jLqHtR3ivb54c+it3O+
	 mIvmX+SOTwTg0oV2cHnc4zPRlmVIQL7gCv1GKmgQbU+4YEYZywIq2JtYEM7nleVOTy
	 U/efa+x+qA4LkhtjDUpjpIdWn9JyDGgP72ZbFNbnSBWg6SnQciG5OUmehUZ330BGC4
	 m9lbj42An5aMnZfMIbS71Aw32odjkRTe7S/9oD4TCNiR7LWlLa4YgLcNTNUDmBr7TK
	 l6/eNbJVOWO/Q==
Date: Mon, 02 Feb 2026 21:25:17 +0000
To: a3205153416@gmail.com
From: "Remy D. Farley" <one-d-wide@protonmail.com>
Cc: git@vger.kernel.org, one-d-wide@protonmail.com
Subject: Re: Bug: git add :!x . exits with error when x is in .gitignore
Message-ID: <20260202212420.1185803-1-one-d-wide@protonmail.com>
In-Reply-To: <1d560aa1-d452-47f5-aaf2-4cb1ccdab100@gmail.com>
References: <20260131194309.601838-1-one-d-wide@protonmail.com> <1d560aa1-d452-47f5-aaf2-4cb1ccdab100@gmail.com>
Feedback-ID: 59017272:user:proton
X-Pm-Message-ID: 43598928c1f1a162fecca6aca0e19621624ac676
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> Thanks for the report and the patch! I also agree that the behavior you
> described seems like a bug.
>=20
> However, though I'm new to git community, I still have concerns about
> the fix in 'dir.c':
>=20
> > - if (!pathspec || !pathspec->nr)
> > + if (!pathspec || !pathspec->nr || pathspec->magic & PATHSPEC_EXCLUDE)
> > return 0;
>=20
>=20
> I tried to analyze the logic and I believe this patch breaks the basic
> functionality of the negative pathspec (:!):
>=20
> (I didn't check the caller of exclude_matches_pathspec and I only focus
> on the function itself. Tell me if I'm wrong :)
>=20
> By returning 0 whenever PATHSPEC_EXCLUDE is set globally,
> exclude_matches_pathspec will report "no match" for all files,
> effectively disabling the exclusion mechanism entirely.
>=20
> Instead of fixing the issue with ignored files, this patch causes valid
> exclusions to be ignored.
>=20
> We must check if the specific path matches the exclude pattern, not
> short-circuit based on the global flag.


Oops. Somehow I was convinced struct pathspec represents only a single path=
.
This way something like this would silently succeed, without actually index=
ing x:

  touch x
  echo x >.gitignore
  git add -n ":(exclude)smth/else" x

Thank you for pointing out.


> It will be great if we set a test script for this. I will be working on
> it in the next few days.

---
 dir.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/dir.c b/dir.c
index b00821f2..ed6b99e3 100644
--- a/dir.c
+++ b/dir.c
@@ -2280,6 +2280,9 @@ static int exclude_matches_pathspec(const char *path,=
 int pathlen,
 =09=09const struct pathspec_item *item =3D &pathspec->items[i];
 =09=09int len =3D item->nowildcard_len;
=20
+=09=09if (item->magic & PATHSPEC_EXCLUDE)
+=09=09=09continue;
+
 =09=09if (len =3D=3D pathlen &&
 =09=09    !ps_strncmp(item, item->match, path, pathlen))
 =09=09=09return 1;
--=20
2.51.2


