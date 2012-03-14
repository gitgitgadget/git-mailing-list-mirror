From: Johan Herland <johan@herland.net>
Subject: [PATCH 3/2] notes-merge: Don't remove .git/NOTES_MERGE_WORKTREE; it
 may be the user's cwd
Date: Thu, 15 Mar 2012 00:55:33 +0100
Message-ID: <1331769333-13890-1-git-send-email-johan@herland.net>
References: <7vlin3qdpt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Johan Herland <johan@herland.net>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	david@tethera.net, pclouds@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 15 00:56:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7y39-0000PN-WA
	for gcvg-git-2@plane.gmane.org; Thu, 15 Mar 2012 00:56:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031157Ab2CNX4I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Mar 2012 19:56:08 -0400
Received: from smtp.getmail.no ([84.208.15.66]:52379 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760795Ab2CNX4E (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2012 19:56:04 -0400
Received: from get-mta-scan01.get.basefarm.net ([10.5.16.4])
 by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0M0W00G6UFTELAA0@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Thu, 15 Mar 2012 00:56:02 +0100 (MET)
Received: from get-mta-scan01.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 663131798FB3_F613012B	for <git@vger.kernel.org>; Wed,
 14 Mar 2012 23:56:02 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan01.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id E168A1796361_F613011F	for <git@vger.kernel.org>; Wed,
 14 Mar 2012 23:56:01 +0000 (GMT)
Received: from alpha.herland ([84.208.177.71]) by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0M0W00C79FTD1V20@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Thu, 15 Mar 2012 00:56:01 +0100 (MET)
X-Mailer: git-send-email 1.7.10.rc0.43.g35011
In-reply-to: <7vlin3qdpt.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193170>

When a manual notes merge is committed or aborted, we need to remove the
temporary worktree at .git/NOTES_MERGE_WORKTREE. However, removing the
entire directory is not good if the user ran the 'git notes merge
--commit/--abort' from within that directory. On Windows, the directory
removal would simply fail, while on POSIX systems, users would suddenly
find themselves in an invalid current directory.

Therefore, instead of deleting the entire directory, we delete everything
_within_ the directory, and leave the (empty) directory in place.

This would cause a subsequent notes merge to abort, complaining about a
previous - unfinished - notes merge (due to the presence of
.git/NOTES_MERGE_WORKTREE), so we also need to adjust this check to only
trigger when .git/NOTES_MERGE_WORKTREE is non-empty.

Finally, adjust the t3310 manual notes merge testcases to correctly handle
the existence of an empty .git/NOTES_MERGE_WORKTREE directory.

Inspired-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Johan Herland <johan@herland.net>
---

How about this solution? I believe it should solve all the cases.

I'm torn about the new remove_everything_inside_dir(). Obviously it's a
copy-paste-modify of dir.c:remove_dir_recursively(), and could instead be
implemented by adding an extra flag to remove_dir_recursively(). However,
adding a "#define REMOVE_DIR_CONTENTS_BUT_NOT_DIR_ITSELF 04" seemed even
uglier to me...

What do you think?


...Johan


 notes-merge.c                         |   52 ++++++++++++++++++++++++++++++---
 t/t3310-notes-merge-manual-resolve.sh |    8 ++---
 2 files changed, 52 insertions(+), 8 deletions(-)

diff --git a/notes-merge.c b/notes-merge.c
index 3a16af2..bf080fb 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -267,7 +267,8 @@ static void check_notes_merge_worktree(struct notes_merge_options *o)
 		 * Must establish NOTES_MERGE_WORKTREE.
 		 * Abort if NOTES_MERGE_WORKTREE already exists
 		 */
-		if (file_exists(git_path(NOTES_MERGE_WORKTREE))) {
+		if (file_exists(git_path(NOTES_MERGE_WORKTREE)) &&
+		    !is_empty_dir(git_path(NOTES_MERGE_WORKTREE))) {
 			if (advice_resolve_conflict)
 				die("You have not concluded your previous "
 				    "notes merge (%s exists).\nPlease, use "
@@ -754,16 +755,59 @@ int notes_merge_commit(struct notes_merge_options *o,
 	return 0;
 }
 
+/* Based on dir.c:remove_dir_recursively() */
+static int remove_everything_inside_dir(struct strbuf *path)
+{
+	DIR *dir;
+	struct dirent *e;
+	int ret = 0, original_len = path->len, len;
+
+	dir = opendir(path->buf);
+	if (!dir)
+		return -1;
+	if (path->buf[original_len - 1] != '/')
+		strbuf_addch(path, '/');
+
+	len = path->len;
+	while ((e = readdir(dir)) != NULL) {
+		struct stat st;
+		if (is_dot_or_dotdot(e->d_name))
+			continue;
+
+		strbuf_setlen(path, len);
+		strbuf_addstr(path, e->d_name);
+		if (lstat(path->buf, &st))
+			; /* fall thru */
+		else if (S_ISDIR(st.st_mode)) {
+			if (!remove_dir_recursively(path, 0))
+				continue; /* happy */
+		} else if (!unlink(path->buf))
+			continue; /* happy, too */
+
+		/* path too long, stat fails, or non-directory still exists */
+		ret = -1;
+		break;
+	}
+	closedir(dir);
+
+	strbuf_setlen(path, original_len);
+	return ret;
+}
+
 int notes_merge_abort(struct notes_merge_options *o)
 {
-	/* Remove .git/NOTES_MERGE_WORKTREE directory and all files within */
+	/*
+	 * Remove all files within .git/NOTES_MERGE_WORKTREE. We do not remove
+	 * the .git/NOTES_MERGE_WORKTREE directory itself, since it might be
+	 * the current working directory of the user.
+	 */
 	struct strbuf buf = STRBUF_INIT;
 	int ret;
 
 	strbuf_addstr(&buf, git_path(NOTES_MERGE_WORKTREE));
 	if (o->verbosity >= 3)
-		printf("Removing notes merge worktree at %s\n", buf.buf);
-	ret = remove_dir_recursively(&buf, 0);
+		printf("Removing notes merge worktree at %s/*\n", buf.buf);
+	ret = remove_everything_inside_dir(&buf);
 	strbuf_release(&buf);
 	return ret;
 }
diff --git a/t/t3310-notes-merge-manual-resolve.sh b/t/t3310-notes-merge-manual-resolve.sh
index d6d6ac6..195bb97 100755
--- a/t/t3310-notes-merge-manual-resolve.sh
+++ b/t/t3310-notes-merge-manual-resolve.sh
@@ -324,7 +324,7 @@ y and z notes on 4th commit
 EOF
 	git notes merge --commit &&
 	# No .git/NOTES_MERGE_* files left
-	test_must_fail ls .git/NOTES_MERGE_* >output 2>/dev/null &&
+	test_might_fail ls .git/NOTES_MERGE_* >output 2>/dev/null &&
 	test_cmp /dev/null output &&
 	# Merge commit has pre-merge y and pre-merge z as parents
 	test "$(git rev-parse refs/notes/m^1)" = "$(cat pre_merge_y)" &&
@@ -386,7 +386,7 @@ test_expect_success 'redo merge of z into m (== y) with default ("manual") resol
 test_expect_success 'abort notes merge' '
 	git notes merge --abort &&
 	# No .git/NOTES_MERGE_* files left
-	test_must_fail ls .git/NOTES_MERGE_* >output 2>/dev/null &&
+	test_might_fail ls .git/NOTES_MERGE_* >output 2>/dev/null &&
 	test_cmp /dev/null output &&
 	# m has not moved (still == y)
 	test "$(git rev-parse refs/notes/m)" = "$(cat pre_merge_y)" &&
@@ -453,7 +453,7 @@ EOF
 	# Finalize merge
 	git notes merge --commit &&
 	# No .git/NOTES_MERGE_* files left
-	test_must_fail ls .git/NOTES_MERGE_* >output 2>/dev/null &&
+	test_might_fail ls .git/NOTES_MERGE_* >output 2>/dev/null &&
 	test_cmp /dev/null output &&
 	# Merge commit has pre-merge y and pre-merge z as parents
 	test "$(git rev-parse refs/notes/m^1)" = "$(cat pre_merge_y)" &&
@@ -542,7 +542,7 @@ EOF
 test_expect_success 'resolve situation by aborting the notes merge' '
 	git notes merge --abort &&
 	# No .git/NOTES_MERGE_* files left
-	test_must_fail ls .git/NOTES_MERGE_* >output 2>/dev/null &&
+	test_might_fail ls .git/NOTES_MERGE_* >output 2>/dev/null &&
 	test_cmp /dev/null output &&
 	# m has not moved (still == w)
 	test "$(git rev-parse refs/notes/m)" = "$(git rev-parse refs/notes/w)" &&
-- 
1.7.10.rc0.43.g35011
