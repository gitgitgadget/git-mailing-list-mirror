Received: from mail-43166.protonmail.ch (mail-43166.protonmail.ch [185.70.43.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6169E31A7EA
	for <git@vger.kernel.org>; Wed,  4 Feb 2026 20:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770235905; cv=none; b=Zhy05nht3lEKb6Of/NMOjgJlUpjhkRq3r9mEbPMoxU26cKwiFfmi3U8hO87pYh4fMxFFa2Rrm6we+wH0/jKB3FD2kS9tpjj922joGFFbYyERvCZW22cHg7s2nOVtCegto7rjwpr/poedomWDU0jJf45cSVfoc/SPaKh4W/mMAqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770235905; c=relaxed/simple;
	bh=nz63wDUaZDcuUjdroxftV1EDTDszCpwJvEJNajzO0fo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vCFbX9qi7sDgcjQNe85mv3+1qNIISoZKf3nTplRYQaOR/VuBofe3EoeHAh/TFmGaflmZfoL89kQQ2UEPUSvxTDOoo0GiPex7aJaw/RzSew2GG06SY/14bQ/tCHrKipW+8DvrG6NGiCpPtVJyF3LhYVWUp0d3o8tBzO1XSUw6XgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=nJZqxS+o; arc=none smtp.client-ip=185.70.43.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="nJZqxS+o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1770235896; x=1770495096;
	bh=0e6gQAHYYGnbQvA6/GXmRJLKlbF46b7QxNwknBIG2oA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=nJZqxS+o4LgxG5YAg27sztiMWf+GI9Id9Mf2dh07VHQSPuzpW+iiqNWzY3FFF+TDD
	 lHdKrHIdQD2hL4tywDPnZomtmePgMJ3wGj0L+ANuB5Q7ztI3HfrGuk+HqCsNvRVPeN
	 4p4XQUoWenGo2Aw9unSv/Sueab0li5A3/k5XZQ2akmlzDzD8L9L7XHYoouLLQEjwR5
	 ZD7nwSuvUDNGsUo21e0GOdhwver3VfaygN9BRXZuvJmkuFFeiByH/qJshXrO0DnXMG
	 W6WQI+6dp/7wKni2yp+nWqlMSbUXd0+VhdacfnKo7Zz2dx993etWb3drOHrg7/UFDi
	 Rou+9b0TDixKw==
Date: Wed, 04 Feb 2026 20:11:32 +0000
To: Junio C Hamano <gitster@pobox.com>
From: "Remy D. Farley" <one-d-wide@protonmail.com>
Cc: Tian Yuchen <a3205153416@gmail.com>, git@vger.kernel.org
Subject: [PATCH] fix git add :!x exiting with error when x is in .gitignore
Message-ID: <24VdqZCRHE7M9q7Rp-IH60MmQrEOW5lzhtd1-SUNqEhV_OTzGiCUkVDL5ngVJbyWRMDZ2GlWCJ9wkMSJLsJh8QYO4gRhDMGyzhfuGAODOs8=@protonmail.com>
In-Reply-To: <xmqq5x8cpcrd.fsf@gitster.g>
References: <20260204132747.1564157-1-one-d-wide@protonmail.com> <xmqqo6m4pi84.fsf@gitster.g> <9c5be231-f340-4a97-850e-d43c78b2c889@gmail.com> <xmqq5x8cpcrd.fsf@gitster.g>
Feedback-ID: 59017272:user:proton
X-Pm-Message-ID: 538da49bf62ab6fed2e4373fb165ab1c8b58760b
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Junio C Hamano <gitster@pobox.com> wrote:
> A question that immediately comes to mind is if it is appropriate
> for a negated pathspec element to recuse itself like this from the
> decision process and let other pathspec elements decide the fate of
> the path, or if a negated pathspec element should take a more active
> role of saying "no" (no, not by immediately returning 0, but this
> loop may have to become a two step process if we wanted to implement
> e.g., for the function to yield "yes", it has to match at least one
> positive pathspec element and zero negated one, or something like
> that).
>
> What should
>
>     git add "$x" ":!$y"
>
> do when a path <matches, does not match> $X and <matches, does not
> match> $Y? We have four combinations to consider in such a case.
> The code in the patch says it should behave identically to
>
>     git add "$x"
>
> and negated ":!$y" should not make any difference. Is that what we
> want?


I indeed failed to consider cases where pathspecs could interfere with each
other, sorry.

It does seems like we don't want to just blanketly ignore negated pathspecs=
,
at least for the sake of consistency:

    git add -n :!a a/ignored/c # is ok (even on mainline, nothing is added)

    git add -n :!a/b a/b # ok (same)

Probably the same should hold after this patch if "a" or "a/b" were exclude=
d.
I'll try to think this through.


Tian Yuchen <a3205153416@gmail.com> wrote:
> By the way, I think extreme cases like 'git add x :!x' should be added
> into the test scripts.


I think this was already covered, though with a simplistic (wrong) approach=
.

>  for i in ign dir/ign dir/sub dir/sub/*ign sub/file sub sub/*
>  do
>  =09[...]
> +=09test_expect_success "complaints for ignored $i with ignored :!ign" '
> +=09=09rm -f .git/index &&
> +=09=09test_must_fail git add "$i" :!ign 2>err &&
> +=09=09git ls-files "$i" ign >out &&
> +=09=09test_must_be_empty out
> +=09'
>  done


Junio C Hamano <gitster@pobox.com> wrote:
> One caveat.  The case without any positive pathspec entries needs
> special consideration.  I suspect, but can be totally wrong as I
> didn't think things through thoroughly, that
>=20
>     git add "!$y"
>=20
> would want to behave as if an implicit "everything matches" was
> given, i.e.,
>=20
>     git add "!$y" .
>
> while a pathspec with one or more positive entries would not need
> and want such an implicit "everything" treatment.


This case is actually already handled by the pathspec itself.


From pathspec.c:
> void parse_pathspec(struct pathspec *pathspec,
> =09=09    unsigned magic_mask, unsigned flags,
> =09=09    const char *prefix, const char **argv)
> {
> =09[...]
> =09/*
> =09 * If everything is an exclude pattern, add one positive pattern
> =09 * that matches everything. We allocated an extra one for this.
> =09 */
> =09if (nr_exclude =3D=3D n) {
> =09=09int plen =3D (!(flags & PATHSPEC_PREFER_CWD)) ? 0 : prefixlen;
> =09=09init_pathspec_item(item + n, 0, prefix, plen, ".");
> =09=09pathspec->nr++;
> =09}
