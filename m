From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Detached HEAD (experimental)
Date: Mon, 01 Jan 2007 23:45:08 -0800
Message-ID: <7vac11yirf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Jan 02 08:45:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1eKn-0006er-VR
	for gcvg-git@gmane.org; Tue, 02 Jan 2007 08:45:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932957AbXABHpO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 Jan 2007 02:45:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932959AbXABHpO
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jan 2007 02:45:14 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:46739 "EHLO
	fed1rmmtao09.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932957AbXABHpM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jan 2007 02:45:12 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070102074510.PPEA18767.fed1rmmtao09.cox.net@fed1rmimpo01.cox.net>;
          Tue, 2 Jan 2007 02:45:10 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 67kN1W00o1kojtg0000000; Tue, 02 Jan 2007 02:44:24 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35777>

This allows "git checkout -d v1.4.3" to detach the HEAD from any
branch but point directly at the named commit.  After this, "git
branch" starts reporting that you are not on any branch.  You
can merge into "current branch" although there is not even such
a thing.

You can go back the normal state by switching to an existing
branch, say, "git checkout master" for example.  Another way to
get out of this is "git checkout -b newbranch".

This is still experimental.  While I think it makes sense to
allow commits on top of detached HEAD, it is rather dangerous
unless you are careful and know what you are doing.  Next "git
checkout master" will obviously lose what you have done, so we
might want to require "git checkout -f" out of a detached HEAD
if we find that the HEAD commit is not an ancestor of any other
branches.

On the other hand, the reason the user did not start the ad-hoc
work on a new branch with "git checkout -b" was probably because
the work was of a throw-away nature, so the convenience of not
having that safety valve might be even better.  We'll see.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 builtin-branch.c |   36 ++++++++++++++++++++++++++----------
 cache.h          |    2 +-
 git-checkout.sh  |   22 +++++++++++++++++++---
 path.c           |   26 ++++++++++++++++++--------
 setup.c          |    5 +++--
 5 files changed, 67 insertions(+), 24 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index 745ee04..71f88f2 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -299,7 +299,8 @@ static void print_ref_list(int kinds, int verbose, int abbrev)
 	free_ref_list(&ref_list);
 }
 
-static void create_branch(const char *name, const char *start,
+static void create_branch(const char *name, const char *start_name,
+			  unsigned char *start_sha1,
 			  int force, int reflog)
 {
 	struct ref_lock *lock;
@@ -318,9 +319,14 @@ static void create_branch(const char *name, const char *start,
 			die("Cannot force update the current branch.");
 	}
 
-	if (get_sha1(start, sha1) ||
-	    (commit = lookup_commit_reference(sha1)) == NULL)
-		die("Not a valid branch point: '%s'.", start);
+	if (start_sha1)
+		/* detached HEAD */
+		hashcpy(sha1, start_sha1);
+	else if (get_sha1(start_name, sha1))
+		die("Not a valid object name: '%s'.", start_name);
+
+	if ((commit = lookup_commit_reference(sha1)) == NULL)
+		die("Not a valid branch point: '%s'.", start_name);
 	hashcpy(sha1, commit->object.sha1);
 
 	lock = lock_any_ref_for_update(ref, NULL);
@@ -329,7 +335,8 @@ static void create_branch(const char *name, const char *start,
 
 	if (reflog) {
 		log_all_ref_updates = 1;
-		snprintf(msg, sizeof msg, "branch: Created from %s", start);
+		snprintf(msg, sizeof msg, "branch: Created from %s",
+			 start_name);
 	}
 
 	if (write_ref_sha1(lock, sha1, msg) < 0)
@@ -341,6 +348,9 @@ static void rename_branch(const char *oldname, const char *newname, int force)
 	char oldref[PATH_MAX], newref[PATH_MAX], logmsg[PATH_MAX*2 + 100];
 	unsigned char sha1[20];
 
+	if (!oldname)
+		die("cannot rename the curren branch while not on any.");
+
 	if (snprintf(oldref, sizeof(oldref), "refs/heads/%s", oldname) > sizeof(oldref))
 		die("Old branchname too long");
 
@@ -447,9 +457,15 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	head = xstrdup(resolve_ref("HEAD", head_sha1, 0, NULL));
 	if (!head)
 		die("Failed to resolve HEAD as a valid ref.");
-	if (strncmp(head, "refs/heads/", 11))
-		die("HEAD not found below refs/heads!");
-	head += 11;
+	if (!strcmp(head, "HEAD")) {
+		/* detached HEAD */
+		;
+	}
+	else {
+		if (strncmp(head, "refs/heads/", 11))
+			die("HEAD not found below refs/heads!");
+		head += 11;
+	}
 
 	if (delete)
 		return delete_branches(argc - i, argv + i, force_delete, kinds);
@@ -460,9 +476,9 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	else if (rename && (i == argc - 2))
 		rename_branch(argv[i], argv[i + 1], force_rename);
 	else if (i == argc - 1)
-		create_branch(argv[i], head, force_create, reflog);
+		create_branch(argv[i], head, head_sha1, force_create, reflog);
 	else if (i == argc - 2)
-		create_branch(argv[i], argv[i + 1], force_create, reflog);
+		create_branch(argv[i], argv[i+1], NULL, force_create, reflog);
 	else
 		usage(builtin_branch_usage);
 
diff --git a/cache.h b/cache.h
index 29dd290..891045c 100644
--- a/cache.h
+++ b/cache.h
@@ -296,7 +296,7 @@ extern char *sha1_to_hex(const unsigned char *sha1);	/* static buffer result! */
 extern int read_ref(const char *filename, unsigned char *sha1);
 extern const char *resolve_ref(const char *path, unsigned char *sha1, int, int *);
 extern int create_symref(const char *ref, const char *refs_heads_master);
-extern int validate_symref(const char *ref);
+extern int validate_headref(const char *ref);
 
 extern int base_name_compare(const char *name1, int len1, int mode1, const char *name2, int len2, int mode2);
 extern int cache_name_compare(const char *name1, int len1, const char *name2, int len2);
diff --git a/git-checkout.sh b/git-checkout.sh
index 92ec069..c50df28 100755
--- a/git-checkout.sh
+++ b/git-checkout.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-USAGE='[-f] [-b <new_branch>] [-m] [<branch>] [<paths>...]'
+USAGE='[-f] [-b <new_branch>] [-d] [-m] [<branch>] [<paths>...]'
 SUBDIRECTORY_OK=Sometimes
 . git-sh-setup
 
@@ -12,6 +12,7 @@ force=
 branch=
 newbranch=
 newbranch_log=
+detached=
 merge=
 while [ "$#" != "0" ]; do
     arg="$1"
@@ -27,6 +28,9 @@ while [ "$#" != "0" ]; do
 		git-check-ref-format "heads/$newbranch" ||
 			die "git checkout: we do not like '$newbranch' as a branch name."
 		;;
+	-d)
+		detached=1
+		;;
 	"-l")
 		newbranch_log=1
 		;;
@@ -144,13 +148,25 @@ fi
 # are switching to, then we'd better just be checking out
 # what we already had
 
-[ -z "$branch$newbranch" ] &&
-	[ "$new" != "$old" ] &&
+if test -z "$branch$newbranch" && test "$new" != "$old"
+then
+	case "$detached" in
+	'')
 	die "git checkout: provided reference cannot be checked out directly
 
   You need -b to associate a new branch with the wanted checkout. Example:
   git checkout -b <new_branch_name> $arg
 "
+		;;
+	1)
+		# NEEDSWORK: we would want to have this command here
+		# that allows us to detach the HEAD atomically.
+		# git update-ref --detach HEAD "$new"
+		rm -f "$GIT_DIR/HEAD"
+		echo "$new" >"$GIT_DIR/HEAD"
+		;;
+	esac
+fi
 
 if [ "X$old" = X ]
 then
diff --git a/path.c b/path.c
index 066f621..94ddd7e 100644
--- a/path.c
+++ b/path.c
@@ -90,10 +90,11 @@ int git_mkstemp(char *path, size_t len, const char *template)
 }
 
 
-int validate_symref(const char *path)
+int validate_headref(const char *path)
 {
 	struct stat st;
 	char *buf, buffer[256];
+	unsigned char sha1[20];
 	int len, fd;
 
 	if (lstat(path, &st) < 0)
@@ -119,14 +120,23 @@ int validate_symref(const char *path)
 	/*
 	 * Is it a symbolic ref?
 	 */
-	if (len < 4 || memcmp("ref:", buffer, 4))
+	if (len < 4)
 		return -1;
-	buf = buffer + 4;
-	len -= 4;
-	while (len && isspace(*buf))
-		buf++, len--;
-	if (len >= 5 && !memcmp("refs/", buf, 5))
+	if (!memcmp("ref:", buffer, 4)) {
+		buf = buffer + 4;
+		len -= 4;
+		while (len && isspace(*buf))
+			buf++, len--;
+		if (len >= 5 && !memcmp("refs/", buf, 5))
+			return 0;
+	}
+
+	/*
+	 * Is this a detached HEAD?
+	 */
+	if (!get_sha1_hex(buffer, sha1))
 		return 0;
+
 	return -1;
 }
 
@@ -241,7 +251,7 @@ char *enter_repo(char *path, int strict)
 		return NULL;
 
 	if (access("objects", X_OK) == 0 && access("refs", X_OK) == 0 &&
-	    validate_symref("HEAD") == 0) {
+	    validate_headref("HEAD") == 0) {
 		putenv("GIT_DIR=.");
 		check_repository_format();
 		return path;
diff --git a/setup.c b/setup.c
index 2ae57f7..cc97f9f 100644
--- a/setup.c
+++ b/setup.c
@@ -138,7 +138,8 @@ const char **get_pathspec(const char *prefix, const char **pathspec)
  *    GIT_OBJECT_DIRECTORY environment variable
  *  - a refs/ directory
  *  - either a HEAD symlink or a HEAD file that is formatted as
- *    a proper "ref:".
+ *    a proper "ref:", or a regular file HEAD that has a properly
+ *    formatted sha1 object name.
  */
 static int is_git_directory(const char *suspect)
 {
@@ -161,7 +162,7 @@ static int is_git_directory(const char *suspect)
 		return 0;
 
 	strcpy(path + len, "/HEAD");
-	if (validate_symref(path))
+	if (validate_headref(path))
 		return 0;
 
 	return 1;
-- 
1.5.0.rc0.gab5a
