Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC45420B7ED
	for <git@vger.kernel.org>; Sun, 29 Jun 2025 11:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751197849; cv=none; b=b3cXPqCcFUBI24eew8eZvxvHQKLLCP622hVBWrnvROFsIZzcQbWWPey59iRbyNtE3/lqBC+BMeOuVrA0c93/qyPbcNNYFNYvAhDjVRAeeBgtFUJO+W2I0pGcoOuhyjDC4Bqw6yOKboYGzZDWRydxBBqe2W3rizj6FAGz/RDVNDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751197849; c=relaxed/simple;
	bh=Dpt1mMbTnwj0Im1jTM2lMox+C5xZ6adQgI5821Mljx4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=und6SAvB5V41MuU++ReY7bhta+A42FeJWUfzlHbdnZCNOX0Lenierqiv3XSSjxJoW/mFVY0yRO+0ekcE71SEL+4pS0jQdngE4ihFkYvRf4KN4/kiSSquCUCdC5tWRb0YhgmrZDYkckGHISx+eWQMEZmB22NGp3hprpwTdwJo5EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=b9XhRlPS; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="b9XhRlPS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1751197840; x=1751802640; i=l.s.r@web.de;
	bh=2Gn7pb6l4QJ5OZdAWN32Y9W+N7tGlj4aAJ1dBO9xLsI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=b9XhRlPSIJycyB3cfga78ABzIV2oM0deOZCAtepYTf1FesPGuZnTwCSsf4bXtxex
	 nniLd9Tnwh+XBcyCk7JkXIQuXOPo6sLcbgDp3T0pl38En2weWF2qXxe6sh0P0J0Mp
	 tqS4M64Le7aLhexsh+BOmfJgF8eHyw7QnFGzdgIy4e2LJWaz/KSxlGiBwyQmzocpe
	 Xavp3r5m1Z/1/MmR6ZGDVvqt570UOiXDwLqeylQ0MYaOrCfK+bdWX8Izv7dgBZdXu
	 2Et3gdXCXW0XA7UQ5q6/ytv17LMs+3z07Pi92kgJhvPMGY60bwmiQqdpfF8yyd18f
	 +Yu220a92stJWZX3vg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.28.103]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mw9xG-1uokuy03mO-010H17; Sun, 29
 Jun 2025 13:50:40 +0200
Message-ID: <3690df99-8a83-4377-9b03-6766f7958c21@web.de>
Date: Sun, 29 Jun 2025 13:50:39 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/6] parse-options: add precision handling for OPTION_SET_INT
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
Cc: Patrick Steinhardt <ps@pks.im>
References: <cf5cd57d-733f-4239-80f8-23bdc1523ab2@web.de>
Content-Language: en-US
In-Reply-To: <cf5cd57d-733f-4239-80f8-23bdc1523ab2@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OXwNedQ9z+ZSPnQSSjKso9Ya9QhQoPpETglz5jOcJHrwkXyzFIs
 +uxZLaVKreS7122Gd9sSfqmUeUBkhcnOww77duxCqeU9gP+NHjdmigxWuCAyUcnRUZMip3h
 3WDW5fV4M61TD0VWume6yQwLDTlpyFXhyZ+BxpRx9nXCkiWca8z4AXJrjgvzQwdj+4hZ5bc
 kUL9Jjy0XWscK3BwNEupA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/sq46IdVdI4=;7EB5ZlsoCLCIjwp8z2ICUASMi0W
 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
 Kw==

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
index da07a000a3..bbb68603cc 100644
=2D-- a/parse-options.c
+++ b/parse-options.c
@@ -85,6 +85,36 @@ static intmax_t get_int_value(const struct option *opt)
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
+static int signed_int_fits(intmax_t value, size_t size)
+{
+	size_t bits =3D size * CHAR_BIT;
+	intmax_t upper_bound =3D INTMAX_MAX >> (bitsizeof(intmax_t) - bits);
+	intmax_t lower_bound =3D -upper_bound - 1;
+	return lower_bound <=3D value && value <=3D upper_bound;
+}
+
 static enum parse_opt_result do_get_value(struct parse_opt_ctx_t *p,
 					  const struct option *opt,
 					  enum opt_parsed flags,
@@ -133,8 +163,7 @@ static enum parse_opt_result do_get_value(struct parse=
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
@@ -216,23 +245,7 @@ static enum parse_opt_result do_get_value(struct pars=
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
@@ -604,10 +617,13 @@ static void parse_options_check(const struct option =
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
 			if ((opts->flags & PARSE_OPT_OPTARG) ||
 			    !(opts->flags & PARSE_OPT_NOARG))
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
