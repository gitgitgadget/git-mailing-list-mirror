Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A739F4A20
	for <git@vger.kernel.org>; Thu, 18 Apr 2024 22:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713480870; cv=none; b=c2+KkJmmW4vc9nJjauKglBI2UXobRpTJWoOtPWvg1xLoyaJJyeAm5Uwd+q6c+GKM38P0jgvYwxul+YQicd/TuvRQNi5Zt8FMhyt4xZ/R7RZ+Gx3bIf8HfVjGYScI9IgM+2VusJNyMd+AAnFczCBKnk7uOYSYBZB/rthzyOuoRc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713480870; c=relaxed/simple;
	bh=hKaXJzgtVo4u0s+QvXn5pbSb02Q6zC7nlZk/gURCc+w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=enVJxObqLndOUGCnkWIv1ExJ3sQE29vvHbx/Q+OyemwUxzNBXjLY+RKl2WjDr+0G6ufupKTfIpC4Ox8n9pFPeFs0F8IRd8978oFA5Z+CYuwdpGlGWcitI+vYpunVC02DAtXU1jQs0Wm7D0ovRLxhN77Y7kYYHWIxVCVw2BHn9XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=kVTYM2pW; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kVTYM2pW"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6E2951ED071;
	Thu, 18 Apr 2024 18:54:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=h
	KaXJzgtVo4u0s+QvXn5pbSb02Q6zC7nlZk/gURCc+w=; b=kVTYM2pWl4yxKkprZ
	uPaIJZYzcXXH6wEBuW9Q0jFxO6ONd2QERylmQZGDHO55wq0KyO/JJBVMWFXC1JRZ
	CZd5/LYPEH3ku7D/7Gaj6t7PoNhYsUfRe2Eq8R7S7u0mBN2X7OZxMjyMFujatXl+
	zHfalug8W0AV6oFdj3OAR3OWtI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 660891ED070;
	Thu, 18 Apr 2024 18:54:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CABF61ED06F;
	Thu, 18 Apr 2024 18:54:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>, Dragan Simic <dsimic@manjaro.org>
Subject: [PATCH] format-patch: allow --rfc to optionally take a value, like
 --rfc=WIP
Date: Thu, 18 Apr 2024 15:54:25 -0700
Message-ID: <xmqqzftqnuxq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9B7B7FAE-FDD6-11EE-A4D1-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

With the "--rfc" option, we can tweak the "[PATCH]" (or whatever
string specified with the "--subject-prefix" option, instead of
"PATCH") that we prefix the title of the commit with into "[RFC
PATCH]", but some projects may want "[rfc PATCH]".  Adding a new
option, e.g., "--rfc-lowercase", to support such need every time
somebody wants to use different strings would lead to insanity of
accumulating unbounded number of such options.

Allow an optional value specified for the option, so that users can
use "--rfc=rfc" (think of "--rfc" without value as a short-hand for
"--rfc=RFC").

This can of course be (ab)used to make the prefix "[WIP PATCH]" by
passing "--rfc=WIP".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 Documentation/git-format-patch.txt | 15 ++++++++++-----
 builtin/log.c                      | 22 ++++++++++++++++++----
 t/t4014-format-patch.sh            |  9 +++++++++
 3 files changed, 37 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 728bb3821c..8d634f5b1b 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -20,7 +20,7 @@ SYNOPSIS
 		   [--in-reply-to=<message-id>] [--suffix=.<sfx>]
 		   [--ignore-if-in-upstream] [--always]
 		   [--cover-from-description=<mode>]
-		   [--rfc] [--subject-prefix=<subject-prefix>]
+		   [--rfc[=<rfc>]] [--subject-prefix=<subject-prefix>]
 		   [(--reroll-count|-v) <n>]
 		   [--to=<email>] [--cc=<email>]
 		   [--[no-]cover-letter] [--quiet]
@@ -238,10 +238,15 @@ the patches (with a value of e.g. "PATCH my-project").
 	value of the `format.filenameMaxLength` configuration
 	variable, or 64 if unconfigured.
 
---rfc::
-	Prepends "RFC" to the subject prefix (producing "RFC PATCH" by
-	default). RFC means "Request For Comments"; use this when sending
-	an experimental patch for discussion rather than application.
+--rfc[=<rfc>]::
+	Prepends the string _<rfc>_ (defaults to "RFC") to
+	the subject prefix.  As the subject prefix defaults to
+	"PATCH", you'll get "RFC PATCH" by default.
++
+RFC means "Request For Comments"; use this when sending
+an experimental patch for discussion rather than application.
+"--rfc=WIP" may also be a useful way to indicate that a patch
+is not complete yet.
 
 -v <n>::
 --reroll-count=<n>::
diff --git a/builtin/log.c b/builtin/log.c
index c0a8bb95e9..2d6e0f3688 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1494,6 +1494,18 @@ static int subject_prefix_callback(const struct option *opt, const char *arg,
 	return 0;
 }
 
+static int rfc_callback(const struct option *opt, const char *arg,
+			int unset)
+{
+	struct strbuf *rfc;
+
+	BUG_ON_OPT_NEG(unset);
+	rfc = opt->value;
+	strbuf_reset(rfc);
+	strbuf_addstr(rfc, arg ? arg : "RFC");
+	return 0;
+}
+
 static int numbered_cmdline_opt = 0;
 
 static int numbered_callback(const struct option *opt, const char *arg,
@@ -1907,8 +1919,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	struct strbuf rdiff2 = STRBUF_INIT;
 	struct strbuf rdiff_title = STRBUF_INIT;
 	struct strbuf sprefix = STRBUF_INIT;
+	struct strbuf rfc = STRBUF_INIT;
 	int creation_factor = -1;
-	int rfc = 0;
 
 	const struct option builtin_format_patch_options[] = {
 		OPT_CALLBACK_F('n', "numbered", &numbered, NULL,
@@ -1932,7 +1944,9 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			    N_("mark the series as Nth re-roll")),
 		OPT_INTEGER(0, "filename-max-length", &fmt_patch_name_max,
 			    N_("max length of output filename")),
-		OPT_BOOL(0, "rfc", &rfc, N_("use [RFC PATCH] instead of [PATCH]")),
+		OPT_CALLBACK_F(0, "rfc", &rfc, N_("extra"),
+			       N_("add <extra> (default 'RFC') before 'PATCH'"),
+			       PARSE_OPT_NONEG|PARSE_OPT_OPTARG, rfc_callback),
 		OPT_STRING(0, "cover-from-description", &cover_from_description_arg,
 			    N_("cover-from-description-mode"),
 			    N_("generate parts of a cover letter based on a branch's description")),
@@ -2050,8 +2064,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	if (cover_from_description_arg)
 		cover_from_description_mode = parse_cover_from_description(cover_from_description_arg);
 
-	if (rfc)
-		strbuf_insertstr(&sprefix, 0, "RFC ");
+	if (rfc.len)
+		strbuf_insertf(&sprefix, 0, "%s ", rfc.buf);
 
 	if (reroll_count) {
 		strbuf_addf(&sprefix, " v%s", reroll_count);
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index e37a1411ee..905858da35 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1377,6 +1377,15 @@ test_expect_success '--rfc' '
 	test_cmp expect actual
 '
 
+test_expect_success '--rfc=WIP' '
+	cat >expect <<-\EOF &&
+	Subject: [WIP PATCH 1/1] header with . in it
+	EOF
+	git format-patch -n -1 --stdout --rfc=WIP >patch &&
+	grep "^Subject:" patch >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success '--rfc does not overwrite prefix' '
 	cat >expect <<-\EOF &&
 	Subject: [RFC PATCH foobar 1/1] header with . in it
-- 
2.44.0-651-g21306a098c

