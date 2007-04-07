From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 3/5] merge-recursive: do not barf on "to be removed" entries.
Date: Sat, 07 Apr 2007 07:40:53 -0700
Message-ID: <7v8xd4ckne.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Alex Riesen <raa.lkml@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 07 16:42:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HaC66-00042A-8d
	for gcvg-git@gmane.org; Sat, 07 Apr 2007 16:40:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965907AbXDGOkz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Apr 2007 10:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965910AbXDGOkz
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Apr 2007 10:40:55 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:62061 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965907AbXDGOky (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Apr 2007 10:40:54 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070407144054.PWVE27119.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Sat, 7 Apr 2007 10:40:54 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id kEgt1W00S1kojtg0000000; Sat, 07 Apr 2007 10:40:54 -0400
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43969>

When update-trees::threeway_merge() decides that a path that
exists in the current index (and HEAD) is to be removed, it
leaves a stage 0 entry whose mode bits are set to 0.  The code
mistook it as "this stage wants the blob here", and proceeded
to call update_file_flags() which ended up trying to put the
mode=0 entry in the index, got very confused, and ended up
barfing with "do not know what to do with 000000".

Since threeway_merge() does not handle case #10 (one side
removes while the other side does not do anything), this is not
a problem while we refuse to merge branches that have D/F
conflicts, but when we start resolving them, we would need to be
able to remove cache entries, and at that point it starts to
matter.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 merge-recursive.c |   16 +++++++++++-----
 1 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index e1aebd7..aa3d913 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1002,9 +1002,9 @@ static int process_renames(struct path_list *a_renames,
 	return clean_merge;
 }
 
-static unsigned char *has_sha(const unsigned char *sha)
+static unsigned char *stage_sha(const unsigned char *sha, unsigned mode)
 {
-	return is_null_sha1(sha) ? NULL: (unsigned char *)sha;
+	return (is_null_sha1(sha) || mode == 0) ? NULL: (unsigned char *)sha;
 }
 
 /* Per entry merge function */
@@ -1017,12 +1017,12 @@ static int process_entry(const char *path, struct stage_data *entry,
 	print_index_entry("\tpath: ", entry);
 	*/
 	int clean_merge = 1;
-	unsigned char *o_sha = has_sha(entry->stages[1].sha);
-	unsigned char *a_sha = has_sha(entry->stages[2].sha);
-	unsigned char *b_sha = has_sha(entry->stages[3].sha);
 	unsigned o_mode = entry->stages[1].mode;
 	unsigned a_mode = entry->stages[2].mode;
 	unsigned b_mode = entry->stages[3].mode;
+	unsigned char *o_sha = stage_sha(entry->stages[1].sha, o_mode);
+	unsigned char *a_sha = stage_sha(entry->stages[2].sha, a_mode);
+	unsigned char *b_sha = stage_sha(entry->stages[3].sha, b_mode);
 
 	if (o_sha && (!a_sha || !b_sha)) {
 		/* Case A: Deleted in one */
@@ -1123,6 +1123,12 @@ static int process_entry(const char *path, struct stage_data *entry,
 				update_file_flags(mfi.sha, mfi.mode, path,
 					      0 /* update_cache */, 1 /* update_working_directory */);
 		}
+	} else if (!o_sha && !a_sha && !b_sha) {
+		/*
+		 * this entry was deleted altogether. a_mode == 0 means
+		 * we had that path and want to actively remove it.
+		 */
+		remove_file(1, path, !a_mode);
 	} else
 		die("Fatal merge failure, shouldn't happen.");
 
-- 
1.5.1.81.gee969
