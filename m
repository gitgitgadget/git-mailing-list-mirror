From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 3/5] bisect: introduce --no-checkout[=<ref>] support into porcelain.
Date: Sat, 30 Jul 2011 18:28:29 +1000
Message-ID: <1312014511-7157-4-git-send-email-jon.seymour@gmail.com>
References: <1312014511-7157-1-git-send-email-jon.seymour@gmail.com>
Cc: j6t@kdbg.org, gitster@pobox.com, jnareb@gmail.com,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 30 10:29:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qn4uu-0002JC-J1
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jul 2011 10:29:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751667Ab1G3I26 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jul 2011 04:28:58 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:39956 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751573Ab1G3I2w (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2011 04:28:52 -0400
Received: by pzk37 with SMTP id 37so7731301pzk.1
        for <git@vger.kernel.org>; Sat, 30 Jul 2011 01:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=EaJ0B6f6JOa6agIDFS6lsxwiiYDWFhDtfgixNNwzVyM=;
        b=aCycDgvTuDt75HFclr8/nVJq7XAim1XTtlkfTVdoElvH3cWPBsLq//qseIeCZtd+lq
         4MaNXdRN/JH8IgGJ+UFJCRZEVLYz9z0RpAYHJmIUp5JuQa3+l/bHBOE5TivoSghpKJZa
         cDpGnT2HnwlxfoNm1C5DtcMiZ0er+d1MHJr2s=
Received: by 10.68.30.134 with SMTP id s6mr3770422pbh.364.1312014532540;
        Sat, 30 Jul 2011 01:28:52 -0700 (PDT)
Received: from localhost.localdomain (124-169-144-208.dyn.iinet.net.au [124.169.144.208])
        by mx.google.com with ESMTPS id p7sm3012490pbn.65.2011.07.30.01.28.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 30 Jul 2011 01:28:51 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.387.g991c2
In-Reply-To: <1312014511-7157-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178184>

git-bisect can now perform bisection of a history without performing
a checkout at each stage of the bisection process.

Instead, the reference specified by <ref> is updated. If <ref> is not
specified, HEAD is used instead.

One use-case for this function is allow git bisect to be used with
damaged repositories where git checkout would fail because the tree
referenced by the commit is damaged.

It can also be used in other cases where actual checkout of the tree
is not required to progress the bisection.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 git-bisect.sh |   45 ++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 38 insertions(+), 7 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index b2186a8..6c4e853 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -3,7 +3,7 @@
 USAGE='[help|start|bad|good|skip|next|reset|visualize|replay|log|run]'
 LONG_USAGE='git bisect help
         print this long help message.
-git bisect start [<bad> [<good>...]] [--] [<pathspec>...]
+git bisect start [--no=checkout[=<ref>]] [<bad> [<good>...]] [--] [<pathspec>...]
         reset bisect state and start bisection.
 git bisect bad [<rev>]
         mark <rev> a known-bad revision.
@@ -34,6 +34,8 @@ require_work_tree
 _x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
 _x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
 
+BISECT_NOCHECKOUT=$(test -f "${GIT_DIR}/BISECT_NOCHECKOUT" && cat "${GIT_DIR}/BISECT_NOCHECKOUT")
+
 bisect_autostart() {
 	test -s "$GIT_DIR/BISECT_START" || {
 		(
@@ -59,6 +61,18 @@ bisect_autostart() {
 }
 
 bisect_start() {
+	BISECT_NOCHECKOUT=
+	for arg in "$@"; do
+		case "$arg" in
+		--no-checkout)
+			BISECT_NOCHECKOUT=--no-checkout=HEAD ;;
+		--no-checkout=*)
+			BISECT_NOCHECKOUT=$arg ;;
+		--)
+			break; ;;
+		esac
+	done
+
 	#
 	# Verify HEAD.
 	#
@@ -74,7 +88,11 @@ bisect_start() {
 	then
 		# Reset to the rev from where we started.
 		start_head=$(cat "$GIT_DIR/BISECT_START")
-		git checkout "$start_head" -- || exit
+		if test -z "${BISECT_NOCHECKOUT}"; then
+		    git checkout "$start_head" --
+		else
+		    git update-ref --no-deref "${BISECT_NOCHECKOUT#--no-checkout=}" "$start_head"
+		fi
 	else
 		# Get rev from where we start.
 		case "$head" in
@@ -114,6 +132,13 @@ bisect_start() {
 		shift
 		break
 		;;
+	    --no-checkout*)
+		echo "${BISECT_NOCHECKOUT}" > "$GIT_DIR/BISECT_NOCHECKOUT"
+		shift
+		;;
+	    --*)
+		die "unrecognised option: $arg"
+		;;
 	    *)
 		rev=$(git rev-parse -q --verify "$arg^{commit}") || {
 		    test $has_double_dash -eq 1 &&
@@ -291,7 +316,7 @@ bisect_next() {
 	bisect_next_check good
 
 	# Perform all bisection computation, display and checkout
-	git bisect--helper --next-all
+	git bisect--helper --next-all "${BISECT_NOCHECKOUT}"
 	res=$?
 
         # Check if we should exit because bisection is finished
@@ -340,11 +365,16 @@ bisect_reset() {
 	*)
 	    usage ;;
 	esac
-	if git checkout "$branch" -- ; then
-		bisect_clean_state
-	else
-		die "$(eval_gettext "Could not check out original HEAD '\$branch'.
+	if test -z "${BISECT_NOCHECKOUT}"; then
+		if git checkout "$branch" --; then
+			bisect_clean_state
+		else
+			die "$(eval_gettext "Could not check out original HEAD '\$branch'.
 Try 'git bisect reset <commit>'.")"
+		fi
+	else
+	    ref=${BISECT_NOCHECKOUT#--no-checkout=}
+	    git symbolic-ref "$ref" $(git rev-parse --symbolic-full-name "${branch}")
 	fi
 }
 
@@ -360,6 +390,7 @@ bisect_clean_state() {
 	rm -f "$GIT_DIR/BISECT_LOG" &&
 	rm -f "$GIT_DIR/BISECT_NAMES" &&
 	rm -f "$GIT_DIR/BISECT_RUN" &&
+	rm -f "$GIT_DIR/BISECT_NOCHECKOUT" &&
 	# Cleanup head-name if it got left by an old version of git-bisect
 	rm -f "$GIT_DIR/head-name" &&
 
-- 
1.7.6.387.g991c2
