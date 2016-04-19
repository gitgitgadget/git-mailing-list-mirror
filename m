From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/2] xdiff: implement empty line chunk heuristic
Date: Tue, 19 Apr 2016 08:21:30 -0700
Message-ID: <1461079290-6523-3-git-send-email-sbeller@google.com>
References: <1461079290-6523-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>,
	Jacob Keller <jacob.e.keller@intel.com>
To: gitster@pobox.com, git@vger.kernel.org, jacob.keller@gmail.com,
	peff@peff.net
X-From: git-owner@vger.kernel.org Tue Apr 19 17:21:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asXTB-0005DR-6B
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 17:21:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932531AbcDSPVj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 11:21:39 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:34815 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932526AbcDSPVh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 11:21:37 -0400
Received: by mail-pf0-f174.google.com with SMTP id c20so7781598pfc.1
        for <git@vger.kernel.org>; Tue, 19 Apr 2016 08:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=E1T1rDgwe5U8GvP7QbUv7LsE1Z0uuG42Q7M/LFz/48I=;
        b=bMPe4uEFRhnyTqq4J/A/Pfu+ObKnv69/G/+yU5g+2wJ7EJLzjR75No2EUU9zbqHHg7
         R+DIx0zEHYv8Xos6Q0B25gCRa5bUsj2+HW753LZjTHaUrvsN/HiMPqwQsqBFhpmFXEru
         3elOu1L2tXJb6av6QkBPr7pyeDGD9yZ6rf6lewDBIr4Zg3W91j1QfPimH7eoRN4beGcM
         IStE4YtEF03OCFLx27Em3woscgZbOVxStygrYJFNCqIpt84iGl1PxIebpDdCIS0hwUHr
         WP1iaLRjWD6f28Ebxq/aKiGdWcq97hsz8LRnZ42Srp8Xbvfy3lA+txZMioVu735txOvH
         pKWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=E1T1rDgwe5U8GvP7QbUv7LsE1Z0uuG42Q7M/LFz/48I=;
        b=AClw4vdI0YKGVVuptZ0YYf5gz8dAetKXJbFy6wJorN034vkh4jSz2Tk+twJ8iaDgEQ
         3h9Wp8VoIq1T8vJgT4dyLgzYXbK07H9Cl4mCIb2uHCywL7uny6LeGE8CpImpoeBgwZPV
         s67kbH8KMqRREdDBjVEMxIXJKKMqj9PMdtOOFCGhn8R0uxQqabv06iQ1PsrEI9Er8LZi
         WBdLIlsPcwYJO47tChoQupdbHRVwt5JyTJiQPelSrSebfNS4ZxR4cw41dUory+fWNq6V
         HdlMGQv0hcHjqbMeSQJkJwUGVOSTjw714vW7CEW2RV8OxdHKCYUVSjVdcONyIVfDjBCP
         EmJQ==
X-Gm-Message-State: AOPr4FViWEujpvDiqhFsO/6JB7jGW4t+PkMxi7JCzK8NtI+x27IG4aU7ecHSxtrzGM0Xyg8T
X-Received: by 10.98.53.4 with SMTP id c4mr4799386pfa.65.1461079296249;
        Tue, 19 Apr 2016 08:21:36 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:7418:717f:4b27:128f])
        by smtp.gmail.com with ESMTPSA id r5sm15139750pfi.67.2016.04.19.08.21.35
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 19 Apr 2016 08:21:35 -0700 (PDT)
X-Mailer: git-send-email 2.4.11.2.g96ed4e5.dirty
In-Reply-To: <1461079290-6523-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291876>

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
index 6eaa452..9bf3e92 100644
--- a/Documentation/diff-config.txt
+++ b/Documentation/diff-config.txt
@@ -166,6 +166,11 @@ diff.tool::
 
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
index 3ad6404..b513023 100644
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
index f62b7f7..05ca3ce 100644
--- a/diff.c
+++ b/diff.c
@@ -25,6 +25,7 @@
 #endif
 
 static int diff_detect_rename_default;
+static int diff_compaction_heuristic = 1;
 static int diff_rename_limit_default = 400;
 static int diff_suppress_blank_empty;
 static int diff_use_color_default = -1;
@@ -181,6 +182,10 @@ int git_diff_ui_config(const char *var, const char *value, void *cb)
 	}
 	if (!strcmp(var, "diff.renames")) {
 		diff_detect_rename_default = git_config_rename(var, value);
+		return 0;
+	}
+	if (!strcmp(var, "diff.compactionheuristic")) {
+		diff_compaction_heuristic = git_config_bool(var, value);
 		return 0;
 	}
 	if (!strcmp(var, "diff.autorefreshindex")) {
@@ -3235,6 +3240,8 @@ void diff_setup(struct diff_options *options)
 	options->use_color = diff_use_color_default;
 	options->detect_rename = diff_detect_rename_default;
 	options->xdl_opts |= diff_algorithm;
+	if (diff_compaction_heuristic)
+		DIFF_XDL_SET(options, COMPACTION_HEURISTIC);
 
 	options->orderfile = diff_order_file_cfg;
 
@@ -3712,6 +3719,10 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
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
index c033991..d1dbb27 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -41,6 +41,8 @@ extern "C" {
 
 #define XDF_IGNORE_BLANK_LINES (1 << 7)
 
+#define XDF_COMPACTION_HEURISTIC (1 << 8)
+
 #define XDL_EMIT_FUNCNAMES (1 << 0)
 #define XDL_EMIT_COMMON (1 << 1)
 #define XDL_EMIT_FUNCCONTEXT (1 << 2)
diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 748eeb9..b3c6848 100644
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
 
@@ -503,6 +512,23 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 			rchg[--ixs] = 1;
 			rchg[--ix] = 0;
 			while (rchgo[--ixo]);
+		}
+
+		/*
+		 * If a group can be moved back and forth, see if there is a
+		 * blank line in the moving space. If there is a blank line,
+		 * make sure the last blank line is the end of the group.
+		 *
+		 * As we already shifted the group forward as far as possible
+		 * in the earlier loop, we need to shift it back only if at all.
+		 */
+		if ((flags & XDF_COMPACTION_HEURISTIC) && blank_lines) {
+			while (ixs > 0 &&
+			       !is_blank_line(recs, ix - 1, flags) &&
+			       recs_match(recs, ixs - 1, ix - 1, flags)) {
+				rchg[--ixs] = 1;
+				rchg[--ix] = 0;
+			}
 		}
 	}
 
-- 
2.4.11.2.g96ed4e5.dirty
