From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v9 5/5] bisect: allow any terms set by user
Date: Thu, 25 Jun 2015 20:50:57 +0200
Message-ID: <1435258257-29047-6-git-send-email-Matthieu.Moy@imag.fr>
References: <1435064084-5554-1-git-send-email-Matthieu.Moy@imag.fr>
 <1435258257-29047-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: git@vger.kernel.org, antoine.delaite@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	chriscool@tuxfamily.org, thomasxnguy@gmail.com,
	valentinduperray@gmail.com,
	Louis Stuber <stuberl@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jun 25 20:51:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8CFF-0000Bq-Qo
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jun 2015 20:51:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752001AbbFYSvX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 14:51:23 -0400
Received: from mx1.imag.fr ([129.88.30.5]:46283 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751914AbbFYSvO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2015 14:51:14 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t5PIp1gO023843
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 25 Jun 2015 20:51:01 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5PIp3SK024596;
	Thu, 25 Jun 2015 20:51:03 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1Z8CEp-00080P-NB; Thu, 25 Jun 2015 20:51:03 +0200
X-Mailer: git-send-email 2.4.4.414.g318df7a.dirty
In-Reply-To: <1435258257-29047-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 25 Jun 2015 20:51:04 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5PIp1gO023843
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1435863067.94956@HbeC0Ue8uD1OzN3tAwZOGg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272710>

From: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>

Introduction of the git bisect terms command. The user can set his own
terms. It will work exactly like before. The terms must be set before the
start.

Signed-off-by: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
Signed-off-by: Louis Stuber <stuberl@ensimag.grenoble-inp.fr>
Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/git-bisect.txt | 24 +++++++++++++
 git-bisect.sh                | 80 ++++++++++++++++++++++++++++++++++++++------
 t/t6030-bisect-porcelain.sh  | 43 ++++++++++++++++++++++++
 3 files changed, 137 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index 3c3021a..e783f87 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -133,6 +133,30 @@ You must run `git bisect start` without commits as argument and run
 `git bisect new <rev>`/`git bisect old <rev>...` after to add the
 commits.
 
+Alternative terms: use your own terms
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+If the builtins terms bad/good and new/old do not satisfy you, you can
+set your own terms.
+
+------------------------------------------------
+git bisect terms <term-new> <term-old>
+------------------------------------------------
+
+This command has to be used before a bisection has started. <term-old>
+must be associated with the latest revisions and <term-new> with the
+ancestors of <term-old>. For example, if something was buggy in the
+old part of the history, you know somewhere the bug was fixed, and you
+want to find the exact commit that fixed it, you may want to say `git
+bisect terms fixed broken`; this way, you would mark a commit that
+still has the bug with `broken`, and a newer one after the fix with
+`fixed`.
+
+Only the first bisection following the `git bisect terms` will use the
+terms. If you mistyped one of the terms you can do again `git bisect
+terms <term-old> <term-new>`.
+
+
 Bisect visualize
 ~~~~~~~~~~~~~~~~
 
diff --git a/git-bisect.sh b/git-bisect.sh
index 569898b..8fee712 100755
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
+git bisect terms <term-new> <term-old>
+	set up <term-new> and <term-old> as terms (default: bad, good)
 git bisect skip [(<rev>|<range>)...]
 	mark <rev>... untestable revisions.
 git bisect next
@@ -80,6 +82,16 @@ bisect_start() {
 	bad_seen=0
 	eval=''
 	must_write_terms=0
+	must_log_terms=0
+	if test -s "$GIT_DIR/BISECT_TERMS"
+	then
+		# We're going to restart from a clean state and the
+		# file will be deleted. Record the old state in
+		# variables and restore it below.
+		must_write_terms=1
+		must_log_terms=1
+		get_terms
+	fi
 	if test "z$(git rev-parse --is-bare-repository)" != zfalse
 	then
 		mode=--no-checkout
@@ -183,10 +195,14 @@ bisect_start() {
 	} &&
 	git rev-parse --sq-quote "$@" >"$GIT_DIR/BISECT_NAMES" &&
 	eval "$eval true" &&
-	if test $must_write_terms -eq 1 && test ! -s "$GIT_DIR/BISECT_TERMS"
+	if test $must_write_terms -eq 1
 	then
-		echo "$NAME_BAD" >"$GIT_DIR/BISECT_TERMS" &&
-		echo "$NAME_GOOD" >>"$GIT_DIR/BISECT_TERMS"
+		write_terms "$NAME_BAD" "$NAME_GOOD" &&
+		if test $must_log_terms -eq 1
+		then
+			echo "git bisect terms $NAME_BAD $NAME_GOOD" \
+			    >>"$GIT_DIR/BISECT_LOG"
+		fi
 	fi &&
 	echo "git bisect start$orig_args" >>"$GIT_DIR/BISECT_LOG" || exit
 	#
@@ -450,6 +466,8 @@ bisect_replay () {
 			eval "$cmd" ;;
 		"$NAME_GOOD"|"$NAME_BAD"|skip)
 			bisect_write "$command" "$rev" ;;
+		terms)
+			bisect_terms $rev ;;
 		*)
 			die "$(gettext "?? what are you talking about?")" ;;
 		esac
@@ -534,7 +552,8 @@ get_terms () {
 check_and_set_terms () {
 	cmd="$1"
 	case "$cmd" in
-	bad|good|new|old)
+	skip|start|terms) ;;
+	*)
 		if test -s "$GIT_DIR/BISECT_TERMS" && test "$cmd" != "$NAME_BAD" && test "$cmd" != "$NAME_GOOD"
 		then
 			die "$(eval_gettext "Invalid command: you're currently in a \$NAME_BAD/\$NAME_GOOD bisect.")"
@@ -543,16 +562,14 @@ check_and_set_terms () {
 		bad|good)
 			if ! test -s "$GIT_DIR/BISECT_TERMS"
 			then
-				echo "bad" >"$GIT_DIR/BISECT_TERMS" &&
-				echo "good" >>"$GIT_DIR/BISECT_TERMS"
+				write_terms bad good
 			fi
 			NAME_BAD="bad"
 			NAME_GOOD="good" ;;
 		new|old)
 			if ! test -s "$GIT_DIR/BISECT_TERMS"
 			then
-				echo "new" >"$GIT_DIR/BISECT_TERMS" &&
-				echo "old" >>"$GIT_DIR/BISECT_TERMS"
+				write_terms new old
 			fi
 			NAME_BAD="new"
 			NAME_GOOD="old" ;;
@@ -567,6 +584,47 @@ bisect_voc () {
 	esac
 }
 
+bisect_terms () {
+	case "$#" in
+	0)
+		if test -s "$GIT_DIR/BISECT_TERMS"
+		then
+			get_terms
+			gettextln "Your current terms are $NAME_GOOD for the old state
+and $NAME_BAD for the new state."
+		else
+			die "$(gettext "No terms defined.")"
+		fi ;;
+	2)
+		if ! test -s "$GIT_DIR/BISECT_START"
+		then
+			write_terms "$1" "$2"
+			echo "git bisect terms $NAME_BAD $NAME_GOOD" >>"$GIT_DIR/BISECT_LOG" || exit
+		else
+			die "$(gettext "A bisection has already started, and you can't change terms in the middle of it.
+Use 'git bisect terms' to see the current terms.
+Otherwise, to start a new bisection with new terms, please use
+'git bisect reset' and set the terms before the start")"
+		fi ;;
+	*)
+		usage ;;
+	esac
+}
+
+write_terms () {
+	NAME_BAD=$1
+	NAME_GOOD=$2
+	check_term_format "$NAME_BAD"
+	check_term_format "$NAME_GOOD"
+	printf '%s\n%s\n' "$NAME_BAD" "$NAME_GOOD" >"$GIT_DIR/BISECT_TERMS"
+}
+
+check_term_format () {
+	term=$1
+	git check-ref-format refs/bisect/"$term" ||
+	die "$(eval_gettext "'\$term' is not a valid term")"
+}
+
 case "$#" in
 0)
 	usage ;;
@@ -579,7 +637,7 @@ case "$#" in
 		git bisect -h ;;
 	start)
 		bisect_start "$@" ;;
-	bad|good|new|old)
+	bad|good|new|old|"$NAME_BAD"|"$NAME_GOOD")
 		bisect_state "$cmd" "$@" ;;
 	skip)
 		bisect_skip "$@" ;;
@@ -596,6 +654,8 @@ case "$#" in
 		bisect_log ;;
 	run)
 		bisect_run "$@" ;;
+	terms)
+		bisect_terms "$@" ;;
 	*)
 		usage ;;
 	esac
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 983c503..289dbb0 100755
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
+	git bisect log >log_to_replay.txt &&
+	git bisect reset
+'
+
+test_expect_success 'bisect replay with term1 and term2' '
+	git bisect replay log_to_replay.txt >bisect_result &&
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
+	git bisect log >log_to_replay.txt &&
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
2.4.4.414.g318df7a.dirty
