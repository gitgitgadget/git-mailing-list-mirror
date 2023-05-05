Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD61C77B75
	for <git@archiver.kernel.org>; Fri,  5 May 2023 16:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjEEQ75 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 May 2023 12:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231730AbjEEQ7z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2023 12:59:55 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E78B30EE
        for <git@vger.kernel.org>; Fri,  5 May 2023 09:59:54 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-24e14a24c9dso1508036a91.0
        for <git@vger.kernel.org>; Fri, 05 May 2023 09:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683305994; x=1685897994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5QE0A7UYyAtrG5ZOUi8/BrjgPEzUirE9nvZziVM3/J4=;
        b=ieNw/1+kV0bcAW7Fksgj3Lia7xAHpIYSDuC0Us+57MOAQ6Ero7bFqomZQrRkxq3lvt
         bxlc4ORviNifWHi0ciCHRp/XHA9KGBAsCqzr8Ok2UmTaWvZsezuBN+ySxQhW9elvTrhS
         LtdaA0yKBGX5EYt9TeUIBGyjp7ttIHGmzKMtLpLcZ8NlkCHzM1j85NZbH7xuHmJO6DWY
         5pX3W7VUyM4t68Rox+TcBCgcgeWDFjXhC6tlyYhGg8ZpTzRcCndXDAnfpsxaxOHXI1eB
         Py1de46EccUb8ws6mn143tZb9v9gYqfZsvFVVzO+jO64775y1viNY3K/P8semmgqz8s2
         jriw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683305994; x=1685897994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:sender:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5QE0A7UYyAtrG5ZOUi8/BrjgPEzUirE9nvZziVM3/J4=;
        b=RAkK46jRvr7dKe4JJNplhDnjsgIHYlKAR2FWH/L4ozIhlZpA7JkpXUcCUo4hSlNuCW
         RNRsafkLVLWbm3LuxlaMX7TW3EA60fyqwLjsvq8MrDnnK7u0RIPRkUIntCukiZy3IzGP
         t3xq8yRmdUoTO+jQ9hTVqoaib+A/MTXhPcGV4k2pAg4DKMLRn17fpi3UZ/XsP79w8UlQ
         TYCCWyZ2MfZuthhghdLb73P5vjwSjY79N6HXNM9+wgE+vQfjM39qR7Koh6zv6+Jqq3OM
         jywjR6Bhp7Wl4Jl4XjkQEp0i7iZKyYiF5beS55bdZVgXnkUJbPFhfqrzTteGrqmeejNN
         S3bQ==
X-Gm-Message-State: AC+VfDx8zblRJ65N85YmA1eCLkGOdika+2S/WanBSWB7bGAnyp+9DCyL
        mseNyESR7ExP44E5gudI91FvveqOxIg=
X-Google-Smtp-Source: ACHHUZ6NFgItd34s+0kngcffm52RNL7R97j7Ud7k96hjvXckFnovOESCxLlP7xppm27pVvD26aGU9Q==
X-Received: by 2002:a17:90a:d498:b0:24e:10b3:c9cc with SMTP id s24-20020a17090ad49800b0024e10b3c9ccmr2213483pju.14.1683305993461;
        Fri, 05 May 2023 09:59:53 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id w1-20020a655341000000b0051815eae23esm1817694pgr.27.2023.05.05.09.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 09:59:53 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v2] diff: fix interaction between the "-s" option and other options
Date:   Fri,  5 May 2023 09:59:52 -0700
Message-ID: <20230505165952.335256-1-gitster@pobox.com>
X-Mailer: git-send-email 2.40.1-476-g69c786637d
In-Reply-To: <xmqqfs8bith1.fsf_-_@gitster.g>
References: <xmqqfs8bith1.fsf_-_@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov noticed and reported "--patch --no-patch --raw"
behaves differently from just "--raw".  It turns out that there are
a few interesting bugs in the implementation and documentation.

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
   interesting bugs to happen, and we have both X-<.

   (1) After setting a format bit, then setting NO_OUTPUT with "-s",
       the code to process another "--<format>" option drops the
       NO_OUTPUT bit to allow output to be shown again.  However,
       the code to handle "-s" only set NO_OUTPUT without unsetting
       format bits set earlier, so the earlier format bit got
       revealed upon seeing the second "--<format>" option.  This is
       the problem Sergey observed.

   (2) After setting NO_OUTPUT with "-s", code to process
       "--<format>" option can forget to unset NO_OUTPUT, leaving
       the command still silent.

It is tempting to change the meaning of "--no-patch" to mean
"disable only the patch format output" and reimplement "-s" as "not
showing anything", but it would be an end-user visible change in
behavior.  Let's fix the interactions of these bits to first make
"-s" work as intended.

The fix is conceptually very simple.

 * Whenever we set DIFF_FORMAT_FOO because we saw the "--foo"
   option (e.g. DIFF_FORMAT_RAW is set when the "--raw" option is
   given), we make sure we drop DIFF_FORMAT_NO_OUTPUT.  We forgot to
   do so in some of the options and caused (2) above.

 * When processing "-s" option, we should not just set
   DIFF_FORMAT_NO_OUTPUT bit, but clear other DIFF_FORMAT_* bits.
   We didn't do so and retained format bits set by options
   previously seen, causing (1) above.

It is even more tempting to lose NO_OUTPUT bit and instead take
output_format word being 0 as its replacement, but that would break
the mechanism "git show" uses to default to "--patch" output, where
the distinction between telling the command to be silent with "-s"
and having no output format specified on the command line matters,
and an explicit output format given on the command line should not
be "combined" with the default "--patch" format.

So, while we cannot lose the NO_OUTPUT bit, as a follow-up work, we
may want to replace it with OPTION_GIVEN bit, and

 * make "--patch", "--raw", etc. set DIFF_FORMAT_$format bit and
   DIFF_FORMAT_OPTION_GIVEN bit on for each format.  "--no-raw",
   etc. will set off DIFF_FORMAT_$format bit but still record the
   fact that we saw an option from the command line by setting
   DIFF_FORMAT_OPTION_GIVEN bit.

 * make "-s" (and its synonym "--no-patch") clear all other bits
   and set only the DIFF_FORMAT_OPTION_GIVEN bit on.

which I suspect would make the code much cleaner without breaking
any end-user expectations.

Once that is in place, transitioning "--no-patch" to mean the
counterpart of "--patch", just like "--no-raw" only defeats an
earlier "--raw", would be quite simple at the code level.  The
social cost of migrating the end-user expectations might be too
great for it to be worth, but at least the "GIVEN" bit clean-up
alone may be worth it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/diff-options.txt |  7 +++++--
 diff.c                         | 24 +++++++++++++-----------
 t/t4000-diff-format.sh         | 34 +++++++++++++++++++++++++++++++++-
 3 files changed, 51 insertions(+), 14 deletions(-)

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
index bfcaae390f..8d50331b8c 100755
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
@@ -91,4 +96,31 @@ test_expect_success 'git diff-files --patch --no-patch does not show the patch'
 	test_must_be_empty err
 '
 
+
+# Smudge path2/path3 so that dirstat has something to show
+date >path2/path3
+
+for format in stat raw numstat shortstat summary \
+	dirstat cumulative dirstat-by-file \
+	patch-with-raw patch-with-stat compact-summary
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

