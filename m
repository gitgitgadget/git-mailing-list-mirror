From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] git-clone: fix handling of upsteram whose HEAD does not point at master.
Date: Sun, 02 Apr 2006 16:29:46 -0700
Message-ID: <7vu09bimj9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Apr 03 01:29:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQC15-0002Kf-Ti
	for gcvg-git@gmane.org; Mon, 03 Apr 2006 01:29:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751547AbWDBX3t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Apr 2006 19:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751548AbWDBX3t
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Apr 2006 19:29:49 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:14829 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751546AbWDBX3s (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Apr 2006 19:29:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060402232948.FOGW3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 2 Apr 2006 19:29:48 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18298>

Here is a proposed fix to a problem discussed on #git yesterday.

The change also contains an independent fix to deal with new
style symref HEAD copied over HTTP (we incorrectly kept the code
that assumes downloading $GIT_DIR/HEAD using curl/wget would
give us the SHA1, which is not the case anymore), which was what
started me, but it turns out the other transports share the
problem the rest of the patch addresses.

-- >8 --

When cloning from a remote repository that has master, main, and
origin branches _and_ with the HEAD pointing at main branch, we
did quite confused things during clone.  So this cleans things
up.  The behaviour is a bit different between separate remotes/
layout and the mixed branches layout.

The newer layout with $GIT_DIR/refs/remotes/$origin/, things are
simpler and more transparent:

 - remote branches are copied to refs/remotes/$origin/.
 - HEAD points at refs/heads/master, which starts at where the
   remote HEAD points at.
 - $GIT_DIR/remotes/$origin file is set up to fetch all remote
   branches, and merge the branch HEAD pointed at at the time of
   the cloning.

Everything-in-refs/heads layout was the more confused one, but
cleaned up like this:

 - remote branches are copied to refs/heads, but the branch
   "$origin" is not copied, instead a copy of the branch the
   remote HEAD points at is created there.

 - HEAD points at the branch with the same name as the remote
   HEAD points at.

 - $GIT_DIR/remotes/$origin file is set up to fetch all remote
   branches except "$origin", and merge the branch HEAD pointed
   at at the time of the cloning.

With this, the remote has master, main and origin, and its HEAD
points at main, you could:

	git clone $URL --origin upstream

to use refs/heads/upstream as the tracking branch for remote
"main", and your primary working branch will also be "main".
"master" and "origin" are used to track the corresponding remote
branches and with this setup they do not have any special meaning.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 git-clone.sh |   51 ++++++++++++++++++++++++++++++++-------------------
 1 files changed, 32 insertions(+), 19 deletions(-)

1fa378f885d2d3e391b2924a01f42dc38f87cc21
diff --git a/git-clone.sh b/git-clone.sh
index 823c74b..9cc374e 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -52,7 +52,8 @@ Perhaps git-update-server-info needs to 
 		git-http-fetch -v -a -w "$tname" "$name" "$1/" || exit 1
 	done <"$clone_tmp/refs"
 	rm -fr "$clone_tmp"
-	http_fetch "$1/HEAD" "$GIT_DIR/REMOTE_HEAD"
+	http_fetch "$1/HEAD" "$GIT_DIR/REMOTE_HEAD" ||
+	rm -f "$GIT_DIR/REMOTE_HEAD"
 }
 
 # Read git-fetch-pack -k output and store the remote branches.
@@ -324,7 +325,7 @@ test -d "$GIT_DIR/refs/reference-tmp" &&
 
 if test -f "$GIT_DIR/CLONE_HEAD"
 then
-	# Figure out where the remote HEAD points at.
+	# Read git-fetch-pack -k output and store the remote branches.
 	perl -e "$copy_refs" "$GIT_DIR" "$use_separate_remote" "$origin"
 fi
 
@@ -332,22 +333,25 @@ cd "$D" || exit
 
 if test -z "$bare" && test -f "$GIT_DIR/REMOTE_HEAD"
 then
-	head_sha1=`cat "$GIT_DIR/REMOTE_HEAD"`
 	# Figure out which remote branch HEAD points at.
 	case "$use_separate_remote" in
 	'')	remote_top=refs/heads ;;
 	*)	remote_top="refs/remotes/$origin" ;;
 	esac
 
-	# What to use to track the remote primary branch
-	if test -n "$use_separate_remote"
-	then
-		origin_tracking="remotes/$origin/master"
-	else
-		origin_tracking="heads/$origin"
-	fi
+	head_sha1=`cat "$GIT_DIR/REMOTE_HEAD"`
+	case "$head_sha1" in
+	'ref: refs/'*)
+		# Uh-oh, the remote told us (http transport done against
+		# new style repository with a symref HEAD).
+		# Ideally we should skip the guesswork but for now
+		# opt for minimum change.
+		head_sha1=`expr "$head_sha1" : 'ref: refs/heads/\(.*\)'`
+		head_sha1=`cat "$GIT_DIR/$remote_top/$head_sha1"`
+		;;
+	esac
 
-	# The name under $remote_top the remote HEAD seems to point at
+	# The name under $remote_top the remote HEAD seems to point at.
 	head_points_at=$(
 		(
 			echo "master"
@@ -368,23 +372,32 @@ then
 		)
 	)
 
-	# Write out remotes/$origin file.
+	# Write out remotes/$origin file, and update our "$head_points_at".
 	case "$head_points_at" in
 	?*)
 		mkdir -p "$GIT_DIR/remotes" &&
+		case "$use_separate_remote" in
+		# With separete-remote, our primary branch is always
+		# at 'master'
+		t)	origin_track="$remote_top/$head_points_at"
+			git-update-ref HEAD "$head_sha1" ;;
+		# Otherwise our primary branch is the same as the remote;
+		# we track upstream with $origin.
+		*)	origin_track="$remote_top/$origin"
+			git-symbolic-ref HEAD "refs/heads/$head_points_at"
+			git-update-ref "refs/heads/$origin" "$head_sha1" ;;
+		esac &&
 		echo >"$GIT_DIR/remotes/$origin" \
 		"URL: $repo
-Pull: refs/heads/$head_points_at:refs/$origin_tracking" &&
-		case "$use_separate_remote" in
-		t) git-update-ref HEAD "$head_sha1" ;;
-		*) git-update-ref "refs/heads/$origin" $(git-rev-parse HEAD) ;;
-		esac &&
+Pull: refs/heads/$head_points_at:$origin_track" &&
 		(cd "$GIT_DIR/$remote_top" && find . -type f -print) |
 		while read dotslref
 		do
 			name=`expr "$dotslref" : './\(.*\)'` &&
-			test "$head_points_at" = "$name" ||
-			test "$origin" = "$name" ||
+			test "$use_separate_remote" = '' && {
+				test "$head_points_at" = "$name" ||
+				test "$origin" = "$name"
+			} ||
 			echo "Pull: refs/heads/${name}:$remote_top/${name}"
 		done >>"$GIT_DIR/remotes/$origin" &&
 		case "$use_separate_remote" in
-- 
1.3.0.rc1.gf0c97
