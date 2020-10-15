Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F4CC433E7
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 07:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C13EA2224A
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 07:24:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbgJOHYU convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 15 Oct 2020 03:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbgJOHYQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 03:24:16 -0400
Received: from mx.pao1.isc.org (mx.pao1.isc.org [IPv6:2001:4f8:0:2::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEAF3C061755
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 00:24:16 -0700 (PDT)
Received: from zmx1.isc.org (zmx1.isc.org [149.20.0.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.pao1.isc.org (Postfix) with ESMTPS id A68D83AB19E
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 07:24:16 +0000 (UTC)
Received: from zmx1.isc.org (localhost [127.0.0.1])
        by zmx1.isc.org (Postfix) with ESMTPS id 66999160083
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 07:24:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by zmx1.isc.org (Postfix) with ESMTP id 5B5E716006B
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 07:24:16 +0000 (UTC)
Received: from zmx1.isc.org ([127.0.0.1])
        by localhost (zmx1.isc.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id FBZa9nQIN4eL for <git@vger.kernel.org>;
        Thu, 15 Oct 2020 07:24:16 +0000 (UTC)
Received: from larwa.hq.kempniu.pl (unknown [212.180.223.213])
        by zmx1.isc.org (Postfix) with ESMTPSA id C6B7716005D
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 07:24:15 +0000 (UTC)
From:   =?UTF-8?q?Micha=C5=82=20K=C4=99pie=C5=84?= <michal@isc.org>
To:     git@vger.kernel.org
Subject: [PATCH v3 2/2] diff: add -I<regex> that ignores matching changes
Date:   Thu, 15 Oct 2020 09:24:06 +0200
Message-Id: <20201015072406.4506-3-michal@isc.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201015072406.4506-1-michal@isc.org>
References: <20201012091751.19594-1-michal@isc.org>
 <20201015072406.4506-1-michal@isc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a new diff option that enables ignoring changes whose all lines
(changed, removed, and added) match a given regular expression.  This is
similar to the -I/--ignore-matching-lines option in standalone diff
utilities and can be used e.g. to ignore changes which only affect code
comments or to look for unrelated changes in commits containing a large
number of automatically applied modifications (e.g. a tree-wide string
replacement).  The difference between -G/-S and the new -I option is
that the latter filters output on a per-change basis.

Use the 'ignore' field of xdchange_t for marking a change as ignored or
not.  Since the same field is used by --ignore-blank-lines, identical
hunk emitting rules apply for --ignore-blank-lines and -I.  These two
options can also be used together in the same git invocation (they are
complementary to each other).

Rename xdl_mark_ignorable() to xdl_mark_ignorable_lines(), to indicate
that it is logically a "sibling" of xdl_mark_ignorable_regex() rather
than its "parent".

Signed-off-by: Michał Kępień <michal@isc.org>
---
 Documentation/diff-options.txt |  5 ++++
 diff.c                         | 28 ++++++++++++++++++++
 diff.h                         |  4 +++
 t/t4013-diff-various.sh        | 33 ++++++++++++++++++++++++
 xdiff/xdiff.h                  |  4 +++
 xdiff/xdiffi.c                 | 47 ++++++++++++++++++++++++++++++++--
 6 files changed, 119 insertions(+), 2 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 573fb9bb71..ee52b65e46 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -687,6 +687,11 @@ endif::git-format-patch[]
 --ignore-blank-lines::
 	Ignore changes whose lines are all blank.
 
+-I<regex>::
+--ignore-matching-lines=<regex>::
+	Ignore changes whose all lines match <regex>.  This option may
+	be specified more than once.
+
 --inter-hunk-context=<lines>::
 	Show the context between diff hunks, up to the specified number
 	of lines, thereby fusing hunks that are close to each other.
diff --git a/diff.c b/diff.c
index 2bb2f8f57e..677de23352 100644
--- a/diff.c
+++ b/diff.c
@@ -3587,6 +3587,8 @@ static void builtin_diff(const char *name_a,
 		if (header.len && !o->flags.suppress_diff_headers)
 			ecbdata.header = &header;
 		xpp.flags = o->xdl_opts;
+		xpp.ignore_regex = o->ignore_regex;
+		xpp.ignore_regex_nr = o->ignore_regex_nr;
 		xpp.anchors = o->anchors;
 		xpp.anchors_nr = o->anchors_nr;
 		xecfg.ctxlen = o->context;
@@ -3716,6 +3718,8 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
 		memset(&xpp, 0, sizeof(xpp));
 		memset(&xecfg, 0, sizeof(xecfg));
 		xpp.flags = o->xdl_opts;
+		xpp.ignore_regex = o->ignore_regex;
+		xpp.ignore_regex_nr = o->ignore_regex_nr;
 		xpp.anchors = o->anchors;
 		xpp.anchors_nr = o->anchors_nr;
 		xecfg.ctxlen = o->context;
@@ -5203,6 +5207,22 @@ static int diff_opt_patience(const struct option *opt,
 	return 0;
 }
 
+static int diff_opt_ignore_regex(const struct option *opt,
+				 const char *arg, int unset)
+{
+	struct diff_options *options = opt->value;
+	regex_t *regex;
+
+	BUG_ON_OPT_NEG(unset);
+	regex = xmalloc(sizeof(*regex));
+	if (regcomp(regex, arg, REG_EXTENDED | REG_NEWLINE))
+		return error(_("invalid regex given to -I: '%s'"), arg);
+	ALLOC_GROW(options->ignore_regex, options->ignore_regex_nr + 1,
+		   options->ignore_regex_alloc);
+	options->ignore_regex[options->ignore_regex_nr++] = regex;
+	return 0;
+}
+
 static int diff_opt_pickaxe_regex(const struct option *opt,
 				  const char *arg, int unset)
 {
@@ -5491,6 +5511,9 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_BIT_F(0, "ignore-blank-lines", &options->xdl_opts,
 			  N_("ignore changes whose lines are all blank"),
 			  XDF_IGNORE_BLANK_LINES, PARSE_OPT_NONEG),
+		OPT_CALLBACK_F('I', "ignore-matching-lines", options, N_("<regex>"),
+			       N_("ignore changes whose all lines match <regex>"),
+			       0, diff_opt_ignore_regex),
 		OPT_BIT(0, "indent-heuristic", &options->xdl_opts,
 			N_("heuristic to shift diff hunk boundaries for easy reading"),
 			XDF_INDENT_HEURISTIC),
@@ -6405,6 +6428,11 @@ void diff_flush(struct diff_options *options)
 	DIFF_QUEUE_CLEAR(q);
 	if (options->close_file)
 		fclose(options->file);
+	for (i = 0; i < options->ignore_regex_nr; i++) {
+		regfree(options->ignore_regex[i]);
+		free(options->ignore_regex[i]);
+	}
+	free(options->ignore_regex);
 
 	/*
 	 * Report the content-level differences with HAS_CHANGES;
diff --git a/diff.h b/diff.h
index 11de52e9e9..a402227b80 100644
--- a/diff.h
+++ b/diff.h
@@ -234,6 +234,10 @@ struct diff_options {
 	 */
 	const char *pickaxe;
 
+	/* -I<regex> */
+	regex_t **ignore_regex;
+	size_t ignore_regex_nr, ignore_regex_alloc;
+
 	const char *single_follow;
 	const char *a_prefix, *b_prefix;
 	const char *line_prefix;
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 5c7b0122b4..efaaee2ef0 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -6,6 +6,7 @@
 test_description='Various diff formatting options'
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/diff-lib.sh
 
 test_expect_success setup '
 
@@ -473,4 +474,36 @@ test_expect_success 'diff-tree --stdin with log formatting' '
 	test_cmp expect actual
 '
 
+test_expect_success 'diff -I<regex>' '
+	test_seq 50 >I.txt &&
+	sed -e "s/13/ten and three/" -e "/7\$/d" <I.txt >J.txt &&
+	echo >>J.txt &&
+
+	test_expect_code 1 git diff --no-index --ignore-blank-lines -I"ten.*e" -I"^[124-9]" I.txt J.txt >actual &&
+	cat >expect <<-\EOF &&
+	diff --git a/I.txt b/J.txt
+	--- a/I.txt
+	+++ b/J.txt
+	@@ -34,7 +31,6 @@
+	 34
+	 35
+	 36
+	-37
+	 38
+	 39
+	 40
+	EOF
+	compare_diff_patch expect actual &&
+
+	test_expect_code 1 git diff --stat --no-index --ignore-blank-lines -I"ten.*e" -I"^[124-9]" I.txt J.txt >actual &&
+	cat >expect <<-\EOF &&
+	 I.txt => J.txt | 1 -
+	 1 file changed, 1 deletion(-)
+	EOF
+	test_cmp expect actual &&
+
+	test_expect_code 129 git diff --no-index --ignore-matching-lines="^[124-9]" --ignore-matching-lines="^[124-9" I.txt J.txt >output 2>&1 &&
+	test_i18ngrep "invalid regex given to -I: " output
+'
+
 test_done
diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index 032e3a9f41..7a04605146 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -79,6 +79,10 @@ typedef struct s_mmbuffer {
 typedef struct s_xpparam {
 	unsigned long flags;
 
+	/* -I<regex> */
+	regex_t **ignore_regex;
+	size_t ignore_regex_nr;
+
 	/* See Documentation/diff-options.txt. */
 	char **anchors;
 	size_t anchors_nr;
diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index bd035139f9..380eb728ed 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -998,7 +998,7 @@ static int xdl_call_hunk_func(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
 	return 0;
 }
 
-static void xdl_mark_ignorable(xdchange_t *xscr, xdfenv_t *xe, long flags)
+static void xdl_mark_ignorable_lines(xdchange_t *xscr, xdfenv_t *xe, long flags)
 {
 	xdchange_t *xch;
 
@@ -1019,6 +1019,46 @@ static void xdl_mark_ignorable(xdchange_t *xscr, xdfenv_t *xe, long flags)
 	}
 }
 
+static int record_matches_regex(xrecord_t *rec, xpparam_t const *xpp) {
+	regmatch_t regmatch;
+	int i;
+
+	for (i = 0; i < xpp->ignore_regex_nr; i++)
+		if (!regexec_buf(xpp->ignore_regex[i], rec->ptr, rec->size, 1,
+				 &regmatch, 0))
+			return 1;
+
+	return 0;
+}
+
+static void xdl_mark_ignorable_regex(xdchange_t *xscr, const xdfenv_t *xe,
+				     xpparam_t const *xpp)
+{
+	xdchange_t *xch;
+
+	for (xch = xscr; xch; xch = xch->next) {
+		xrecord_t **rec;
+		int ignore = 1;
+		long i;
+
+		/*
+		 * Do not override --ignore-blank-lines.
+		 */
+		if (xch->ignore)
+			continue;
+
+		rec = &xe->xdf1.recs[xch->i1];
+		for (i = 0; i < xch->chg1 && ignore; i++)
+			ignore = record_matches_regex(rec[i], xpp);
+
+		rec = &xe->xdf2.recs[xch->i2];
+		for (i = 0; i < xch->chg2 && ignore; i++)
+			ignore = record_matches_regex(rec[i], xpp);
+
+		xch->ignore = ignore;
+	}
+}
+
 int xdl_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 	     xdemitconf_t const *xecfg, xdemitcb_t *ecb) {
 	xdchange_t *xscr;
@@ -1038,7 +1078,10 @@ int xdl_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 	}
 	if (xscr) {
 		if (xpp->flags & XDF_IGNORE_BLANK_LINES)
-			xdl_mark_ignorable(xscr, &xe, xpp->flags);
+			xdl_mark_ignorable_lines(xscr, &xe, xpp->flags);
+
+		if (xpp->ignore_regex)
+			xdl_mark_ignorable_regex(xscr, &xe, xpp);
 
 		if (ef(&xe, xscr, ecb, xecfg) < 0) {
 
-- 
2.28.0

