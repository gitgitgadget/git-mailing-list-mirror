From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 3/4] diff: Clean up diff_scoreopt_parse().
Date: Fri, 03 Jun 2005 01:37:54 -0700
Message-ID: <7v1x7jq1i5.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0505301253070.1876@ppc970.osdl.org>
	<m1psv7bjb6.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.58.0505312002160.1876@ppc970.osdl.org>
	<7vmzqau3es.fsf@assigned-by-dhcp.cox.net>
	<7vll5sz54z.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506021716140.1876@ppc970.osdl.org>
	<7vis0wusv5.fsf@assigned-by-dhcp.cox.net>
	<7vis0vq1rz.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 03 10:36:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1De7eT-0007gi-DQ
	for gcvg-git@gmane.org; Fri, 03 Jun 2005 10:35:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbVFCIil (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Jun 2005 04:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261183AbVFCIil
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Jun 2005 04:38:41 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:38784 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S261181AbVFCIh4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2005 04:37:56 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050603083754.TXZO12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 3 Jun 2005 04:37:54 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vis0vq1rz.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Fri, 03 Jun 2005 01:32:00 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This cleans up diff_scoreopt_parse() function that is used to
parse the fractional notation -B, -C and -M option takes.  The
callers are modified to check for errors and complain.  Earlier
they silently ignored malformed input and falled back on the
default.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 diff-cache.c      |    9 ++++++---
 diff-files.c      |   15 +++++++++++----
 diff-tree.c       |    9 ++++++---
 diff.c            |   39 +++++++++++++++++++++++++++++++++++++++
 diffcore-rename.c |   18 ------------------
 5 files changed, 62 insertions(+), 28 deletions(-)

diff --git a/diff-cache.c b/diff-cache.c
--- a/diff-cache.c
+++ b/diff-cache.c
@@ -191,17 +191,20 @@ int main(int argc, const char **argv)
 			continue;
 		}
 		if (!strncmp(arg, "-B", 2)) {
-			diff_break_opt = diff_scoreopt_parse(arg);
+			if ((diff_break_opt = diff_scoreopt_parse(arg)) == -1)
+				usage(diff_cache_usage);
 			continue;
 		}
 		if (!strncmp(arg, "-M", 2)) {
 			detect_rename = DIFF_DETECT_RENAME;
-			diff_score_opt = diff_scoreopt_parse(arg);
+			if ((diff_score_opt = diff_scoreopt_parse(arg)) == -1)
+				usage(diff_cache_usage);
 			continue;
 		}
 		if (!strncmp(arg, "-C", 2)) {
 			detect_rename = DIFF_DETECT_COPY;
-			diff_score_opt = diff_scoreopt_parse(arg);
+			if ((diff_score_opt = diff_scoreopt_parse(arg)) == -1)
+				usage(diff_cache_usage);
 			continue;
 		}
 		if (!strcmp(arg, "-z")) {
diff --git a/diff-files.c b/diff-files.c
--- a/diff-files.c
+++ b/diff-files.c
@@ -61,14 +61,21 @@ int main(int argc, const char **argv)
 			orderfile = argv[1] + 2;
 		else if (!strcmp(argv[1], "--pickaxe-all"))
 			pickaxe_opts = DIFF_PICKAXE_ALL;
-		else if (!strncmp(argv[1], "-B", 2))
-			diff_break_opt = diff_scoreopt_parse(argv[1]);
+		else if (!strncmp(argv[1], "-B", 2)) {
+			if ((diff_break_opt =
+			     diff_scoreopt_parse(argv[1])) == -1)
+				usage(diff_files_usage);
+		}
 		else if (!strncmp(argv[1], "-M", 2)) {
-			diff_score_opt = diff_scoreopt_parse(argv[1]);
+			if ((diff_score_opt =
+			     diff_scoreopt_parse(argv[1])) == -1)
+				usage(diff_files_usage);
 			detect_rename = DIFF_DETECT_RENAME;
 		}
 		else if (!strncmp(argv[1], "-C", 2)) {
-			diff_score_opt = diff_scoreopt_parse(argv[1]);
+			if ((diff_score_opt =
+			     diff_scoreopt_parse(argv[1])) == -1)
+				usage(diff_files_usage);
 			detect_rename = DIFF_DETECT_COPY;
 		}
 		else
diff --git a/diff-tree.c b/diff-tree.c
--- a/diff-tree.c
+++ b/diff-tree.c
@@ -459,16 +459,19 @@ int main(int argc, const char **argv)
 		}
 		if (!strncmp(arg, "-M", 2)) {
 			detect_rename = DIFF_DETECT_RENAME;
-			diff_score_opt = diff_scoreopt_parse(arg);
+			if ((diff_score_opt = diff_scoreopt_parse(arg)) == -1)
+				usage(diff_tree_usage);
 			continue;
 		}
 		if (!strncmp(arg, "-C", 2)) {
 			detect_rename = DIFF_DETECT_COPY;
-			diff_score_opt = diff_scoreopt_parse(arg);
+			if ((diff_score_opt = diff_scoreopt_parse(arg)) == -1)
+				usage(diff_tree_usage);
 			continue;
 		}
 		if (!strncmp(arg, "-B", 2)) {
-			diff_break_opt = diff_scoreopt_parse(arg);
+			if ((diff_break_opt = diff_scoreopt_parse(arg)) == -1)
+				usage(diff_tree_usage);
 			continue;
 		}
 		if (!strcmp(arg, "-z")) {
diff --git a/diff.c b/diff.c
--- a/diff.c
+++ b/diff.c
@@ -589,6 +589,45 @@ void diff_setup(int flags)
 	
 }
 
+static int parse_num(const char **cp_p)
+{
+	int num, scale, ch, cnt;
+	const char *cp = *cp_p;
+
+	cnt = num = 0;
+	scale = 1;
+	while ('0' <= (ch = *cp) && ch <= '9') {
+		if (cnt++ < 5) {
+			/* We simply ignore more than 5 digits precision. */
+			scale *= 10;
+			num = num * 10 + ch - '0';
+		}
+		*cp++;
+	}
+	*cp_p = cp;
+
+	/* user says num divided by scale and we say internally that
+	 * is MAX_SCORE * num / scale.
+	 */
+	return (MAX_SCORE * num / scale);
+}
+
+int diff_scoreopt_parse(const char *opt)
+{
+	int opt1, cmd;
+
+	if (*opt++ != '-')
+		return -1;
+	cmd = *opt++;
+	if (cmd != 'M' && cmd != 'C' && cmd != 'B')
+		return -1; /* that is not a -M, -C nor -B option */
+
+	opt1 = parse_num(&opt);
+	if (*opt != 0)
+		return -1;
+	return opt1;
+}
+
 struct diff_queue_struct diff_queued_diff;
 
 void diff_q(struct diff_queue_struct *queue, struct diff_filepair *dp)
diff --git a/diffcore-rename.c b/diffcore-rename.c
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -229,24 +229,6 @@ static int score_compare(const void *a_,
 	return b->score - a->score;
 }
 
-int diff_scoreopt_parse(const char *opt)
-{
-	int diglen, num, scale, i;
-	if (opt[0] != '-' || (opt[1] != 'M' && opt[1] != 'C' && opt[1] != 'B'))
-		return -1; /* that is not a -M, -C nor -B option */
-	diglen = strspn(opt+2, "0123456789");
-	if (diglen == 0 || strlen(opt+2) != diglen)
-		return 0; /* use default */
-	sscanf(opt+2, "%d", &num);
-	for (i = 0, scale = 1; i < diglen; i++)
-		scale *= 10;
-
-	/* user says num divided by scale and we say internally that
-	 * is MAX_SCORE * num / scale.
-	 */
-	return MAX_SCORE * num / scale;
-}
-
 void diffcore_rename(int detect_rename, int minimum_score)
 {
 	struct diff_queue_struct *q = &diff_queued_diff;
------------

