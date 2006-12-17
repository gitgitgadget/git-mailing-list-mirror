X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/2] Teach all of log family --left-right output.
Date: Sat, 16 Dec 2006 16:12:47 -0800
Message-ID: <7vmz5n8jnk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 17 Dec 2006 00:13:01 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34662>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvjeB-0005FK-2u for gcvg-git@gmane.org; Sun, 17 Dec
 2006 01:12:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422908AbWLQAMw (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 16 Dec 2006
 19:12:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422910AbWLQAMw
 (ORCPT <rfc822;git-outgoing>); Sat, 16 Dec 2006 19:12:52 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:44410 "EHLO
 fed1rmmtao05.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1422908AbWLQAMw (ORCPT <rfc822;git@vger.kernel.org>); Sat, 16 Dec 2006
 19:12:52 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao05.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061217001251.BWQC15640.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>; Sat, 16
 Dec 2006 19:12:51 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id zcCz1V01H1kojtg0000000; Sat, 16 Dec 2006
 19:13:03 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

This makes reviewing

     git log --left-right --merge --no-merges -p

a lot more pleasant.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * This is on the tip of jc/leftright topic, currently only in
   'pu'.  Earlier I had this only for git-rev-list.  Now log
   family knows about this.

 builtin-rev-list.c |    7 +------
 log-tree.c         |   26 ++++++++++++++++++++++----
 revision.c         |    4 ++++
 revision.h         |    1 +
 4 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 4364035..1bb3a06 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -45,7 +45,6 @@ static int bisect_list;
 static int show_timestamp;
 static int hdr_termination;
 static const char *header_prefix;
-static int show_left_right;
 
 static void show_commit(struct commit *commit)
 {
@@ -55,7 +54,7 @@ static void show_commit(struct commit *commit)
 		fputs(header_prefix, stdout);
 	if (commit->object.flags & BOUNDARY)
 		putchar('-');
-	else if (show_left_right) {
+	else if (revs.left_right) {
 		if (commit->object.flags & SYMMETRIC_LEFT)
 			putchar('<');
 		else
@@ -247,10 +246,6 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 			bisect_list = 1;
 			continue;
 		}
-		if (!strcmp(arg, "--left-right")) {
-			show_left_right = 1;
-			continue;
-		}
 		if (!strcmp(arg, "--stdin")) {
 			if (read_from_stdin++)
 				die("--stdin given twice?");
diff --git a/log-tree.c b/log-tree.c
index 8787df5..35be33a 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -114,6 +114,14 @@ void show_log(struct rev_info *opt, const char *sep)
 
 	opt->loginfo = NULL;
 	if (!opt->verbose_header) {
+		if (opt->left_right) {
+			if (commit->object.flags & BOUNDARY)
+				putchar('-');
+			else if (commit->object.flags & SYMMETRIC_LEFT)
+				putchar('<');
+			else
+				putchar('>');
+		}
 		fputs(diff_unique_abbrev(commit->object.sha1, abbrev_commit), stdout);
 		if (opt->parents)
 			show_parents(commit, abbrev_commit);
@@ -192,10 +200,20 @@ void show_log(struct rev_info *opt, const char *sep)
 			opt->diffopt.stat_sep = buffer;
 		}
 	} else {
-		printf("%s%s%s",
-		       diff_get_color(opt->diffopt.color_diff, DIFF_COMMIT),
-		       opt->commit_format == CMIT_FMT_ONELINE ? "" : "commit ",
-		       diff_unique_abbrev(commit->object.sha1, abbrev_commit));
+		fputs(diff_get_color(opt->diffopt.color_diff, DIFF_COMMIT),
+		      stdout);
+		if (opt->commit_format != CMIT_FMT_ONELINE)
+			fputs("commit ", stdout);
+		if (opt->left_right) {
+			if (commit->object.flags & BOUNDARY)
+				putchar('-');
+			else if (commit->object.flags & SYMMETRIC_LEFT)
+				putchar('<');
+			else
+				putchar('>');
+		}
+		fputs(diff_unique_abbrev(commit->object.sha1, abbrev_commit),
+		      stdout);
 		if (opt->parents)
 			show_parents(commit, abbrev_commit);
 		if (parent)
diff --git a/revision.c b/revision.c
index 3d989c3..d84f46e 100644
--- a/revision.c
+++ b/revision.c
@@ -853,6 +853,10 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 				revs->boundary = 1;
 				continue;
 			}
+			if (!strcmp(arg, "--left-right")) {
+				revs->left_right = 1;
+				continue;
+			}
 			if (!strcmp(arg, "--objects")) {
 				revs->tag_objects = 1;
 				revs->tree_objects = 1;
diff --git a/revision.h b/revision.h
index f92a4d4..4585463 100644
--- a/revision.h
+++ b/revision.h
@@ -41,6 +41,7 @@ struct rev_info {
 			limited:1,
 			unpacked:1, /* see also ignore_packed below */
 			boundary:1,
+			left_right:1,
 			parents:1;
 
 	/* Diff flags */
-- 
1.4.4.2.g83c5

