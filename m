From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH] Use diff_tree() directly in making cover letter
Date: Thu, 28 Feb 2008 12:14:13 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802281213140.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 28 18:14:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUmLO-0003mf-Td
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 18:14:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758307AbYB1ROS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 12:14:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757812AbYB1ROR
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 12:14:17 -0500
Received: from iabervon.org ([66.92.72.58]:43428 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753248AbYB1ROR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 12:14:17 -0500
Received: (qmail 8949 invoked by uid 1000); 28 Feb 2008 17:14:13 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 28 Feb 2008 17:14:13 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75424>

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 builtin-log.c |   25 +++++++++++--------------
 1 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 836b61e..bbadbc0 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -647,8 +647,7 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 			      int nr, struct commit **list, struct commit *head)
 {
 	const char *committer;
-	const char *origin_sha1, *head_sha1;
-	const char *argv[7];
+	char *head_sha1;
 	const char *subject_start = NULL;
 	const char *body = "*** SUBJECT HERE ***\n\n*** BLURB HERE ***\n";
 	const char *msg;
@@ -657,6 +656,7 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 	struct strbuf sb;
 	int i;
 	const char *encoding = "utf-8";
+	struct diff_options opts;
 
 	if (rev->commit_format != CMIT_FMT_EMAIL)
 		die("Cover letter needs email format");
@@ -694,20 +694,17 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 	if (!origin)
 		return;
 
-	origin_sha1 = sha1_to_hex(origin->object.sha1);
+	diff_setup(&opts);
+	opts.output_format |= DIFF_FORMAT_SUMMARY | DIFF_FORMAT_DIFFSTAT;
 
-	argv[0] = "diff";
-	argv[1] = "--stat";
-	argv[2] = "--summary";
-	argv[3] = head_sha1;
-	argv[4] = "--not";
-	argv[5] = origin_sha1;
-	argv[6] = "--";
-	argv[7] = NULL;
-	fflush(stdout);
-	run_command_v_opt(argv, RUN_GIT_CMD);
+	diff_setup_done(&opts);
+
+	diff_tree_sha1(origin->tree->object.sha1,
+		       head->tree->object.sha1,
+		       "", &opts);
+	diffcore_std(&opts);
+	diff_flush(&opts);
 
-	fflush(stdout);
 	printf("\n");
 }
 
-- 
1.5.4.3.328.gcaed
