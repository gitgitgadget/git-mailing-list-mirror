From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Terminate diff-* on non-zero exit from GIT_EXTERNAL_DIFF
Date: Tue, 03 May 2005 12:49:29 -0700
Message-ID: <7v4qdkw0mu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 21:44:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DT3Ig-00072Q-MP
	for gcvg-git@gmane.org; Tue, 03 May 2005 21:43:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261647AbVECTtm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 15:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261649AbVECTtm
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 15:49:42 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:57244 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S261647AbVECTtf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2005 15:49:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050503194930.GMRE7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 3 May 2005 15:49:30 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This patch changes the git-apply-patch-script to exit non-zero
when the patch cannot be applied.  Previously, the external diff
driver deliberately ignored the exit status of GIT_EXTERNAL_DIFF
command, which was a design mistake.  It now stops the
processing when GIT_EXTERNAL_DIFF exits non-zero, so the damages
from running git-diff-* with git-apply-patch-script between two
wrong trees can be contained.

The "diff" command line built-in driver builds is changed to
always exit 0 in order to match this new behaviour.  I know
Pasky does not use GIT_EXTERNAL_DIFF yet, so this change should
not break Cogito, either.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

diff.c                 |   19 +++++++++------
git-apply-patch-script |   59 +++++++++++++++++++++++--------------------------
2 files changed, 39 insertions(+), 39 deletions(-)

# - HEAD: Merge with linus-mirror.
# + 2: Use GIT_EXTERNAL_DIFF exit status to terminate diff early.
--- a/diff.c
+++ b/diff.c
@@ -83,7 +83,7 @@ static void builtin_diff(const char *nam
 {
 	int i, next_at;
 	const char *diff_cmd = "diff -L'%s%s' -L'%s%s'";
-	const char *diff_arg  = "'%s' '%s'";
+	const char *diff_arg  = "'%s' '%s'||:"; /* "||:" is to return 0 */
 	const char *input_name_sq[2];
 	const char *path0[2];
 	const char *path1[2];
@@ -261,16 +261,19 @@ void run_external_diff(const char *name,
 			printf("* Unmerged path %s\n", name);
 		exit(0);
 	}
-	if (waitpid(pid, &status, 0) < 0 || !WIFEXITED(status)) {
-		/* We do not check the exit status because typically
+	if (waitpid(pid, &status, 0) < 0 ||
+	    !WIFEXITED(status) || WEXITSTATUS(status)) {
+		/* Earlier we did not check the exit status because
 		 * diff exits non-zero if files are different, and
-		 * we are not interested in knowing that.  We *knew*
-		 * they are different and that's why we ran diff
-		 * in the first place!  However if it dies by a signal,
-		 * we stop processing immediately.
+		 * we are not interested in knowing that.  It was a
+		 * mistake which made it harder to quit a diff-*
+		 * session that uses the git-apply-patch-script as
+		 * the GIT_EXTERNAL_DIFF.  A custom GIT_EXTERNAL_DIFF
+		 * should also exit non-zero only when it wants to
+		 * abort the entire diff-* session.
 		 */
 		remove_tempfile();
-		die("external diff died unexpectedly.\n");
+		die("external diff died, stopping at %s.\n", name);
 	}
 	remove_tempfile();
 }
--- a/git-apply-patch-script
+++ b/git-apply-patch-script
@@ -21,38 +21,35 @@ then
 fi
 # This will say "patching ..." so we do not say anything outselves.
 
-diff -u -L "a/$name" -L "b/$name" "$tmp1" "$tmp2" | patch -p1
-test -f "$name.rej" || {
-    case "$mode1,$mode2" in
-    .,?x)
-	# newly created
-	case "$mode2" in
-	+x)
-	    echo >&2 "created $name with mode +x."
-	    chmod "$mode2" "$name"
-	    ;;
-	-x)
-	    echo >&2 "created $name."
-	    ;;
-	esac
-	git-update-cache --add -- "$name"
+diff -u -L "a/$name" -L "b/$name" "$tmp1" "$tmp2" | patch -p1 || exit
+case "$mode1,$mode2" in
+.,?x)
+    # newly created
+    case "$mode2" in
+    +x)
+	echo >&2 "created $name with mode +x."
+	chmod "$mode2" "$name"
 	;;
-    ?x,.)
-	# deleted
-	echo >&2 "deleted $name."
-	rm -f "$name"
-	git-update-cache --remove -- "$name"
+    -x)
+	echo >&2 "created $name."
 	;;
+    esac
+    git-update-cache --add -- "$name"
+    ;;
+?x,.)
+    # deleted
+    echo >&2 "deleted $name."
+    rm -f "$name"
+    git-update-cache --remove -- "$name"
+    ;;
+*)
+    # changed
+    case "$mode1,$mode2" in
+    "$mode2,$mode1") ;;
     *)
-	# changed
-	case "$mode1,$mode2" in
-	"$mode2,$mode1") ;;
-	*)
-	    echo >&2 "changing mode from $mode1 to $mode2."
-	    chmod "$mode2" "$name"
-	    ;;
-	esac
-	git-update-cache -- "$name"
+	echo >&2 "changing mode from $mode1 to $mode2."
+	chmod "$mode2" "$name"
+	;;
     esac
-}
-exit 0
+    git-update-cache -- "$name"
+esac

