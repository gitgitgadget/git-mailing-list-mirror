From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/2] xdiff: implement empty line chunk heuristic
Date: Mon, 18 Apr 2016 14:12:30 -0700
Message-ID: <1461013950-12503-3-git-send-email-sbeller@google.com>
References: <1461013950-12503-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, jacob.keller@gmail.com,
	Stefan Beller <sbeller@google.com>,
	Jacob Keller <jacob.e.keller@intel.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Apr 18 23:13:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asGTb-0001ds-Dm
	for gcvg-git-2@plane.gmane.org; Mon, 18 Apr 2016 23:12:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751712AbcDRVMp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Apr 2016 17:12:45 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:33473 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752036AbcDRVMl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2016 17:12:41 -0400
Received: by mail-pf0-f176.google.com with SMTP id 184so84934167pff.0
        for <git@vger.kernel.org>; Mon, 18 Apr 2016 14:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XbUgUcU9R4cAWP9zfiPRCZq5Asb5xIpUXAnNVgiwbQU=;
        b=BqsxlRO/iTESY6RyXbw6GKgSV7Sv7CdK2cC9R80F1dv/++u2rlDauP29a+mA0LMO/N
         dFwQhmzrkiZv8BdAcfwL9cNZFhdo6GWhtwcWDiSS7NhtM3HmhudkLf2VEwXOvbM/VNZh
         G0H0WXF9WNqYFJWW+8fGQFiHq+LoFPNLSSRCvzPUFuPovSQpcvPo6JRkrUSD5N8rm0Af
         mrTvDwsrz7HjRAx3ZqLc38KdEDg0U7CtjyVa1qgQyV/msh6mojw1DY6CsBuD7NSbmhhL
         l90bETRAzkkNxB1kPA+MSzQnJ3fUEoS333Td29MqFFw3T4jjm+p/8dmKFvy/WR3oWKfE
         wORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XbUgUcU9R4cAWP9zfiPRCZq5Asb5xIpUXAnNVgiwbQU=;
        b=Ai5+jvZ5pU7wj/4XFShAywpWm0AvbaUa3ACPD3vOXiMgAW9iiFmpvW0dP9BV8I0i8W
         EJwx4ZlWo48Z3wo4ZHNzD6XbMwli1QsCcw54Hu1hBVwg+00NBfWXUJpanP+g4bhB0ESE
         8m2Jy0+B152B463MtTo0Ce9p5EU2n9ZeGaF0d2xtdnITbr1/Fwgf5mL0CjTnqRzi1/qZ
         2IJWj1uxCW7bb364W0GSY/kzZVyidCl3VAJ+VbMi3QAXyfDl8pJd3X4dOxR8F/WrF3u+
         NCDcrnaI/ZvVJJ56GhTL7HwAfui3pxnLBwQ4bPzhA8xzl6E3ogxzae3eGFV4Bk0HBOGx
         8QNA==
X-Gm-Message-State: AOPr4FWS0EnM3CWGplHByLNG7CdzM1K8oaRaFe933+eNZdsj2CE2DeoyJmxKrXFh9yOw2vMI
X-Received: by 10.98.71.156 with SMTP id p28mr52314057pfi.139.1461013960897;
        Mon, 18 Apr 2016 14:12:40 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:6869:43f:e72f:2f19])
        by smtp.gmail.com with ESMTPSA id xs10sm86017733pab.4.2016.04.18.14.12.39
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 18 Apr 2016 14:12:40 -0700 (PDT)
X-Mailer: git-send-email 2.8.1.212.gdf84f39
In-Reply-To: <1461013950-12503-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291828>

In order to produce the smallest possible diff and combine several diff
hunks together, we implement a heuristic from GNU Diff which moves diff
hunks forward as far as possible when we find common context above and
below a diff hunk. This sometimes produces less readable diffs when
writing C, Shell, or other programming languages, ie:

...
 /*
+ *
+ *
+ */
+
+/*
...

instead of the more readable equivalent of

...
+/*
+ *
+ *
+ */
+
 /*
...

Implement the following heuristic to (optionally) produce the desired
output.

  If there are diff chunks which can be shifted around, shift each hunk
  such that the last common empty line is below the chunk with the rest
  of the context above.

This heuristic appears to resolve the above example and several other
common issues without producing significantly weird results. However, as
with any heuristic it is not really known whether this will always be
more optimal. Thus, it can be disabled via diff.compactionHeuristic.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/diff-config.txt  |  5 +++++
 Documentation/diff-options.txt |  6 ++++++
 diff.c                         | 11 +++++++++++
 xdiff/xdiff.h                  |  2 ++
 xdiff/xdiffi.c                 | 26 ++++++++++++++++++++++++++
 5 files changed, 50 insertions(+)

diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
index edba565..a9f4b57 100644
--- a/Documentation/diff-config.txt
+++ b/Documentation/diff-config.txt
@@ -170,6 +170,11 @@ diff.tool::
 
 include::mergetools-diff.txt[]
 
+diff.compactionHeuristic::
+	Set this option to enable an experimental heuristic that
+	shifts the hunk boundary in an attempt to make the resulting
+	patch easier to read.
+
 diff.algorithm::
 	Choose a diff algorithm.  The variants are as follows:
 +
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 4b0318e..0993742 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -63,6 +63,12 @@ ifndef::git-format-patch[]
 	Synonym for `-p --raw`.
 endif::git-format-patch[]
 
+--compaction-heuristic::
+--no-compaction-heuristic::
+	These are to help debugging and tuning an experimental
+	heuristic that shifts the hunk boundary in an attempt to
+	make the resulting patch easier to read.
+
 --minimal::
 	Spend extra time to make sure the smallest possible
 	diff is produced.
diff --git a/diff.c b/diff.c
index 4dfe660..d3734d3 100644
--- a/diff.c
+++ b/diff.c
@@ -26,6 +26,7 @@
 #endif
 
 static int diff_detect_rename_default;
+static int diff_compaction_heuristic = 1;
 static int diff_rename_limit_default = 400;
 static int diff_suppress_blank_empty;
 static int diff_use_color_default = -1;
@@ -189,6 +190,10 @@ int git_diff_ui_config(const char *var, const char *value, void *cb)
 		diff_detect_rename_default = git_config_rename(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "diff.compactionheuristic")) {
+		diff_compaction_heuristic = git_config_bool(var, value);
+		return 0;
+	}
 	if (!strcmp(var, "diff.autorefreshindex")) {
 		diff_auto_refresh_index = git_config_bool(var, value);
 		return 0;
@@ -3278,6 +3283,8 @@ void diff_setup(struct diff_options *options)
 	options->use_color = diff_use_color_default;
 	options->detect_rename = diff_detect_rename_default;
 	options->xdl_opts |= diff_algorithm;
+	if (diff_compaction_heuristic)
+		DIFF_XDL_SET(options, COMPACTION_HEURISTIC);
 
 	options->orderfile = diff_order_file_cfg;
 
@@ -3798,6 +3805,10 @@ int diff_opt_parse(struct diff_options *options,
 		DIFF_XDL_SET(options, IGNORE_WHITESPACE_AT_EOL);
 	else if (!strcmp(arg, "--ignore-blank-lines"))
 		DIFF_XDL_SET(options, IGNORE_BLANK_LINES);
+	else if (!strcmp(arg, "--compaction-heuristic"))
+		DIFF_XDL_SET(options, COMPACTION_HEURISTIC);
+	else if (!strcmp(arg, "--no-compaction-heuristic"))
+		DIFF_XDL_CLR(options, COMPACTION_HEURISTIC);
 	else if (!strcmp(arg, "--patience"))
 		options->xdl_opts = DIFF_WITH_ALG(options, PATIENCE_DIFF);
 	else if (!strcmp(arg, "--histogram"))
diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index 4fb7e79..7423f77 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -41,6 +41,8 @@ extern "C" {
 
 #define XDF_IGNORE_BLANK_LINES (1 << 7)
 
+#define XDF_COMPACTION_HEURISTIC (1 << 8)
+
 #define XDL_EMIT_FUNCNAMES (1 << 0)
 #define XDL_EMIT_FUNCCONTEXT (1 << 2)
 
diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 748eeb9..5a02b15 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -400,6 +400,11 @@ static xdchange_t *xdl_add_change(xdchange_t *xscr, long i1, long i2, long chg1,
 }
 
 
+static int is_blank_line(xrecord_t **recs, long ix, long flags)
+{
+	return xdl_blankline(recs[ix]->ptr, recs[ix]->size, flags);
+}
+
 static int recs_match(xrecord_t **recs, long ixs, long ix, long flags)
 {
 	return (recs[ixs]->ha == recs[ix]->ha &&
@@ -411,6 +416,7 @@ static int recs_match(xrecord_t **recs, long ixs, long ix, long flags)
 int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 	long ix, ixo, ixs, ixref, grpsiz, nrec = xdf->nrec;
 	char *rchg = xdf->rchg, *rchgo = xdfo->rchg;
+	unsigned int blank_lines;
 	xrecord_t **recs = xdf->recs;
 
 	/*
@@ -444,6 +450,7 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 
 		do {
 			grpsiz = ix - ixs;
+			blank_lines = 0;
 
 			/*
 			 * If the line before the current change group, is equal to
@@ -478,6 +485,8 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 			 * the group.
 			 */
 			while (ix < nrec && recs_match(recs, ixs, ix, flags)) {
+				blank_lines += is_blank_line(recs, ix, flags);
+
 				rchg[ixs++] = 0;
 				rchg[ix++] = 1;
 
@@ -504,6 +513,23 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 			rchg[--ix] = 0;
 			while (rchgo[--ixo]);
 		}
+
+		/*
+		 * If a group can be moved back and forth, see if there is an
+		 * blank line in the moving space. If there is a blank line,
+		 * make sure the last blank line is the end of the group.
+		 *
+		 * As we shifted the group forward as far as possible, we only
+		 * need to shift it back if at all.
+		 */
+		if ((flags & XDF_COMPACTION_HEURISTIC) && blank_lines) {
+			while (ixs > 0 &&
+			       !is_blank_line(recs, ix - 1, flags) &&
+			       recs_match(recs, ixs - 1, ix - 1, flags)) {
+				rchg[--ixs] = 1;
+				rchg[--ix] = 0;
+			}
+		}
 	}
 
 	return 0;
-- 
2.8.0.26.gba39a1b.dirty
