From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/3] blame: -C -C -C
Date: Sat,  5 May 2007 23:02:42 -0700
Message-ID: <11784313642492-git-send-email-junkio@cox.net>
References: <11784313631165-git-send-email-junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 06 08:03:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkZpj-00008i-3H
	for gcvg-git@gmane.org; Sun, 06 May 2007 08:02:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754617AbXEFGCq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 May 2007 02:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754689AbXEFGCq
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 02:02:46 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:52403 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754617AbXEFGCo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2007 02:02:44 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070506060243.YJOS24310.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>
          for <git@vger.kernel.org>; Sun, 6 May 2007 02:02:43 -0400
Received: from localhost.localdomain ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id vi2j1W00X1kojtg0000100; Sun, 06 May 2007 02:02:44 -0400
X-Mailer: git-send-email 1.5.2.rc1.709.g9462
In-Reply-To: <11784313631165-git-send-email-junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46299>

Existing "blame -C -C" would not find that the latter half of
the file2 came from the existing file1:

	... both file1 and file2 are tracked ...
	$ cat file1 >>file2
	$ git add file1 file2
	$ git commit

This is because we avoid the expensive find-copies-harder code
that makes unchanged file (in this case, file1) as a candidate
for copy & paste source when annotating an existing file
(file2).  The third -C now allows it.  However, this obviously
makes the process very expensive.  We've actually seen this
patch before, but I dismissed it because it covers such a narrow
(and arguably stupid) corner case.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 builtin-blame.c |   15 +++++++++++++--
 1 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/builtin-blame.c b/builtin-blame.c
index f8843e6..65d029a 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -55,6 +55,7 @@ static int num_commits;
 #define PICKAXE_BLAME_MOVE		01
 #define PICKAXE_BLAME_COPY		02
 #define PICKAXE_BLAME_COPY_HARDER	04
+#define PICKAXE_BLAME_COPY_HARDEST	010
 
 /*
  * blame for a blame_entry with score lower than these thresholds
@@ -1079,8 +1080,9 @@ static int find_copy_in_parent(struct scoreboard *sb,
 	 * and this code needs to be after diff_setup_done(), which
 	 * usually makes find-copies-harder imply copy detection.
 	 */
-	if ((opt & PICKAXE_BLAME_COPY_HARDER) &&
-	    (!porigin || strcmp(target->path, porigin->path)))
+	if ((opt & PICKAXE_BLAME_COPY_HARDEST)
+	    || ((opt & PICKAXE_BLAME_COPY_HARDER)
+		&& (!porigin || strcmp(target->path, porigin->path))))
 		diff_opts.find_copies_harder = 1;
 
 	if (is_null_sha1(target->commit->object.sha1))
@@ -2127,6 +2129,15 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 			blame_move_score = parse_score(arg+2);
 		}
 		else if (!prefixcmp(arg, "-C")) {
+			/*
+			 * -C enables copy from removed files;
+			 * -C -C enables copy from existing files, but only
+			 *       when blaming a new file;
+			 * -C -C -C enables copy from existing files for
+			 *          everybody
+			 */
+			if (opt & PICKAXE_BLAME_COPY_HARDER)
+				opt |= PICKAXE_BLAME_COPY_HARDEST;
 			if (opt & PICKAXE_BLAME_COPY)
 				opt |= PICKAXE_BLAME_COPY_HARDER;
 			opt |= PICKAXE_BLAME_COPY | PICKAXE_BLAME_MOVE;
-- 
1.5.2.rc1.709.g9462
