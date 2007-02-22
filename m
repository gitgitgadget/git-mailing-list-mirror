From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] run_diff_files(): add option to prevent --no-index
Date: Thu, 22 Feb 2007 19:54:35 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702221952140.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0702201944340.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vzm76fpia.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0702221724090.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vvehuf4ic.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0702221926390.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Feb 22 19:54:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKJ5V-0004jx-L3
	for gcvg-git@gmane.org; Thu, 22 Feb 2007 19:54:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751769AbXBVSyi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Feb 2007 13:54:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751771AbXBVSyi
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Feb 2007 13:54:38 -0500
Received: from mail.gmx.net ([213.165.64.20]:37469 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751769AbXBVSyh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Feb 2007 13:54:37 -0500
Received: (qmail invoked by alias); 22 Feb 2007 18:54:35 -0000
X-Provags-ID: V01U2FsdGVkX188/50JBgA8Q3MHdoTg6IUQWKOv/VS64bNccCWFa/
	zVVw==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.63.0702221926390.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40367>


An important user, wt-status, does not want no-index. So add a
parameter to run_diff_files() which says if it is allowed or not.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	> How about adding "int always_use_index" to the signature of 
	> run_diff_files()?

	I called the parameter "allow_no_index", since it is a little 
	friendlier. I have been accused of being not friendly enough.

 builtin-diff-files.c |    2 +-
 builtin-diff.c       |    2 +-
 diff-lib.c           |    5 +++--
 diff.h               |    2 +-
 wt-status.c          |    2 +-
 5 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/builtin-diff-files.c b/builtin-diff-files.c
index 8d78dfa..05a81b1 100644
--- a/builtin-diff-files.c
+++ b/builtin-diff-files.c
@@ -26,5 +26,5 @@ int cmd_diff_files(int argc, const char **argv, const char *prefix)
 	argc = setup_revisions(argc, argv, &rev, NULL);
 	if (!rev.diffopt.output_format)
 		rev.diffopt.output_format = DIFF_FORMAT_RAW;
-	return run_diff_files(&rev, argc, argv);
+	return run_diff_files(&rev, argc, argv, 1);
 }
diff --git a/builtin-diff.c b/builtin-diff.c
index 9334589..7f1ad60 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -282,7 +282,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 	if (!ents) {
 		switch (blobs) {
 		case 0:
-			return run_diff_files(&rev, argc, argv);
+			return run_diff_files(&rev, argc, argv, 1);
 			break;
 		case 1:
 			if (paths != 1)
diff --git a/diff-lib.c b/diff-lib.c
index 83d6682..7877f5c 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -200,7 +200,8 @@ static int handle_diff_files_args(struct rev_info *revs,
 	return 0;
 }
 
-int run_diff_files(struct rev_info *revs, int argc, const char **argv)
+int run_diff_files(struct rev_info *revs, int argc, const char **argv,
+		int allow_no_index)
 {
 	int entries, i;
 	int diff_unmerged_stage;
@@ -211,7 +212,7 @@ int run_diff_files(struct rev_info *revs, int argc, const char **argv)
 
 	diff_unmerged_stage = revs->max_count;
 
-	if (revs->max_count == -2) {
+	if (allow_no_index && revs->max_count == -2) {
 		if (revs->diffopt.nr_paths != 2)
 			return error("need two files/directories with --no-index");
 		queue_diff(&revs->diffopt, revs->diffopt.paths[0],
diff --git a/diff.h b/diff.h
index cc28418..bf2d3c9 100644
--- a/diff.h
+++ b/diff.h
@@ -218,7 +218,7 @@ extern void diff_flush(struct diff_options*);
 
 extern const char *diff_unique_abbrev(const unsigned char *, int);
 
-extern int run_diff_files(struct rev_info *revs, int argc, const char **argv);
+extern int run_diff_files(struct rev_info *revs, int argc, const char **argv, int allow_no_index);
 
 extern int run_diff_index(struct rev_info *revs, int cached);
 
diff --git a/wt-status.c b/wt-status.c
index b68eea3..4e8904d 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -231,7 +231,7 @@ static void wt_status_print_changed(struct wt_status *s)
 	rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
 	rev.diffopt.format_callback = wt_status_print_changed_cb;
 	rev.diffopt.format_callback_data = s;
-	run_diff_files(&rev, 0, NULL);
+	run_diff_files(&rev, 0, NULL, 0);
 }
 
 static void wt_status_print_untracked(struct wt_status *s)
-- 
1.5.0.51.ge5582-dirty
