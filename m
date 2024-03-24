Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F2C8831
	for <git@vger.kernel.org>; Sun, 24 Mar 2024 08:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711267466; cv=none; b=AVM30uePsJYVGsh615RG6kU6ha7uaVKW4T1UVRhsZyynJfDCPS0EJe2l7jjMIA1qyrDVus+0Glm0W4MvSlyXCBPKF0Oc2+UJDuL+e8Kd1FmdIrc+vmstp2sJpXpQ/eeoNCLyu0BDaf7C72rG9wUYiJF+b41jFqYjv045gMPvwpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711267466; c=relaxed/simple;
	bh=A+YSaDX0ZxHVaMZy9wwzRjrjkZhjLXNgMP6gXHyNyEk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=QdMi80MsDrxcQqBRrpsBnUDK6ToOlpmifuicowjlDu4XQSZ8Q7dwYof2iNTdJPIt5p7OhzDaZx0pXIMWTpvvNKD6GmpISljf6zm/hqkUqXgajsq3DilLP8zorcCloZVrZMO638M5sdERqUvT/GNZfBbrAlANWliEM7OSTVX0aZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=BruJGMxW; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="BruJGMxW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1711267462; x=1711872262; i=l.s.r@web.de;
	bh=KO3xIc5epXfxTb10zdNMkM35xVpQxUfDbCLLmE170kY=;
	h=X-UI-Sender-Class:Date:Subject:From:To:References:In-Reply-To;
	b=BruJGMxW16DmRII7SztsESoV4/X6YZV7+hY3KoPXSNgP56N3/brZN+yi60IuDqOC
	 M3H/25MoCPkRQyFzEuZ0HoJI3v0ku9TDq1z4wpOo1jHwt3XO5K3xdW/JamfZJPZXq
	 tA5WygyUD0Sr/Vqvz+PVprHfAXLzLlNwKiiSqsc3j9L6YNsYEJ88AGpqZRiGk/+cT
	 p7ulg9LiJ0ulYQIm/UUTfKpe6lzNPn7e1WGLsGugfh2ENOu90xAJQqwXHewDrsQzn
	 i+6Vml04369JUtcIFjmxUnn/DfNyFEl7ZAA7fTpmnir2dB7+RzX/XBcLcgiCt3wbr
	 86A84tJC/DRRXV0/TA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.19.211]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MCXVZ-1reiCT0LWF-009O7m for
 <git@vger.kernel.org>; Sun, 24 Mar 2024 09:04:22 +0100
Message-ID: <62c7ec20-4c1f-4a17-9deb-30699215251a@web.de>
Date: Sun, 24 Mar 2024 09:04:21 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/2] cat-file: use strbuf_expand_bad_format()
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
References: <27cdcde7-74bc-4ee8-bc84-9a6046292cae@web.de>
Content-Language: en-US
In-Reply-To: <27cdcde7-74bc-4ee8-bc84-9a6046292cae@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CaiKggvgmKHGUPZ5RKzgxk5W12tpsmNlgfTf2zMiXPU7RDLTu8U
 WrHLPH/f3pT4TTocuvnhQQmnrDqEvUbv7psz5hnSGhTGRfSIKu0cotLFQBaJ3jxllmLEmlD
 YS95KOw/JHP/iE01Sp/G3pKhwpf2o4FpZdYm21M9Dj18LKnWSBU95cH/tvyCgCqQxBrx8UV
 tnYphVYKLfLeDD3NeeXPw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:i+37WVCF2NU=;SLklub8iTywUNWTSBqyG62DO40m
 EVpRpargK50ZhKR0wk/6kQkiSfvIdbuMYucLeEktmolP7B8+ZKXmugV4AOiZuOvKPWDBNgdLr
 ewUH2hbjYeRzZV7vqT6PFP0SftvYjDBmWwSF0CJo2FSxqz/x5Vnd8lqMe/NMRqPQTgUljUPSm
 XMnbpbvkXpuTXWT/RUpcmIYuLH8GGa92kBzOoQgAiTFqKg9XEGYihB1HchEtAz7L1uMKTC5d8
 jJ4HfoF7593u1Mb/W2qU+7jlVOOm4yBub2BDKAyZRIlcLKcyQ8XAagRLA64vSW1tLb09Ebplm
 hZgyqtngx4i7GY6BSiuzPhsDZMcCr3l9UoPqcF1NPDGv/jdccuR5IzNcCL5xa3tsmFVY9Wp/e
 pjlHhh0qqraa5YapTvXH/yyRXc0Ic2bUi39Ahy96vAYSwdc3D714jJ7Df1jSyArNQkMop5ze/
 rPd5ajRModekul67IZ9xYc7lwLWLAxLPGyy/CvEbIq5cviIHjXmsdqBqyOmwogL236IiQ5kf6
 TddJ99pZuvYdvIxRjnCDiTURtIoZ8UBlaed531OnT1tJa86mESYfj/bLyBCLe85LzX7DKOrnx
 ohqBnEbGzLcT5P4H+bUYMkSO1guPtDeFwk9dqlLwA9MRH8Qn2zus/ogH5esOaC4FAZdywjFG+
 1u16wqUWgB43d26DfHyxIEHMNoGdR36Dmj5s6OqCRjoSDz+ykwg8vEhEctpLViwCuh9L2930v
 bTFK9ljq+K6/s5Y9JVFoO4g0Wv92hIbKq4k8d18njkKEtDZc0aSToIqVjx1ERzGurk1OxSjE4
 TO66cG60PWQ68MF/gQtgFd0tbSZ5HpOE465PYXex6PSC4=

Report unknown format elements and missing closing parentheses with
consistent and translated messages by calling strbuf_expand_bad_format()
at the very end of the combined if/else chain of expand_format() and
expand_atom().

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/cat-file.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index bbf851138e..fadf2da2f0 100644
=2D-- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -310,8 +310,8 @@ static int is_atom(const char *atom, const char *s, in=
t slen)
 	return alen =3D=3D slen && !memcmp(atom, s, alen);
 }

-static void expand_atom(struct strbuf *sb, const char *atom, int len,
-			struct expand_data *data)
+static int expand_atom(struct strbuf *sb, const char *atom, int len,
+		       struct expand_data *data)
 {
 	if (is_atom("objectname", atom, len)) {
 		if (!data->mark_query)
@@ -343,7 +343,8 @@ static void expand_atom(struct strbuf *sb, const char =
*atom, int len,
 			strbuf_addstr(sb,
 				      oid_to_hex(&data->delta_base_oid));
 	} else
-		die("unknown format element: %.*s", len, atom);
+		return 0;
+	return 1;
 }

 static void expand_format(struct strbuf *sb, const char *start,
@@ -354,12 +355,11 @@ static void expand_format(struct strbuf *sb, const c=
har *start,

 		if (skip_prefix(start, "%", &start) || *start !=3D '(')
 			strbuf_addch(sb, '%');
-		else if (!(end =3D strchr(start + 1, ')')))
-			die("format element '%s' does not end in ')'", start);
-		else {
-			expand_atom(sb, start + 1, end - start - 1, data);
+		else if ((end =3D strchr(start + 1, ')')) &&
+			 expand_atom(sb, start + 1, end - start - 1, data))
 			start =3D end + 1;
-		}
+		else
+			strbuf_expand_bad_format(start, "cat-file");
 	}
 }

=2D-
2.44.0
