Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FA321579F
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 09:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752054385; cv=none; b=DkffSn0MlHsCld7afB9yiybwYE/LSGfex/9mgcwGfZsGibEFudVIYN6MM/d9Z1+OV1P9LBLzbGUXdbmzPc2aBKnh5hJu0wbyvctP4QQSNed/hhB19xRHEHhYETWz+co65UnuSIY/LHDIvr7pTDeF60rHOCNRER2Z0oxj+cbaQBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752054385; c=relaxed/simple;
	bh=DWNpGeySwMSZp1f3J9d/JNTGPMNiJORA/1+mxl5wXVs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=o0XAMIKk2Pl77nEBWLQR/C3uKxG/TY+6ppg1ExICuKmLRi/B7f8zDwyPfZZ6kbxsGMqgsIsMKpgwawnb5t9d5mC4DPSc7Ecn3dNcINiG+x0Y/GHKwvs3erqPfDq3loO32t3S2e/2aV4ODCE0hNSYm8xaYOJu8RXprP3vht+Wdng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=Vi7Fb2Jv; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="Vi7Fb2Jv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1752054381; x=1752659181; i=l.s.r@web.de;
	bh=ghPeciNnc1m4LQKK2KZf9BWUJCWRVpGVn7yOoZ0inbc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Vi7Fb2JvrJQDkIiUG3iCpbSwHVGe8+qBmFlRw9b15xEA95dU5qGyqbEfEvk7iaO2
	 Ne/yuHIKDbbkM5/lSGhQEkIJmhmPJUXLpd8tYRdi4aiRW/PVoNe/r2e8Z+d6wS1NG
	 7iE1YgbdirOEQRtv4/90J58ozak7vJ0iB/ks60YbhbCNysMHb9u6g5DCV/SrpFm84
	 jQgQSQRefNAiefnPymqTgDWmvlrwNuYE84q3TcdPzrFvoxo8Yt1PqcdZGCOPWwhXe
	 Lr7BRquoyT8bKgjoGg0tHUUbecqj5dzoawdf43uJIjEgsSks4SZE8nVczCfS/LW1V
	 zoRXhh3Y8gaEfoivFw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.28.103]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N8Elm-1umnKX0WtU-00wv2H; Wed, 09
 Jul 2025 11:46:21 +0200
Message-ID: <62725f95-a732-4ad3-ba55-0bfe4de7f1f3@web.de>
Date: Wed, 9 Jul 2025 11:46:20 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 6/7] parse-options: add precision handling for OPTION_BITOP
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
Cc: Patrick Steinhardt <ps@pks.im>
References: <cf5cd57d-733f-4239-80f8-23bdc1523ab2@web.de>
 <802eba72-c100-429a-80b7-7a0e8b6559ed@web.de>
Content-Language: en-US
In-Reply-To: <802eba72-c100-429a-80b7-7a0e8b6559ed@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:c/vdhnjjQU2Y3/syuHSTMFe7hKHGUGHlLUA1bNsMgRfbe39Yeip
 IeOLFuSoA4fnCubq7KWy2Q9vysMLI2wQf4P/sOdWPypG9Bdq0cw7c24rz1iDVBF4WnzOoDt
 iNZPqQN/10lOy2e0haV//kuobR2rLTn3oinh33Ll7gFFS+OonMjX/IvO3dwhPtoDMMYberX
 O86bzZoySr41bEsT2swbA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:BiDEZNWyz/M=;djwQ7AP8wqxM3HkUtNtjDzSqOCG
 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
 mRZF1Uo1PRg==

Similar to 09705696f7 (parse-options: introduce precision handling for
`OPTION_INTEGER`, 2025-04-17) support value variables of different sizes
for OPTION_BITOP.  Do that by requiring their "precision" to be set,
casting their "value" pointer accordingly and checking whether the value
fits.

Check if "devfal" fits into an integer variable with the given
"precision", but don't check "extra", as its value is only used to clear
bits, so cannot lead to an overflow.  Not checking continues to allow
e.g., using -1 to clear all bits even if the value variable has a
narrower type than intptr_t.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 parse-options.c | 11 +++++++----
 parse-options.h |  1 +
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index ba89dc4d09..a813511b1b 100644
=2D-- a/parse-options.c
+++ b/parse-options.c
@@ -167,11 +167,14 @@ static enum parse_opt_result do_get_value(struct par=
se_opt_ctx_t *p,
 	}
=20
 	case OPTION_BITOP:
+	{
+		intmax_t value =3D get_int_value(opt, flags);
 		if (unset)
 			BUG("BITOP can't have unset form");
-		*(int *)opt->value &=3D ~opt->extra;
-		*(int *)opt->value |=3D opt->defval;
-		return 0;
+		value &=3D ~opt->extra;
+		value |=3D opt->defval;
+		return set_int_value(opt, flags, value);
+	}
=20
 	case OPTION_COUNTUP:
 		if (*(int *)opt->value < 0)
@@ -647,12 +650,12 @@ static void parse_options_check(const struct option =
*opts)
 		case OPTION_SET_INT:
 		case OPTION_BIT:
 		case OPTION_NEGBIT:
+		case OPTION_BITOP:
 			if (!signed_int_fits(opts->defval, opts->precision))
 				optbug(opts, "has invalid defval");
 			/* fallthru */
 		case OPTION_COUNTUP:
 		case OPTION_NUMBER:
-		case OPTION_BITOP:
 			if ((opts->flags & PARSE_OPT_OPTARG) ||
 			    !(opts->flags & PARSE_OPT_NOARG))
 				optbug(opts, "should not accept an argument");
diff --git a/parse-options.h b/parse-options.h
index 076f88b384..8bdf469ae9 100644
=2D-- a/parse-options.h
+++ b/parse-options.h
@@ -240,6 +240,7 @@ struct option {
 	.short_name =3D (s), \
 	.long_name =3D (l), \
 	.value =3D (v), \
+	.precision =3D sizeof(*v), \
 	.help =3D (h), \
 	.flags =3D PARSE_OPT_NOARG|PARSE_OPT_NONEG, \
 	.defval =3D (set), \
=2D-=20
2.50.0
