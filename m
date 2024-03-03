Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A094BD2FF
	for <git@vger.kernel.org>; Sun,  3 Mar 2024 12:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709468405; cv=none; b=R1UD2AF0b50jl2e0Sp+RQ/ONeQDDC4CYxztJ+qyqtK8vALru/uj0OY+svhXJZ87GuXMBrWyhmGMTioHNkUK6Z8uDs7dzCH353UH23KqNhLJDxZPoqLwJ4Hsc3FpTV3A94cd9E8MAwPpUn0lrGV59eiPDzxFWMcFjtGkkTVWBOIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709468405; c=relaxed/simple;
	bh=TMiHPegQUo5WD5H3L2SdR8bYUsLkTA/0O79Y1122BU8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OGuczNGD9RhGnIkJuoSdFyFRp0+ScUIqGxxDuMBWBRuhAdGFdy3Hc1rzXPkScelk6354S6S6y0f6nmRRGreXJsD0onybith1RLX1hovB4/we89lCLo8NaAEWp99iH/1kMtBmRGIKf2k6Ypw/TmOAmhCK6JSPMHIyo/1HyZWE/qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=VVl0Slwd; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="VVl0Slwd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1709468393; x=1710073193; i=l.s.r@web.de;
	bh=TMiHPegQUo5WD5H3L2SdR8bYUsLkTA/0O79Y1122BU8=;
	h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
	b=VVl0Slwd3cqcaLcyMnhED/D3i8hNqUGotWICt1dnB5TMd54Oj+RqsDJPDQYAoP5y
	 YLdSGgqecromIKRBw72+Ukx3GYfxG8EwbqZlu4RTkA15GuAAYcsdGlNGg6d/LZ3M9
	 pj6SXxIxUg8iSq63fis1R0/N36W18+NkFTQ74qWCMYZTLTpz9qL7aAK8/THggA+x6
	 N261HxnPPr/0L6quVicFi1+klbpeIaHm7D352RAs31zOYv2MHrKevd919v9tMWnR8
	 25s0ZuKUrU0it/dOLSFG/0GnTDegv97aSiRbi8OgSgrPB2aCAd1XuosHjyj9jLj0k
	 XV0Sf6gnO14Te3Z1OA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from Mini-von-Rene.fritz.box ([79.203.19.211]) by smtp.web.de
 (mrweb005 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1MP384-1rUbBt2TKW-00PVAo for <git@vger.kernel.org>; Sun, 03 Mar 2024 13:19:53
 +0100
From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Subject: [PATCH v2 3/6] parse-options: factor out register_abbrev() and struct parsed_option
Date: Sun,  3 Mar 2024 13:19:40 +0100
Message-ID: <20240303121944.20627-4-l.s.r@web.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240303121944.20627-1-l.s.r@web.de>
References: <20240224212953.44026-1-l.s.r@web.de>
 <20240303121944.20627-1-l.s.r@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Cu5WycJZR5jjsFrF/WXLO0HbHUJRJ0fPxS+2Wyf4QHvJoLns/P9
 Ep4pdEk/ZV4jQI9Efw9L/uqSy4OZ6x0hEQsMxAGfyYfLtWMwJ/oQaevQUekxYbuX53CyG0S
 RmUtSqlVnlrcSjZPTl0AsVjdHw9AM0UYZEFaAIbL41LS7g+Z2ZGRRf8tN8S04xoBCE3+Tyf
 ELtuqt0iXQPdxNeXRLvXw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0m67X2ai2Dk=;3Jhw3os7sjyDif5FsDB+xWJR/sO
 H2Mt64EK0m07516/9Lznm5sHL9Lpk+j4CZQoVc+s9ne4GCL4WEe9dCNNpEHxN8Nb9Tdc1HRB9
 74CXV0TXatDTQV0YkSWiqUG17tRNsC5BcM6W6Y8wPkChikUkoM5SzQVLxVZRHRVqLY7GoWcMo
 k9nf++jmEWHAMHRmPH59rGpocYoLVGIBawHRZFUZioG8BvZim0sIbI5W61WlaGaOsOMUAOlWD
 wGNVgz7XDHoKaiivJ3p7jUVidPBTg6Sudv5lN9PGH9FQ5lM2MyhQq7YKj5jxru8wfzAeXdoUc
 0eF8a6zecmm1PTF+uVSER46YIebYgejF+RcN8uENCyDBUJT45Y7EuSRz7z6uDCEM+NyqZb5Mq
 LEtqqVQJIUZkyfEc9GpqhomfXYBqw78tl1tct/64Dau6SWQvXEVQLfR+S8xjbF+hVznRu3Qlu
 oAxFh5v0C6S5sZDkRWYzA51ukF5iYMKwo6/1er0L3ha7h+JtxIIeY7u4QGb9GVlsQsF/VNKQg
 vyc49QnZL1Cr+fKyYo0rHX+bU8dn8MpTvaw0VZt9EB/blwT/o/p7qrLc/3PpP2iha8TbSVl9H
 OMZIjwKdlqBXXX8qETPqCp+872IjilRVSTxVPCSB4cUXFD94FzYBf87HZDkXwjbPV+zWbnFRm
 0hl3QOhJsjnOCYMI20JWInve5tmW/7zExId1DvedFXPz/d6E7goIYD3C9I0JNLyWQgbwuh/Md
 49vq8qw64BSXXKsmBYb1R9YJh3i5PBvpQYkT74KeP/hsJwqBtoX+qRdxT4JLY/lOMo0JNgoya
 VG0Rut4K4RNraDWswqWIKRCVgG8eSblcTKVDfo1Pgv9uE=

Add a function, register_abbrev(), for storing the necessary details for
remembering an abbreviated and thus potentially ambiguous option.  Call
it instead of sharing the code using goto, to make the control flow more
explicit.

Conveniently collect these details in the new struct parsed_option to
reduce the number of necessary function arguments.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 parse-options.c | 83 +++++++++++++++++++++++++++++--------------------
 1 file changed, 49 insertions(+), 34 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 056c6b30e9..398ebaef14 100644
=2D-- a/parse-options.c
+++ b/parse-options.c
@@ -350,14 +350,40 @@ static int is_alias(struct parse_opt_ctx_t *ctx,
 	return 0;
 }

+struct parsed_option {
+	const struct option *option;
+	enum opt_parsed flags;
+};
+
+static void register_abbrev(struct parse_opt_ctx_t *p,
+			    const struct option *option, enum opt_parsed flags,
+			    struct parsed_option *abbrev,
+			    struct parsed_option *ambiguous)
+{
+	if (p->flags & PARSE_OPT_KEEP_UNKNOWN_OPT)
+		return;
+	if (abbrev->option &&
+	    !is_alias(p, abbrev->option, option)) {
+		/*
+		 * If this is abbreviated, it is
+		 * ambiguous. So when there is no
+		 * exact match later, we need to
+		 * error out.
+		 */
+		ambiguous->option =3D abbrev->option;
+		ambiguous->flags =3D abbrev->flags;
+	}
+	abbrev->option =3D option;
+	abbrev->flags =3D flags;
+}
+
 static enum parse_opt_result parse_long_opt(
 	struct parse_opt_ctx_t *p, const char *arg,
 	const struct option *options)
 {
 	const char *arg_end =3D strchrnul(arg, '=3D');
-	const struct option *abbrev_option =3D NULL, *ambiguous_option =3D NULL;
-	enum opt_parsed abbrev_flags =3D OPT_LONG, ambiguous_flags =3D OPT_LONG;
-	int allow_abbrev =3D !(p->flags & PARSE_OPT_KEEP_UNKNOWN_OPT);
+	struct parsed_option abbrev =3D { .option =3D NULL, .flags =3D OPT_LONG =
};
+	struct parsed_option ambiguous =3D { .option =3D NULL, .flags =3D OPT_LO=
NG };

 	for (; options->type !=3D OPTION_END; options++) {
 		const char *rest, *long_name =3D options->long_name;
@@ -377,31 +403,20 @@ static enum parse_opt_result parse_long_opt(
 			rest =3D NULL;
 		if (!rest) {
 			/* abbreviated? */
-			if (allow_abbrev &&
-			    !strncmp(long_name, arg, arg_end - arg)) {
-is_abbreviated:
-				if (abbrev_option &&
-				    !is_alias(p, abbrev_option, options)) {
-					/*
-					 * If this is abbreviated, it is
-					 * ambiguous. So when there is no
-					 * exact match later, we need to
-					 * error out.
-					 */
-					ambiguous_option =3D abbrev_option;
-					ambiguous_flags =3D abbrev_flags;
-				}
-				abbrev_option =3D options;
-				abbrev_flags =3D flags ^ opt_flags;
+			if (!strncmp(long_name, arg, arg_end - arg)) {
+				register_abbrev(p, options, flags ^ opt_flags,
+						&abbrev, &ambiguous);
 				continue;
 			}
 			/* negation allowed? */
 			if (options->flags & PARSE_OPT_NONEG)
 				continue;
 			/* negated and abbreviated very much? */
-			if (allow_abbrev && starts_with("no-", arg)) {
+			if (starts_with("no-", arg)) {
 				flags |=3D OPT_UNSET;
-				goto is_abbreviated;
+				register_abbrev(p, options, flags ^ opt_flags,
+						&abbrev, &ambiguous);
+				continue;
 			}
 			/* negated? */
 			if (!starts_with(arg, "no-"))
@@ -409,12 +424,12 @@ static enum parse_opt_result parse_long_opt(
 			flags |=3D OPT_UNSET;
 			if (!skip_prefix(arg + 3, long_name, &rest)) {
 				/* abbreviated and negated? */
-				if (allow_abbrev &&
-				    !strncmp(long_name, arg + 3,
+				if (!strncmp(long_name, arg + 3,
 					     arg_end - arg - 3))
-					goto is_abbreviated;
-				else
-					continue;
+					register_abbrev(p, options,
+							flags ^ opt_flags,
+							&abbrev, &ambiguous);
+				continue;
 			}
 		}
 		if (*rest) {
@@ -425,24 +440,24 @@ static enum parse_opt_result parse_long_opt(
 		return get_value(p, options, flags ^ opt_flags);
 	}

-	if (disallow_abbreviated_options && (ambiguous_option || abbrev_option))
+	if (disallow_abbreviated_options && (ambiguous.option || abbrev.option))
 		die("disallowed abbreviated or ambiguous option '%.*s'",
 		    (int)(arg_end - arg), arg);

-	if (ambiguous_option) {
+	if (ambiguous.option) {
 		error(_("ambiguous option: %s "
 			"(could be --%s%s or --%s%s)"),
 			arg,
-			(ambiguous_flags & OPT_UNSET) ?  "no-" : "",
-			ambiguous_option->long_name,
-			(abbrev_flags & OPT_UNSET) ?  "no-" : "",
-			abbrev_option->long_name);
+			(ambiguous.flags & OPT_UNSET) ?  "no-" : "",
+			ambiguous.option->long_name,
+			(abbrev.flags & OPT_UNSET) ?  "no-" : "",
+			abbrev.option->long_name);
 		return PARSE_OPT_HELP;
 	}
-	if (abbrev_option) {
+	if (abbrev.option) {
 		if (*arg_end)
 			p->opt =3D arg_end + 1;
-		return get_value(p, abbrev_option, abbrev_flags);
+		return get_value(p, abbrev.option, abbrev.flags);
 	}
 	return PARSE_OPT_UNKNOWN;
 }
=2D-
2.44.0

