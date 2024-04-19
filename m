Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E548329D08
	for <git@vger.kernel.org>; Fri, 19 Apr 2024 22:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713564101; cv=none; b=RZXRZGMJUfIHkZqgbPjGh+c89EY3gyX/KRtavjkCW0+vq9+P+wKwx7xNm2lwncYvtUUKGZSzTKc7CkUK3+OUuRpOkngK16OGyMgRkYFqTKkUrZtLKexuD4qxWkMoGXkLyzmPI7uff0u1c7Wf+wa883sqod9VDif2NtT4VuELIl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713564101; c=relaxed/simple;
	bh=LXYHgnGrSyQZZm7MoiRXhK+IHLHsv8I6/IYEzrWIkPc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RxsDMbnrPXLusa/1X748mzi+D6QnxdJSMd1S/qOZ0WpccPwjHgfrxuLyNVnvOv9zlkVpApWhj2NoJ4E+iccDD4uTiRhNWVru1rf4kZ9HOlacljkIEU10l0x7sV2NscYJSBLxB3mc1Zz4pzFlmzM1lWfoimxZNSfKgdXGJZDsmuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=D/zbEJx9; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="D/zbEJx9"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 7FC27348CE;
	Fri, 19 Apr 2024 18:01:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=LXYHgnGrSyQZZm7MoiRXhK+IHLHsv8I6/IYEzr
	WIkPc=; b=D/zbEJx94Pt2IzqTh5f7foCTiTc35dBFPN3pHq5olzb8Oebs7FPjZS
	+yIUERX65tZJS6QK0zbRLrfjAvXuGo72Ym2ilGp+u4NVgRBF/X9YvC2JPSLbgMdB
	srNvR4UYtNSxPyyZcEgzN8rINLkdp8AzsrmqkbR0yPDmMOK+3O458=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 77B63348CD;
	Fri, 19 Apr 2024 18:01:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C18E4348CB;
	Fri, 19 Apr 2024 18:01:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,  Dragan Simic
 <dsimic@manjaro.org>
Subject: [PATCH v2] format-patch: allow --rfc to optionally take a value,
 like --rfc=WIP
In-Reply-To: <xmqqzftqnuxq.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	18 Apr 2024 15:54:25 -0700")
References: <xmqqzftqnuxq.fsf@gitster.g>
Date: Fri, 19 Apr 2024 15:01:34 -0700
Message-ID: <xmqqy1993tc1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 63CF374A-FE98-11EE-AC31-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

With the "--rfc" option, we can tweak the "[PATCH]" (or whatever
string specified with the "--subject-prefix" option, instead of
"PATCH") that we prefix the title of the commit with into "[RFC
PATCH]", but some projects may want "[rfc PATCH]".  Adding a new
option, e.g., "--rfc-lowercase", to support such need every time
somebody wants to use different strings would lead to insanity of
accumulating unbounded number of such options.

Allow an optional value specified for the option, so that users can
use "--rfc=rfc" (think of "--rfc" without value as a short-hand for
"--rfc=RFC") if they wanted to.

This can of course be (ab)used to make the prefix "[WIP PATCH]" by
passing "--rfc=WIP".  Passing an empty string, i.e., "--rfc=", is
the same as "--no-rfc" to override an option given earlier on the
same command line.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
Range-diff against v1:
1:  4077ed52e8 ! 1:  bffe0055d0 format-patch: allow --rfc to optionally take a value, like --rfc=WIP
    @@ Commit message
     
         Allow an optional value specified for the option, so that users can
         use "--rfc=rfc" (think of "--rfc" without value as a short-hand for
    -    "--rfc=RFC").
    +    "--rfc=RFC") if they wanted to.
     
         This can of course be (ab)used to make the prefix "[WIP PATCH]" by
    -    passing "--rfc=WIP".
    +    passing "--rfc=WIP".  Passing an empty string, i.e., "--rfc=", is
    +    the same as "--no-rfc" to override an option given earlier on the
    +    same command line.
     
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
    @@ Documentation/git-format-patch.txt: the patches (with a value of e.g. "PATCH my-
     +RFC means "Request For Comments"; use this when sending
     +an experimental patch for discussion rather than application.
     +"--rfc=WIP" may also be a useful way to indicate that a patch
    -+is not complete yet.
    ++is not complete yet ("WIP" stands for "Work In Progress").
      
      -v <n>::
      --reroll-count=<n>::
    @@ builtin/log.c: static int subject_prefix_callback(const struct option *opt, cons
     +{
     +	struct strbuf *rfc;
     +
    -+	BUG_ON_OPT_NEG(unset);
     +	rfc = opt->value;
     +	strbuf_reset(rfc);
    -+	strbuf_addstr(rfc, arg ? arg : "RFC");
    ++	if (!unset)
    ++		strbuf_addstr(rfc, arg ? arg : "RFC");
     +	return 0;
     +}
     +
    @@ builtin/log.c: int cmd_format_patch(int argc, const char **argv, const char *pre
      		OPT_INTEGER(0, "filename-max-length", &fmt_patch_name_max,
      			    N_("max length of output filename")),
     -		OPT_BOOL(0, "rfc", &rfc, N_("use [RFC PATCH] instead of [PATCH]")),
    -+		OPT_CALLBACK_F(0, "rfc", &rfc, N_("extra"),
    -+			       N_("add <extra> (default 'RFC') before 'PATCH'"),
    -+			       PARSE_OPT_NONEG|PARSE_OPT_OPTARG, rfc_callback),
    ++		OPT_CALLBACK_F(0, "rfc", &rfc, N_("rfc"),
    ++			       N_("add <rfc> (default 'RFC') before 'PATCH'"),
    ++			       PARSE_OPT_OPTARG, rfc_callback),
      		OPT_STRING(0, "cover-from-description", &cover_from_description_arg,
      			    N_("cover-from-description-mode"),
      			    N_("generate parts of a cover letter based on a branch's description")),
    @@ builtin/log.c: int cmd_format_patch(int argc, const char **argv, const char *pre
      		strbuf_addf(&sprefix, " v%s", reroll_count);
     
      ## t/t4014-format-patch.sh ##
    -@@ t/t4014-format-patch.sh: test_expect_success '--rfc' '
    +@@ t/t4014-format-patch.sh: test_expect_success 'empty subject prefix does not have extra space' '
      	test_cmp expect actual
      '
      
    -+test_expect_success '--rfc=WIP' '
    +-test_expect_success '--rfc' '
    ++test_expect_success '--rfc and --no-rfc' '
    + 	cat >expect <<-\EOF &&
    + 	Subject: [RFC PATCH 1/1] header with . in it
    + 	EOF
    + 	git format-patch -n -1 --stdout --rfc >patch &&
    + 	grep "^Subject:" patch >actual &&
    +-	test_cmp expect actual
    ++	test_cmp expect actual &&
    ++	git format-patch -n -1 --stdout --rfc --no-rfc >patch &&
    ++	sed -e "s/RFC //" expect >expect-raw &&
    ++	grep "^Subject:" patch >actual &&
    ++	test_cmp expect-raw actual
    ++'
    ++
    ++test_expect_success '--rfc=WIP and --rfc=' '
     +	cat >expect <<-\EOF &&
     +	Subject: [WIP PATCH 1/1] header with . in it
     +	EOF
     +	git format-patch -n -1 --stdout --rfc=WIP >patch &&
     +	grep "^Subject:" patch >actual &&
    -+	test_cmp expect actual
    -+'
    -+
    ++	test_cmp expect actual &&
    ++	git format-patch -n -1 --stdout --rfc --rfc= >patch &&
    ++	sed -e "s/WIP //" expect >expect-raw &&
    ++	grep "^Subject:" patch >actual &&
    ++	test_cmp expect-raw actual
    + '
    + 
      test_expect_success '--rfc does not overwrite prefix' '
    - 	cat >expect <<-\EOF &&
    - 	Subject: [RFC PATCH foobar 1/1] header with . in it

 Documentation/git-format-patch.txt | 15 ++++++++++-----
 builtin/log.c                      | 22 ++++++++++++++++++----
 t/t4014-format-patch.sh            | 21 +++++++++++++++++++--
 3 files changed, 47 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 728bb3821c..e553810b1e 100644
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
+is not complete yet ("WIP" stands for "Work In Progress").
 
 -v <n>::
 --reroll-count=<n>::
diff --git a/builtin/log.c b/builtin/log.c
index c0a8bb95e9..0e9c84e51d 100644
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
+	rfc = opt->value;
+	strbuf_reset(rfc);
+	if (!unset)
+		strbuf_addstr(rfc, arg ? arg : "RFC");
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
+		OPT_CALLBACK_F(0, "rfc", &rfc, N_("rfc"),
+			       N_("add <rfc> (default 'RFC') before 'PATCH'"),
+			       PARSE_OPT_OPTARG, rfc_callback),
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
index e37a1411ee..645c4189f9 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1368,13 +1368,30 @@ test_expect_success 'empty subject prefix does not have extra space' '
 	test_cmp expect actual
 '
 
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
+test_expect_success '--rfc=WIP and --rfc=' '
+	cat >expect <<-\EOF &&
+	Subject: [WIP PATCH 1/1] header with . in it
+	EOF
+	git format-patch -n -1 --stdout --rfc=WIP >patch &&
+	grep "^Subject:" patch >actual &&
+	test_cmp expect actual &&
+	git format-patch -n -1 --stdout --rfc --rfc= >patch &&
+	sed -e "s/WIP //" expect >expect-raw &&
+	grep "^Subject:" patch >actual &&
+	test_cmp expect-raw actual
 '
 
 test_expect_success '--rfc does not overwrite prefix' '
-- 
2.45.0-rc0

