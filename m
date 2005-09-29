From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Add git-symbolic-ref
Date: Wed, 28 Sep 2005 21:24:08 -0700
Message-ID: <7vek78pklz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Sep 29 06:25:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKpxx-00015d-68
	for gcvg-git@gmane.org; Thu, 29 Sep 2005 06:24:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175AbVI2EYM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Sep 2005 00:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751180AbVI2EYM
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Sep 2005 00:24:12 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:35214 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751175AbVI2EYM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Sep 2005 00:24:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050929042410.SYDB9260.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 29 Sep 2005 00:24:10 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9456>

This adds the counterpart of git-update-ref that lets you read
and create "symbolic refs".  By default it uses a symbolic link
to represent ".git/HEAD -> refs/heads/master", but it can be
compiled to use the textfile symbolic ref.  In that case, the
.git/HEAD file would typically read "ref: refs/heads/master".

The places that did 'readlink .git/HEAD' and 'ln -s
refs/heads/blah .git/HEAD' have been converted to use new
git-symbolic-ref command, so that they can deal with either
implementation.

I suspect that I ended up wasting my git day of this week
working on this, given that Cygwin seems to be capable of
emulating symlinks using .lnk files.  On the other hand, even
Linux folks may be on vfat or similar fs that does not have
symlinks so who knows.  On yet another hand, a project can have
symlinks stored in the repository, and in order to check things
out the filesystem needs to have symlinks anyway, so maybe this
is a big wasted effort.  Mumble mumble mumble...

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 Makefile             |    2 +-
 cache.h              |    1 +
 fsck-objects.c       |   28 ++++++++++------------------
 git-bisect.sh        |    7 ++++---
 git-branch.sh        |    6 ++++--
 git-checkout.sh      |    3 ++-
 git-commit.sh        |   17 ++++++++---------
 git-sh-setup.sh      |    4 ++--
 git-status.sh        |    4 ++--
 init-db.c            |   10 +++++-----
 refs.c               |   46 ++++++++++++++++++++++++++++++++++++++++++++--
 setup.c              |   16 ++++++++++------
 show-branch.c        |   13 +++++++++----
 symbolic-ref.c       |   34 ++++++++++++++++++++++++++++++++++
 t/t5400-send-pack.sh |    6 +++---
 15 files changed, 139 insertions(+), 58 deletions(-)
 create mode 100644 symbolic-ref.c

15de68abcb00ede12ac4b67c3f0ecac7cfffd0b4
diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -116,7 +116,7 @@ PROGRAMS = \
 	git-ssh-upload git-tar-tree git-unpack-file \
 	git-unpack-objects git-update-index git-update-server-info \
 	git-upload-pack git-verify-pack git-write-tree \
-	git-update-ref \
+	git-update-ref git-symbolic-ref \
 	$(SIMPLE_PROGRAMS)
 
 # Backward compatibility -- to be removed in 0.99.8
diff --git a/cache.h b/cache.h
--- a/cache.h
+++ b/cache.h
@@ -231,6 +231,7 @@ extern int get_sha1_hex(const char *hex,
 extern char *sha1_to_hex(const unsigned char *sha1);	/* static buffer result! */
 extern int read_ref(const char *filename, unsigned char *sha1);
 extern const char *resolve_ref(const char *path, unsigned char *sha1);
+extern int create_symref(const char *git_HEAD, const char *refs_heads_master);
 
 /* General helper functions */
 extern void usage(const char *err) NORETURN;
diff --git a/fsck-objects.c b/fsck-objects.c
--- a/fsck-objects.c
+++ b/fsck-objects.c
@@ -402,25 +402,17 @@ static void fsck_object_dir(const char *
 
 static int fsck_head_link(void)
 {
-	int fd, count;
-	char hex[40];
 	unsigned char sha1[20];
-	static char path[PATH_MAX], link[PATH_MAX];
-	const char *git_dir = get_git_dir();
-
-	snprintf(path, sizeof(path), "%s/HEAD", git_dir);
-	if (readlink(path, link, sizeof(link)) < 0)
-		return error("HEAD is not a symlink");
-	if (strncmp("refs/heads/", link, 11))
-		return error("HEAD points to something strange (%s)", link);
-	fd = open(path, O_RDONLY);
-	if (fd < 0)
-		return error("HEAD: %s", strerror(errno));
-	count = read(fd, hex, sizeof(hex));
-	close(fd);
-	if (count < 0)
-		return error("HEAD: %s", strerror(errno));
-	if (count < 40 || get_sha1_hex(hex, sha1))
+	const char *git_HEAD = strdup(git_path("HEAD"));
+	const char *git_refs_heads_master = resolve_ref(git_HEAD, sha1);
+	int pfxlen = strlen(git_HEAD) - 4; /* strip .../.git/ part */
+
+	if (!git_refs_heads_master)
+		return error("HEAD is not a symbolic ref");
+	if (strncmp(git_refs_heads_master + pfxlen, "refs/heads/", 11))
+		return error("HEAD points to something strange (%s)",
+			     git_refs_heads_master + pfxlen);
+	if (!memcmp(null_sha1, sha1, 20))
 		return error("HEAD: not a valid git pointer");
 	return 0;
 }
diff --git a/git-bisect.sh b/git-bisect.sh
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -38,7 +38,8 @@ bisect_start() {
 	# Verify HEAD. If we were bisecting before this, reset to the
 	# top-of-line master first!
 	#
-	head=$(readlink $GIT_DIR/HEAD) || die "Bad HEAD - I need a symlink"
+	head=$(GIT_DIR="$GIT_DIR" git-symbolic-ref HEAD) ||
+	die "Bad HEAD - I need a symbolic ref"
 	case "$head" in
 	refs/heads/bisect*)
 		git checkout master || exit
@@ -46,7 +47,7 @@ bisect_start() {
 	refs/heads/*)
 		;;
 	*)
-		die "Bad HEAD - strange symlink"
+		die "Bad HEAD - strange symbolic ref"
 		;;
 	esac
 
@@ -135,7 +136,7 @@ bisect_next() {
 	echo "$rev" > "$GIT_DIR/refs/heads/new-bisect"
 	git checkout new-bisect || exit
 	mv "$GIT_DIR/refs/heads/new-bisect" "$GIT_DIR/refs/heads/bisect" &&
-	ln -sf refs/heads/bisect "$GIT_DIR/HEAD"
+	GIT_DIR="$GIT_DIR" git-symbolic-ref HEAD refs/heads/bisect
 	git-show-branch "$rev"
 }
 
diff --git a/git-branch.sh b/git-branch.sh
--- a/git-branch.sh
+++ b/git-branch.sh
@@ -14,7 +14,8 @@ If two arguments, create a new branch <b
 
 delete_branch () {
     option="$1" branch_name="$2"
-    headref=$(readlink "$GIT_DIR/HEAD" | sed -e 's|^refs/heads/||')
+    headref=$(GIT_DIR="$GIT_DIR" git-symbolic-ref HEAD |
+    	       sed -e 's|^refs/heads/||')
     case ",$headref," in
     ",$branch_name,")
 	die "Cannot delete the branch you are on." ;;
@@ -67,7 +68,8 @@ done
 
 case "$#" in
 0)
-	headref=$(readlink "$GIT_DIR/HEAD" | sed -e 's|^refs/heads/||')
+	headref=$(GIT_DIR="$GIT_DIR" git-symbolic-ref HEAD |
+		  sed -e 's|^refs/heads/||')
 	git-rev-parse --symbolic --all |
 	sed -ne 's|^refs/heads/||p' |
 	sort |
diff --git a/git-checkout.sh b/git-checkout.sh
--- a/git-checkout.sh
+++ b/git-checkout.sh
@@ -71,7 +71,8 @@ if [ "$?" -eq 0 ]; then
 		echo $new > "$GIT_DIR/refs/heads/$newbranch"
 		branch="$newbranch"
 	fi
-	[ "$branch" ] && ln -sf "refs/heads/$branch" "$GIT_DIR/HEAD"
+	[ "$branch" ] &&
+	GIT_DIR="$GIT_DIR" git-symbolic-ref HEAD "refs/heads/$branch"
 	rm -f "$GIT_DIR/MERGE_HEAD"
 else
 	exit 1
diff --git a/git-commit.sh b/git-commit.sh
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -153,15 +153,8 @@ if [ -f "$GIT_DIR/MERGE_HEAD" ]; then
 fi >>.editmsg
 
 PARENTS="-p HEAD"
-if [ ! -r "$GIT_DIR/HEAD" ]; then
-	if [ -z "$(git-ls-files)" ]; then
-		echo Nothing to commit 1>&2
-		exit 1
-	fi
-	PARENTS=""
-	current=
-else
-	current=$(git-rev-parse --verify HEAD)
+if GIT_DIR="$GIT_DIR" git-rev-parse --verify HEAD >/dev/null 2>&1
+then
 	if [ -f "$GIT_DIR/MERGE_HEAD" ]; then
 		PARENTS="-p HEAD "`sed -e 's/^/-p /' "$GIT_DIR/MERGE_HEAD"`
 	fi
@@ -194,6 +187,12 @@ else
 		export GIT_AUTHOR_EMAIL
 		export GIT_AUTHOR_DATE
 	fi
+else
+	if [ -z "$(git-ls-files)" ]; then
+		echo Nothing to commit 1>&2
+		exit 1
+	fi
+	PARENTS=""
 fi
 git-status >>.editmsg
 if [ "$?" != "0" -a ! -f $GIT_DIR/MERGE_HEAD ]
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -13,10 +13,10 @@
 unset CDPATH
 
 die() {
-	echo "$@" >&2
+	echo >&2 "$@"
 	exit 1
 }
 
-[ -h "$GIT_DIR/HEAD" ] &&
+GIT_DIR="$GIT_DIR" git-symbolic-ref HEAD >/dev/null 2>&1 &&
 [ -d "$GIT_DIR/refs" ] &&
 [ -d "$GIT_OBJECT_DIRECTORY/00" ]
diff --git a/git-status.sh b/git-status.sh
--- a/git-status.sh
+++ b/git-status.sh
@@ -31,7 +31,7 @@ report () {
   [ "$header" ]
 }
 
-branch=`readlink "$GIT_DIR/HEAD"`
+branch=$(GIT_DIR="$GIT_DIR" git-symbolic-ref HEAD)
 case "$branch" in
 refs/heads/master) ;;
 *)	echo "# On branch $branch" ;;
@@ -39,7 +39,7 @@ esac
 
 git-update-index --refresh >/dev/null 2>&1
 
-if test -f "$GIT_DIR/HEAD"
+if GIT_DIR="$GIT_DIR" git-rev-parse --verify HEAD >/dev/null 2>&1
 then
 	git-diff-index -M --cached HEAD |
 	sed 's/^://' |
diff --git a/init-db.c b/init-db.c
--- a/init-db.c
+++ b/init-db.c
@@ -166,6 +166,7 @@ static void create_default_files(const c
 {
 	unsigned len = strlen(git_dir);
 	static char path[PATH_MAX];
+	unsigned char sha1[20];
 
 	if (len > sizeof(path)-50)
 		die("insane git directory %s", git_dir);
@@ -186,15 +187,14 @@ static void create_default_files(const c
 
 	/*
 	 * Create the default symlink from ".git/HEAD" to the "master"
-	 * branch
+	 * branch, if it does not exist yet.
 	 */
 	strcpy(path + len, "HEAD");
-	if (symlink("refs/heads/master", path) < 0) {
-		if (errno != EEXIST) {
-			perror(path);
+	if (read_ref(path, sha1) < 0) {
+		if (create_symref(path, "refs/heads/master") < 0)
 			exit(1);
-		}
 	}
+	path[len] = 0;
 	copy_templates(path, len, template_path);
 }
 
diff --git a/refs.c b/refs.c
--- a/refs.c
+++ b/refs.c
@@ -9,6 +9,10 @@ const unsigned char null_sha1[20] = { 0,
 /* We allow "recursive" symbolic refs. Only within reason, though */
 #define MAXDEPTH 5
 
+#ifndef USE_SYMLINK_HEAD
+#define USE_SYMLINK_HEAD 1
+#endif
+
 const char *resolve_ref(const char *path, unsigned char *sha1)
 {
 	int depth = MAXDEPTH, len;
@@ -22,9 +26,14 @@ const char *resolve_ref(const char *path
 		if (--depth < 0)
 			return NULL;
 
-		/* Special case: non-existing file */
+		/* Special case: non-existing file.
+		 * But if this is the first round, i.e. the user
+		 * gave us ".git/NO_SUCH_SYMLINK" which does not even
+		 * exist, we should barf.  ".git/HEAD" symlink which
+		 * points at "refs/heads/master" not yet born is OK.
+		 */
 		if (lstat(path, &st) < 0) {
-			if (errno != ENOENT)
+			if (errno != ENOENT || depth == MAXDEPTH - 1)
 				return NULL;
 			memset(sha1, 0, 20);
 			return path;
@@ -67,6 +76,39 @@ const char *resolve_ref(const char *path
 	return path;
 }
 
+int create_symref(const char *git_HEAD, const char *refs_heads_master)
+{
+#if USE_SYMLINK_HEAD
+	unlink(git_HEAD);
+	return symlink(refs_heads_master, git_HEAD);
+#else
+	const char *lockpath;
+	char ref[1000];
+	int fd, len, written;
+
+	len = snprintf(ref, sizeof(ref), "ref: %s\n", refs_heads_master);
+	if (sizeof(ref) <= len) {
+		error("refname too long: %s", refs_heads_master);
+		return -1;
+	}
+	lockpath = mkpath("%s.lock", git_HEAD);
+	fd = open(lockpath, O_CREAT | O_EXCL | O_WRONLY, 0666);	
+	written = write(fd, ref, len);
+	close(fd);
+	if (written != len) {
+		unlink(lockpath);
+		error("Unable to write to %s", lockpath);
+		return -2;
+	}
+	if (rename(lockpath, git_HEAD) < 0) {
+		unlink(lockpath);
+		error("Unable to create %s", git_HEAD);
+		return -3;
+	}
+	return 0;
+#endif
+}
+
 int read_ref(const char *filename, unsigned char *sha1)
 {
 	if (resolve_ref(filename, sha1) && memcmp(sha1, null_sha1, 20))
diff --git a/setup.c b/setup.c
--- a/setup.c
+++ b/setup.c
@@ -76,18 +76,22 @@ const char **get_pathspec(const char *pr
  * Test it it looks like we're at the top
  * level git directory. We want to see a
  *
- *  - a HEAD symlink and a refs/ directory under ".git"
  *  - either a .git/objects/ directory _or_ the proper
  *    GIT_OBJECT_DIRECTORY environment variable
+ *  - a refs/ directory under ".git"
+ *  - either a HEAD symlink or a HEAD file that is formatted as
+ *    a proper "ref:".
  */
 static int is_toplevel_directory(void)
 {
-	struct stat st;
+	unsigned char sha1[20];
 
-	return	!lstat(".git/HEAD", &st) &&
-		S_ISLNK(st.st_mode) &&
-		!access(".git/refs/", X_OK) &&
-		(getenv(DB_ENVIRONMENT) || !access(".git/objects/", X_OK));
+	if (access(".git/refs/", X_OK) ||
+	    access(getenv(DB_ENVIRONMENT) ?
+		   getenv(DB_ENVIRONMENT) : ".git/objects/", X_OK) ||
+	    (resolve_ref(".git/HEAD", sha1) == NULL))
+		return 0;
+	return 1;
 }
 
 const char *setup_git_directory(void)
diff --git a/show-branch.c b/show-branch.c
--- a/show-branch.c
+++ b/show-branch.c
@@ -349,6 +349,7 @@ int main(int ac, char **av)
 	int all_heads = 0, all_tags = 0;
 	int all_mask, all_revs, shown_merge_point;
 	char head_path[128];
+	const char *head_path_p;
 	int head_path_len;
 	unsigned char head_sha1[20];
 	int merge_base = 0;
@@ -430,11 +431,15 @@ int main(int ac, char **av)
 	if (0 <= extra)
 		join_revs(&list, &seen, num_rev, extra);
 
-	head_path_len = readlink(".git/HEAD", head_path, sizeof(head_path)-1);
-	if ((head_path_len < 0) || get_sha1("HEAD", head_sha1))
+	head_path_p = resolve_ref(git_path("HEAD"), head_sha1);
+	if (head_path_p) {
+		head_path_len = strlen(head_path_p);
+		memcpy(head_path, head_path_p, head_path_len + 1);
+	}
+	else {
+		head_path_len = 0;
 		head_path[0] = 0;
-	else
-		head_path[head_path_len] = 0;
+	}
 
 	if (merge_base)
 		return show_merge_base(seen, num_rev);
diff --git a/symbolic-ref.c b/symbolic-ref.c
new file mode 100644
--- /dev/null
+++ b/symbolic-ref.c
@@ -0,0 +1,34 @@
+#include "cache.h"
+
+static const char git_symbolic_ref_usage[] =
+"git-symbolic-ref name [ref]";
+
+static void check_symref(const char *HEAD)
+{
+	unsigned char sha1[20];
+	const char *git_HEAD = strdup(git_path("%s", HEAD));
+	const char *git_refs_heads_master = resolve_ref(git_HEAD, sha1);
+	if (git_refs_heads_master) {
+		/* we want to strip the .git/ part */
+		int pfxlen = strlen(git_HEAD) - strlen(HEAD);
+		puts(git_refs_heads_master + pfxlen);
+	}
+	else
+		die("No such ref: %s", HEAD);
+}
+
+int main(int argc, const char **argv)
+{
+	setup_git_directory();
+	switch (argc) {
+	case 2:
+		check_symref(argv[1]);
+		break;
+	case 3:
+		create_symref(strdup(git_path("%s", argv[1])), argv[2]);
+		break;
+	default:
+		usage(git_symbolic_ref_usage);
+	}
+	return 0;
+}
diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -20,12 +20,12 @@ test_expect_success setup '
 	    commit=$(echo "Commit #$i" | git-commit-tree $tree -p $parent) &&
 	    parent=$commit || return 1
 	done &&
-	echo "$commit" >.git/HEAD &&
+	git-update-ref HEAD "$commit" &&
 	git-clone -l ./. victim &&
 	cd victim &&
 	git-log &&
 	cd .. &&
-	echo $zero >.git/HEAD &&
+	git-update-ref HEAD "$zero" &&
 	parent=$zero &&
 	for i in $cnt
 	do
@@ -33,7 +33,7 @@ test_expect_success setup '
 	    commit=$(echo "Rebase #$i" | git-commit-tree $tree -p $parent) &&
 	    parent=$commit || return 1
 	done &&
-	echo "$commit" >.git/HEAD &&
+	git-update-ref HEAD "$commit" &&
 	echo Rebase &&
 	git-log'
 
