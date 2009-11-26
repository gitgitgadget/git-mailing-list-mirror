From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: [PATCH 1/8] git-merge-file --ours, --theirs
Date: Wed, 25 Nov 2009 21:23:53 -0500
Message-ID: <d243a513ffb8da4272f7a0e13a711f9b65195c25.1259201377.git.apenwarr@gmail.com>
References: <cover.1259201377.git.apenwarr@gmail.com>
Cc: <gitster@pobox.com>, "Avery Pennarun" <apenwarr@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 26 03:42:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDUJq-0004jY-US
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 03:42:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755001AbZKZCmo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 21:42:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754795AbZKZCmk
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 21:42:40 -0500
Received: from mailhost.pwcorp.com ([216.13.111.70]:4746 "EHLO
	mailhost.pwcorp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754005AbZKZCme (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 21:42:34 -0500
X-Greylist: delayed 912 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Nov 2009 21:42:31 EST
X-Brightmail-Tracker: AAAAAgAAA+sAAAPp
thread-index: AcpuP9zhV3tj9LGuRk2FcenZiiEytg==
X-Language-Identified: TRUE
Received: from weaver.open.versabanq.com ([10.65.1.2]) by mailhost.pwcorp.com with Microsoft SMTPSVC(6.0.3790.3959); Wed, 25 Nov 2009 21:26:20 -0500
Content-Class: urn:content-classes:message
Importance: normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.4325
Received: (qmail 5457 invoked from network); 26 Nov 2009 02:25:35 -0000
Received: from unknown (HELO harmony.mtl.versabanq.com) (10.65.1.133)  by weaver.open.versabanq.com with SMTP; 26 Nov 2009 02:25:35 -0000
Received: by harmony.mtl.versabanq.com (sSMTP sendmail emulation); Wed, 25 Nov 2009 21:24:10 -0500
X-Mailer: git-send-email 1.6.6.rc0.62.gaccf
In-Reply-To: <cover.1259201377.git.apenwarr@gmail.com>
In-Reply-To: <cover.1259201377.git.apenwarr@gmail.com>
References: <cover.1259201377.git.apenwarr@gmail.com>
X-OriginalArrivalTime: 26 Nov 2009 02:26:20.0277 (UTC) FILETIME=[D702F250:01CA6E3F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133755>

Often people want their conflicting merges autoresolved by favouring
upstream changes (or their own --- it's the same thing), and hinted to run
"git diff --name-only | xargs git checkout MERGE_HEAD --".  This is
essentially to accept automerge results for the paths that are fully
resolved automatically while taking their version of the file in full for
paths that have conflicts.

This is problematic on two counts.

One problem is that this is not exactly what these people want.  They
usually want to salvage as much automerge result as possible.  In
particular, they want to keep autoresolved parts in conflicting paths, as
well as the paths that are fully autoresolved.

This patch teaches two new modes of operation to the lowest-lever merge
machinery, xdl_merge().  Instead of leaving the conflicted lines from both
sides enclosed in <<<, ===, and >>> markers, you can tell the conflicts to
be resolved favouring your side or their side of changes.

A larger problem is that this tends to encourage a bad workflow by
allowing them to record such a mixed up half-merge result as a full commit
without auditing.  This commit does not tackle this latter issue.  In git,
we usually give long enough rope to users with strange wishes as long as
the risky features is not on by default.

(Patch originally by Junio Hamano <gitster@pobox.com>.)

Signed-off-by: Avery Pennarun <apenwarr@gmail.com>
---
 Documentation/git-merge-file.txt |   12 ++++++++++--
 builtin-merge-file.c             |    5 ++++-
 xdiff/xdiff.h                    |    7 ++++++-
 xdiff/xmerge.c                   |   11 +++++++++--
 4 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-merge-file.txt b/Documentation/git-merge-file.txt
index 3035373..b9d2276 100644
--- a/Documentation/git-merge-file.txt
+++ b/Documentation/git-merge-file.txt
@@ -10,7 +10,8 @@ SYNOPSIS
 --------
 [verse]
 'git merge-file' [-L <current-name> [-L <base-name> [-L <other-name>]]]
-	[-p|--stdout] [-q|--quiet] <current-file> <base-file> <other-file>
+	[--ours|--theirs] [-p|--stdout] [-q|--quiet]
+	<current-file> <base-file> <other-file>
 
 
 DESCRIPTION
@@ -34,7 +35,9 @@ normally outputs a warning and brackets the conflict with lines containing
 	>>>>>>> B
 
 If there are conflicts, the user should edit the result and delete one of
-the alternatives.
+the alternatives.  When `--ours` or `--theirs` option is in effect, however,
+these conflicts are resolved favouring lines from `<current-file>` or
+lines from `<other-file>` respectively.
 
 The exit value of this program is negative on error, and the number of
 conflicts otherwise. If the merge was clean, the exit value is 0.
@@ -62,6 +65,11 @@ OPTIONS
 -q::
 	Quiet; do not warn about conflicts.
 
+--ours::
+--theirs::
+	Instead of leaving conflicts in the file, resolve conflicts
+	favouring our (or their) side of the lines.
+
 
 EXAMPLES
 --------
diff --git a/builtin-merge-file.c b/builtin-merge-file.c
index afd2ea7..8f22aa8 100644
--- a/builtin-merge-file.c
+++ b/builtin-merge-file.c
@@ -29,11 +29,14 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
 	int ret = 0, i = 0, to_stdout = 0;
 	int merge_level = XDL_MERGE_ZEALOUS_ALNUM;
 	int merge_style = 0, quiet = 0;
+	int merge_favor = 0;
 	int nongit;
 
 	struct option options[] = {
 		OPT_BOOLEAN('p', "stdout", &to_stdout, "send results to standard output"),
 		OPT_SET_INT(0, "diff3", &merge_style, "use a diff3 based merge", XDL_MERGE_DIFF3),
+		OPT_SET_INT(0, "ours", &merge_favor, "for conflicts, use our version", XDL_MERGE_FAVOR_OURS),
+		OPT_SET_INT(0, "theirs", &merge_favor, "for conflicts, use their version", XDL_MERGE_FAVOR_THEIRS),
 		OPT__QUIET(&quiet),
 		OPT_CALLBACK('L', NULL, names, "name",
 			     "set labels for file1/orig_file/file2", &label_cb),
@@ -68,7 +71,7 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
 	}
 
 	ret = xdl_merge(mmfs + 1, mmfs + 0, names[0], mmfs + 2, names[2],
-			&xpp, merge_level | merge_style, &result);
+			&xpp, merge_level | merge_style | merge_favor, &result);
 
 	for (i = 0; i < 3; i++)
 		free(mmfs[i].ptr);
diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index 4da052a..2cce49d 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -58,6 +58,11 @@ extern "C" {
 #define XDL_MERGE_ZEALOUS_ALNUM 3
 #define XDL_MERGE_LEVEL_MASK 0x0f
 
+/* merge favor modes */
+#define XDL_MERGE_FAVOR_OURS 0x0010
+#define XDL_MERGE_FAVOR_THEIRS 0x0020
+#define XDL_MERGE_FAVOR(flags) (((flags)>>4) & 3)
+
 /* merge output styles */
 #define XDL_MERGE_DIFF3 0x8000
 #define XDL_MERGE_STYLE_MASK 0x8000
@@ -110,7 +115,7 @@ int xdl_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 
 int xdl_merge(mmfile_t *orig, mmfile_t *mf1, const char *name1,
 		mmfile_t *mf2, const char *name2,
-		xpparam_t const *xpp, int level, mmbuffer_t *result);
+		xpparam_t const *xpp, int flags, mmbuffer_t *result);
 
 #ifdef __cplusplus
 }
diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
index 1cb65a9..2325f6d 100644
--- a/xdiff/xmerge.c
+++ b/xdiff/xmerge.c
@@ -214,11 +214,15 @@ static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
 
 static int xdl_fill_merge_buffer(xdfenv_t *xe1, const char *name1,
 				 xdfenv_t *xe2, const char *name2,
+				 int favor,
 				 xdmerge_t *m, char *dest, int style)
 {
 	int size, i;
 
 	for (size = i = 0; m; m = m->next) {
+		if (favor && !m->mode)
+                	m->mode = favor;
+		
 		if (m->mode == 0)
 			size = fill_conflict_hunk(xe1, name1, xe2, name2,
 						  size, i, style, m, dest);
@@ -391,6 +395,7 @@ static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1, const char *name1,
 	int i0, i1, i2, chg0, chg1, chg2;
 	int level = flags & XDL_MERGE_LEVEL_MASK;
 	int style = flags & XDL_MERGE_STYLE_MASK;
+	int favor = XDL_MERGE_FAVOR(flags);
 
 	if (style == XDL_MERGE_DIFF3) {
 		/*
@@ -523,14 +528,14 @@ static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1, const char *name1,
 	/* output */
 	if (result) {
 		int size = xdl_fill_merge_buffer(xe1, name1, xe2, name2,
-			changes, NULL, style);
+			favor, changes, NULL, style);
 		result->ptr = xdl_malloc(size);
 		if (!result->ptr) {
 			xdl_cleanup_merge(changes);
 			return -1;
 		}
 		result->size = size;
-		xdl_fill_merge_buffer(xe1, name1, xe2, name2, changes,
+		xdl_fill_merge_buffer(xe1, name1, xe2, name2, favor, changes,
 				      result->ptr, style);
 	}
 	return xdl_cleanup_merge(changes);
@@ -542,6 +547,8 @@ int xdl_merge(mmfile_t *orig, mmfile_t *mf1, const char *name1,
 	xdchange_t *xscr1, *xscr2;
 	xdfenv_t xe1, xe2;
 	int status;
+	int level = flags & XDL_MERGE_LEVEL_MASK;
+	int favor = XDL_MERGE_FAVOR(flags);
 
 	result->ptr = NULL;
 	result->size = 0;
-- 
1.6.6.rc0.62.gaccf
