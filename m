Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944002367B3
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 09:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752054360; cv=none; b=Fm3nfJWJRXkMCbnHXDQ+OdQNMCAGq8r10GKDTFLPS2ZKvLcRSj+67ecOtF2s81KTEH+C6z9xat0+9T3002lxGV3IZeDgke5bielnh290GiEkB6qyGDRHi8uUE2jjDU0oyM4SgLEhjCB95ckiKVgPx4NCcZxhVrJy/uU70hXf/nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752054360; c=relaxed/simple;
	bh=+tubxzxeh+110S6kwciRhzMs4CHLgbEphjphglZpa/M=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=QsGUGnOpFSN1xGL2bjNd32ct3k1YrgludzQ5a2RXht8t8IJ2xHqrrpvUuykIOKK4c3AqWiG6ow5oYDr5kCJdiKvL5RcvkEVzrBVzf35xAIYC88ETfm7j/ASi5qpXEGDyOXsxg4d1PrVVDsdjqeduEZ7Bcz4KW3D1UxgxHDtQLeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=vVkBlKE2; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="vVkBlKE2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1752054354; x=1752659154; i=l.s.r@web.de;
	bh=y52Yu4VqFjiLrXG+4mWgxCyOACAWk3HNnx/VW6BuMos=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=vVkBlKE2yUq2goCxARjUt/dHMGMZJcnMsFfssrLilv9NhMWF01sRvJHKm5+MhGKR
	 We7Dsk0p6t95rwkO7V8quki3IFk9o+VLJ4vSTjCkxR+r/racgEiix4m012nxd7ljp
	 vNBX8b+Gx3FZHQADcYP5mesljg6q8DN8NTZJhWAI4TK8ZZe3PKMxOOb9C7DHTeQAx
	 2aE8qYxGUdxXMQD9yjYRqvuvO3pYOFvptTFLpIQnQe3EGFx6idaE29s7kaeSyXuS/
	 24LLzqFfQJwNQp4zt/nnWvSV0LmUz8LC1UIceO+9TV07b/CAOy51Fbx+oO8KigXmo
	 aV8tHBxB87A2SUHquQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.28.103]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MtyA2-1unwSL3eDU-011FCC; Wed, 09
 Jul 2025 11:45:53 +0200
Message-ID: <c492e2cd-d1aa-43ba-83c0-bd8f1a4d2f19@web.de>
Date: Wed, 9 Jul 2025 11:45:53 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 5/7] parse-options: add precision handling for
 OPTION_NEGBIT
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
Cc: Patrick Steinhardt <ps@pks.im>
References: <cf5cd57d-733f-4239-80f8-23bdc1523ab2@web.de>
 <802eba72-c100-429a-80b7-7a0e8b6559ed@web.de>
Content-Language: en-US
In-Reply-To: <802eba72-c100-429a-80b7-7a0e8b6559ed@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:drQ7aiqe5qMKq1jpaGocnJIUUeY8fhl+3/FJygllvOcdTD9Ia0I
 XAbAVNY9Wr73lqZKa6R6MOfkbVRxbYKz6Bblw1D2RDUuWDsllaIZD2anvJDjLSmNCBkpddd
 vjUyggYABuTpimb743oGnLFya4fXdJVku/3gdaXvjQLwBlf+Bke0T3+gqQO8hFyEh1tAdPU
 yuQ31E8PjhGTy0SvQOnaA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:BeKEFJFUkI4=;wNtihfd8At/cobcbeqjEksKg/vN
 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
 2CgXjXeyWSYLlXa53q9CPI22RAxsctBI=

Similar to 09705696f7 (parse-options: introduce precision handling for
`OPTION_INTEGER`, 2025-04-17) support value variables of different sizes
for OPTION_NEGBIT.  Do that by requiring their "precision" to be set,
casting their "value" pointer accordingly and checking whether the value
fits.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/rebase.c |  1 +
 parse-options.c  | 11 +++++++----
 parse-options.h  |  1 +
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 2e8c4ee678..e90562a3b8 100644
=2D-- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1128,6 +1128,7 @@ int cmd_rebase(int argc,
 			.short_name =3D 'n',
 			.long_name =3D "no-stat",
 			.value =3D &options.flags,
+			.precision =3D sizeof(options.flags),
 			.help =3D N_("do not show diffstat of what changed upstream"),
 			.flags =3D PARSE_OPT_NOARG,
 			.defval =3D REBASE_DIFFSTAT,
diff --git a/parse-options.c b/parse-options.c
index b5c877d5e1..ba89dc4d09 100644
=2D-- a/parse-options.c
+++ b/parse-options.c
@@ -157,11 +157,14 @@ static enum parse_opt_result do_get_value(struct par=
se_opt_ctx_t *p,
 	}
=20
 	case OPTION_NEGBIT:
+	{
+		intmax_t value =3D get_int_value(opt, flags);
 		if (unset)
-			*(int *)opt->value |=3D opt->defval;
+			value |=3D opt->defval;
 		else
-			*(int *)opt->value &=3D ~opt->defval;
-		return 0;
+			value &=3D ~opt->defval;
+		return set_int_value(opt, flags, value);
+	}
=20
 	case OPTION_BITOP:
 		if (unset)
@@ -643,11 +646,11 @@ static void parse_options_check(const struct option =
*opts)
 		switch (opts->type) {
 		case OPTION_SET_INT:
 		case OPTION_BIT:
+		case OPTION_NEGBIT:
 			if (!signed_int_fits(opts->defval, opts->precision))
 				optbug(opts, "has invalid defval");
 			/* fallthru */
 		case OPTION_COUNTUP:
-		case OPTION_NEGBIT:
 		case OPTION_NUMBER:
 		case OPTION_BITOP:
 			if ((opts->flags & PARSE_OPT_OPTARG) ||
diff --git a/parse-options.h b/parse-options.h
index 6501ca3c27..076f88b384 100644
=2D-- a/parse-options.h
+++ b/parse-options.h
@@ -250,6 +250,7 @@ struct option {
 	.short_name =3D (s), \
 	.long_name =3D (l), \
 	.value =3D (v), \
+	.precision =3D sizeof(*v), \
 	.help =3D (h), \
 	.flags =3D PARSE_OPT_NOARG, \
 	.defval =3D (b), \
=2D-=20
2.50.0
