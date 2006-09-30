From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/2] ref locking: allow 'foo' when 'foo/bar' used to exist but not anymore.
Date: Sat, 30 Sep 2006 12:49:00 -0700
Message-ID: <7vsli9cez7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Sep 30 21:49:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GTkpn-0004z3-AG
	for gcvg-git@gmane.org; Sat, 30 Sep 2006 21:49:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751785AbWI3TtF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Sep 2006 15:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751798AbWI3TtF
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Sep 2006 15:49:05 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:39389 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751785AbWI3TtB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Sep 2006 15:49:01 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060930194901.WTNJ26416.fed1rmmtao12.cox.net@fed1rmimpo02.cox.net>;
          Sat, 30 Sep 2006 15:49:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Ujp31V00D1kojtg0000000
	Sat, 30 Sep 2006 15:49:03 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28148>

It is normal to have .git/refs/heads/foo directory which is
empty after the last branch whose name starts with foo/ is
removed.  Make sure we notice this case and allow creation of
branch foo by removing the empty directory.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * Recent git-branch in "next" does the moral equivalent of this
   itself, but other users of git-update-ref would not be helped
   without something like this.

   We would need to do the same for $GIT_DIR/logs/ but that is
   for a later round.  I want to get the deletion of packed refs
   right first but before doing that the code needs some more
   clean-ups.

 refs.c |   64 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 64 insertions(+), 0 deletions(-)

diff --git a/refs.c b/refs.c
index 3d4cdd1..b433c0c 100644
--- a/refs.c
+++ b/refs.c
@@ -473,6 +473,59 @@ static struct ref_lock *verify_lock(stru
 	return lock;
 }
 
+static int remove_empty_dir_recursive(char *path, int len)
+{
+	DIR *dir = opendir(path);
+	struct dirent *e;
+	int ret = 0;
+
+	if (!dir)
+		return -1;
+	if (path[len-1] != '/')
+		path[len++] = '/';
+	while ((e = readdir(dir)) != NULL) {
+		struct stat st;
+		int namlen;
+		if ((e->d_name[0] == '.') &&
+		    ((e->d_name[1] == 0) ||
+		     ((e->d_name[1] == '.') && e->d_name[2] == 0)))
+			continue; /* "." and ".." */
+
+		namlen = strlen(e->d_name);
+		if ((len + namlen < PATH_MAX) &&
+		    strcpy(path + len, e->d_name) &&
+		    !lstat(path, &st) &&
+		    S_ISDIR(st.st_mode) &&
+		    remove_empty_dir_recursive(path, len + namlen))
+			continue; /* happy */
+
+		/* path too long, stat fails, or non-directory still exists */
+		ret = -1;
+		break;
+	}
+	closedir(dir);
+	if (!ret) {
+		path[len] = 0;
+		ret = rmdir(path);
+	}
+	return ret;
+}
+
+static int remove_empty_directories(char *file)
+{
+	/* we want to create a file but there is a directory there;
+	 * if that is an empty directory (or a directory that contains
+	 * only empty directories), remove them.
+	 */
+	char path[PATH_MAX];
+	int len = strlen(file);
+
+	if (len >= PATH_MAX) /* path too long ;-) */
+		return -1;
+	strcpy(path, file);
+	return remove_empty_dir_recursive(path, len);
+}
+
 static struct ref_lock *lock_ref_sha1_basic(const char *ref, const unsigned char *old_sha1)
 {
 	char *ref_file;
@@ -485,6 +538,17 @@ static struct ref_lock *lock_ref_sha1_ba
 	lock->lock_fd = -1;
 
 	ref = resolve_ref(ref, lock->old_sha1, mustexist, NULL);
+	if (!ref && errno == EISDIR) {
+		/* we are trying to lock foo but we used to
+		 * have foo/bar which now does not exist;
+		 * it is normal for the empty directory 'foo'
+		 * to remain.
+		 */
+		ref_file = git_path("%s", orig_ref);
+		if (remove_empty_directories(ref_file))
+			die("there are still refs under '%s'", orig_ref);
+		ref = resolve_ref(orig_ref, lock->old_sha1, mustexist, NULL);
+	}
 	if (!ref) {
 		int last_errno = errno;
 		error("unable to resolve reference %s: %s",
-- 
1.4.2.1.g5a98f
