Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C84B23AD
	for <git@vger.kernel.org>; Mon,  1 Apr 2024 09:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711962358; cv=none; b=k1bnyJlBgKpO94vDFiYfZVtg+YPNkLXIJXKnwlwGbuAPhpmTot5vcIWXnpPyWmtFzx2xmV1ALWbfW6slSG8AvY5/Tqj/T4pYHbGZCsXY84gyig+tF6jJ+fXjkymv0kP5kxkcIuANOH2x9KhdJhWCpVzGuxI6sm8K9nrUJzQw/B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711962358; c=relaxed/simple;
	bh=LcfIre2yL87gmXrdRDp+9YJPxCTSjEUcFzkq6ft+7Fg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PLCJy9ldljBbR+i/4nBLDZfDeWr2x0f9pcpxsyEV7XSuxVHCf8aq26M0uX+PndrrrDWLS1Dsm2EFrKi6lfWLsMlwGQD/l+V1srWFx6k6BPYXgTq0cfY8KPCr+OFO9zeEa8y9bJlx/NkCYykMiFOViwh1pEFMcl7huSJJpduajas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archibald.dev; spf=pass smtp.mailfrom=archibald.dev; dkim=pass (2048-bit key) header.d=archibald.dev header.i=@archibald.dev header.b=rQv+KOlj; arc=none smtp.client-ip=185.70.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archibald.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=archibald.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=archibald.dev header.i=@archibald.dev header.b="rQv+KOlj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archibald.dev;
	s=protonmail3; t=1711962354; x=1712221554;
	bh=GvGTS/qRNZ1T4/w52zTe9pJVv2BlkQ+U56/EbjJcafs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=rQv+KOljlvJkqx8TUCdK9tIqmqJQPyaM1xCbsa12drn0ZFeBbxv3PNifXmsitYyZT
	 e1NzTzD7T0VKuN73obKB/7GBz5MofbRreJvMcag69vbItgF6tqzGz5iBz/MjctVWUC
	 cDOVVOPtlbpyQKL3U/4JceeVOm5KwpOV3pEZecTnxjvgJM69qFLie7gydest+ujPKH
	 Uemru2AgklmwmPyhxYD/q0xyPzjSajarGMwQgAQ/5vs1f75G+1/i73QdcmBlRCY5g+
	 Io1pMySmePBSpyof+eTTv5Qo5aTzbVaCtQsmnzf8bRPsO4SNwqPtVBz3V16yp7TKqt
	 ar5QTBGuQSZWA==
Date: Mon, 01 Apr 2024 09:05:48 +0000
To: Patrick Steinhardt <ps@pks.im>
From: Thalia Archibald <thalia@archibald.dev>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/6] fast-import: tighten parsing of paths
Message-ID: <4523FBB5-68AE-4D98-BB5F-6B498ADF1C25@archibald.dev>
In-Reply-To: <E01C617F-3720-42C0-83EE-04BB01643C86@archibald.dev>
References: <20240322000304.76810-1-thalia@archibald.dev> <20240322000304.76810-2-thalia@archibald.dev> <ZgUobnAVRCfyu1k7@tanuki> <E01C617F-3720-42C0-83EE-04BB01643C86@archibald.dev>
Feedback-ID: 63908566:user:proton
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

(Sorry for first sending as HTML)

On Mar 28, 2024, at 01:21, Patrick Steinhardt <ps@pks.im> wrote:
>=20
> So this is part of the "filemodify" section with the following syntax:
>=20
>    'M' SP <mode> SP <dataref> SP <path> LF
>=20
> The way I interpret this change is that <path> could previously be empty
> (`SP LF`), but now it needs to be quoted (`SP '"' '"' LF). This seems to
> be related to cases (1) and (3) of your commit messages, where
> "filemodify" could contain an unquoted empty string whereas "filecopy"
> and "filerename" would complain about such an unquoted string.
>=20
> In any case I don't see a strong argument why exactly it should be
> forbidden to have an unquoted empty path here, and I do wonder whether
> it would break existing writers of the format when we retroactively
> tighten this case. Isn't it possible to instead loosen it such that all
> three of the above actions know to handle unquoted empty paths?

At first, I strongly thought that we should forbid this case of unquoted em=
pty
paths. It's a somewhat peculiar case in that it refers to the root of the r=
epo
and few front-ends use it. I surveyed git fast-export, git-filter-repo,
Reposurgeon, hg-fast-export, cvs-fast-export (by Eric S. Raymond),
cvs-fast-export (by Roger Vaughn), svn2git, bzr-fastexport, and bk fast-exp=
ort,
but none of them ever target the root of the repo. I assumed that if an unq=
uoted
empty path was ever emitted, it was likely an bug that should not be accept=
ed
(e.g., a null byte array somehow).

However, most occurrences of <path> in the grammar have allowed unquoted em=
pty
strings to mean the root for 14 years and documentation has implied that it=
's
allowed for 13 years. It's just the two cases of the destination paths of
filecopy and filerename that don't allow it, and those are less-used operat=
ions,
so front-ends may never encounter that error.

Some assumed errors in emitting empty paths are caught by validation with f=
ile
modes, so even if it's loosened it's still fairly safe. filemodify must be
040000 when it targets the root, and filecopy and filerename to the root mu=
st
have a source path that's a directory. The worst case is filedelete
unintentionally targeting the root, but that's been allowed to be an unquot=
ed
empty path for almost its entire lifetime, so I don't think should be chang=
ed.

I've changed it to allow unquoted empty paths for all operations in patch v=
2
3/8 (fast-import: allow unquoted empty path for root).

> This is loosening the condition so that we also accept unquoted paths
> now. Okay.

On the contrary, v1 tightens all paths to forbid unquoted empty strings. v2=
 now
allows it and should make that change more clear.

> On Fri, Mar 22, 2024 at 12:03:18AM +0000, Thalia Archibald wrote:
>> +/*
>> + * Parse the path string into the strbuf. It may be quoted with escape =
sequences
>> + * or unquoted without escape sequences. When unquoted, it may only con=
tain a
>> + * space if `allow_spaces` is nonzero.
>> + */
>> +static void parse_path(struct strbuf *sb, const char *p, const char **e=
ndp, int allow_spaces, const char *field)
>> +{
>> + strbuf_reset(sb);
>> + if (*p =3D=3D '"') {
>> + if (unquote_c_style(sb, p, endp))
>> + die("Invalid %s: %s", field, command_buf.buf);
>> + } else {
>> + if (allow_spaces)
>> + *endp =3D p + strlen(p);
>=20
> I wonder whether `stop_at_unquoted_space` might be more telling. It's
> not like we disallow spaces here, it's that we treat them as the
> separator to the next field.

I agree, but I=E2=80=99d rather something shorter, so I=E2=80=99ve changed =
it to `include_spaces`.

>> + else
>> + *endp =3D strchr(p, ' ');
>> + if (*endp =3D=3D p)
>> + die("Missing %s: %s", field, command_buf.buf);
>=20
> Error messages should start with a lower-case letter and be
> translateable. But these are simply moved over from the previous code,
> so I don't mind much if you want to keep them as-is.
>=20
>> + strbuf_add(sb, p, *endp - p);
>> + }
>> +}


fast-import isn=E2=80=99t a porcelain command, AFAIK, so I thought the conv=
ention is
that its output isn't translated?

From po/README.md:
>=20
> The output from Git's plumbing utilities will primarily be read by
> programs and would break scripts under non-C locales if it was
> translated. Plumbing strings should not be translated, since
> they're part of Git's API.


I would, however, like to improve its error messages. For example, diagnosi=
ng
errors more precisely or changing the outdated =E2=80=9CGIT=E2=80=9D to =
=E2=80=9CGit=E2=80=9D.

To what extent should the exact error messages be considered part of Git's =
API?

Thalia
