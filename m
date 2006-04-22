From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Libified diff-index: backward compatibility fix.
Date: Sat, 22 Apr 2006 04:04:25 -0700
Message-ID: <7vbqutkh1i.fsf@assigned-by-dhcp.cox.net>
References: <7v64l1lxwj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: torvalds@osdl.org
X-From: git-owner@vger.kernel.org Sat Apr 22 22:34:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FXOoQ-00039C-AH
	for gcvg-git@gmane.org; Sat, 22 Apr 2006 22:34:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbWDVUef (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 22 Apr 2006 16:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbWDVUef
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Apr 2006 16:34:35 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:46799 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751162AbWDVUee (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 Apr 2006 16:34:34 -0400
Received: from fed1rmmtao01.cox.net (fed1rmmtao01.cox.net [68.230.241.38])
	by zeus1.kernel.org (8.13.1/8.13.1) with ESMTP id k3MB5YvB005054
	for <git@vger.kernel.org>; Sat, 22 Apr 2006 11:05:35 GMT
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060422110429.JPQS24981.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 22 Apr 2006 07:04:29 -0400
To: git@vger.kernel.org
In-Reply-To: <7v64l1lxwj.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 22 Apr 2006 03:14:52 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
X-Virus-Scanned: ClamAV 0.88/1414/Fri Apr 21 22:58:39 2006 on zeus1.kernel.org
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19053>

"diff-index -m" does not mean "do not ignore merges", but means
"pretend missing files match the index".

The previous round tried to address this, but failed because
setup_revisions() ate "-m" flag before the caller had a chance
to intervene.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 diff-index.c |    6 ++----
 diff-lib.c   |   10 +++++++++-
 diff.h       |    2 +-
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/diff-index.c b/diff-index.c
index 4a243b3..8694012 100644
--- a/diff-index.c
+++ b/diff-index.c
@@ -23,9 +23,7 @@ int main(int argc, const char **argv)
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
 			
-		if (!strcmp(arg, "-m"))
-			match_missing = 1; 
-		else if (!strcmp(arg, "--cached"))
+		if (!strcmp(arg, "--cached"))
 			cached = 1;
 		else
 			usage(diff_cache_usage);
@@ -37,5 +35,5 @@ int main(int argc, const char **argv)
 	if (!rev.pending_objects || rev.pending_objects->next ||
 	    rev.max_count != -1 || rev.min_age != -1 || rev.max_age != -1)
 		usage(diff_cache_usage);
-	return run_diff_index(&rev, cached, match_missing);
+	return run_diff_index(&rev, cached);
 }
diff --git a/diff-lib.c b/diff-lib.c
index 63da3b5..2183b41 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -308,12 +308,20 @@ static void mark_merge_entries(void)
 	}
 }
 
-int run_diff_index(struct rev_info *revs, int cached, int match_missing)
+int run_diff_index(struct rev_info *revs, int cached)
 {
 	int ret;
 	struct object *ent;
 	struct tree *tree;
 	const char *tree_name;
+	int match_missing = 0;
+
+	/* 
+	 * Backward compatibility wart - "diff-index -m" does
+	 * not mean "do not ignore merges", but totally different.
+	 */
+	if (!revs->ignore_merges)
+		match_missing = 1;
 
 	if (read_cache() < 0) {
 		perror("read_cache");
diff --git a/diff.h b/diff.h
index 837d449..7150b90 100644
--- a/diff.h
+++ b/diff.h
@@ -171,6 +171,6 @@ extern const char *diff_unique_abbrev(co
 
 extern int run_diff_files(struct rev_info *revs, int silent_on_removed);
 
-extern int run_diff_index(struct rev_info *revs, int cached, int match_missing);
+extern int run_diff_index(struct rev_info *revs, int cached);
 
 #endif /* DIFF_H */
-- 
1.3.0.g0bc6
