Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB03DC77B7C
	for <git@archiver.kernel.org>; Thu,  4 May 2023 23:10:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjEDXKH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 May 2023 19:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjEDXKG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2023 19:10:06 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C04D12094
        for <git@vger.kernel.org>; Thu,  4 May 2023 16:10:04 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-52160f75920so722516a12.2
        for <git@vger.kernel.org>; Thu, 04 May 2023 16:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683241804; x=1685833804;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ENwsoERRLStUxbBtRHHrJBwOzuzBxQm+yb20nC9JNiE=;
        b=UV9HgpnTZAfNzv7oSF+SgMHEK3Ids0F8ZijMHnH3IMGHcuQB2Fq4jpJH/It0fvwmZG
         LRbMLTYuAwk4mgM0VuEpeVlujwmyM7ah15IqLvDkpZye9dVxGxKXnteaeMfoQBKz20k9
         grc6rt/xV8aOp6x8wWHvsx/BJftGgR+3s6nBBGHIkd7fMHrEeBOt4mooYvuLVJUEqSGh
         R9fy9F6ptIejr/Zcc/dDKiN+KcVqwrP7t1Tlm9Z5eNyk+3mzsZGVXqvxqSHa64P2E8Zf
         LCsEfdqZpd2uM7TgUIAQ521D+NLH4sHIt8HmNE8GHKQguu8N7m0i8ntitBqGRj659ZZE
         yqRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683241804; x=1685833804;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ENwsoERRLStUxbBtRHHrJBwOzuzBxQm+yb20nC9JNiE=;
        b=SUWNwoqJ8DEWM+S84xop0qnhfHy7PdzDI5uJeqgYH2kYFB7rZJNeLUn80YXXze9KAN
         ssD0geoWkDCeettEjey8GEQ/E1ePMd2Ct6zVt6EwrZrpXsJH8ANZtzAPkwGngu1joBkE
         L8wTZlpvbvT/sRsT3nqV/k2SqIs2BrdC5SLTa3aOehka/P4scQgw2wDXbbrBUhT+QEMa
         MkIiYiRewqiywJtNkoXRZCwGV2dRKUzaZfou5As+LNIWnGp52NyrKSonXiJyvc+FdOpt
         S1PyzicZzSxi+xTb+XAaCdMC0eS9tgMRfPqyDCJ1Usp9ImIuhAt2b6KmaNwAIrUNPzyj
         E7uQ==
X-Gm-Message-State: AC+VfDzh2ihU2kyJApsCXqAAPrlwKnjjLTSTDYb6+03h2LoJy0s6Mbxx
        67UPr6hyNqojm5V2bYFMZNWA+7P6w0c=
X-Google-Smtp-Source: ACHHUZ5J2FgcCPhLjtbimYTSMT373u31Z6MBsYW6skHdqKFol+PYXY2FW+2tCaP0nr83RWsmqWul8w==
X-Received: by 2002:a17:902:ce8d:b0:1aa:ef83:34be with SMTP id f13-20020a170902ce8d00b001aaef8334bemr5953323plg.47.1683241803474;
        Thu, 04 May 2023 16:10:03 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id t15-20020a170902b20f00b001aaeaa27dd5sm58700plr.252.2023.05.04.16.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 16:10:03 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Sergey Organov <sorganov@gmail.com>
Subject: [PATCH] diff: fix behaviour of the "-s" option
References: <20230503134118.73504-1-sorganov@gmail.com>
        <xmqqsfcdtkt0.fsf@gitster.g> <874jote2zl.fsf@osv.gnss.ru>
        <xmqqmt2lqofb.fsf@gitster.g> <xmqqttwskse5.fsf@gitster.g>
        <87o7n03qgq.fsf@osv.gnss.ru> <xmqqpm7fizsl.fsf@gitster.g>
        <xmqqjzxnixqr.fsf_-_@gitster.g>
Date:   Thu, 04 May 2023 16:10:02 -0700
In-Reply-To: <xmqqjzxnixqr.fsf_-_@gitster.g> (Junio C. Hamano's message of
        "Thu, 04 May 2023 14:37:48 -0700")
Message-ID: <xmqqfs8bith1.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I haven't run any tests (not just your new one, but existing ones)
> but ...

And of course, not writing tests fails to even realize that the bug
has two components, "-s" failing to clear the bits previously set,
and other options not clearing the bit set by "-s".

This version may still be rough, but at least the full test suite
has been run with it, so I have a bit more confidence than the
earlier one (which may not mean much).

------- >8 ------------- >8 ------------- >8 -------------
Sergey Organov noticed and reported "--patch --no-patch --raw"
behaves differently from "--raw".  It turns out there are a few
interesting bugs in the implementation and documentation.

 * First, the documentation for "--no-patch" was unclear that it
   could be read to mean "--no-patch" countermands an earlier
   "--patch" but not other things.  The intention of "--no-patch"
   ever since it was introduced at d09cd15d (diff: allow --no-patch
   as synonym for -s, 2013-07-16) was to serve as a synonym for
   "-s", so "--raw --patch --no-patch" should have produced no
   output, but it can be (mis)read to allow showing only "--raw"
   output.

 * Then the interaction between "-s" and other format options were
   poorly implemented.  Modern versions of Git uses one bit each to
   represent formatting options like "--patch", "--stat" in a single
   output_format word, but for historical reasons, "-s" also is
   represented as another bit in the same word.  This allows two
   interesting bugs to happen, and we have both.

   (1) After setting a format bit, then setting NO_OUTPUT with "-s",
       the code to process another "--<format>" option drops the
       NO_OUTPUT bit to allow output to be shown again.  However,
       the code to handle "-s" only set NO_OUTPUT without unsetting
       format bits set earlier, so the earlier format bit got
       revealed upon seeing the second "--<format>" option.  THis is
       the problem Sergey observed.

   (2) After setting NO_OUTPUT with "-s", code to process
       "--<format>" option can forget to unset NO_OUTPUT, leaving
       the command still silent.

It is tempting to change the meaning of "--no-patch" to mean
"disable only the patch format output" and reimplement "-s" as "not
showing anything", but it would be an end-user visible change in
behaviour.  Let's fix the interactions of these bits to first make
"-s" work as intended.

The fix is conceptually very simple.

 * Whenever we set DIFF_FORMAT_FOO becasuse we saw the "--foo"
   option (e.g. DIFF_FORMAT_RAW is set when the "--raw" option is
   given), we make sure we drop DIFF_FORMAT_NO_OUTPUT.  We forgot to
   do so in some of the options and caused (2) above.

 * When processing "-s" option, we should not just set
   DIFF_FORMAT_NO_OUTPUT bit, but clear other DIFF_FORMAT_* bits.
   We didn't do so and retained format bits set by options
   previously seen, causing (1) above.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/diff-options.txt |  7 +++++--
 diff.c                         | 24 +++++++++++++-----------
 t/t4000-diff-format.sh         | 32 +++++++++++++++++++++++++++++++-
 3 files changed, 49 insertions(+), 14 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 3674ac48e9..7d5bb65a49 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -29,8 +29,11 @@ endif::git-diff[]
 
 -s::
 --no-patch::
-	Suppress diff output. Useful for commands like `git show` that
-	show the patch by default, or to cancel the effect of `--patch`.
+	Suppress all output from the diff machinery.  Useful for
+	commands like `git show` that show the patch by default to
+	squelch their output, or to cancel the effect of options like
+	`--patch`, `--stat` earlier on the command line in an alias.
+
 endif::git-format-patch[]
 
 ifdef::git-log[]
diff --git a/diff.c b/diff.c
index 648f6717a5..5a2f096683 100644
--- a/diff.c
+++ b/diff.c
@@ -4868,6 +4868,7 @@ static int diff_opt_stat(const struct option *opt, const char *value, int unset)
 	} else
 		BUG("%s should not get here", opt->long_name);
 
+	options->output_format &= ~DIFF_FORMAT_NO_OUTPUT;
 	options->output_format |= DIFF_FORMAT_DIFFSTAT;
 	options->stat_name_width = name_width;
 	options->stat_graph_width = graph_width;
@@ -4887,6 +4888,7 @@ static int parse_dirstat_opt(struct diff_options *options, const char *params)
 	 * The caller knows a dirstat-related option is given from the command
 	 * line; allow it to say "return this_function();"
 	 */
+	options->output_format &= ~DIFF_FORMAT_NO_OUTPUT;
 	options->output_format |= DIFF_FORMAT_DIRSTAT;
 	return 1;
 }
@@ -5086,6 +5088,7 @@ static int diff_opt_compact_summary(const struct option *opt,
 		options->flags.stat_with_summary = 0;
 	} else {
 		options->flags.stat_with_summary = 1;
+		options->output_format &= ~DIFF_FORMAT_NO_OUTPUT;
 		options->output_format |= DIFF_FORMAT_DIFFSTAT;
 	}
 	return 0;
@@ -5404,9 +5407,8 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_BITOP('p', "patch", &options->output_format,
 			  N_("generate patch"),
 			  DIFF_FORMAT_PATCH, DIFF_FORMAT_NO_OUTPUT),
-		OPT_BIT_F('s', "no-patch", &options->output_format,
-			  N_("suppress diff output"),
-			  DIFF_FORMAT_NO_OUTPUT, PARSE_OPT_NONEG),
+		OPT_SET_INT('s', "no-patch", &options->output_format,
+			    N_("suppress diff output"), DIFF_FORMAT_NO_OUTPUT),
 		OPT_BITOP('u', NULL, &options->output_format,
 			  N_("generate patch"),
 			  DIFF_FORMAT_PATCH, DIFF_FORMAT_NO_OUTPUT),
@@ -5415,9 +5417,9 @@ static void prep_parse_options(struct diff_options *options)
 			       PARSE_OPT_NONEG | PARSE_OPT_OPTARG, diff_opt_unified),
 		OPT_BOOL('W', "function-context", &options->flags.funccontext,
 			 N_("generate diffs with <n> lines context")),
-		OPT_BIT_F(0, "raw", &options->output_format,
+		OPT_BITOP(0, "raw", &options->output_format,
 			  N_("generate the diff in raw format"),
-			  DIFF_FORMAT_RAW, PARSE_OPT_NONEG),
+			  DIFF_FORMAT_RAW, DIFF_FORMAT_NO_OUTPUT),
 		OPT_BITOP(0, "patch-with-raw", &options->output_format,
 			  N_("synonym for '-p --raw'"),
 			  DIFF_FORMAT_PATCH | DIFF_FORMAT_RAW,
@@ -5426,12 +5428,12 @@ static void prep_parse_options(struct diff_options *options)
 			  N_("synonym for '-p --stat'"),
 			  DIFF_FORMAT_PATCH | DIFF_FORMAT_DIFFSTAT,
 			  DIFF_FORMAT_NO_OUTPUT),
-		OPT_BIT_F(0, "numstat", &options->output_format,
+		OPT_BITOP(0, "numstat", &options->output_format,
 			  N_("machine friendly --stat"),
-			  DIFF_FORMAT_NUMSTAT, PARSE_OPT_NONEG),
-		OPT_BIT_F(0, "shortstat", &options->output_format,
+			  DIFF_FORMAT_NUMSTAT, DIFF_FORMAT_NO_OUTPUT),
+		OPT_BITOP(0, "shortstat", &options->output_format,
 			  N_("output only the last line of --stat"),
-			  DIFF_FORMAT_SHORTSTAT, PARSE_OPT_NONEG),
+			  DIFF_FORMAT_SHORTSTAT, DIFF_FORMAT_NO_OUTPUT),
 		OPT_CALLBACK_F('X', "dirstat", options, N_("<param1,param2>..."),
 			       N_("output the distribution of relative amount of changes for each sub-directory"),
 			       PARSE_OPT_NONEG | PARSE_OPT_OPTARG,
@@ -5447,9 +5449,9 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_BIT_F(0, "check", &options->output_format,
 			  N_("warn if changes introduce conflict markers or whitespace errors"),
 			  DIFF_FORMAT_CHECKDIFF, PARSE_OPT_NONEG),
-		OPT_BIT_F(0, "summary", &options->output_format,
+		OPT_BITOP(0, "summary", &options->output_format,
 			  N_("condensed summary such as creations, renames and mode changes"),
-			  DIFF_FORMAT_SUMMARY, PARSE_OPT_NONEG),
+			  DIFF_FORMAT_SUMMARY, DIFF_FORMAT_NO_OUTPUT),
 		OPT_BIT_F(0, "name-only", &options->output_format,
 			  N_("show only names of changed files"),
 			  DIFF_FORMAT_NAME, PARSE_OPT_NONEG),
diff --git a/t/t4000-diff-format.sh b/t/t4000-diff-format.sh
index bfcaae390f..762b9d4c60 100755
--- a/t/t4000-diff-format.sh
+++ b/t/t4000-diff-format.sh
@@ -5,6 +5,9 @@
 
 test_description='Test built-in diff output engine.
 
+We happen to know that all diff plumbing and diff Porcelain share the
+same command line parser, so testing one should be sufficient; pick
+diff-files as a representative.
 '
 
 TEST_PASSES_SANITIZE_LEAK=true
@@ -16,9 +19,11 @@ Line 2
 line 3'
 cat path0 >path1
 chmod +x path1
+mkdir path2
+>path2/path3
 
 test_expect_success 'update-index --add two files with and without +x.' '
-	git update-index --add path0 path1
+	git update-index --add path0 path1 path2/path3
 '
 
 mv path0 path0-
@@ -91,4 +96,29 @@ test_expect_success 'git diff-files --patch --no-patch does not show the patch'
 	test_must_be_empty err
 '
 
+
+# Smudge path2/path3 so that dirstat has something to show
+date >path2/path3
+
+for format in stat raw numstat shortstat dirstat
+do
+	test_expect_success "--no-patch in 'git diff-files --no-patch --$format' is a no-op" '
+		git diff-files --no-patch "--$format" >actual &&
+		git diff-files "--$format" >expect &&
+		test_cmp expect actual
+	'
+
+	test_expect_success "--no-patch clears all previous ones" '
+		git diff-files --$format -s -p >actual &&
+		git diff-files -p >expect &&
+		test_cmp expect actual
+	'
+
+	test_expect_success "--no-patch in 'git diff --no-patch --$format' is a no-op" '
+		git diff --no-patch "--$format" >actual &&
+		git diff "--$format" >expect &&
+		test_cmp expect actual
+	'
+done
+
 test_done
-- 
2.40.1-476-g69c786637d


