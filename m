From: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
Subject: [PATCH v2 7/7] bisect: allows any terms set by user
Date: Wed, 10 Jun 2015 21:01:58 +0200
Message-ID: <1433962918-6536-3-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
References: <1433962918-6536-1-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
Cc: remi.lespinet@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	remi.galan-alfonso@ensimag.grenoble-inp.fr,
	guillaume.pages@ensimag.grenoble-inp.fr,
	antoine.delaite@ensimag.grenoble-inp.fr,
	Matthieu.Moy@grenoble-inp.fr, chriscool@tuxfamily.org,
	thomasxnguy@gmail.com, valentinduperray@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 10 21:02:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2lGP-0003XA-8f
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 21:02:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932289AbbFJTCJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 15:02:09 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:48702 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753288AbbFJTCB (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Jun 2015 15:02:01 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id F24A92864;
	Wed, 10 Jun 2015 21:01:58 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 29L5bVmpNgCD; Wed, 10 Jun 2015 21:01:58 +0200 (CEST)
Received: from zm-smtpauth-1.grenet.fr (zm-smtpauth-1.grenet.fr [130.190.244.122])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id DF5332852;
	Wed, 10 Jun 2015 21:01:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-1.grenet.fr (Postfix) with ESMTP id DA28620D6;
	Wed, 10 Jun 2015 21:01:58 +0200 (CEST)
Received: from zm-smtpauth-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P9A-R5viqNba; Wed, 10 Jun 2015 21:01:58 +0200 (CEST)
Received: from pcserveur.ensimag.fr (ensipcserveur.imag.fr [129.88.240.65])
	by zm-smtpauth-1.grenet.fr (Postfix) with ESMTPSA id 8B5A920E5;
	Wed, 10 Jun 2015 21:01:58 +0200 (CEST)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1433962918-6536-1-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271345>

Introduction of the git bisect terms function.
The user can set its own terms.

List of known commands not available :
`git bisect replay`
`git bisect terms term1 term2
then
git bisect start bad_rev good_rev`

Signed-off-by: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
Signed-off-by: Louis Stuber <stuberl@ensimag.grenoble-inp.fr>
---
 Documentation/git-bisect.txt |   19 ++++++++++++++++++
 git-bisect.sh                |   44 ++++++++++++++++++++++++++++++++++-------
 2 files changed, 55 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index 3c3021a..ef0c03c 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -133,6 +133,25 @@ You must run `git bisect start` without commits as argument and run
 `git bisect new <rev>`/`git bisect old <rev>...` after to add the
 commits.
 
+Alternative terms: use your own terms
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+If the builtins terms bad/good and new/old do not satisfy you, you can
+set your own terms.
+
+------------------------------------------------
+git bisect terms term1 term2
+------------------------------------------------
+
+This command has to be used before a bisection has started.
+The term1 must be associated with the latest revisions and term2 with the
+ancestors of term1.
+
+Only the first bisection following the 'git bisect terms' will use the terms.
+If you mistyped one of the terms you can do again 'git bisect terms term1
+term2'.
+
+
 Bisect visualize
 ~~~~~~~~~~~~~~~~
 
diff --git a/git-bisect.sh b/git-bisect.sh
index c012f5d..22d65b1 100644
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-USAGE='[help|start|bad|good|new|old|skip|next|reset|visualize|replay|log|run]'
+USAGE='[help|start|bad|good|new|old|terms|skip|next|reset|visualize|replay|log|run]'
 LONG_USAGE='git bisect help
 	print this long help message.
 git bisect start [--no-checkout] [<bad> [<good>...]] [--] [<pathspec>...]
@@ -11,6 +11,8 @@ git bisect (bad|new) [<rev>]
 git bisect (good|old) [<rev>...]
 	mark <rev>... known-good revisions/
 		revisions before change in a given property.
+git bisect terms term1 term2
+	set up term1 and term2 as bisection terms.
 git bisect skip [(<rev>|<range>)...]
 	mark <rev>... untestable revisions.
 git bisect next
@@ -79,9 +81,16 @@ bisect_start() {
 	orig_args=$(git rev-parse --sq-quote "$@")
 	bad_seen=0
 	eval=''
-	# start_bad_good is used to detect if we did a 
-	# 'git bisect start bad_rev good_rev'
-	start_bad_good=0
+	# terms_defined is used to detect if we did a
+	# 'git bisect start bad_rev good_rev' or if the user
+	# defined his own terms with git bisect terms
+	terms_defined=0
+	if test -s "$GIT_DIR/TERMS_DEFINED"
+	then
+		terms_defined=1
+		get_terms
+		rm -rf "$GIT_DIR/TERMS_DEFINED"
+	fi
 	if test "z$(git rev-parse --is-bare-repository)" != zfalse
 	then
 		mode=--no-checkout
@@ -107,7 +116,7 @@ bisect_start() {
 				break
 			}
 
-			start_bad_good=1
+			terms_defined=1
 
 			case $bad_seen in
 			0) state=$NAME_BAD ; bad_seen=1 ;;
@@ -180,7 +189,7 @@ bisect_start() {
 	} &&
 	git rev-parse --sq-quote "$@" >"$GIT_DIR/BISECT_NAMES" &&
 	eval "$eval true" &&
-	if test $start_bad_good -eq 1 && test ! -s "$GIT_DIR/BISECT_TERMS"
+	if test $terms_defined -eq 1 && test ! -s "$GIT_DIR/BISECT_TERMS"
 	then
 		echo "$NAME_BAD" >"$GIT_DIR/BISECT_TERMS" &&
 		echo "$NAME_GOOD" >>"$GIT_DIR/BISECT_TERMS"
@@ -419,6 +428,7 @@ bisect_clean_state() {
 	rm -f "$GIT_DIR/BISECT_NAMES" &&
 	rm -f "$GIT_DIR/BISECT_RUN" &&
 	rm -f "$GIT_DIR/BISECT_TERMS" &&
+	rm -f "$GIT_DIR/TERMS_DEFINED" &&
 	# Cleanup head-name if it got left by an old version of git-bisect
 	rm -f "$GIT_DIR/head-name" &&
 	git update-ref -d --no-deref BISECT_HEAD &&
@@ -529,7 +539,8 @@ get_terms () {
 check_and_set_terms () {
 	cmd="$1"
 	case "$cmd" in
-	bad|good|new|old)
+	skip) ;;
+	*)
 		if test -s "$GIT_DIR/BISECT_TERMS" && test "$cmd" != "$NAME_BAD" && test "$cmd" != "$NAME_GOOD"
 		then
 			die "$(eval_gettext "Invalid command: you're currently in a \$NAME_BAD/\$NAME_GOOD bisect.")"
@@ -562,6 +573,21 @@ bisect_voc () {
 	esac
 }
 
+bisect_terms () {
+	test $# -eq 2 ||
+	die "You need to give me at least two arguments"
+
+	if ! test -s "$GIT_DIR/BISECT_START"
+	then
+		echo $1 >"$GIT_DIR/BISECT_TERMS" &&
+		echo $2 >>"$GIT_DIR/BISECT_TERMS" &&
+		echo "1" > "$GIT_DIR/TERMS_DEFINED"
+	else
+		die "A bisection has already started, please use "\
+		"'git bisect reset' to restart and change the terms"
+	fi
+}
+
 case "$#" in
 0)
 	usage ;;
@@ -574,7 +600,7 @@ case "$#" in
 		git bisect -h ;;
 	start)
 		bisect_start "$@" ;;
-	bad|good|new|old)
+	bad|good|new|old|$NAME_BAD|$NAME_GOOD)
 		bisect_state "$cmd" "$@" ;;
 	skip)
 		bisect_skip "$@" ;;
@@ -591,6 +617,8 @@ case "$#" in
 		bisect_log ;;
 	run)
 		bisect_run "$@" ;;
+	terms)
+		bisect_terms "$@" ;;
 	*)
 		usage ;;
 	esac
-- 
1.7.1
