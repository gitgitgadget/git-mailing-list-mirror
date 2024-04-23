Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD7913DDD0
	for <git@vger.kernel.org>; Tue, 23 Apr 2024 17:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713894760; cv=none; b=I8lk2R8XkGEI0iMcaAk47bc+GA9lZAIgOkii7xMO2PVc/H92beU14W8oGTUqwIkzqGJ9X1DCW59GcE12Q2O674/9naM9bHxhSUouJKfVfdEBf2jjnDikviHCovVtuJc2IW9EgPda+LksJMBw3IA4BtyQc/iudaq2jasXKntBd1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713894760; c=relaxed/simple;
	bh=0hJCYnS4R6RsrDJ3B+8VOFL9JcDh9cyUtjs8oqcOw/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e4m1JegFHZNGmD731lJK8dRgLZZx47HG+4KrJySJWyQs2ScdaBOBPsH37he6vPcFdGRndoLOZ2XOf6s0dDjwuORJIv5OLePflp8INsnhtl4Q/XuaM6/T4v9ZpSr+s+JMpQRlyjlR6tX+2qne1Awerx5ECbIjazB+X/PzdGoA9zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=C5GsvsVU; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="C5GsvsVU"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 28B8F1F3FA0;
	Tue, 23 Apr 2024 13:52:38 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=0hJCYnS4R6RsrDJ3B+8VOFL9J
	cDh9cyUtjs8oqcOw/Y=; b=C5GsvsVUmo9kADoQo64WPik+BuDOEw21eXI30kb0k
	i6NCQXEG8I/zT2d3V8a1hBhOE+ZfyeLnVVlP7aWElwXG+wvvuqUbUbz2wC+/tfC/
	7jvQbqMZjCJo3vsvQFobYIuwCZ/uVrrZqfJF28L69JIjuoMc5SjQfYcBU1i2NM1p
	aQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1ED421F3F9F;
	Tue, 23 Apr 2024 13:52:38 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7D38E1F3F9E;
	Tue, 23 Apr 2024 13:52:37 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
	Dragan Simic <dsimic@manjaro.org>
Subject: [PATCH v4 1/2] format-patch: allow --rfc to optionally take a value, like --rfc=WIP
Date: Tue, 23 Apr 2024 10:52:33 -0700
Message-ID: <20240423175234.170434-2-gitster@pobox.com>
X-Mailer: git-send-email 2.45.0-rc0-3-g00e10ef10e
In-Reply-To: <20240423175234.170434-1-gitster@pobox.com>
References: <20240421185915.1031590-1-gitster@pobox.com>
 <20240423175234.170434-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 458E6BF2-019A-11EF-9295-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

With the "--rfc" option, we can tweak the "[PATCH]" (or whatever
string specified with the "--subject-prefix" option, instead of
"PATCH") that we prefix the title of the commit with into "[RFC
PATCH]", but some projects may want "[rfc PATCH]".  Adding a new
option, e.g., "--rfc-lowercase", to support such need every time
somebody wants to use different strings would lead to insanity of
accumulating unbounded number of such options.

Allow an optional value specified for the option, so that users can
use "--rfc=3Drfc" (think of "--rfc" without value as a short-hand for
"--rfc=3DRFC") if they wanted to.

This can of course be (ab)used to make the prefix "[WIP PATCH]" by
passing "--rfc=3DWIP".  Passing an empty string, i.e., "--rfc=3D", is
the same as "--no-rfc" to override an option given earlier on the
same command line.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-format-patch.txt | 15 ++++++++++-----
 builtin/log.c                      | 23 +++++++++++++++++++----
 t/t4014-format-patch.sh            | 21 +++++++++++++++++++--
 3 files changed, 48 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-forma=
t-patch.txt
index 728bb3821c..e553810b1e 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -20,7 +20,7 @@ SYNOPSIS
 		   [--in-reply-to=3D<message-id>] [--suffix=3D.<sfx>]
 		   [--ignore-if-in-upstream] [--always]
 		   [--cover-from-description=3D<mode>]
-		   [--rfc] [--subject-prefix=3D<subject-prefix>]
+		   [--rfc[=3D<rfc>]] [--subject-prefix=3D<subject-prefix>]
 		   [(--reroll-count|-v) <n>]
 		   [--to=3D<email>] [--cc=3D<email>]
 		   [--[no-]cover-letter] [--quiet]
@@ -238,10 +238,15 @@ the patches (with a value of e.g. "PATCH my-project=
").
 	value of the `format.filenameMaxLength` configuration
 	variable, or 64 if unconfigured.
=20
---rfc::
-	Prepends "RFC" to the subject prefix (producing "RFC PATCH" by
-	default). RFC means "Request For Comments"; use this when sending
-	an experimental patch for discussion rather than application.
+--rfc[=3D<rfc>]::
+	Prepends the string _<rfc>_ (defaults to "RFC") to
+	the subject prefix.  As the subject prefix defaults to
+	"PATCH", you'll get "RFC PATCH" by default.
++
+RFC means "Request For Comments"; use this when sending
+an experimental patch for discussion rather than application.
+"--rfc=3DWIP" may also be a useful way to indicate that a patch
+is not complete yet ("WIP" stands for "Work In Progress").
=20
 -v <n>::
 --reroll-count=3D<n>::
diff --git a/builtin/log.c b/builtin/log.c
index c0a8bb95e9..97ca885b33 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1494,6 +1494,19 @@ static int subject_prefix_callback(const struct op=
tion *opt, const char *arg,
 	return 0;
 }
=20
+static int rfc_callback(const struct option *opt, const char *arg,
+			int unset)
+{
+	const char **rfc =3D opt->value;
+
+	*rfc =3D opt->value;
+	if (unset)
+		*rfc =3D NULL;
+	else
+		*rfc =3D arg ? arg : "RFC";
+	return 0;
+}
+
 static int numbered_cmdline_opt =3D 0;
=20
 static int numbered_callback(const struct option *opt, const char *arg,
@@ -1907,8 +1920,8 @@ int cmd_format_patch(int argc, const char **argv, c=
onst char *prefix)
 	struct strbuf rdiff2 =3D STRBUF_INIT;
 	struct strbuf rdiff_title =3D STRBUF_INIT;
 	struct strbuf sprefix =3D STRBUF_INIT;
+	const char *rfc =3D NULL;
 	int creation_factor =3D -1;
-	int rfc =3D 0;
=20
 	const struct option builtin_format_patch_options[] =3D {
 		OPT_CALLBACK_F('n', "numbered", &numbered, NULL,
@@ -1932,7 +1945,9 @@ int cmd_format_patch(int argc, const char **argv, c=
onst char *prefix)
 			    N_("mark the series as Nth re-roll")),
 		OPT_INTEGER(0, "filename-max-length", &fmt_patch_name_max,
 			    N_("max length of output filename")),
-		OPT_BOOL(0, "rfc", &rfc, N_("use [RFC PATCH] instead of [PATCH]")),
+		OPT_CALLBACK_F(0, "rfc", &rfc, N_("rfc"),
+			       N_("add <rfc> (default 'RFC') before 'PATCH'"),
+			       PARSE_OPT_OPTARG, rfc_callback),
 		OPT_STRING(0, "cover-from-description", &cover_from_description_arg,
 			    N_("cover-from-description-mode"),
 			    N_("generate parts of a cover letter based on a branch's descript=
ion")),
@@ -2050,8 +2065,8 @@ int cmd_format_patch(int argc, const char **argv, c=
onst char *prefix)
 	if (cover_from_description_arg)
 		cover_from_description_mode =3D parse_cover_from_description(cover_fro=
m_description_arg);
=20
-	if (rfc)
-		strbuf_insertstr(&sprefix, 0, "RFC ");
+	if (rfc && rfc[0])
+		strbuf_insertf(&sprefix, 0, "%s ", rfc);
=20
 	if (reroll_count) {
 		strbuf_addf(&sprefix, " v%s", reroll_count);
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index e37a1411ee..645c4189f9 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1368,13 +1368,30 @@ test_expect_success 'empty subject prefix does no=
t have extra space' '
 	test_cmp expect actual
 '
=20
-test_expect_success '--rfc' '
+test_expect_success '--rfc and --no-rfc' '
 	cat >expect <<-\EOF &&
 	Subject: [RFC PATCH 1/1] header with . in it
 	EOF
 	git format-patch -n -1 --stdout --rfc >patch &&
 	grep "^Subject:" patch >actual &&
-	test_cmp expect actual
+	test_cmp expect actual &&
+	git format-patch -n -1 --stdout --rfc --no-rfc >patch &&
+	sed -e "s/RFC //" expect >expect-raw &&
+	grep "^Subject:" patch >actual &&
+	test_cmp expect-raw actual
+'
+
+test_expect_success '--rfc=3DWIP and --rfc=3D' '
+	cat >expect <<-\EOF &&
+	Subject: [WIP PATCH 1/1] header with . in it
+	EOF
+	git format-patch -n -1 --stdout --rfc=3DWIP >patch &&
+	grep "^Subject:" patch >actual &&
+	test_cmp expect actual &&
+	git format-patch -n -1 --stdout --rfc --rfc=3D >patch &&
+	sed -e "s/WIP //" expect >expect-raw &&
+	grep "^Subject:" patch >actual &&
+	test_cmp expect-raw actual
 '
=20
 test_expect_success '--rfc does not overwrite prefix' '
--=20
2.45.0-rc0-3-g00e10ef10e

