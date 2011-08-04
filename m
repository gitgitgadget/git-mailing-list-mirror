From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v17 5/7] bisect: introduce --no-checkout support into porcelain.
Date: Thu,  4 Aug 2011 22:01:01 +1000
Message-ID: <1312459263-16911-6-git-send-email-jon.seymour@gmail.com>
References: <1312459263-16911-1-git-send-email-jon.seymour@gmail.com>
Cc: chriscool@tuxfamily.org, gitster@pobox.com, j6t@kdbg.org,
	jnareb@gmail.com, jrnieder@gmail.com,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 04 14:02:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qowd0-00043l-OO
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 14:02:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753780Ab1HDMCL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Aug 2011 08:02:11 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:38126 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753820Ab1HDMCH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2011 08:02:07 -0400
Received: by yia27 with SMTP id 27so992703yia.19
        for <git@vger.kernel.org>; Thu, 04 Aug 2011 05:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=nvOd/5OZnUzHBtw1G+926MGevLLt7MysdDXLNDj2ZrI=;
        b=qRIt6f5fixekF05bJrTmohjltkWDQry7d/q0eZ8zn26BDCHegT0xjLjDPy5QFo/apj
         +HBPHeQAf93vNfoRO9CwK8is7hKdr3eWrxVj83ZhV02hOv8F8z6nzKV6TkKsG+ure9Pn
         E5VA5gWCaqwjdPsbUniviNjvkeSr6ipnEoOFw=
Received: by 10.142.44.7 with SMTP id r7mr759156wfr.122.1312459326082;
        Thu, 04 Aug 2011 05:02:06 -0700 (PDT)
Received: from localhost.localdomain ([120.16.214.215])
        by mx.google.com with ESMTPS id i5sm249965wff.18.2011.08.04.05.01.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 04 Aug 2011 05:02:05 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.353.g50d6f
In-Reply-To: <1312459263-16911-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178743>

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
 git-bisect.sh |   48 +++++++++++++++++++++++++++++++++++++-----------
 1 files changed, 37 insertions(+), 11 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index a44ffe1..b9c18dd 100755
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
@@ -34,6 +34,16 @@ require_work_tree
 _x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
 _x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
 
+bisect_head()
+{
+	if test -f "$GIT_DIR/BISECT_HEAD"
+	then
+		echo BISECT_HEAD
+	else
+		echo HEAD
+	fi
+}
+
 bisect_autostart() {
 	test -s "$GIT_DIR/BISECT_START" || {
 		(
@@ -69,6 +79,7 @@ bisect_start() {
 	orig_args=$(git rev-parse --sq-quote "$@")
 	bad_seen=0
 	eval=''
+	mode=''
 	while [ $# -gt 0 ]; do
 	    arg="$1"
 	    case "$arg" in
@@ -76,6 +87,11 @@ bisect_start() {
 		shift
 		break
 		;;
+	    --no-checkout)
+		mode=--no-checkout
+		shift ;;
+	    --*)
+		die "$(eval_gettext "unrecognised option: '\$arg'")" ;;
 	    *)
 		rev=$(git rev-parse -q --verify "$arg^{commit}") || {
 		    test $has_double_dash -eq 1 &&
@@ -107,7 +123,10 @@ bisect_start() {
 	then
 		# Reset to the rev from where we started.
 		start_head=$(cat "$GIT_DIR/BISECT_START")
-		git checkout "$start_head" -- || exit
+		if test "z$mode" != "z--no-checkout"
+		then
+		    git checkout "$start_head" --
+		fi
 	else
 		# Get rev from where we start.
 		case "$head" in
@@ -143,7 +162,10 @@ bisect_start() {
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
@@ -206,8 +228,8 @@ bisect_state() {
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
@@ -291,7 +313,7 @@ bisect_next() {
 	bisect_next_check good
 
 	# Perform all bisection computation, display and checkout
-	git bisect--helper --next-all
+	git bisect--helper --next-all $(test -f "$GIT_DIR/BISECT_HEAD" && echo --no-checkout)
 	res=$?
 
         # Check if we should exit because bisection is finished
@@ -340,12 +362,15 @@ bisect_reset() {
 	*)
 	    usage ;;
 	esac
-	if git checkout "$branch" -- ; then
-		bisect_clean_state
-	else
-		die "$(eval_gettext "Could not check out original HEAD '\$branch'.
+	if ! test -f "$GIT_DIR/BISECT_HEAD"
+	then
+		if ! git checkout "$branch" --
+		then
+			die "$(eval_gettext "Could not check out original HEAD '\$branch'.
 Try 'git bisect reset <commit>'.")"
+		fi
 	fi
+	bisect_clean_state
 }
 
 bisect_clean_state() {
@@ -362,7 +387,8 @@ bisect_clean_state() {
 	rm -f "$GIT_DIR/BISECT_RUN" &&
 	# Cleanup head-name if it got left by an old version of git-bisect
 	rm -f "$GIT_DIR/head-name" &&
-
+	git update-ref -d --no-deref BISECT_HEAD &&
+	# clean up BISECT_START last
 	rm -f "$GIT_DIR/BISECT_START"
 }
 
-- 
1.7.6.353.g50d6f
