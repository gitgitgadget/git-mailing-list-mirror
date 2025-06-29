Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05ECB204C0C
	for <git@vger.kernel.org>; Sun, 29 Jun 2025 11:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751197836; cv=none; b=L0aJLMErK/IRnFfw+mq8ej6xjKFpm1PLP1orCrDYoLPkYx8enVAULnAyLqZ+CMGDjb/wvnnNW1ojqHWkoGvYtsYjFVQ8mnbhmSA1tT5Y8NIVtdHBAfVbjhfqfGOQbScUqH9lr/kxZZpVz5ar/GH0HeZE2N7mZ9wW+JtEa1eBXtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751197836; c=relaxed/simple;
	bh=pKfzGYvHPHftdvKMj8I8ckGFtXp5JZ2XfbNSgLjOjGU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=PK8OvUdo3bXfeHK1YRD3SpBio507NtoCFE0qIASS9MiR8WI3iiBKBY+aVBKGobdN9MKYgQat0YpZaHItR71rYcGbDR8Mq4vm7b8nArArtUf8q2y3trnwcI6O7ts/bMZog6XAUsPkiwIN3vyaB7hq6Lr+N40MwoGAYNX7Yic92Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=NkUY3AHO; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="NkUY3AHO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1751197832; x=1751802632; i=l.s.r@web.de;
	bh=6nN2X8LX6tg+AZadA1nWZt4CHMefDdd04vn6DBDT9yI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=NkUY3AHO7olqXnO3KKWqNGr+M9FmPdZ0DI6mSra0JuNs4K635eSKnBRP8t4UpIsH
	 AinzwpsvsFbTcterpSx3TRbQa5uR9aI9cIoAmZ/MlleFqnso/0RCRAxWJEeoQ/xZv
	 kh92lebxuOOypBCRKPFGwvrl7zFRjoNefL8Pl+t5mc4sbYJV5gcSZEDe/b/Npo4Oj
	 fsRxftTteF4Cn6xD7i6BiF6bgYblynUc6VfkRhyCVKO/mrZ8X76VN14I24G3U1iG3
	 Sq+qIFjo7GKzyPtBaUxRXp8gSR7W+S/mzibi0J8wSbUHJzLS+Cmq0SB9BDxXvq+Hj
	 FTKePJXOdy2lXOW5eA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.28.103]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MxpmW-1uvurB3cp4-016Aub; Sun, 29
 Jun 2025 13:50:31 +0200
Message-ID: <d92697a6-5367-4412-88db-164ba4dd6230@web.de>
Date: Sun, 29 Jun 2025 13:50:31 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 1/6] parse-options: add precision handling for
 PARSE_OPT_CMDMODE
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
Cc: Patrick Steinhardt <ps@pks.im>
References: <cf5cd57d-733f-4239-80f8-23bdc1523ab2@web.de>
Content-Language: en-US
In-Reply-To: <cf5cd57d-733f-4239-80f8-23bdc1523ab2@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Z+pKq9+F0F2n1xn75Qh457SONMNYhVC/yZmBMWKCf4+t/YN/PBl
 ivZrAO0Mq8tvRfEtGX4J7dZ5CZSDLG+Y2sYFDF2sz9OOv1Uwn3I+cqE4cVjX+UQJPut8/K0
 izW3AVAoFXx73Typ+6A3MigMJ8+sdtee2li9fMm7f1xxIOvf3X0U+AbWDu/IUfYZYTaMc/U
 I/G3ANdEPs6m2EMGfSEPg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WjG/51QKSO0=;dH6jUTOEGG6foCZhl21bgx/JB85
 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
 vPCQwAIq/C8liKOzLaeg7a8=

Build on 09705696f7 (parse-options: introduce precision handling for
`OPTION_INTEGER`, 2025-04-17) to support value variables of different
sizes for PARSE_OPT_CMDMODE options.  Do that by requiring their
"precision" to be set and casting their "value" pointer accordingly.

get_value() needs to access all PARSE_OPT_CMDMODE values in addition to
the actual value it is supposed to get to detect conflicting changes.
Give it an example struct option pointer in cmdmode_list instead of just
the "value" pointer to allow it to use the proper "precision".

Use optbug() in get_int_value() to report options with unsupported
"precision" values without requiring enum opt_parsed flags, as we don't
have them in build_cmdmode_list().  Use BUG right afterwards to abort
for uses outside of build_cmdmode_list() by aborting immediately.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/am.c                  |  1 +
 parse-options.c               | 36 ++++++++++++++++++++++++++---------
 parse-options.h               |  1 +
 t/helper/test-parse-options.c | 13 ++++++++++---
 4 files changed, 39 insertions(+), 12 deletions(-)

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
index a9a39ecaef..da07a000a3 100644
=2D-- a/parse-options.c
+++ b/parse-options.c
@@ -68,6 +68,23 @@ static char *fix_filename(const char *prefix, const cha=
r *file)
 		return prefix_filename_except_for_dash(prefix, file);
 }
=20
+static intmax_t get_int_value(const struct option *opt)
+{
+	switch (opt->precision) {
+	case sizeof(int8_t):
+		return *(int8_t *)opt->value;
+	case sizeof(int16_t):
+		return *(int16_t *)opt->value;
+	case sizeof(int32_t):
+		return *(int32_t *)opt->value;
+	case sizeof(int64_t):
+		return *(int64_t *)opt->value;
+	default:
+		optbug(opt, "has invalid precision");
+		BUG("invalid 'struct option'");
+	}
+}
+
 static enum parse_opt_result do_get_value(struct parse_opt_ctx_t *p,
 					  const struct option *opt,
 					  enum opt_parsed flags,
@@ -266,8 +283,8 @@ static enum parse_opt_result do_get_value(struct parse=
_opt_ctx_t *p,
 }
=20
 struct parse_opt_cmdmode_list {
-	int value, *value_ptr;
-	const struct option *opt;
+	intmax_t value;
+	const struct option *opt, *reference_opt;
 	const char *arg;
 	enum opt_parsed flags;
 	struct parse_opt_cmdmode_list *next;
@@ -280,19 +297,18 @@ static void build_cmdmode_list(struct parse_opt_ctx_=
t *ctx,
=20
 	for (; opts->type !=3D OPTION_END; opts++) {
 		struct parse_opt_cmdmode_list *elem =3D ctx->cmdmode_list;
-		int *value_ptr =3D opts->value;
=20
-		if (!(opts->flags & PARSE_OPT_CMDMODE) || !value_ptr)
+		if (!(opts->flags & PARSE_OPT_CMDMODE) || !opts->value)
 			continue;
=20
-		while (elem && elem->value_ptr !=3D value_ptr)
+		while (elem && elem->reference_opt->value !=3D opts->value)
 			elem =3D elem->next;
 		if (elem)
 			continue;
=20
 		CALLOC_ARRAY(elem, 1);
-		elem->value_ptr =3D value_ptr;
-		elem->value =3D *value_ptr;
+		elem->reference_opt =3D opts;
+		elem->value =3D get_int_value(opts);
 		elem->next =3D ctx->cmdmode_list;
 		ctx->cmdmode_list =3D elem;
 	}
@@ -317,7 +333,9 @@ static enum parse_opt_result get_value(struct parse_op=
t_ctx_t *p,
 	char *opt_name, *other_opt_name;
=20
 	for (; elem; elem =3D elem->next) {
-		if (*elem->value_ptr =3D=3D elem->value)
+		intmax_t new_value =3D get_int_value(elem->reference_opt);
+
+		if (new_value =3D=3D elem->value)
 			continue;
=20
 		if (elem->opt &&
@@ -327,7 +345,7 @@ static enum parse_opt_result get_value(struct parse_op=
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
