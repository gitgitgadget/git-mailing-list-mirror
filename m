From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/3] blame: handle the tail-match correctly in -C/-M
Date: Sat,  5 May 2007 23:02:41 -0700
Message-ID: <11784313631165-git-send-email-junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 06 08:03:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkZpi-00008i-JD
	for gcvg-git@gmane.org; Sun, 06 May 2007 08:02:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754597AbXEFGCp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 May 2007 02:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754657AbXEFGCp
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 02:02:45 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:57728 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754597AbXEFGCo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2007 02:02:44 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070506060243.TABB6556.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>
          for <git@vger.kernel.org>; Sun, 6 May 2007 02:02:43 -0400
Received: from localhost.localdomain ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id vi2j1W00X1kojtg0000000; Sun, 06 May 2007 02:02:43 -0400
X-Mailer: git-send-email 1.5.2.rc1.709.g9462
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46298>

The -C/-M option to blame tries to find a section of a preimage
file by running diff against the lines whose origin is still
unknown, and excluding the different parts.  The code however
did not cover the case where the tail part of the section
matched, which we handle for the normal non-move/copy codepath.

This breakage was most visible when preimage file matches in its
entirety and failed to pass blame in such a case.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 builtin-blame.c |   52 ++++++++++++++++++++++++++++++++++++++++------------
 1 files changed, 40 insertions(+), 12 deletions(-)

diff --git a/builtin-blame.c b/builtin-blame.c
index 8919b02..f8843e6 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -891,6 +891,39 @@ static void copy_split_if_better(struct scoreboard *sb,
 }
 
 /*
+ * We are looking at a part of the final image represented by
+ * ent (tlno and same are offset by ent->s_lno).
+ * tlno is where we are looking at in the final image.
+ * up to (but not including) same match preimage.
+ * plno is where we are looking at in the preimage.
+ *
+ * <-------------- final image ---------------------->
+ *       <------ent------>
+ *         ^tlno ^same
+ *    <---------preimage----->
+ *         ^plno
+ *
+ * All line numbers are 0-based.
+ */
+static void handle_split(struct scoreboard *sb,
+			 struct blame_entry *ent,
+			 int tlno, int plno, int same,
+			 struct origin *parent,
+			 struct blame_entry *split)
+{
+	if (ent->num_lines <= tlno)
+		return;
+	if (tlno < same) {
+		struct blame_entry this[3];
+		tlno += ent->s_lno;
+		same += ent->s_lno;
+		split_overlap(this, ent, tlno, plno, same, parent);
+		copy_split_if_better(sb, split, this);
+		decref_split(this);
+	}
+}
+
+/*
  * Find the lines from parent that are the same as ent so that
  * we can pass blames to it.  file_p has the blob contents for
  * the parent.
@@ -922,26 +955,21 @@ static void find_copy_in_blob(struct scoreboard *sb,
 
 	patch = compare_buffer(file_p, &file_o, 1);
 
+	/*
+	 * file_o is a part of final image we are annotating.
+	 * file_p partially may match that image.
+	 */
 	memset(split, 0, sizeof(struct blame_entry [3]));
 	plno = tlno = 0;
 	for (i = 0; i < patch->num; i++) {
 		struct chunk *chunk = &patch->chunks[i];
 
-		/* tlno to chunk->same are the same as ent */
-		if (ent->num_lines <= tlno)
-			break;
-		if (tlno < chunk->same) {
-			struct blame_entry this[3];
-			split_overlap(this, ent,
-				      tlno + ent->s_lno, plno,
-				      chunk->same + ent->s_lno,
-				      parent);
-			copy_split_if_better(sb, split, this);
-			decref_split(this);
-		}
+		handle_split(sb, ent, tlno, plno, chunk->same, parent, split);
 		plno = chunk->p_next;
 		tlno = chunk->t_next;
 	}
+	/* remainder, if any, all match the preimage */
+	handle_split(sb, ent, tlno, plno, ent->num_lines, parent, split);
 	free_patch(patch);
 }
 
-- 
1.5.2.rc1.709.g9462
