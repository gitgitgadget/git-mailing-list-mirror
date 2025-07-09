Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FDE2857EA
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 09:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752054332; cv=none; b=YG5zjlTeWcFgq1FqY5BHWfeNk+1kDJhDkeV/rMdjA6C+TpU9T+PXJy5UOSRypYcRXDEr2Qqt7QkyMOBSbVoGhmuAuNeLtt0EESwBJwzcUXUPJBsDRpCQBclSm19aouqxZX7AOJ7fhFbkWnhaGJoo6S+KdKKcgBmem/dm2qCUa+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752054332; c=relaxed/simple;
	bh=YfMMeAUjbyInC2920ZZgrCRJM4FO6O8NZrhvwT2ukAA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=VaNNPgAeneopEofSQuOsx28Ky6T4zY529uo/kr9v89640obhYX5pa7l0TUu8FSzf8ufZA3WiC5mbwP7VSfrQfDDxGC61muQVb/tt8+74aiaBiNJbN2n8tKBRslCyUaDTenj/OPlZ0EptcLx78Reu4iyc3PP/4W7JJKAFh2Iudsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=hEa1ErM4; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="hEa1ErM4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1752054325; x=1752659125; i=l.s.r@web.de;
	bh=zynpyAgdbMObJ89/swIpfngTwuuoBDu8mJdwdKFST0A=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=hEa1ErM4uBt9h38Yr0ODl3epOL0cHZYfJUxECDVHTaZyTkJbzeIwpyZLcnzkEMRu
	 GPTgdudKYSD1TeC1FL2y29y+T/vbWmxW/T0jw677FF5KE6FQKc1l7QjVc+sdRo6YF
	 Ufvfr2XOoOwtV4kOPuAeJjsJeDkp5DkFl75bg8biC+FLSHpGEufE2d3eSIiPUo8FE
	 xGFEXCTv1Pxb5c/Ll1bFUc9Q2N7y7y/LDkRCk0yUEXAUOEkxD591/CYMRyj+WYXZE
	 qg2mIx0PcHxquqO9H0L80Fhbtq0BVCQ9Oi7yBuLTlcErVDP4GJPNU1huaD+9Y/pAK
	 FeVw+QHhGPCMUtFdHw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.28.103]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N0Igv-1uuG021g99-014NJr; Wed, 09
 Jul 2025 11:45:25 +0200
Message-ID: <fbb7d5fe-e7ae-440f-80c4-991a2aff1d6a@web.de>
Date: Wed, 9 Jul 2025 11:45:24 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 3/7] parse-options: add precision handling for
 OPTION_SET_INT
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
Cc: Patrick Steinhardt <ps@pks.im>
References: <cf5cd57d-733f-4239-80f8-23bdc1523ab2@web.de>
 <802eba72-c100-429a-80b7-7a0e8b6559ed@web.de>
Content-Language: en-US
In-Reply-To: <802eba72-c100-429a-80b7-7a0e8b6559ed@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0jGnzpeIIYC9Pt5lpMhUNeWmiW4mqc7GHRtMR8A0ctb019DK87g
 P494WmPn5fpFDgft+x83GfCvlYac9BJML+k8vdz0lWbLUE5QCf8PierYNCx6kczFHdAltf+
 Yr9pF0ao52OFW0rX34+uiryY/AFEG02foR3PmBH3MB+lsS+N6iiA3/l1HwFho83bwTpU+0E
 8l8zTlwEmTjwmNS9uR/Ew==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:n12mp2/A0pM=;NtAQ1jse0ycZSCmVZJZOoTdD0+z
 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

Similar to 09705696f7 (parse-options: introduce precision handling for
`OPTION_INTEGER`, 2025-04-17) support value variables of different sizes
for OPTION_SET_INT.  Do that by requiring their "precision" to be set,
casting their "value" pointer accordingly and checking whether the value
fits.

Factor out the casting code from the part of do_get_value() that handles
OPTION_INTEGER to avoid code duplication.  We're going to use it in the
next patches as well.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/update-index.c        |  6 ++++
 parse-options.c               | 56 ++++++++++++++++++++++-------------
 parse-options.h               |  2 ++
 t/helper/test-parse-options.c |  1 +
 4 files changed, 45 insertions(+), 20 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 538b619ba4..0c1d4ed55b 100644
=2D-- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -981,6 +981,7 @@ int cmd_update_index(int argc,
 			.type =3D OPTION_SET_INT,
 			.long_name =3D "assume-unchanged",
 			.value =3D &mark_valid_only,
+			.precision =3D sizeof(mark_valid_only),
 			.help =3D N_("mark files as \"not changing\""),
 			.flags =3D PARSE_OPT_NOARG | PARSE_OPT_NONEG,
 			.defval =3D MARK_FLAG,
@@ -989,6 +990,7 @@ int cmd_update_index(int argc,
 			.type =3D OPTION_SET_INT,
 			.long_name =3D "no-assume-unchanged",
 			.value =3D &mark_valid_only,
+			.precision =3D sizeof(mark_valid_only),
 			.help =3D N_("clear assumed-unchanged bit"),
 			.flags =3D PARSE_OPT_NOARG | PARSE_OPT_NONEG,
 			.defval =3D UNMARK_FLAG,
@@ -997,6 +999,7 @@ int cmd_update_index(int argc,
 			.type =3D OPTION_SET_INT,
 			.long_name =3D "skip-worktree",
 			.value =3D &mark_skip_worktree_only,
+			.precision =3D sizeof(mark_skip_worktree_only),
 			.help =3D N_("mark files as \"index-only\""),
 			.flags =3D PARSE_OPT_NOARG | PARSE_OPT_NONEG,
 			.defval =3D MARK_FLAG,
@@ -1005,6 +1008,7 @@ int cmd_update_index(int argc,
 			.type =3D OPTION_SET_INT,
 			.long_name =3D "no-skip-worktree",
 			.value =3D &mark_skip_worktree_only,
+			.precision =3D sizeof(mark_skip_worktree_only),
 			.help =3D N_("clear skip-worktree bit"),
 			.flags =3D PARSE_OPT_NOARG | PARSE_OPT_NONEG,
 			.defval =3D UNMARK_FLAG,
@@ -1079,6 +1083,7 @@ int cmd_update_index(int argc,
 			.type =3D OPTION_SET_INT,
 			.long_name =3D "fsmonitor-valid",
 			.value =3D &mark_fsmonitor_only,
+			.precision =3D sizeof(mark_fsmonitor_only),
 			.help =3D N_("mark files as fsmonitor valid"),
 			.flags =3D PARSE_OPT_NOARG | PARSE_OPT_NONEG,
 			.defval =3D MARK_FLAG,
@@ -1087,6 +1092,7 @@ int cmd_update_index(int argc,
 			.type =3D OPTION_SET_INT,
 			.long_name =3D "no-fsmonitor-valid",
 			.value =3D &mark_fsmonitor_only,
+			.precision =3D sizeof(mark_fsmonitor_only),
 			.help =3D N_("clear fsmonitor valid bit"),
 			.flags =3D PARSE_OPT_NOARG | PARSE_OPT_NONEG,
 			.defval =3D UNMARK_FLAG,
diff --git a/parse-options.c b/parse-options.c
index ddac008a5e..639f41b83b 100644
=2D-- a/parse-options.c
+++ b/parse-options.c
@@ -88,6 +88,36 @@ static int do_get_int_value(const void *value, size_t p=
recision, intmax_t *ret)
 	}
 }
=20
+static enum parse_opt_result set_int_value(const struct option *opt,
+					   enum opt_parsed flags,
+					   intmax_t value)
+{
+	switch (opt->precision) {
+	case sizeof(int8_t):
+		*(int8_t *)opt->value =3D value;
+		return 0;
+	case sizeof(int16_t):
+		*(int16_t *)opt->value =3D value;
+		return 0;
+	case sizeof(int32_t):
+		*(int32_t *)opt->value =3D value;
+		return 0;
+	case sizeof(int64_t):
+		*(int64_t *)opt->value =3D value;
+		return 0;
+	default:
+		BUG("invalid precision for option %s", optname(opt, flags));
+	}
+}
+
+static int signed_int_fits(intmax_t value, size_t precision)
+{
+	size_t bits =3D precision * CHAR_BIT;
+	intmax_t upper_bound =3D INTMAX_MAX >> (bitsizeof(intmax_t) - bits);
+	intmax_t lower_bound =3D -upper_bound - 1;
+	return lower_bound <=3D value && value <=3D upper_bound;
+}
+
 static enum parse_opt_result do_get_value(struct parse_opt_ctx_t *p,
 					  const struct option *opt,
 					  enum opt_parsed flags,
@@ -136,8 +166,7 @@ static enum parse_opt_result do_get_value(struct parse=
_opt_ctx_t *p,
 		return 0;
=20
 	case OPTION_SET_INT:
-		*(int *)opt->value =3D unset ? 0 : opt->defval;
-		return 0;
+		return set_int_value(opt, flags, unset ? 0 : opt->defval);
=20
 	case OPTION_STRING:
 		if (unset)
@@ -219,23 +248,7 @@ static enum parse_opt_result do_get_value(struct pars=
e_opt_ctx_t *p,
 			return error(_("value %s for %s not in range [%"PRIdMAX",%"PRIdMAX"]")=
,
 				     arg, optname(opt, flags), (intmax_t)lower_bound, (intmax_t)upper=
_bound);
=20
-		switch (opt->precision) {
-		case 1:
-			*(int8_t *)opt->value =3D value;
-			return 0;
-		case 2:
-			*(int16_t *)opt->value =3D value;
-			return 0;
-		case 4:
-			*(int32_t *)opt->value =3D value;
-			return 0;
-		case 8:
-			*(int64_t *)opt->value =3D value;
-			return 0;
-		default:
-			BUG("invalid precision for option %s",
-			    optname(opt, flags));
-		}
+		return set_int_value(opt, flags, value);
 	}
 	case OPTION_UNSIGNED:
 	{
@@ -617,10 +630,13 @@ static void parse_options_check(const struct option =
*opts)
 		    opts->long_name && !(opts->flags & PARSE_OPT_NONEG))
 			optbug(opts, "OPTION_SET_INT 0 should not be negatable");
 		switch (opts->type) {
+		case OPTION_SET_INT:
+			if (!signed_int_fits(opts->defval, opts->precision))
+				optbug(opts, "has invalid defval");
+			/* fallthru */
 		case OPTION_COUNTUP:
 		case OPTION_BIT:
 		case OPTION_NEGBIT:
-		case OPTION_SET_INT:
 		case OPTION_NUMBER:
 		case OPTION_BITOP:
 			if ((opts->flags & PARSE_OPT_OPTARG) ||
diff --git a/parse-options.h b/parse-options.h
index c75a473c9e..71516e4b5b 100644
=2D-- a/parse-options.h
+++ b/parse-options.h
@@ -190,6 +190,7 @@ struct option {
 	.short_name =3D (s), \
 	.long_name =3D (l), \
 	.value =3D (v), \
+	.precision =3D sizeof(*v), \
 	.help =3D (h), \
 	.flags =3D PARSE_OPT_NOARG | (f), \
 	.defval =3D (i), \
@@ -260,6 +261,7 @@ struct option {
 	.short_name =3D (s), \
 	.long_name =3D (l), \
 	.value =3D (v), \
+	.precision =3D sizeof(*v), \
 	.help =3D (h), \
 	.flags =3D PARSE_OPT_NOARG | PARSE_OPT_HIDDEN, \
 	.defval =3D 1, \
diff --git a/t/helper/test-parse-options.c b/t/helper/test-parse-options.c
index 1e03ff88f6..2ba2546d70 100644
=2D-- a/t/helper/test-parse-options.c
+++ b/t/helper/test-parse-options.c
@@ -131,6 +131,7 @@ int cmd__parse_options(int argc, const char **argv)
 			.short_name =3D 'B',
 			.long_name =3D "no-fear",
 			.value =3D &boolean,
+			.precision =3D sizeof(boolean),
 			.help =3D "be brave",
 			.flags =3D PARSE_OPT_NOARG | PARSE_OPT_NONEG,
 			.defval =3D 1,
=2D-=20
2.50.0
