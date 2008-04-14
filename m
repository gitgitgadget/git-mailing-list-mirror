From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/2] bisect: warn if given dubious tag or branch as rev
Date: Mon, 14 Apr 2008 05:41:51 +0200
Message-ID: <20080414054151.52e55e7f.chriscool@tuxfamily.org>
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
	id 1JlFVY-000819-L5
	for gcvg-git-2@gmane.org; Mon, 14 Apr 2008 05:37:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754109AbYDNDgp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Apr 2008 23:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754033AbYDNDgp
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Apr 2008 23:36:45 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:53411 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754007AbYDNDgg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Apr 2008 23:36:36 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id BE0481AB2BA;
	Mon, 14 Apr 2008 05:36:34 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 7DD671AB2B9;
	Mon, 14 Apr 2008 05:36:34 +0200 (CEST)
X-Mailer: Sylpheed 2.5.0beta1 (GTK+ 2.12.9; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79454>

This patch refactors rev parsing code in a new "bisect_parse_rev"
function, and adds warnings in case a rev with a name that is the
same as one of the bisect subcommands is given where a revision
is expected.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-bisect.sh               |   47 ++++++++++++++++++++++++++++++------------
 t/t6030-bisect-porcelain.sh |   21 +++++++++++++++++++
 2 files changed, 54 insertions(+), 14 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 6b43461..a090b97 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -61,6 +61,31 @@ bisect_autostart() {
 	}
 }
 
+bisect_parse_rev() {
+	rev="$1"
+	dont_die_on_wrong_rev="$2"
+	name="$rev^{commit}"
+	dubious_rev_name=''
+
+	case "$rev" in
+		HEAD)
+			name='HEAD' ;;
+		help|start|bad|good|skip|next|reset|visualize|replay|log|run)
+			dubious_rev_name='yes' ;;
+	esac
+
+	sha=$(git rev-parse --verify "$name" 2>/dev/null)
+	status=$?
+
+	test $status -eq 0 && test -n "$dubious_rev_name" &&
+		echo >&2 "A tag or branch named '$rev' exists and will be used." \
+			"This may be a syntax error, please check."
+
+	test -n "$dont_die_on_wrong_rev" && return $status
+
+	test $status -eq 0 || die "Bad rev input: $rev"
+}
+
 bisect_start() {
 	#
 	# Verify HEAD. If we were bisecting before this, reset to the
@@ -68,7 +93,7 @@ bisect_start() {
 	#
 	head=$(GIT_DIR="$GIT_DIR" git symbolic-ref HEAD) ||
 	head=$(GIT_DIR="$GIT_DIR" git rev-parse --verify HEAD) ||
-	die "Bad HEAD - I need a HEAD"
+		die "Bad HEAD - I need a HEAD"
 	start_head=''
 	case "$head" in
 	refs/heads/bisect)
@@ -98,9 +123,9 @@ bisect_start() {
 	#
 	# Check for one bad and then some good revisions.
 	#
-	has_double_dash=0
+	dont_die_on_wrong_rev='yes'
 	for arg; do
-	    case "$arg" in --) has_double_dash=1; break ;; esac
+	    case "$arg" in --) dont_die_on_wrong_rev=''; break ;; esac
 	done
 	orig_args=$(sq "$@")
 	bad_seen=0
@@ -113,16 +138,12 @@ bisect_start() {
 		break
 		;;
 	    *)
-		rev=$(git rev-parse --verify "$arg^{commit}" 2>/dev/null) || {
-		    test $has_double_dash -eq 1 &&
-		        die "'$arg' does not appear to be a valid revision"
-		    break
-		}
+		bisect_parse_rev "$arg" "$dont_die_on_wrong_rev" || break
 		case $bad_seen in
 		0) state='bad' ; bad_seen=1 ;;
 		*) state='good' ;;
 		esac
-		eval="$eval bisect_write '$state' '$rev' 'nolog'; "
+		eval="$eval bisect_write '$state' '$sha' 'nolog'; "
 		shift
 		;;
 	    esac
@@ -156,16 +177,14 @@ bisect_state() {
 	0,*)
 		die "Please call 'bisect_state' with at least one argument." ;;
 	1,bad|1,good|1,skip)
-		rev=$(git rev-parse --verify HEAD) ||
-			die "Bad rev input: HEAD"
-		bisect_write "$state" "$rev" ;;
+		bisect_parse_rev HEAD
+		bisect_write "$state" "$sha" ;;
 	2,bad|*,good|*,skip)
 		shift
 		eval=''
 		for rev in "$@"
 		do
-			sha=$(git rev-parse --verify "$rev^{commit}") ||
-				die "Bad rev input: $rev"
+			bisect_parse_rev "$rev"
 			eval="$eval bisect_write '$state' '$sha'; "
 		done
 		eval "$eval" ;;
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 5e3e544..dc95117 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -89,6 +89,27 @@ test_expect_success 'bisect fails if given any junk instead of revs' '
 	git bisect bad $HASH4
 '
 
+test_expect_success 'bisect warns if given dubious tags or branches' '
+	git branch bad $HASH4 &&
+	git bisect start bad -- 2>start.output &&
+	grep "bad" start.output &&
+	grep "may be a syntax error" start.output &&
+	git tag good $HASH1 &&
+	git bisect start $HASH4 $HASH2 good -- 2>start.output &&
+	grep "good" start.output &&
+	grep "may be a syntax error" start.output &&
+	git bisect start &&
+	git bisect good $HASH2 bad 2>good.output &&
+	grep "bad" good.output &&
+	grep "may be a syntax error" good.output &&
+	git bisect start &&
+	git bisect bad bad 2>bad.output &&
+	grep "bad" bad.output &&
+	grep "may be a syntax error" bad.output &&
+	git branch -D bad &&
+	git tag -d good
+'
+
 test_expect_success 'bisect reset: back in the master branch' '
 	git bisect reset &&
 	echo "* master" > branch.expect &&
-- 
1.5.5.50.ge6e82.dirty
