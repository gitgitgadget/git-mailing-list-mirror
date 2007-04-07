From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 4/5] merge-recursive: handle D/F conflict case more carefully.
Date: Sat, 07 Apr 2007 07:42:55 -0700
Message-ID: <7v6488ckk0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Alex Riesen <raa.lkml@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 07 16:43:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HaC89-0004MC-0X
	for gcvg-git@gmane.org; Sat, 07 Apr 2007 16:43:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752246AbXDGOnB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Apr 2007 10:43:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752249AbXDGOnA
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Apr 2007 10:43:00 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:35267 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752245AbXDGOnA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Apr 2007 10:43:00 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070407144256.MMQQ792.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Sat, 7 Apr 2007 10:42:56 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id kEiv1W00K1kojtg0000000; Sat, 07 Apr 2007 10:42:56 -0400
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43970>

When a path D that originally was blob in the ancestor was
modified on our branch while it was removed on the other branch,
we keep stages 1 and 2, and leave our version in the working
tree.  If the other branch created a path D/F, however, that
path can cleanly be resolved in the index (after all, the
ancestor nor we do not have it and only the other side added),
but it cannot be checked out.  The issue is the same when the
other branch had D and we had renamed it to D/F, or the ancestor
had D/F instead of D (so there are four combinations).

Do not stop the merge, but leave both D and D/F paths in the
index so that the user can clear things up.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * This one is quite iffy, as I suspect it can leave higher
   stages for intermediate merges in its current form, and I
   suspect that the caller of this function should be checking
   for D/F conflicts (there are some provisions in the existing
   code, but apparently they are not good enough to do the right
   thing to pass t3030 test which is the next patch).

 merge-recursive.c |   29 ++++++++++++++++++++++++++---
 1 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index aa3d913..857eeee 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -580,9 +580,31 @@ static void update_file_flags(const unsigned char *sha,
 
 		if (S_ISREG(mode) || (!has_symlinks && S_ISLNK(mode))) {
 			int fd;
-			if (mkdir_p(path, 0777))
-				die("failed to create path %s: %s", path, strerror(errno));
-			unlink(path);
+			int status;
+			const char *msg = "failed to create path '%s'%s";
+
+			status = mkdir_p(path, 0777);
+			if (status) {
+				if (status == -3) {
+					/* something else exists */
+					error(msg, path, ": perhaps a D/F conflict?");
+					update_wd = 0;
+					goto update_index;
+				}
+				die(msg, path, "");
+			}
+			if (unlink(path)) {
+				if (errno == EISDIR) {
+					/* something else exists */
+					error(msg, path, ": perhaps a D/F conflict?");
+					update_wd = 0;
+					goto update_index;
+				}
+				if (errno != ENOENT)
+					die("failed to unlink %s "
+					    "in preparation to update: %s",
+					    path, strerror(errno));
+			}
 			if (mode & 0100)
 				mode = 0777;
 			else
@@ -604,6 +626,7 @@ static void update_file_flags(const unsigned char *sha,
 			die("do not know what to do with %06o %s '%s'",
 			    mode, sha1_to_hex(sha), path);
 	}
+ update_index:
 	if (update_cache)
 		add_cacheinfo(mode, sha, path, 0, update_wd, ADD_CACHE_OK_TO_ADD);
 }
-- 
1.5.1.81.gee969
