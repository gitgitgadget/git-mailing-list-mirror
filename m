From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v8 4/7] bisect: introduce --no-checkout, --update-ref=<ref> support into porcelain.
Date: Sun, 31 Jul 2011 21:55:18 +1000
Message-ID: <1312113321-28760-5-git-send-email-jon.seymour@gmail.com>
References: <1312113321-28760-1-git-send-email-jon.seymour@gmail.com>
Cc: chriscool@tuxfamily.org, gitster@pobox.com, j6t@kdbg.org,
	jnareb@gmail.com, Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 31 13:56:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnUdN-0002mJ-Al
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jul 2011 13:56:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753356Ab1GaL4j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jul 2011 07:56:39 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:33709 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753243Ab1GaL4h (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jul 2011 07:56:37 -0400
Received: by mail-pz0-f42.google.com with SMTP id 37so9556049pzk.1
        for <git@vger.kernel.org>; Sun, 31 Jul 2011 04:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=iavFgEd6EGqv7C3te0qmq07iksPQkpoSeXwD5uhkHXw=;
        b=j0Nghij7xuedHBEX4IIEgIMlBERzZ4ntwkmDpXv38bBKCs6jHlLyEkFlW9P3a+16pU
         1QsRykFjn/15M4AJtDaiXtWKTfHnrMZTU679JXUJ5tDr0WXXey7j3moAHSfjpZdNyKd8
         Z6ca/5DhOrXWvC7KG/DPgChOOGekfAVaiv1QE=
Received: by 10.68.48.2 with SMTP id h2mr5960423pbn.148.1312113397136;
        Sun, 31 Jul 2011 04:56:37 -0700 (PDT)
Received: from localhost.localdomain ([120.16.239.154])
        by mx.google.com with ESMTPS id g4sm4306620pbj.41.2011.07.31.04.56.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 31 Jul 2011 04:56:36 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.352.g62761
In-Reply-To: <1312113321-28760-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178241>

git-bisect can now perform bisection of a history without performing
a checkout at each stage of the bisection process.

Instead, the reference specified by <ref> is updated. If <ref> is not
specified, HEAD is used instead.

One use-case for this function is allow git bisect to be used with
damaged repositories where git checkout would fail because the tree
referenced by the commit is damaged.

It can also be used in other cases where actual checkout of the tree
is not required to progress the bisection.

Improved-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 git-bisect.sh |   40 ++++++++++++++++++++++++++++++----------
 1 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 20f6dd5..24ac859 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -3,7 +3,7 @@
 USAGE='[help|start|bad|good|skip|next|reset|visualize|replay|log|run]'
 LONG_USAGE='git bisect help
         print this long help message.
-git bisect start [<bad> [<good>...]] [--] [<pathspec>...]
+git bisect start [--no-checkout|--update-ref=<ref>] [<bad> [<good>...]] [--] [<pathspec>...]
         reset bisect state and start bisection.
 git bisect bad [<rev>]
         mark <rev> a known-bad revision.
@@ -34,6 +34,8 @@ require_work_tree
 _x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
 _x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
 
+BISECT_UPDATE_REF=$(test -f "$GIT_DIR/BISECT_UPDATE_REF" && cat "$GIT_DIR/BISECT_UPDATE_REF")
+
 bisect_autostart() {
 	test -s "$GIT_DIR/BISECT_START" || {
 		(
@@ -69,13 +71,18 @@ bisect_start() {
 	orig_args=$(git rev-parse --sq-quote "$@")
 	bad_seen=0
 	eval=''
+	BISECT_UPDATE_REF=
 	while [ $# -gt 0 ]; do
 	    arg="$1"
 	    case "$arg" in
 	    --)
-		shift
-		break
-		;;
+		shift; break ;;
+	    --no-checkout)
+		BISECT_UPDATE_REF=HEAD; shift ;;
+	    --update-ref=*)
+		BISECT_UPDATE_REF=${arg#--update-ref=}; shift ;;
+	    --*)
+		die "$(eval_gettext "unrecognised option: '\$arg'")" ;;
 	    *)
 		rev=$(git rev-parse -q --verify "$arg^{commit}") || {
 		    test $has_double_dash -eq 1 &&
@@ -92,6 +99,10 @@ bisect_start() {
 	    esac
 	done
 
+	if test -n "$BISECT_UPDATE_REF"; then
+	    eval="$eval echo '$BISECT_UPDATE_REF' > '$GIT_DIR/BISECT_UPDATE_REF';"
+	fi
+
 	#
 	# Verify HEAD.
 	#
@@ -107,7 +118,11 @@ bisect_start() {
 	then
 		# Reset to the rev from where we started.
 		start_head=$(cat "$GIT_DIR/BISECT_START")
-		git checkout "$start_head" -- || exit
+		if test -z "$BISECT_UPDATE_REF"; then
+		    git checkout "$start_head" --
+		else
+		    git update-ref --no-deref "$BISECT_UPDATE_REF" "$start_head"
+		fi
 	else
 		# Get rev from where we start.
 		case "$head" in
@@ -291,7 +306,7 @@ bisect_next() {
 	bisect_next_check good
 
 	# Perform all bisection computation, display and checkout
-	git bisect--helper --next-all
+	git bisect--helper --next-all ${BISECT_UPDATE_REF:+--update-ref=}$BISECT_UPDATE_REF
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
+	if test -z "$BISECT_UPDATE_REF"; then
+		if git checkout "$branch" --; then
+			bisect_clean_state
+		else
+			die "$(eval_gettext "Could not check out original HEAD '\$branch'.
 Try 'git bisect reset <commit>'.")"
+		fi
+	else
+	    git symbolic-ref "$BISECT_UPDATE_REF" $(git rev-parse --symbolic-full-name "${branch}")
 	fi
 }
 
@@ -360,6 +379,7 @@ bisect_clean_state() {
 	rm -f "$GIT_DIR/BISECT_LOG" &&
 	rm -f "$GIT_DIR/BISECT_NAMES" &&
 	rm -f "$GIT_DIR/BISECT_RUN" &&
+	rm -f "$GIT_DIR/BISECT_UPDATE_REF" &&
 	# Cleanup head-name if it got left by an old version of git-bisect
 	rm -f "$GIT_DIR/head-name" &&
 
-- 
1.7.6.391.g168d0.dirty
