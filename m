From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/2] xdiff: implement empty line chunk heuristic
Date: Fri, 15 Apr 2016 16:01:46 -0700
Message-ID: <1460761306-18794-3-git-send-email-sbeller@google.com>
References: <1460761306-18794-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
	Jens.Lehmann@web.de, davidel@xmailserver.org,
	Stefan Beller <sbeller@google.com>,
	Jacob Keller <jacob.e.keller@intel.com>
To: jacob.keller@gmail.com
X-From: git-owner@vger.kernel.org Sat Apr 16 01:01:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arCkO-0006DH-Ge
	for gcvg-git-2@plane.gmane.org; Sat, 16 Apr 2016 01:01:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751696AbcDOXBx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 19:01:53 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:36732 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751320AbcDOXBw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 19:01:52 -0400
Received: by mail-pa0-f53.google.com with SMTP id er2so30823040pad.3
        for <git@vger.kernel.org>; Fri, 15 Apr 2016 16:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hTdu+JJT8WAQXGTUsbSDQFOvuiRhwp2m699gYxLA3O4=;
        b=QiswaKxvEGnTumS9kqyOCEZpi7B8KeYfM7kOYB6ghld6RDCDu1E/sK9P4k7j4glFxx
         McXMjNcTSxmJ6HJ6zkb22cDGgijvcOR8v6vE8pMi1XKMy8bCttjtvv0/wMidSzcMA+Os
         g9r866m/lfERQqajYOqxG29VYpk5HSldmAuBjRQ6BCruXSCK6vP6rOKNI3SrGN1IudBr
         Tu4mmNv0iAGoQlBGrdDeFHRsNPedJULv6DHiIj3x2JDrGY2g0o1ZCUxMKRKBHOenHDbF
         wF48tPl9XxBPKs0VDQ1fRxg6xSvAcmBfbkWopfiKYwa/RbimzzPfJx7V9mIx2Dn1Rtdk
         gBGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hTdu+JJT8WAQXGTUsbSDQFOvuiRhwp2m699gYxLA3O4=;
        b=iN0mAHXQh2+m1QBsLNISVVRNKBgbeTnhMdfL0O/vjWiV9Df1KKnNV2Y73xNGNapC8C
         bXsevhWYJD7jXdddAJZw4GMu94gkXDtme+RbP66csLQPZSNMoeEYazv6swMz+If1fI0j
         ArsU/mRzIvacvusa8CXVwCXlAGxtFi4vR2FiOMcLwEAegDBW9q71vbFMm3j+QpIB+tGR
         PEJQulyt/TNAx4ITvqEz8HJCiVnjHMQ5I+EPApjyHB927MiGuYVD0jrbjUZpXR0iyFCv
         TegvmGtC0Nnq+XHbxKHJ4xa90bEA9WO+O9laS4BcyhEfkh+Ua5cwAwln47RHL7/JZ4f8
         W9XQ==
X-Gm-Message-State: AOPr4FXIm3lYHLoHFeZ4SfJpZozibaniUan1js3rjz5IVfUrG52NCLT4iNOuYPs7lAiyRAgW
X-Received: by 10.66.26.110 with SMTP id k14mr8133472pag.66.1460761311674;
        Fri, 15 Apr 2016 16:01:51 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:c97d:dddf:ab88:e90])
        by smtp.gmail.com with ESMTPSA id d2sm27019521pfd.80.2016.04.15.16.01.50
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 15 Apr 2016 16:01:50 -0700 (PDT)
X-Mailer: git-send-email 2.8.1.189.gd13d43c
In-Reply-To: <1460761306-18794-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291696>

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

Original discussion and testing found the following heuristic to be
producing the desired output:

  If there are diff chunks which can be shifted around, shift each hunk
  such that the last common empty line is below the chunk with the rest
  of the context above.

This heuristic appears to resolve the above example and several other
common issues without producing significantly weird results. When
implementing this heuristic the handling of empty lines was awkward as
it is unclear what an empty line is. ('\n' or do we include "\r\n" as it
is common on Windows?) Instead we implement a slightly different heuristic:

  If there are diff chunks which can be shifted around, find the shortest
  line in the overlapping parts. Use the line with the shortest length that
  occurs last as the last line of the chunk with the rest
  of the context above.

However, as with any heuristic it is not really known whether this will
always be more optimal. Thus, leave the heuristic disabled by default.

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
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/diff-config.txt  |  6 ++++++
 Documentation/diff-options.txt |  6 ++++++
 diff.c                         | 11 +++++++++++
 xdiff/xdiff.h                  |  2 ++
 xdiff/xdiffi.c                 | 29 +++++++++++++++++++++++++++++
 5 files changed, 54 insertions(+)

diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
index edba565..3d99a90 100644
--- a/Documentation/diff-config.txt
+++ b/Documentation/diff-config.txt
@@ -170,6 +170,12 @@ diff.tool::
 
 include::mergetools-diff.txt[]
 
+diff.shortestLineHeuristic::
+	Set this option to true to enable the shortest line chunk heuristic when
+	producing diff output. This heuristic will attempt to shift hunks such
+	that the last shortest common line occurs below the hunk with the rest of
+	the context above it.
+
 diff.algorithm::
 	Choose a diff algorithm.  The variants are as follows:
 +
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 4b0318e..b1ca83d 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -63,6 +63,12 @@ ifndef::git-format-patch[]
 	Synonym for `-p --raw`.
 endif::git-format-patch[]
 
+--shortest-line-heuristic::
+--no-shortest-line-heuristic::
+	When possible, shift common shortest line in diff hunks below the hunk
+	such that the last common shortest line for each hunk is below, with the
+	rest of the context above the hunk.
+
 --minimal::
 	Spend extra time to make sure the smallest possible
 	diff is produced.
diff --git a/diff.c b/diff.c
index 4dfe660..a02aff9 100644
--- a/diff.c
+++ b/diff.c
@@ -26,6 +26,7 @@
 #endif
 
 static int diff_detect_rename_default;
+static int diff_shortest_line_heuristic = 0;
 static int diff_rename_limit_default = 400;
 static int diff_suppress_blank_empty;
 static int diff_use_color_default = -1;
@@ -189,6 +190,10 @@ int git_diff_ui_config(const char *var, const char *value, void *cb)
 		diff_detect_rename_default = git_config_rename(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "diff.shortestlineheuristic")) {
+		diff_shortest_line_heuristic = git_config_bool(var, value);
+		return 0;
+	}
 	if (!strcmp(var, "diff.autorefreshindex")) {
 		diff_auto_refresh_index = git_config_bool(var, value);
 		return 0;
@@ -3278,6 +3283,8 @@ void diff_setup(struct diff_options *options)
 	options->use_color = diff_use_color_default;
 	options->detect_rename = diff_detect_rename_default;
 	options->xdl_opts |= diff_algorithm;
+	if (diff_shortest_line_heuristic)
+		DIFF_XDL_SET(options, SHORTEST_LINE_HEURISTIC);
 
 	options->orderfile = diff_order_file_cfg;
 
@@ -3798,6 +3805,10 @@ int diff_opt_parse(struct diff_options *options,
 		DIFF_XDL_SET(options, IGNORE_WHITESPACE_AT_EOL);
 	else if (!strcmp(arg, "--ignore-blank-lines"))
 		DIFF_XDL_SET(options, IGNORE_BLANK_LINES);
+	else if (!strcmp(arg, "--shortest-line-heuristic"))
+		DIFF_XDL_SET(options, SHORTEST_LINE_HEURISTIC);
+	else if (!strcmp(arg, "--no-shortest-line-heuristic"))
+		DIFF_XDL_CLR(options, SHORTEST_LINE_HEURISTIC);
 	else if (!strcmp(arg, "--patience"))
 		options->xdl_opts = DIFF_WITH_ALG(options, PATIENCE_DIFF);
 	else if (!strcmp(arg, "--histogram"))
diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index 4fb7e79..e1f8ec0 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -41,6 +41,8 @@ extern "C" {
 
 #define XDF_IGNORE_BLANK_LINES (1 << 7)
 
+#define XDF_SHORTEST_LINE_HEURISTIC (1 << 8)
+
 #define XDL_EMIT_FUNCNAMES (1 << 0)
 #define XDL_EMIT_FUNCCONTEXT (1 << 2)
 
diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 748eeb9..7d15b26 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -400,6 +400,12 @@ static xdchange_t *xdl_add_change(xdchange_t *xscr, long i1, long i2, long chg1,
 }
 
 
+static int line_length(const char *recs)
+{
+	char *s = strchr(recs, '\n');
+	return s ? s - recs : strlen(recs);
+}
+
 static int recs_match(xrecord_t **recs, long ixs, long ix, long flags)
 {
 	return (recs[ixs]->ha == recs[ix]->ha &&
@@ -411,6 +417,7 @@ static int recs_match(xrecord_t **recs, long ixs, long ix, long flags)
 int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 	long ix, ixo, ixs, ixref, grpsiz, nrec = xdf->nrec;
 	char *rchg = xdf->rchg, *rchgo = xdfo->rchg;
+	unsigned int shortest_line;
 	xrecord_t **recs = xdf->recs;
 
 	/*
@@ -444,6 +451,7 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 
 		do {
 			grpsiz = ix - ixs;
+			shortest_line = UINT_MAX;
 
 			/*
 			 * If the line before the current change group, is equal to
@@ -478,6 +486,10 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 			 * the group.
 			 */
 			while (ix < nrec && recs_match(recs, ixs, ix, flags)) {
+				int l = line_length(recs[ix]->ptr);
+				if (l < shortest_line)
+					shortest_line = l;
+
 				rchg[ixs++] = 0;
 				rchg[ix++] = 1;
 
@@ -504,6 +516,23 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
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
+		if ((flags & XDF_SHORTEST_LINE_HEURISTIC)) {
+			while (ixs > 0 &&
+			       line_length(recs[ix - 1]->ptr) > shortest_line &&
+			       recs_match(recs, ixs - 1, ix - 1, flags)) {
+				rchg[--ixs] = 1;
+				rchg[--ix] = 0;
+			}
+		}
 	}
 
 	return 0;
-- 
2.8.1.189.gd13d43c
