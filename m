Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B84C20B7ED
	for <git@vger.kernel.org>; Sun, 29 Jun 2025 11:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751197870; cv=none; b=e0T9RriRQ8Jz7RbIjWJvtU7oBVJRPOggmxjMvsTRR+rZdR8lUs9LfoltzaIMO1nQv8VmyEudxA0yAddhfRr7+Sq8vzjwyc30nyLzigWX5tu+DY42KEDeqkQQLJAzdHFKNpTqXFyM9hSbUSeAAlkcFVtZdlsiiLCjhNjiQ7qmUhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751197870; c=relaxed/simple;
	bh=HJhChh/ObGXKH30Z183pIVnI/NdC5I239lt/Ip8yg8U=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=kHy32DcIEurSOK67sNllryQFZGy7tNWlzw6U3FKWaJZsvuLfnwZ9JecXkYie+arMIOq5N+Cgue8dfZQs8c0iDxqvnXF43SAFlS0Fv1aG1teo+u7zpIAGTLbuMdE95lj7aTLUgxpcDIlUey+g0LN9QYJaEOfALaxIuBlXGAjphaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=BbCXgjXo; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="BbCXgjXo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1751197866; x=1751802666; i=l.s.r@web.de;
	bh=Hj8DTULybergtSkrHlaVQV52r4zupQEaZAsH8TCRM+g=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=BbCXgjXo0zyxI9CaQ6vt8ShGUawNh0Ook/bOq1vr+FKTJNtSvZToFTuY6T+zC+A9
	 lCcPCLT0E+kKMVzcSKZq5P1ihPaFffQdcPaHNHMfC4gKC4fQExIPjmcGgGdMSCY2a
	 0mrcL44W7rtPCXckYrFLT7PM42iopvV5EpEFrxEt303OuBadaAwfW3UT2h+c0vwWS
	 uQVbFs+UZIdnNpc8G7FazJMoe808T8lcwta0w+bF5Ob15kuPc24QAuirexEyTedj/
	 HjpHzJ2pbRNsllJguAyZquKwpyufhPdOnbZdmFmCSAUiCPO7Ax7IVxCX+isaqH32y
	 OpSrP2/kKp3bD1rJWA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.28.103]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MQPdr-1uISa31fyj-00Wy3a; Sun, 29
 Jun 2025 13:51:06 +0200
Message-ID: <b0f69c3d-d0a0-4137-ad09-4f46dedc0dab@web.de>
Date: Sun, 29 Jun 2025 13:51:06 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 4/6] parse-options: add precision handling for OPTION_NEGBIT
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
Cc: Patrick Steinhardt <ps@pks.im>
References: <cf5cd57d-733f-4239-80f8-23bdc1523ab2@web.de>
Content-Language: en-US
In-Reply-To: <cf5cd57d-733f-4239-80f8-23bdc1523ab2@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vkl0PwwpG38UPaVzfk9bWArGKvEwCDS+VyFFCsXUqNlpqqxIljs
 yuEe++/NDvoJ8WMSa0/k3DT5gFUe+a0+91igq6osADAivjGaBAC/tIbdKJ7JsQXfrDxI1om
 QilEnyTFt3+xpn+BtSlFY/0+yaamb2MrqCyrQ7SZyxxptN5m+uD/C5+jANFIbNmwrXjc1ft
 4sIJ8vS5C6FiqcG6D5PVw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MzC95iAOiao=;Ts8fFWolPAyW72MY6BL86rPxYkN
 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
 cQ==

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
index 47a77d2cea..6bd7158806 100644
=2D-- a/parse-options.c
+++ b/parse-options.c
@@ -146,11 +146,14 @@ static enum parse_opt_result do_get_value(struct par=
se_opt_ctx_t *p,
 	}
=20
 	case OPTION_NEGBIT:
+	{
+		intmax_t value =3D get_int_value(opt);
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
@@ -622,11 +625,11 @@ static void parse_options_check(const struct option =
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
 			if ((opts->flags & PARSE_OPT_OPTARG) ||
 			    !(opts->flags & PARSE_OPT_NOARG))
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
