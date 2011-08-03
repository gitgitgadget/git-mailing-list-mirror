From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v16 5/7] bisect: introduce --no-checkout support into porcelain.
Date: Thu,  4 Aug 2011 07:57:04 +1000
Message-ID: <1312408626-8600-6-git-send-email-jon.seymour@gmail.com>
References: <1312408626-8600-1-git-send-email-jon.seymour@gmail.com>
Cc: chriscool@tuxfamily.org, gitster@pobox.com, j6t@kdbg.org,
	jnareb@gmail.com, jrnieder@gmail.com,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 03 23:58:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QojSJ-0007T3-Fg
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 23:58:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755585Ab1HCV6R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Aug 2011 17:58:17 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:49435 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755556Ab1HCV6P (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 17:58:15 -0400
Received: by yxj19 with SMTP id 19so495880yxj.19
        for <git@vger.kernel.org>; Wed, 03 Aug 2011 14:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=e8Vlzubzv75qJ/ZbglPL8Imsd7Bg9ZAFHqhLFniuFME=;
        b=frDo3e6z/U3+JBTdDZlXYsitPSzgV/2pwpvbOFMgf84R+DtiEv5MG5w0L+ckGtYNHP
         jgmjvuoSw/JH663Xmx63MRp1G0Loyce4/GsXRIdBXNHfY63ss+e0IQPdABW+1yKdiG7K
         lSpbj7W4V/kHS2Z9/xJHe8QhPxqZPwamakOMQ=
Received: by 10.150.100.4 with SMTP id x4mr1242172ybb.135.1312408695126;
        Wed, 03 Aug 2011 14:58:15 -0700 (PDT)
Received: from localhost.localdomain ([120.16.210.46])
        by mx.google.com with ESMTPS id e7sm625568ybg.18.2011.08.03.14.58.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 03 Aug 2011 14:58:14 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.352.g172e
In-Reply-To: <1312408626-8600-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178634>

git-bisect can now perform bisection of a history without performing
a checkout at each stage of the bisection process. Instead, HEAD is updated.

One use-case for this function is allow git bisect to be used with
damaged repositories where git checkout would fail because the tree
referenced by the commit is damaged.

It can also be used in other cases where actual checkout of the tree
is not required to progress the bisection.

Improved-by: Christian Couder <chriscool@tuxfamily.org>
Improved-by: Junio C Hamano <gitster@pobox.com>
Improved-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 git-bisect.sh |   44 +++++++++++++++++++++++++++++++++-----------
 1 files changed, 33 insertions(+), 11 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index a44ffe1..64f2302 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -3,7 +3,7 @@
 USAGE='[help|start|bad|good|skip|next|reset|visualize|replay|log|run]'
 LONG_USAGE='git bisect help
         print this long help message.
-git bisect start [<bad> [<good>...]] [--] [<pathspec>...]
+git bisect start [--no-checkout] [<bad> [<good>...]] [--] [<pathspec>...]
         reset bisect state and start bisection.
 git bisect bad [<rev>]
         mark <rev> a known-bad revision.
@@ -34,6 +34,15 @@ require_work_tree
 _x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
 _x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
 
+bisect_head()
+{
+	if test -f "$GIT_DIR/BISECT_HEAD"; then
+		echo BISECT_HEAD;
+	else
+		echo HEAD
+	fi
+}
+
 bisect_autostart() {
 	test -s "$GIT_DIR/BISECT_START" || {
 		(
@@ -69,6 +78,7 @@ bisect_start() {
 	orig_args=$(git rev-parse --sq-quote "$@")
 	bad_seen=0
 	eval=''
+	mode=''
 	while [ $# -gt 0 ]; do
 	    arg="$1"
 	    case "$arg" in
@@ -76,6 +86,11 @@ bisect_start() {
 		shift
 		break
 		;;
+	    --no-checkout)
+		mode=--no-checkout;
+		shift ;;
+	    --*)
+		die "$(eval_gettext "unrecognised option: '\$arg'")" ;;
 	    *)
 		rev=$(git rev-parse -q --verify "$arg^{commit}") || {
 		    test $has_double_dash -eq 1 &&
@@ -107,7 +122,9 @@ bisect_start() {
 	then
 		# Reset to the rev from where we started.
 		start_head=$(cat "$GIT_DIR/BISECT_START")
-		git checkout "$start_head" -- || exit
+		if test "z$mode" != "z--no-checkout"; then
+		    git checkout "$start_head" --
+		fi
 	else
 		# Get rev from where we start.
 		case "$head" in
@@ -143,7 +160,10 @@ bisect_start() {
 	#
 	# Write new start state.
 	#
-	echo "$start_head" >"$GIT_DIR/BISECT_START" &&
+	echo "$start_head" >"$GIT_DIR/BISECT_START" && {
+		test "z$mode" != "z--no-checkout" ||
+		git update-ref --no-deref BISECT_HEAD "$start_head"
+	} &&
 	git rev-parse --sq-quote "$@" >"$GIT_DIR/BISECT_NAMES" &&
 	eval "$eval true" &&
 	echo "git bisect start$orig_args" >>"$GIT_DIR/BISECT_LOG" || exit
@@ -206,8 +226,8 @@ bisect_state() {
 	0,*)
 		die "$(gettext "Please call 'bisect_state' with at least one argument.")" ;;
 	1,bad|1,good|1,skip)
-		rev=$(git rev-parse --verify HEAD) ||
-			die "$(gettext "Bad rev input: HEAD")"
+		rev=$(git rev-parse --verify $(bisect_head)) ||
+			die "$(gettext "Bad rev input: $(bisect_head)")"
 		bisect_write "$state" "$rev"
 		check_expected_revs "$rev" ;;
 	2,bad|*,good|*,skip)
@@ -291,7 +311,7 @@ bisect_next() {
 	bisect_next_check good
 
 	# Perform all bisection computation, display and checkout
-	git bisect--helper --next-all
+	git bisect--helper --next-all $(test -f "$GIT_DIR/BISECT_HEAD" && echo --no-checkout)
 	res=$?
 
         # Check if we should exit because bisection is finished
@@ -340,12 +360,13 @@ bisect_reset() {
 	*)
 	    usage ;;
 	esac
-	if git checkout "$branch" -- ; then
-		bisect_clean_state
-	else
-		die "$(eval_gettext "Could not check out original HEAD '\$branch'.
+	if ! test -f "$GIT_DIR/BISECT_HEAD"; then
+		if ! git checkout "$branch" --; then
+			die "$(eval_gettext "Could not check out original HEAD '\$branch'.
 Try 'git bisect reset <commit>'.")"
+		fi
 	fi
+	bisect_clean_state
 }
 
 bisect_clean_state() {
@@ -362,7 +383,8 @@ bisect_clean_state() {
 	rm -f "$GIT_DIR/BISECT_RUN" &&
 	# Cleanup head-name if it got left by an old version of git-bisect
 	rm -f "$GIT_DIR/head-name" &&
-
+	git update-ref -d --no-deref BISECT_HEAD &&
+	# clean up BISECT_START last
 	rm -f "$GIT_DIR/BISECT_START"
 }
 
-- 
1.7.6.352.g172e
