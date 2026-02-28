Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9EC2727FC
	for <git@vger.kernel.org>; Sat, 28 Feb 2026 09:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772270363; cv=none; b=bzfFTahHhjz2cErszkFu2pHuehCWPC+MgetzBYdUP3/kg8FCJUCRrF1vQEznWfQaJBi01YxGFVlpW5J7l91CrluNXpGiubgoMCbyf4GVCXG8ci+qeB6M/dSNAAw9mZSWO9M+LEcPqF9yaeW+zN707S0KoKaAzCFLD67+bBmg2tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772270363; c=relaxed/simple;
	bh=KXiwp+/vp0BXjO162dI2v0hxg/Bj2qZDF5eae3j20HA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:Cc:
	 In-Reply-To:Content-Type; b=m8OoHRX6yiAuJHqVQwmTECMKMJwNy0U1pZFAW+CJWLGriphxYIldHO01t4vnQgt5ABwD05zK258B0u3POR82J+50frzlVsklx+sGfT3yliilqYOe4YF2ehMkZAJF/YY2Qw8uaCnGerWzHFvkcrvqvfzc82Gd7luPg+q3HZQbnP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=ert2G71n; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="ert2G71n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1772270357; x=1772875157; i=l.s.r@web.de;
	bh=nKQbuFMBBrg77M4RnXylbenuEerqaRfV/NhP4W8ZXd0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 References:Cc:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ert2G71ntLjkVV+6NiCL8RU3EOAkwvqUbZOGbd/TnBw9mBw2EFNPbP8ot1zdht8K
	 dg5A4za+G3TVp7uIZPgz8tpqlAWGujh8hKXTtsx+WGR6//8ewXW2ks0D8sXZffLKB
	 eCfbvvpUUYtbP59ZJTiqqqJHAk/IlkYxI7FxDJ0giSjszI/p4Gd0zrHequlEXqpZj
	 cnRyqTmEsESKvP8it8zK6U6NwXOaQ/cIvve59bqGMSYUFJLxQZa/mHv/HUdPNWYF6
	 FQiOAwrOPTjnbAlglVY4PRE9YOL/koERg9Fvp/W/PtyP8/NzcWipa+jbqpN6zfIHP
	 S31srRx86/9ITGGnbQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N2SKz-1vYnaU0Wh5-017xTr; Sat, 28
 Feb 2026 10:19:17 +0100
Message-ID: <6b674316-9a6e-4f57-b32c-f1824869ba7e@web.de>
Date: Sat, 28 Feb 2026 10:19:16 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 2/2] parseopt: check for duplicate long names and numerical
 options
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqq5x7jujqb.fsf@gitster.g>
 <7693799a-91a2-480a-ae3e-29f8eed5b55a@web.de>
Content-Language: en-US
Cc: Jeff King <peff@peff.net>
In-Reply-To: <7693799a-91a2-480a-ae3e-29f8eed5b55a@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/UFBz+RoEmXlc3UKxUVjhzUEXJbDBU6MBBPAtoCt6MxbyFC6YW5
 8x4QqaGPyjOXdF4liEj05YLi+yt/yb/a331h5HnnHzT50e/MvKEoc3yUTPcD4Bp0hgN4mxv
 ESVXNA2pRsw1bNhDMjXb0dAhVJlsr9wc8tvXVBUNEht1vdUKbg/vGDEXcBgyeVZ8dd1hoa4
 aqm3r/zRbmTB3g1R+oOTQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Lm3HYcGxpUU=;zjlWLFuEMiP2eQSjcyJxlub4Wga
 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
 YikNY0rj8LV0Ue42xRRy2QUX44dfr

We already check for duplicate short names.  Check for and report
duplicate long names and numerical options as well.

Perform the slightly expensive string duplicate check only when showing
the usage to keep the cost of normal invocations low.  t0012-help.sh
covers it.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Changes since v1:
- Removed strset_contains() call.
- Only check for duplicate long names when showing the usage.

 parse-options.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/parse-options.c b/parse-options.c
index c9cafc21b9..0214c106d4 100644
=2D-- a/parse-options.c
+++ b/parse-options.c
@@ -5,6 +5,7 @@
 #include "gettext.h"
 #include "strbuf.h"
 #include "string-list.h"
+#include "strmap.h"
 #include "utf8.h"
=20
 static int disallow_abbreviated_options;
@@ -641,6 +642,7 @@ static void check_typos(const char *arg, const struct =
option *options)
 static void parse_options_check(const struct option *opts)
 {
 	char short_opts[128];
+	bool saw_number_option =3D false;
 	void *subcommand_value =3D NULL;
=20
 	memset(short_opts, '\0', sizeof(short_opts));
@@ -655,6 +657,11 @@ static void parse_options_check(const struct option *=
opts)
 			else if (short_opts[opts->short_name]++)
 				optbug(opts, "short name already used");
 		}
+		if (opts->type =3D=3D OPTION_NUMBER) {
+			if (saw_number_option)
+				optbug(opts, "duplicate numerical option");
+			saw_number_option =3D true;
+		}
 		if (opts->flags & PARSE_OPT_NODASH &&
 		    ((opts->flags & PARSE_OPT_OPTARG) ||
 		     !(opts->flags & PARSE_OPT_NOARG) ||
@@ -714,6 +721,19 @@ static void parse_options_check(const struct option *=
opts)
 	BUG_if_bug("invalid 'struct option'");
 }
=20
+static void parse_options_check_harder(const struct option *opts)
+{
+	struct strset long_names =3D STRSET_INIT;
+	for (; opts->type !=3D OPTION_END; opts++) {
+		if (opts->long_name) {
+			if (!strset_add(&long_names, opts->long_name))
+				optbug(opts, "long name already used");
+		}
+	}
+	BUG_if_bug("invalid 'struct option'");
+	strset_clear(&long_names);
+}
+
 static int has_subcommands(const struct option *options)
 {
 	for (; options->type !=3D OPTION_END; options++)
@@ -1339,6 +1359,8 @@ static enum parse_opt_result usage_with_options_inte=
rnal(struct parse_opt_ctx_t
 	const char *prefix =3D usage_prefix;
 	int saw_empty_line =3D 0;
=20
+	parse_options_check_harder(opts);
+
 	if (!usagestr)
 		return PARSE_OPT_HELP;
=20
=2D-=20
2.53.0
