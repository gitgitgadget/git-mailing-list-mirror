Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE0A287248
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 09:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752054322; cv=none; b=TMFRP35ECgo34C5/cs7ZaeDk8QJWUvomvmQs669UamQGIe+fuJFEfMIZv3eaKrg9rPhcuiVv3UPf5Cn9QHeIjgsGpsdGsfNA23Lb//1neynuVkGOZufpYoJDYGDr+218l/+pfxvqu838Q8fG9GrG6obBFKrTuzRWLouzcsvlTHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752054322; c=relaxed/simple;
	bh=SN8gZB6DFWgX2Fkdir4nwCApLBqLUOvXWbEw8OkyjuA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=n0BiKg9Z79ftfae1wYVYGbAe+VuE4EYzqgrHjrtdRk5+edJn0bzXw6b8fR/+6jSmkOgFo5MWplrZNSepfO7LZ52/tkr9T62YuO1cEw+cEWe/ThvxELNZynOsyDS6bjQ/EroJktQeN9xdQgLIeqQLWQfvhPfwKoneVGjcPOJ0wZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=qcBvTi5d; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="qcBvTi5d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1752054315; x=1752659115; i=l.s.r@web.de;
	bh=aPOOcg9JRlcKbzIW5o5Rgr3I0nIFX7MtDs5VW+RZwjU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=qcBvTi5diU/I8g6Va9vlesixMRL1JLl5lm6rUadtgyTWBM0hsZk9jkOgdcGswisH
	 l6z4AGdq2ND78Xj85Mdzc1r4Yawara3ayuRengJ2c32Mdlm5sQbQXIPYgilOT0bfe
	 a6OWHX4v7DysKaEXvXj2W+5A82FwX39hj0mgiPaPYpGDMWG2CW7kP7bBGhdRg0PSR
	 WsHefzR1LXRrbKr9KdvuAq1+DjgfDhOP7jl8aWYBQ3S+ab7qyJUpwKHDAcuRD3Oii
	 NW13oqd4bnvX9eguK8X34ZzSBaH12tFvCoe9SLpP/xX9w0Zp+aHgNQzBCSkAUjE6Y
	 qT9aCFoATvkD9Nr77Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.28.103]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MMp8Y-1uGoaE3ELE-00RDHP; Wed, 09
 Jul 2025 11:45:14 +0200
Message-ID: <77b841ea-eab1-4e76-98ff-f7a16653fcb8@web.de>
Date: Wed, 9 Jul 2025 11:45:14 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 2/7] parse-options: add precision handling for
 PARSE_OPT_CMDMODE
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
Cc: Patrick Steinhardt <ps@pks.im>
References: <cf5cd57d-733f-4239-80f8-23bdc1523ab2@web.de>
 <802eba72-c100-429a-80b7-7a0e8b6559ed@web.de>
Content-Language: en-US
In-Reply-To: <802eba72-c100-429a-80b7-7a0e8b6559ed@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:j3rSWP6WF/ZHwMsuToMVbM6baeTk/6xWgtgogMY9XXF5rBNhDMC
 kXmOveqIZDxFfNzY6C6YiHQ8LOR9YTEOu0QOIeH9vJWD/ksp4tPCOVQ7RuOW1H9/x9OndPe
 w/NS/aSfoQq9uRtm+PrqeA/7o5pNo5XcMU0XLzgRbehLuX3SkCg8uaWxMTesTXejPIDKAx2
 o0/qLGCD5JdzyNqvg8l4A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yQjSTX6B8Bk=;pyRTdiLO+0iCL/S8PnHo2iq9G7U
 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

Build on 09705696f7 (parse-options: introduce precision handling for
`OPTION_INTEGER`, 2025-04-17) to support value variables of different
sizes for PARSE_OPT_CMDMODE options.  Do that by requiring their
"precision" to be set and casting their "value" pointer accordingly.

Call the function that does the raw casting do_get_int_value() to
reserve the name get_int_value() for a more friendly wrapper we're
going to introduce in one of the next patches.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/am.c                  |  1 +
 parse-options.c               | 41 ++++++++++++++++++++++++++++++-----
 parse-options.h               |  1 +
 t/helper/test-parse-options.c | 13 ++++++++---
 4 files changed, 48 insertions(+), 8 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index a800003340..c9d925f7b9 100644
=2D-- a/builtin/am.c
+++ b/builtin/am.c
@@ -2406,6 +2406,7 @@ int cmd_am(int argc,
 			.type =3D OPTION_CALLBACK,
 			.long_name =3D "show-current-patch",
 			.value =3D &resume_mode,
+			.precision =3D sizeof(resume_mode),
 			.argh =3D "(diff|raw)",
 			.help =3D N_("show the patch being applied"),
 			.flags =3D PARSE_OPT_CMDMODE | PARSE_OPT_OPTARG | PARSE_OPT_NONEG | PA=
RSE_OPT_LITERAL_ARGHELP,
diff --git a/parse-options.c b/parse-options.c
index 68ff494492..ddac008a5e 100644
=2D-- a/parse-options.c
+++ b/parse-options.c
@@ -68,6 +68,26 @@ static char *fix_filename(const char *prefix, const cha=
r *file)
 		return prefix_filename_except_for_dash(prefix, file);
 }
=20
+static int do_get_int_value(const void *value, size_t precision, intmax_t=
 *ret)
+{
+	switch (precision) {
+	case sizeof(int8_t):
+		*ret =3D *(int8_t *)value;
+		return 0;
+	case sizeof(int16_t):
+		*ret =3D *(int16_t *)value;
+		return 0;
+	case sizeof(int32_t):
+		*ret =3D *(int32_t *)value;
+		return 0;
+	case sizeof(int64_t):
+		*ret =3D *(int64_t *)value;
+		return 0;
+	default:
+		return -1;
+	}
+}
+
 static enum parse_opt_result do_get_value(struct parse_opt_ctx_t *p,
 					  const struct option *opt,
 					  enum opt_parsed flags,
@@ -266,7 +286,9 @@ static enum parse_opt_result do_get_value(struct parse=
_opt_ctx_t *p,
 }
=20
 struct parse_opt_cmdmode_list {
-	int value, *value_ptr;
+	intmax_t value;
+	void *value_ptr;
+	size_t precision;
 	const struct option *opt;
 	const char *arg;
 	enum opt_parsed flags;
@@ -280,7 +302,7 @@ static void build_cmdmode_list(struct parse_opt_ctx_t =
*ctx,
=20
 	for (; opts->type !=3D OPTION_END; opts++) {
 		struct parse_opt_cmdmode_list *elem =3D ctx->cmdmode_list;
-		int *value_ptr =3D opts->value;
+		void *value_ptr =3D opts->value;
=20
 		if (!(opts->flags & PARSE_OPT_CMDMODE) || !value_ptr)
 			continue;
@@ -292,10 +314,13 @@ static void build_cmdmode_list(struct parse_opt_ctx_=
t *ctx,
=20
 		CALLOC_ARRAY(elem, 1);
 		elem->value_ptr =3D value_ptr;
-		elem->value =3D *value_ptr;
+		elem->precision =3D opts->precision;
+		if (do_get_int_value(value_ptr, opts->precision, &elem->value))
+			optbug(opts, "has invalid precision");
 		elem->next =3D ctx->cmdmode_list;
 		ctx->cmdmode_list =3D elem;
 	}
+	BUG_if_bug("invalid 'struct option'");
 }
=20
 static char *optnamearg(const struct option *opt, const char *arg,
@@ -317,7 +342,13 @@ static enum parse_opt_result get_value(struct parse_o=
pt_ctx_t *p,
 	char *opt_name, *other_opt_name;
=20
 	for (; elem; elem =3D elem->next) {
-		if (*elem->value_ptr =3D=3D elem->value)
+		intmax_t new_value;
+
+		if (do_get_int_value(elem->value_ptr, elem->precision,
+				     &new_value))
+			BUG("impossible: invalid precision");
+
+		if (new_value =3D=3D elem->value)
 			continue;
=20
 		if (elem->opt &&
@@ -327,7 +358,7 @@ static enum parse_opt_result get_value(struct parse_op=
t_ctx_t *p,
 		elem->opt =3D opt;
 		elem->arg =3D arg;
 		elem->flags =3D flags;
-		elem->value =3D *elem->value_ptr;
+		elem->value =3D new_value;
 	}
=20
 	if (result || !elem)
diff --git a/parse-options.h b/parse-options.h
index 91c3e3c29b..c75a473c9e 100644
=2D-- a/parse-options.h
+++ b/parse-options.h
@@ -269,6 +269,7 @@ struct option {
 	.short_name =3D (s), \
 	.long_name =3D (l), \
 	.value =3D (v), \
+	.precision =3D sizeof(*v), \
 	.help =3D (h), \
 	.flags =3D PARSE_OPT_CMDMODE|PARSE_OPT_NOARG|PARSE_OPT_NONEG | (f), \
 	.defval =3D (i), \
diff --git a/t/helper/test-parse-options.c b/t/helper/test-parse-options.c
index f2663dd0c0..1e03ff88f6 100644
=2D-- a/t/helper/test-parse-options.c
+++ b/t/helper/test-parse-options.c
@@ -148,9 +148,16 @@ int cmd__parse_options(int argc, const char **argv)
 		OPT_SET_INT(0, "set23", &integer, "set integer to 23", 23),
 		OPT_CMDMODE(0, "mode1", &integer, "set integer to 1 (cmdmode option)", =
1),
 		OPT_CMDMODE(0, "mode2", &integer, "set integer to 2 (cmdmode option)", =
2),
-		OPT_CALLBACK_F(0, "mode34", &integer, "(3|4)",
-			"set integer to 3 or 4 (cmdmode option)",
-			PARSE_OPT_CMDMODE, mode34_callback),
+		{
+			.type =3D OPTION_CALLBACK,
+			.long_name =3D "mode34",
+			.value =3D &integer,
+			.precision =3D sizeof(integer),
+			.argh =3D "(3|4)",
+			.help =3D "set integer to 3 or 4 (cmdmode option)",
+			.flags =3D PARSE_OPT_CMDMODE,
+			.callback =3D mode34_callback,
+		},
 		OPT_CALLBACK('L', "length", &integer, "str",
 			"get length of <str>", length_callback),
 		OPT_FILENAME('F', "file", &file, "set file to <file>"),
=2D-=20
2.50.0
