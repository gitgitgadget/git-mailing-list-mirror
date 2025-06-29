Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C935420B7ED
	for <git@vger.kernel.org>; Sun, 29 Jun 2025 11:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751197856; cv=none; b=GnfxgExEG4L93Ytg4vUVheMOueZaFERSlxBNLf4TuJrWsTvMFrI7C/YDuMyzWRthSPXl+uw2QsvgcgFFMH7+9W/rbLtu1h2lfHc8vKjZlpbIoJMNLMNUOLUMbWr+h+4syWPm+Hzpm5mGBq532q2nQpgRcwW22oIDoHcyIN8NClQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751197856; c=relaxed/simple;
	bh=7doDbM1AwlbhffTkyGA8O9bnpl7j+3Va5vCv21adfh0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=IWMnzn04DHFd9x5XS2Y0nj7h/mz/uzyoDO/KI3SjCuHl8doZi4sJDujYmeNQj7BhdBhErJSF0ngm4C7sgSq2uUFoFDyK3DKR6XY7C4jlVk/WlZhjR/JPht1C1mAYrINXCUOPBTFxOJHChwkZ4eitHGjPuDsv8rzvtqtMbdCNM44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=XLXGCO+k; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="XLXGCO+k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1751197852; x=1751802652; i=l.s.r@web.de;
	bh=I970pKLh8CBU2UYP3c2S9zfIH4wtAQ3f6olVhZK1k2E=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=XLXGCO+kPw9OMUF5Uecfj/nDY0n3LJCcRfH2cz5mNAU9XZHm+Os+ag+Ea4pszVMH
	 kCRLIY0+kodKmQD7bqg0X+tTBfduNZBc3s/s6JjGHF1n1v+0rpMkIczcefPJHhN2i
	 Ljx0tNuSHqOFFXCs2FEwlWnI99VzRobCdms3KRuUnOoDt+I0xq66gxecy+VAoqnwe
	 KfE6IDqkRP1g6aUtYHpbyn9Zy1IPaz6O6ZpfVFFkVgVyCVjvM8StgjLR09ifQ1Jy2
	 PjSKr4QY2Y7Or2QSE9gL7dzauyTsgzaHBSR+j/AvOsdCTTAv5yu1JYB3UhmC3cdgn
	 4Xm8DaVf347dlfIQkg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.28.103]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N4627-1ueXmv2jwn-00soZs; Sun, 29
 Jun 2025 13:50:52 +0200
Message-ID: <7be6f365-7904-4086-992a-607d6c638d11@web.de>
Date: Sun, 29 Jun 2025 13:50:52 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 3/6] parse-options: add precision handling for OPTION_BIT
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
Cc: Patrick Steinhardt <ps@pks.im>
References: <cf5cd57d-733f-4239-80f8-23bdc1523ab2@web.de>
Content-Language: en-US
In-Reply-To: <cf5cd57d-733f-4239-80f8-23bdc1523ab2@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qlZpB26GGsAJ82HA268z5SuKWDKnX+lfoalh64mfAmYGYbs5MiL
 ep3TFu3aqEHReFjJa8dmYf4zGsIZVZP2l8X7yakGXnqoO3JDojLpn5YCziyjZmrZCm1CZh3
 xMEzjNjEA4AedKugcJ4g9lZRd3z3evrsQJt19QOu9QH4q6nMymCGYyD0idhAY0mduw8/1NJ
 UXKRkRRL8W/nOhfnfqAHQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:REAtLBYd1u0=;1gJSTUK8VcXhQLycldRQaoZPPu0
 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
 h8Cz1P9HDFQ==

Similar to 09705696f7 (parse-options: introduce precision handling for
`OPTION_INTEGER`, 2025-04-17) support value variables of different sizes
for OPTION_BIT.  Do that by requiring their "precision" to be set,
casting their "value" pointer accordingly and checking whether the value
fits.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/write-tree.c |  1 +
 parse-options.c      | 11 +++++++----
 parse-options.h      |  1 +
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/builtin/write-tree.c b/builtin/write-tree.c
index 5a8dc377ec..cfec044710 100644
=2D-- a/builtin/write-tree.c
+++ b/builtin/write-tree.c
@@ -35,6 +35,7 @@ int cmd_write_tree(int argc,
 			.type =3D OPTION_BIT,
 			.long_name =3D "ignore-cache-tree",
 			.value =3D &flags,
+			.precision =3D sizeof(flags),
 			.help =3D N_("only useful for debugging"),
 			.flags =3D PARSE_OPT_HIDDEN | PARSE_OPT_NOARG,
 			.defval =3D WRITE_TREE_IGNORE_CACHE_TREE,
diff --git a/parse-options.c b/parse-options.c
index bbb68603cc..47a77d2cea 100644
=2D-- a/parse-options.c
+++ b/parse-options.c
@@ -136,11 +136,14 @@ static enum parse_opt_result do_get_value(struct par=
se_opt_ctx_t *p,
 		return opt->ll_callback(p, opt, NULL, unset);
=20
 	case OPTION_BIT:
+	{
+		intmax_t value =3D get_int_value(opt);
 		if (unset)
-			*(int *)opt->value &=3D ~opt->defval;
+			value &=3D ~opt->defval;
 		else
-			*(int *)opt->value |=3D opt->defval;
-		return 0;
+			value |=3D opt->defval;
+		return set_int_value(opt, flags, value);
+	}
=20
 	case OPTION_NEGBIT:
 		if (unset)
@@ -618,11 +621,11 @@ static void parse_options_check(const struct option =
*opts)
 			optbug(opts, "OPTION_SET_INT 0 should not be negatable");
 		switch (opts->type) {
 		case OPTION_SET_INT:
+		case OPTION_BIT:
 			if (!signed_int_fits(opts->defval, opts->precision))
 				optbug(opts, "has invalid defval");
 			/* fallthru */
 		case OPTION_COUNTUP:
-		case OPTION_BIT:
 		case OPTION_NEGBIT:
 		case OPTION_NUMBER:
 			if ((opts->flags & PARSE_OPT_OPTARG) ||
diff --git a/parse-options.h b/parse-options.h
index 71516e4b5b..6501ca3c27 100644
=2D-- a/parse-options.h
+++ b/parse-options.h
@@ -172,6 +172,7 @@ struct option {
 	.short_name =3D (s), \
 	.long_name =3D (l), \
 	.value =3D (v), \
+	.precision =3D sizeof(*v), \
 	.help =3D (h), \
 	.flags =3D PARSE_OPT_NOARG|(f), \
 	.callback =3D NULL, \
=2D-=20
2.50.0
