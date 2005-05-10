From: Junio C Hamano <junkio@cox.net>
Subject: Introducing GIT_DIR environment variable.
Date: Mon, 09 May 2005 23:25:30 -0700
Message-ID: <7v8y2nr411.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.21.0505092012340.30848-100000@iabervon.org>
	<7voebjr5vd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 10 08:19:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVO5d-0000tj-Q2
	for gcvg-git@gmane.org; Tue, 10 May 2005 08:19:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261552AbVEJG0s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 May 2005 02:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261564AbVEJG0s
	(ORCPT <rfc822;git-outgoing>); Tue, 10 May 2005 02:26:48 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:42680 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S261552AbVEJGZe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2005 02:25:34 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050510062532.BMPK26972.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 10 May 2005 02:25:32 -0400
To: Petr Baudis <pasky@ucw.cz>, Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <7voebjr5vd.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Mon, 09 May 2005 22:45:42 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Ok, following the mailing list discussion, I've done GIT_DIR and
pushed it out to the usual git-jc repository, at:

    http://members.cox.net/junkio/git-jc.git/

Author: Junio C Hamano <junkio@cox.net>
Date:   Mon May 9 22:57:58 2005 -0700
    
    Introduce GIT_DIR environment variable.
    
    During the mailing list discussion on renaming GIT_ environment
    variables, people felt that having one environment that lets the
    user (or Porcelain) specify both SHA1_FILE_DIRECTORY (now
    GIT_OBJECT_DIRECTORY) and GIT_INDEX_FILE for the default layout
    would be handy.  This change introduces GIT_DIR environment
    variable, from which the defaults for GIT_INDEX_FILE and
    GIT_OBJECT_DIRECTORY are derived.  When GIT_DIR is not defined,
    it defaults to ".git".  GIT_INDEX_FILE defaults to
    "$GIT_DIR/index" and GIT_OBJECT_DIRECTORY defaults to
    "$GIT_DIR/objects".
    
    Special thanks for ideas and discussions go to Petr Baudis and
    Daniel Barkalow.  Bugs are mine ;-)
    
Signed-off-by: Junio C Hamano <junkio@cox.net>
---
--- a/cache.h
+++ b/cache.h
@@ -106,16 +106,15 @@ static inline unsigned int create_ce_mod
 struct cache_entry **active_cache;
 unsigned int active_nr, active_alloc, active_cache_changed;
 
+#define GIT_DIR_ENVIRONMENT "GIT_DIR"
+#define DEFAULT_GIT_DIR_ENVIRONMENT ".git"
 #define DB_ENVIRONMENT "GIT_OBJECT_DIRECTORY"
-#define DEFAULT_DB_ENVIRONMENT ".git/objects"
-#define ALTERNATE_DB_ENVIRONMENT "GIT_ALTERNATE_OBJECT_DIRECTORIES"
-
-#define get_object_directory() (gitenv(DB_ENVIRONMENT) ? : DEFAULT_DB_ENVIRONMENT)
-
 #define INDEX_ENVIRONMENT "GIT_INDEX_FILE"
-#define DEFAULT_INDEX_ENVIRONMENT ".git/index"
 
-#define get_index_file() (gitenv(INDEX_ENVIRONMENT) ? : DEFAULT_INDEX_ENVIRONMENT)
+extern char *get_object_directory(void);
+extern char *get_index_file(void);
+
+#define ALTERNATE_DB_ENVIRONMENT "GIT_ALTERNATE_OBJECT_DIRECTORIES"
 
 #define alloc_nr(x) (((x)+16)*3/2)
 
--- a/git-prune-script
+++ b/git-prune-script
@@ -11,6 +11,9 @@ do
     shift;
 done
 
+: ${GIT_DIR=.git}
+: ${GIT_OBJECT_DIRECTORY="${SHA1_FILE_DIRECTORY-"$GIT_DIR/objects"}"}
+
 # Defaulting to include .git/refs/*/* may be debatable from the
 # purist POV but power users can always give explicit parameters
 # to the script anyway.
@@ -19,7 +22,8 @@ case "$#" in
 0)
     x_40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
     x_40="$x_40$x_40$x_40$x_40$x_40$x_40$x_40$x_40"
-    set x $(sed -ne "/^$x_40\$/p" .git/HEAD .git/refs/*/* 2>/dev/null)
+    set x $(sed -ne "/^$x_40\$/p" \
+	"$GIT_DIR"/HEAD "$GIT_DIR"/refs/*/* /dev/null 2>/dev/null)
     shift ;;
 esac
 
@@ -28,13 +32,7 @@ sed -ne '/unreachable /{
     s/unreachable [^ ][^ ]* //
     s|\(..\)|\1/|p
 }' | {
-	for d in "$GIT_OBJECT_DIRECTORY" "$SHA1_FILE_DIRECTORY" ''
-	do
-		test "$d" != "" && test -d "$d" && break
-	done
-	case "$d" in
-	'') cd .git/objects/ ;;
-	*) cd "$d" ;;
-	esac || exit
+	cd "$GIT_OBJECT_DIRECTORY" || exit
 	xargs -r $dryrun rm -f
 }
+
--- a/git-pull-script
+++ b/git-pull-script
@@ -3,6 +3,9 @@
 merge_repo=$1
 merge_name=${2:-HEAD}
 
+: ${GIT_DIR=.git}
+: ${GIT_OBJECT_DIRECTORY="${SHA1_FILE_DIRECTORY-"$GIT_DIR/objects"}"}
+
 download_one () {
 	# remote_path="$1" local_file="$2"
 	case "$1" in
@@ -25,16 +28,19 @@ download_objects () {
 		git-local-pull -l -a "$2" "$1/"
 		;;
 	*)
-		rsync -avz --ignore-existing "$1/objects/." \
-			${SHA_FILE_DIRECTORY:-.git/objects}/.
+		rsync -avz --ignore-existing \
+			"$1/objects/." "$GIT_OBJECT_DIRECTORY"/.
 		;;
 	esac
 }
 
 echo "Getting remote $merge_name"
-download_one "$merge_repo/$merge_name" .git/MERGE_HEAD
+download_one "$merge_repo/$merge_name" "$GIT_DIR"/MERGE_HEAD
 
 echo "Getting object database"
-download_objects "$merge_repo" "$(cat .git/MERGE_HEAD)"
+download_objects "$merge_repo" "$(cat "$GIT_DIR"/MERGE_HEAD)"
 
-git-resolve-script "$(cat .git/HEAD)" "$(cat .git/MERGE_HEAD)" "$merge_repo"
+git-resolve-script \
+	"$(cat "$GIT_DIR"/HEAD)" \
+	"$(cat "$GIT_DIR"/MERGE_HEAD)" \
+	"$merge_repo"
--- a/git-resolve-script
+++ b/git-resolve-script
@@ -1,14 +1,19 @@
 #!/bin/sh
 #
+# Copyright (c) 2005 Linus Torvalds
+#
 # Resolve two trees.
 #
 head="$1"
 merge="$2"
 merge_repo="$3"
 
-rm -f .git/MERGE_HEAD .git/ORIG_HEAD
-echo $head > .git/ORIG_HEAD
-echo $merge > .git/MERGE_HEAD
+: ${GIT_DIR=.git}
+: ${GIT_OBJECT_DIRECTORY="${SHA1_FILE_DIRECTORY-"$GIT_DIR/objects"}"}
+
+rm -f "$GIT_DIR"/MERGE_HEAD "$GIT_DIR"/ORIG_HEAD
+echo $head > "$GIT_DIR"/ORIG_HEAD
+echo $merge > "$GIT_DIR"/MERGE_HEAD
 
 #
 # The remote name is just used for the message,
@@ -35,7 +40,7 @@ if [ "$common" == "$head" ]; then
 	echo "Kill me within 3 seconds.."
 	sleep 3
 	git-read-tree -m $merge && git-checkout-cache -f -a && git-update-cache --refresh
-	echo $merge > .git/HEAD
+	echo $merge > "$GIT_DIR"/HEAD
 	git-diff-tree -p ORIG_HEAD HEAD | diffstat -p1
 	exit 0
 fi
@@ -51,6 +56,6 @@ if [ $? -ne 0 ]; then
 fi
 result_commit=$(echo "$merge_msg" | git-commit-tree $result_tree -p $head -p $merge)
 echo "Committed merge $result_commit"
-echo $result_commit > .git/HEAD
+echo $result_commit > "$GIT_DIR"/HEAD
 git-checkout-cache -f -a && git-update-cache --refresh
 git-diff-tree -p ORIG_HEAD HEAD | diffstat -p1
--- a/git-tag-script
+++ b/git-tag-script
@@ -1,5 +1,9 @@
 #!/bin/sh
-object=${2:-$(cat .git/HEAD)}
+# Copyright (c) 2005 Linus Torvalds
+
+: ${GIT_DIR=.git}
+
+object=${2:-$(cat "$GIT_DIR"/HEAD)}
 type=$(git-cat-file -t $object) || exit 1
 ( echo -e "object $object\ntype $type\ntag $1\n"; cat ) > .tmp-tag
 rm -f .tmp-tag.asc
--- a/init-db.c
+++ b/init-db.c
@@ -27,11 +27,12 @@ int main(int argc, char **argv)
 	char *path;
 	int len, i;
 
-	safe_create_dir(".git");
-
-	sha1_dir = gitenv(DB_ENVIRONMENT);
-	if (!sha1_dir) {
-		sha1_dir = DEFAULT_DB_ENVIRONMENT;
+	sha1_dir = get_object_directory();
+	if (!gitenv(DB_ENVIRONMENT) && !gitenv(GIT_DIR_ENVIRONMENT)) {
+		/* We create leading paths only when we fall back
+		 * to local .git/objects, at least for now.
+		 */
+		safe_create_dir(DEFAULT_GIT_DIR_ENVIRONMENT);
 		fprintf(stderr, "defaulting to local storage area\n");
 	}
 	len = strlen(sha1_dir);
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -59,6 +59,38 @@ int get_sha1_file(const char *path, unsi
 	return get_sha1_hex(buffer, result);
 }
 
+static char *git_dir, *git_object_dir, *git_index_file;
+static void setup_git_env(void)
+{
+	git_dir = gitenv(GIT_DIR_ENVIRONMENT);
+	if (!git_dir)
+		git_dir = DEFAULT_GIT_DIR_ENVIRONMENT;
+	git_object_dir = gitenv(DB_ENVIRONMENT);
+	if (!git_object_dir) {
+		git_object_dir = xmalloc(strlen(git_dir) + 9);
+		sprintf(git_object_dir, "%s/objects", git_dir);
+	}
+	git_index_file = gitenv(INDEX_ENVIRONMENT);
+	if (!git_index_file) {
+		git_index_file = xmalloc(strlen(git_dir) + 7);
+		sprintf(git_index_file, "%s/index", git_dir);
+	}
+}
+
+char *get_object_directory(void)
+{
+	if (!git_object_dir)
+		setup_git_env();
+	return git_object_dir;
+}
+
+char *get_index_file(void)
+{
+	if (!git_index_file)
+		setup_git_env();
+	return git_index_file;
+}
+
 int get_sha1(const char *str, unsigned char *sha1)
 {
 	static char pathname[PATH_MAX];
@@ -70,15 +102,16 @@ int get_sha1(const char *str, unsigned c
 		"refs/snap",
 		NULL
 	};
-	const char *gitdir;
 	const char **p;
 
 	if (!get_sha1_hex(str, sha1))
 		return 0;
 
-	gitdir = ".git";
+	if (!git_dir)
+		setup_git_env();
 	for (p = prefix; *p; p++) {
-		snprintf(pathname, sizeof(pathname), "%s/%s/%s", gitdir, *p, str);
+		snprintf(pathname, sizeof(pathname), "%s/%s/%s",
+			 git_dir, *p, str);
 		if (!get_sha1_file(pathname, sha1))
 			return 0;
 	}



