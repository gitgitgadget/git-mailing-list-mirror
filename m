Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5FC204C0C
	for <git@vger.kernel.org>; Sun, 29 Jun 2025 11:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751197886; cv=none; b=TxJjPGRqXpO/DqwTOrYtMEouDl+9j0ripBRDrHLVa+abk0CvPBe56DOa44IuFQhsZkq196+YrN3pMLswl31fsDE1hDYVySwqpmNfDmQwtnxCbXWbEVpzUqTrYNbkcbsLduzd+Y6RYR2g09PJkQ0PtjBi2MFcd++kGgwwCnFGZs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751197886; c=relaxed/simple;
	bh=PLwa+cmE4psITwhuVBtjQ1/+G4r+cfNVJ/M4J2zzPik=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=GdP+NcYBY8Jq4AS93I55MyFbASd24sDl5Vjzg5P6UHNEox91592tTIxVk2YCrngsM4YbTcw9XwH76DNZB9PLm/frH74hgm6Z0keoAtRwr+feilwJhZmAeqxNQXty9u3tc1Sv9R+z8raD0LqZfkN4rdGOb/gVkC5SJ4x4Sf5gEKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=Nbc1qokG; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="Nbc1qokG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1751197880; x=1751802680; i=l.s.r@web.de;
	bh=OfAjA3pkWNtJ6peE4ajgV4TKlKbIXKDxC6ZNFtQafp8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Nbc1qokGW5FXTqU33yiXI8mFQ88RyEf67x/SV1ROQe+NfduR7HVmPaVdVVoiqW3x
	 UdKv3KmH18hh5PUlV9Ux/2knUazwjxPgKyL7pXWmlpuuaqR6h6Dsm6Q62xMHPcne1
	 omCfT+HwAo7NZzHH23sxgsEaQxI66Z5WVTZr92j2w9ym/Hpfo65PU/R3zN191Q2dV
	 CYxl4ROZ0YYsCiPVg2bjIlweKeqXfMI+ZY3ENwYCouGrD5b56YK4nIAMujpjQz9ly
	 wLyJClFbRw9q3erExNVb6TO067pYq1yLHOtfUlHKoP1SkE3Fwbh3ucj9x5Tyo5Gln
	 S1U3NcQaK+H9i9d0Qw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.28.103]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MtyA2-1uqwmp2xrQ-011FF2; Sun, 29
 Jun 2025 13:51:19 +0200
Message-ID: <7b970f48-05a8-40c6-8e5b-95ce830705c0@web.de>
Date: Sun, 29 Jun 2025 13:51:19 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 5/6] parse-options: add precision handling for OPTION_BITOP
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
Cc: Patrick Steinhardt <ps@pks.im>
References: <cf5cd57d-733f-4239-80f8-23bdc1523ab2@web.de>
Content-Language: en-US
In-Reply-To: <cf5cd57d-733f-4239-80f8-23bdc1523ab2@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:34e4upV+QSLIimZxwIPMb1AZUPYurhn/TC8Hb2Tapit9PJb6h9h
 TJ0jhWUJ0swprLPp7qcim8Ddn8WsDUere6FrO+0yKFouabJeyVc3/o7Gt74EbevwfqeYy6t
 Z57pnbqfKYv8g6FExCexzo7A4pZ5U/B4I3mPlWbEmCCKxEVx6sMRzWKWYRBJFovEP4zkN9T
 VQ26sQHCo9QqkiUFOJ+/w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3AeBW6NtVQc=;CEUToczJe9uSCscf+lMcrwIGPg4
 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
 uhQY1kgvbC9cmoCTrH/vHRLnzOwYPjoQ=

Similar to 09705696f7 (parse-options: introduce precision handling for
`OPTION_INTEGER`, 2025-04-17) support value variables of different sizes
for OPTION_BITOP.  Do that by requiring their "precision" to be set,
casting their "value" pointer accordingly and checking whether the value
fits.

Checking "defval" has the side-effect of also requiring PARSE_OPT_NOARG.
This is sensible, as OPTION_BITOP doesn't handle any arguments, so we
take this unintended benefit.

Don't check "extra", though, as its value is only used to clear bits, so
cannot lead to an overflow.  Not checking continues to allow e.g., using
-1 to clear all bits even if the value variable has a narrower type than
intptr_t.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 parse-options.c | 10 +++++++---
 parse-options.h |  1 +
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 6bd7158806..0dc9b0324a 100644
=2D-- a/parse-options.c
+++ b/parse-options.c
@@ -156,11 +156,14 @@ static enum parse_opt_result do_get_value(struct par=
se_opt_ctx_t *p,
 	}
=20
 	case OPTION_BITOP:
+	{
+		intmax_t value =3D get_int_value(opt);
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
@@ -626,6 +629,7 @@ static void parse_options_check(const struct option *o=
pts)
 		case OPTION_SET_INT:
 		case OPTION_BIT:
 		case OPTION_NEGBIT:
+		case OPTION_BITOP:
 			if (!signed_int_fits(opts->defval, opts->precision))
 				optbug(opts, "has invalid defval");
 			/* fallthru */
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
