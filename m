From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v14 5/8] bisect: introduce --no-checkout support into porcelain.
Date: Wed,  3 Aug 2011 08:15:59 +1000
Message-ID: <1312323362-20096-6-git-send-email-jon.seymour@gmail.com>
References: <1312323362-20096-1-git-send-email-jon.seymour@gmail.com>
Cc: chriscool@tuxfamily.org, gitster@pobox.com, j6t@kdbg.org,
	jnareb@gmail.com, Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 03 00:16:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoNGk-000433-1x
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 00:16:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755604Ab1HBWQq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Aug 2011 18:16:46 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:47511 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755714Ab1HBWQj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2011 18:16:39 -0400
Received: by mail-pz0-f42.google.com with SMTP id 37so375496pzk.1
        for <git@vger.kernel.org>; Tue, 02 Aug 2011 15:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=nzcjhcisEiKxrXFnQRAcothSDIRE17owTZDlaLqxbZM=;
        b=kPAgEAxREeO4+v/cq/zC5cUtoLd5+knYFnY2Djh0L4K/nwi0ZEqhT5GbWv4TZ6khsE
         hHY+9YxDI5ZrLpOiR+Qboo/PYhzY0O+d00HGaWrljNdqZOOpoGcxrwAciTa9km0u64W8
         Gi/XmP1ZVe1UU8hzveE7ADMmF8unnEZ7kgDmc=
Received: by 10.68.32.228 with SMTP id m4mr1320772pbi.66.1312323398779;
        Tue, 02 Aug 2011 15:16:38 -0700 (PDT)
Received: from localhost.localdomain ([120.16.93.94])
        by mx.google.com with ESMTPS id d3sm269987pbg.44.2011.08.02.15.16.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 02 Aug 2011 15:16:37 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.353.gb3ae7e
In-Reply-To: <1312323362-20096-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178523>

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
 git-bisect.sh |   32 +++++++++++++++++++++++++-------
 1 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index a44ffe1..99a2637 100755
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
 
+BISECT_MODE=$(test -f "$GIT_DIR/BISECT_MODE" && cat "$GIT_DIR/BISECT_MODE")
+
 bisect_autostart() {
 	test -s "$GIT_DIR/BISECT_START" || {
 		(
@@ -69,6 +71,7 @@ bisect_start() {
 	orig_args=$(git rev-parse --sq-quote "$@")
 	bad_seen=0
 	eval=''
+	BISECT_MODE=
 	while [ $# -gt 0 ]; do
 	    arg="$1"
 	    case "$arg" in
@@ -76,6 +79,11 @@ bisect_start() {
 		shift
 		break
 		;;
+	    --no-checkout)
+		BISECT_MODE=--no-checkout;
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
+		if test "$BISECT_MODE" = "--no-checkout"; then
+		    git update-ref --no-deref HEAD "$start_head"
+		else
+		    git checkout "$start_head" --
+		fi
 	else
 		# Get rev from where we start.
 		case "$head" in
@@ -144,7 +156,8 @@ bisect_start() {
 	# Write new start state.
 	#
 	echo "$start_head" >"$GIT_DIR/BISECT_START" &&
-	git rev-parse --sq-quote "$@" >"$GIT_DIR/BISECT_NAMES" &&
+	git rev-parse --sq-quote "$@" >"$GIT_DIR/BISECT_NAMES"
+	echo "$BISECT_MODE" > "$GIT_DIR/BISECT_MODE" &&
 	eval "$eval true" &&
 	echo "git bisect start$orig_args" >>"$GIT_DIR/BISECT_LOG" || exit
 	#
@@ -291,7 +304,7 @@ bisect_next() {
 	bisect_next_check good
 
 	# Perform all bisection computation, display and checkout
-	git bisect--helper --next-all
+	git bisect--helper --next-all ${BISECT_MODE}
 	res=$?
 
         # Check if we should exit because bisection is finished
@@ -340,11 +353,15 @@ bisect_reset() {
 	*)
 	    usage ;;
 	esac
-	if git checkout "$branch" -- ; then
-		bisect_clean_state
+	if test "$BISECT_MODE" = "--no-checkout"; then
+		git symbolic-ref HEAD $(git rev-parse --symbolic-full-name "${branch}")
 	else
-		die "$(eval_gettext "Could not check out original HEAD '\$branch'.
+		if git checkout "$branch" --; then
+			bisect_clean_state
+		else
+			die "$(eval_gettext "Could not check out original HEAD '\$branch'.
 Try 'git bisect reset <commit>'.")"
+		fi
 	fi
 }
 
@@ -360,6 +377,7 @@ bisect_clean_state() {
 	rm -f "$GIT_DIR/BISECT_LOG" &&
 	rm -f "$GIT_DIR/BISECT_NAMES" &&
 	rm -f "$GIT_DIR/BISECT_RUN" &&
+	rm -f "$GIT_DIR/BISECT_MODE" &&
 	# Cleanup head-name if it got left by an old version of git-bisect
 	rm -f "$GIT_DIR/head-name" &&
 
-- 
1.7.6.353.gb3ae7e
