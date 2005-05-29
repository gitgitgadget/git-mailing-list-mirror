From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] diff-cache: diff-patch (-p) format fixes.
Date: Sat, 28 May 2005 22:23:17 -0700
Message-ID: <7voeaur4fu.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0505261731050.17207@ppc970.osdl.org>
	<7vsm091887.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505270848220.17402@ppc970.osdl.org>
	<7vk6lk5lxt.fsf_-_@assigned-by-dhcp.cox.net>
	<7v3bs82rwh.fsf@assigned-by-dhcp.cox.net>
	<7vis13wth4.fsf_-_@assigned-by-dhcp.cox.net>
	<7vr7frrw8x.fsf_-_@assigned-by-dhcp.cox.net>
	<7v3bs6slwl.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 29 07:24:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcGH2-0000Vw-6W
	for gcvg-git@gmane.org; Sun, 29 May 2005 07:23:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261254AbVE2FZf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 May 2005 01:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261264AbVE2FZe
	(ORCPT <rfc822;git-outgoing>); Sun, 29 May 2005 01:25:34 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:18081 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S261254AbVE2FXT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 May 2005 01:23:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050529052317.CVTW22430.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 29 May 2005 01:23:17 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7v3bs6slwl.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Sat, 28 May 2005 21:20:42 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This fixes two more bugs.

 - When diff-cache is run with -R and without --cached, a
   stat-dirty but otherwise unmodified file still produced an
   empty "diff --git" header (earlier fix was only for the case
   without -R).

 - When diff-cache is run without --cached, an unmodifed file
   that has different mode bits from the tree incorrectly picked
   up the mode bits from the filesystem, when it should have
   used what was recorded in the tree object.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

diff.c |   26 ++++++++++++++++++++++----
1 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/diff.c b/diff.c
--- a/diff.c
+++ b/diff.c
@@ -183,6 +183,9 @@ void fill_filespec(struct diff_filespec 
  * Given a name and sha1 pair, if the dircache tells us the file in
  * the work tree has that object contents, return true, so that
  * prepare_temp_file() does not have to inflate and extract.
+ *
+ * NOTE: this function does not use the mode bits, so diff_filespec
+ * users must be careful about mode handling!
  */
 static int work_tree_matches(const char *name, const unsigned char *sha1)
 {
@@ -394,6 +397,10 @@ static void prepare_temp_file(const char
 
 	if (!one->sha1_valid ||
 	    work_tree_matches(name, one->sha1)) {
+		/* NOTE: we only say the matching file has the same
+		 * contents.  It may have a different mode, in which
+		 * case we should not pick it up from the filesystem!
+		 */
 		struct stat st;
 		if (lstat(name, &st) < 0) {
 			if (errno == ENOENT)
@@ -421,8 +428,15 @@ static void prepare_temp_file(const char
 				strcpy(temp->hex, sha1_to_hex(null_sha1));
 			else
 				strcpy(temp->hex, sha1_to_hex(one->sha1));
-			sprintf(temp->mode, "%06o",
-				S_IFREG |ce_permissions(st.st_mode));
+			/* even though we borrow the contents from the
+			 * work tree, we want our mode if we are not told
+			 * to look at the filesystem.
+			 */
+			if (one->sha1_valid)
+				sprintf(temp->mode, "%06o", one->mode);
+			else
+				sprintf(temp->mode, "%06o",
+					S_IFREG | ce_permissions(st.st_mode));
 		}
 		return;
 	}
@@ -716,9 +730,13 @@ static void diff_flush_patch(struct diff
 	 * need to see if the two are the same and if so not to emit
 	 * anything at all.  Avoid is_exact_match() comparison when it
 	 * does not matter.
+	 * Notice that "look at the filesystem" can happen on p->one
+	 * if we are operating under reverse-diff option.
 	 */
-	if ((DIFF_FILE_VALID(p->two) && !p->two->sha1_valid) &&
-	    is_exact_match(p->one, p->two))
+	if ( ((DIFF_FILE_VALID(p->one) && !p->one->sha1_valid) ||
+	      (DIFF_FILE_VALID(p->two) && !p->two->sha1_valid)) &&
+	     is_exact_match(p->one, p->two) &&
+	     (p->one->mode == p->two->mode) )
 		return;
 
 	name = p->one->path;
------------------------------------------------

