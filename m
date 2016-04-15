From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [RFC PATCH, WAS: "weird diff output?" 0/2] implement better chunk heuristics
Date: Fri, 15 Apr 2016 09:51:39 -0700
Message-ID: <20160415165141.4712-1-jacob.e.keller@intel.com>
Cc: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Jens Lehmann <Jens.Lehmann@web.de>,
	Davide Libenzi <davidel@xmailserver.org>,
	Jacob Keller <jacob.keller@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 18:52:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ar6yL-000425-Js
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 18:51:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751562AbcDOQvw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 12:51:52 -0400
Received: from mga02.intel.com ([134.134.136.20]:3095 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751294AbcDOQvv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 12:51:51 -0400
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP; 15 Apr 2016 09:51:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,488,1455004800"; 
   d="scan'208";a="946005187"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([134.134.3.173])
  by fmsmga001.fm.intel.com with ESMTP; 15 Apr 2016 09:51:50 -0700
X-Mailer: git-send-email 2.8.1.369.geae769a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291614>

From: Jacob Keller <jacob.keller@gmail.com>

I took up Stefan's patch, and modified it to resolve a couple issues. I
also tried to implement the suggestions from Junio's review, as well as
the suggestions I had. It appears to produce equivalent output as Jeff's
script. This version is still missing a few things, and it is possible
Stefan is working on a v2 of his own, but I thought I'd submit this.

There's still several TODOs:
* Add some tests
* better name for the heuristic(?)
* better patch description plus documentation
* is_emptyline should be more generic and handle CRLF

Changes since Stefan's v1:
* Added a patch to implement xdl_hash_and_recmatch as Junio suggested.
* Fixed a segfault in Stefan's patch
* Added XDL flag to configure the behavior
* Used an int and counted empty lines via += instead of |=
* Renamed starts_with_emptyline to is_emptyline
* Added diff command line and config options

For reviewer convenience, the interdiff between this and Stefan's version:

diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
index edba56522bce..cebf82702d2a 100644
--- a/Documentation/diff-config.txt
+++ b/Documentation/diff-config.txt
@@ -170,6 +170,12 @@ diff.tool::
 
 include::mergetools-diff.txt[]
 
+diff.emptyLineHeuristic::
+	Set this option to true to enable the empty line chunk heuristic when
+	producing diff output. This heuristic will attempt to shift hunks such
+	that a common empty line occurs below the hunk with the rest of the
+	context above it.
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
index 5f14beb98049..83984b90f82f 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -400,7 +400,7 @@ static xdchange_t *xdl_add_change(xdchange_t *xscr, long i1, long i2, long chg1,
 }
 
 
-static int starts_with_emptyline(const char *recs)
+static int is_emptyline(const char *recs)
 {
 	return recs[0] == '\n'; /* CRLF not covered here */
 }
@@ -416,7 +416,7 @@ static int xdl_hash_and_recmatch(xrecord_t **recs, long ixs, long ix, long flags
 int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 	long ix, ixo, ixs, ixref, grpsiz, nrec = xdf->nrec;
 	char *rchg = xdf->rchg, *rchgo = xdfo->rchg;
-	unsigned char has_emptyline;
+	unsigned int emptylines;
 	xrecord_t **recs = xdf->recs;
 
 	/*
@@ -450,7 +450,7 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 
 		do {
 			grpsiz = ix - ixs;
-			has_emptyline = 0;
+			emptylines = 0;
 
 			/*
 			 * If the line before the current change group, is equal to
@@ -458,11 +458,11 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 			 * the group.
 			 */
 			while (ixs > 0 && xdl_hash_and_recmatch(recs, ixs - 1, ix - 1, flags)) {
+				emptylines += is_emptyline(recs[ix - 1]->ptr);
+
 				rchg[--ixs] = 1;
 				rchg[--ix] = 0;
 
-				has_emptyline |=
-					starts_with_emptyline(recs[ix]->ptr);
 				/*
 				 * This change might have joined two change groups,
 				 * so we try to take this scenario in account by moving
@@ -492,9 +492,6 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 				rchg[ixs++] = 0;
 				rchg[ix++] = 1;
 
-				has_emptyline |=
-					starts_with_emptyline(recs[ix]->ptr);
-
 				/*
 				 * This change might have joined two change groups,
 				 * so we try to take this scenario in account by moving
@@ -527,21 +524,12 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 		 * As we shifted the group forward as far as possible, we only
 		 * need to shift it back if at all.
 		 */
-		if (has_emptyline) {
-			while (ixs > 0 && recs[ixs - 1]->ha == recs[ix - 1]->ha &&
-			       xdl_recmatch(recs[ixs - 1]->ptr, recs[ixs - 1]->size, recs[ix - 1]->ptr, recs[ix - 1]->size, flags) &&
-			       !starts_with_emptyline(recs[ix - 1]->ptr)) {
+		if ((flags & XDF_EMPTY_LINE_HEURISTIC) && emptylines) {
+			while (ixs > 0 &&
+			       !is_emptyline(recs[ix - 1]->ptr) &&
+			       xdl_hash_and_recmatch(recs, ixs - 1, ix - 1, flags)) {
 				rchg[--ixs] = 1;
 				rchg[--ix] = 0;
-
-				/*
-				 * This change did not join two change groups,
-				 * as we did that before already, so there is no
-				 * need to adapt the other-file, i.e.
-				 * running
-				 *     for (; rchg[ixs - 1]; ixs--);
-				 *     while (rchgo[--ixo]);
-				 */
 			}
 		}
 	}

Jacob Keller (1):
  xdiff: add xdl_hash_and_recmatch helper function

Stefan Beller (1):
  xdiff: implement empty line chunk heuristic

 Documentation/diff-config.txt  |  6 ++++++
 Documentation/diff-options.txt |  6 ++++++
 diff.c                         | 11 +++++++++++
 xdiff/xdiff.h                  |  2 ++
 xdiff/xdiffi.c                 | 42 ++++++++++++++++++++++++++++++++++++++----
 5 files changed, 63 insertions(+), 4 deletions(-)

-- 
2.8.1.369.geae769a
