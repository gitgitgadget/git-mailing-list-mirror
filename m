From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/2] diff-index --cached --raw: show tree entry on the LHS for unmerged entries.
Date: Fri, 05 Jan 2007 01:42:22 -0800
Message-ID: <7vr6u9izcx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Jan 05 10:42:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2lam-0004YN-0t
	for gcvg-git@gmane.org; Fri, 05 Jan 2007 10:42:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965143AbXAEJmZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Jan 2007 04:42:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030364AbXAEJmZ
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jan 2007 04:42:25 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:39997 "EHLO
	fed1rmmtao11.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965143AbXAEJmY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jan 2007 04:42:24 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070105094223.QIYC25875.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>;
          Fri, 5 Jan 2007 04:42:23 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 7Mie1W0021kojtg0000000; Fri, 05 Jan 2007 04:42:38 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35986>

This updates the way diffcore represents an unmerged pair
somewhat.  It used to be that entries with mode=0 on both sides
were used to represent an unmerged pair, but now it has an
explicit flag.  This is to allow diff-index --cached to report
the entry from the tree when the path is unmerged in the index.

This is used in updating "git reset <tree> -- <path>" to restore
absense of the path in the index from the tree.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * This is rather subtle but touches fairly core part of the
   plumbing, which I tried to stay away from doing these days.
   I do not think it would break anything, but please holler if
   it breaks your scripts...

 diff-lib.c |    9 ++++++---
 diff.c     |    6 ++++--
 diff.h     |    4 +++-
 diffcore.h |    4 ++--
 4 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index fc69fb9..2c9be60 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -97,7 +97,7 @@ int run_diff_files(struct rev_info *revs, int silent_on_removed)
 			 * Show the diff for the 'ce' if we found the one
 			 * from the desired stage.
 			 */
-			diff_unmerge(&revs->diffopt, ce->name);
+			diff_unmerge(&revs->diffopt, ce->name, 0, null_sha1);
 			if (ce_stage(ce) != diff_unmerged_stage)
 				continue;
 		}
@@ -297,9 +297,12 @@ static int diff_cache(struct rev_info *revs,
 			    !show_modified(revs, ce, ac[1], 0,
 					   cached, match_missing))
 				break;
-			/* fallthru */
+			diff_unmerge(&revs->diffopt, ce->name,
+				     ntohl(ce->ce_mode), ce->sha1);
+			break;
 		case 3:
-			diff_unmerge(&revs->diffopt, ce->name);
+			diff_unmerge(&revs->diffopt, ce->name,
+				     0, null_sha1);
 			break;
 
 		default:
diff --git a/diff.c b/diff.c
index f14288b..2c2e9dc 100644
--- a/diff.c
+++ b/diff.c
@@ -2875,10 +2875,12 @@ void diff_change(struct diff_options *options,
 }
 
 void diff_unmerge(struct diff_options *options,
-		  const char *path)
+		  const char *path,
+		  unsigned mode, const unsigned char *sha1)
 {
 	struct diff_filespec *one, *two;
 	one = alloc_filespec(path);
 	two = alloc_filespec(path);
-	diff_queue(&diff_queued_diff, one, two);
+	fill_filespec(one, sha1, mode);
+	diff_queue(&diff_queued_diff, one, two)->is_unmerged = 1;
 }
diff --git a/diff.h b/diff.h
index eff4455..7a347cf 100644
--- a/diff.h
+++ b/diff.h
@@ -144,7 +144,9 @@ extern void diff_change(struct diff_options *,
 			const char *base, const char *path);
 
 extern void diff_unmerge(struct diff_options *,
-			 const char *path);
+			 const char *path,
+			 unsigned mode,
+			 const unsigned char *sha1);
 
 extern int diff_scoreopt_parse(const char *opt);
 
diff --git a/diffcore.h b/diffcore.h
index 2249bc2..1ea8067 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -54,9 +54,9 @@ struct diff_filepair {
 	unsigned source_stays : 1; /* all of R/C are copies */
 	unsigned broken_pair : 1;
 	unsigned renamed_pair : 1;
+	unsigned is_unmerged : 1;
 };
-#define DIFF_PAIR_UNMERGED(p) \
-	(!DIFF_FILE_VALID((p)->one) && !DIFF_FILE_VALID((p)->two))
+#define DIFF_PAIR_UNMERGED(p) ((p)->is_unmerged)
 
 #define DIFF_PAIR_RENAME(p) ((p)->renamed_pair)
 
-- 
1.5.0.rc0.ge0f6
