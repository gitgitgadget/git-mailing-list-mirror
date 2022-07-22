Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52BE9CCA473
	for <git@archiver.kernel.org>; Fri, 22 Jul 2022 23:29:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbiGVX3L (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jul 2022 19:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbiGVX3J (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jul 2022 19:29:09 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1DC89A72
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 16:29:07 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id mh14so4519538qvb.1
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 16:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lc7aSTRt+vxhw0My9vYAl8Lh1HPcvZL99itmKD8zu+k=;
        b=kV180cdcQa5yizyApJyp+dq1ZPcKSjm4z0NHlsv8CxrClC3+QWFhBl/HPsAOzrKHjm
         /tnBw12dS6Jn8ZCCBv4VgXd73bW+WHB9dcBLsNC3LBbOIjf1Zo27T0e/OhwuxRcihO0F
         S38oQ4nEkIm8t7X1/g1bNadfyI2YoopaVmrHO57YeNmSNx/DqZkjQlm62Fwtoryxj4PI
         SesvqB/8JnyL0gCHJcFgp5Rvkwm4BqHdDXU6zt8fkwwud4Oi60snT2oFFMgd4BL+G4a+
         13lqJLqvllm+yuQcQccpe3/RCEHT8xN/ZZmBFdhwhXZMya2HId6u9gammAo1daHgVIS6
         tC/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lc7aSTRt+vxhw0My9vYAl8Lh1HPcvZL99itmKD8zu+k=;
        b=CecfexLJMLQqLgct1kcayjVovoOVfjgnlbq2PX4MKSxi5MDotkZaUa6g6SPHQ+8eYp
         rjZoskXcjz48ZKfELwjrDYCyKXCyVSbdRYQTI0SYtZjTUiDuexe6TZjtiZ6aTtVBrjWn
         knUJiDXDCsSviohdylXXBStje2L+aFD5cX7sGptVur/xQxpI2ZBgjKSLeDMihM38p++W
         QWR1D5VARuHpE1TNFQVcFU0qND0na5X0ZfllxK5xRAXHhfT0z7JcUSyU/4l3khPAGQnn
         96z+4eEOBaT8ZHsMooBqo85N4kM0N9hj9xFll76nQJIjI/T4lJlx4/8+O1xR4aubnzlm
         uO5g==
X-Gm-Message-State: AJIora/nKlAdi+5SiEfeZziITh1BbRrH3cI2sc4C4cfldxOfdqaIoqo+
        Hg66lC6XSrNav2xRMQrRH77Eq0plagsheQ==
X-Google-Smtp-Source: AGRyM1vE/mG7QCD8IRatcZdY7vV1WYUQ4lKWutgPWI3I0r0rL6Ap/kuaF/9WmVKggwfW3frPcA4/qg==
X-Received: by 2002:ad4:4ea2:0:b0:473:6d91:6759 with SMTP id ed2-20020ad44ea2000000b004736d916759mr2253435qvb.102.1658532546672;
        Fri, 22 Jul 2022 16:29:06 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id f22-20020ac84716000000b0031ed590433bsm3517113qtp.78.2022.07.22.16.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 16:29:06 -0700 (PDT)
Date:   Fri, 22 Jul 2022 19:29:05 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: [PATCH 2/2] builtin/cat-file.c: support NUL-delimited input with `-z`
Message-ID: <ed1583223f63cfde99829069f14af62e4f0f2a82.1658532524.git.me@ttaylorr.com>
References: <cover.1658532524.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1658532524.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When callers are using `cat-file` via one of the stdin-driven `--batch`
modes, all input is newline-delimited. This presents a problem when
callers wish to ask about, e.g. tree-entries that have a newline
character present in their filename.

To support this niche scenario, introduce a new `-z` mode to the
`--batch`, `--batch-check`, and `--batch-command` suite of options that
instructs `cat-file` to treat its input as NUL-delimited, allowing the
individual commands themselves to have newlines present.

The refactoring here is slightly unfortunate, since we turn loops like:

    while (strbuf_getline(&buf, stdin) != EOF)

into:

    while (1) {
        int ret;
        if (opt->nul_terminated)
            ret = strbuf_getline_nul(&input, stdin);
        else
            ret = strbuf_getline(&input, stdin);

        if (ret == EOF)
            break;
    }

It's tempting to think that we could use `strbuf_getwholeline()` and
specify either `\n` or `\0` as the terminating character. But for input
on platforms that include a CR character preceeding the LF, this
wouldn't quite be the same, since `strbuf_getline(...)` will trim any
trailing CR, while `strbuf_getwholeline(&buf, stdin, '\n')` will not.

In the future, we could clean this up further by introducing a variant
of `strbuf_getwholeline()` that addresses the aforementioned gap, but
that approach felt too heavy-handed for this pair of uses.

Some tests are added in t1006 to ensure that `cat-file` produces the
same output in `--batch`, `--batch-check`, and `--batch-command` modes
with and without the new `-z` option.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-cat-file.txt |  7 +++++-
 builtin/cat-file.c             | 28 ++++++++++++++++++++---
 t/t1006-cat-file.sh            | 42 +++++++++++++++++++++++++++++++++-
 3 files changed, 72 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index 24a811f0ef..3515350ed6 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -14,7 +14,7 @@ SYNOPSIS
 'git cat-file' (-t | -s) [--allow-unknown-type] <object>
 'git cat-file' (--batch | --batch-check | --batch-command) [--batch-all-objects]
 	     [--buffer] [--follow-symlinks] [--unordered]
-	     [--textconv | --filters]
+	     [--textconv | --filters] [-z]
 'git cat-file' (--textconv | --filters)
 	     [<rev>:<path|tree-ish> | --path=<path|tree-ish> <rev>]
 
@@ -207,6 +207,11 @@ respectively print:
 	/etc/passwd
 --
 
+-z::
+	Only meaningful with `--batch`, `--batch-check`, or
+	`--batch-command`; input is NUL-delimited instead of
+	newline-delimited.
+
 
 OUTPUT
 ------
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index f42782e955..c3602d15df 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -31,6 +31,7 @@ struct batch_options {
 	int all_objects;
 	int unordered;
 	int transform_mode; /* may be 'w' or 'c' for --filters or --textconv */
+	int nul_terminated;
 	const char *format;
 };
 
@@ -614,12 +615,20 @@ static void batch_objects_command(struct batch_options *opt,
 	struct queued_cmd *queued_cmd = NULL;
 	size_t alloc = 0, nr = 0;
 
-	while (!strbuf_getline(&input, stdin)) {
-		int i;
+	while (1) {
+		int i, ret;
 		const struct parse_cmd *cmd = NULL;
 		const char *p = NULL, *cmd_end;
 		struct queued_cmd call = {0};
 
+		if (opt->nul_terminated)
+			ret = strbuf_getline_nul(&input, stdin);
+		else
+			ret = strbuf_getline(&input, stdin);
+
+		if (ret)
+			break;
+
 		if (!input.len)
 			die(_("empty command in input"));
 		if (isspace(*input.buf))
@@ -763,7 +772,16 @@ static int batch_objects(struct batch_options *opt)
 		goto cleanup;
 	}
 
-	while (strbuf_getline(&input, stdin) != EOF) {
+	while (1) {
+		int ret;
+		if (opt->nul_terminated)
+			ret = strbuf_getline_nul(&input, stdin);
+		else
+			ret = strbuf_getline(&input, stdin);
+
+		if (ret == EOF)
+			break;
+
 		if (data.split_on_whitespace) {
 			/*
 			 * Split at first whitespace, tying off the beginning
@@ -866,6 +884,7 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 			N_("like --batch, but don't emit <contents>"),
 			PARSE_OPT_OPTARG | PARSE_OPT_NONEG,
 			batch_option_callback),
+		OPT_BOOL('z', NULL, &batch.nul_terminated, N_("stdin is NUL-terminated")),
 		OPT_CALLBACK_F(0, "batch-command", &batch, N_("format"),
 			N_("read commands from stdin"),
 			PARSE_OPT_OPTARG | PARSE_OPT_NONEG,
@@ -921,6 +940,9 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 	else if (batch.all_objects)
 		usage_msg_optf(_("'%s' requires a batch mode"), usage, options,
 			       "--batch-all-objects");
+	else if (batch.nul_terminated)
+		usage_msg_optf(_("'%s' requires a batch mode"), usage, options,
+			       "-z");
 
 	/* Batch defaults */
 	if (batch.buffer_output < 0)
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 01c0535765..23b8942edb 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -88,7 +88,8 @@ done
 
 for opt in --buffer \
 	--follow-symlinks \
-	--batch-all-objects
+	--batch-all-objects \
+	-z
 do
 	test_expect_success "usage: bad option combination: $opt without batch mode" '
 		test_incompatible_usage git cat-file $opt &&
@@ -100,6 +101,10 @@ echo_without_newline () {
     printf '%s' "$*"
 }
 
+echo_without_newline_nul () {
+	echo_without_newline "$@" | tr '\n' '\0'
+}
+
 strlen () {
     echo_without_newline "$1" | wc -c | sed -e 's/^ *//'
 }
@@ -398,6 +403,12 @@ test_expect_success '--batch with multiple sha1s gives correct format' '
 	test "$(maybe_remove_timestamp "$batch_output" 1)" = "$(maybe_remove_timestamp "$(echo_without_newline "$batch_input" | git cat-file --batch)" 1)"
 '
 
+test_expect_success '--batch, -z with multiple sha1s gives correct format' '
+	echo_without_newline_nul "$batch_input" >in &&
+	test "$(maybe_remove_timestamp "$batch_output" 1)" = \
+	"$(maybe_remove_timestamp "$(git cat-file --batch -z <in)" 1)"
+'
+
 batch_check_input="$hello_sha1
 $tree_sha1
 $commit_sha1
@@ -418,6 +429,24 @@ test_expect_success "--batch-check with multiple sha1s gives correct format" '
     "$(echo_without_newline "$batch_check_input" | git cat-file --batch-check)"
 '
 
+test_expect_success "--batch-check, -z with multiple sha1s gives correct format" '
+    echo_without_newline_nul "$batch_check_input" >in &&
+    test "$batch_check_output" = "$(git cat-file --batch-check -z <in)"
+'
+
+test_expect_success FUNNYNAMES '--batch-check, -z with newline in input' '
+	touch -- "newline${LF}embedded" &&
+	git add -- "newline${LF}embedded" &&
+	git commit -m "file with newline embedded" &&
+	test_tick &&
+
+	printf "HEAD:newline${LF}embedded" >in &&
+	git cat-file --batch-check -z <in >actual &&
+
+	echo "$(git rev-parse "HEAD:newline${LF}embedded") blob 0" >expect &&
+	test_cmp expect actual
+'
+
 batch_command_multiple_info="info $hello_sha1
 info $tree_sha1
 info $commit_sha1
@@ -436,6 +465,11 @@ test_expect_success '--batch-command with multiple info calls gives correct form
 	echo "$batch_command_multiple_info" >in &&
 	git cat-file --batch-command --buffer <in >actual &&
 
+	test_cmp expect actual &&
+
+	echo "$batch_command_multiple_info" | tr "\n" "\0" >in &&
+	git cat-file --batch-command --buffer -z <in >actual &&
+
 	test_cmp expect actual
 '
 
@@ -459,6 +493,12 @@ test_expect_success '--batch-command with multiple command calls gives correct f
 	echo "$batch_command_multiple_contents" >in &&
 	git cat-file --batch-command --buffer <in >actual_raw &&
 
+	remove_timestamp <actual_raw >actual &&
+	test_cmp expect actual &&
+
+	echo "$batch_command_multiple_contents" | tr "\n" "\0" >in &&
+	git cat-file --batch-command --buffer -z <in >actual_raw &&
+
 	remove_timestamp <actual_raw >actual &&
 	test_cmp expect actual
 '
-- 
2.37.0.1.g1379af2e9d
