From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [RFC PATCH, WAS: "weird diff output?" v3 2/2] xdiff: implement empty line chunk heuristic
Date: Fri, 15 Apr 2016 15:57:18 -0700
Message-ID: <20160415225718.13610-3-jacob.e.keller@intel.com>
References: <20160415225718.13610-1-jacob.e.keller@intel.com>
Cc: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Jens Lehmann <Jens.Lehmann@web.de>,
	Davide Libenzi <davidel@xmailserver.org>,
	Jacob Keller <jacob.e.keller@intel.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 00:57:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arCg4-0003f7-Lx
	for gcvg-git-2@plane.gmane.org; Sat, 16 Apr 2016 00:57:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751273AbcDOW5Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 18:57:24 -0400
Received: from mga01.intel.com ([192.55.52.88]:55313 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750982AbcDOW5W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 18:57:22 -0400
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP; 15 Apr 2016 15:57:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,489,1455004800"; 
   d="scan'208";a="946203961"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([134.134.3.173])
  by fmsmga001.fm.intel.com with ESMTP; 15 Apr 2016 15:57:21 -0700
X-Mailer: git-send-email 2.8.1.369.geae769a
In-Reply-To: <20160415225718.13610-1-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291693>

From: Stefan Beller <sbeller@google.com>

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
more optimal. Thus, leave the heuristic disabled by default.

Add an XDIFF flag to enable this heuristic only conditionally. Add
a diff command line option and diff configuration option to allow users
to enable this option when desired.

TODO:
* Add tests
* Add better/more documentation explaining the heuristic, possibly with
  examples(?)
* better name(?)

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 Documentation/diff-config.txt  |  6 ++++++
 Documentation/diff-options.txt |  6 ++++++
 diff.c                         | 11 +++++++++++
 xdiff/xdiff.h                  |  2 ++
 xdiff/xdiffi.c                 | 26 ++++++++++++++++++++++++++
 5 files changed, 51 insertions(+)

diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
index edba56522bce..9265d60d9571 100644
--- a/Documentation/diff-config.txt
+++ b/Documentation/diff-config.txt
@@ -170,6 +170,12 @@ diff.tool::
 
 include::mergetools-diff.txt[]
 
+diff.emptyLineHeuristic::
+	Set this option to true to enable the empty line chunk heuristic when
+	producing diff output. This heuristic will attempt to shift hunks such
+	that the last common empty line occurs below the hunk with the rest of
+	the context above it.
+
 diff.algorithm::
 	Choose a diff algorithm.  The variants are as follows:
 +
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 4b0318e2ac15..6c1cd8b35584 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -63,6 +63,12 @@ ifndef::git-format-patch[]
 	Synonym for `-p --raw`.
 endif::git-format-patch[]
 
+--empty-line-heuristic::
+--no-empty-line-heuristic::
+	When possible, shift common empty lines in diff hunks below the hunk
+	such that the last common empty line for each hunk is below, with the
+	rest of the context above the hunk.
+
 --minimal::
 	Spend extra time to make sure the smallest possible
 	diff is produced.
diff --git a/diff.c b/diff.c
index 4dfe6609d059..8ab9a492928d 100644
--- a/diff.c
+++ b/diff.c
@@ -26,6 +26,7 @@
 #endif
 
 static int diff_detect_rename_default;
+static int diff_empty_line_heuristic = 0;
 static int diff_rename_limit_default = 400;
 static int diff_suppress_blank_empty;
 static int diff_use_color_default = -1;
@@ -189,6 +190,10 @@ int git_diff_ui_config(const char *var, const char *value, void *cb)
 		diff_detect_rename_default = git_config_rename(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "diff.emptylineheuristic")) {
+		diff_empty_line_heuristic = git_config_bool(var, value);
+		return 0;
+	}
 	if (!strcmp(var, "diff.autorefreshindex")) {
 		diff_auto_refresh_index = git_config_bool(var, value);
 		return 0;
@@ -3278,6 +3283,8 @@ void diff_setup(struct diff_options *options)
 	options->use_color = diff_use_color_default;
 	options->detect_rename = diff_detect_rename_default;
 	options->xdl_opts |= diff_algorithm;
+	if (diff_empty_line_heuristic)
+		DIFF_XDL_SET(options, EMPTY_LINE_HEURISTIC);
 
 	options->orderfile = diff_order_file_cfg;
 
@@ -3798,6 +3805,10 @@ int diff_opt_parse(struct diff_options *options,
 		DIFF_XDL_SET(options, IGNORE_WHITESPACE_AT_EOL);
 	else if (!strcmp(arg, "--ignore-blank-lines"))
 		DIFF_XDL_SET(options, IGNORE_BLANK_LINES);
+	else if (!strcmp(arg, "--empty-line-heuristic"))
+		DIFF_XDL_SET(options, EMPTY_LINE_HEURISTIC);
+	else if (!strcmp(arg, "--no-empty-line-heuristic"))
+		DIFF_XDL_CLR(options, EMPTY_LINE_HEURISTIC);
 	else if (!strcmp(arg, "--patience"))
 		options->xdl_opts = DIFF_WITH_ALG(options, PATIENCE_DIFF);
 	else if (!strcmp(arg, "--histogram"))
diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index 4fb7e79410c2..9195a5c0e958 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -41,6 +41,8 @@ extern "C" {
 
 #define XDF_IGNORE_BLANK_LINES (1 << 7)
 
+#define XDF_EMPTY_LINE_HEURISTIC (1 << 8)
+
 #define XDL_EMIT_FUNCNAMES (1 << 0)
 #define XDL_EMIT_FUNCCONTEXT (1 << 2)
 
diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index b56c1e24593c..dd93e6781e8b 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -400,6 +400,11 @@ static xdchange_t *xdl_add_change(xdchange_t *xscr, long i1, long i2, long chg1,
 }
 
 
+static int is_emptyline(const char *recs)
+{
+	return recs[0] == '\n'; /* CRLF not covered here */
+}
+
 static int recs_match(xrecord_t **recs, long ixs, long ix, long flags)
 {
 	return (recs[ixs]->ha == recs[ix]->ha &&
@@ -411,6 +416,7 @@ static int recs_match(xrecord_t **recs, long ixs, long ix, long flags)
 int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 	long ix, ixo, ixs, ixref, grpsiz, nrec = xdf->nrec;
 	char *rchg = xdf->rchg, *rchgo = xdfo->rchg;
+	unsigned int emptylines;
 	xrecord_t **recs = xdf->recs;
 
 	/*
@@ -444,6 +450,7 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 
 		do {
 			grpsiz = ix - ixs;
+			emptylines = 0;
 
 			/*
 			 * If the line before the current change group, is equal to
@@ -479,6 +486,8 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 			 */
 			while (ix < nrec && recs_match(recs, ixs, ix, flags)) {
 
+				emptylines += is_emptyline(recs[ix]->ptr);
+
 				rchg[ixs++] = 0;
 				rchg[ix++] = 1;
 
@@ -505,6 +514,23 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 			rchg[--ix] = 0;
 			while (rchgo[--ixo]);
 		}
+
+		/*
+		 * If a group can be moved back and forth, see if there is an
+		 * empty line in the moving space. If there is an empty line,
+		 * make sure the last empty line is the end of the group.
+		 *
+		 * As we shifted the group forward as far as possible, we only
+		 * need to shift it back if at all.
+		 */
+		if ((flags & XDF_EMPTY_LINE_HEURISTIC) && emptylines) {
+			while (ixs > 0 &&
+			       !is_emptyline(recs[ix - 1]->ptr) &&
+			       recs_match(recs, ixs - 1, ix - 1, flags)) {
+				rchg[--ixs] = 1;
+				rchg[--ix] = 0;
+			}
+		}
 	}
 
 	return 0;
-- 
2.8.1.369.geae769a
