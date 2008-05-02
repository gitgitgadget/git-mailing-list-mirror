From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH 3/4] Fix diff regression for submodules not checked out
Date: Fri,  2 May 2008 21:35:35 +0800
Message-ID: <1209735336-4690-4-git-send-email-pkufranky@gmail.com>
References: <46dff0320804300856w941d948rbcc1cee06f1b41a9@mail.gmail.com>
 <1209735336-4690-1-git-send-email-pkufranky@gmail.com>
 <1209735336-4690-2-git-send-email-pkufranky@gmail.com>
 <1209735336-4690-3-git-send-email-pkufranky@gmail.com>
Cc: gitster@pobox.com, Ping Yin <pkufranky@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 02 15:37:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrvRb-0003lU-VQ
	for gcvg-git-2@gmane.org; Fri, 02 May 2008 15:37:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935141AbYEBNfq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2008 09:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933914AbYEBNfp
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 09:35:45 -0400
Received: from mail.qikoo.org ([60.28.205.235]:57907 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S935075AbYEBNfn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2008 09:35:43 -0400
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id C57E0470AF; Fri,  2 May 2008 21:35:36 +0800 (CST)
X-Mailer: git-send-email 1.5.5.1.116.ge4b9c.dirty
In-Reply-To: <1209735336-4690-3-git-send-email-pkufranky@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80991>

This regression is introduced by f58dbf23c3, which calls
check_work_tree_entity in run_diff_files. While check_work_tree_entity
treats submodule not checked out as non stagable which causes that
diff-files shows these submodules as deleted.

check_work_tree_entity considers a worktree entity having two statuses:
stagable and inexistent. Actually, there is a 3rd status: a submodule
entity can be existent but not stagable (for example, empty directory for
non-checked-out submodule)

This patch redesigns the return value of check_work_tree_entity to
consider both the 3 statuses.

Signed-off-by: Ping Yin <pkufranky@gmail.com>
---
 diff-lib.c |   22 +++++++++++++---------
 1 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index cfd629d..72c2a7b 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -337,25 +337,29 @@ int run_diff_files_cmd(struct rev_info *revs, int argc, const char **argv)
 	}
 	return run_diff_files(revs, options);
 }
+
+#define ENT_STAGABLE 1
+#define ENT_INEXISTENT 2
+#define ENT_NOTGITDIR 3		/* Existent but not stagable (not a git dir) */
 /*
- * See if work tree has an entity that can be staged.  Return 0 if so,
- * return 1 if not and return -1 if error.
+ * Check the status of a work tree entity
+ * Return ENT_{STAGABLE,INEXISTENT,NOTGITDIR} or -1 if error
  */
 static int check_work_tree_entity(const struct cache_entry *ce, struct stat *st, char *symcache)
 {
 	if (lstat(ce->name, st) < 0) {
 		if (errno != ENOENT && errno != ENOTDIR)
 			return -1;
-		return 1;
+		return ENT_INEXISTENT;
 	}
 	if (has_symlink_leading_path(ce->name, symcache))
-		return 1;
+		return ENT_INEXISTENT;
 	if (S_ISDIR(st->st_mode)) {
 		unsigned char sub[20];
 		if (resolve_gitlink_ref(ce->name, "HEAD", sub))
-			return 1;
+			return ENT_NOTGITDIR;
 	}
-	return 0;
+	return ENT_STAGABLE;
 }
 
 int run_diff_files(struct rev_info *revs, unsigned int option)
@@ -403,7 +407,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 			       sizeof(struct combine_diff_parent)*5);
 
 			changed = check_work_tree_entity(ce, &st, symcache);
-			if (!changed)
+			if (changed != ENT_INEXISTENT)
 				dpath->mode = ce_mode_from_stat(ce, st.st_mode);
 			else {
 				if (changed < 0) {
@@ -467,7 +471,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 			continue;
 
 		changed = check_work_tree_entity(ce, &st, symcache);
-		if (changed) {
+		if (changed == ENT_INEXISTENT) {
 			if (changed < 0) {
 				perror(ce->name);
 				continue;
@@ -527,7 +531,7 @@ static int get_stat_data(struct cache_entry *ce,
 		changed = check_work_tree_entity(ce, &st, cbdata->symcache);
 		if (changed < 0)
 			return -1;
-		else if (changed) {
+		else if (changed == ENT_INEXISTENT) {
 			if (match_missing) {
 				*sha1p = sha1;
 				*modep = mode;
-- 
1.5.5.1.116.ge4b9c.dirty
