Return-Path: <SRS0=yenB=DI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52BA6C47420
	for <git@archiver.kernel.org>; Thu,  1 Oct 2020 12:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10504208B6
	for <git@archiver.kernel.org>; Thu,  1 Oct 2020 12:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732052AbgJAMpD convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 1 Oct 2020 08:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732026AbgJAMpC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Oct 2020 08:45:02 -0400
Received: from mx.pao1.isc.org (mx.pao1.isc.org [IPv6:2001:4f8:0:2::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8117EC0613E2
        for <git@vger.kernel.org>; Thu,  1 Oct 2020 05:45:02 -0700 (PDT)
Received: from zmx1.isc.org (zmx1.isc.org [149.20.0.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.pao1.isc.org (Postfix) with ESMTPS id 58A503AB214
        for <git@vger.kernel.org>; Thu,  1 Oct 2020 12:06:17 +0000 (UTC)
Received: from zmx1.isc.org (localhost [127.0.0.1])
        by zmx1.isc.org (Postfix) with ESMTPS id 39B7916007F
        for <git@vger.kernel.org>; Thu,  1 Oct 2020 12:06:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by zmx1.isc.org (Postfix) with ESMTP id 2D8F916007D
        for <git@vger.kernel.org>; Thu,  1 Oct 2020 12:06:17 +0000 (UTC)
Received: from zmx1.isc.org ([127.0.0.1])
        by localhost (zmx1.isc.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8tIVH6l8nLeq for <git@vger.kernel.org>;
        Thu,  1 Oct 2020 12:06:17 +0000 (UTC)
Received: from larwa.hq.kempniu.pl (unknown [212.180.223.213])
        by zmx1.isc.org (Postfix) with ESMTPSA id 9572D160047
        for <git@vger.kernel.org>; Thu,  1 Oct 2020 12:06:16 +0000 (UTC)
From:   =?UTF-8?q?Micha=C5=82=20K=C4=99pie=C5=84?= <michal@isc.org>
To:     git@vger.kernel.org
Subject: [PATCH 1/2] diff: add -I<regex> that ignores matching changes
Date:   Thu,  1 Oct 2020 14:06:05 +0200
Message-Id: <20201001120606.25773-2-michal@isc.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201001120606.25773-1-michal@isc.org>
References: <20201001120606.25773-1-michal@isc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a new diff option that enables ignoring changes whose all lines
(changed, removed, and added) match a given regular expression.  This is
similar to the -I option in standalone diff utilities and can be used
e.g. to look for unrelated changes in commits containing a large number
of automatically applied modifications (e.g. a tree-wide string
replacement).  The difference between -G/-S and the new -I option is
that the latter filters output on a per-change basis.

Use the 'ignore' field of xdchange_t for marking a change as ignored or
not.  Since the same field is used by --ignore-blank-lines, identical
hunk emitting rules apply for --ignore-blank-lines and -I.  These two
options can also be used together at the same time.

Apart from adding a new field to struct diff_options, also define a new
flag, XDF_IGNORE_REGEX, for the 'xdl_opts' field of that structure.
This is done because the xpparam_t structure (which is used for passing
around the regular expression supplied to -I) is not zeroed out in all
call stacks involving xdl_diff() and thus only performing a NULL check
on xpp->ignore_regex could result in xdl_mark_ignorable_regex() treating
garbage on the stack as a regular expression.  As the 'flags' field of
xpparam_t is initialized in all call stacks involving xdl_diff(), adding
a flag check avoids that problem.

Signed-off-by: Michał Kępień <michal@isc.org>
---
 Documentation/diff-options.txt |  3 +++
 diff.c                         | 16 +++++++++++++++
 diff.h                         |  2 ++
 xdiff/xdiff.h                  |  2 ++
 xdiff/xdiffi.c                 | 36 ++++++++++++++++++++++++++++++++++
 5 files changed, 59 insertions(+)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 573fb9bb71..a7ef3f5645 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -687,6 +687,9 @@ endif::git-format-patch[]
 --ignore-blank-lines::
 	Ignore changes whose lines are all blank.
 
+-I<regex>::
+	Ignore changes whose all lines match <regex>.
+
 --inter-hunk-context=<lines>::
 	Show the context between diff hunks, up to the specified number
 	of lines, thereby fusing hunks that are close to each other.
diff --git a/diff.c b/diff.c
index 2bb2f8f57e..c9603c941e 100644
--- a/diff.c
+++ b/diff.c
@@ -3587,6 +3587,7 @@ static void builtin_diff(const char *name_a,
 		if (header.len && !o->flags.suppress_diff_headers)
 			ecbdata.header = &header;
 		xpp.flags = o->xdl_opts;
+		xpp.ignore_regex = o->ignore_regex;
 		xpp.anchors = o->anchors;
 		xpp.anchors_nr = o->anchors_nr;
 		xecfg.ctxlen = o->context;
@@ -3716,6 +3717,7 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
 		memset(&xpp, 0, sizeof(xpp));
 		memset(&xecfg, 0, sizeof(xecfg));
 		xpp.flags = o->xdl_opts;
+		xpp.ignore_regex = o->ignore_regex;
 		xpp.anchors = o->anchors;
 		xpp.anchors_nr = o->anchors_nr;
 		xecfg.ctxlen = o->context;
@@ -5203,6 +5205,17 @@ static int diff_opt_patience(const struct option *opt,
 	return 0;
 }
 
+static int diff_opt_ignore_regex(const struct option *opt,
+				 const char *arg, int unset)
+{
+	struct diff_options *options = opt->value;
+
+	BUG_ON_OPT_NEG(unset);
+	options->xdl_opts |= XDF_IGNORE_REGEX;
+	options->ignore_regex = arg;
+	return 0;
+}
+
 static int diff_opt_pickaxe_regex(const struct option *opt,
 				  const char *arg, int unset)
 {
@@ -5491,6 +5504,9 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_BIT_F(0, "ignore-blank-lines", &options->xdl_opts,
 			  N_("ignore changes whose lines are all blank"),
 			  XDF_IGNORE_BLANK_LINES, PARSE_OPT_NONEG),
+		OPT_CALLBACK_F('I', NULL, options, N_("<regex>"),
+			       N_("ignore changes whose all lines match <regex>"),
+			       0, diff_opt_ignore_regex),
 		OPT_BIT(0, "indent-heuristic", &options->xdl_opts,
 			N_("heuristic to shift diff hunk boundaries for easy reading"),
 			XDF_INDENT_HEURISTIC),
diff --git a/diff.h b/diff.h
index 3de343270f..0b8871c0c1 100644
--- a/diff.h
+++ b/diff.h
@@ -234,6 +234,8 @@ struct diff_options {
 	 */
 	const char *pickaxe;
 
+	const char *ignore_regex;
+
 	const char *single_follow;
 	const char *a_prefix, *b_prefix;
 	const char *line_prefix;
diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index 032e3a9f41..db28055a5e 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -40,6 +40,7 @@ extern "C" {
 			      XDF_IGNORE_CR_AT_EOL)
 
 #define XDF_IGNORE_BLANK_LINES (1 << 7)
+#define XDF_IGNORE_REGEX (1 << 8)
 
 #define XDF_PATIENCE_DIFF (1 << 14)
 #define XDF_HISTOGRAM_DIFF (1 << 15)
@@ -78,6 +79,7 @@ typedef struct s_mmbuffer {
 
 typedef struct s_xpparam {
 	unsigned long flags;
+	const char *ignore_regex;
 
 	/* See Documentation/diff-options.txt. */
 	char **anchors;
diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index bd035139f9..13f7ab95ac 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -1019,6 +1019,39 @@ static void xdl_mark_ignorable(xdchange_t *xscr, xdfenv_t *xe, long flags)
 	}
 }
 
+static void
+xdl_mark_ignorable_regex(xdchange_t *xscr, const xdfenv_t *xe,
+			 const char *ignore_regex)
+{
+	xdchange_t *xch;
+	regex_t regex;
+
+	if (regcomp(&regex, ignore_regex, REG_EXTENDED | REG_NEWLINE))
+		die("invalid regex: %s", ignore_regex);
+
+	for (xch = xscr; xch; xch = xch->next) {
+		regmatch_t regmatch;
+		xrecord_t **rec;
+		int ignore = 1;
+		long i;
+
+		rec = &xe->xdf1.recs[xch->i1];
+		for (i = 0; i < xch->chg1 && ignore; i++)
+			ignore = !regexec_buf(&regex, rec[i]->ptr, rec[i]->size,
+					      1, &regmatch, 0);
+
+		rec = &xe->xdf2.recs[xch->i2];
+		for (i = 0; i < xch->chg2 && ignore; i++)
+			ignore = !regexec_buf(&regex, rec[i]->ptr, rec[i]->size,
+					      1, &regmatch, 0);
+
+		/*
+		 * Do not override --ignore-blank-lines.
+		 */
+		xch->ignore |= ignore;
+	}
+}
+
 int xdl_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 	     xdemitconf_t const *xecfg, xdemitcb_t *ecb) {
 	xdchange_t *xscr;
@@ -1040,6 +1073,9 @@ int xdl_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 		if (xpp->flags & XDF_IGNORE_BLANK_LINES)
 			xdl_mark_ignorable(xscr, &xe, xpp->flags);
 
+		if ((xpp->flags & XDF_IGNORE_REGEX) && xpp->ignore_regex)
+			xdl_mark_ignorable_regex(xscr, &xe, xpp->ignore_regex);
+
 		if (ef(&xe, xscr, ecb, xecfg) < 0) {
 
 			xdl_free_script(xscr);
-- 
2.28.0

