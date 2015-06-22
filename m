From: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
Subject: [PATCH v3 6/6] bisect: allows any terms set by user
Date: Mon, 22 Jun 2015 23:00:36 +0200
Message-ID: <1435006836-18182-6-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
References: <1435006836-18182-1-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
Cc: antoine.delaite@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	Matthieu.Moy@grenoble-inp.fr, chriscool@tuxfamily.org,
	thomasxnguy@gmail.com, valentinduperray@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 22 23:00:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z78pn-0005uZ-B1
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 23:00:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752453AbbFVVAq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 17:00:46 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:47364 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751724AbbFVVAk (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Jun 2015 17:00:40 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 288532890;
	Mon, 22 Jun 2015 23:00:38 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m4HO9bORbqEP; Mon, 22 Jun 2015 23:00:38 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 0DDAB2917;
	Mon, 22 Jun 2015 23:00:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id 02EF320D2;
	Mon, 22 Jun 2015 23:00:38 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4xLj-hjVYHu9; Mon, 22 Jun 2015 23:00:37 +0200 (CEST)
Received: from pcserveur.ensimag.fr (ensipcserveur.imag.fr [129.88.240.65])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 6378E20E7;
	Mon, 22 Jun 2015 23:00:37 +0200 (CEST)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1435006836-18182-1-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272410>

Introduction of the git bisect terms function.
The user can set its own terms.
It will work exactly like before. The terms must be set
before the start.

Signed-off-by: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
Signed-off-by: Louis Stuber <stuberl@ensimag.grenoble-inp.fr>
---
 Documentation/git-bisect.txt |   19 ++++++++++++
 git-bisect.sh                |   68 ++++++++++++++++++++++++++++++++++++++---
 t/t6030-bisect-porcelain.sh  |   43 ++++++++++++++++++++++++++
 3 files changed, 125 insertions(+), 5 deletions(-)

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
index a11ca06..7da22b1 100644
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
@@ -82,6 +84,14 @@ bisect_start() {
 	# revision_seen is true if a git bisect start
 	# has revision as arguments
 	revision_seen=0
+	# terms_defined is used to detect if the user
+	# defined his own terms with git bisect terms
+	terms_defined=0
+	if test -s "$GIT_DIR/TERMS_DEFINED"
+	then
+		terms_defined=1
+		get_terms
+	fi
 	if test "z$(git rev-parse --is-bare-repository)" != zfalse
 	then
 		mode=--no-checkout
@@ -180,10 +190,14 @@ bisect_start() {
 	} &&
 	git rev-parse --sq-quote "$@" >"$GIT_DIR/BISECT_NAMES" &&
 	eval "$eval true" &&
-	if test $revision_seen -eq 1 && test ! -s "$GIT_DIR/BISECT_TERMS"
+	if test $revision_seen -eq 1 && test ! -s "$GIT_DIR/BISECT_TERMS" || test $terms_defined -eq 1
 	then
 		echo "$NAME_BAD" >"$GIT_DIR/BISECT_TERMS" &&
-		echo "$NAME_GOOD" >>"$GIT_DIR/BISECT_TERMS"
+		echo "$NAME_GOOD" >>"$GIT_DIR/BISECT_TERMS" &&
+		if test $terms_defined -eq 1
+		then
+			echo "git bisect terms $NAME_BAD $NAME_GOOD" >>"$GIT_DIR/BISECT_LOG" || exit
+		fi
 	fi &&
 	echo "git bisect start$orig_args" >>"$GIT_DIR/BISECT_LOG" || exit
 	#
@@ -419,6 +433,7 @@ bisect_clean_state() {
 	rm -f "$GIT_DIR/BISECT_NAMES" &&
 	rm -f "$GIT_DIR/BISECT_RUN" &&
 	rm -f "$GIT_DIR/BISECT_TERMS" &&
+	rm -f "$GIT_DIR/TERMS_DEFINED" &&
 	# Cleanup head-name if it got left by an old version of git-bisect
 	rm -f "$GIT_DIR/head-name" &&
 	git update-ref -d --no-deref BISECT_HEAD &&
@@ -447,6 +462,8 @@ bisect_replay () {
 			eval "$cmd" ;;
 		"$NAME_GOOD"|"$NAME_BAD"|skip)
 			bisect_write "$command" "$rev" ;;
+		terms)
+			bisect_terms $rev ;;
 		*)
 			die "$(gettext "?? what are you talking about?")" ;;
 		esac
@@ -531,7 +548,8 @@ get_terms () {
 check_and_set_terms () {
 	cmd="$1"
 	case "$cmd" in
-	bad|good|new|old)
+	skip|start|terms) ;;
+	*)
 		if test -s "$GIT_DIR/BISECT_TERMS" && test "$cmd" != "$NAME_BAD" && test "$cmd" != "$NAME_GOOD"
 		then
 			die "$(eval_gettext "Invalid command: you're currently in a \$NAME_BAD/\$NAME_GOOD bisect.")"
@@ -564,6 +582,44 @@ bisect_voc () {
 	esac
 }
 
+bisect_terms () {
+	case "$#" in
+	0)
+		if test -s "$GIT_DIR/BISECT_TERMS"
+		then
+			{
+			read term1
+			read term2
+			}<"$GIT_DIR/BISECT_TERMS"
+			gettextln "Your current terms are $term1 and $term2."
+		else
+			die "$(gettext "No terms defined.")"
+		fi ;;
+	2)
+		check_term_format refs/bisect/"$1"
+		check_term_format refs/bisect/"$2"
+		if ! test -s "$GIT_DIR/BISECT_START"
+		then
+			echo $1 >"$GIT_DIR/BISECT_TERMS" &&
+			echo $2 >>"$GIT_DIR/BISECT_TERMS" &&
+			echo "1" >"$GIT_DIR/TERMS_DEFINED"
+			echo "git bisect terms $NAME_BAD $NAME_GOOD" >>"$GIT_DIR/BISECT_LOG" || exit
+		else
+			die "$(gettext "A bisection has already started, and you can't change terms in the middle of it. 
+Use 'git bisect terms' to see the current terms. 
+Otherwise, to start a new bisection with new terms, please use 'git bisect reset' and set the terms before the start")"
+		fi ;;
+	*)
+		usage ;;
+	esac
+}
+
+check_term_format () {
+	arg="$1"
+	git check-ref-format $arg ||
+	die "$(eval_gettext "'\$arg' is not a valid term")"
+}
+
 case "$#" in
 0)
 	usage ;;
@@ -576,7 +632,7 @@ case "$#" in
 		git bisect -h ;;
 	start)
 		bisect_start "$@" ;;
-	bad|good|new|old)
+	bad|good|new|old|"$NAME_BAD"|"$NAME_GOOD")
 		bisect_state "$cmd" "$@" ;;
 	skip)
 		bisect_skip "$@" ;;
@@ -593,6 +649,8 @@ case "$#" in
 		bisect_log ;;
 	run)
 		bisect_run "$@" ;;
+	terms)
+		bisect_terms "$@" ;;
 	*)
 		usage ;;
 	esac
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 2f2143b..d91116e 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -797,4 +797,47 @@ test_expect_success 'bisect cannot mix old/new and good/bad' '
 	test_must_fail git bisect old $HASH1
 '
 
+test_expect_success 'bisect start with one term1 and term2' '
+	git bisect reset &&
+	git bisect terms term1 term2 &&
+	git bisect start &&
+	git bisect term2 $HASH1 &&
+	git bisect term1 $HASH4 &&
+	git bisect term1 &&
+	git bisect term1 >bisect_result &&
+	grep "$HASH2 is the first term1 commit" bisect_result &&
+	git bisect log > log_to_replay.txt &&
+	git bisect reset
+'
+
+test_expect_success 'bisect replay with term1 and term2' '
+	git bisect replay log_to_replay.txt > bisect_result &&
+	grep "$HASH2 is the first term1 commit" bisect_result &&
+	git bisect reset
+'
+
+test_expect_success 'bisect start term1 term2' '
+	git bisect reset &&
+	git bisect terms term1 term2 &&
+	git bisect start $HASH4 $HASH1 &&
+	git bisect term1 &&
+	git bisect term1 >bisect_result &&
+	grep "$HASH2 is the first term1 commit" bisect_result &&
+	git bisect log > log_to_replay.txt &&
+	git bisect reset
+'
+
+test_expect_success 'bisect cannot mix terms' '
+	git bisect reset &&
+	git bisect terms a b &&
+	git bisect terms term1 term2 &&
+	git bisect start $HASH4 $HASH1 &&
+	test_must_fail git bisect a &&
+	test_must_fail git bisect b &&
+	test_must_fail git bisect bad &&
+	test_must_fail git bisect good &&
+	test_must_fail git bisect new &&
+	test_must_fail git bisect old
+'
+
 test_done
-- 
1.7.1
