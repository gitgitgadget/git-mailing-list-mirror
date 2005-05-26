From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Diff updates to express type changes
Date: Thu, 26 May 2005 02:24:30 -0700
Message-ID: <7vu0kqcpbl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 26 11:23:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbEZt-0000O2-Aa
	for gcvg-git@gmane.org; Thu, 26 May 2005 11:22:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261225AbVEZJYp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 May 2005 05:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261235AbVEZJYp
	(ORCPT <rfc822;git-outgoing>); Thu, 26 May 2005 05:24:45 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:6528 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S261225AbVEZJYg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2005 05:24:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050526092431.LIQN7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 26 May 2005 05:24:31 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

With the introduction of type 'T' in the diff-raw output, and
the "apply-patch" program Linus has been quietly working on
without much advertisement, it started to make sense to emit
usable information in the "diff --git" patch output format as
well.  Earlier built-in diff driver punted and did not say
anything about a symbolic link changing into a file or vice
versa, but this version represents it as a pair of deletion
and creation.

It also fixes a minor problem dealing with old archive created
with ancient git.  The earlier code was reporting file mode
change between 100664 and 100644 (we shouldn't).  The linux-2.6
git tree has a good example that exposes this problem.  A good
test case is commit ce1dc02f76432a46db149241e015a4f782974623.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

diff.c     |   45 ++++++++++++++++++++++++++++++++++++---------
diffcore.h |    6 ++++++
2 files changed, 42 insertions(+), 9 deletions(-)

diff --git a/diff.c b/diff.c
--- a/diff.c
+++ b/diff.c
@@ -171,8 +171,8 @@ struct diff_filespec *alloc_filespec(con
 void fill_filespec(struct diff_filespec *spec, const unsigned char *sha1,
 		   unsigned short mode)
 {
-	if (mode) { /* just playing defensive */
-		spec->mode = mode;
+	if (mode) {
+		spec->mode = DIFF_FILE_CANON_MODE(mode);
 		memcpy(spec->sha1, sha1, 20);
 		spec->sha1_valid = !!memcmp(sha1, null_sha1, 20);
 	}
@@ -390,7 +390,8 @@ static void remove_tempfile_on_signal(in
  *               infile2 infile2-sha1 infile2-mode [ rename-to ]
  *
  */
-static void run_external_diff(const char *name,
+static void run_external_diff(const char *pgm,
+			      const char *name,
 			      const char *other,
 			      struct diff_filespec *one,
 			      struct diff_filespec *two,
@@ -418,7 +419,6 @@ static void run_external_diff(const char
 	if (pid < 0)
 		die("unable to fork");
 	if (!pid) {
-		const char *pgm = external_diff();
 		if (pgm) {
 			if (one && two) {
 				const char *exec_arg[10];
@@ -468,6 +468,30 @@ static void run_external_diff(const char
 	remove_tempfile();
 }
 
+static void run_diff(const char *name,
+		     const char *other,
+		     struct diff_filespec *one,
+		     struct diff_filespec *two,
+		     const char *xfrm_msg)
+{
+	const char *pgm = external_diff();
+	if (!pgm &&
+	    DIFF_FILE_VALID(one) && DIFF_FILE_VALID(two) &&
+	    (S_IFMT & one->mode) != (S_IFMT & two->mode)) {
+		/* a filepair that changes between file and symlink
+		 * needs to be split into deletion and creation.
+		 */
+		struct diff_filespec *null = alloc_filespec(two->path);
+		run_external_diff(NULL, name, other, one, null, xfrm_msg);
+		free(null);
+		null = alloc_filespec(one->path);
+		run_external_diff(NULL, name, other, null, two, xfrm_msg);
+		free(null);
+	}
+	else
+		run_external_diff(pgm, name, other, one, two, xfrm_msg);
+}
+
 void diff_setup(int reverse_diff_)
 {
 	reverse_diff = reverse_diff_;
@@ -553,9 +577,11 @@ int diff_unmodified_pair(struct diff_fil
 	one = p->one;
 	two = p->two;
 
-	/* deletion, addition, mode change and renames are all interesting. */
+	/* deletion, addition, mode or type change
+	 * and rename are all interesting.
+	 */
 	if (DIFF_FILE_VALID(one) != DIFF_FILE_VALID(two) ||
-	    (one->mode != two->mode) ||
+	    DIFF_PAIR_MODE_CHANGED(p) ||
 	    strcmp(one->path, two->path))
 		return 0;
 
@@ -608,9 +634,9 @@ static void diff_flush_patch(struct diff
 	}
 
 	if (DIFF_PAIR_UNMERGED(p))
-		run_external_diff(name, NULL, NULL, NULL, NULL);
+		run_diff(name, NULL, NULL, NULL, NULL);
 	else
-		run_external_diff(name, other, p->one, p->two, msg);
+		run_diff(name, other, p->one, p->two, msg);
 }
 
 int diff_needs_to_stay(struct diff_queue_struct *q, int i,
@@ -775,7 +801,8 @@ void diff_flush(int diff_output_style, i
 
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
-		if (p->status == 'X')
+		if ((diff_output_style == DIFF_FORMAT_NO_OUTPUT) ||
+		    (p->status == 'X'))
 			continue;
 		if (p->status == 0)
 			die("internal error in diff-resolve-rename-copy");
diff --git a/diffcore.h b/diffcore.h
--- a/diffcore.h
+++ b/diffcore.h
@@ -48,6 +48,12 @@ struct diff_filepair {
 #define DIFF_PAIR_TYPE_CHANGED(p) \
 	((S_IFMT & (p)->one->mode) != (S_IFMT & (p)->two->mode))
 
+#define DIFF_PAIR_MODE_CHANGED(p) ((p)->one->mode != (p)->two->mode)
+
+#define DIFF_FILE_CANON_MODE(mode) \
+	(S_ISREG(mode) ? (S_IFREG | ce_permissions(mode)) : \
+	S_ISLNK(mode) ? S_IFLNK : S_IFDIR)
+
 extern int diff_unmodified_pair(struct diff_filepair *);
 
 struct diff_queue_struct {
------------------------------------------------

