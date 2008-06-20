From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] git-merge-file --ours, --theirs
Date: Fri, 20 Jun 2008 00:38:22 -0700
Message-ID: <7vfxr8o8sx.fsf_-_@gitster.siamese.dyndns.org>
References: <93c3eada0806152116v2cef4035u272dc1a26005661a@mail.gmail.com>
 <20080616092554.GB29404@genesis.frugalware.org>
 <48563D6C.8060704@viscovery.net>
 <bd6139dc0806161521p3667a44ble8573be1569986a0@mail.gmail.com>
 <93c3eada0806161545m5c6e1073q5522ce31f72be9f0@mail.gmail.com>
 <7vve076d6t.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0806181618070.6439@racer>
 <alpine.DEB.1.00.0806181627260.6439@racer>
 <7viqw6zovi.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: geoffrey.russell@gmail.com, sverre@rabbelier.nl,
	Johannes Sixt <j.sixt@viscovery.net>,
	Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 20 09:39:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9bDX-0002MI-TG
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 09:39:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251AbYFTHij (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2008 03:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbYFTHii
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jun 2008 03:38:38 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63745 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751163AbYFTHih (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2008 03:38:37 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id DBFF21E748;
	Fri, 20 Jun 2008 03:38:34 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 7F5511E747; Fri, 20 Jun 2008 03:38:24 -0400 (EDT)
In-Reply-To: <7viqw6zovi.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 18 Jun 2008 09:31:13 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E3839BDA-3E9B-11DD-A7BF-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85601>

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

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Essentially the same patch but with documentation.

 Documentation/git-merge-file.txt |   12 ++++++++++--
 builtin-merge-file.c             |   10 ++++++++--
 xdiff/xdiff.h                    |    8 +++++++-
 xdiff/xmerge.c                   |   24 ++++++++++++++++--------
 4 files changed, 41 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-merge-file.txt b/Documentation/git-merge-file.txt
index 149f131..87e07d3 100644
--- a/Documentation/git-merge-file.txt
+++ b/Documentation/git-merge-file.txt
@@ -10,7 +10,8 @@ SYNOPSIS
 --------
 [verse]
 'git-merge-file' [-L <current-name> [-L <base-name> [-L <other-name>]]]
-	[-p|--stdout] [-q|--quiet] <current-file> <base-file> <other-file>
+	[--ours|--theirs] [-p|--stdout] [-q|--quiet]
+	<current-file> <base-file> <other-file>
 
 
 DESCRIPTION
@@ -34,7 +35,9 @@ normally outputs a warning and brackets the conflict with <<<<<<< and
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
 	Quiet;  do  not  warn about conflicts.
 
+--ours::
+--theirs::
+	Instead of leaving conflicts in the file, resolve conflicts
+	favouring our (or their) side of the lines.
+
 
 EXAMPLES
 --------
diff --git a/builtin-merge-file.c b/builtin-merge-file.c
index 3605960..7d4ca8c 100644
--- a/builtin-merge-file.c
+++ b/builtin-merge-file.c
@@ -4,7 +4,7 @@
 #include "xdiff-interface.h"
 
 static const char merge_file_usage[] =
-"git merge-file [-p | --stdout] [-q | --quiet] [-L name1 [-L orig [-L name2]]] file1 orig_file file2";
+"git merge-file [-p | --stdout] [-q | --quiet] [--ours|--theirs] [-L name1 [-L orig [-L name2]]] file1 orig_file file2";
 
 int cmd_merge_file(int argc, const char **argv, const char *prefix)
 {
@@ -13,6 +13,7 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
 	mmbuffer_t result = {NULL, 0};
 	xpparam_t xpp = {XDF_NEED_MINIMAL};
 	int ret = 0, i = 0, to_stdout = 0;
+	int flags, favor = 0;
 
 	while (argc > 4) {
 		if (!strcmp(argv[1], "-L") && i < 3) {
@@ -25,6 +26,10 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
 		else if (!strcmp(argv[1], "-q") ||
 				!strcmp(argv[1], "--quiet"))
 			freopen("/dev/null", "w", stderr);
+		else if (!strcmp(argv[1], "--ours"))
+			favor = XDL_MERGE_FAVOR_OURS;
+		else if (!strcmp(argv[1], "--theirs"))
+			favor = XDL_MERGE_FAVOR_THEIRS;
 		else
 			usage(merge_file_usage);
 		argc--;
@@ -45,8 +50,9 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
 					argv[i + 1]);
 	}
 
+	flags = XDL_MERGE_FLAGS(XDL_MERGE_ZEALOUS_ALNUM, favor);
 	ret = xdl_merge(mmfs + 1, mmfs + 0, names[0], mmfs + 2, names[2],
-			&xpp, XDL_MERGE_ZEALOUS_ALNUM, &result);
+			&xpp, flags, &result);
 
 	for (i = 0; i < 3; i++)
 		free(mmfs[i].ptr);
diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index 413082e..d40cf21 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -99,9 +99,15 @@ long xdl_mmfile_size(mmfile_t *mmf);
 int xdl_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 	     xdemitconf_t const *xecfg, xdemitcb_t *ecb);
 
+#define XDL_MERGE_FAVOR_OURS		1
+#define XDL_MERGE_FAVOR_THEIRS		2
+#define XDL_MERGE_FAVOR(flag)		(((flag)>>4) & 03)
+#define XDL_MERGE_LEVEL(flag)		((flag) & 07)
+#define XDL_MERGE_FLAGS(level,flag)	((level) | ((flag)<<4))
+
 int xdl_merge(mmfile_t *orig, mmfile_t *mf1, const char *name1,
 		mmfile_t *mf2, const char *name2,
-		xpparam_t const *xpp, int level, mmbuffer_t *result);
+		xpparam_t const *xpp, int flag, mmbuffer_t *result);
 
 #ifdef __cplusplus
 }
diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
index 82b3573..88c29ae 100644
--- a/xdiff/xmerge.c
+++ b/xdiff/xmerge.c
@@ -114,7 +114,9 @@ static int xdl_recs_copy(xdfenv_t *xe, int i, int count, int add_nl, char *dest)
 }
 
 static int xdl_fill_merge_buffer(xdfenv_t *xe1, const char *name1,
-		xdfenv_t *xe2, const char *name2, xdmerge_t *m, char *dest)
+				 xdfenv_t *xe2, const char *name2,
+				 int favor,
+				 xdmerge_t *m, char *dest)
 {
 	const int marker_size = 7;
 	int marker1_size = (name1 ? strlen(name1) + 1 : 0);
@@ -124,6 +126,9 @@ static int xdl_fill_merge_buffer(xdfenv_t *xe1, const char *name1,
 	int size, i1, j;
 
 	for (size = i1 = 0; m; m = m->next) {
+		if (favor && !m->mode)
+			m->mode = favor;
+
 		if (m->mode == 0) {
 			size += xdl_recs_copy(xe1, i1, m->i1 - i1, 0,
 					dest ? dest + size : NULL);
@@ -322,8 +327,9 @@ static int xdl_simplify_non_conflicts(xdfenv_t *xe1, xdmerge_t *m,
  * returns < 0 on error, == 0 for no conflicts, else number of conflicts
  */
 static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1, const char *name1,
-		xdfenv_t *xe2, xdchange_t *xscr2, const char *name2,
-		int level, xpparam_t const *xpp, mmbuffer_t *result) {
+			xdfenv_t *xe2, xdchange_t *xscr2, const char *name2,
+			int level, int favor,
+			xpparam_t const *xpp, mmbuffer_t *result) {
 	xdmerge_t *changes, *c;
 	int i1, i2, chg1, chg2;
 
@@ -430,25 +436,27 @@ static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1, const char *name1,
 	/* output */
 	if (result) {
 		int size = xdl_fill_merge_buffer(xe1, name1, xe2, name2,
-			changes, NULL);
+						 favor, changes, NULL);
 		result->ptr = xdl_malloc(size);
 		if (!result->ptr) {
 			xdl_cleanup_merge(changes);
 			return -1;
 		}
 		result->size = size;
-		xdl_fill_merge_buffer(xe1, name1, xe2, name2, changes,
-				result->ptr);
+		xdl_fill_merge_buffer(xe1, name1, xe2, name2,
+				      favor, changes, result->ptr);
 	}
 	return xdl_cleanup_merge(changes);
 }
 
 int xdl_merge(mmfile_t *orig, mmfile_t *mf1, const char *name1,
 		mmfile_t *mf2, const char *name2,
-		xpparam_t const *xpp, int level, mmbuffer_t *result) {
+		xpparam_t const *xpp, int flag, mmbuffer_t *result) {
 	xdchange_t *xscr1, *xscr2;
 	xdfenv_t xe1, xe2;
 	int status;
+	int level = XDL_MERGE_LEVEL(flag);
+	int favor = XDL_MERGE_FAVOR(flag);
 
 	result->ptr = NULL;
 	result->size = 0;
@@ -482,7 +490,7 @@ int xdl_merge(mmfile_t *orig, mmfile_t *mf1, const char *name1,
 		} else {
 			status = xdl_do_merge(&xe1, xscr1, name1,
 					      &xe2, xscr2, name2,
-					      level, xpp, result);
+					      level, favor, xpp, result);
 		}
 		xdl_free_script(xscr1);
 		xdl_free_script(xscr2);
-- 
1.5.6.6.gd3e97
