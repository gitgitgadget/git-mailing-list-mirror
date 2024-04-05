Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD294161906
	for <git@vger.kernel.org>; Fri,  5 Apr 2024 10:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712314419; cv=none; b=SN0Ql70HypVoazJwT1CmEPxWgHmK3auA9HfXTV5/f6s7MNxohvYdQVoaW+hnHpLoUKXl22quvFS47erBEFVmBdSW0LaJfMBc2ZMiN0Qv1GlWbWbp3xCLToPG62dNQE7pqE7ke9Cg2kKD9NAPGD92kL8zXh84OfzGYqJR6OKhUdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712314419; c=relaxed/simple;
	bh=tQK3lUl4rPNVIN3lnLVB8VH7z7fPQp0chQ96IyIU5+M=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=RBu1hh5JF2oEl2p4543OOZUjnVnZzv2FW/Cv1YrzfEF8b8Q+5Z8mlYawd7zHPnTdiKD82xMPBWcvjbqrv30dkB8I0hd4brdbrWQra6L6w+6yHBIz0TH3yo3lTWkH2dKZsPWhlQ57PxMLHyG2wlQ10xw+xdyZE6InBtFgqahN2Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=se6ICRwO; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="se6ICRwO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1712314404; x=1712919204; i=l.s.r@web.de;
	bh=2H9BrIZKtnTVO0z60FxxiO9DbTzpX8uHAPhG4eizMYI=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=se6ICRwORnoVH5wwfFnCjSrgyap66WEsZg0ofgHSoVPyLuV0WzE2KonpI82L3Ri3
	 Herr0IxPNRwYSZyDqRNlY7JdIC4PJHH+SzEBjIOQE+sE5NrSaq7WV9XkR3yEUkR4e
	 wZdf8Y7eDqdDwWJ7TyEAw3jD/lc2B2hk7wFqL8cfqx0jn8Y+U9BzpfbDxgvnrXYn3
	 NILW328K4fcQ71D9uOmgeS7poIphXc7zpTdy5OgXCZhUBwyHx6vFubXXkoXJl8qmI
	 DMhsY8aQQ1u26Tr1K/bOo1UCWSaa/4KUge6pRVFqDEDH/boBAjvORPgPaxE7aGX7n
	 vNRGGbpZhRKVfRM/VA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.147.225]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MuVKK-1sijt01H6I-00rsl2; Fri, 05
 Apr 2024 12:53:24 +0200
Message-ID: <1b5f3b1d-60e2-4fe7-9ac8-a63ad861cd16@web.de>
Date: Fri, 5 Apr 2024 12:53:23 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 1/2] apply: avoid fixed-size buffer in create_one_file()
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
Cc: Jeff King <peff@peff.net>
References: <df774306-f29b-4a75-a282-59db89812b9a@web.de>
Content-Language: en-US
In-Reply-To: <df774306-f29b-4a75-a282-59db89812b9a@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PPyVy47fretU9KdJ9L91qSG3aYCOeCAEZYTZLK/GfXTuMsfhSR+
 QYi+1Sv+iiMsOlpacDBJV+JEfOQBX/iOwL4ISx2pZJVeaIZfk8K1WtM9I9J9bM58NDdUKmy
 6O26kkyQ8zioAKZ/gn+qQS0e4SzGXt2JsB5SC0F9u01BXKGqYolVwkMOgy3ZO1JpjgDJGnb
 qspOd8Pg7k4Uvgp9iRKhw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:hWWRv892mjY=;d2LFvEPK+t93ymlwNhyoVZ5rcVO
 mLBaWipAGeorpKIWz+COtKdqkVA7d1MlVZpswkMoakwOmTg7yvAceQ3l8s/L/4Bztmhsrpp4Y
 d/5/s4UocgCwTNKxlkyK9TEravS6fVSAmKAIbtD8eMKeDVKAQbgfWRKCuLKljPHrcCkwOUNmL
 1RkV+Ea5qAzoMLXx89xIzYrAsDiArjQPNhPVWWGa6UusI3OvNbOJu+JBhEEYAM2Rc4ciTCwFS
 pi+uPJ5lnstPCuSExitJ9G59MrjIe2FAVkUiFJ+tl+0LJ6MGPNC7Zxyjv2ywzi1TidSKuJaen
 h37WcUSgZ+w+TTtnkcOVJCx7qm3C+Qcux7kOPMvM1a0yuiU4h1rsiewVHglCxJTVSNnPTevza
 sP5DzFukGoCUNcKpkpx6VkVRdLFGr6u+xa5xfV9CdwuQKVTn2DoYPl+1UFA8x32cgaHpQb5ww
 b07kzALg0maSXNIGVoNaJdwq3xYCsk/l76EFbiFggf+SKu0bIfd7JNHlEbmy2atZzSFgmpe6a
 RF/5kl5CFX5k0Z4XsLMb8RapkeIkoWdH3IeWmY8xK9qIGaEQG1RUNte0xngdnI0IOx9EJjK32
 Nr0jPyKNUinxC/HTcgZROW+AD1Y8F4a5Or30IIg7vJSgxk4zP+K6bKzcESMR+RODg5pkjEHNr
 19XLTHZt8qZ1+hcfCNC96gHwb2zbVk1OoJzak1/yAMiKWAJ1K5Jg+knt5aKKzFr4/Ywg2hGiF
 mh0AAPuUGNLQ3uOh1XSmoFYFLLjGrVPQgSLb+/Ts6t/lCUxxKTAnDw/JGqIFKScIui4sADgZe
 7oOEabAn8SB0qMdEV+xKnq++Pw+WoyEgw3wuoxzRbE8Q4=

PATH_MAX is not always a hard limit and 'path' in create_one_file()
could be longer -- it's taken from the patch file and allocated
dynamically.  Allocate the name of the temporary file on the heap as
well instead of using a fixed-size buffer to avoid that arbitrary limit.

Resist the temptation of using the more convenient mkpath() to avoid
introducing a dependency on a static variable deep inside the apply
machinery.

Take care to work around (arguably buggy) implementations of free(3)
that modify errno, by calling it only after using the errno value.

Suggested-by: Jeff King <peff@peff.net>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Changes since v1:
- Split out removal of mksnpath() into a separate patch.
- Use errno only before calling free(3).

 apply.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/apply.c b/apply.c
index 432837a674..e171b42904 100644
=2D-- a/apply.c
+++ b/apply.c
@@ -4441,6 +4441,7 @@ static int create_one_file(struct apply_state *state=
,
 			   const char *buf,
 			   unsigned long size)
 {
+	char *newpath =3D NULL;
 	int res;

 	if (state->cached)
@@ -4502,24 +4503,26 @@ static int create_one_file(struct apply_state *sta=
te,
 		unsigned int nr =3D getpid();

 		for (;;) {
-			char newpath[PATH_MAX];
-			mksnpath(newpath, sizeof(newpath), "%s~%u", path, nr);
+			newpath =3D mkpathdup("%s~%u", path, nr);
 			res =3D try_create_file(state, newpath, mode, buf, size);
 			if (res < 0)
-				return -1;
+				goto out;
 			if (!res) {
 				if (!rename(newpath, path))
-					return 0;
+					goto out;
 				unlink_or_warn(newpath);
 				break;
 			}
 			if (errno !=3D EEXIST)
 				break;
 			++nr;
+			FREE_AND_NULL(newpath);
 		}
 	}
-	return error_errno(_("unable to write file '%s' mode %o"),
-			   path, mode);
+	res =3D error_errno(_("unable to write file '%s' mode %o"), path, mode);
+out:
+	free(newpath);
+	return res;
 }

 static int add_conflicted_stages_file(struct apply_state *state,
=2D-
2.44.0
