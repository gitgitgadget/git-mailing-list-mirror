From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] git-check-ref-format: reject funny ref names.
Date: Wed, 12 Oct 2005 15:01:43 -0700
Message-ID: <7v64s2cs3c.fsf@assigned-by-dhcp.cox.net>
References: <46a038f90510062014l7f5740e0l77fc53b50f822e8f@mail.gmail.com>
	<46a038f90510082014i6b296f2bvbac56e25344cbdf2@mail.gmail.com>
	<4349ED5D.6020703@catalyst.net.nz>
	<7v4q7p927d.fsf@assigned-by-dhcp.cox.net>
	<7vzmpgznfj.fsf_-_@assigned-by-dhcp.cox.net>
	<7virw4zlod.fsf_-_@assigned-by-dhcp.cox.net>
	<7vzmpgy4g4.fsf@assigned-by-dhcp.cox.net>
	<7vk6gjl2uu.fsf@assigned-by-dhcp.cox.net> <434D2D8F.2020407@zytor.com>
	<7v4q7mip30.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Oct 13 00:03:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPofa-0000yr-6R
	for gcvg-git@gmane.org; Thu, 13 Oct 2005 00:01:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932466AbVJLWBr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Oct 2005 18:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932468AbVJLWBr
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Oct 2005 18:01:47 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:11685 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932466AbVJLWBq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2005 18:01:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051012220124.CUPX11356.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 12 Oct 2005 18:01:24 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10055>

Update check_ref_format() function to reject ref names that:

 * has a path component that begins with a ".", or
 * has ASCII control character, "~", "^", ":" or SP, anywhere, or
 * ends with a "/".

Use it in 'git-checkout -b', 'git-branch', and 'git-tag' to make sure
that newly created refs are well-formed.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 * This is the beginning of currently two-patch series.  This
   one "fixes" the programs that trivially create new refs.
   Also check_ref_format() is used by commit walkers when
   writing a new ref or updating an existing ref, so this patch
   makes them to refuse funny refs being created.

 Makefile           |    2 +-
 check-ref-format.c |   17 ++++++++++++++
 git-branch.sh      |   63 +++++++++++++++++++++++++++++-----------------------
 git-checkout.sh    |    2 ++
 git-tag.sh         |    2 ++
 refs.c             |   52 +++++++++++++++++++++++++++++++++++--------
 6 files changed, 100 insertions(+), 38 deletions(-)
 create mode 100644 check-ref-format.c

applies-to: ea37b42d53264d65f746b3e42577349e8a44d5c4
3fa00f52f80e5e51cc8098979ce0883c77caab52
diff --git a/Makefile b/Makefile
index 7c8f647..2860d47 100644
--- a/Makefile
+++ b/Makefile
@@ -120,7 +120,7 @@ PROGRAMS = \
 	git-ssh-upload$X git-tar-tree$X git-unpack-file$X \
 	git-unpack-objects$X git-update-index$X git-update-server-info$X \
 	git-upload-pack$X git-verify-pack$X git-write-tree$X \
-	git-update-ref$X git-symbolic-ref$X \
+	git-update-ref$X git-symbolic-ref$X git-check-ref-format$X \
 	$(SIMPLE_PROGRAMS)
 
 # Backward compatibility -- to be removed after 1.0
diff --git a/check-ref-format.c b/check-ref-format.c
new file mode 100644
index 0000000..a0adb3d
--- /dev/null
+++ b/check-ref-format.c
@@ -0,0 +1,17 @@
+/*
+ * GIT - The information manager from hell
+ */
+
+#include "cache.h"
+#include "refs.h"
+
+#include <stdio.h>
+
+int main(int ac, char **av)
+{
+	if (ac != 2)
+		usage("git-check-ref-format refname");
+	if (check_ref_format(av[1]))
+		exit(1);
+	return 0;
+}
diff --git a/git-branch.sh b/git-branch.sh
index 074229c..e2db906 100755
--- a/git-branch.sh
+++ b/git-branch.sh
@@ -13,38 +13,42 @@ If two arguments, create a new branch <b
 }
 
 delete_branch () {
-    option="$1" branch_name="$2"
+    option="$1"
+    shift
     headref=$(GIT_DIR="$GIT_DIR" git-symbolic-ref HEAD |
     	       sed -e 's|^refs/heads/||')
-    case ",$headref," in
-    ",$branch_name,")
-	die "Cannot delete the branch you are on." ;;
-    ,,)
-	die "What branch are you on anyway?" ;;
-    esac
-    branch=$(cat "$GIT_DIR/refs/heads/$branch_name") &&
-	branch=$(git-rev-parse --verify "$branch^0") ||
-	    die "Seriously, what branch are you talking about?"
-    case "$option" in
-    -D)
-	;;
-    *)
-	mbs=$(git-merge-base -a "$branch" HEAD | tr '\012' ' ')
-	case " $mbs " in
-	*' '$branch' '*)
-	    # the merge base of branch and HEAD contains branch --
-	    # which means that the HEAD contains everything in the HEAD.
+    for branch_name
+    do
+	case ",$headref," in
+	",$branch_name,")
+	    die "Cannot delete the branch you are on." ;;
+	,,)
+	    die "What branch are you on anyway?" ;;
+	esac
+	branch=$(cat "$GIT_DIR/refs/heads/$branch_name") &&
+	    branch=$(git-rev-parse --verify "$branch^0") ||
+		die "Seriously, what branch are you talking about?"
+	case "$option" in
+	-D)
 	    ;;
 	*)
-	    echo >&2 "The branch '$branch_name' is not a strict subset of your current HEAD.
-If you are sure you want to delete it, run 'git branch -D $branch_name'."
-	    exit 1
+	    mbs=$(git-merge-base -a "$branch" HEAD | tr '\012' ' ')
+	    case " $mbs " in
+	    *' '$branch' '*)
+		# the merge base of branch and HEAD contains branch --
+		# which means that the HEAD contains everything in the HEAD.
+		;;
+	    *)
+		echo >&2 "The branch '$branch_name' is not a strict subset of your current HEAD.
+    If you are sure you want to delete it, run 'git branch -D $branch_name'."
+		exit 1
+		;;
+	    esac
 	    ;;
 	esac
-	;;
-    esac
-    rm -f "$GIT_DIR/refs/heads/$branch_name"
-    echo "Deleted branch $branch_name."
+	rm -f "$GIT_DIR/refs/heads/$branch_name"
+	echo "Deleted branch $branch_name."
+    done
     exit 0
 }
 
@@ -52,7 +56,7 @@ while case "$#,$1" in 0,*) break ;; *,-*
 do
 	case "$1" in
 	-d | -D)
-		delete_branch "$1" "$2"
+		delete_branch "$@"
 		exit
 		;;
 	--)
@@ -93,6 +97,9 @@ branchname="$1"
 
 rev=$(git-rev-parse --verify "$head") || exit
 
-[ -e "$GIT_DIR/refs/heads/$branchname" ] && die "$branchname already exists"
+[ -e "$GIT_DIR/refs/heads/$branchname" ] &&
+	die "$branchname already exists."
+git-check-ref-format "heads/$branchname" ||
+	die "we do not like '$branchname' as a branch name."
 
 echo $rev > "$GIT_DIR/refs/heads/$branchname"
diff --git a/git-checkout.sh b/git-checkout.sh
index c382590..2c053a3 100755
--- a/git-checkout.sh
+++ b/git-checkout.sh
@@ -17,6 +17,8 @@ while [ "$#" != "0" ]; do
 			die "git checkout: -b needs a branch name"
 		[ -e "$GIT_DIR/refs/heads/$newbranch" ] &&
 			die "git checkout: branch $newbranch already exists"
+		git-check-ref-format "heads/$newbranch" ||
+			die "we do not like '$newbranch' as a branch name."
 		;;
 	"-f")
 		force=1
diff --git a/git-tag.sh b/git-tag.sh
index 25c1a0e..faa7667 100755
--- a/git-tag.sh
+++ b/git-tag.sh
@@ -53,6 +53,8 @@ if [ -e "$GIT_DIR/refs/tags/$name" -a -z
     die "tag '$name' already exists"
 fi
 shift
+git-check-ref-format "tags/$name" ||
+	die "we do not like '$name' as a tag name."
 
 object=$(git-rev-parse --verify --default HEAD "$@") || exit 1
 type=$(git-cat-file -t $object) || exit 1
diff --git a/refs.c b/refs.c
index 5a8cbd4..2d2144c 100644
--- a/refs.c
+++ b/refs.c
@@ -335,17 +335,51 @@ int write_ref_sha1(const char *ref, int 
 	return retval;
 }
 
+/*
+ * Make sure "ref" is something reasonable to have under ".git/refs/";
+ * We do not like it if:
+ *
+ * - any path component of it begins with ".", or
+ * - it has ASCII control character, "~", "^", ":" or SP, anywhere, or
+ * - it ends with a "/".
+ */
+
+static inline int bad_ref_char(int ch)
+{
+	return (((unsigned) ch) <= ' ' ||
+		ch == '~' || ch == '^' || ch == ':');
+}
+
 int check_ref_format(const char *ref)
 {
-	char *middle;
-	if (ref[0] == '.' || ref[0] == '/')
-		return -1;
-	middle = strchr(ref, '/');
-	if (!middle || !middle[1])
-		return -1;
-	if (strchr(middle + 1, '/'))
-		return -1;
-	return 0;
+	int ch, level;
+	const char *cp = ref;
+
+	level = 0;
+	while (1) {
+		while ((ch = *cp++) == '/')
+			; /* tolerate duplicated slashes */
+		if (!ch)
+			return -1; /* should not end with slashes */
+
+		/* we are at the beginning of the path component */
+		if (ch == '.' || bad_ref_char(ch))
+			return -1;
+
+		/* scan the rest of the path component */
+		while ((ch = *cp++) != 0) {
+			if (bad_ref_char(ch))
+				return -1;
+			if (ch == '/')
+				break;
+		}
+		level++;
+		if (!ch) {
+			if (level < 2)
+				return -1; /* at least of form "heads/blah" */
+			return 0;
+		}
+	}
 }
 
 int write_ref_sha1_unlocked(const char *ref, const unsigned char *sha1)
---
0.99.8.GIT
