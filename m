From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/2] bisect: make "start", "good" and "skip" succeed or fail
 atomically
Date: Mon, 14 Apr 2008 05:41:45 +0200
Message-ID: <20080414054145.e2d5e253.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>, Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Mon Apr 14 05:37:31 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlFVY-000819-0U
	for gcvg-git-2@gmane.org; Mon, 14 Apr 2008 05:37:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754012AbYDNDgc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Apr 2008 23:36:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754007AbYDNDgc
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Apr 2008 23:36:32 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:53404 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753868AbYDNDgb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Apr 2008 23:36:31 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id EFF2D1AB2AC;
	Mon, 14 Apr 2008 05:36:28 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 8C9A11AB2BA;
	Mon, 14 Apr 2008 05:36:28 +0200 (CEST)
X-Mailer: Sylpheed 2.5.0beta1 (GTK+ 2.12.9; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79453>

Before this patch, when "git bisect start", "git bisect good" or
"git bisect skip" were called with many revisions, they could fail
after having already marked some revisions as "good", "bad" or
"skip".

This could be especilally bad for "git bisect start" because as
the file ".git/BISECT_NAMES" would not have been written, there
would have been no attempt to clear the marked revisions on a
"git bisect reset". That's because if there is no
".git/BISECT_NAMES" file, nothing is done to clean things up, as
the bisect session is not supposed to have started.

While at it, let's also create the ".git/BISECT_START" file, only
after ".git/BISECT_NAMES" as been created.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-bisect.sh               |   14 ++++++++++----
 t/t6030-bisect-porcelain.sh |    7 ++++++-
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 408775a..6b43461 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -69,6 +69,7 @@ bisect_start() {
 	head=$(GIT_DIR="$GIT_DIR" git symbolic-ref HEAD) ||
 	head=$(GIT_DIR="$GIT_DIR" git rev-parse --verify HEAD) ||
 	die "Bad HEAD - I need a HEAD"
+	start_head=''
 	case "$head" in
 	refs/heads/bisect)
 		if [ -s "$GIT_DIR/BISECT_START" ]; then
@@ -82,7 +83,7 @@ bisect_start() {
 		# This error message should only be triggered by cogito usage,
 		# and cogito users should understand it relates to cg-seek.
 		[ -s "$GIT_DIR/head-name" ] && die "won't bisect on seeked tree"
-		echo "${head#refs/heads/}" >"$GIT_DIR/BISECT_START"
+		start_head="${head#refs/heads/}"
 		;;
 	*)
 		die "Bad HEAD - strange symbolic ref"
@@ -103,6 +104,7 @@ bisect_start() {
 	done
 	orig_args=$(sq "$@")
 	bad_seen=0
+	eval=''
 	while [ $# -gt 0 ]; do
 	    arg="$1"
 	    case "$arg" in
@@ -120,13 +122,15 @@ bisect_start() {
 		0) state='bad' ; bad_seen=1 ;;
 		*) state='good' ;;
 		esac
-		bisect_write "$state" "$rev" 'nolog'
+		eval="$eval bisect_write '$state' '$rev' 'nolog'; "
 		shift
 		;;
 	    esac
 	done
 
 	sq "$@" >"$GIT_DIR/BISECT_NAMES"
+	test -n "$start_head" && echo "$start_head" >"$GIT_DIR/BISECT_START"
+	eval "$eval"
 	echo "git-bisect start$orig_args" >>"$GIT_DIR/BISECT_LOG"
 	bisect_auto_next
 }
@@ -157,12 +161,14 @@ bisect_state() {
 		bisect_write "$state" "$rev" ;;
 	2,bad|*,good|*,skip)
 		shift
+		eval=''
 		for rev in "$@"
 		do
 			sha=$(git rev-parse --verify "$rev^{commit}") ||
 				die "Bad rev input: $rev"
-			bisect_write "$state" "$sha"
-		done ;;
+			eval="$eval bisect_write '$state' '$sha'; "
+		done
+		eval "$eval" ;;
 	*,bad)
 		die "'git bisect bad' can take only one argument." ;;
 	*)
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 32d6118..5e3e544 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -71,8 +71,12 @@ test_expect_success 'bisect start with one bad and good' '
 	git bisect next
 '
 
-test_expect_success 'bisect good and bad fails if not given only revs' '
+test_expect_success 'bisect fails if given any junk instead of revs' '
 	git bisect reset &&
+	test_must_fail git bisect start foo $HASH1 -- &&
+	test_must_fail git bisect start $HASH4 $HASH1 bar -- &&
+	test -z "$(git for-each-ref "refs/bisect/*")" &&
+	test_must_fail ls .git/BISECT_* &&
 	git bisect start &&
 	test_must_fail git bisect good foo $HASH1 &&
 	test_must_fail git bisect good $HASH1 bar &&
@@ -80,6 +84,7 @@ test_expect_success 'bisect good and bad fails if not given only revs' '
 	test_must_fail git bisect bad $HASH3 $HASH4 &&
 	test_must_fail git bisect skip bar $HASH3 &&
 	test_must_fail git bisect skip $HASH1 foo &&
+	test -z "$(git for-each-ref "refs/bisect/*")" &&
 	git bisect good $HASH1 &&
 	git bisect bad $HASH4
 '
-- 
1.5.5.50.ge6e82.dirty
