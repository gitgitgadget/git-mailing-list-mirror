From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Fix automerge message.
Date: Fri, 02 Sep 2005 02:39:37 -0700
Message-ID: <7vr7c7izae.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0509011117130.6795@evo.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 02 11:41:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EB81P-0007KP-2q
	for gcvg-git@gmane.org; Fri, 02 Sep 2005 11:39:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106AbVIBJjk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Sep 2005 05:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbVIBJjj
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Sep 2005 05:39:39 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:13276 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751106AbVIBJjj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Sep 2005 05:39:39 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050902093938.EEUI7185.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 2 Sep 2005 05:39:38 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8014>

The rewrite done while adding the shorthand support made the remote
refname recorded in the commit message too long for human consumption,
while losing information by using the shorthand not the real URL to
name the remote repository there.  They were both bad changes done
without enough thinking.

Pointed out by Linus.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 git-fetch-script |   51 +++++++++++++++++++++++++++++++++------------------
 1 files changed, 33 insertions(+), 18 deletions(-)

06ec2b4bb4ab9096d1304ba5a2ec388078dcdf7f
diff --git a/git-fetch-script b/git-fetch-script
--- a/git-fetch-script
+++ b/git-fetch-script
@@ -55,21 +55,41 @@ append_fetch_head () {
     remote_nick_="$4"
     local_name_="$5"
 
+    # remote-nick is the URL given on the command line (or a shorthand)
+    # remote-name is the $GIT_DIR relative refs/ path we computed
+    # for this refspec.
+    case "$remote_name_" in
+    HEAD)
+	note_= ;;
+    refs/heads/*)
+	note_="$(expr "$remote_name_" : 'refs/heads/\(.*\)')"
+	note_="branch '$note_' of " ;;
+    refs/tags/*)
+	note_="$(expr "$remote_name_" : 'refs/tags/\(.*\)')"
+	note_="tag '$note_' of " ;;
+    *)
+	note_="$remote_name of " ;;
+    esac
+    remote_1_=$(expr "$remote_" : '\(.*\)\.git/*$') &&
+	remote_="$remote_1_"
+    note_="$note_$remote_"
+
     # 2.6.11-tree tag would not be happy to be fed to resolve.
     if git-cat-file commit "$head_" >/dev/null 2>&1
     then
 	headc_=$(git-rev-parse --verify "$head_^0") || exit
-	note_="$headc_	$remote_name_ from $remote_nick_"
-	echo "$note_" >>$GIT_DIR/FETCH_HEAD
-	echo >&2 "* committish: $note_"
+	echo "$headc_	$note_" >>$GIT_DIR/FETCH_HEAD
+	echo >&2 "* committish: $head_"
+	echo >&2 "  $note_"
     else
-	echo >&2 "* non-commit: $note_"
+	echo >&2 "* non-commit: $head_"
+	echo >&2 "  $note_"
     fi
     if test "$local_name_" != ""
     then
 	# We are storing the head locally.  Make sure that it is
 	# a fast forward (aka "reverse push").
-	fast_forward_local "$local_name_" "$head_" "$remote_" "$remote_name_"
+	fast_forward_local "$local_name_" "$head_" "$note_"
     fi
 }
 
@@ -80,11 +100,9 @@ fast_forward_local () {
 	# is no way to guarantee "fast-forward" anyway.
 	if test -f "$GIT_DIR/$1"
 	then
-		echo >&2 "* $1: updating with $4"
-		echo >&2 "  from $3."
+		echo >&2 "* $1: updating with $3"
 	else
-		echo >&2 "* $1: storing $4"
-		echo >&2 "  from $3."
+		echo >&2 "* $1: storing $3"
 	fi
 	echo "$2" >"$GIT_DIR/$1" ;;
 
@@ -97,31 +115,28 @@ fast_forward_local () {
 	    mb=$(git-merge-base "$local" "$2") &&
 	    case "$2,$mb" in
 	    $local,*)
-		echo >&2 "* $1: same as $4"
-		echo >&2 "  from $3"
+		echo >&2 "* $1: same as $3"
 		;;
 	    *,$local)
-		echo >&2 "* $1: fast forward to $4"
-		echo >&2 "  from $3"
+		echo >&2 "* $1: fast forward to $3"
 		;;
 	    *)
 		false
 		;;
 	    esac || {
-		echo >&2 "* $1: does not fast forward to $4"
+		echo >&2 "* $1: does not fast forward to $3;"
 		case "$force,$single_force" in
 		t,* | *,t)
-			echo >&2 "  from $3; forcing update."
+			echo >&2 "  forcing update."
 			;;
 		*)
 			mv "$GIT_DIR/$1.lock" "$GIT_DIR/$1.remote"
-			echo >&2 "  from $3; leaving it in '$1.remote'"
+			echo >&2 "  leaving it in '$1.remote'"
 			;;
 		esac
 	    }
 	else
-		echo >&2 "* $1: storing $4"
-		echo >&2 "  from $3."
+		echo >&2 "* $1: storing $3"
 	fi
 	test -f "$GIT_DIR/$1.lock" &&
 	    mv "$GIT_DIR/$1.lock" "$GIT_DIR/$1"
