From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v11 5/7] bisect: introduce --no-checkout support into porcelain.
Date: Mon,  1 Aug 2011 21:56:15 +1000
Message-ID: <1312199777-10144-6-git-send-email-jon.seymour@gmail.com>
References: <1312199777-10144-1-git-send-email-jon.seymour@gmail.com>
Cc: chriscool@tuxfamily.org, gitster@pobox.com, j6t@kdbg.org,
	jnareb@gmail.com, Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 01 13:57:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qnr7a-00062W-2s
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 13:57:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752252Ab1HAL5T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Aug 2011 07:57:19 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:33742 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751784Ab1HAL5Q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2011 07:57:16 -0400
Received: by gyh3 with SMTP id 3so3371275gyh.19
        for <git@vger.kernel.org>; Mon, 01 Aug 2011 04:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=cwjhl98anReWofKuvdYpuinuYHmv1P7I2rD0E8TjxDQ=;
        b=mhAuBkZO8rsn2mPC2+ziWy4mrCkbMiRf3srBv+n0DZaDseUGMDeE5M9GzAnHZIWA5/
         al6F1u5PUcmtFYcrJraiHgjpD8nQTNYKKUlJCVU0hAAqyC1FWuxzONsiv4LgD/faZH7t
         1FUItrhM3nbXZmaPUO0d8c6bmgWl6uTz/kBQs=
Received: by 10.142.7.17 with SMTP id 17mr3023407wfg.69.1312199835245;
        Mon, 01 Aug 2011 04:57:15 -0700 (PDT)
Received: from localhost.localdomain ([120.16.6.238])
        by mx.google.com with ESMTPS id a4sm3060009wfm.4.2011.08.01.04.57.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 01 Aug 2011 04:57:14 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.352.g0c69b
In-Reply-To: <1312199777-10144-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178337>

git-bisect can now perform bisection of a history without performing
a checkout at each stage of the bisection process. Instead, HEAD is updated.

One use-case for this function is allow git bisect to be used with
damaged repositories where git checkout would fail because the tree
referenced by the commit is damaged.

It can also be used in other cases where actual checkout of the tree
is not required to progress the bisection.

Improved-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 git-bisect.sh |   36 ++++++++++++++++++++++++++++--------
 1 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index a44ffe1..81d2344 100755
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
@@ -34,6 +34,8 @@ require_work_tree
 _x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
 _x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
 
+BISECT_NO_CHECKOUT=$(test -f "$GIT_DIR/BISECT_NO_CHECKOUT" && cat "$GIT_DIR/BISECT_NO_CHECKOUT")
+
 bisect_autostart() {
 	test -s "$GIT_DIR/BISECT_START" || {
 		(
@@ -69,6 +71,7 @@ bisect_start() {
 	orig_args=$(git rev-parse --sq-quote "$@")
 	bad_seen=0
 	eval=''
+	BISECT_NO_CHECKOUT=
 	while [ $# -gt 0 ]; do
 	    arg="$1"
 	    case "$arg" in
@@ -76,6 +79,11 @@ bisect_start() {
 		shift
 		break
 		;;
+	    --no-checkout)
+		BISECT_NO_CHECKOUT=$arg;
+		shift ;;
+	    --*)
+		die "$(eval_gettext "unrecognised option: '\$arg'")" ;;
 	    *)
 		rev=$(git rev-parse -q --verify "$arg^{commit}") || {
 		    test $has_double_dash -eq 1 &&
@@ -107,7 +115,11 @@ bisect_start() {
 	then
 		# Reset to the rev from where we started.
 		start_head=$(cat "$GIT_DIR/BISECT_START")
-		git checkout "$start_head" -- || exit
+		if test -z "$BISECT_NO_CHECKOUT"; then
+		    git checkout "$start_head" --
+		else
+		    git update-ref --no-deref HEAD "$start_head"
+		fi
 	else
 		# Get rev from where we start.
 		case "$head" in
@@ -144,7 +156,10 @@ bisect_start() {
 	# Write new start state.
 	#
 	echo "$start_head" >"$GIT_DIR/BISECT_START" &&
-	git rev-parse --sq-quote "$@" >"$GIT_DIR/BISECT_NAMES" &&
+	git rev-parse --sq-quote "$@" >"$GIT_DIR/BISECT_NAMES" && {
+	    test -z "$BISECT_NO_CHECKOUT" ||
+	    echo "$BISECT_NO_CHECKOUT" > "$GIT_DIR/BISECT_NO_CHECKOUT"
+	} &&
 	eval "$eval true" &&
 	echo "git bisect start$orig_args" >>"$GIT_DIR/BISECT_LOG" || exit
 	#
@@ -291,7 +306,7 @@ bisect_next() {
 	bisect_next_check good
 
 	# Perform all bisection computation, display and checkout
-	git bisect--helper --next-all
+	git bisect--helper --next-all ${BISECT_NO_CHECKOUT}
 	res=$?
 
         # Check if we should exit because bisection is finished
@@ -340,11 +355,15 @@ bisect_reset() {
 	*)
 	    usage ;;
 	esac
-	if git checkout "$branch" -- ; then
-		bisect_clean_state
-	else
-		die "$(eval_gettext "Could not check out original HEAD '\$branch'.
+	if test -z "$BISECT_NO_CHECKOUT"; then
+		if git checkout "$branch" --; then
+			bisect_clean_state
+		else
+			die "$(eval_gettext "Could not check out original HEAD '\$branch'.
 Try 'git bisect reset <commit>'.")"
+		fi
+	else
+	    git symbolic-ref HEAD $(git rev-parse --symbolic-full-name "${branch}")
 	fi
 }
 
@@ -360,6 +379,7 @@ bisect_clean_state() {
 	rm -f "$GIT_DIR/BISECT_LOG" &&
 	rm -f "$GIT_DIR/BISECT_NAMES" &&
 	rm -f "$GIT_DIR/BISECT_RUN" &&
+	rm -f "$GIT_DIR/BISECT_NO_CHECKOUT" &&
 	# Cleanup head-name if it got left by an old version of git-bisect
 	rm -f "$GIT_DIR/head-name" &&
 
-- 
1.7.6.352.g0c69b
