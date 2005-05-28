From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Do not show empty diff in diff-cache uncached.
Date: Sat, 28 May 2005 03:11:19 -0700
Message-ID: <7vis13wth4.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0505261731050.17207@ppc970.osdl.org>
	<7vsm091887.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505270848220.17402@ppc970.osdl.org>
	<7vk6lk5lxt.fsf_-_@assigned-by-dhcp.cox.net>
	<7v3bs82rwh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 28 12:10:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbyFx-0003RM-Ii
	for gcvg-git@gmane.org; Sat, 28 May 2005 12:09:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262678AbVE1KLc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 May 2005 06:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262464AbVE1KLc
	(ORCPT <rfc822;git-outgoing>); Sat, 28 May 2005 06:11:32 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:25846 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S262678AbVE1KLV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 May 2005 06:11:21 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050528101120.XKQP19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 28 May 2005 06:11:20 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7v3bs82rwh.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Fri, 27 May 2005 16:03:26 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Pre- "diff --git" built-in diff did not add any extended header
on its own, so it did not show anything for unmodified but
stat-dirty file from diff-cache command without --cached flag.

Recent diff-cache produces "diff --git" header internally before
calling the "diff" command, which results in an empty diff for
such a file, cluttering the output.  This patch fixes this.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

diff.c            |   26 ++++++++++++++++++++++++++
diffcore-rename.c |   17 -----------------
diffcore.h        |    2 ++
3 files changed, 28 insertions(+), 17 deletions(-)

diff --git a/diff.c b/diff.c
--- a/diff.c
+++ b/diff.c
@@ -684,6 +684,23 @@ int diff_unmodified_pair(struct diff_fil
 	return 0;
 }
 
+int is_exact_match(struct diff_filespec *src, struct diff_filespec *dst)
+{
+	if (src->sha1_valid && dst->sha1_valid &&
+	    !memcmp(src->sha1, dst->sha1, 20))
+		return 1;
+	if (diff_populate_filespec(src, 1) || diff_populate_filespec(dst, 1))
+		return 0;
+	if (src->size != dst->size)
+		return 0;
+	if (diff_populate_filespec(src, 0) || diff_populate_filespec(dst, 0))
+		return 0;
+	if (src->size == dst->size &&
+	    !memcmp(src->data, dst->data, src->size))
+		return 1;
+	return 0;
+}
+
 static void diff_flush_patch(struct diff_filepair *p)
 {
 	const char *name, *other;
@@ -692,6 +709,15 @@ static void diff_flush_patch(struct diff
 	if (diff_unmodified_pair(p))
 		return;
 
+	/* When diff-raw would have said "look at the filesystem", we
+	 * need to see if the two are the same and if so not to emit
+	 * anything at all.  Avoid is_exact_match() comparison when it
+	 * does not matter.
+	 */
+	if ((DIFF_FILE_VALID(p->two) && !p->two->sha1_valid) &&
+	    is_exact_match(p->one, p->two))
+		return;
+
 	name = p->one->path;
 	other = (strcmp(name, p->two->path) ? p->two->path : NULL);
 	if ((DIFF_FILE_VALID(p->one) && S_ISDIR(p->one->mode)) ||
diff --git a/diffcore-rename.c b/diffcore-rename.c
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -94,23 +94,6 @@ static struct diff_rename_src *register_
 	return &(rename_src[first]);
 }
 
-static int is_exact_match(struct diff_filespec *src, struct diff_filespec *dst)
-{
-	if (src->sha1_valid && dst->sha1_valid &&
-	    !memcmp(src->sha1, dst->sha1, 20))
-		return 1;
-	if (diff_populate_filespec(src, 1) || diff_populate_filespec(dst, 1))
-		return 0;
-	if (src->size != dst->size)
-		return 0;
-	if (diff_populate_filespec(src, 0) || diff_populate_filespec(dst, 0))
-		return 0;
-	if (src->size == dst->size &&
-	    !memcmp(src->data, dst->data, src->size))
-		return 1;
-	return 0;
-}
-
 struct diff_score {
 	int src; /* index in rename_src */
 	int dst; /* index in rename_dst */
diff --git a/diffcore.h b/diffcore.h
--- a/diffcore.h
+++ b/diffcore.h
@@ -29,6 +29,8 @@ struct diff_filespec {
 	unsigned should_munmap : 1; /* data should be munmap()'ed */
 };
 
+extern int is_exact_match(struct diff_filespec *, struct diff_filespec *);
+
 extern struct diff_filespec *alloc_filespec(const char *);
 extern void fill_filespec(struct diff_filespec *, const unsigned char *,
 			  unsigned short);
------------------------------------------------

