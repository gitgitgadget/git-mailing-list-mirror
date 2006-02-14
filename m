From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] combine-diff: diff-files fix.
Date: Mon, 13 Feb 2006 23:53:07 -0800
Message-ID: <7virritlzw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Feb 14 08:53:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8v0C-0001U2-AN
	for gcvg-git@gmane.org; Tue, 14 Feb 2006 08:53:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030401AbWBNHxL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Feb 2006 02:53:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030408AbWBNHxK
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Feb 2006 02:53:10 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:18345 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1030401AbWBNHxJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2006 02:53:09 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060214075201.FOLD3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 14 Feb 2006 02:52:01 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16128>

When showing a conflicted merge from index stages and working
tree file, we did not fetch the mode from the working tree,
and mistook that as a deleted file.  Also if the manual
resolution (or automated resolution by git rerere) ended up
taking either parent's version, we did not show _anything_ for
that path.  Either was quite bad and confusing.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---
 * This will be part of 1.2.1 maintenance series.

 combine-diff.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

713a11fceb662f275b5e1294acc6f38674834941
diff --git a/combine-diff.c b/combine-diff.c
index a38f01b..d812600 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -630,9 +630,10 @@ static int show_patch_diff(struct combin
 	int i, show_hunks, shown_header = 0;
 	char ourtmp_buf[TMPPATHLEN];
 	char *ourtmp = ourtmp_buf;
+	int working_tree_file = !memcmp(elem->sha1, null_sha1, 20);
 
 	/* Read the result of merge first */
-	if (memcmp(elem->sha1, null_sha1, 20)) {
+	if (!working_tree_file) {
 		result = grab_blob(elem->sha1, &size);
 		write_to_temp_file(ourtmp, result, size);
 	}
@@ -646,6 +647,7 @@ static int show_patch_diff(struct combin
 			int len = st.st_size;
 			int cnt = 0;
 
+			elem->mode = DIFF_FILE_CANON_MODE(st.st_mode);
 			size = len;
 			result = xmalloc(len + 1);
 			while (cnt < len) {
@@ -661,6 +663,7 @@ static int show_patch_diff(struct combin
 		else {
 			/* deleted file */
 			size = 0;
+			elem->mode = 0;
 			result = xmalloc(1);
 			result[0] = 0;
 			ourtmp = "/dev/null";
@@ -716,7 +719,7 @@ static int show_patch_diff(struct combin
 
 	show_hunks = make_hunks(sline, cnt, num_parent, dense);
 
-	if (show_hunks || mode_differs) {
+	if (show_hunks || mode_differs || working_tree_file) {
 		const char *abb;
 
 		if (header) {
@@ -731,8 +734,6 @@ static int show_patch_diff(struct combin
 		putchar('\n');
 		printf("index ");
 		for (i = 0; i < num_parent; i++) {
-			if (elem->parent[i].mode != elem->mode)
-				mode_differs = 1;
 			abb = find_unique_abbrev(elem->parent[i].sha1,
 						 DEFAULT_ABBREV);
 			printf("%s%s", i ? "," : "", abb);
-- 
1.2.0.g45dc
