From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/8] diff --no-index: also imitate the exit status of diff(1)
Date: Sun, 25 Feb 2007 23:34:54 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702252334400.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Sun Feb 25 23:35:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLRxL-0002xs-Hb
	for gcvg-git@gmane.org; Sun, 25 Feb 2007 23:34:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965172AbXBYWe5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Feb 2007 17:34:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751410AbXBYWe5
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Feb 2007 17:34:57 -0500
Received: from mail.gmx.net ([213.165.64.20]:38387 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751284AbXBYWez (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Feb 2007 17:34:55 -0500
Received: (qmail invoked by alias); 25 Feb 2007 22:34:54 -0000
X-Provags-ID: V01U2FsdGVkX1+9+KVKxRS9bAMYpGY547MeWBDMP52RMc1bk29DhU
	lSNg==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40584>


diff sets the exit status to 0 when no changes were found, to 1
when changes were found, and 2 means error.

We imitate this to be able to use "git diff" in the test scripts.
(Actually, keeping in line with the rest of git, -1 is returned
on error, which corresponds to an exit status 255).

To find out if the diff is not empty, a member called
"found_changes" was introduced in struct diff_options, which is
set in builtin_diff() and fn_out_consume().

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 diff-lib.c |   11 ++++++++---
 diff.c     |    6 ++++++
 diff.h     |    3 +++
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index 17b9a56..b164222 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -210,11 +210,16 @@ int run_diff_files_cmd(struct rev_info *revs, int argc, const char **argv)
 	if (revs->max_count == -2) {
 		if (revs->diffopt.nr_paths != 2)
 			return error("need two files/directories with --no-index");
-		queue_diff(&revs->diffopt, revs->diffopt.paths[0],
-				revs->diffopt.paths[1]);
+		if (queue_diff(&revs->diffopt, revs->diffopt.paths[0],
+				revs->diffopt.paths[1]))
+			return -1;
 		diffcore_std(&revs->diffopt);
 		diff_flush(&revs->diffopt);
-		return 0;
+		/*
+		 * The return code for --no-index imitates diff(1):
+		 * 0 = no changes, 1 = changes, else error
+		 */
+		return revs->diffopt.found_changes;
 	}
 
 	if (read_cache() < 0) {
diff --git a/diff.c b/diff.c
index 6bd456e..5651152 100644
--- a/diff.c
+++ b/diff.c
@@ -382,6 +382,7 @@ struct emit_callback {
 	int nparents, color_diff;
 	const char **label_path;
 	struct diff_words_data *diff_words;
+	int *found_changesp;
 };
 
 static void free_diff_words_data(struct emit_callback *ecbdata)
@@ -501,6 +502,8 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 	const char *set = diff_get_color(ecbdata->color_diff, DIFF_METAINFO);
 	const char *reset = diff_get_color(ecbdata->color_diff, DIFF_RESET);
 
+	*(ecbdata->found_changesp) = 1;
+
 	if (ecbdata->label_path[0]) {
 		const char *name_a_tab, *name_b_tab;
 
@@ -1098,6 +1101,7 @@ static void builtin_diff(const char *name_a,
 		if (complete_rewrite) {
 			emit_rewrite_diff(name_a, name_b, one, two,
 					o->color_diff);
+			o->found_changes = 1;
 			goto free_ab_and_return;
 		}
 	}
@@ -1115,6 +1119,7 @@ static void builtin_diff(const char *name_a,
 		else
 			printf("Binary files %s and %s differ\n",
 			       lbl[0], lbl[1]);
+		o->found_changes = 1;
 	}
 	else {
 		/* Crazy xdl interfaces.. */
@@ -1127,6 +1132,7 @@ static void builtin_diff(const char *name_a,
 		memset(&ecbdata, 0, sizeof(ecbdata));
 		ecbdata.label_path = lbl;
 		ecbdata.color_diff = o->color_diff;
+		ecbdata.found_changesp = &o->found_changes;
 		xpp.flags = XDF_NEED_MINIMAL | o->xdl_opts;
 		xecfg.ctxlen = o->context;
 		xecfg.flags = XDL_EMIT_FUNCNAMES;
diff --git a/diff.h b/diff.h
index b608828..4043cec 100644
--- a/diff.h
+++ b/diff.h
@@ -75,6 +75,9 @@ struct diff_options {
 	int stat_width;
 	int stat_name_width;
 
+	/* this is set by diffcore for DIFF_FORMAT_PATCH */
+	int found_changes;
+
 	int nr_paths;
 	const char **paths;
 	int *pathlens;
-- 
1.5.0.1.788.g8ca52
