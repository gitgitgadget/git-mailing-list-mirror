Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E05254FA0
	for <git@vger.kernel.org>; Mon,  8 Jan 2024 17:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Ec4BOBfI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1704735255; x=1704994455;
	bh=0fEfDjmtfaDj8TdwoGVcCCADD7obGyJKlpuyBhNmhEM=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Ec4BOBfIOeLONJnj/BR5LM4N+DdOIHfRW5ohgYEZFH+QYaG2Ex+AeONDLKUxlsyyv
	 QkijyQa6iJE6PRIBcx8Og92uo3nAt4fWC1E47bCMrVGx27nAsdOARPkaKhW8mR7Q08
	 iMFGOQW7vYM6s8u0TegOd/cDTDrGwBw/qE+v7Q2qxB+aUKFRorqRkVA6YUlfJGYabL
	 1m/N78SzRa+VYpjSeQGiXqozK5b96yJKR7qkGgYsOlMyPo8BVb2/UK+1W7T8VNI7D/
	 S9H+knc+sGLTitvIArcDqEluglQTYdy/zntR/3MPF0k0EzdYTpOuPbZHZc+eEqY6an
	 /5Faox4U3KmOQ==
Date: Mon, 08 Jan 2024 17:34:01 +0000
To: "git@vger.kernel.org" <git@vger.kernel.org>
From: mohitmarathe@proton.me
Cc: "gitster@pobox.com" <gitster@pobox.com>, "britton.kerin@gmail.com" <britton.kerin@gmail.com>, "peff@peff.net" <peff@peff.net>
Subject: [GSoC][RFC] Replace use of atoi() with strtol_i(), as a microproject
Message-ID: <OqD4xQ_p-jcftCbAw0ovvrBztfiuoMGcTonCc0i6x7Ziy-hx3uA-Hoz4-3tfRI39KMj-V5OZIGgOe66b1eyX3YrKZNThMYjjMkn6g4-Ww8c=@proton.me>
Feedback-ID: 95862732:user:proton
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello,

I'm Mohit, an undergrad from India, and I want to start contributing to the=
 Git project. I have already built Git from source and finished `git psuh` =
tutorial. And I must say the "Hacking Git" documentation is great (very det=
ailed and maybe exhaustive) and easy to follow. So I also read the topic on=
 "microprojects", and while searching for one, I came across this message: =
https://public-inbox.org/git/xmqqjzpjsbjl.fsf@gitster.g/.
I want to work on this task (if it is not taken up already) as a microproje=
ct for GSoC.

Approach:
From what I understood, the idea is to *not* allow non-integer characters i=
n the arguments by printing an error message. So we have to replace `atoi` =
with `strtol_i`, like it is done in this patch: https://public-inbox.org/gi=
t/xmqq5y181fx0.fsf_-_@gitster.g/.
There are some places where we want to continue to parse after the end of t=
he integer (where `strspn` is used as mentioned by Junio), and based on Jun=
io's suggestion, a new helper can be created like this:

> static inline int strtol_i2(char const *s, int base, int *result, char **=
endp)
> {
> =09long ul;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 char *dummy =3D NULL;
>=20
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!endp)
> =09=09endp =3D &dummy;
> =09errno =3D 0;
> =09ul =3D strtol(s, &endp, base);
> =09if (errno ||
> =09 =C2=A0 =C2=A0/*
> =09 =C2=A0 =C2=A0 * if we are told to parse to the end of the string by
> =09 =C2=A0 =C2=A0 * passing NULL to endp, it is an error to have any
> =09 =C2=A0 =C2=A0 * remaining character after the digits.
> =09 =C2=A0 =C2=A0 */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (dummy && *dummy) ||
> =09 =C2=A0 =C2=A0endp =3D=3D s || (int) ul !=3D ul)
> =09=09return -1;
> =09*result =3D ul;
> =09return 0;
> }


So I searched for all the occurrences of `atoi(` (as suggested by Junio), a=
nd I found only two instances (both in `builtin/patch-id.c`) where it is fo=
llowed by `strspn`. Is it safe to assume that this is the only place where =
we cannot directly replace `atoi` with `strtol_i`, or should I keep digging=
?

Also, this seems like a large change due to the number of files involved, w=
hile the documentation about the microproject emphasizes keeping the change=
 small. Does it mean a small change per commit or a small change per Pull R=
equest?

Thanks!
